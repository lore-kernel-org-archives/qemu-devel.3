Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA118C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTkQw-0000sh-EO; Mon, 23 Jun 2025 12:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1uTkQu-0000rB-8d
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:54:12 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1uTkQs-0008Bp-5C
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:54:12 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-453442d3a15so2144015e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 09:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1750697648; x=1751302448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FIb9TYrVuPtuI9Bb5j8ylfTFm18U5O3mg4bYirShZKU=;
 b=nUIulfhJgfka4Q5NYf90ZhJ0RJENu5v7yo8T/dWdPQtu+SONRYNAIiE6MWvbFL2UDu
 iHIGLurW3mZjMFqyIIWqp9ffqtbNbjyUZHK/ijUiZOrPJAuF8XFSs6hDMVtnfviX9iVx
 5IetoHOhPOp8ibIp0eDTvxKU124bEFnpjmRQ31gOhncZP/6a/qz0MAYOaIir/sx5zGyU
 AlyDCrYveNOdA/w9pKqoPxd1abwVI+5ORVpTpGh4nF8+/4NaGDEzSoh6cTu7YKVtxRtz
 AaraUwlix57edf1IQY10izcqMrxZVkUUiPrzWDW3eYtwq329j5OCyL3kT+xr3l+sltk4
 q8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750697648; x=1751302448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FIb9TYrVuPtuI9Bb5j8ylfTFm18U5O3mg4bYirShZKU=;
 b=pcWKa+ZHyp8VI2V2pBjVnAkcdRbkLYCsoTmqceXUf1Jp8e8Kgc+JvSKxFXvy9xf0oR
 0ir0TawpRgpggF/dNZc0ZjRGzy5b2Ra3iTBrREIkgSQXnO6vHrAPok6pzW8kle63+u7K
 pZW7hesTVM4kDyEtQSSmKWpj9+YlhSd5n+GndQ0VtXDuScyvzENY0BGUlqrj8hE4Mjy5
 NW1lE6CLgeiRBmItX67dQwTbXBYCi7QpvtoujhLhbKSFH0xcFZ2IrYv36uPwP098Okdp
 XdzXBrvSHhtTaaYsVtIdIAERY/z2Gp5oVDdWVKzA5uRD2TKt8nhIVZeqUdCYsf7AG32y
 8beg==
X-Gm-Message-State: AOJu0YxdecoT80y8dNfnSd6hNaHq/2FkBRncSfDYYH16OsRotjSMqW2p
 +OCkx0Wl+EW6mdZbp/7y8CXAPTIQSmrT6gruBkYQs6HBaWnBFY7/9tBDO6o26wD0yCA=
X-Gm-Gg: ASbGncs6s0Q4oscrhKnNE6JZD7kwJhlMgHNScp+rqC9wuto/3lqZ3JZ919pfV1wXJgR
 RJ1PaLXlVkQwy/vD2EqfeMqsz12J1CNGuZMnkqc2qssaL3IPUi2x3XGeO0+86qA+wHHlvg0U4+s
 NoRevxjn4YATNceocl6gMpTtpumKnnuiCvQf+80DK63nUj05CTJ5uXbyWivNPUoQ2aVxLBHLLPI
 +B9YCzADyBetYYuiptDkCnsZjEiMtj/KqhEcTKZviK5G7ZjyMxhkF24h0hZtwBI98d9SbPB0mm4
 jM4q1saFE0FswTvZMaSxtw3aLD6snvExeNfAMe5ffTGpHKFLubFsQRhwopI3oBYKng8=
X-Google-Smtp-Source: AGHT+IGqUaxtjYlSHer0MjB31iX+H9Al6TIvqCBfxG2Y+JR5KRhjG9937p5Xaoqw/Aa1phJzSOsJfQ==
X-Received: by 2002:a05:600c:6989:b0:43d:fa58:81d2 with SMTP id
 5b1f17b1804b1-453659b60b2mr49592085e9.9.1750697648361; 
 Mon, 23 Jun 2025 09:54:08 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:8947:973b:de:93b7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453755e7d1dsm33747445e9.10.2025.06.23.09.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 09:54:08 -0700 (PDT)
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Atish Patra <atishp@rivosinc.com>
Subject: [PATCH 1/2] target/riscv: disable *stimecmp interrupts without
 *envcfg.STCE
Date: Mon, 23 Jun 2025 18:53:28 +0200
Message-ID: <20250623165329.2759651-2-rkrcmar@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623165329.2759651-1-rkrcmar@ventanamicro.com>
References: <20250623165329.2759651-1-rkrcmar@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=rkrcmar@ventanamicro.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The specification states that menvcfg.STCE=0 prevents both *stimecmp
CSRs from having an effect on the pending interrupts.
henvcfg.STCE=0 disables only vstimecmp.

Make sure that when *envcfg.STCE is not set:
* writing the *stimecmp CSRs doesn't modify the *ip CSRs,
* and that the interrupt timer is disarmed.

Call the *stimecmp CSR update functions when *envcfg.STCE is toggled,
because the *ip CSRs need to immediately reflect the new behavior.

Fixes: 43888c2f1823 ("target/riscv: Add stimecmp support")
Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
---
 target/riscv/csr.c         | 12 ++++++++++++
 target/riscv/time_helper.c | 10 ++++++++++
 2 files changed, 22 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index fb149721691d..43eae9bcf153 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3181,6 +3181,7 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
                     MENVCFG_CBZE | MENVCFG_CDE;
+    typeof(env->menvcfg) old = env->menvcfg;
 
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
@@ -3208,6 +3209,11 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
         }
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
+
+    if ((old ^ env->menvcfg) & MENVCFG_STCE) {
+        riscv_timer_write_timecmp(env, env->stimer, env->stimecmp, 0, MIP_STIP);
+    }
+
     return write_henvcfg(env, CSR_HENVCFG, env->henvcfg, ra);
 }
 
@@ -3314,6 +3320,7 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val, uintptr_t ra)
 {
     uint64_t mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
+    typeof(env->henvcfg) old = env->henvcfg;
     RISCVException ret;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
@@ -3347,6 +3354,11 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
         env->vsstatus &= ~MSTATUS_SDT;
     }
 
+    if ((old ^ env->henvcfg) & HENVCFG_STCE) {
+        riscv_timer_write_timecmp(env, env->vstimer, env->vstimecmp,
+                                  env->htimedelta, MIP_VSTIP);
+    }
+
     return RISCV_EXCP_NONE;
 }
 
diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index bc0d9a0c4c35..8198a2d8d92d 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -49,6 +49,16 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
     uint32_t timebase_freq = mtimer->timebase_freq;
     uint64_t rtc_r = env->rdtime_fn(env->rdtime_fn_arg) + delta;
 
+    /*
+     * *envcfg.STCE disables *stimecmp interrupts, but still allows higher
+     * privileges to write the *stimecmp CSRs.
+     */
+    if (!get_field(env->menvcfg, MENVCFG_STCE) ||
+        (timer_irq == MIP_VSTIP && !get_field(env->henvcfg, HENVCFG_STCE))) {
+        timer_del(timer);
+        return;
+    }
+
     if (timecmp <= rtc_r) {
         /*
          * If we're setting an stimecmp value in the "past",
-- 
2.49.0


