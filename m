Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056A3C3ABA1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5eB-0006zd-Dw; Tue, 11 Mar 2025 15:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5e8-0006zK-Jl
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:52:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5e6-0007Vv-C1
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:52:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso1318435e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741722728; x=1742327528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lD2YxegH+O2M3mDLxbpltYgZrEw2FQlSYewOZZxS04U=;
 b=HWmPo6pm3Id7WzcbtoweBcAoaKAVonpke5lMBJYQ1lAJRQcJMPkolcjagsKqP9Vd08
 LJRURKx+TA4/1pVhMMihF+lB7hLvzGeMrUy26Vonc28A3qHhuJeiiv1DM/NkJutpHajT
 CismHPj1UPH5eL2H1ZqHFciPv/+GZLYYP5zeyS+M8vC7cbgFehDvAh50znruHJFBnCa0
 fcW99hMvOz24aKWD5EXCtzHDPXVFTBvGOYEqF0pG93iVPUX7KBh/jqM0PymBDXzjAfcF
 magbD0vbX6mmOeFe69F0rmigO9CXPPg8drNIvqwoUhtHMxvjrFAUKoMZizkC+7awZcPF
 Vplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741722728; x=1742327528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lD2YxegH+O2M3mDLxbpltYgZrEw2FQlSYewOZZxS04U=;
 b=QZkHEvEqgGfiecenF3Ba3sehBoGZ6B9+UyTM8Yjs8w1vWkusk6QsBduJY+QaHXOlFA
 TQLiKA7dB4BkrZ9SDpoWwHzNolKhX1HTXUTpsxYJykvNXOjAFG+PpbbL/ccvaUMabS+L
 gWw2UewBfDjL9bWCKK8Ga9dT2swnvTg57iosUzLVfERZuCYmNMEoM7HgU/k9bLSYCLfc
 vK12a9w7eRzn4iJFbgEjrnNnIOJY7BlnvFPwec2QH5jF8MWN1DvCP0RyeRnrAom5452T
 NcRB/T9P22tUDnSlZpvjgHxie6aMeC7eTfujUwRJo/fwyNp64hfboAfGapYhqd9bda58
 c7yA==
X-Gm-Message-State: AOJu0YxS/b2X9Bl+wi1Xlhc6yVp5A2BUAsjsBdpjPnbO6rLjr0Ntvgsa
 khhWdy7+oNwDpcLSRPBrxhs+xWZJxGklQcD7QGUMN5rz7S64VuWzOaS9H+K+j4k+4TgD6DLdDL5
 fj4Q=
X-Gm-Gg: ASbGnctFvj+jKHioPSqLD3Be/mRQKXXa5f9+dODPpBvriKrXrohHgCwMCCR/lz+xVRU
 QkUlAeOfvq84mmJaHzC8/y+soicH8TT7J35+c2S8Or4yFUl1JmMdW7A28ymjSYCKStDhVEcg08b
 dyl2jTbXuCxwWBFdE3izr6XnWwy4KpR981At3d3cCVBNl3g4iyJFTQ6pVTHEsQfMN8PK9MNvz80
 HWLDvK+s2yKmOG/FHti6TKT8J62hFzhAvtgjYSC2DNNo/dNIkwMpVUns+wG0T90uRD3kdbjmN3q
 yXWiFBLE5QBXncdVJwBV9nSsQmZZVIsW5R0QEmfXJ/RBPCAw5VW6aTeywzndtAtlQ1ZrcaXuzeM
 RowiCq+VcEWtGyRamO08=
X-Google-Smtp-Source: AGHT+IG3X8RAn8nfTSAZO46u73tb9pWb8gn636R9tWndW0J4LLfXSeISvkWS/8lZB3dCwdroaOGCiw==
X-Received: by 2002:a05:600c:1c22:b0:439:8634:9909 with SMTP id
 5b1f17b1804b1-43d01d50313mr56671515e9.14.1741722728324; 
 Tue, 11 Mar 2025 12:52:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c015a29sm18637792f8f.42.2025.03.11.12.52.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 12:52:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/14] system: Replace arch_type global by
 qemu_arch_available() helper
