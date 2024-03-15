Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8395CC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7Jd-0005kx-Jq; Fri, 15 Mar 2024 09:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7JS-0005cT-E5
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:31 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7JL-0007Yl-9H
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:25 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5689b7e8387so2720653a12.2
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710508161; x=1711112961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NCfHsLOktJnJk/FrjkYW88SQD28CKLAyjY7rSKM5rcw=;
 b=ODJzEgTewYBjA1vbFoVLXqCZ/dmX12nggcch+wbY2JIpDZ7la337XjSWIPaem4ny5X
 GjBb4zdyTaBRk8GBL4lcjQHisbgN+KzSLDGEL8unHJ4/WoJJwfKbFYGgui6i+GlcsoGd
 mJtsgMnOXDOysu8GsEcvziGvAbQt7oHQah5A0P2x99BpnJUb6VIhRcdsUv25HgIEd7by
 FN+OdZmERQcQnCJjHSfre4uYTEAdGtK+37jzUaUnxnEu7M8E0HZM/r8OJX2djlpF6V1c
 MzcSmoyOqp92pk2mdGlZf0pnPFiLFRGwv7vivJy7qGwhYe84ztuIs26nslSLADNrrUdf
 cKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508161; x=1711112961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NCfHsLOktJnJk/FrjkYW88SQD28CKLAyjY7rSKM5rcw=;
 b=mzmn1h/ot9nlqeHtGHXGxvXOQdk8hAT37N0RV3nGf6GxnlFch47nmIjCYxyJGPZ1yq
 xluKHHUeekSLgFAUb4b5M9LemAJkuwFykzxJY9/Tlauid3z4QNVRweYBxc3TroHSY0we
 np2gpNcC6LCV78INhMPFf6HcGMz6B9XRvoSNjs8C/qQ2Y06lm7N2ocqx/iEz0mYCC6Ty
 7vvfzw5IekzHHXqHlv0Km9Jh6fHfJjf1fl58kM4vQWG0au5CHbZVsfXYeoFSmCPkwyvO
 8Lp0HXWxNvjc3ME0tObm90FHDPkcQR7LUz4Wqp+agADQGhOZQam+y/SrWXyK/W82KHyn
 hnAw==
X-Gm-Message-State: AOJu0YxiBhv21HFJbmldzmib81P+MjNv7lwM532P831C86N6Lqz3UcKZ
 YGXLHTVktchtPC3XxRafhAhy8Z6R9QfQs4bUcmsks135yqlb6drftXnRlNzRsSsNwX5+MsNbdw2
 z
X-Google-Smtp-Source: AGHT+IEIqbu+dkyYORdlV0Gte9UybiujX61BXzptaCyYsWEUuL7ULvFX0eVwlBjaCfc67LjfUoRRVg==
X-Received: by 2002:a17:906:360a:b0:a46:9a13:362c with SMTP id
 q10-20020a170906360a00b00a469a13362cmr291836ejb.52.1710508160915; 
 Fri, 15 Mar 2024 06:09:20 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.145.26])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a17090613cc00b00a45ff1fe8dasm1693781ejc.115.2024.03.15.06.09.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Mar 2024 06:09:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 01/21] target/i386: Declare CPU QOM types using
 DEFINE_TYPES() macro
Date: Fri, 15 Mar 2024 14:08:49 +0100
Message-ID: <20240315130910.15750-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240315130910.15750-1-philmd@linaro.org>
References: <20240315130910.15750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. In
particular because type array declared with such macro
are easier to review.

In few commits we are going to add more types, so replace
the type_register_static() to ease further reviews.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20231013140116.255-14-philmd@linaro.org>
---
 target/i386/cpu.c | 50 ++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9a210d8d92..ebf555f50f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4991,13 +4991,6 @@ static void max_x86_cpu_initfn(Object *obj)
                             &error_abort);
 }
 
-static const TypeInfo max_x86_cpu_type_info = {
-    .name = X86_CPU_TYPE_NAME("max"),
-    .parent = TYPE_X86_CPU,
-    .instance_init = max_x86_cpu_initfn,
-    .class_init = max_x86_cpu_class_init,
-};
-
 static char *feature_word_description(FeatureWordInfo *f, uint32_t bit)
 {
     assert(f->type == CPUID_FEATURE_WORD || f->type == MSR_FEATURE_WORD);
@@ -8041,19 +8034,6 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     }
 }
 
-static const TypeInfo x86_cpu_type_info = {
-    .name = TYPE_X86_CPU,
-    .parent = TYPE_CPU,
-    .instance_size = sizeof(X86CPU),
-    .instance_align = __alignof(X86CPU),
-    .instance_init = x86_cpu_initfn,
-    .instance_post_init = x86_cpu_post_initfn,
-
-    .abstract = true,
-    .class_size = sizeof(X86CPUClass),
-    .class_init = x86_cpu_common_class_init,
-};
-
 /* "base" CPU model, used by query-cpu-model-expansion */
 static void x86_cpu_base_class_init(ObjectClass *oc, void *data)
 {
@@ -8065,22 +8045,38 @@ static void x86_cpu_base_class_init(ObjectClass *oc, void *data)
     xcc->ordering = 8;
 }
 
-static const TypeInfo x86_base_cpu_type_info = {
-        .name = X86_CPU_TYPE_NAME("base"),
-        .parent = TYPE_X86_CPU,
-        .class_init = x86_cpu_base_class_init,
+static const TypeInfo x86_cpu_types[] = {
+    {
+        .name           = TYPE_X86_CPU,
+        .parent         = TYPE_CPU,
+        .abstract       = true,
+        .instance_size  = sizeof(X86CPU),
+        .instance_align = __alignof(X86CPU),
+        .instance_init  = x86_cpu_initfn,
+        .instance_post_init = x86_cpu_post_initfn,
+        .class_size     = sizeof(X86CPUClass),
+        .class_init     = x86_cpu_common_class_init,
+    }, {
+        .name           = X86_CPU_TYPE_NAME("base"),
+        .parent         = TYPE_X86_CPU,
+        .class_init     = x86_cpu_base_class_init,
+    }, {
+        .name           = X86_CPU_TYPE_NAME("max"),
+        .parent         = TYPE_X86_CPU,
+        .instance_init  = max_x86_cpu_initfn,
+        .class_init     = max_x86_cpu_class_init,
+    }
 };
 
+DEFINE_TYPES(x86_cpu_types)
+
 static void x86_cpu_register_types(void)
 {
     int i;
 
-    type_register_static(&x86_cpu_type_info);
     for (i = 0; i < ARRAY_SIZE(builtin_x86_defs); i++) {
         x86_register_cpudef_types(&builtin_x86_defs[i]);
     }
-    type_register_static(&max_x86_cpu_type_info);
-    type_register_static(&x86_base_cpu_type_info);
 }
 
 type_init(x86_cpu_register_types)
-- 
2.41.0


