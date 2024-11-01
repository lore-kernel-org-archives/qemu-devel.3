Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2331DE6B278
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 13:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6rsC-0002xg-70; Fri, 01 Nov 2024 09:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t6rsA-0002x7-Kf
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:39:30 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t6rs7-0000sk-SR
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:39:30 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xg22l4pr4z6K6Tt;
 Fri,  1 Nov 2024 21:36:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 38AFB140A36;
 Fri,  1 Nov 2024 21:39:19 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 14:39:18 +0100
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>,
 Esifiel <esifiel@gmail.com>
CC: Fan Ni <fan.ni@samsung.com>, <linuxarm@huawei.com>
Subject: [PATCH qemu 00/10] hw/cxl: Mailbox input parser hardening against
 invalid input.
Date: Fri, 1 Nov 2024 13:39:07 +0000
Message-ID: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The CXL device mailbox has some variable sized input commands. The payload
length for each must be established using command especific structures.

If user space is either buggy or malicious, it may use size fields to
indicate fields beyond the end of the payload sent.  Some checks on this
were missing and Esifiel picked up on this.  I've tagged all these fixes
with Esifiel's Reported-by as either they were in the report or are similar
issues in other commands.

These can mostly be easily tested by using the raw mailbox commands option
in Linux and injecting broken commands from user space.

A typical command needs to first check that there is enough data to get to
the command specific sizing fields, then check the reported size is less
than or equal to the available payload.

Note that I think it very unlikely anyone is currently using CXL emulation
with a VM that they do not trust, but that may happen in future so good to
fix these paths now.

Jonathan Cameron (10):
  hw/cxl: Check size of input data to dynamic capacity mailbox commands
  hw/cxl: Check input includes at least the header in
    cmd_features_set_feature()
  hw/cxl: Check input length is large enough in
    cmd_events_clear_records()
  hw/cxl: Check enough data in cmd_firmware_update_transfer()
  hw/cxl: Check the length of data requested fits in get_log()
  hw/cxl: Avoid accesses beyond the end of cel_log.
  hw/cxl: Ensuring enough data to read parameters in
    cmd_tunnel_management_cmd()
  hw/cxl: Check that writes do not go beyond end of target attributes
  hw/cxl: Ensure there is enough data for the header in
    cmd_ccls_set_lsa()
  hw/cxl: Ensure there is enough data to read the input header in
    cmd_get_physical_port_state()

 hw/cxl/cxl-mailbox-utils.c | 73 ++++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 11 deletions(-)

-- 
2.43.0


