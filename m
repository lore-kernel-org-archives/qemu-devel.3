Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441E6C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 13:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSzRx-0005Lu-V3; Thu, 25 Jan 2024 08:07:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rSzRq-0005CE-2T
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 08:07:14 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rSzRl-0001l5-Ln
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 08:07:12 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-55a50649ff6so7422175a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 05:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706188025; x=1706792825;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qs4io9fLdT3cAG7lBct+y78n0jaTZdDvmWX1yYHA+NE=;
 b=F20ofYxkLDUNjzuCTdAPrgbSBEiDYj57htf65E/d9XDrtzyAKsU1FP+WPltkFGBKBQ
 XZJmul4bhQaK6xlLk4TKZeegrGDOSk8kU15f6o2G7orpzDHrwm0i2V+OCEhRa3uPHHJF
 KDJonBeklEebFsJ2NP5exqcygfokq1Qc/SFZjZ3JFbQwPl+AAv/i0Wu0AKxj0CYU7w7d
 vE+ynk0Zek5ppW/4Qbx2cP8uXY7Y5ikI0hFAXhB81TUXWqssCvX+aVSWCmDj71QJ3y9u
 2+/wUg8cxDbS0XRatlgqYMEI2AolCs4obb9OamJRuuHP2r3kcftdiWphxzWFADISdkor
 354w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706188025; x=1706792825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qs4io9fLdT3cAG7lBct+y78n0jaTZdDvmWX1yYHA+NE=;
 b=YC8rZC03tkId4LY+JDHqX9PRUasKKNO/CiBBFAfn3TkQ6+ZX3h+XpzAWsq+cf6tkkV
 2dNHNrX+sfz7fFleBSWWS71tqKB3dcA4m9QIRomdfgazGDSjJtY6vkp0JDEloFGXrhwq
 L9OyHq+ESgz7HxTUmFYdtcR365M+jai5Odv7asrPFRklQRjDDQXHxItpirkTd4Xnq649
 CNXwT6Zze3cApcaqk36z/xgGwwcmckPdU6P00gt4vs1MfeCjFuyD4qcgFmbnwkyffEW5
 baT0GFoy3jMkD5ZLfiIOBb09ktjeHf7/Pesg1qW4KfYH1VS2mjo9BUlBV++4dkDLD/99
 Q0Pg==
X-Gm-Message-State: AOJu0YzWTJ/JcBN0liwyvorWDw7lz8v7ZLF6etKPQWGmdomM5mUBjQfx
 20AAJ6pLv46K6A1Jrfb/PtEhKCxaci0H+k6rZvyP4wIeEb9gON1oojFBDjQjNHw/fQ6x0Igch0b
 l
X-Google-Smtp-Source: AGHT+IETVsUtJ7Q1t+vuLYFtxuMZaYqFyNM+r7x25ssjq7tuZfbtUp/z3E/pNgw0Yj7d/Py4IHiwyA==
X-Received: by 2002:aa7:c343:0:b0:55a:61a0:b9dc with SMTP id
 j3-20020aa7c343000000b0055a61a0b9dcmr582228edr.35.1706188025284; 
 Thu, 25 Jan 2024 05:07:05 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 er25-20020a056402449900b0055a829811ddsm6558709edb.48.2024.01.25.05.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 05:07:05 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com,
	akihiko.odaki@daynix.com
Subject: [PATCH v8 2/5] ebpf: Added eBPF initialization by fds.
Date: Thu, 25 Jan 2024 15:06:51 +0200
Message-ID: <20240125130656.425607-3-andrew@daynix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125130656.425607-1-andrew@daynix.com>
References: <20240125130656.425607-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::536;
 envelope-from=andrew@daynix.com; helo=mail-ed1-x536.google.com
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

It allows using file descriptors of eBPF provided
outside of QEMU.
QEMU may be run without capabilities for eBPF and run
RSS program provided by management tool(g.e. libvirt).

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 ebpf/ebpf_rss-stub.c |  9 +++++++--
 ebpf/ebpf_rss.c      | 27 +++++++++++++++++++++++++++
 ebpf/ebpf_rss.h      |  5 +++++
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/ebpf/ebpf_rss-stub.c b/ebpf/ebpf_rss-stub.c
index e71e229190..1c158b6e06 100644
--- a/ebpf/ebpf_rss-stub.c
+++ b/ebpf/ebpf_rss-stub.c
@@ -6,8 +6,7 @@
  * Authors:
  *  Yuri Benditovich <yuri.benditovich@daynix.com>
  *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
@@ -28,6 +27,12 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
     return false;
 }
 
+bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
+                       int config_fd, int toeplitz_fd, int table_fd)
+{
+    return false;
+}
+
 bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
                       uint16_t *indirections_table, uint8_t *toeplitz_key)
 {
diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index c6e10265a7..20c44f2baa 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -145,6 +145,33 @@ error:
     return false;
 }
 
+bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
+                       int config_fd, int toeplitz_fd, int table_fd)
+{
+    if (ebpf_rss_is_loaded(ctx)) {
+        return false;
+    }
+
+    if (program_fd < 0 || config_fd < 0 || toeplitz_fd < 0 || table_fd < 0) {
+        return false;
+    }
+
+    ctx->program_fd = program_fd;
+    ctx->map_configuration = config_fd;
+    ctx->map_toeplitz_key = toeplitz_fd;
+    ctx->map_indirections_table = table_fd;
+
+    if (!ebpf_rss_mmap(ctx)) {
+        ctx->program_fd = -1;
+        ctx->map_configuration = -1;
+        ctx->map_toeplitz_key = -1;
+        ctx->map_indirections_table = -1;
+        return false;
+    }
+
+    return true;
+}
+
 static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
                                 struct EBPFRSSConfig *config)
 {
diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h
index 404cf53613..39646aff6f 100644
--- a/ebpf/ebpf_rss.h
+++ b/ebpf/ebpf_rss.h
@@ -13,6 +13,8 @@
 #ifndef QEMU_EBPF_RSS_H
 #define QEMU_EBPF_RSS_H
 
+#define EBPF_RSS_MAX_FDS 4
+
 struct EBPFRSSContext {
     void *obj;
     int program_fd;
@@ -40,6 +42,9 @@ bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx);
 
 bool ebpf_rss_load(struct EBPFRSSContext *ctx);
 
+bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
+                       int config_fd, int toeplitz_fd, int table_fd);
+
 bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
                       uint16_t *indirections_table, uint8_t *toeplitz_key);
 
-- 
2.43.0


