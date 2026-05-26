Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07631CD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 06:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRlcy-0002JF-Jd; Tue, 26 May 2026 02:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wRlca-0002Fq-Hn
 for qemu-devel@nongnu.org; Tue, 26 May 2026 02:50:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wRlcV-0000ZA-Kn
 for qemu-devel@nongnu.org; Tue, 26 May 2026 02:50:36 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxQ_CyQhVqT0wNAA--.37994S3;
 Tue, 26 May 2026 14:50:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBx68GwQhVqMF6RAA--.10913S3;
 Tue, 26 May 2026 14:50:25 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH 01/12] target/loongarch: Add new field curState in
 CPULoongArchState
Date: Tue, 26 May 2026 14:50:12 +0800
Message-Id: <20260526065023.1639371-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260526065023.1639371-1-maobibo@loongson.cn>
References: <20260526065023.1639371-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBx68GwQhVqMF6RAA--.10913S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

New field curState is added in structure CPULoongArchState, it points
to CPULoongArchState itself now.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c |  2 ++
 target/loongarch/cpu.h | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 8f277f7696..693ce30b60 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -278,6 +278,7 @@ static void loongarch_la464_initfn(Object *obj)
     uint32_t data = 0, field;
     int i;
 
+    set_current_state(env, env);
     for (i = 0; i < 21; i++) {
         env->cpucfg[i] = 0x0;
     }
@@ -406,6 +407,7 @@ static void loongarch_la132_initfn(Object *obj)
     uint32_t data = 0;
     int i;
 
+    set_current_state(env, env);
     for (i = 0; i < 21; i++) {
         env->cpucfg[i] = 0x0;
     }
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 096d778928..e738923049 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -317,6 +317,8 @@ typedef struct  LoongArchBT {
 #define CPU_VENDOR_LOONGSON   "Loongson"
 #define CPU_MODEL_3A5000      "3A5000"
 #define CPU_MODEL_1C101       "1C101"
+struct CPUArchState;
+typedef struct CPUArchState CPUSysState;
 
 typedef struct CPUArchState {
     uint64_t gpr[32];
@@ -415,6 +417,7 @@ typedef struct CPUArchState {
     AddressSpace *address_space_iocsr;
     uint32_t mp_state;
 #endif
+    CPUSysState *curState;
 } CPULoongArchState;
 
 typedef struct LoongArchCPUTopo {
@@ -481,6 +484,16 @@ struct LoongArchCPUClass {
 #define MMU_USER_IDX     MMU_PLV_USER
 #define MMU_DA_IDX       4
 
+static inline CPUSysState *get_current_state(CPULoongArchState *env)
+{
+    return env->curState;
+}
+
+static inline void set_current_state(CPULoongArchState *env, CPUSysState *cur)
+{
+    env->curState = cur;
+}
+
 static inline bool is_la64(CPULoongArchState *env)
 {
     return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64;
-- 
2.39.3


