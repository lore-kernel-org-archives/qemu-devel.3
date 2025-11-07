Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72ABCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 14:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHNqU-0003hp-Jr; Fri, 07 Nov 2025 09:53:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vHNqM-0003Tr-Mq
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 09:53:39 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vHNqK-0001v1-BO
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 09:53:38 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ed20bdfdffso795900f8f.2
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 06:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1762527214; x=1763132014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BThCjqaenmyeD9EsuFRpmtd4rv5WpUA+nY9VQioN73Y=;
 b=G+szwIjuE5Ep4o8wwdujWBNPCnRi/m7iS7zMCi+BYD+HkuAIPmwZmpcYZ0nky+kQJ1
 +GnlQYKQ1m8KttJbwX/+/01V4ewuFDnQvq8bf/eMECJUpHB6GJid1qAvTLZ9chvSNM3J
 lTSW7VoOj6aLzGUbQE34PMlbP2NcWs1fjF6AYPZSZoOAmlQPpb6Md4YzCT0iJtQoiMe+
 /6r9h3t3326FUyRssd+sUKE6IJCICm1obfxVs/rha3WTQlw7w0S5aD/dLazDTLr3EFAq
 e22WOlTyufWNkl00DbEtSBMXUbStDaiaQ35lDOd715HsNDnLzurNrEfwiYxIk77b+1Vs
 F42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762527214; x=1763132014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BThCjqaenmyeD9EsuFRpmtd4rv5WpUA+nY9VQioN73Y=;
 b=UqFDFUcRVfRh2W9+4rJv2dDnGjFLBBn6I0TaKfXCslt7eWkg30dF8M3m7m3rGjRkXH
 +2dO+otViyhLxx97Prm/LXgl3d9EVD6ZBBXgDtzgJxgpHvxV7pR07esPEc54NR3EH+kz
 xGkWv3KRbwEznCu4NRAh36v4qOCNB2l1VGQgYomiHWRpp15McjFX56A76+XJT7VDvvCT
 hgxYw3Caol8lD0MpNQ+CBPzhmW41Y3VJWLjILj2lCtOx1mFIBB2oUPvWcv1UPsgOAbp2
 BNE52rlWc1q05R+InLFr3g49mBFa2I6kBkr9ABfdAE5EirUhcHEVQz+4L8C855sQhat1
 VpfQ==
X-Gm-Message-State: AOJu0YwF+wG6UsKbaTc9ZgSa+JIR9PbJeO+HxLVoboFZnHVAyPyCFgvg
 H9ZZN6rPsJc5vsTihbbbXcWDc9/4JMma/CxOH0XPt5sGc92UPi4kZFBf+y3koAzJaQ==
X-Gm-Gg: ASbGncvIAMBoMeBnMz98tqMydzYYjfklfMc/Wmwqs+tufu2Yo4FSux4X8fChiN0nFqF
 XyxPFPGuJWW99+0DDvO+RlOA/NsoVXU91URVBSiW/OaxyUjOaKYDGwjP5EfNSsDzaqir26vAXsu
 vFZawFC8SVQLNMu9q8puN0HP+HP/kNLY/vtQTwaWOiRQ4LMxPOip5gylcK1UUpfnbRq31pNqGd2
 tqjSIB3EabhZog5u6E6trkWrEP7OUnp9Q6woApr9zhBT3AdLAdC4LxPbjYXAw+JGPpVihYEq186
 UyYIhe0YRDTUfNP8nMP+5/JM2tPQgMauJQEyqYZaEPzPk0sZ82NW+IJ/JTg5YjNF7mDHMwTEv+J
 tM8HIMh9MSVfvkWhmeAMx/9hUfkjJ/gxQWKae2gMABzV8g8jzXRZu3x3+QtQ89J7VzxybXwERLQ
 OGtM8WkR0=
X-Google-Smtp-Source: AGHT+IH53mykz/MiKBT8Ux/WHXoRE4h9QmmUOIyNK49LI8eTL0TCywmhx663ZwWjdoiXOIB9Ez/9Fw==
X-Received: by 2002:a05:6000:2209:b0:429:f01d:dd92 with SMTP id
 ffacd0b85a97d-42ae5af4989mr2784365f8f.59.1762527213878; 
 Fri, 07 Nov 2025 06:53:33 -0800 (PST)
