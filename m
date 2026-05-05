Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D350CFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 11:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKDpI-0007KG-Kk; Tue, 05 May 2026 07:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKDpA-0007HL-6R
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:20:24 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKDp7-0005qE-Hf
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:20:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso56002815e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 04:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777980020; x=1778584820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6sMi0kUGzt6eghb/XXUV9xCjggNDxEZ3+ioLqRmvCVE=;
 b=ksx41mhU/NPyMFA4KnzDoqj0naFbgPdBsEaSYqfxLZtvQHWRdgZbbrUnpCk6BHZZLU
 jZLPASyRU+MGV6zp91m8UPyo2vz6K4QGncRI8SFCJW+swBWGIXZhL3Q3716Wpi9YVpyZ
 nwFiWmkw8KOfivgWMZ/nZ+75IfhLehWjXrZA3z4BLapRWqoebd5C8U13NV1Gzags2+FJ
 4gC1neRqsenZECn4Jc2S0tYkBVaOQiZ+uOL1nVmTVwBxcKSCo/90zkZSTL0JSUzfQXj3
 64Oe8BXWV/dt7nLPdVAqvHXvktGfKtaf2a6lyV3kS72h/pQ7ciX5OorHtGvW0AfEn1L3
 OP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777980020; x=1778584820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6sMi0kUGzt6eghb/XXUV9xCjggNDxEZ3+ioLqRmvCVE=;
 b=V0af7YSXUbHFRidowTcFuPpY3ma5neDoMHKRw/xfz2bY24rZ2K5eAGDyE0N1KNACch
 A8yZJm9o2g33iFfnlRLBX1bUkosJi39fQZFu28FGteUPwlk3hvlTE1nRWwQ3koZkWBFb
 N6+SvdilxjcygNUVVNgHZYyZey1vN1RjtiSKf0gTA0Q0MT78lHaEewda5JhPe04shYfs
 MziOY9j5tzRkPuw6jq/ddXxO1HIboYBhVFqpDCi6qWHxdcUskxeAmvWPZiAsaCN+BpjN
 7ldVDBBQHJNk5zDza7yuddYkUxeOwhBS0aEZCholWxuQ107d2/clC0VQrqw88SzJTtX3
 Jxtw==
X-Gm-Message-State: AOJu0YwOTOEhdP2KfNJGWsnv5mzM7JE5jYoJyq6vvNnWR90KDal+Foj5
 uf0Ib3VXWDFpieKgd1imVmsIkImzV3H1SXE+YKDwHwfybPF7rsGZK60QVgFEseytEoM=
X-Gm-Gg: AeBDiesMaxNrAwfVVnt546Hg1cQueZct9mMepC9UtCZFYh7KrwkMM/JY3sa+VTl78Zq
 yAAuIL4uNYlJE5wx1lNY4Xlq4TL01nDCK6HHKLvFAUJ0m4FAUoRnTi2HJA+q7Fd1zXm8Ynd+wqE
 LDR2903oMyuWo1+3ul+C86umpciH7MEN4AnnZpvaqiMFOIYVuPPrM2JPhU3jXI8F9l/AkDBy8Ye
 lgetLCmU5h2A/FtTH1twqb52ShnEgBLH4Pa9TMuAX8OHt3oBVD0pP9T7Eu82gb126gC8AG/Wzze
 5Y4oCwjY28SSZfd5+x9SPEu11MEv6IbSoTcd+uZvk0ni+r7/2hNdyyft36W1N5ylHLvPwVMvnC/
 Uev5BdzMPggz8f0Ih+sMJILjIduWcQ3oDRsyxD8QoBnzWWpHQiiNh+oGdeODmzxkoMSsH6v/ZN+
 fhqIqLZJBRl8K4Ach1jRnItz3Y11cmWyLYxw==
X-Received: by 2002:a05:600c:4ed2:b0:488:a882:c7 with SMTP id
 5b1f17b1804b1-48a98671da2mr235172445e9.25.1777980019858; 
 Tue, 05 May 2026 04:20:19 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb6fffcsm365107245e9.4.2026.05.05.04.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 04:20:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 03C035FB54;
 Tue, 05 May 2026 12:20:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 7/7] target/arm: implement WFET
Date: Tue,  5 May 2026 12:20:13 +0100
Message-ID: <20260505112014.102993-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505112014.102993-1-alex.bennee@linaro.org>
References: <20260505112014.102993-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Now we have the event stream and SEV/SEVL implemented we can finally
enable WFET for Aarch64.

To avoid issues with QEMU's incomplete ldst exclusive handling causing
potential deadlocks in common WFE enabled locking patterns we take
advantage of the architectures flexibility and treat being in the
exclusive region as a reason to exit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - fix exception syndrome by using enum value
  - use env->halt_reason
v3
  - fix check_wfx_trap(s/false/true/) as it is a WFE
v4
  - defer expensive calculations until needed
  - treat cs->exclusive_addr as a IMPDEF WFE exit
  - update commit message
