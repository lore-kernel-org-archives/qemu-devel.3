Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384A6D116E2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 14:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOcvD-0005yb-HD; Thu, 27 Nov 2025 09:24:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vOcv9-0005pb-RM
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 09:24:32 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vOcv7-0006ng-By
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 09:24:31 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477770019e4so6910175e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 06:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1764253468; x=1764858268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lI/ueV3yXfasYkKZLg6niVJzElYESndcDgMuV6p/Zq0=;
 b=I31kDAdVGWlT/CTcmOdllqrdtKbcnJ6+oltvcJPDNg4htzZTILv7JAc9+AQY2D+ASz
 +xfOD1SPFVgWpf06k4nzQXKpvLhxPiW8ne4syGvv/s4fz6/s7WF7srAVHzoSrLTTaxKK
 CKL3d5rfAGTQ5qInTlbYJbLSxuD/VX/PuirdSnxwXouNk2IxMrKbNzvZyiIGL9/QN4kK
 doTxybPsSRckoePHQ9o5aDeFW4ifn+CfasIJU3bZLFDNgksR8U+IbmY0BaJ+jQDfKBxW
 BwD5yptPArpnqa1eKDHweQZ8eJmKmXEvDJ/+h2xyRD96bNXMDoCxfhLnpEGSJQQpxKr6
 KH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764253468; x=1764858268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lI/ueV3yXfasYkKZLg6niVJzElYESndcDgMuV6p/Zq0=;
 b=N2AhO+KkFgCkXKUDuEsp722Kb1T928fhP5Tvo+FIFlBtVfANONzK3hVpaNDTRHRslT
 o2ZErzVtOK/cjb2iSDnMODPP67qeEAUItp2xK6JJhvhMABf7+tIcs35ALZ46voAi3P3h
 Da1DHMNkrFMfhCMvvX/d5XqZsunc/+CK5UVlyF9ZoCl0zVH77ccFiq9mRC5o/mUEtyYL
 5EvjfVSAIiSUr5Z8dXfkuyfgMsz5HUx2SsKRlpynKLX22FMQCeilcd8ZQV9PP9yJdbMY
 Of6ZwxiS6hVTPqjrSWD+eqQ5XWpKaIWbMHc+FktyeQ/KN8sd/tPIIqxIKwYNHJ5GOTSv
 VXXg==
X-Gm-Message-State: AOJu0Yw9Sm64J1oluS1vNg8wluroorG6GHkSWKZV3SbU7fvDpjeSlArN
 wL4pgL+UVE567DLlD4/JV+t4CA0TDvbZyE1VJ2N/erwgvl6XpPC8MzGuv7HkNu7t1Q==
X-Gm-Gg: ASbGncsBxf0Ar8uwyw1S7TUDJhrJV3H6j5j+8flwB5JJ/RWbca3jBoYlxH0sEIqfHGy
 ZkAg4bo7xq1JZnKQR66GiCcNH0Uj6GAMONhNa7Vj5CRiUCwHcIKoMfVXzU7epmkti8vXROp4UHt
 Db7b0pSZOJCDpmrCVtUrOVSdjHQu8sDO9pM5HSa+1NfKUJF2bUzn53YiT4u47eB59gruLAY8opx
 lVNwcRt16URx+JE4ITzyBF+O0oTq1UU5GIT/DBbopT+IZm3R0AV1cPt85fTD+5sxoMOe3fL4bvM
 wcVMobxiiFBF+IzXkn2tuP0Ylx0EQoVcYBz7Yw5+PdjuECwSsEWk67Xc7b0PN6JFggNG4Fti9cv
 n7/p80eEZiaT9ywXbGfqpYpEKNyZO3GS8ZdTRLqH/6BMDu5lSM42xRFLQyioIVavHogQ8/XPx/0
 7Co9KF2DcRBe79
