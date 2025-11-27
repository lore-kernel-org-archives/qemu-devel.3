Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC5CD116E2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 14:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOcv7-0005f4-5y; Thu, 27 Nov 2025 09:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vOcv6-0005b3-7b
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 09:24:28 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vOcv4-0006mE-5L
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 09:24:27 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42b31c610fcso838578f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 06:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1764253465; x=1764858265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ff3mnhdX3mWfpzK9gGdgsJWMgoiDPX053a6cG/860JI=;
 b=Kcr4HwUAcWpSHj3nRhHL7FXspwIpkUXbAzzXcVtPFmvIRORje04J33233I0O97wh3y
 5IdpwBfze8JE+cYNt1vQqgpLRgMHeKXiSNfzVWBdJXCFrnzNc19leFa+AHE6qmWH1qBV
 7lKZGE+bsNZ7gJ1vx4nMOvjNSNRtKm4mOLZyuTTVyi3T+fSfsR7201Oz9FJVylkg+Fi1
 pg5FWWMHIkJcLO1d8X7Dc6l4kCEjAJs3iDZhvuywpFEHsIHvu7DPVeeGIeOcZoWO3ig7
 UGU2kwDlkOUHBJlsf60KCKbdftSypcJ3IV2pGxJVXhtl019HdLbrgrAGYkFreIm8EoSB
 PuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764253465; x=1764858265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ff3mnhdX3mWfpzK9gGdgsJWMgoiDPX053a6cG/860JI=;
 b=YWJ8cIePA+gOE3yPf2Z5SIfK6V2nA8WoMhyGwBLnNy7EKuXnwXIyEPa8p16UdhFaeh
 13q/D4wRGK77f/wlHpmZwTE2suBuOJWe9kgPDdZou4Nw3Vn2E7eo/6bQyo2iNPKkjVI7
 C8vAOoLJR1v10G48w3GHYVTLKKQVC2BpzQghxAkTOK4RkbGsys5/v+H6JT89LhKFGcsc
 69pWoMqQLBS3A94IXJeN/2DatjKdVa952Yj+IC/fTS10SAl9VAZvSiPJcImKYtdAyT6g
 ndzTBpXSOTvygfZ1slbReZR/55XOW4+1b2Yi4rJUtvLJN87k4jtEEbXQ7q7OJWv3+j3r
 9SZg==
X-Gm-Message-State: AOJu0YwmP6yMs2KJhshK1cXDJCkbiOtuAaOiEc9aJshmCLArCbB9VTl9
 0PGvFf6+RE3kES0D8K+VQHLWFhXF1s3EqaQ3pOqUyQHq/Wg3GHqRM/+HCZTmfgarpQ==
X-Gm-Gg: ASbGncvFpK+Wxz6FpPJRpHkxyZy1AZDHGfOfvNmR8J6geJgx+zmBY+cMuQaYsjmdzy6
 UVaPdPJ2f+S9LSBpdDZBix/cnV1+euQvLUZ4uslCSKGgEUMdycdZgQgGkCCL3t8aOYt5L1x5lOr
 yIxUl7VkrvfxHfHSMLR+Z8i67frnrA3V4e4P9IIwH48yRMBUeo44uirXNRkwPHMsTDXM/PAzemn
 O+vJ6CWfu7XTo/UvcvTDmSbE0+eY9hPZWuAxTe3ANIl/MExNvFt0Rb1xFfoP4Y8mbO9jK1O+R34
 z/B5/KGcQ+cy6FCPgz9A6AZgQl3L0bKSIZITLHWZEF4qbjAu+KNhkm/4x6Z6r06EZ7u/WDpwKn1
 h+dnyix2fPHW+aOSbcLq+lYcySoYN267fH/aCg/lfIOVb4eLyZAlOeXBBihiFlX0XulZNvyb9Yk
 XcsE6yOzTHuTom
X-Google-Smtp-Source: AGHT+IFgjLtvWu0ynA12FfSHsr4iw1tkXY9FEL8Hgm8LbN5uqywVTyMf/T59AeMhX+LKMACrLb8eGQ==
X-Received: by 2002:a5d:4251:0:b0:42c:b8fd:21b3 with SMTP id
 ffacd0b85a97d-42e0f362440mr9069673f8f.57.1764253464626; 
 Thu, 27 Nov 2025 06:24:24 -0800 (PST)
