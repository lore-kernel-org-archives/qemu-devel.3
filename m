Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C92C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 00:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpd0I-00020r-Tu; Tue, 04 Mar 2025 19:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd0H-00020c-5z
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:52:53 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd0F-0007Tb-7K
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:52:52 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4398ec2abc2so55758515e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 16:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741135969; x=1741740769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IqxIPPwTTylIALJZg+yGEIl/36eft918YUUplk+Ib0s=;
 b=vMfyQlwW3ifHEUez9rMcU15yy3BugspweUKQKayjIpu5JwrHfCAxtruDw8F8M7gvxn
 S4Xe4+XKEpRMhahyr9uVA54EPr/KAZRWbOZwuVd4KjFL1mNy4CQe2wf+nGs88gyDrfIP
 +ZuHYI4Knf05+tPSHA8dD08daBwXF+LjmAdWR7wbS9caow2HGdBnWzdhg3CIIh4oP7aM
 tfIJQcl9CoHnD+30Q7I4x1kJM8iDVdvcDoAfSh/smfchEtdwLHH4+8tPohVVdPf3PXoC
 8jTUA4q1a7T1TdmW7Uaf7J0BZXCUk3R57vxby+QweYnyQokwg9YnzgNlKM+6VY8ESKss
 WxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741135969; x=1741740769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IqxIPPwTTylIALJZg+yGEIl/36eft918YUUplk+Ib0s=;
 b=DFCETfR+449XRXOKXuheUPDIi+9daZtuFhZbV27IM+MCDg8MHfEOm+XGxBw9ZDlYeB
 O/mLK/aNKMdvS9O6KVkrlOVp/Y6oC1tdRxe+t9WbjF1GyRllafL86HwXGBteSBjW090E
 eTZWLk82TmAyAbCTfmoyMnwLWECWG/Uc+9hUL+ZPfTt9xOBWpdT78SU6iARcQWgL6OqC
 REp93azp46hgkf1yL9VhIWQG4nvTSy9UiMAqFi9xtja3dy8oYVCn+n0Fnn/jekKoR0I6
 9C28+qjcQSw+c0HN5/iTjSxWp0xabvYwlBYcjExFFkbhVyOg67FKXfHljbBocxSejLYu
 yLHA==
X-Gm-Message-State: AOJu0Yy7nEJ1rBMNN+arMYByqb1HtM5CzrR3MkmoNdmwWj5wOuA2jbLW
 zLblAvAtcT/ZruJeb9c/T7AlOlQq1kb48pNH7qMlvamAm8pciuoRYbgzsKQ6NpB04qrgJAZ6zB8
 8yO4=
X-Gm-Gg: ASbGncvEmJT37yCSWJpsxXJyGI+rDuyQ5RKxDJ0FjngIwP+hGyXuhx6UdGIr5l9KZor
 gt2fOCW9Xp7m9cisif/7FgJpW0Zb9hUaaKXEzHI/qKsghuQWkLk44GBEL+0k45pKcQFXL5hgu1l
 T44Ym+9dn1IU1cWxtwPWUVuvYc8xlYIf3Ggk4wVwS2QEwGEuCBSprxOT1G+a8qGEsFladNRgMlj
 LzaLgln8R58fj8ZK2qWvf5dZYPQ4TdUguGEFGNCBykoNlKl+OYDmVhPhqCItSXwuSvp7EI7Suta
 BHTsp7LoJX6tMno/pELNT10Lf1pj/pRlcWmY9xj26Tbi3jvCFousqVDI4Fc8u44y08sQG6/LOPp
 /iL1tORcvKoQDAI2M9fs=
X-Google-Smtp-Source: AGHT+IFkkESVTMJACdAouYCNj8b63Ia4DfV/xQK4xvXC7T6yZGBtKO5jarL2vPnB3cvAXhHTFY/Mvg==
X-Received: by 2002:a05:600c:3b87:b0:439:6101:5440 with SMTP id
 5b1f17b1804b1-43bd296abc2mr5697225e9.8.1741135968698; 
 Tue, 04 Mar 2025 16:52:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485e61csm19488252f8f.98.2025.03.04.16.52.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 16:52:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 04/11] system: Replace arch_type global by
 qemu_arch_available() helper
Date: Wed,  5 Mar 2025 01:52:18 +0100
Message-ID: <20250305005225.95051-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305005225.95051-1-philmd@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/arch_init.h | 2 +-
 hw/scsi/scsi-disk.c        | 2 +-
 system/arch_init.c         | 5 ++++-
 system/qdev-monitor.c      | 4 ++--
 system/vl.c                | 6 +++---
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/system/arch_init.h b/include/system/arch_init.h
index 06e5527ec88..023d27d5bd7 100644
--- a/include/system/arch_init.h
+++ b/include/system/arch_init.h
@@ -46,6 +46,6 @@ typedef enum QemuArchBit {
 #define QEMU_ARCH_LOONGARCH     BIT(QEMU_ARCH_BIT_LOONGARCH)
 #define QEMU_ARCH_ALL           -1
 
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
index fedbb18e2cc..0fec0cd416b 100644
--- a/system/arch_init.c
+++ b/system/arch_init.c
@@ -24,4 +24,7 @@
 #include "qemu/osdep.h"
 #include "system/arch_init.h"
 
-const uint32_t arch_type = BIT(QEMU_ARCH_BIT);
+bool qemu_arch_available(unsigned qemu_arch_mask)
+{
+    return qemu_arch_mask & BIT(QEMU_ARCH_BIT);
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


