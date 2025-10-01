Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAF2CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rJh-0005vG-IV; Wed, 01 Oct 2025 03:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rJc-0005qo-Pf
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:31:56 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rJ9-0003Zq-91
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=JRkbdPiP3dpnkZ74mZxcDs2fSC6lavTjIReGJbOf02g=; b=IdHNiMVm52Z16ph
 rv7vZB0iFLXh4vad5zRAxMK7FWSVY3MF9J3/USe3dHHLiUnyC+f+Sw9SNWr4I8KWJOt9Sld0+3a4k
 o2Hyi+L7QpvR1MAacfNX9u9ZOgXH1/9ku+aH0IKklC6W8tNt0ONPlIP9Eh9ObqIRFT4+3Ko2NmK5X
 SM=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org,
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Subject: [PATCH v2 26/33] target/riscv: Replace target_ulong in
 riscv_cpu_get_trap_name()
Date: Wed,  1 Oct 2025 09:32:59 +0200
Message-ID: <20251001073306.28573-27-anjo@rev.ng>
In-Reply-To: <20251001073306.28573-1-anjo@rev.ng>
References: <20251001073306.28573-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fix cause argument to 64 bit to match env->mcause.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h | 2 +-
 target/riscv/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d264c87e32..c1fbb67b08 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -593,7 +593,7 @@ extern const char * const riscv_int_regnames[];
 extern const char * const riscv_int_regnamesh[];
 extern const char * const riscv_fpr_regnames[];
 
-const char *riscv_cpu_get_trap_name(target_ulong cause, bool async);
+const char *riscv_cpu_get_trap_name(uint64_t cause, bool async);
 int riscv_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, DumpState *s);
 int riscv_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4e38487dca..5206abe640 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -348,7 +348,7 @@ static const char * const riscv_intr_names[] = {
     "reserved"
 };
 
-const char *riscv_cpu_get_trap_name(target_ulong cause, bool async)
+const char *riscv_cpu_get_trap_name(uint64_t cause, bool async)
 {
     if (async) {
         return (cause < ARRAY_SIZE(riscv_intr_names)) ?
-- 
2.51.0