Received: from chigot-Dell.. ([2a01:e0a:ca1:4970:e598:a2f0:7cc0:4392])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a2easm4148996f8f.23.2025.11.27.06.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 06:24:24 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v3 1/5] vvfat: introduce partitioned option
Date: Thu, 27 Nov 2025 15:24:13 +0100
Message-ID: <20251127142417.710094-2-chigot@adacore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127142417.710094-1-chigot@adacore.com>
References: <20251127142417.710094-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This option tells whether the volume should be partitioned or not. Its
default varies: true for hard disks and false for floppy. Its prime
effect is to prevent a master boot record (MBR) to be initialized.

This is useful as some operating system (QNX, Rtems) don't
recognized FAT mounted disks (especially SD cards) if a MBR is present.

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 block/vvfat.c        | 19 ++++++++++++++++---
 qapi/block-core.json | 10 +++++++---
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 814796d918..dd0b3689c1 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -306,7 +306,8 @@ typedef struct BDRVVVFATState {
     array_t fat,directory,mapping;
     char volume_label[11];
 
-    uint32_t offset_to_bootsector; /* 0 for floppy, 0x3f for disk */
+    /* 0x3f for partitioned disk, 0x0 otherwise */
+    uint32_t offset_to_bootsector;
 
     unsigned int cluster_size;
     unsigned int sectors_per_cluster;
@@ -1082,6 +1083,11 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_BOOL,
             .help = "Make the image writable",
         },
+        {
+            .name = "partitioned",
+            .type = QEMU_OPT_BOOL,
+            .help = "Do not add a Master Boot Record on this disk",
+        },
         { /* end of list */ }
     },
 };
@@ -1138,7 +1144,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
 {
     BDRVVVFATState *s = bs->opaque;
     int cyls, heads, secs;
-    bool floppy;
+    bool floppy, partitioned;
     const char *dirname, *label;
     QemuOpts *opts;
     int ret;
@@ -1165,6 +1171,9 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
     s->fat_type = qemu_opt_get_number(opts, "fat-type", 0);
     floppy = qemu_opt_get_bool(opts, "floppy", false);
 
+    /* Hard disk are partitioned by default; floppy aren't.  */
+    partitioned = qemu_opt_get_bool(opts, "partitioned", floppy ? false : true);
+
     memset(s->volume_label, ' ', sizeof(s->volume_label));
     label = qemu_opt_get(opts, "label");
     if (label) {
@@ -1196,7 +1205,6 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
         if (!s->fat_type) {
             s->fat_type = 16;
         }
-        s->offset_to_bootsector = 0x3f;
         cyls = s->fat_type == 12 ? 64 : 1024;
         heads = 16;
         secs = 63;
@@ -1215,6 +1223,10 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
+    /* Reserver space for MBR */
+    if (partitioned) {
+        s->offset_to_bootsector = 0x3f;
+    }
 
     s->bs = bs;
 
@@ -3246,6 +3258,7 @@ static const char *const vvfat_strong_runtime_opts[] = {
     "floppy",
     "label",
     "rw",
+    "partitioned",
 
     NULL
 };
diff --git a/qapi/block-core.json b/qapi/block-core.json
index b82af74256..ca438fba51 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3464,8 +3464,8 @@
 #
 # @fat-type: FAT type: 12, 16 or 32
 #
-# @floppy: whether to export a floppy image (true) or partitioned hard
-#     disk (false; default)
+# @floppy: whether to export a floppy image (true) or hard disk
+#     (false; default)
 #
 # @label: set the volume label, limited to 11 bytes.  FAT16 and FAT32
 #     traditionally have some restrictions on labels, which are
@@ -3474,11 +3474,15 @@
 #
 # @rw: whether to allow write operations (default: false)
 #
+# @partitioned: whether the volume will be partitioned;
+#     (default: true for hard disk, false for floppy)
+#     (since 10.2)
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsVVFAT',
   'data': { 'dir': 'str', '*fat-type': 'int', '*floppy': 'bool',
-            '*label': 'str', '*rw': 'bool' } }
+            '*label': 'str', '*rw': 'bool', '*partitioned': 'bool' } }
 
 ##
 # @BlockdevOptionsGenericFormat:
-- 
2.43.0