Received: from chigot-Dell.home ([2a01:cb15:80db:7c00:e453:acd:db85:b66e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42abe63e131sm5922435f8f.20.2025.11.07.06.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 06:53:33 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v2 5/5] vvfat: add support for "fat-size" options
Date: Fri,  7 Nov 2025 15:53:27 +0100
Message-ID: <20251107145327.539481-6-chigot@adacore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107145327.539481-1-chigot@adacore.com>
References: <20251107145327.539481-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x435.google.com
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

This allows more flexibility to vvfat backend. The values of "Number of
Heads" and "Sectors per track" are based on SD specifications Part 2.

Due to the FAT architecture, not all sizes are reachable. Therefore, it
could be round up to the closest available size.

FAT32 has not been adjusted and thus still default to 504 Mib.

For floppy, only 1440 Kib and 2880 Kib are supported.

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 block/vvfat.c        | 169 ++++++++++++++++++++++++++++++++++++++-----
 qapi/block-core.json |   8 +-
 2 files changed, 158 insertions(+), 19 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index b0e591e35e..96f5062939 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1095,6 +1095,11 @@ static QemuOptsList runtime_opts = {
             .def_value_str = "true",
             .help = "Do not add a Master Boot Record on this disk",
         },
+        {
+            .name = "fat-size",
+            .type = QEMU_OPT_SIZE,
+            .help = "Virtual disk size"
+        },
         { /* end of list */ }
     },
 };
@@ -1152,10 +1157,150 @@ static void vvfat_parse_filename(const char *filename, QDict *options,
     qdict_put_bool(options, "partitioned", partitioned);
 }
 
