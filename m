Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B0FC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7Kt-00088q-9J; Fri, 15 Mar 2024 09:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7KO-0006yq-5z
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:10:29 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7K6-0007wU-Mw
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:10:26 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5688eaf1165so3196598a12.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710508208; x=1711113008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qDIsKXjb1Jl9yBqR7T/u0FWdWtcs/rDVYwZEhcpoxew=;
 b=nloCUCPnHdJsTMOe5mB56ubaQqAIRf8Nt8dSaGwx8ZgJNLgL4o5fs/vibYlSdxwQDu
 77pUt1NYKxQkxq1Rrm7sDRFClixlech/srG5DqOIi/nd/017iu8LLJ0+iKSFRs4KCZlq
 mug7V1dobjrxLy02cXPiKoc3tzth37HV5ebQK+vCrC96s54SXJKS38dqAU9nMyMDLglG
 zjD8vQGdL7FSIneCIPz5NYhk4SkTgKWhTDj+m9DxScoMthRTVLkSQjXugFCbyVfsjeTU
 kaw2GVYGa+8j7am6YPiBU+E5Z12b2AhtlPRjAYjLvD/+8YflBQPRsmNcEwFhX0mhb0aD
 spFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508208; x=1711113008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qDIsKXjb1Jl9yBqR7T/u0FWdWtcs/rDVYwZEhcpoxew=;
 b=PEtxakO3ZJ9ZxNL+wQxLTU7tfr7OllaGyksgF2VsYh1WQF+FNwE/hPBA8+2xmadxxN
 NIJXF99K3RBYi7yABwtWJKej15Lb7l07nHOm9t8zwZhDADRO36q+meW7J+RETrP40cyh
 7DaPhIh4aYIKeAnBFoWY3FRyDtH/XV0oemIculxVVb/NH23zNW7t2wtazjAAQGVOTvEv
 5fRbmfMIboI1nDxlN5krlHTQkSrl6QOv65ZcR0ySEq5dgb8Ubgj5C388iYg8Pdg8hg4n
 +DiLePoCTO0OIgTOfBlGvL0SIAZgPH7YMHLmuy7u4k3NHoOGGb5HTubAMna5QZvJl/xG
 1ENg==
X-Gm-Message-State: AOJu0YwsMS7uELZvQABsnYb+he8EP2l7UhwniQ72i+kZpsKKfJlCAWID
 +I+kwQ2Uxe/apyicdm9spjCUMoNvZkBDsRaYgSbbtdW+C+cSl2kl+Efl/yLE6VOD7m+r4YnKg5t
 P
X-Google-Smtp-Source: AGHT+IHz6vQYIeOBcjGc+xE2c8P3SUzSTmtoEr2FLDXsqrRWBjGskKgF5u0V0+3R6przXpowCYuWpA==
X-Received: by 2002:a05:6402:5512:b0:568:9c6b:eb0f with SMTP id
 fi18-20020a056402551200b005689c6beb0fmr3550192edb.21.1710508207999; 
 Fri, 15 Mar 2024 06:10:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.145.26])
 by smtp.gmail.com with ESMTPSA id
 dk4-20020a0564021d8400b0056706105abesm1689843edb.33.2024.03.15.06.10.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Mar 2024 06:10:07 -0700 (PDT)
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
Subject: [PATCH-for-9.1 08/21] target/sparc: Make SPARC_CPU common to new
 SPARC32_CPU/SPARC64_CPU types
Date: Fri, 15 Mar 2024 14:08:56 +0100
Message-ID: <20240315130910.15750-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240315130910.15750-1-philmd@linaro.org>
References: <20240315130910.15750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

"target/foo/cpu-qom.h" can not use any target specific definitions.

Currently "target/sparc/cpu-qom.h" defines TYPE_SPARC_CPU
depending on the sparc(32)/sparc64 build type. This doesn't
scale in a heterogeneous context where we need to access both
types concurrently.

In order to do that, introduce the new SPARC32_CPU / SPARC64_CPU
types, both inheriting a common TYPE_SPARC_CPU base type.

Keep the current CPU types registered in sparc_register_cpudef_type()
as 32 or 64-bit, depending on the binary built.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/cpu-qom.h |  9 +++++----
 target/sparc/cpu.c     | 12 +++++++++++-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/sparc/cpu-qom.h b/target/sparc/cpu-qom.h
index a86331bd58..6ad283506e 100644
--- a/target/sparc/cpu-qom.h
+++ b/target/sparc/cpu-qom.h
@@ -22,14 +22,15 @@
 
 #include "hw/core/cpu.h"
 
-#ifdef TARGET_SPARC64
-#define TYPE_SPARC_CPU "sparc64-cpu"
-#else
 #define TYPE_SPARC_CPU "sparc-cpu"
-#endif
+#define TYPE_SPARC32_CPU "sparc32-cpu"
+#define TYPE_SPARC64_CPU "sparc64-cpu"
 
 OBJECT_DECLARE_CPU_TYPE(SPARCCPU, SPARCCPUClass, SPARC_CPU)
 
+OBJECT_DECLARE_CPU_TYPE(SPARC32CPU, SPARCCPUClass, SPARC32_CPU)
+OBJECT_DECLARE_CPU_TYPE(SPARC64CPU, SPARCCPUClass, SPARC64_CPU)
+
 #define SPARC_CPU_TYPE_SUFFIX "-" TYPE_SPARC_CPU
 #define SPARC_CPU_TYPE_NAME(model) model SPARC_CPU_TYPE_SUFFIX
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 42b13ab63f..9e27e16b75 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -959,6 +959,12 @@ static const TypeInfo sparc_cpu_types[] = {
         .abstract       = true,
         .class_size     = sizeof(SPARCCPUClass),
         .class_init     = sparc_cpu_class_init,
+    }, {
+        .name           = TYPE_SPARC32_CPU,
+        .parent         = TYPE_SPARC_CPU,
+    }, {
+        .name           = TYPE_SPARC64_CPU,
+        .parent         = TYPE_SPARC_CPU,
     }
 };
 
@@ -975,7 +981,11 @@ static void sparc_register_cpudef_type(const struct sparc_def_t *def)
     char *typename = sparc_cpu_type_name(def->name);
     TypeInfo ti = {
         .name = typename,
-        .parent = TYPE_SPARC_CPU,
+#ifdef TARGET_SPARC64
+        .parent = TYPE_SPARC64_CPU,
+#else
+        .parent = TYPE_SPARC32_CPU,
+#endif
         .class_init = sparc_cpu_cpudef_class_init,
         .class_data = (void *)def,
     };
-- 
2.41.0


