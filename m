Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95A6C83F17
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Jul 2025 15:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaywW-0007Qe-7r; Sun, 13 Jul 2025 11:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1uayvZ-0006wx-PR
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 11:47:48 -0400
Received: from out-174.mta1.migadu.com ([95.215.58.174])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1uayvX-00043e-Mj
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 11:47:45 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1752421651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=g++ulRUN4C55mZbS9xGwxQzv13dC9+1jGquJ51cFtp4=;
 b=HBY8LOIXBNrAtAw/C7HR0NBD3k5GkK6m5n3idLoL+ad5guYlhByJrcv6q3fDECaDWGzxBE
 EZn2dyunxdrnR35TgzQnh0OGvPz7smwGzHeUb+zlZc/gC3dWQqCAHBEdRA30c3HfuT8K8m
 EywVuySSu8CfiHYQ2pHw70LHerwlrv4=
From: Zenghui Yu <zenghui.yu@linux.dev>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: agraf@csgraf.de, mads@ynddal.dk, peter.maydell@linaro.org,
 Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH] hvf: arm: Remove $pc from trace_hvf_data_abort()
Date: Sun, 13 Jul 2025 23:47:19 +0800
Message-Id: <20250713154719.4248-1-zenghui.yu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.174; envelope-from=zenghui.yu@linux.dev;
 helo=out-174.mta1.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

We don't synchronize vcpu registers from the hardware accelerator (e.g., by
cpu_synchronize_state()) in the Dabort handler, so env->pc points to the
instruction which has nothing to do with the Dabort at all.

And it doesn't seem to make much sense to log PC in every Dabort handler,
let's just remove it from this trace event.

Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
---
 target/arm/hvf/hvf.c        | 2 +-
 target/arm/hvf/trace-events | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index c9cfcdc08b..8f93e42b34 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2005,7 +2005,7 @@ int hvf_vcpu_exec(CPUState *cpu)
         uint32_t cm = (syndrome >> 8) & 0x1;
         uint64_t val = 0;
 
-        trace_hvf_data_abort(env->pc, hvf_exit->exception.virtual_address,
+        trace_hvf_data_abort(hvf_exit->exception.virtual_address,
                              hvf_exit->exception.physical_address, isv,
                              iswrite, s1ptw, len, srt);
 
diff --git a/target/arm/hvf/trace-events b/target/arm/hvf/trace-events
index b49746f28d..b29a995f3d 100644
--- a/target/arm/hvf/trace-events
+++ b/target/arm/hvf/trace-events
@@ -2,7 +2,7 @@ hvf_unhandled_sysreg_read(uint64_t pc, uint32_t reg, uint32_t op0, uint32_t op1,
 hvf_unhandled_sysreg_write(uint64_t pc, uint32_t reg, uint32_t op0, uint32_t op1, uint32_t crn, uint32_t crm, uint32_t op2) "unhandled sysreg write at pc=0x%"PRIx64": 0x%08x (op0=%d op1=%d crn=%d crm=%d op2=%d)"
 hvf_inject_fiq(void) "injecting FIQ"
 hvf_inject_irq(void) "injecting IRQ"
-hvf_data_abort(uint64_t pc, uint64_t va, uint64_t pa, bool isv, bool iswrite, bool s1ptw, uint32_t len, uint32_t srt) "data abort: [pc=0x%"PRIx64" va=0x%016"PRIx64" pa=0x%016"PRIx64" isv=%d iswrite=%d s1ptw=%d len=%d srt=%d]"
+hvf_data_abort(uint64_t va, uint64_t pa, bool isv, bool iswrite, bool s1ptw, uint32_t len, uint32_t srt) "data abort: [va=0x%016"PRIx64" pa=0x%016"PRIx64" isv=%d iswrite=%d s1ptw=%d len=%d srt=%d]"
 hvf_sysreg_read(uint32_t reg, uint32_t op0, uint32_t op1, uint32_t crn, uint32_t crm, uint32_t op2, uint64_t val) "sysreg read 0x%08x (op0=%d op1=%d crn=%d crm=%d op2=%d) = 0x%016"PRIx64
 hvf_sysreg_write(uint32_t reg, uint32_t op0, uint32_t op1, uint32_t crn, uint32_t crm, uint32_t op2, uint64_t val) "sysreg write 0x%08x (op0=%d op1=%d crn=%d crm=%d op2=%d, val=0x%016"PRIx64")"
 hvf_unknown_hvc(uint64_t pc, uint64_t x0) "pc=0x%"PRIx64" unknown HVC! 0x%016"PRIx64
-- 
2.34.1


