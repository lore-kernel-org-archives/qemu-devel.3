Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60012103FFAC
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw6Ni-0004Bc-1S; Fri, 27 Feb 2026 17:32:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1vw6Nh-0004BI-1V
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:32:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1vw6Ne-0001k1-Rx
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:32:20 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fN32W4JfczHnGcj;
 Sat, 28 Feb 2026 06:31:15 +0800 (CST)
Received: from dubpeml500008.china.huawei.com (unknown [7.214.146.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 44BBF40572;
 Sat, 28 Feb 2026 06:32:02 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.175.34) by
 dubpeml500008.china.huawei.com (7.214.146.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Feb 2026 22:32:01 +0000
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <mst@redhat.com>,
 <peter.maydell@linaro.org>, <jonathan.cameron@huawei.com>,
 <dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH 0/3] hw/cxl: Add fixes in maintenance, PPR and event records
Date: Fri, 27 Feb 2026 22:32:03 +0000
Message-ID: <20260227223207.972-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.175.34]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500008.china.huawei.com (7.214.146.94)
Received-SPF: pass client-ip=185.176.79.56; envelope-from=shiju.jose@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  <shiju.jose@huawei.com>
From: shiju.jose--- via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Shiju Jose <shiju.jose@huawei.com>

Add few fixes in CXL maintenance, PPR and event records generation.

1. In cxl_create_mem_sparing_event_records(), replace strncpy with memcpy to
solve coverity warning because full size of the array to use as length in
strncpy to copy the entire component id data, which is 16 bytes.

2. In cxl_maintenance_insert(),
 - replace strncpy with memcpy in to copy full data because component id is
   16 bytes data.
 - remove memset which is not required.

3. In cxl_perform_ppr(), remove and free the maintenance entry from QLIST if
match is found and PPR operation is performed.

4. Component id in CXL events is 16 bytes data, but event record generation copy
15 bytes only from the qmp "component-id" field using strncpy.
Replace strncpy with memcpy and change length of data to copy to the size of the
component_id array (16 bytes).

Shiju Jose (3):
  hw/cxl: Add fixes in maintenance and memory sparing
  hw/cxl: Add fixes in Post Package Repair (PPR)
  hw/cxl/events: Fixes for component id in event records generation

 hw/cxl/cxl-mailbox-utils.c |  6 ++++--
 hw/mem/cxl_type3.c         | 13 ++++---------
 2 files changed, 8 insertions(+), 11 deletions(-)

-- 
2.43.0


