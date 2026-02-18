Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B5BE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfg-0004GD-1O; Wed, 18 Feb 2026 08:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfR-0003yL-0h
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfA-0005Qz-IQ
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZlCiaeoLEleGjH47/mJTlqebumMXTgkps2WXMv7tSY=;
 b=B4e19W4LDmUPnXSZ8c+X8u4tZRD0vzkKraQjCJ02ahzIrQhljRPGXj4lR+WuW5G+V9YMly
 Omm6zbAh6JLxI2LVZLRlU/wGnlhJ/VlU2hJ94tj4FjG3UAc//H7m8xOKwuT58irpHjZ9fL
 1B4BrgcLMnnNHtLnRVYPMUKp3H01r68=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-vKyX8TPaOHWtsN-7ejbBAA-1; Wed, 18 Feb 2026 08:27:13 -0500
X-MC-Unique: vKyX8TPaOHWtsN-7ejbBAA-1
X-Mimecast-MFC-AGG-ID: vKyX8TPaOHWtsN-7ejbBAA_1771421232
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4362456500eso5072697f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421232; x=1772026032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZlCiaeoLEleGjH47/mJTlqebumMXTgkps2WXMv7tSY=;
 b=i4VJKYB+b09pTDUbHYrKS4iaIfwWkYEfBjoS9kjRIOru6DBC/g4g7gdBZM8Ap62l9Q
 eCkX1pdiBoSQljWCPcqdy3UPjSbRN9BrREWdtJA/KTB0aSN84pZ3n2N07sSTeTLVaPCo
 y1UgJW6h3OkD3oGElgUMt0weB+iQc1CXUgBCUik657QsAF2kBoo9/Pm8s2EIWqjK95u7
 FjhSfSSKyu96meENqaM8sRDuQUK2XRuj1R4K7KWu9fjohaX41FtnKqa+bFrOpPuTqAZ5
 X5PAL6vPJ4FE4ZfnuHUBWxmp0r3/0viZydYGfteFxxSEeq5R7SIr9hSY64wRG76R7IzT
 A8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421232; x=1772026032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HZlCiaeoLEleGjH47/mJTlqebumMXTgkps2WXMv7tSY=;
 b=L1L+tgDinDa7fkecH/UjlQyFqWF/fAweIZgMECeMaLoOh5fNq/MxGnlhx+5GScPxTL
 0bZ4FbSTTEk6tZJy0dhjEYvnJ3+e3uom8+3h26PP2WPkMIabPpSUyR3BtbyWYicE2lag
 hVBxcByL1B6/9w8RTDu4Ee2IquxxD/DurrbnIlaad1fN0iCQgU/chREoeG0p4cf9t3Sh
 5OZppQMpdocZbv4bAq4N/Af0TDlMyQkK4NwavxG28/mfM1sS7gGy4tAiHOHe9Cr0Ce1r
 oJbKBg3UZm8MhGTcH+Cx7VGnSXSvt5deFG8RtksFa+kfsvTLbdt29aDJk/5O9HZGAVZp
 u87w==
X-Gm-Message-State: AOJu0Yzn+crILb+k0uL5tzNqb3Od79sOra7ftOCq2zBkH7gnrSk53ZL8
 YHNYQwuoT4FEGtkj4mPnZE4ga4XBeWIXS4Bab95Jz8Gk9lGYqwLcscmIqrUqS7csXSGkqGcgaOx
 TQ969366bhY8UJ665vXi6rOuN4OUTqtToFAlpkhka0wAMgPmagZRbvHTQ
X-Gm-Gg: AZuq6aI2OFxs+qJ88p9+TzerzMpLhjksfUtJdyxATlflAKYY11/Co4dwyh7K8moS1aW
 M49v7DVyZ72DB5zPesGLb+xxX/0aQn2V5JvkeRH+NM7XS5AEkDioVqiRLPW9aZKYuUAo9f6v6OR
 aUN007UEXflXsnbapOaYza3xo8NVGV0A/k2qCxZfZZ8RC4aElsF13jDpqTJ8H/qVyUVEB6oTlLG
 u7gQr2cvuf1jBrXk/q4aKSmIkUjjR+KPEAFWDlFFbBr91t9+CTN9hia5J3bQvxjQmWp5YFElPtw
 JMCNvG9/LpMdIzYcEy/WWyMx8LYXX+kxoJDKtgXybiJxQYKYRXDRs7aTr/uy7IsBxIy1UJZqZSI
 YvaKDl+KlwqlzKnOZTxmG9mA4LYwZ7vH6FmWAZE4ERLaxlTRJ1ws3LbbJIHvRIejY/m4xbjjiGk
 3MEaWF
X-Received: by 2002:a05:600c:c4a5:b0:480:19ed:7efa with SMTP id
 5b1f17b1804b1-48398b8522fmr25131105e9.36.1771421231753; 
 Wed, 18 Feb 2026 05:27:11 -0800 (PST)
X-Received: by 2002:a05:600c:c4a5:b0:480:19ed:7efa with SMTP id
 5b1f17b1804b1-48398b8522fmr25130845e9.36.1771421231286; 
 Wed, 18 Feb 2026 05:27:11 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483983c0766sm29540755e9.5.2026.02.18.05.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:27:09 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 11/24] fuse: Add halted flag
Date: Wed, 18 Feb 2026 14:26:20 +0100
Message-ID: <20260218132633.29748-12-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a flag that we will want when processing FUSE requests
ourselves: When the kernel sends us e.g. a truncated request (i.e. we
receive less data than the request's indicated length), we cannot rely
on subsequent data to be valid.  Then, we are going to set this flag,
halting all FUSE request processing.

We plan to only use this flag in cases that would effectively be kernel
bugs.

While not necessary yet, access the flag atomically so that it will be
safe to use once we introduce multi-threading.

(Right now, the flag is unused because libfuse still does our request
processing.)

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index fc75a5e74d..f6a5f4fa0a 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -53,6 +53,13 @@ typedef struct FuseExport {
     unsigned int in_flight; /* atomic */
     bool mounted, fd_handler_set_up;
 
+    /*
+     * Set when there was an unrecoverable error and no requests should be read
+     * from the device anymore (basically only in case of something we would
+     * consider a kernel bug).  Access atomically.
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
+    if (qatomic_read(&exp->halted)) {
+        return;
+    }
+
     aio_set_fd_handler(exp->common.ctx,
                        fuse_session_fd(exp->fuse_session),
                        read_from_fuse_export, NULL, NULL, NULL, exp);
@@ -322,6 +334,10 @@ static void read_from_fuse_export(void *opaque)
     FuseExport *exp = opaque;
     int ret;
 
+    if (unlikely(qatomic_read(&exp->halted))) {
+        return;
+    }
+
     fuse_inc_in_flight(exp);
 
     do {
@@ -380,6 +396,20 @@ static void fuse_export_delete(BlockExport *blk_exp)
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
+    qatomic_set(&exp->halted, true);
+    fuse_detach_handlers(exp);
+}
+
 /**
  * Check whether @path points to a regular file.  If not, put an
  * appropriate message into *errp.
-- 
2.53.0


