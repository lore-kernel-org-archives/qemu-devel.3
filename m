Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FA8CD8C88
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWE71-0004NG-4P; Sun, 07 Jun 2026 10:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWE6z-0004Mt-S4
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 10:04:25 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wWE6y-00088C-6n
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 10:04:25 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 551156001D;
 Sun,  7 Jun 2026 14:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD6B1F00893;
 Sun,  7 Jun 2026 14:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780841062;
 bh=RfxlUwNU/48O+8PvYhYcsgantRKLa0A2pRTtbB1enaY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gyJ1sjVf47+a6UHesFQWUc96tB54KHrcEUHMG2rg/9qHFYhgYjDN0+FIhGlyie7fw
 UicBLFluopap1G6/QTGnscVcbOy15p869mC7aeU/7jLTofemKipKoYuxmUH2lY+fqq
 lZ6ZhoWQ0lAJla4xU0RVJ7ladpMtwKbVcHFPZQewq+Qr+XZwsqIqXPAQ4hlBz8OdRz
 OcjsPQBfj+TclXHUB/tm1CnYLo4UZK8hjLAHGw3cxCsgNgiuBXCEpINk8WsKuO9Bfl
 KrenkjFmIgdsuwAuJSIYZc+tcyNL9b4iEzAMo2A9HbkxnBi6VnfnvGtBkDaEcuJrK2
 Qjeai4TGy/aTw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Helge Deller <deller@gmx.de>,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH 10/10] target/xtensa: add cpu_set_fcr/fsr helpers to sync
 fp_status
Date: Sun,  7 Jun 2026 16:03:56 +0200
Message-ID: <20260607140356.10702-11-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607140356.10702-1-deller@kernel.org>
References: <20260607140356.10702-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Matt Turner <mattst88@gmail.com>

Factor FCR→fp_status and FSR→fp_status synchronisation out of the
wur_fpu{2k,}_fcr/wur_fpu_fsr helpers into cpu_set_fcr(), cpu_set_fsr(),
and cpu_get_fsr(). Signal delivery code needs to restore the FP rounding
mode and exception flags without duplicating the flag-mapping tables.

cpu_set_fcr() applies the union mask 0xfffff07f (superset of the
wur_fpu_fcr mask 0x0000007f and the wur_fpu2k_fcr mask 0xfffff07f) so
that FCR bits valid only on fpu2k configs are preserved while MBZ bits
7-11 are always cleared.

v2: Use FloatRoundMode as suggested by Richard.

Signed-off-by: Matt Turner <mattst88@gmail.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/xtensa/cpu.h        |  4 ++++
 target/xtensa/fpu_helper.c | 42 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 75cfeee6e3..442e98bd1b 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -642,6 +642,10 @@ static inline void xtensa_select_static_vectors(CPUXtensaState *env,
 }
 void xtensa_runstall(CPUXtensaState *env, bool runstall);
 
+uint32_t cpu_get_fsr(CPUXtensaState *env);
+void cpu_set_fcr(CPUXtensaState *env, uint32_t v);
+void cpu_set_fsr(CPUXtensaState *env, uint32_t v);
+
 #define XTENSA_OPTION_BIT(opt) (((uint64_t)1) << (opt))
 #define XTENSA_OPTION_ALL (~(uint64_t)0)
 
diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
index 5358060c50..9f1256f677 100644
--- a/target/xtensa/fpu_helper.c
+++ b/target/xtensa/fpu_helper.c
@@ -64,6 +64,48 @@ void xtensa_use_first_nan(CPUXtensaState *env, bool use_first)
                              &env->fp_status);
 }
 
+uint32_t cpu_get_fsr(CPUXtensaState *env)
+{
+    uint32_t flags = 0;
+    int fef = get_float_exception_flags(&env->fp_status);
+    unsigned i;
+
+    for (i = 0; i < ARRAY_SIZE(xtensa_fp_flag_map); ++i) {
+        if (fef & xtensa_fp_flag_map[i].softfloat_fp_flag) {
+            flags |= xtensa_fp_flag_map[i].xtensa_fp_flag;
+        }
+    }
+    return flags << XTENSA_FSR_FLAGS_SHIFT;
+}
+
+void cpu_set_fcr(CPUXtensaState *env, uint32_t v)
+{
+    static const FloatRoundMode rounding_mode[] = {
+        float_round_nearest_even,
+        float_round_to_zero,
+        float_round_up,
+        float_round_down,
+    };
+
+    env->uregs[FCR] = v & 0xfffff07f;
+    set_float_rounding_mode(rounding_mode[v & 3], &env->fp_status);
+}
+
+void cpu_set_fsr(CPUXtensaState *env, uint32_t v)
+{
+    uint32_t flags = v >> XTENSA_FSR_FLAGS_SHIFT;
+    int fef = 0;
+    unsigned i;
+
+    env->uregs[FSR] = v & 0x00000f80;
+    for (i = 0; i < ARRAY_SIZE(xtensa_fp_flag_map); ++i) {
+        if (flags & xtensa_fp_flag_map[i].xtensa_fp_flag) {
+            fef |= xtensa_fp_flag_map[i].softfloat_fp_flag;
+        }
+    }
+    set_float_exception_flags(fef, &env->fp_status);
+}
+
 void HELPER(wur_fpu2k_fcr)(CPUXtensaState *env, uint32_t v)
 {
     static const int rounding_mode[] = {
-- 
2.54.0