Date: Tue, 11 Mar 2025 20:51:18 +0100
Message-ID: <20250311195123.94212-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311195123.94212-1-philmd@linaro.org>
References: <20250311195123.94212-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

qemu_arch_available() is a bit simpler to understand while
reviewing than the undocumented arch_type variable.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250305005225.95051-5-philmd@linaro.org>
---
 include/system/arch_init.h | 2 +-
 hw/scsi/scsi-disk.c        | 2 +-
 system/arch_init.c         | 5 ++++-
 system/qdev-monitor.c      | 4 ++--
 system/vl.c                | 6 +++---
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/system/arch_init.h b/include/system/arch_init.h
index d8b77440487..51e24c3091e 100644
--- a/include/system/arch_init.h
+++ b/include/system/arch_init.h
@@ -25,6 +25,6 @@ enum {
     QEMU_ARCH_LOONGARCH = (1 << 23),
 };
 
-extern const uint32_t arch_type;
+bool qemu_arch_available(unsigned qemu_arch_mask);
 
 #endif
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e7f738b4841..7c87b20e694 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3165,7 +3165,7 @@ static void scsi_property_add_specifics(DeviceClass *dc)
     ObjectClass *oc = OBJECT_CLASS(dc);
 
     /* The loadparm property is only supported on s390x */
-    if (arch_type & QEMU_ARCH_S390X) {
+    if (qemu_arch_available(QEMU_ARCH_S390X)) {
         object_class_property_add_str(oc, "loadparm",
                                       scsi_property_get_loadparm,
                                       scsi_property_set_loadparm);
diff --git a/system/arch_init.c b/system/arch_init.c
index b9147af93cb..e85736884c9 100644
--- a/system/arch_init.c
+++ b/system/arch_init.c
@@ -24,4 +24,7 @@
 #include "qemu/osdep.h"
 #include "system/arch_init.h"
 
-const uint32_t arch_type = QEMU_ARCH;
+bool qemu_arch_available(unsigned qemu_arch_mask)
+{
+    return qemu_arch_mask & QEMU_ARCH;
+}
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 856c9e8c32e..5588ed2047d 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -132,7 +132,7 @@ static const char *qdev_class_get_alias(DeviceClass *dc)
 
     for (i = 0; qdev_alias_table[i].typename; i++) {
         if (qdev_alias_table[i].arch_mask &&
-            !(qdev_alias_table[i].arch_mask & arch_type)) {
+            !qemu_arch_available(qdev_alias_table[i].arch_mask)) {
             continue;
         }
 
@@ -218,7 +218,7 @@ static const char *find_typename_by_alias(const char *alias)
 
     for (i = 0; qdev_alias_table[i].alias; i++) {
         if (qdev_alias_table[i].arch_mask &&
-            !(qdev_alias_table[i].arch_mask & arch_type)) {
+            !qemu_arch_available(qdev_alias_table[i].arch_mask)) {
             continue;
         }
 
diff --git a/system/vl.c b/system/vl.c
index 04f78466c41..ec93988a03a 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -878,11 +878,11 @@ static void help(int exitcode)
             g_get_prgname());
 
 #define DEF(option, opt_arg, opt_enum, opt_help, arch_mask)    \
-    if ((arch_mask) & arch_type)                               \
+    if (qemu_arch_available(arch_mask)) \
         fputs(opt_help, stdout);
 
 #define ARCHHEADING(text, arch_mask) \
-    if ((arch_mask) & arch_type)    \
+    if (qemu_arch_available(arch_mask)) \
         puts(stringify(text));
 
 #define DEFHEADING(text) ARCHHEADING(text, QEMU_ARCH_ALL)
@@ -2929,7 +2929,7 @@ void qemu_init(int argc, char **argv)
             const QEMUOption *popt;
 
             popt = lookup_opt(argc, argv, &optarg, &optind);
-            if (!(popt->arch_mask & arch_type)) {
+            if (!qemu_arch_available(popt->arch_mask)) {
                 error_report("Option not supported for this target");
                 exit(1);
             }
-- 
2.47.1


