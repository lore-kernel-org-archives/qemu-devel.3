Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC7ED2A52F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 16:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t16TM-0005aU-Gb; Wed, 16 Oct 2024 12:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t16TD-0005VT-1p
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 12:01:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t16TA-0004R7-1X
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 12:01:54 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTFzM3pcmz6FGy5;
 Wed, 16 Oct 2024 23:59:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id B856C140558;
 Thu, 17 Oct 2024 00:01:40 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Oct
 2024 18:01:39 +0200
Date: Wed, 16 Oct 2024 17:01:38 +0100
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <nifan.cxl@gmail.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>, <a.manzanares@samsung.com>,
 <nmtadam.samsung@gmail.com>, <abhi.n@samsung.com>,
 <alok.rathore@samsung.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [QEMU PATCH] cxl/cxl-mailbox-utils: Fix size check for
 cmd_firmware_update_get_info
Message-ID: <20241016170138.000001cf@Huawei.com>
In-Reply-To: <uuxiowlqgqs7mq2dfxixw4ryx4zfbygyaji7axfcln3nstdfed@nufwcfs2nj2a>
References: <20241008164624.78608-1-nifan.cxl@gmail.com>
 <uuxiowlqgqs7mq2dfxixw4ryx4zfbygyaji7axfcln3nstdfed@nufwcfs2nj2a>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 8 Oct 2024 20:01:07 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Tue, 08 Oct 2024, nifan.cxl@gmail.com wrote:\n
> >From: Fan Ni <fan.ni@samsung.com>
> >
> >In the function cmd_firmware_update_get_info for handling Get FW info
> >command (0x0200h), the vmem, pmem and DC capacity size check were
> >incorrect. The size should be aligned to 256MiB, not smaller than
> >256MiB.  
> 
> Can get rid of a level of parenthesis (other cmds as well), otherwise:
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
I missed this one when gathering up fixes the other day.
I'll queue it up now with the excess brackets dropped.

Jonathan

> 
> >
> >Signed-off-by: Fan Ni <fan.ni@samsung.com>
> >---
> > hw/cxl/cxl-mailbox-utils.c | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> >
> >diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> >index 9258e48f95..c82ad50ac8 100644
> >--- a/hw/cxl/cxl-mailbox-utils.c
> >+++ b/hw/cxl/cxl-mailbox-utils.c
> >@@ -649,9 +649,9 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
> >     } QEMU_PACKED *fw_info;
> >     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
> >
> >-    if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
> >-        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||
> >-        (ct3d->dc.total_capacity < CXL_CAPACITY_MULTIPLIER)) {
> >+    if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> >+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> >+        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
> >         return CXL_MBOX_INTERNAL_ERROR;
> >     }
> >
> >--
> >2.43.0
> >  


