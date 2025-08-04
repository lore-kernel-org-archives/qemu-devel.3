Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293DCC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 18:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0JN-0006Vg-VV; Mon, 04 Aug 2025 14:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1uizA0-0004VY-0K; Mon, 04 Aug 2025 13:39:45 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1uiz9v-0006Bi-Qw; Mon, 04 Aug 2025 13:39:42 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 8B467A559E9;
 Mon,  4 Aug 2025 17:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AEDC4CEE7;
 Mon,  4 Aug 2025 17:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754329173;
 bh=VOFGKbHRfr1JcCUs/oI52wfC86Udfbt5H6v3sVTxeM4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BFzIh12giFFcAzAEF4yBUrQo0S/W0pYiHBojACJnQNuzs4tQ8JvEuUEc7MJXlLxWS
 y2Zkr1XgJRcb/9Kc3Jgbz+PVGGRBWFl7l32vYEKuNqfotwUlzyNIkg0cVLqMMPePRQ
 p5ixI/eOK1GZptvnxYOgD9AS48Jk0VsMP1wT1z1ClrfQ3IbgwILddplzPeT9lVbOyp
 H6sO9rGCSQNnT+0aOsgwAGmmqJ7JPZxtJwMqQXQ9drGV7+YolmS/0IGacWb367ECdu
 AZRPwx/Y+R1RWSMlsERcQ/hSrlFXQuQXiokNZoa+Sby4HlvnURYMUQJt5cKW2LsJnx
 ayRbHGoeo04ug==
Date: Mon, 4 Aug 2025 11:39:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Keith Busch <kbusch@meta.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH] hw/nvme: cap MDTS value for internal limitation
Message-ID: <aJDwUhgfS2b-DnLp@kbusch-mbp>
References: <20250801142457.3012213-1-kbusch@meta.com>
 <aJCA6oB1LZdHbAz9@AALNPWKJENSEN.aal.scsc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJCA6oB1LZdHbAz9@AALNPWKJENSEN.aal.scsc.local>
Received-SPF: pass client-ip=147.75.193.91; envelope-from=kbusch@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Aug 04, 2025 at 11:44:10AM +0200, Klaus Jensen wrote:
> On Aug  1 07:24, Keith Busch wrote:
> 
> This allows >2MB transfers with PRPs. However, it is not a clean fix
> since it does not deal with the issue that remains for the CMB (which
> uses the blk_aio api directly.
> 
> I'll queue up your patch for now. Thanks!

Thanks, sounds okay for the near term. 

Here's another idea to merge contiguous PRPs into a single segment. This
should get around that IOV_MAX limitation for Linux because that OS
wouldn't send such a large IO if it wasn't mostly physically contiguous:

---
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e764ec7683..83fb1385d1 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -827,6 +827,7 @@ static uint16_t nvme_map_addr_pmr(NvmeCtrl *n, QEMUIOVector *iov, hwaddr addr,
 static uint16_t nvme_map_addr(NvmeCtrl *n, NvmeSg *sg, hwaddr addr, size_t len)
 {
     bool cmb = false, pmr = false;
+    QEMUSGList *qsg;
 
     if (!len) {
         return NVME_SUCCESS;
@@ -864,6 +865,13 @@ static uint16_t nvme_map_addr(NvmeCtrl *n, NvmeSg *sg, hwaddr addr, size_t len)
         return NVME_INVALID_USE_OF_CMB | NVME_DNR;
     }
 
+    qsg = &sg->qsg;
+    if (qsg->sg[qsg->nsg - 1].base + qsg->sg[qsg->nsg - 1].len == addr) {
+        qsg->sg[qsg->nsg].len += len;
+        qsg->size += len;
+        return NVME_SUCCESS;
+    }
+
     if (sg->qsg.nsg + 1 > IOV_MAX) {
         goto max_mappings_exceeded;
     }
--

