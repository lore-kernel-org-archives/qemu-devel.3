Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC8FC48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 13:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSzRv-0005Kl-F8; Thu, 25 Jan 2024 08:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rSzRq-0005CK-65
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 08:07:14 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rSzRl-0001kp-ON
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 08:07:12 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-55a90b2b554so5553514a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 05:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706188024; x=1706792824;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKUnbGe/6f66+lwn1J0s8MBl41hnIgl8Nwp3JbmZTwY=;
 b=cgBm7ryL2Phh3nzpgr3rKe9pc3PN66fLVmWt85NTe9c5Na2Or+bu02aJyQJiIb75J6
 shCGg1fs2WVefkoLAcXMzb+yOebUmCHlW22DKywaQGc5qfgaWoRYRXeofJCnVtXS0kEi
 f9DZusMuw+OTX0UlBIJnSlPygQ3fEKMF9UmVxaO4YtkYudQ1ZoQKMO24v5TNtMczRZCM
 lsVAjLWGr2ql/TvuNSA9aNmnz1vT3GbPMyi8uEdcf6Opkrh4iLqqDe3gaCIP6LG4hSkf
 MMmvAesS+xxOhWxriNNW2gxuw4SZLlJnZVffZNbVOgxOYStkGs+mQueCxFh7+h6CrEIl
 eFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706188024; x=1706792824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mKUnbGe/6f66+lwn1J0s8MBl41hnIgl8Nwp3JbmZTwY=;
 b=TuaFsVHWJU2QzMW3mu5+xPrApqEpp9s7w9/RnBYYMVbwLj+8B0Ymdj75I32MAfzPu/
 UWt6etSpc/mWjTzNFFwuwCDV1eRG7zAFo//aygqXGKiCnlb8aaaB+rUQ/CSUX+ysCC+R
 dry5ySTCOwXsDa5cvL6dkRn4OOfztWGS/km3DBQGINzLabm4c9jdIntg5VONtl/tGhn7
 JjRm6Xhs5gyAEy1BNdGrvqc4W6hG/W+1c8GwC9mzDzSYCv6oBdAfa2JHjhmZs1Gp9ar8
 71PGL3bYMPLIyhVXrqRjVN2nIDlFywcrM0emJ1YgUhrOr4yHbYEnXqRGmW0pt+mrhaIv
 wynQ==
X-Gm-Message-State: AOJu0YzfBHRgbamI0yeqS+qSFOHxv3UxQBGkz43xby3Ur+OlkhUcsNWT
 78TVQ8FZPpYjBtnEpFjnCNXWreNGbM80LGrmC/6e2YD99/gq/ODXqU16Jt/yj3k=
X-Google-Smtp-Source: AGHT+IHo/xnm5mHS7nJzPvXzUCVpYVPG7yfBBDheuRrq2iykWWziPsXMnH+XvOoMdfdC19R1oSa3/g==
X-Received: by 2002:a05:6402:c99:b0:55c:7f97:4028 with SMTP id
 cm25-20020a0564020c9900b0055c7f974028mr787352edb.4.1706188024524; 
 Thu, 25 Jan 2024 05:07:04 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 er25-20020a056402449900b0055a829811ddsm6558709edb.48.2024.01.25.05.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 05:07:04 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com,
	akihiko.odaki@daynix.com
Subject: [PATCH v8 1/5] ebpf: Added eBPF map update through mmap.
Date: Thu, 25 Jan 2024 15:06:50 +0200
Message-ID: <20240125130656.425607-2-andrew@daynix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125130656.425607-1-andrew@daynix.com>
References: <20240125130656.425607-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::52d;
 envelope-from=andrew@daynix.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Changed eBPF map updates through mmaped array.
Mmaped arrays provide direct access to map data.
It should omit using bpf_map_update_elem() call,
which may require capabilities that are not present.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 ebpf/ebpf_rss.c | 120 ++++++++++++++++++++++++++++++++++++++----------
 ebpf/ebpf_rss.h |   8 +++-
 2 files changed, 101 insertions(+), 27 deletions(-)

diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index cee658c158..c6e10265a7 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -7,8 +7,7 @@
  *  Andrew Melnychenko <andrew@daynix.com>
  *  Yuri Benditovich <yuri.benditovich@daynix.com>
  *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
@@ -27,19 +26,83 @@ void ebpf_rss_init(struct EBPFRSSContext *ctx)
 {
     if (ctx != NULL) {
         ctx->obj = NULL;
+        ctx->program_fd = -1;
+        ctx->map_configuration = -1;
+        ctx->map_toeplitz_key = -1;
+        ctx->map_indirections_table = -1;
+
+        ctx->mmap_configuration = NULL;
+        ctx->mmap_toeplitz_key = NULL;
+        ctx->mmap_indirections_table = NULL;
     }
 }
 
 bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
 {
-    return ctx != NULL && ctx->obj != NULL;
+    return ctx != NULL && (ctx->obj != NULL || ctx->program_fd != -1);
+}
+
+static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
+{
+    if (!ebpf_rss_is_loaded(ctx)) {
+        return false;
+    }
+
+    ctx->mmap_configuration = mmap(NULL, qemu_real_host_page_size(),
+                                   PROT_READ | PROT_WRITE, MAP_SHARED,
+                                   ctx->map_configuration, 0);
+    if (ctx->mmap_configuration == MAP_FAILED) {
+        trace_ebpf_error("eBPF RSS", "can not mmap eBPF configuration array");
+        return false;
+    }
+    ctx->mmap_toeplitz_key = mmap(NULL, qemu_real_host_page_size(),
+                                   PROT_READ | PROT_WRITE, MAP_SHARED,
+                                   ctx->map_toeplitz_key, 0);
+    if (ctx->mmap_toeplitz_key == MAP_FAILED) {
+        trace_ebpf_error("eBPF RSS", "can not mmap eBPF toeplitz key");
+        goto toeplitz_fail;
+    }
+    ctx->mmap_indirections_table = mmap(NULL, qemu_real_host_page_size(),
+                                   PROT_READ | PROT_WRITE, MAP_SHARED,
+                                   ctx->map_indirections_table, 0);
+    if (ctx->mmap_indirections_table == MAP_FAILED) {
+        trace_ebpf_error("eBPF RSS", "can not mmap eBPF indirection table");
+        goto indirection_fail;
+    }
+
+    return true;
+
+indirection_fail:
+    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
+    ctx->mmap_toeplitz_key = NULL;
+toeplitz_fail:
+    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
+    ctx->mmap_configuration = NULL;
+
+    ctx->mmap_indirections_table = NULL;
+    return false;
+}
+
+static void ebpf_rss_munmap(struct EBPFRSSContext *ctx)
+{
+    if (!ebpf_rss_is_loaded(ctx)) {
+        return;
+    }
+
+    munmap(ctx->mmap_indirections_table, qemu_real_host_page_size());
+    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
+    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
+
+    ctx->mmap_configuration = NULL;
+    ctx->mmap_toeplitz_key = NULL;
+    ctx->mmap_indirections_table = NULL;
 }
 
 bool ebpf_rss_load(struct EBPFRSSContext *ctx)
 {
     struct rss_bpf *rss_bpf_ctx;
 
-    if (ctx == NULL) {
+    if (ebpf_rss_is_loaded(ctx)) {
         return false;
     }
 
@@ -66,10 +129,18 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
     ctx->map_toeplitz_key = bpf_map__fd(
             rss_bpf_ctx->maps.tap_rss_map_toeplitz_key);
 
+    if (!ebpf_rss_mmap(ctx)) {
+        goto error;
+    }
+
     return true;
 error:
     rss_bpf__destroy(rss_bpf_ctx);
     ctx->obj = NULL;
+    ctx->program_fd = -1;
+    ctx->map_configuration = -1;
+    ctx->map_toeplitz_key = -1;
+    ctx->map_indirections_table = -1;
 
     return false;
 }
@@ -77,15 +148,11 @@ error:
 static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
                                 struct EBPFRSSConfig *config)
 {
-    uint32_t map_key = 0;
-
     if (!ebpf_rss_is_loaded(ctx)) {
         return false;
     }
-    if (bpf_map_update_elem(ctx->map_configuration,
-                            &map_key, config, 0) < 0) {
-        return false;
-    }
+
+    memcpy(ctx->mmap_configuration, config, sizeof(*config));
     return true;
 }
 
