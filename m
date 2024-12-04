Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC94EE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvyr-0002RH-ER; Wed, 04 Dec 2024 15:28:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvyi-000298-1Q
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:28:08 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvyf-0002GV-0Z
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:28:07 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4349cc45219so1875115e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733344083; x=1733948883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9QewNS2KrXYFKBtSPrML3uVF3WnArNvnPbDN/XKhdgc=;
 b=zkLXT/c64uMGH6KoQQilbT/8TWzf8HL2stHfoI6fw/h/gWz/rbUOn79145ycxguHxg
 tzx0cH5x/CB+IEioYHkwGk1WN9mkIof1DS3n7NfBAbRPdGo4qZavZWmbo+cypYh+cLIo
 woGq8GmOB+1v2y6UOKu6QgEz3KiYvF6W8re13R8EmwbB4dTsLuJJ8e9stlfpFilxBg8C
 Oqn2Lae3nQ92+WaBuRkitAj7m8orJBvUW+OZvd4gsZBtuQOFJgtitYU2JsXfZC6BrpKh
 xtmGCYJoRbU/nJy8XPCtNaiW/alvumlyZa222Pv5aGhmECLQGiaPC5ux5I89VD4HXAbu
 s2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733344083; x=1733948883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9QewNS2KrXYFKBtSPrML3uVF3WnArNvnPbDN/XKhdgc=;
 b=SIWegflf4qjc+rBvL7AKEo8gw87YWyQZB4TV0Fq/L8EI5jA7+hFs9sY3h4JX2uSBtL
 2fTFxW4hLagX6kqeBaqe7bkzxr1jdtUiW6DMDmmbyOd32n9BqJRtpqYmBt9mSQkP5aFe
 ci6L6rGOJaWwyLaQJlq2HOuhGAkhfRyQMtvVQyRbbBreCsebLsrzNo0touPwZP7Oedik
 zAqHRxePvuztluKDRh2+c5Jv8CwaBVmkoOenKEAMOXt7qTOa04q3vF2Z2pKAZHb1GiB2
 b0ccMENF7mQRIJd6DZlOUVw7Fo9hSsbSe06FilXbLX2dunrMBNNWG/BhWz0Q/KTMe79a
 7O0Q==
X-Gm-Message-State: AOJu0YzcDiHHx9IIi+fLUhVxDeCAyxVbAftXTsV5n4KtCszwst4WVEh0
 Z34jer3k84JUXbkSJ8NL91eHYdv0MvzknvPdcBmGG4qzk1zdaCQchzJrro1hs/DDwPr9471DomB
 7
X-Gm-Gg: ASbGncsyYCw+sxTJuGVWWefq3QDM1I9lJIxM0b+gt+WQbfWx5tqok/VEflzfgQE3+Sc
 MNBvvGkXfb8YofCfLi4/4vlcEnh63RAwJX8w9cJroeIcnMrWSXWTx2SFHPIEksIvGkvT69v7SdI
 iTMsxjbyrAhxJHK2aTDEeULINZ2q/Nr+mk9RSMI22Is3buXiTFoRKMKLSklj0t/IwE7oLkAnfX1
 +ngtU7JLNlJf9KWFve5ZyMbNudyh1iMbU8SOeSfuW4+l1aHly1LoUyjWMcgeow0eXIwkARhlRMY
 VOQPUoqzrtjQ5/JYHJupS3/d
X-Google-Smtp-Source: AGHT+IFxlGUUFIyfkFeZ4l8REFf4CCrkxe7SUkymjFY/EOIvnxUeAib+1bgksySbStfCRyrv1tvxHg==
X-Received: by 2002:a05:600c:1ca2:b0:434:ba13:e52b with SMTP id
 5b1f17b1804b1-434d0a14a83mr76478475e9.31.1733344083303; 
 Wed, 04 Dec 2024 12:28:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d526b158sm36718205e9.8.2024.12.04.12.28.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Dec 2024 12:28:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 15/20] target: Implement CPUClass::datapath_is_big_endian
 (big-endian)
Date: Wed,  4 Dec 2024 21:25:57 +0100
Message-ID: <20241204202602.58083-16-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204202602.58083-1-philmd@linaro.org>
References: <20241204202602.58083-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

