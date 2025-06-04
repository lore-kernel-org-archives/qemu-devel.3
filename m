Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2203C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoBg-0008MP-2I; Wed, 04 Jun 2025 09:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoAy-0007Ct-F3
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoAu-0004m8-SX
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749043739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nk418H24kCz2+AUWTyV3Eb4pfrMBZv0WmNVH2UyfbVo=;
 b=Vj9w0cjI9HHQmjND+yvbHNnbmjagtViFqeoWxaflQH3ZjFVnH+AwBJkMVF9jaL0DtyNJTe
 beZI+V/u91PrMlCDUNqxgD3+VZcu7Hp4VbIpNosdmb7k3z2DrVL3whV9JWbYMOdC9Dwxiv
 moLSCr8/G7amzQdEmTNAKGh3sbBojM0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-_uwPc5wDMA6eLrY3DTNtjg-1; Wed, 04 Jun 2025 09:28:58 -0400
X-MC-Unique: _uwPc5wDMA6eLrY3DTNtjg-1
X-Mimecast-MFC-AGG-ID: _uwPc5wDMA6eLrY3DTNtjg_1749043737
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4fea70656so1800144f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 06:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749043737; x=1749648537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nk418H24kCz2+AUWTyV3Eb4pfrMBZv0WmNVH2UyfbVo=;
 b=goaal1aJ43f1Y8VAFmStsAbrqTjzzD7AV4q+ooso2aPAl33I8gfJTM+sbFJ1okW5j4
 1ylhPr9jyzBayXa8Gm6DZziEtSe8sLnqE68/o08RbpKlErGWn7IVeH4SszdEohCkol/8
 RIZ4V3kg4DrkCX42IGr13B+BThLBuGRAR9SQQQZl20ZIYwwCp3F/GfUBufkwIegqU9D6
 HTkUsAQsuzfW7Zqj8N2YwFY/1CDjMM+X4IK9pLIKJ6Wh4Fpx0Y0BaWx1PQQhByTXssl+
 vRfdAwJV8TB2Mqh4qe+pKUCNaPe0bTxpwVfHz+iwjlF+pLP/es3XRwZ6IVTlcZzb+f3v
 4yZw==
X-Gm-Message-State: AOJu0YybZnmhqMecTQt9hAY6NZFstPEGZIZ1759D4CiM4D5bH42C6I2l
 e8Rv02b9BKvqlQiRa05b6ICBrHDdzLG1sTgn1CL/gLZhu2sPEYwbM9NmNfme8ILQkpK5NRepVix
 i4PVPhlz0C7MWocabVn4k8K7Qp09RFx2r3h1JiToM+s4uUVowH9G8xDOc
X-Gm-Gg: ASbGncv7w8UXgU0xxcvXD2z8fOHboeu64lcZz+s5ltViF5fLv132m7EmZyYoHkM+S+d
 DL8mY/f5elMXQL/QvZvGsd8WY/hrrB6t9dMFIe5MPwNRHWHw++360nQmnMMwMd4rgfPBCy6MzMw
 r9gDNPNmIChUzpqGUKtMKTNbrJ/YaVR7bL0v1N1Mhbp7wLhm1PPMFzuYvQPXqG/FnbUuN5rEF9P
 8ap/hbxNvtSDufwmrD4oMhsHh45QqGW0h/w5jxesjKyAq41GMInVXOgM1bAhyvuU8mhtZaKXMvf
 5aWlQmgXdNzh15GkEXPtwZKIhQWCV3I0CtVpAIq3PODiTtBlANN15b1S2/cXPXgQp+CQxw==
X-Received: by 2002:a05:6000:2dc6:b0:3a4:d939:62fc with SMTP id
 ffacd0b85a97d-3a51d920b3cmr2124804f8f.22.1749043736640; 
 Wed, 04 Jun 2025 06:28:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5M5oa3DzMm7KTnqYsIxt+hrRGr0Gva3ljw7o+b1eu8NMFA8U6nZ+HPE0yzqMF91pDhjN1hg==
X-Received: by 2002:a05:6000:2dc6:b0:3a4:d939:62fc with SMTP id
 ffacd0b85a97d-3a51d920b3cmr2124784f8f.22.1749043736235; 
 Wed, 04 Jun 2025 06:28:56 -0700 (PDT)
Received: from localhost
 (p200300cfd700f306503d3c798c1bf214.dip0.t-ipconnect.de.
 [2003:cf:d700:f306:503d:3c79:8c1b:f214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00972c1sm22078407f8f.68.2025.06.04.06.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 06:28:54 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v2 10/21] fuse: Add halted flag
Date: Wed,  4 Jun 2025 15:28:02 +0200
Message-ID: <20250604132813.359438-11-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604132813.359438-1-hreitz@redhat.com>
References: <20250604132813.359438-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This is a flag that we will want when processing FUSE requests
ourselves: When the kernel sends us e.g. a truncated request (i.e. we
receive less data than the request's indicated length), we cannot rely
on subsequent data to be valid.  Then, we are going to set this flag,
halting all FUSE request processing.

We plan to only use this flag in cases that would effectively be kernel
bugs.

(Right now, the flag is unused because libfuse still does our request
processing.)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index bcbeaf92f4..044fbbf1fe 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -53,6 +53,13 @@ typedef struct FuseExport {
     unsigned int in_flight; /* atomic */
     bool mounted, fd_handler_set_up;
 
+    /*
+     * Set when there was an unrecoverable error and no requests should be read
+     * from the device anymore (basically only in case of something we would
+     * consider a kernel bug)
+     */
+    bool halted;
+
     char *mountpoint;
     bool writable;
     bool growable;
@@ -69,6 +76,7 @@ static const struct fuse_lowlevel_ops fuse_ops;
 
 static void fuse_export_shutdown(BlockExport *exp);
 static void fuse_export_delete(BlockExport *exp);
+static void fuse_export_halt(FuseExport *exp) G_GNUC_UNUSED;
 
 static void init_exports_table(void);
 
@@ -99,6 +107,10 @@ static void fuse_dec_in_flight(FuseExport *exp)
 
 static void fuse_attach_handlers(FuseExport *exp)
 {
+    if (exp->halted) {
+        return;
+    }
+
     aio_set_fd_handler(exp->common.ctx,
                        fuse_session_fd(exp->fuse_session),
                        read_from_fuse_export, NULL, NULL, NULL, exp);
@@ -316,6 +328,10 @@ static void read_from_fuse_export(void *opaque)
     FuseExport *exp = opaque;
     int ret;
 
+    if (unlikely(exp->halted)) {
+        return;
+    }
+
     fuse_inc_in_flight(exp);
 
     do {
@@ -374,6 +390,20 @@ static void fuse_export_delete(BlockExport *blk_exp)
     g_free(exp->mountpoint);
 }
 
+/**
+ * Halt the export: Detach FD handlers, and set exp->halted to true, preventing
+ * fuse_attach_handlers() from re-attaching them, therefore stopping all further
+ * request processing.
+ *
+ * Call this function when an unrecoverable error happens that makes processing
+ * all future requests unreliable.
+ */
+static void fuse_export_halt(FuseExport *exp)
+{
+    exp->halted = true;
+    fuse_detach_handlers(exp);
+}
+
 /**
  * Check whether @path points to a regular file.  If not, put an
  * appropriate message into *errp.
-- 
2.49.0


