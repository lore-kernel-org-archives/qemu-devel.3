Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA1DC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7Jn-0005wf-Sb; Fri, 15 Mar 2024 09:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7JY-0005e6-AS
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:40 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7JV-0007bn-R6
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:36 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d228a132acso28949641fa.0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710508169; x=1711112969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38DwNqP/w4iyE7cU/eTej+AEZTmllcOjbkkM5XAd0Sw=;
 b=XB5H0U5l83wIbjQjpuYrC5o12zfap5fgJx3f06O+MSzwOlneioTk6FoIpJ4t2tDHN6
 8t+1D5KldGYyL1Nm7TIUFScpsoHQj2+miWpenx2W8ytiCpcs++dukYTLuNdXpNCz8tJZ
 5aB5zoFCSHB/f7ah2CmUk0ZFEYxlRpOMp+jd6fqH9S+/Ea3rk6m1qd2g/1h50qyRmmIy
 Zdzwgk5doM//rWBzrUkHlquT7/eexJnaT+NaN5BgJ7vEdZr6Ly5fcxPTkRvUvOah8ARC
 2L8h7GCTyL6oorUJ3ceF9qnT4Pu3tz0CeNwW6uHfRqIlY0vqzOih5we19mXj2jIMqai6
 nsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508169; x=1711112969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=38DwNqP/w4iyE7cU/eTej+AEZTmllcOjbkkM5XAd0Sw=;
 b=PuSfKsenRCYK65/5vM4h7+c0+fhY9PxaLdFFNMax1a3X4hwE4CFfQeXkRmCvacbVd6
 C6dn8tTJLLnAQLhOr1Dk7HHzg0Sdfg88iqYSzu/5UxvAjvxBVBFjoOi5dJRPso3cS0yx
 6g6y/1+1/l+XXNs2ziUf1MJLOfxLn0ppS0mnih62rxhvCfixw4J/17/qqGbicN0mqmsK
 A8E/2K5vf9qhsAgiZ2usDiMLOgX3qfFCkWZc2lSzNqLUkf10tTGq0u1BPvLJA3fZr/fZ
 i9GetKZH4q0kZNJbvf4yVxmRv6CVyQbN7IXzciie+MZEh2bb0knqmETOcs0bf3qeh87J
 W9KQ==
X-Gm-Message-State: AOJu0YzOaPB2EIkR5ImK9XCLI7jjG+6TVpW7nTsdkZnA+21sa5yVDHtR
 TG8UGIOSVUvfSHUtSU6VJAjDuxAlpHRNpR0RhfDNe2yV0wkWXtwfVwhAyo2fGSq0G6dHfrkTdY8
 9
X-Google-Smtp-Source: AGHT+IGUqlgwpBs0iVH+nA4YB8mpndxs+sUNctHnYtgA2NyEqcGCBN6lT+1elp7U+umu/qoGxw6VQg==
X-Received: by 2002:a2e:9850:0:b0:2d4:7829:4d13 with SMTP id
 e16-20020a2e9850000000b002d478294d13mr2977270ljj.50.1710508167582; 
 Fri, 15 Mar 2024 06:09:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.145.26])
 by smtp.gmail.com with ESMTPSA id
 qs28-20020a170906459c00b00a45efdfdd1esm1685202ejc.40.2024.03.15.06.09.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Mar 2024 06:09:27 -0700 (PDT)
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
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PATCH-for-9.1 02/21] target/mips: Declare CPU QOM types using
 DEFINE_TYPES() macro
Date: Fri, 15 Mar 2024 14:08:50 +0100
Message-ID: <20240315130910.15750-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240315130910.15750-1-philmd@linaro.org>
References: <20240315130910.15750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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
Message-Id: <20231013140116.255-15-philmd@linaro.org>
---
 target/mips/cpu.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 8d8f690a53..c096d97fe3 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -594,17 +594,21 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
 #endif /* CONFIG_TCG */
 }
 
-static const TypeInfo mips_cpu_type_info = {
-    .name = TYPE_MIPS_CPU,
-    .parent = TYPE_CPU,
-    .instance_size = sizeof(MIPSCPU),
-    .instance_align = __alignof(MIPSCPU),
-    .instance_init = mips_cpu_initfn,
-    .abstract = true,
-    .class_size = sizeof(MIPSCPUClass),
-    .class_init = mips_cpu_class_init,
+static const TypeInfo mips_cpu_types[] = {
+    {
+        .name           = TYPE_MIPS_CPU,
+        .parent         = TYPE_CPU,
+        .instance_size  = sizeof(MIPSCPU),
+        .instance_align = __alignof(MIPSCPU),
+        .instance_init  = mips_cpu_initfn,
+        .abstract       = true,
+        .class_size     = sizeof(MIPSCPUClass),
+        .class_init     = mips_cpu_class_init,
+    }
 };
 
+DEFINE_TYPES(mips_cpu_types)
+
 static void mips_cpu_cpudef_class_init(ObjectClass *oc, void *data)
 {
     MIPSCPUClass *mcc = MIPS_CPU_CLASS(oc);
@@ -629,7 +633,6 @@ static void mips_cpu_register_types(void)
 {
     int i;
 
-    type_register_static(&mips_cpu_type_info);
     for (i = 0; i < mips_defs_number; i++) {
         mips_register_cpudef_type(&mips_defs[i]);
     }
-- 
2.41.0


