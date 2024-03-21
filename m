Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D518C54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKhp-0002N6-2b; Thu, 21 Mar 2024 11:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKhW-0001cp-MV
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:51:31 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKhO-0002DG-Ir
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:51:27 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a471f86dcd3so27479766b.2
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711036264; x=1711641064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ie3mfp1m/rRKvj+8OELX2ynuCGg82V7qLs9kfFYvM/A=;
 b=x2r+5suXYj2OJFynwLooTTT/G1/nFqtcu6I19wZwOk6fJjz9M8vEXYlv+fbrMK4jG6
 QjudyUBsGu+u8Ycfu4qiAPOB5yL4ndbkg/zj8S3YZ9pVW/WeEFcIJxV2fbqqyCdbo1QO
 ojOKKvSX/a24RoTMiGY43EDNSynqPsdoJhRB5kuHsXLBb3r04q+HFmuB+P8JuAd/dgqe
 w5d00MmZW/kA0T2gmuAWU7XOTKXHux2GDkm1JjGyShFTAwv/W42+5S+o6cpUT9AtTg/P
 rtgdfQyIcnBUKXXFbLBCzB01pNbrx/bJmblJgCPYxTKJ1q7/5eOO3c7EcijqRKJa9Wo7
 XztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711036264; x=1711641064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ie3mfp1m/rRKvj+8OELX2ynuCGg82V7qLs9kfFYvM/A=;
 b=oEQxE7OwCeJCb6OfE7IlEIB+AxeFyeQUpkQwP7y1vBtORM7n/G+Uw8M5ThtWNLBzN2
 jG3PgDQ8qsTYg4KLwWBCi8bxqCrXt77KJKg34xfqXMAhvTnjAPrwXMQLLvN74L2GLBl1
 dOvFgxX6uElkrpnN5vT+evYUF9x0nw+vIS6+IPkOuTq7LTZUGsDu+2O11BXLidaTlASn
 uJcPvS1UbeZxe9Aj3mVHlYQ1LRTSERJ8+3n4KrQgpZctw8bWwEc9diuzW5D2fvxTrgeB
 qvyJvfBwOZ6xmC7u0Bfp0n5Kc4kyPMp0OPCAVmZmTx5GPt29J9IVgcVAEK178ZocfKNe
 eZSw==
X-Gm-Message-State: AOJu0Yzhxjgqqz8D82AuvklJh7b6CbkThzGOarX/KG5gv7p7dcT2i0K4
 sVx+jztk/OVZstlDaYVswe5MQVWQV9PMyWtKurH3LHxxbjo1JGYiIHoRjV44So1ZAzZbgkohUok
 hhPE=
X-Google-Smtp-Source: AGHT+IHBIEjNNoQWciGMRReYDUJ+2KBY59lWDsKhCAXVV+pZNY4VmyPe+35g936JWxQSLM+SygqP2g==
X-Received: by 2002:a17:906:119b:b0:a46:d776:645a with SMTP id
 n27-20020a170906119b00b00a46d776645amr6338524eja.52.1711036263951; 
 Thu, 21 Mar 2024 08:51:03 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a170906694500b00a4131367204sm55036ejs.80.2024.03.21.08.51.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 08:51:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Chris Wulff <crwulff@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 19/21] target/xtensa: Simplify dump_mpu() and
 dump_tlb()
Date: Thu, 21 Mar 2024 16:48:35 +0100
Message-ID: <20240321154838.95771-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321154838.95771-1-philmd@linaro.org>
References: <20240321154838.95771-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Remove few qemu_printf() calls in xtensa_dump_mmu()
by slightly reworking dump_mpu() and dump_tlb().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/mmu_helper.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 8be8d79dcd..3b4f53feb0 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -203,6 +203,7 @@ static void dump_tlb(CPUXtensaState *env, bool dtlb)
         xtensa_option_enabled(env->config, XTENSA_OPTION_MMU) ?
         mmu_attr_to_access : region_attr_to_access;
 
+    qemu_printf("%s:\n", dtlb ? "DTLB" : "IBLB");
     for (wi = 0; wi < conf->nways; ++wi) {
         uint32_t sz = ~xtensa_tlb_get_addr_mask(env, dtlb, wi) + 1;
         const char *sz_text;
@@ -252,11 +253,12 @@ static void dump_tlb(CPUXtensaState *env, bool dtlb)
     }
 }
 
-static void dump_mpu(CPUXtensaState *env,
+static void dump_mpu(CPUXtensaState *env, const char *map_desc,
                      const xtensa_mpu_entry *entry, unsigned n)
 {
     unsigned i;
 
+    qemu_printf("%s map:\n", map_desc);
     qemu_printf("\t%s  Vaddr       Attr        Ring0  Ring1  System Type    CPU cache\n"
                 "\t%s  ----------  ----------  -----  -----  -------------  ---------\n",
                 env ? "En" : "  ",
@@ -316,15 +318,15 @@ void xtensa_dump_mmu(CPUXtensaState *env)
                 XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_TRANSLATION) |
                 XTENSA_OPTION_BIT(XTENSA_OPTION_MMU))) {
 
-        qemu_printf("ITLB:\n");
         dump_tlb(env, false);
-        qemu_printf("\nDTLB:\n");
+        qemu_printf("\n");
         dump_tlb(env, true);
     } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_MPU)) {
-        qemu_printf("Foreground map:\n");
-        dump_mpu(env, env->mpu_fg, env->config->n_mpu_fg_segments);
-        qemu_printf("\nBackground map:\n");
-        dump_mpu(NULL, env->config->mpu_bg, env->config->n_mpu_bg_segments);
+        dump_mpu(env, "Foreground",
+                 env->mpu_fg, env->config->n_mpu_fg_segments);
+        qemu_printf("\n");
+        dump_mpu(NULL, "Background",
+                 env->config->mpu_bg, env->config->n_mpu_bg_segments);
     } else {
         qemu_printf("No TLB for this CPU core\n");
     }
-- 
2.41.0