For all targets which have endianness architecturally
predefined as big endian (built using TARGET_BIG_ENDIAN=y),
their datapath_is_big_endian() handler simply returns %true.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hexagon/cpu.c  | 6 ++++++
 target/hppa/cpu.c     | 6 ++++++
 target/m68k/cpu.c     | 6 ++++++
 target/openrisc/cpu.c | 6 ++++++
 target/s390x/cpu.c    | 6 ++++++
 5 files changed, 30 insertions(+)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 020038fc490..6407ed80c59 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -245,6 +245,11 @@ void hexagon_debug(CPUHexagonState *env)
     hexagon_dump(env, stdout, CPU_DUMP_FPU);
 }
 
+static bool hexagon_cpu_datapath_is_big_endian(CPUState *cs)
+{
+    return true;
+}
+
 static void hexagon_cpu_set_pc(CPUState *cs, vaddr value)
 {
     cpu_env(cs)->gpr[HEX_REG_PC] = value;
@@ -342,6 +347,7 @@ static void hexagon_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = hexagon_cpu_class_by_name;
+    cc->datapath_is_big_endian = hexagon_cpu_datapath_is_big_endian;
     cc->has_work = hexagon_cpu_has_work;
     cc->dump_state = hexagon_dump_state;
     cc->set_pc = hexagon_cpu_set_pc;
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index c38439c1800..8ccd224f2a4 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -203,6 +203,11 @@ static void hppa_cpu_initfn(Object *obj)
     cpu_hppa_put_psw(env, PSW_W);
 }
 
+static bool hppa_cpu_datapath_is_big_endian(CPUState *cs)
+{
+    return true;
+}
+
 static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
 {
     g_autofree char *typename = g_strconcat(cpu_model, "-cpu", NULL);
@@ -245,6 +250,7 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
                                     &acc->parent_realize);
 
     cc->class_by_name = hppa_cpu_class_by_name;
+    cc->datapath_is_big_endian = hppa_cpu_datapath_is_big_endian;
     cc->has_work = hppa_cpu_has_work;
     cc->mmu_index = hppa_cpu_mmu_index;
     cc->dump_state = hppa_cpu_dump_state;
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 5fe335558aa..52f8db41d5a 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -24,6 +24,11 @@
 #include "migration/vmstate.h"
 #include "fpu/softfloat.h"
 
+static bool m68k_cpu_datapath_is_big_endian(CPUState *cs)
+{
+    return true;
+}
+
 static void m68k_cpu_set_pc(CPUState *cs, vaddr value)
 {
     M68kCPU *cpu = M68K_CPU(cs);
@@ -571,6 +576,7 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = m68k_cpu_class_by_name;
+    cc->datapath_is_big_endian = m68k_cpu_datapath_is_big_endian;
     cc->has_work = m68k_cpu_has_work;
     cc->mmu_index = m68k_cpu_mmu_index;
     cc->dump_state = m68k_cpu_dump_state;
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index b96561d1f26..16e39b43ec4 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -25,6 +25,11 @@
 #include "fpu/softfloat-helpers.h"
 #include "tcg/tcg.h"
 
+static bool openrisc_cpu_datapath_is_big_endian(CPUState *cs)
+{
+    return true;
+}
+
 static void openrisc_cpu_set_pc(CPUState *cs, vaddr value)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
@@ -257,6 +262,7 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
                                        &occ->parent_phases);
 
     cc->class_by_name = openrisc_cpu_class_by_name;
+    cc->datapath_is_big_endian = openrisc_cpu_datapath_is_big_endian;
     cc->has_work = openrisc_cpu_has_work;
     cc->mmu_index = openrisc_cpu_mmu_index;
     cc->dump_state = openrisc_cpu_dump_state;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 514c70f3010..eda1e3b286f 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -44,6 +44,11 @@
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
 
+static bool s390_cpu_datapath_is_big_endian(CPUState *cs)
+{
+    return true;
+}
+
 #ifndef CONFIG_USER_ONLY
 static bool is_early_exception_psw(uint64_t mask, uint64_t addr)
 {
@@ -390,6 +395,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = s390_cpu_class_by_name,
+    cc->datapath_is_big_endian = s390_cpu_datapath_is_big_endian;
     cc->has_work = s390_cpu_has_work;
     cc->mmu_index = s390x_cpu_mmu_index;
     cc->dump_state = s390_cpu_dump_state;
-- 
2.45.2