---
 target/arm/tcg/helper-defs.h   |  1 +
 target/arm/tcg/op_helper.c     | 95 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c | 15 +++---
 3 files changed, 104 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index ebdf09be38a..5e4d828dd55 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -56,6 +56,7 @@ DEF_HELPER_1(setend, void, env)
 DEF_HELPER_2(wfi, void, env, i32)
 DEF_HELPER_2(wfe, void, env, i32)
 DEF_HELPER_2(wfit, void, env, i32)
+DEF_HELPER_2(wfet, void, env, i32)
 DEF_HELPER_1(yield, void, env)
 DEF_HELPER_1(pre_hvc, void, env)
 DEF_HELPER_2(pre_smc, void, env, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 1349bcc7929..d8d7557b880 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -640,6 +640,101 @@ void HELPER(wfe)(CPUARMState *env, uint32_t insn_len)
 #endif
 }
 
+void HELPER(wfet)(CPUARMState *env, uint32_t rd)
+{
+#ifdef CONFIG_USER_ONLY
+    /*
+     * As for WFIT make it NOP here, because trying to raise EXCP_HLT
+     * would trigger an abort.
+     */
+    return;
+#else
+    CPUState *cs = env_cpu(env);
+    uint32_t excp;
+    int target_el;
+    ARMCPU *cpu;
+    uint64_t cntval, timeout, offset, cntvct, nexttick;
+    int64_t next_event;
+
+    /*
+     * As for WFE if the event register is already set we can consume
+     * the event and return immediately.
+     */
+    if (env->event_register) {
+        env->event_register = false;
+        return;
+    }
+
+    /*
+     * Don't bother to go into our "low power state" if
+     * we would just wake up immediately.
+     *
+     * We want the value that we would get if we read CNTVCT_EL0 from
+     * the current exception level, so the direct_access offset, not
+     * the indirect_access one. Compare the pseudocode LocalTimeoutEvent(),
+     * which calls VirtualCounterTimer().
+     */
+    cntval = gt_get_countervalue(env);
+    offset = gt_direct_access_timer_offset(env, GTIMER_VIRT);
+    cntvct = cntval - offset;
+    timeout = env->xregs[rd];
+    if (cpu_has_work(cs) || cntvct >= timeout) {
+        return;
+    }
+
+    /* We might sleep, so now we check to see if we should trap */
+    target_el = check_wfx_trap(env, true, &excp);
+    if (target_el) {
+        env->pc -= 4;
+        raise_exception(env, excp, syn_wfx(1, 0xe, rd, true, WFET, false), target_el);
+    }
+
+    /*
+     * If the CPU has entered the exclusive region we could sleep
+     * until the global monitor moves from Exclusive to Open Access.
+     * However it would be expensive for QEMU to fully model the
+     * global monitor and not doing so would potentially trigger
+     * deadlocks in WFE enabled locking code. However as WFE is a hint
+     * instruction the architecture allows for the PE to leave
+     * low-power state for any reason. QEMU chooses to treat being in
+     * an exclusive region as such and return directly.
+     */
+    if (env->exclusive_addr != -1) {
+        return;
+    }
+
+    /*
+     * Finally work out if the timeout or event stream will kick in
+     * earlier.
+     *
+     * The WFET should time out when CNTVCT_EL0 >= the specified value.
+     */
+    cpu = env_archcpu(env);
+    if (uadd64_overflow(timeout, offset, &nexttick)) {
+        nexttick = UINT64_MAX;
+    }
+    if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
+        nexttick = INT64_MAX;
+    }
+
+    next_event = gt_calc_next_event_stream(env);
+    if (next_event > 0 && next_event < nexttick) {
+        timer_mod(cpu->wfxt_timer, next_event);
+    } else {
+        if (nexttick == INT64_MAX) {
+            timer_mod_ns(cpu->wfxt_timer, INT64_MAX);
+        } else {
+            timer_mod(cpu->wfxt_timer, nexttick);
+        }
+    }
+
+    env->halt_reason = HALT_WFE;
+    cs->exception_index = EXCP_HLT;
+    cs->halted = 1;
+    cpu_loop_exit(cs);
+#endif
+}
+
 void HELPER(yield)(CPUARMState *env)
 {
     CPUState *cs = env_cpu(env);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a6f392a28f8..ead2a7ff81f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2086,14 +2086,15 @@ static bool trans_WFET(DisasContext *s, arg_WFET *a)
         return false;
     }
 
-    /*
-     * We rely here on our WFE implementation being a NOP, so we
-     * don't need to do anything different to handle the WFET timeout
-     * from what trans_WFE does.
-     */
-    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
-        s->base.is_jmp = DISAS_WFE;
+    if (s->ss_active) {
+        /* Act like a NOP under architectural singlestep */
+        return true;
     }
+
+    gen_a64_update_pc(s, 4);
+    gen_helper_wfet(tcg_env, tcg_constant_i32(a->rd));
+    /* Go back to the main loop to check for interrupts */
+    s->base.is_jmp = DISAS_EXIT;
     return true;
 }
 
-- 
2.47.3


