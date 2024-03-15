Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F267C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7KG-0006h4-MP; Fri, 15 Mar 2024 09:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7Jk-0005s9-NV
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:49 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7Jf-0007gn-HG
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:48 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-512f54fc2dbso2208720e87.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710508180; x=1711112980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xkGMjK1G9yFAmyZjfysW+oy0VEwc0DxCtLcyXCgX4n0=;
 b=yUX8BfrdzWIXnQVwrJ/GAdj+x14bLcAEJvOqHioGfnhC4XZzV0SmGMjlsDC45KxErx
 dXmhfMEoobwbHvcbyK7oSzpfbV2tBHYzLY7dHSIzm4ADfra8rXl5u7dZjceKKXh9YSSc
 GxTDAdk7cDtCE4Twb7yL4abIKcNTLtDV31QPEJ9frz9E3846pAzm2gi+lxz3bAT9dmnA
 dTj1RvsIne6pT9ieXHwHvB6w2YAsUmctyY5qQVFUXjHho4C/shBinwDSSWfiUrMQmbNl
 NcpWpsRgJRW6vyQTUUjKYLzqPiTXjzTk33YTH/cF4OKPJu7JvaWmMrStTJXq2aJ3dF86
 ywYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508180; x=1711112980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xkGMjK1G9yFAmyZjfysW+oy0VEwc0DxCtLcyXCgX4n0=;
 b=eNZ7Qbutk0gJhGalEBKzP5ekJoAxFxA+oVaNdL4H38XZzrDzkE562PLI3YSafPWe+V
 5bJ1je+EGdb+vScKaOVwYxzyfHy0Czmq54qyJMwmvG1jDNkUQtAYekC4t/tbX5lH5ufp
 8kJYo1WSQKFXzS6jx73fOTmUjchyAkk1K1hcmhsIM9Y3E2XxUmbIPESNw6/rl3DnoXjE
 sSOQl0xxKATI6nasBMvlkqg+lmNLmFvX9SFfJoyXNsTAY9p2q4Cja4wvaaP/6pnoYnXP
 tgaXPJHHrzRGS4KBQSAcUGeB0gFlB7S3MVpl7L3hdyKGJBAGj+yDaNAueRcBaPgZ149o
 Wthg==
X-Gm-Message-State: AOJu0YzLUbK3wWlX9nhgltOBG28rEd0Af5DDL17OsaU1luAYjXYjw+aY
 8UrRnJrln2hXPSmOKcYP/RGWPtXLV4eh3i+zLuFCk8OgojEk4MFIlS2VO15IbFb03bTwT7nGWtB
 b
X-Google-Smtp-Source: AGHT+IHpHtbKvMjVVyy3n1oFAdNafsLrOa9Ad04r6RdA8Gsvr4YycfqtkVPsX2+fpJ/zynsRUwxdAw==
X-Received: by 2002:a2e:808e:0:b0:2d2:a38c:d706 with SMTP id
 i14-20020a2e808e000000b002d2a38cd706mr3159290ljg.17.1710508180605; 
 Fri, 15 Mar 2024 06:09:40 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.145.26])
 by smtp.gmail.com with ESMTPSA id
 cx14-20020a05640222ae00b00568af798c9esm578595edb.90.2024.03.15.06.09.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Mar 2024 06:09:40 -0700 (PDT)
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH-for-9.1 04/21] target/sparc: Declare CPU QOM types using
 DEFINE_TYPES() macro
Date: Fri, 15 Mar 2024 14:08:52 +0100
Message-ID: <20240315130910.15750-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240315130910.15750-1-philmd@linaro.org>
References: <20240315130910.15750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231013140116.255-17-philmd@linaro.org>
---
 target/sparc/cpu.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index dc9ead21fc..42b13ab63f 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -949,17 +949,21 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
     cc->tcg_ops = &sparc_tcg_ops;
 }
 
-static const TypeInfo sparc_cpu_type_info = {
-    .name = TYPE_SPARC_CPU,
-    .parent = TYPE_CPU,
-    .instance_size = sizeof(SPARCCPU),
-    .instance_align = __alignof(SPARCCPU),
-    .instance_init = sparc_cpu_initfn,
-    .abstract = true,
-    .class_size = sizeof(SPARCCPUClass),
-    .class_init = sparc_cpu_class_init,
+static const TypeInfo sparc_cpu_types[] = {
+    {
+        .name           = TYPE_SPARC_CPU,
+        .parent         = TYPE_CPU,
+        .instance_size  = sizeof(SPARCCPU),
+        .instance_align = __alignof(SPARCCPU),
+        .instance_init  = sparc_cpu_initfn,
+        .abstract       = true,
+        .class_size     = sizeof(SPARCCPUClass),
+        .class_init     = sparc_cpu_class_init,
+    }
 };
 
+DEFINE_TYPES(sparc_cpu_types)
+
 static void sparc_cpu_cpudef_class_init(ObjectClass *oc, void *data)
 {
     SPARCCPUClass *scc = SPARC_CPU_CLASS(oc);
@@ -984,7 +988,6 @@ static void sparc_cpu_register_types(void)
 {
     int i;
 
-    type_register_static(&sparc_cpu_type_info);
     for (i = 0; i < ARRAY_SIZE(sparc_defs); i++) {
         sparc_register_cpudef_type(&sparc_defs[i]);
     }
-- 
2.41.0


