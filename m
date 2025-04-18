Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22ACEC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 00:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Zwy-0001jS-7S; Thu, 17 Apr 2025 20:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Zwx-0001jH-1V
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:23 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Zwv-0005qe-71
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:22 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso865943f8f.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 17:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744937476; x=1745542276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oo7hyyEFu8S8sgeHFv9utYRkdVF6oYH3JMKp75dwFuo=;
 b=YD+GMgW5yP/Fy9sVtIdfP7XKHWB0ODLmJQJOIiDalZS8Vetk43dO057GSJLnXylLfY
 RBtGMxbAz25ZnAw64QcosVAzX4QfmBUssyqg61Kk6AMDbjV4yvGGpmaBwkIc3LjsFEUC
 kigNiXcbxaiVzCpuV9s9bf0CHSoy5iWPRG5macipZrG6RHfLOcRQvejjGm/efoWpTBlE
 JVUZ5yZpy5RXs+Bmj4u38gTlncJDhI0QNNdGVPjdk9AINHQpb2bbUSfq92FP6N3NRQyh
 cxaLMoljiruGaCncwZTTdEsm8YSLcPLD/JslOxp3CkT0QYbNhtnHcwCRAlLkGJxXsNoK
 5UFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744937476; x=1745542276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oo7hyyEFu8S8sgeHFv9utYRkdVF6oYH3JMKp75dwFuo=;
 b=FSP7FWyofQVJELrfpUfWjU/BZ6yD5CIHpWMBgH1004dcNb9DlNEcFkds1/eAXAtehW
 ouR3vLke2Og+8HKSb8PWylkU1SOiLZic//JfmyY6J4jh9XS3Pp/iIc35hrtWdv/PEHo2
 3GeFU8lY+efSvbHC/F9dqCRYRzhVq0jUT4Es+yacQwVxcWiPE7jtVFiJiIzE3PQFaIIl
 2IJYotycCwm4DtCxR6yMH9GBPMUy9J0Ju+ZJSkdkveUv7Pvf9LQsG81RnFXBh5aUxH0/
 f3UrQ/Z8Fl1zYrYl7sNOvOFFys4igmmy8vWSOH2fK/GjysR8yAYeNfe6wJXTC2zDs+1h
 3qFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ54vRZBCY6kIdEzDQE3SdmFjRteDdZQXlgH/FiaQj0NEk7zYSSGdcOK82Hqxd1aDQds0dr+rfDv6O@nongnu.org
X-Gm-Message-State: AOJu0YzjgzMz9zeS7SFGpv1zGFyCL9t0MoqHfMmBAKQRkhnMUe2vC93A
 p8KRCpaB13KLJMqJDenXHuI5rqg/pOLWB+mteG7JuRkonDNov/mvUqdqpmcG2yorHRBrQBNi2dF
 x
X-Gm-Gg: ASbGncttu7aje37nPRoSYLlpLlnXUULpfO77NA6wINwMYpv5rG3NYahYZdzRffwjeUv
 AuQTyvGJgbromK4jrZgXntXIAnuN+sRfmTd11pagpEEWFpKWId1CqHTT5M8hg9Oy6+vwprXGMiG
 gqrqBAnvq9Yhx+u2q7aZ/f1TkFNcd8T43kFzGJn1k5jkU4sKOt5PW42aBHiM/6cKMKF/Ev7Jer7
 KFJahAA/FGY4HUNkx8Pww1DBV1p5kv0rwqz4NLFZwr7JA3/wl5kG4mBaE6XmhqecodiIipBPkdL
 mJPgxhPP/XmD+CQUjLq/txUfbQjY13ZIRvzgjW9i0xOkxRI9zG60Qazd82bG0m/EK7RxJnvAkoi
 XgihM4m5Fh0GDCMpOpP3M
