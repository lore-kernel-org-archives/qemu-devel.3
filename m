Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E10B606A331
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=x6z.top header.i=@x6z.top header.a=rsa-sha256 header.s=lark2301040359 header.b=rPyBMaEM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnwX-0000Yp-AU; Fri, 30 Oct 2026 10:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lbyxiaolizi@x6z.top>)
 id 1xMnry-0006jK-V9
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:46:15 -0400
Received: from va-2-54.ptr.blmpb.com ([209.127.231.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lbyxiaolizi@x6z.top>)
 id 1xMnrx-0005V5-D4
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=lark2301040359; d=x6z.top; t=1793371567; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=HnsKhSBqrYHpcD8/xgqiWytQ8qOkxRVek15wxNzbFBc=;
 b=rPyBMaEMuv7beBIrU7igDUo3n5K0KS2P5U3xUFwRuxJ88utsiAjzdjkoF3e60Q0r9KAsFX
 xVnn2s2SFxqj9TkjxRuTItbPUfq5ca9x5TE65CqORJeImZ3r58m2w4wepKb9KjiuphLFRP
 5ns1Nbund5kGmP4w7Mz+/wz4H1UuUqNFENgU+Lc/I3lF1PboZvyNhVgwpZ91AlCpYra7Vc
 wdd/VpsavShdqhvj99ZmNFJrVBkALjxgKW7nF47Mbw/UN1hx5mvezVWITnm4B2UEeLi9VH
 EeJinMpmdDFBlMmWOVJl+JrwoB32YeugZbFPh19dkSrHGxtUyObMnyz/qJ8Ytw==
Cc: "lbyxiaolizi" <lbyxiaolizi@x6z.top>, 
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
X-Lms-Return-Path: <lba+26ae4adae+9c2a44+nongnu.org+lbyxiaolizi@x6z.top>
To: <qemu-devel@nongnu.org>
Date: Fri, 30 Oct 2026 22:45:42 +0800
Received: from localhost.localdomain ([120.236.174.193]) by smtp.larksuite.com
 with ESMTPS; Fri, 30 Oct 2026 14:46:05 +0000
X-Original-From: lbyxiaolizi <lbyxiaolizi@x6z.top>
X-Mailer: git-send-email 2.56.0
Content-Type: text/plain; charset=UTF-8
From: "lbyxiaolizi" <lbyxiaolizi@x6z.top>
Message-Id: <8ac1c98ae3c149facc2bff8c29e15c212b52cb4b.1793370600.git.lbyxiaolizi@x6z.top>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <cover.1793370600.git.lbyxiaolizi@x6z.top>
Content-Transfer-Encoding: 7bit
In-Reply-To: <cover.1793370600.git.lbyxiaolizi@x6z.top>
Subject: [PATCH 4/9] hw/hyperv/vmbus: check seen_gfns <= num_gfns in gpadl
 post_load
Received-SPF: pass client-ip=209.127.231.54; envelope-from=lbyxiaolizi@x6z.top;
 helo=va-2-54.ptr.blmpb.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 30 Oct 2026 10:50:48 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FROM_SUSPICIOUS_NTLD,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	T_PDS_OTHER_BAD_TLD,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vmstate_gpadl allocates gpadl->gfns with num_gfns elements and loads
seen_gfns as a raw uint32_t. If seen_gfns > num_gfns, the unsigned
subtraction num_gfns - seen_gfns in handle_gpadl_body() wraps around
and writes past gpadl->gfns[].

Reject seen_gfns > num_gfns in a post_load hook on vmstate_gpadl.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4776
Signed-off-by: lbyxiaolizi <lbyxiaolizi@x6z.top>
---
 hw/hyperv/vmbus.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index ab99f08..3973ca8 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -531,10 +531,21 @@ void vmbus_unmap_sgl(VMBusChanReq *req, DMADirection dir, struct iovec *iov,
     }
 }
 
+static int vmbus_gpadl_post_load(void *opaque, int version_id)
+{
+    VMBusGpadl *gpadl = opaque;
+
+    if (gpadl->seen_gfns > gpadl->num_gfns) {
+        return -EINVAL;
+    }
+    return 0;
+}
+
 static const VMStateDescription vmstate_gpadl = {
     .name = "vmbus/gpadl",
     .version_id = 0,
     .minimum_version_id = 0,
+    .post_load = vmbus_gpadl_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(id, VMBusGpadl),
         VMSTATE_UINT32(child_relid, VMBusGpadl),

