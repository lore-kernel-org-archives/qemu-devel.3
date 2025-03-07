Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25DBC28B25
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqgMM-00065G-ME; Fri, 07 Mar 2025 17:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqgMK-00064K-3Y
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:40:00 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqgMI-0003Mt-5K
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:39:59 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43bc4b1603fso14698375e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741387196; x=1741991996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vFDIjZoBEkcGFS81AHnWr7iG9XFN0GhdGmikXg5Pgg8=;
 b=zhZQ6zy5585DIFj0jt7j+a6ajOlJRE4LLuuBTVzXSzpQt2mje5U7RQidZ+q+veq5H4
 CW6u9hdO+8n0+TD3HPo8Wuk4xG1NbFH5GP7rg/r8asaH+EGfWhUhzkuJP+nUDeNXM1zX
 Co4yttQfhCh+cGRqzO1mgsvoRmcOlXQ28R23GZEd+tH7F3aI9Z/unIjGgLKPneG889h9
 93787WWOpHsk0VmOqrbemqPR6awSw2OKaRA+++dWk4o6YDMlHfLtMBTbefmb2GE75aLJ
 DW9Tz4jleAhpR/NcIDwmIvEVUJ92Ba2pFcjdvpF8EDrIIyy2Bl7LYiW/GBE28zn4s/wU
 M6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741387196; x=1741991996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vFDIjZoBEkcGFS81AHnWr7iG9XFN0GhdGmikXg5Pgg8=;
 b=fhhhELJ9DLrJm1/WV19iZ3CXmOaMvqzvs6z9jinpOORMMRHbg87ftZ6aQavE72oquT
 Hcko8frMvxhKFTCpFJKCMJ5uiVkIbaxZF84knWUJXH1CKDl97fHW1PmwcUwH96jCTXfz
 rR9l9g/NkpvCbWozXPNzXD2D5W9ehJA5UAN2dBCAjoh4RRjIowoofj8OdYqYnASeWITN
 UeuKPEjfjwhgVIpChgflIuGNc59Gzd/nMP0JwC2kUhoS/JyJ3/rZZDObOpC9jLNfQJI3
 VcL59QePywgF1AtfWV0bOQdh07bBCHbfIWEybL5WqqzHwXQe7Dyu6EVp6Cz0DzChSwVf
 vNkw==
X-Gm-Message-State: AOJu0YzoU6W6swrrouOgTJMc356QFpo2T11ASSispLFp+yLUlR6qf5Ph
 +aj/99r0FTEXctH5w8sEpB7l5pnJCanxMUE1Zpw0jlqWndcHP6aGWbNUFttsQZL42PAhP6xpabN
 tQ7Y=
X-Gm-Gg: ASbGncvDs91Hk9gDSfej1TAHQKGrNvh1p5TyVy1J/FPJP1SVyr1yhNURyF0yA4ideDQ
 OIUHUuyBJ9f/iO8K2cBeEqbl4G8ivohVnHmLy/PHhrpkptYOg8yxoigTCBfUbFLFr46v8Akfp+/
 yGOD7Fw/q6y0hUBoQsza7vnLNzz4DeraYxmzr85CyQ1qYWtQyONlIbKrG/JZ4V+cGztRmBwB0UF
 oDaayleBX4SiH6/cfTiAr9/AybLoZPps4eOZzJM8pu7xv2DIsrQtMa9JhU9OEDMh/TXLNWdSQMx
 Kom1EGRndCFAQ6Z/DPQOwSIsNPhKXJrQQ5gVxxIA+kPTY9FsMz3VA1RAzaeHqNTdSsGRQme0jTH
 AyTZLx3gxDu9hqFnflIo=
X-Google-Smtp-Source: AGHT+IFwGLagRYoTYveF4q5fpm6fs6OOEREKgSMyAOJDGmF0C2x6K7pdRvU8basccICFdStkVzbMJg==
X-Received: by 2002:a05:600c:524c:b0:439:a093:fffe with SMTP id
 5b1f17b1804b1-43c5a5ff0c0mr37827405e9.7.1741387195759; 
 Fri, 07 Mar 2025 14:39:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8c314asm65349195e9.10.2025.03.07.14.39.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 14:39:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/7] system: Replace arch_type global by
 qemu_arch_available() helper
Date: Fri,  7 Mar 2025 23:39:43 +0100
Message-ID: <20250307223949.54040-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307223949.54040-1-philmd@linaro.org>
References: <20250307223949.54040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
index b1baed18a30..61c6f680c94 100644
--- a/system/arch_init.c
+++ b/system/arch_init.c
@@ -38,4 +38,7 @@ int graphic_height = 600;
 int graphic_depth = 32;
 #endif
 
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