@@ -93,27 +160,19 @@ static bool ebpf_rss_set_indirections_table(struct EBPFRSSContext *ctx,
                                             uint16_t *indirections_table,
                                             size_t len)
 {
-    uint32_t i = 0;
-
     if (!ebpf_rss_is_loaded(ctx) || indirections_table == NULL ||
        len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
         return false;
     }
 
-    for (; i < len; ++i) {
-        if (bpf_map_update_elem(ctx->map_indirections_table, &i,
-                                indirections_table + i, 0) < 0) {
-            return false;
-        }
-    }
+    memcpy(ctx->mmap_indirections_table, indirections_table,
+            sizeof(*indirections_table) * len);
     return true;
 }
 
 static bool ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,
                                      uint8_t *toeplitz_key)
 {
-    uint32_t map_key = 0;
-
     /* prepare toeplitz key */
     uint8_t toe[VIRTIO_NET_RSS_MAX_KEY_SIZE] = {};
 
@@ -123,10 +182,7 @@ static bool ebpf_rss_set_toepliz_key(struct EBPFRSSContext *ctx,
     memcpy(toe, toeplitz_key, VIRTIO_NET_RSS_MAX_KEY_SIZE);
     *(uint32_t *)toe = ntohl(*(uint32_t *)toe);
 
-    if (bpf_map_update_elem(ctx->map_toeplitz_key, &map_key, toe,
-                            0) < 0) {
-        return false;
-    }
+    memcpy(ctx->mmap_toeplitz_key, toe, VIRTIO_NET_RSS_MAX_KEY_SIZE);
     return true;
 }
 
@@ -160,6 +216,20 @@ void ebpf_rss_unload(struct EBPFRSSContext *ctx)
         return;
     }
 
-    rss_bpf__destroy(ctx->obj);
+    ebpf_rss_munmap(ctx);
+
+    if (ctx->obj) {
+        rss_bpf__destroy(ctx->obj);
+    } else {
+        close(ctx->program_fd);
+        close(ctx->map_configuration);
+        close(ctx->map_toeplitz_key);
+        close(ctx->map_indirections_table);
+    }
+
     ctx->obj = NULL;
+    ctx->program_fd = -1;
+    ctx->map_configuration = -1;
+    ctx->map_toeplitz_key = -1;
+    ctx->map_indirections_table = -1;
 }
diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h
index bf3f2572c7..404cf53613 100644
--- a/ebpf/ebpf_rss.h
+++ b/ebpf/ebpf_rss.h
@@ -7,8 +7,7 @@
  *  Andrew Melnychenko <andrew@daynix.com>
  *  Yuri Benditovich <yuri.benditovich@daynix.com>
  *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #ifndef QEMU_EBPF_RSS_H
@@ -20,6 +19,11 @@ struct EBPFRSSContext {
     int map_configuration;
     int map_toeplitz_key;
     int map_indirections_table;
+
+    /* mapped eBPF maps for direct access to omit bpf_map_update_elem() */
+    void *mmap_configuration;
+    void *mmap_toeplitz_key;
+    void *mmap_indirections_table;
 };
 
 struct EBPFRSSConfig {
-- 
2.43.0