X-Google-Smtp-Source: AGHT+IH71bpUn0KaJvis1Eb3mWHdM0qWJ3W9E+ZQa0rVSnxDVLiUx3DYdnfAlOwp2kIGPrerB77QBw==
X-Received: by 2002:a5d:5f92:0:b0:39c:2688:6edd with SMTP id
 ffacd0b85a97d-39efba526dcmr604605f8f.15.1744937476369; 
 Thu, 17 Apr 2025 17:51:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5a9dd6sm2255525e9.3.2025.04.17.17.51.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 17:51:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v2 03/11] system/vl: Filter machine list available for a
 particular target binary
Date: Fri, 18 Apr 2025 02:50:51 +0200
Message-ID: <20250418005059.4436-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418005059.4436-1-philmd@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Binaries can register a QOM type to filter their machines
by filling their TargetInfo::machine_typename field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target_info-impl.h |  3 +++
 include/qemu/target_info.h      |  8 ++++++++
 system/vl.c                     | 14 ++++++++++++++
 target_info.c                   |  5 +++++
 4 files changed, 30 insertions(+)

diff --git a/include/qemu/target_info-impl.h b/include/qemu/target_info-impl.h
index d5c94ed5296..990fb067d20 100644
--- a/include/qemu/target_info-impl.h
+++ b/include/qemu/target_info-impl.h
@@ -16,6 +16,9 @@ typedef struct TargetInfo {
     /* runtime equivalent of TARGET_NAME definition */
     const char *const name;
 
+    /* QOM typename machines for this binary must implement */
+    const char *const machine_typename;
+
 } TargetInfo;
 
 const TargetInfo *target_info(void);
diff --git a/include/qemu/target_info.h b/include/qemu/target_info.h
index 3f6cbbbd300..e9fd2fdd7b0 100644
--- a/include/qemu/target_info.h
+++ b/include/qemu/target_info.h
@@ -16,4 +16,12 @@
  */
 const char *target_name(void);
 
+/**
+ * target_machine_interface_typename:
+ *
+ * Returns: Name of the QOM interface implemented by machines
+ *          usable on this target binary.
+ */
+const char *target_machine_interface_typename(void);
+
 #endif
diff --git a/system/vl.c b/system/vl.c
index d8a0fe713c9..4e43e55afe7 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -27,6 +27,7 @@
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qemu/module.h"
+#include "qemu/target_info.h"
 #include "exec/cpu-common.h"
 #include "exec/page-vary.h"
 #include "hw/qdev-properties.h"
@@ -836,11 +837,17 @@ static bool usb_parse(const char *cmdline, Error **errp)
 static MachineClass *find_machine(const char *name, GSList *machines)
 {
     GSList *el;
+    const char *qom_typename_filter = target_machine_interface_typename();
 
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
 
         if (!strcmp(mc->name, name) || !g_strcmp0(mc->alias, name)) {
+            if (qom_typename_filter
+                && !object_class_dynamic_cast(el->data, qom_typename_filter)) {
+                /* Machine is not for this binary: fail */
+                return NULL;
+            }
             return mc;
         }
     }
@@ -1563,6 +1570,7 @@ static void machine_help_func(const QDict *qdict)
     g_autoptr(GSList) machines = NULL;
     GSList *el;
     const char *type = qdict_get_try_str(qdict, "type");
+    const char *qom_typename_filter = target_machine_interface_typename();
 
     machines = object_class_get_list(TYPE_MACHINE, false);
     if (type) {
@@ -1577,6 +1585,12 @@ static void machine_help_func(const QDict *qdict)
     machines = g_slist_sort(machines, machine_class_cmp);
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
+
+        if (qom_typename_filter
+            && !object_class_dynamic_cast(el->data, qom_typename_filter)) {
+            /* Machine is not for this binary: skip */
+            continue;
+        }
         if (mc->alias) {
             printf("%-20s %s (alias of %s)\n", mc->alias, mc->desc, mc->name);
         }
diff --git a/target_info.c b/target_info.c
index 877a6a15014..226eed1fd7d 100644
--- a/target_info.c
+++ b/target_info.c
@@ -14,3 +14,8 @@ const char *target_name(void)
 {
     return target_info()->name;
 }
+
+const char *target_machine_interface_typename(void)
+{
+    return target_info()->machine_typename;
+}
-- 
2.47.1


