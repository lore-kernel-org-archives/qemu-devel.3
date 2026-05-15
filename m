Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72157CD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 18:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNwqw-0007Vf-1v; Fri, 15 May 2026 14:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wNwqT-0007L9-MP
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:01:11 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wNwqM-0001NS-6I
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=5uGCKRizuF6l7LxAwqK0QO7itvAVrH8fAMWTkKtgsGY=; b=oWEFYCd0wLbnvEe
 NsoEInjGUMmmujsbvM6Kz02xLi7cwmuaV0jQoioG110txgL8DHVNeGr1UQYGhKfqkE0qjg2grOpmQ
 T/kqOjCdwvIa9eTmW4WATXvySo1btmfrWBIdhRpo4mpZl2p5gGXTH5gidM60SGkV93ADlVMKfKNj5
 EU=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v6 18/27] target/riscv: Replace target_ulong in
 riscv_cpu_get_trap_name()
Date: Fri, 15 May 2026 20:04:28 +0200
Message-ID: <20260515180437.23620-19-anjo@rev.ng>
In-Reply-To: <20260515180437.23620-1-anjo@rev.ng>
References: <20260515180437.23620-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fix cause argument to 64 bit to match env->mcause.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 2 +-
 target/riscv/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2787bc0386..becf594fc7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -601,7 +601,7 @@ extern const char * const riscv_int_regnamesh[];
 extern const char * const riscv_fpr_regnames[];
 extern const char * const riscv_rvv_regnames[];
 
-const char *riscv_cpu_get_trap_name(target_ulong cause, bool async);
+const char *riscv_cpu_get_trap_name(uint64_t cause, bool async);
 int riscv_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, DumpState *s);
 int riscv_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d7219edd87..4cff10b0d3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -370,7 +370,7 @@ static const char * const riscv_intr_names[] = {
     [IRQ_PMU_OVF] = "counter_overflow",
 };
 
-const char *riscv_cpu_get_trap_name(target_ulong cause, bool async)
+const char *riscv_cpu_get_trap_name(uint64_t cause, bool async)
 {
     if (async) {
         if ((cause < ARRAY_SIZE(riscv_intr_names)) && riscv_intr_names[cause]) {
-- 
2.52.0