X-Google-Smtp-Source: AGHT+IGIIR9q32Z5G45M/pKVUmqgb3GK5vgoZTXI+WSqgE+2BxxmSH9dT7BsdMyiHbfMjI3tZa4cdA==
X-Received: by 2002:a05:600c:3b0a:b0:477:9574:d641 with SMTP id
 5b1f17b1804b1-47904b1b2ecmr98412945e9.22.1764253467836; 
 Thu, 27 Nov 2025 06:24:27 -0800 (PST)
Received: from chigot-Dell.. ([2a01:e0a:ca1:4970:e598:a2f0:7cc0:4392])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a2easm4148996f8f.23.2025.11.27.06.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 06:24:27 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v3 5/5] vvfat: add support for "fs-size" option
Date: Thu, 27 Nov 2025 15:24:17 +0100
Message-ID: <20251127142417.710094-6-chigot@adacore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127142417.710094-1-chigot@adacore.com>
References: <20251127142417.710094-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x335.google.com
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

The name of the option was made different from the classical "size" on
purpose. This would avoid hardly-detactable errors when "format=vvfat"
is forgotten; "size" being recognized by the default format "raw".

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 block/vvfat.c        | 163 +++++++++++++++++++++++++++++++++++++++----
 qapi/block-core.json |   8 ++-
 2 files changed, 155 insertions(+), 16 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 4e698f1ca7..f763ba6423 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1094,6 +1094,11 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_BOOL,
             .help = "Do not add a Master Boot Record on this disk",
         },
+        {
+            .name = "fs-size",
+            .type = QEMU_OPT_SIZE,
+            .help = "Virtual disk size"
+        },
         { /* end of list */ }
     },
 };
@@ -1145,10 +1150,150 @@ static void vvfat_parse_filename(const char *filename, QDict *options,
     qdict_put_bool(options, "rw", rw);
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
     bool floppy, partitioned;
     const char *dirname, *label;
     QemuOpts *opts;
@@ -1175,6 +1320,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->fat_type = qemu_opt_get_number(opts, "fat-type", 0);
     floppy = qemu_opt_get_bool(opts, "floppy", false);
+    size = qemu_opt_get_size_del(opts, "fs-size", 0);
 
     /* Hard disk are partitioned by default; floppy aren't.  */
     partitioned = qemu_opt_get_bool(opts, "partitioned", floppy ? false : true);
@@ -1216,18 +1362,7 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
-
-    if (floppy) {
-        /* Choose floppy size. 1440 KiB for FAT 12, 2880 KiB for FAT-16 */
-        s->sectors_per_track = s->fat_type == 12 ? 18 : 36;
-        s->cylinders = 80;
-        s->number_of_heads = 2;
-    } else {
-        /* 32MB or 504MB disk*/
-        s->cylinders = s->fat_type == 12 ? 64 : 1024;
-        s->number_of_heads = 16;
-        s->sectors_per_track = 63;
-    }
+    vvfat_get_size_parameters(size, s, floppy, errp);
 
     /* Reserver space for MBR */
     if (partitioned) {
@@ -1236,9 +1371,6 @@ static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->bs = bs;
 
-    /* LATER TODO: if FAT32, adjust */
-    s->sectors_per_cluster=0x10;
-
     s->current_cluster=0xffffffff;
 
     s->qcow = NULL;
@@ -3277,6 +3409,7 @@ static const char *const vvfat_strong_runtime_opts[] = {
     "label",
     "rw",
     "partitioned",
+    "fs-size",
 
     NULL
 };
diff --git a/qapi/block-core.json b/qapi/block-core.json
index ca438fba51..fa4df7b408 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3478,11 +3478,17 @@
 #     (default: true for hard disk, false for floppy)
 #     (since 10.2)
 #
+# @fs-size: size of the device in bytes.  Due to FAT underlying
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
+            '*fs-size': 'int' } }
 
 ##
 # @BlockdevOptionsGenericFormat:
-- 
2.43.0


