Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D67C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7Jr-0006Cy-Et; Fri, 15 Mar 2024 09:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7Jb-0005eP-Sn
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:40 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7JY-0007dV-1R
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:39 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5658082d2c4so2805491a12.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710508174; x=1711112974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QXR+KoDyjF3DzCtPRlneMC/cDzpoxSokp1VWknBDtAc=;
 b=OIKG7UBbSegyL5K4xTc8cRKmFmd3w+Kh8zZMEqL33VJK1NazutogQCSSnilz8hXtoN
 8Pw6pY2voj9Sz13mo4rIdXScYcCjgwc8aubTIG3mmaK8pczHsMYV/J7ER79ByRcwb0qv
 6Md90/UyQKaN92DJttmyvCqADnE1AAygbh+hD7OOGAgULOgHDhD7sHHnpAEVmZGo7bm3
 +v3aJtumfpjULMF+NvbLRBHUnowuUSTPpnY1Iifb15rKSuNjPgdRt2r+AR24VEj6fXE6
 02lSwobYUP7cTFMiG6hKRWknhkYwBIKf9m7NyjUW8cbX9s2+Z32h37hna6n3d59hRi52
 THdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508174; x=1711112974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QXR+KoDyjF3DzCtPRlneMC/cDzpoxSokp1VWknBDtAc=;
 b=s5p8qui8W+SkKdgNZZHBv4jyr1087ncPh7G8IWnrFMhMZGFAtaUnTk7wujNLdOmIHh
 1JIEZqXJRqQYRyPKYe9k8FODiDmbnO6xyNAQl+AgglEP36yNuLtt8W86XpceicRlu3re
 2gEvi4P5u5c6Yj8WGv6F2LamTXn8l7VKaHCw6wHGBmzsc3RaBgMP5ZNTahS/VzVBPpuk
 rMv+t4C1Kv7upOHd32BrSQh75kwuWf+2a+ZQhK8LIQVNWr1q8nIvGyRi1z/sCWsSsNI8
 OrYF+XP/9+ngy0jym3UThHBhhHRkJoX0KilVKzCNy3ezkeKBzL3OXqijkfCfLWI+Nx2g
 /6Kg==
X-Gm-Message-State: AOJu0YzcFbNNs/7FhHCk1iYk7d5MtSrH9PX2SzZ8yMEMytDkvAGRlzAj
 wIkc7vIibTDte5AgGG3FYzYJ346sLS/A/d8IHuAOJU+im5sSbn4fMaO+r1VWmDgAAdM5jAje9Pf
 i
X-Google-Smtp-Source: AGHT+IHzBClF6y3leG9X1IH7huHpryichprPqecACIGO7r5xFYMO3bWZ334I3If9L1+1vr9CkQSmGw==
X-Received: by 2002:a17:906:c30f:b0:a46:2a85:b37b with SMTP id
 s15-20020a170906c30f00b00a462a85b37bmr2902264ejz.51.1710508173970; 
 Fri, 15 Mar 2024 06:09:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.145.26])
 by smtp.gmail.com with ESMTPSA id
 v23-20020a1709067d9700b00a461a7ba686sm1707470ejo.75.2024.03.15.06.09.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Mar 2024 06:09:33 -0700 (PDT)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH-for-9.1 03/21] target/ppc: Declare CPU QOM types using
 DEFINE_TYPES() macro
Date: Fri, 15 Mar 2024 14:08:51 +0100
Message-ID: <20240315130910.15750-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240315130910.15750-1-philmd@linaro.org>
References: <20240315130910.15750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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
Message-Id: <20231013140116.255-16-philmd@linaro.org>
---
 target/ppc/cpu_init.c | 52 +++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7e65f08147..d5e227a6fb 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7432,39 +7432,34 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
 #endif /* CONFIG_TCG */
 }
 
-static const TypeInfo ppc_cpu_type_info = {
-    .name = TYPE_POWERPC_CPU,
-    .parent = TYPE_CPU,
-    .instance_size = sizeof(PowerPCCPU),
-    .instance_align = __alignof__(PowerPCCPU),
-    .instance_init = ppc_cpu_instance_init,
-    .instance_finalize = ppc_cpu_instance_finalize,
-    .abstract = true,
-    .class_size = sizeof(PowerPCCPUClass),
-    .class_init = ppc_cpu_class_init,
+static const TypeInfo ppc_cpu_types[] = {
+    {
+        .name           = TYPE_POWERPC_CPU,
+        .parent         = TYPE_CPU,
+        .abstract       = true,
+        .instance_size  = sizeof(PowerPCCPU),
+        .instance_align = __alignof__(PowerPCCPU),
+        .instance_init  = ppc_cpu_instance_init,
+        .instance_finalize = ppc_cpu_instance_finalize,
+        .class_size     = sizeof(PowerPCCPUClass),
+        .class_init     = ppc_cpu_class_init,
 #ifndef CONFIG_USER_ONLY
-    .interfaces = (InterfaceInfo[]) {
-          { TYPE_INTERRUPT_STATS_PROVIDER },
-          { }
+        .interfaces     = (InterfaceInfo[]) {
+              { TYPE_INTERRUPT_STATS_PROVIDER },
+              { }
+        },
+#endif
+    },
+#ifndef CONFIG_USER_ONLY
+    {
+        .name           = TYPE_PPC_VIRTUAL_HYPERVISOR,
+        .parent         = TYPE_INTERFACE,
+        .class_size     = sizeof(PPCVirtualHypervisorClass),
     },
 #endif
 };
 
-#ifndef CONFIG_USER_ONLY
-static const TypeInfo ppc_vhyp_type_info = {
-    .name = TYPE_PPC_VIRTUAL_HYPERVISOR,
-    .parent = TYPE_INTERFACE,
-    .class_size = sizeof(PPCVirtualHypervisorClass),
-};
-#endif
-
-static void ppc_cpu_register_types(void)
-{
-    type_register_static(&ppc_cpu_type_info);
-#ifndef CONFIG_USER_ONLY
-    type_register_static(&ppc_vhyp_type_info);
-#endif
-}
+DEFINE_TYPES(ppc_cpu_types)
 
 void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
@@ -7658,4 +7653,3 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #undef RGPL
 #undef RFPL
 }
-type_init(ppc_cpu_register_types)
-- 
2.41.0


