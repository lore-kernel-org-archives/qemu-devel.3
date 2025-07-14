Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8C6C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMWb-0000bh-9K; Mon, 14 Jul 2025 12:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1ubLcw-0005Za-Lv
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:02:09 -0400
Received: from out-184.mta0.migadu.com ([2001:41d0:1004:224b::b8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1ubLcu-0008PU-1W
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:02:02 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1752508917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tJ1ERHb+C6dy+EReHjSkSbsrkf3SXklGrJ5X9wyIe+s=;
 b=uQrlo3bE8U3DUBsvmVxpCTM+Lrv7GgGOmvXMNqf+oDWGIiBJygGHrUCeUs6zVSnzoa97lJ
 JW+omqcb9nIaEK1PPcgzZmVirc8KvuaUIZrSHxjO7JYsTCdzMQXxwK4bBADhVQybcMFREz
 vitSmjPv9gno/nHpedNb4//W3+Fw/8Y=
From: Zenghui Yu <zenghui.yu@linux.dev>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: agraf@csgraf.de, mads@ynddal.dk, peter.maydell@linaro.org,
 Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH v2 1/2] hvf: arm: Add permission check in GIC sysreg handlers
Date: Tue, 15 Jul 2025 00:01:38 +0800
Message-Id: <20250714160139.10404-2-zenghui.yu@linux.dev>
In-Reply-To: <20250714160139.10404-1-zenghui.yu@linux.dev>
References: <20250714160139.10404-1-zenghui.yu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::b8;
 envelope-from=zenghui.yu@linux.dev; helo=out-184.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Quoting Peter Maydell:

" hvf_sysreg_read_cp() and hvf_sysreg_write_cp() do not check the .access
  field of the ARMCPRegInfo to ensure that they forbid writes to registers
  that are marked with a .access field that says they're read-only (and
  ditto reads to write-only registers). "

Before we add more registers in GIC sysreg handlers, let's get it correct
by adding the .access checks to hvf_sysreg_read_cp() and
hvf_sysreg_write_cp(). With that, a sysreg access with invalid permission
will result in an UNDEFINED exception.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
---

I hard-code the @current_el parameter of cp_access_ok() to 1 because

* we only support EL0 and EL1 in HVF, and
* a GIC sysreg access from EL0 would result in an UNDEF exception which is
  taken to EL1 (without going back to QEMU for emulation).

 target/arm/hvf/hvf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0c7396ad6f..1db0b77fb6 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1270,6 +1270,9 @@ static bool hvf_sysreg_read_cp(CPUState *cpu, uint32_t reg, uint64_t *val)
 
     ri = get_arm_cp_reginfo(arm_cpu->cp_regs, hvf_reg2cp_reg(reg));
     if (ri) {
+        if (!cp_access_ok(1, ri, true)) {
+            return false;
+        }
         if (ri->accessfn) {
             if (ri->accessfn(env, ri, true) != CP_ACCESS_OK) {
                 return false;
@@ -1550,6 +1553,9 @@ static bool hvf_sysreg_write_cp(CPUState *cpu, uint32_t reg, uint64_t val)
     ri = get_arm_cp_reginfo(arm_cpu->cp_regs, hvf_reg2cp_reg(reg));
 
     if (ri) {
+        if (!cp_access_ok(1, ri, false)) {
+            return false;
+        }
         if (ri->accessfn) {
             if (ri->accessfn(env, ri, false) != CP_ACCESS_OK) {
                 return false;
-- 
2.34.1


