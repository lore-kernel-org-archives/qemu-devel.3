Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B13EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 13:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1RIE-0005ee-58; Mon, 29 Apr 2024 09:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s1RI8-0005dg-Jl
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 09:43:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s1RI6-0001fI-Ho
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 09:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714398212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VHWhO8Uw96rfOIbKluUZY5+pGgRzV7sZviOKB2lhoeA=;
 b=SVUy1Y6WIrEigcJcFpXQm2D6NtvUfV+nKlF1oXaIhNtaSOHLZzXwWQKD7wQLe1UfL2IFRA
 cGzbw1dpfA1tYDemLPKB1rLeKyYPH9LwUVbdhLneOqYI/eShmCrTdQcTSS5FpFIO41jQ3O
 wair6aDb9dn90yHFOxY+A5as2ihjUN8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-LjbXWdZ-NwuDpLOPaomNfA-1; Mon, 29 Apr 2024 09:43:27 -0400
X-MC-Unique: LjbXWdZ-NwuDpLOPaomNfA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B88A8FDD22;
 Mon, 29 Apr 2024 13:43:26 +0000 (UTC)
Received: from localhost (unknown [10.39.195.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B58F140C6CB1;
 Mon, 29 Apr 2024 13:43:25 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Jeuk Kim <jeuk20.kim@samsung.com>,
 qemu-block@nongnu.org, Zheyu Ma <zheyuma97@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 1/1] hw/ufs: Fix buffer overflow bug
Date: Mon, 29 Apr 2024 09:43:21 -0400
Message-ID: <20240429134321.321982-2-stefanha@redhat.com>
In-Reply-To: <20240429134321.321982-1-stefanha@redhat.com>
References: <20240429134321.321982-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jeuk Kim <jeuk20.kim@samsung.com>

It fixes the buffer overflow vulnerability in the ufs device.
The bug was detected by sanitizers.

You can reproduce it by:

cat << EOF |\
qemu-system-x86_64 \
-display none -machine accel=qtest -m 512M -M q35 -nodefaults -drive \
file=null-co://,if=none,id=disk0 -device ufs,id=ufs_bus -device \
ufs-lu,drive=disk0,bus=ufs_bus -qtest stdio
outl 0xcf8 0x80000810
outl 0xcfc 0xe0000000
outl 0xcf8 0x80000804
outw 0xcfc 0x06
write 0xe0000058 0x1 0xa7
write 0xa 0x1 0x50
EOF

Resolves: #2299
Fixes: 329f16624499 ("hw/ufs: Support for Query Transfer Requests")
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <f2c8aeb1afefcda92054c448b21fc59cdd99db30.1714360640.git.jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index eccdb852a0..bac78a32bb 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -126,6 +126,10 @@ static MemTxResult ufs_dma_read_req_upiu(UfsRequest *req)
     copy_size = sizeof(UtpUpiuHeader) + UFS_TRANSACTION_SPECIFIC_FIELD_SIZE +
                 data_segment_length;
 
+    if (copy_size > sizeof(req->req_upiu)) {
+        copy_size = sizeof(req->req_upiu);
+    }
+
     ret = ufs_addr_read(u, req_upiu_base_addr, &req->req_upiu, copy_size);
     if (ret) {
         trace_ufs_err_dma_read_req_upiu(req->slot, req_upiu_base_addr);
@@ -225,6 +229,10 @@ static MemTxResult ufs_dma_write_rsp_upiu(UfsRequest *req)
         copy_size = rsp_upiu_byte_len;
     }
 
+    if (copy_size > sizeof(req->rsp_upiu)) {
+        copy_size = sizeof(req->rsp_upiu);
+    }
+
     ret = ufs_addr_write(u, rsp_upiu_base_addr, &req->rsp_upiu, copy_size);
     if (ret) {
         trace_ufs_err_dma_write_rsp_upiu(req->slot, rsp_upiu_base_addr);
-- 
2.44.0