+static void vvfat_get_size_parameters(uint64_t size, BDRVVVFATState *s,
+                                      bool floppy, Error **errp)
+{
+    if (floppy) {
+        if (s->fat_type == 16) {
+            /* The default for floppy FAT 16 is 2880 KiB */
+            if (!size) {
+                size = 2880 * 1024;
+            }
+
+            if (size != 2880 * 1024) {
+                error_setg(errp,
+                           "floppy FAT16 unsupported size; only support "
+                           "2880 KiB");
+            }
+
+        } else {
+            /* The default for floppy FAT 12 is 1440 KiB */
+            if (!size) {
+                size = 1440 * 1024;
+            }
+
+            if (size != 2880 * 1024 && size != 1440 * 1024) {
+                error_setg(errp,
+                           "floppy FAT12 unsupported size; only support "
+                           "1440 KiB or 2880 KiB");
+            }
+
+        }
+
+        if (s->fat_type == 12) {
+            if (size == 2880 * 1024) {
+                s->sectors_per_track = 36;
+            } else {
+                s->sectors_per_track = 18;
+            }
+        } else {
+            s->sectors_per_track = 36;
+        }
+
+        s->sectors_per_cluster = 0x10;
+        s->cylinders = 80;
+        s->number_of_heads = 2;
+    } else {
+
+        switch (s->fat_type) {
+        case 32:
+            /* TODO FAT32 adjust  */
+            if (size) {
+                warn_report("size parameters not supported with FAT32;"
+                            "default to 504 MiB.");
+            }
+            s->cylinders = 1024;
+            s->number_of_heads = 16;
+            s->sectors_per_cluster = 0x10;
+            s->sectors_per_track = 63;
+            return;
+
+        case 12:
+
+            /* Default is 32 MB */
+            if (!size) {
+                size = 32 * 1024 * 1024;
+            } else if (size > 32 * 1024 * 1024) {
+                error_setg(errp, "FAT12 unsupported size; higher than 32 MiB");
+            }
+
+            s->sectors_per_cluster = 0x10;
+            s->cylinders = 64;
+
+            /*
+             * Based on CHS Recommandation table:
+             *  Card Capacity | Number of Headers | Sectors per track
+             *      2 MiB     |         4         |       16
+             *      4 MiB     |         8         |       16
+             *      8 MiB     |        16         |       16
+             *      16 MiB    |         2         |       32
+             *      32 MiB    |         4         |       32
+             *
+             * For 2 MiB, the recommendation is heads = 2 and sectors = 16, but
+             * this requires a different number of cylinders. Thus, it was
+             * adjusted to keep this number constant.
+             */
+            if (size <= 8 * 1024 * 1024) {
+                s->sectors_per_track = 16;
+            } else {
+                s->sectors_per_track = 32;
+            }
+
+            break;
+
+        case 16:
+            /* Default is 504 MiB */
+            if (!size) {
+                size = 504 * 1024 * 1024;
+            } else if (size / 1024 > 4 * 1024 * 1024) {
+                error_setg(errp, "FAT16 unsupported size; higher than 4 GiB");
+            }
+
+            s->sectors_per_cluster = 0x10;
+            s->cylinders = 1024;
+
+            /*
+             * Based on CHS Recommandation table:
+             *  Card Capacity | Number of Headers | Sectors per track
+             *      64 MiB    |         4         |       32
+             *     128 MiB    |         8         |       32
+             *     256 MiB    |        16         |       32
+             *     504 MiB    |        16         |       63
+             *    1008 MiB    |        32         |       63
+             *    2016 MiB    |        64         |       63
+             */
+            if (size <= 256 * 1024 * 1024) {
+                s->sectors_per_track = 32;
+            } else {
+                s->sectors_per_track = 63;
+            }
+
+            break;
+        }
+
+        /*
+         * The formula between the size (in bytes) and the parameters are:
+         *  size = VVFAT_SECTOR_SIZE * sectors_per_track * number_of_headers *
+         *         cylinders
+         *
+         */
+        s->number_of_heads = size / s->sectors_per_track /
+            VVFAT_SECTOR_SIZE / s->cylinders;
+
+        /* Round up to the closest size if the given one cannot be reached. */
+        if (size %
+            (s->sectors_per_track * VVFAT_SECTOR_SIZE * s->cylinders) != 0) {
+            s->number_of_heads++;
+        }
+
+    }
+}
+
 static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
                       Error **errp)
 {
     BDRVVVFATState *s = bs->opaque;
+    uint64_t size;
     bool floppy;
     const char *dirname, *label;
     QemuOpts *opts;
@@ -1182,6 +1327,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->fat_type = qemu_opt_get_number(opts, "fat-type", 0);
     floppy = qemu_opt_get_bool(opts, "floppy", false);
+    size = qemu_opt_get_size_del(opts, "fat-size", 0);
 
     memset(s->volume_label, ' ', sizeof(s->volume_label));
     label = qemu_opt_get(opts, "label");
@@ -1219,29 +1365,15 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
+    vvfat_get_size_parameters(size, s, floppy, errp);
 
-    if (floppy) {
-        /* Choose floppy size. 1440 KiB for FAT 12, 2880 KiB for FAT-16 */
-        s->sectors_per_track = s->fat_type == 12 ? 18 : 36;
-        s->cylinders = 80;
-        s->number_of_heads = 2;
-    } else {
-        /* Reserver space for MBR */
-        if (qemu_opt_get_bool(opts, "partitioned", true)) {
-            s->offset_to_bootsector = 0x3f;
-        }
-        /* 32MB or 504MB disk*/
-        s->cylinders = s->fat_type == 12 ? 64 : 1024;
-        s->number_of_heads = 16;
-        s->sectors_per_track = 63;
+    /* Reserver space for MBR */
+    if (!floppy && qemu_opt_get_bool(opts, "partitioned", true)) {
+        s->offset_to_bootsector = 0x3f;
     }
 
-
     s->bs = bs;
 
-    /* LATER TODO: if FAT32, adjust */
-    s->sectors_per_cluster=0x10;
-
     s->current_cluster=0xffffffff;
 
     s->qcow = NULL;
@@ -3280,6 +3412,7 @@ static const char *const vvfat_strong_runtime_opts[] = {
     "label",
     "rw",
     "partitioned",
+    "fat-size",
 
     NULL
 };
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 8a479ba090..0bcb360320 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3478,11 +3478,17 @@
 #     (default: true)
 #     (since 10.2)
 #
+# @fat-size: size of the device in bytes.  Due to FAT underlying
+#     architecture, this size can be rounded up to the closest valid
+#     size.
+#     (since 10.2)
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsVVFAT',
   'data': { 'dir': 'str', '*fat-type': 'int', '*floppy': 'bool',
-            '*label': 'str', '*rw': 'bool', '*partitioned': 'bool' } }
+            '*label': 'str', '*rw': 'bool', '*partitioned': 'bool',
+            'fat-size': 'int' } }
 
 ##
 # @BlockdevOptionsGenericFormat:
-- 
2.43.0


