Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B93EC36002
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 22:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twU02-000615-QF; Sun, 23 Mar 2025 18:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twU01-00060Q-MD
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:40:57 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twTzz-0006Av-4z
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:40:57 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso26970255e9.3
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 15:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742769653; x=1743374453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mYynSm+9EDEtOgu3b8Om5yz3MdguMMae0p+vB1NumPQ=;
 b=i6KJbQ51IkhJIjqUwthMdGXCckcUT23ysqq4nlLotXpcVRipAhSAfH7bPTbz656GQL
 5vGttspcMvLklXZf/XgiMWokZgL+MXUsFTWEdyOwCwfkVmzCmqelsPcYt5Ec6uhWoDpy
 a3geNcMCK7VsbN2FUMeFRNrPuTRP0+ZOSyJjCytpKArnt0ASpSUvMsZk3NvpmKZ6seDX
 3MOJEWu0+f++X/TjK4pkJG/ygKxLoQ5Xk2ynMq/nn1H516mSnbA6bz0v78Ti7sDoZUej
 8U3rFQPSKKf5VhISNi4r6hbO+mnRRHalg74r352EbzOyKRegZpZu0v4BE6yl1bWts5wv
 x+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742769653; x=1743374453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mYynSm+9EDEtOgu3b8Om5yz3MdguMMae0p+vB1NumPQ=;
 b=GQLgtXlqrgIr1IBnhSpm9aGFW1eG2rxBiR8oA1+OQJUMVm/q1OP8YE3W6obS9phU9b
 O2WD/EBVHwpgR/s8F9U9Ej9RyEkiH/PK41D61S8fC4CVAvfnSYe0IV2zjaV56ZpgKkOe
 Xk+XHrCk9GYJALHxATI4QjdRatwo4Wx7nyaOCsgp2PXgcloApWpnhJMdGhIo0rce38Zw
 mHL7NHRNa6p0CJ4dUqaj3HfC7XaOsIk6B5JatY6ZQv5JyVkU5E331QvH7DxwdF6ABCOr
 GJvV8iCkPMd7v4iOTHtIqBUYIVgw+Rgwl+kt2Y58iMtuzeU19dAl4c9lA2ZrQ23dXX+w
 63Eg==
X-Gm-Message-State: AOJu0Yy4u4rxSr0OPGl/4OCjj6Y9eng2MzHDrYrZgzfKjp1aQGl6sVzL
 TVdKwB9VryiKZHwwzYlxLQf7rdtFxWFDdPbmgJlodZsJsq0/GCd9W2BB7JMVSHiKwtF5KzpfwWl
 x
X-Gm-Gg: ASbGnctOCtPN/W0hhXRTzmVYKhwjTbpE/WRwo3sqHQiDmbPwdV3ycZ8ak53KsiwBJbN
 2D9uubm+gDZ1BnCB4haoq5ih6H08WNDOad3+mn/+KnCrn1oPGimLZoKuYUyLl0RT+nlB1rqnh/I
 ECuCIqZmxFVgB9/mc2krbun1TeAKSkpBP1jVhXFbipNT5GoCBmyw7LZVOuCdlqDtRT5gUzymSZy
 RJwMyFxTQxux7ge98oZ23IFCgybFoUy1by4Y6jFOmIsBX+/kfpzO1Q7LxhOt9G5BydFUbeLchC/
 1j8j09wXxArkx4TZpR2RvYG342D4YMD5xxHyEt909jTKGVbOF3yvSF1/YMd7OhPkSqv0A60yylp
 NBG+tW232tILmWvwyg6aAEnBa
X-Google-Smtp-Source: AGHT+IHu6nTaDTvMdJva7IIQ+uauVzNPBByWzEHqVWKP9akbw5+xGLq7TD467xePGXFnQLiQkkWnWw==
X-Received: by 2002:a05:600c:3c9b:b0:43d:d06:3798 with SMTP id
 5b1f17b1804b1-43d50a31ffamr100862405e9.20.1742769653276; 
 Sun, 23 Mar 2025 15:40:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd9ec29sm99906115e9.30.2025.03.23.15.40.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 23 Mar 2025 15:40:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 3/6] target/ppc: Register CPUClass:list_cpus
Date: Sun, 23 Mar 2025 23:40:32 +0100
Message-ID: <20250323224035.34698-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250323224035.34698-1-philmd@linaro.org>
References: <20250323224035.34698-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Register ppc_cpu_list() as CPUClass:list_cpus callback.
Reduce its scope and remove the cpu_list definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu.h      | 4 ----
 target/ppc/cpu_init.c | 3 ++-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index efab54a0683..0062579ef3e 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1597,8 +1597,6 @@ void ppc_store_dawrx1(CPUPPCState *env, uint32_t value);
 #endif /* !defined(CONFIG_USER_ONLY) */
 void ppc_store_msr(CPUPPCState *env, target_ulong value);
 
-void ppc_cpu_list(void);
-
 /* Time-base and decrementer management */
 uint64_t cpu_ppc_load_tbl(CPUPPCState *env);
 uint32_t cpu_ppc_load_tbu(CPUPPCState *env);
@@ -1660,8 +1658,6 @@ static inline uint64_t ppc_dump_gpr(CPUPPCState *env, int gprn)
 int ppc_dcr_read(ppc_dcr_t *dcr_env, int dcrn, uint32_t *valp);
 int ppc_dcr_write(ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
 
-#define cpu_list ppc_cpu_list
-
 /* MMU modes definitions */
 #define MMU_USER_IDX 0
 static inline int ppc_env_mmu_index(CPUPPCState *env, bool ifetch)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 8b590e7f17c..0ccb9068c89 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7184,7 +7184,7 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
     g_free(name);
 }
 
-void ppc_cpu_list(void)
+static void ppc_cpu_list(void)
 {
     GSList *list;
 
@@ -7525,6 +7525,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
                                        &pcc->parent_phases);
 
     cc->class_by_name = ppc_cpu_class_by_name;
+    cc->list_cpus = ppc_cpu_list;
     cc->mmu_index = ppc_cpu_mmu_index;
     cc->dump_state = ppc_cpu_dump_state;
     cc->set_pc = ppc_cpu_set_pc;
-- 
2.47.1


