Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8A0D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 13:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSyA7-0000Mt-5e; Tue, 09 Dec 2025 08:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vSy9X-00007h-F4
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:53:21 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vSy9U-0002cH-C7
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=OsDi9MONRBDk+VTZpzbFMd5rjuhEpKkEACjoOpl9hdw=; b=I01CPQehsW6CVXm
 DpP1zhl9l6z2/R9plCdtSXYJH3kjEBM3A0J8ljqODozjvq0U49U0jiVQQhJo6KRIXgQ2nGxiRgDLh
 aVcNJRBWWbMK13gljnvQJ2BmDIRZHfWyLMMJLcR41Yujj5yzAbXRK70hl30GZYEGQNHScde9n7YnH
 mw=;
Date: Tue, 09 Dec 2025 14:56:02 +0100
Subject: [PATCH 1/7] target/alpha: Introduce alpha_phys_addr_space_bits()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-phys_addr-v1-1-c387f3e72d77@rev.ng>
References: <20251209-phys_addr-v1-0-c387f3e72d77@rev.ng>
In-Reply-To: <20251209-phys_addr-v1-0-c387f3e72d77@rev.ng>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
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

In preparation for dropping TARGET_PHYS_ADDR_SPACE_BITS, add a
a runtime function to correctly represent the size of the physical
address space for EV4-6 based on the current CPU version.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 linux-user/alpha/target_proc.h |  2 +-
 target/alpha/cpu.h             |  1 +
 target/alpha/helper.c          | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/linux-user/alpha/target_proc.h b/linux-user/alpha/target_proc.h
index da437ee0e5..bcdd1e343c 100644
--- a/linux-user/alpha/target_proc.h
+++ b/linux-user/alpha/target_proc.h
@@ -57,7 +57,7 @@ static int open_cpuinfo(CPUArchState *cpu_env, int fd)
             "L1 Dcache\t\t: n/a\n"
             "L2 cache\t\t: n/a\n"
             "L3 cache\t\t: n/a\n",
-            model, TARGET_PAGE_SIZE, TARGET_PHYS_ADDR_SPACE_BITS,
+            model, TARGET_PAGE_SIZE, alpha_phys_addr_space_bits(cpu_env),
             max_cpus, num_cpus, cpu_mask);
 
     return 0;
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 45944e46b5..9ee8d93b72 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -286,6 +286,7 @@ bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr alpha_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 #endif /* !CONFIG_USER_ONLY */
 void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
+uint8_t alpha_phys_addr_space_bits(CPUAlphaState *env);
 int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int alpha_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index a9af52a928..0f0cf73bf3 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -523,6 +523,24 @@ void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, "\n");
 }
 
+uint8_t alpha_phys_addr_space_bits(CPUAlphaState *env)
+{
+    switch (env->implver) {
+    case IMPLVER_2106x:
+        /* EV4 */
+        return 34;
+    case IMPLVER_21164:
+        /* EV5 */
+        return 40;
+    case IMPLVER_21264:
+    case IMPLVER_21364:
+        /* EV6 and EV7*/
+        return 44;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /* This should only be called from translate, via gen_excp.
    We expect that ENV->PC has already been updated.  */
 G_NORETURN void helper_excp(CPUAlphaState *env, int excp, int error)

-- 
2.51.0


