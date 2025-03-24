Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1915C36008
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 18:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twmor-0001DA-9K; Mon, 24 Mar 2025 14:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twmom-00018d-0f
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:46:36 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twmoj-0008PR-72
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:46:35 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso2826619f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742841991; x=1743446791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ly/YvHnQR5l+vw3Qn+fTS65QZTRPeKhV3q8cV3yjXU=;
 b=E87ZpA/ZzOsBvRxL7x9ZfgDYJe6agjxOzxlIjtlkmBXYhNwiHm2dpynszgL4u1ro3M
 m8BrteeEWF5Oly8tRsYSXH1D+Hap5heDYIDT0Cw6anXf9WR36IP36Ir/clHhp/RtLRSI
 JNKz5ksOdSQFcPXGSSlNX6H8QFO52f9DtKlyIDR2kNa0O6Vq+UXOJul54rie4uQoTIJD
 aHaG7xNfu1Jm/fHX4Sw+lJb+xkIC3tcYtrzgLLYdtycUXlhm4IAMuanpi6fb3JlGktct
 mlYoZv8AkuOCg9m4rPDVdjQI2kxpUuvD+D1TGyWJlnm9qw24joK5kgQTpt7ct5xxEBpl
 qfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742841991; x=1743446791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ly/YvHnQR5l+vw3Qn+fTS65QZTRPeKhV3q8cV3yjXU=;
 b=PZ2BeFoyyPJDpiUVJ6xMiMjVkZh5QKpqPTMbZBHkLUbrSN9P/zo4B78k/mP5SRPJjo
 Ee2j6tPzUhzqma4ue1i+MB5ikvKQ1WTv++Za16MUF6QxMM3olOdHLpcIW61nQx7kLZga
 IOQwR8gqMWw3Vm05zMThV9ewWGpBx+zJX6HOI9QEoX3F4OQLQK2VfjlKtGybifmcRrFr
 6W0pd/BqIWlGhCYwRUGRNSqaWqZoKORNwV8PXjOv4H2QTJwO2WMXd2D9XaUoQNM8Dkfw
 SbuAC6+kf53x4sG9SBWjMQiCHwTFFmgCXbRP8L0cp8Cp3g0NgwMepShTvCjc2rZgc0pt
 oq8g==
X-Gm-Message-State: AOJu0YzOyd0UrrvRoit0l1wYiZNlDjLff3T8GjstiGoOOzNE1IW1rK0u
 6Lt1EurBPAePQWb7m2y7Qu4mAxF1YMMBq+KgOrwZuOWxsImU2XDQ+rMLVuXmhQQnA0hNb7vNUCO
 2
X-Gm-Gg: ASbGncvNah7kQAN2r6rloaVMlo6czPCC3WiWhtiYWdAbKpObChwxu7HgaEkHVfOFh6d
 RsSZPePVDP600PPk6iQhkFLLcg1bF+9p7w3sWoQbSED6XncwFC/p3ZugmcE6PTUROzWfHnWMFRo
 NKSQB9eOVPFcILdH6bHMmFJLChzxT3BfUXET4vrG3w9CrtALBqLU8fV5s5dti6Xs9XWuyzBZN67
 /f3yMA05qz28jiUw1KKbnrRxVMoPXidouCjjYHIJRN88l2vyiDRPNHaFk8zAeR4th0hbXJD3cpb
 7IdsG8HgKtGA1UjbaFi3y3FvKMl2QOtOCJV7nMrv0Y0VodYdp7ubttqxN+Svz5/LbGX85VvukZF
 FsUjZ74cwRDj2A8mFM0vhPfSA
X-Google-Smtp-Source: AGHT+IFYWKd6FgbFXFxzOewiySdVEHxkxATUn24kESP57YGlkzzMl0sig0FYAerGph7ZIBNkUAOCPA==
X-Received: by 2002:a05:6000:1a8a:b0:390:f738:246b with SMTP id
 ffacd0b85a97d-3997f8fedc1mr13917192f8f.15.1742841990978; 
 Mon, 24 Mar 2025 11:46:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39abafed528sm8210539f8f.27.2025.03.24.11.46.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Mar 2025 11:46:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 3/7] target/ppc: Register CPUClass:list_cpus
Date: Mon, 24 Mar 2025 19:46:07 +0100
Message-ID: <20250324184611.44031-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250324184611.44031-1-philmd@linaro.org>
References: <20250324184611.44031-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
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
index ed79cc1a6b7..4d7c0619739 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7184,7 +7184,7 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
     g_free(name);
 }
 
-void ppc_cpu_list(void)
+static void ppc_cpu_list(void)
 {
     GSList *list;
 
@@ -7528,6 +7528,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
                                        &pcc->parent_phases);
 
     cc->class_by_name = ppc_cpu_class_by_name;
+    cc->list_cpus = ppc_cpu_list;
     cc->mmu_index = ppc_cpu_mmu_index;
     cc->dump_state = ppc_cpu_dump_state;
     cc->set_pc = ppc_cpu_set_pc;
-- 
2.47.1


