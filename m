Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEBDCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 14:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHNqU-0003hW-8d; Fri, 07 Nov 2025 09:53:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vHNqK-0003Ra-KW
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 09:53:36 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vHNqH-0001tw-74
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 09:53:35 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-429c8632fcbso574664f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 06:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1762527211; x=1763132011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=izy7/qPzPQoipaFGeT4gnLUB0venGvr75VtHiWV0UpE=;
 b=JDOClDWblSY32a8MSvybJqHK3t2KwT1q4OFBEBWbR7mls7yuQz91/V6iayiYp4rWY/
 IFIOUqNafMspdIj1vWW3yTM/r1QMsjgOeGS56JoOJuxtyfJOFYiUZPLiJ5vjXzDY/SAh
 Jo6vw8Z3iY9tY+PcEZnuFTtZi5yKCe40zqTGmbL6MazlknmAlBRQRftcdFIE4qergGrQ
 8/J1Q42ySsXce2n5tnf3EvBbJY3YWalz0tSVwX+JKfOqj3zs+t5165ZHuCika7szn28T
 d5QrIcdnj+IWgavVIY5Vfd+gIQTxsDjLYF2Q2Bb9KVFpiwbTKhDs56yUT+S7kn62ZulA
 9C+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762527211; x=1763132011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=izy7/qPzPQoipaFGeT4gnLUB0venGvr75VtHiWV0UpE=;
 b=uHRABxrxZOMopSjaiY39gfS8UHpXol+lhwGZBjptCgDigaE+qCs42NEVoFrfyTJiwi
 CowsgMoJfW4Y2hkulldNqQmFBykZ/LLA9tQjJu253Mlc3tu0LllM7Md1j1CTYS/VeWBl
 Jme4A6BEpwqwFdDtN2wY5pu5NzLT/tMp+N4/qEnaJqWzTNJW/AGJfSGhM5AFcuTBi7RN
 fSoKGxH3ikojKnAInfzxSfHDprZcohRXTXxVD44yUkyiz4qfYQNfgEJVI3w1Wvl+UiZP
 OMBdhB9q43IpVsJeUv/C0srvF63lXPdjTj2vEG/c+hwMkxGgrFRfrV4amauRX+ThmLTk
 SoKA==
X-Gm-Message-State: AOJu0YzqPa9hOLmE91TIg5DTGuQTKfRBHzWVAXcVZLjZqxXaQ8Sjdwty
 nqqZXqup8TRYCE2mHyfabgrd7ty+Xc5Grrj0ATx9f9JHi6Cy1Mc+vfQh0AmCmfDDNA==
X-Gm-Gg: ASbGncvlGxZo8Jpu1wbuscU//Dr1RXWwUx8p2Jv+drquxOykY7KgA7sjCkwpEdENs0H
 406L4UDXJsw2p0xry8AywsbXyOLsRHqPmAdgyQmaTZ+dsh2ZkrcCzMtcm2Bw7EH9SXQL7za0jrz
 LD6/hQaXY5x8vj4kCmC0awXCDlAYv8RfrO1LtnHqVGXeuqqG50vXpe7mR9nJoCrROtnTMjnpVGF
 Tx6UUtgG0Krggj1w0k6eGjWM6yS5KbuDDCYeJ2s4oSYOVWEXLmyge0IMhJQT6e0Y+Plk3Kdwagb
 QmDUAmaSUyGH+OLdte62uuyKcsqs/MGb4+HMew/QXqyUvQLya9pk5h+WytJ7+wcUxxy4SaTixml
 WuxRKxL+ScrxZS2XMKml7VwYRdcM8KfWOLfGTRsw9fRhhZfujdNtiQv2u4jmLrwgcKwr5JxL5Gk
 t0gGX7IdE=
X-Google-Smtp-Source: AGHT+IFmIv057xjnjIyUjYmI6jz+jSUOzHJNO7gZIIdGv9cWlh+CWydPo7XQNDYBm87fBaOk79rOnw==
X-Received: by 2002:a05:6000:258a:b0:429:cda2:a025 with SMTP id
 ffacd0b85a97d-42ae58b14fbmr3400600f8f.13.1762527211131; 
 Fri, 07 Nov 2025 06:53:31 -0800 (PST)
Received: from chigot-Dell.home ([2a01:cb15:80db:7c00:e453:acd:db85:b66e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42abe63e131sm5922435f8f.20.2025.11.07.06.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 06:53:30 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v2 1/5] vvfat: introduce partitioned option
Date: Fri,  7 Nov 2025 15:53:23 +0100
Message-ID: <20251107145327.539481-2-chigot@adacore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107145327.539481-1-chigot@adacore.com>
References: <20251107145327.539481-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This option tells whether a hard disk should be partitioned or not. It
defaults to true and have the prime effect of preventing a master boot
record (MBR) to be initialized.

This is useful as some operating system (QNX, Rtems) don't
recognized FAT mounted disks (especially SD cards) if a MBR is present.

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 block/vvfat.c        | 21 +++++++++++++++++++--
 qapi/block-core.json | 10 +++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 814796d918..de6031db98 100644
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
@@ -1082,6 +1083,12 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_BOOL,
             .help = "Make the image writable",
         },
+        {
+            .name = "partitioned",
+            .type = QEMU_OPT_BOOL,
+            .def_value_str = "true",
+            .help = "Do not add a Master Boot Record on this disk",
+        },
         { /* end of list */ }
     },
 };
@@ -1092,6 +1099,7 @@ static void vvfat_parse_filename(const char *filename, QDict *options,
     int fat_type = 0;
     bool floppy = false;
     bool rw = false;
+    bool partitioned = true;
     int i;
 
     if (!strstart(filename, "fat:", NULL)) {
@@ -1116,6 +1124,10 @@ static void vvfat_parse_filename(const char *filename, QDict *options,
         rw = true;
     }
 
+    if (strstr(filename, ":unpartitioned:")) {
+        partitioned = false;
+    }
+
     /* Get the directory name without options */
     i = strrchr(filename, ':') - filename;
     assert(i >= 3);
@@ -1131,6 +1143,7 @@ static void vvfat_parse_filename(const char *filename, QDict *options,
     qdict_put_int(options, "fat-type", fat_type);
     qdict_put_bool(options, "floppy", floppy);
     qdict_put_bool(options, "rw", rw);
+    qdict_put_bool(options, "partitioned", partitioned);
 }
 
 static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
@@ -1196,7 +1209,10 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
         if (!s->fat_type) {
             s->fat_type = 16;
         }
-        s->offset_to_bootsector = 0x3f;
+        /* Reserver space for MBR */
+        if (qemu_opt_get_bool(opts, "partitioned", true)) {
+            s->offset_to_bootsector = 0x3f;
+        }
         cyls = s->fat_type == 12 ? 64 : 1024;
         heads = 16;
         secs = 63;
@@ -3246,6 +3262,7 @@ static const char *const vvfat_strong_runtime_opts[] = {
     "floppy",
     "label",
     "rw",
+    "partitioned",
 
     NULL
 };
diff --git a/qapi/block-core.json b/qapi/block-core.json
index b82af74256..8a479ba090 100644
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
+# @partitioned: whether a hard disk will be partitioned
+#     (default: true)
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


