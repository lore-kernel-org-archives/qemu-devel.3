Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C05FCD6E6B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVPqx-0006R5-TC; Fri, 05 Jun 2026 04:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wVPqv-0006Q9-Nj
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:24:29 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wVPqs-0004ge-J3
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:24:29 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8CxHuq2hyJqlOMQAA--.45503S3;
 Fri, 05 Jun 2026 16:24:22 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJCxvsKuhyJqnLucAA--.34744S3;
 Fri, 05 Jun 2026 16:24:21 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v3 01/14] target/loongarch: Add new field curState in
 CPULoongArchState
Date: Fri,  5 Jun 2026 16:25:39 +0800
Message-ID: <20260605082552.175336-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605082552.175336-1-maobibo@loongson.cn>
References: <20260605082552.175336-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxvsKuhyJqnLucAA--.34744S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF1kGFW7KFW5Gw48Ww48uFX_yoW8ZFyUpr
 ZrZa4jgFWUGFZrC3Z3A3s0gFnxXr1xG342gay2934vkF45Xw15W3Z5X39FyF4DJ3yruF1I
 q3W0yw45WFW7XacCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
 AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
 6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
 KfnxnUUI43ZEXa7IU8EeHDUUUUU==
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

New field sys_state is added in structure CPULoongArchState, it points
to CPULoongArchState itself now.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
---
 target/loongarch/cpu.c |  2 ++
 target/loongarch/cpu.h | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 8f277f7696..13de1722de 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -278,6 +278,7 @@ static void loongarch_la464_initfn(Object *obj)
     uint32_t data = 0, field;
     int i;
 
+    set_sys_state(env, env);
     for (i = 0; i < 21; i++) {
         env->cpucfg[i] = 0x0;
     }
@@ -406,6 +407,7 @@ static void loongarch_la132_initfn(Object *obj)
     uint32_t data = 0;
     int i;
 
+    set_sys_state(env, env);
     for (i = 0; i < 21; i++) {
         env->cpucfg[i] = 0x0;
     }
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 096d778928..b087548295 100644
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
+    CPUSysState *sys_state;
 } CPULoongArchState;
 
 typedef struct LoongArchCPUTopo {
@@ -481,6 +484,16 @@ struct LoongArchCPUClass {
 #define MMU_USER_IDX     MMU_PLV_USER
 #define MMU_DA_IDX       4
 
+static inline CPUSysState *env_sys(CPULoongArchState *env)
+{
+    return env->sys_state;
+}
+
+static inline void set_sys_state(CPULoongArchState *env, CPUSysState *sys)
+{
+    env->sys_state = sys;
+}
+
 static inline bool is_la64(CPULoongArchState *env)
 {
     return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64;
-- 
2.54.0


