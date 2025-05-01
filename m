Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1990DC3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbOq-0004bd-2U; Thu, 01 May 2025 17:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOl-0004Lo-GU
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:51 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOj-0002Ai-9g
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:51 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso1656439b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134687; x=1746739487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQ4d9VytMAyaMdEQkNc3+qF4cN/HnIg5sNtYWblQ1ok=;
 b=W5AvDSFVRywxzDxgULyeO141looRy6yTbT7gnj3zjZ5wbe+4FzoHRBG3PB2T73ARZP
 SNtdry3lsW7v/IEWJ7SbGa3sVMJ1m7MAVYtX5qWlF8y0CL5hum6hu7Y8PGht9JH/Od/Y
 XqNY96nd1U2ny6RZBpJ2lJWSJAi4Z1Pas/RIZodn45OE8qsnSgqDAUNozKym5hqjPxx4
 NVQ9pVM0w8IhZlknhor30LEJwdv+yl0i9Eah9F0LSu26P3zSPwSb9KNHzItBAc1mbO15
 s7NSKPL0HPTcdeIA+B7Ozkiap1TNUyfRxcLNQX2/7oDlC5D+5BRRBUrKeBDkxq/7nCO7
 yihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134687; x=1746739487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iQ4d9VytMAyaMdEQkNc3+qF4cN/HnIg5sNtYWblQ1ok=;
 b=nuEKubPH+XV4fi4krGbne1v4JLceFKI4vc3n7iFndM1AAswPtOFI4oQaANPs2doFXF
 /RE3Ht5X2Fj4/ZkfMOU3ZEDV17A9yYPkfgCJSB8uCfq2x30kRXV0NIZxLEB0hW0qbt+u
 6QdbcQqv9LyjLCGx/hVNNm1pFUjnH0uB1vECWpWOboPW9jKE3mK3FoZ/bcaQ333KKelA
 saCFAE+CvxxiRWCfPALJ7TX0WkdbOji2srxUlyr3fD2elb2Hj2xT+2dP/gR4tc2ja12W
 SPLFg3JN2/d1sCC2SI0hiXWcGRKvrEYWbdUcLeJ1AQtnlP/SfiOg2PfYZlTB/hfwJoej
 yf5Q==
X-Gm-Message-State: AOJu0YyVyS5N93DomWomhSqV7EGM1XH8fsfKuzTngcgcheaZSclEONJu
 eV6b+kktUOIKUjnvmBP0P3MjdrxQAWR1YALMefiqbZsaHzKCSdaNJnzOPvXtc8FKSTVakYgx5Kl
 K
X-Gm-Gg: ASbGncvn8L0UpDRGkPu/weXVfAhQzelRDSmVYcucmx3QOgH+dPbBSoLPPexLQLb1QtZ
 lnlycZWaAIY8NTao0HWFwHe1Vo2d4Wb9h9kprt5QNnoyQ1xUuRrtAaTqKatc16t0rOsLlZHQ44W
 0GU1fb7hJgFnasXR77XzFDQwLYO8ozuiLNPPadHWJTt9SXB2ePCE86qHqTzJbkzy97A9EKd3nkK
 b5khNct+qumxaCLLBXqwnW76Op5xZ5+8nXon5UhXACP51u3QQvLItpkI7MpcVedX/WLTITsHeUE
 oxrpk7+pZZRr9QMf7p/tSPGir0jCrvR9W82iDC3NywJ57LZThHLLJtdT+8L0LsXi27oMAxUAwvq
 ppWlLNGLR3w==
X-Google-Smtp-Source: AGHT+IEIFvDHIPpmVOYQKZDhA6VfBbl0atE9ys4hVp5TySxvaTO4GH2W1mNMkUA+HSWdHe31e9akBQ==
X-Received: by 2002:a05:6a00:4482:b0:739:4a93:a5db with SMTP id
 d2e1a72fcca58-74058b510aemr586109b3a.22.1746134687646; 
 Thu, 01 May 2025 14:24:47 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590610desm135897b3a.146.2025.05.01.14.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:24:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 40/59] system/vl: Filter machine list available for a
 particular target binary
Date: Thu,  1 May 2025 14:20:54 -0700
Message-ID: <20250501212113.2961531-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Binaries can register a QOM type to filter their machines
by filling their TargetInfo::machine_typename field.

This can be used by example by main() -> machine_help_func()
to filter the machines list.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/target-info-impl.h | 2 ++
 include/qemu/target-info.h      | 8 ++++++++
 system/vl.c                     | 3 ++-
 target-info-stub.c              | 2 ++
 target-info.c                   | 5 +++++
 5 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index d30805f7f2..d0e8c86176 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -14,6 +14,8 @@
 typedef struct TargetInfo {
     /* runtime equivalent of TARGET_NAME definition */
     const char *target_name;
+    /* QOM typename machines for this binary must implement */
+    const char *machine_typename;
 } TargetInfo;
 
 /**
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 58d4136897..2b6ccabb11 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -16,6 +16,14 @@
  */
 const char *target_name(void);
 
+/**
+ * target_machine_typename:
+ *
+ * Returns: Name of the QOM interface implemented by machines
+ *          usable on this target binary.
+ */
+const char *target_machine_typename(void);
+
 /**
  * target_cpu_type:
  *
diff --git a/system/vl.c b/system/vl.c
index 520956f4a1..7223f1ff17 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -27,6 +27,7 @@
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qemu/module.h"
+#include "qemu/target-info.h"
 #include "exec/cpu-common.h"
 #include "exec/page-vary.h"
 #include "hw/qdev-properties.h"
@@ -1564,7 +1565,7 @@ static void machine_help_func(const QDict *qdict)
     GSList *el;
     const char *type = qdict_get_try_str(qdict, "type");
 
-    machines = object_class_get_list(TYPE_MACHINE, false);
+    machines = object_class_get_list(target_machine_typename(), false);
     if (type) {
         ObjectClass *machine_class = OBJECT_CLASS(find_machine(type, machines));
         if (machine_class) {
diff --git a/target-info-stub.c b/target-info-stub.c
index 773a10188c..bcf834f71d 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -9,10 +9,12 @@
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
 #include "qemu/target-info-impl.h"
+#include "hw/boards.h"
 #include "cpu.h"
 
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
+    .machine_typename = TYPE_MACHINE,
 };
 
 const TargetInfo *target_info(void)
diff --git a/target-info.c b/target-info.c
index 84b18931e7..0042769e3a 100644
--- a/target-info.c
+++ b/target-info.c
@@ -14,3 +14,8 @@ const char *target_name(void)
 {
     return target_info()->target_name;
 }
+
+const char *target_machine_typename(void)
+{
+    return target_info()->machine_typename;
+}
-- 
2.43.0


