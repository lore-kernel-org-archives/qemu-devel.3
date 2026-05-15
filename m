Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689CFCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 18:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNwr6-0007k4-MU; Fri, 15 May 2026 14:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wNwqb-0007N1-Hv
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:01:21 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wNwqR-0001Rj-Gc
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=N1yXJpxnPJMPpRQ98LN0wif1tMcF3VH9jRzQY+9p8a0=; b=hNIRVIIfocyXxZY
 DLtkjY1VhGWtcWXsRQhb/C56zOrL7y4Q+FPwn06rm55HWjrjGL7qoBOVQBOgEhKVyLbubAPIDnGm6
 N59eyqJWgnlPqJe3YkiY5NCyaSqT3mPEvbqrfClNhdTh3yO/AVZy6v94nk00990+LQ00RroRH2/Re
 wY=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v6 26/27] target/riscv: Pass address as uint64_t in
 cpu_set_exception_base()
Date: Fri, 15 May 2026 20:04:36 +0200
Message-ID: <20260515180437.23620-27-anjo@rev.ng>
In-Reply-To: <20260515180437.23620-1-anjo@rev.ng>
References: <20260515180437.23620-1-anjo@rev.ng>
MIME-Version: 1.0
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

The corresponding field CPUArchState::resetvec is uint64_t anyway, no
need to use target_ulong.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h | 2 +-
 target/riscv/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3352409676..ad5d23ee6b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -679,7 +679,7 @@ uint8_t riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, uint8_t);
 
 #ifndef CONFIG_USER_ONLY
-void cpu_set_exception_base(int vp_index, target_ulong address);
+void cpu_set_exception_base(int vp_index, uint64_t address);
 #endif
 
 FIELD(TB_FLAGS, MEM_IDX, 0, 3)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index daad317381..753f92307f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -79,7 +79,7 @@ bool riscv_cpu_option_set(const char *optname)
 
 #ifndef CONFIG_USER_ONLY
 /* This is used in runtime only. */
-void cpu_set_exception_base(int vp_index, target_ulong address)
+void cpu_set_exception_base(int vp_index, uint64_t address)
 {
     RISCVCPU *cpu;
     CPUState *cs = qemu_get_cpu(vp_index);
-- 
2.52.0


