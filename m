Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A14C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwogd-0003IB-IK; Tue, 16 Apr 2024 15:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rwogb-0003HV-Gq
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:41:45 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rwogZ-00044u-35
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:41:44 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e3c9300c65so41655945ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 12:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713296501; x=1713901301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ssIuZaHoHfxGkU2ooOzNE6RgtnB9PZD34dZd+Oj8vXc=;
 b=pKIpe4hQb+qM27AKuCvcj/dUM4X+N2y4W2IIXltgWxMO76PrdPBDmBH5swU2d5FmUz
 wz4q8uLf37S+dqIoYBnoiLXaH0TWRkELNSVrw1+2tNZ/b4OGDrGTOuNOpuYti6EXkPGz
 a9kIW084h9hY+joDf9epYx67XL3dUv3BK+TmzFqe0hxXrGSJL2a8QXerkrdUo3icsFP9
 VDFsGx+M95WQKDVBj+bHGNjgbbui4VqWHLrCNoTjNCfDkDUpjwu7vY0M/KU/8A0R3w9Y
 xQ1rTadfSs2yQGU62ja/Z+rHjEJ6tCmm3a+4ZnP4oRE3q/SAa8EkP/9FkpCFxsKIezkj
 gCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713296501; x=1713901301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ssIuZaHoHfxGkU2ooOzNE6RgtnB9PZD34dZd+Oj8vXc=;
 b=wQJpqGQhe7SmrGaCa1k+dnq6nlLl7Q8n4zAYlwfgtIuV9I5C7sxkPdFSAfNKeMnVW0
 gy7eFEwz6XhpXwjr1IuGEBjsY09GHoqb/i+OjIhm3d2rZj0KPY8V2o/7wmWzZdJX47wc
 kl+MyMEMVmS0nNWG9yB9n/dkKzGLqYMsuD1a3sm26QQLRdpVUXuJQiv1h+QuO3jcBtD2
 mKBAEhjmIkARq4pSUUfuzY0GdKy6WJv1cG43Ra/b9WQtR0Zj8VZ3nlQKJpKSepA4usC4
 XAzuCYFFeW4nb8510JqPz1erLZcIJ2St68BTq4ZkOH1ION5inXVe7u8EUCVZa8cPjOaE
 3a6A==
X-Gm-Message-State: AOJu0YzVCA0WtcYhiJuVvG9dkpMzmZ59q02aWntq4kcrwyg6d2y5pJ0j
 vwATNVrO4p9yiMW828tU1lTnIMs5STwFwSHriIcwIAe0TIoCxouDBPJo0nS4bup7FlFRtThNLGO
 Z
X-Google-Smtp-Source: AGHT+IFjQlCuRTBdopuP4NNlMBHNMACwASl3i1Delc1p19MBWSguSgTMc85d7l/Iiu6pmxffVVDZKg==
X-Received: by 2002:a17:902:f64a:b0:1e4:9ac6:1f3f with SMTP id
 m10-20020a170902f64a00b001e49ac61f3fmr13834007plg.5.1713296501065; 
 Tue, 16 Apr 2024 12:41:41 -0700 (PDT)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a170902704500b001e3c972c83bsm10160586plt.76.2024.04.16.12.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:41:40 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.1 v2 1/2] target/riscv/debug: set tval=pc in breakpoint
 exceptions
Date: Tue, 16 Apr 2024 16:41:31 -0300
Message-ID: <20240416194132.1843699-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416194132.1843699-1-dbarboza@ventanamicro.com>
References: <20240416194132.1843699-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

We're not setting (s/m)tval when triggering breakpoints of type 2
(mcontrol) and 6 (mcontrol6). According to the debug spec section
5.7.12, "Match Control Type 6":

"The Privileged Spec says that breakpoint exceptions that occur on
instruction fetches, loads, or stores update the tval CSR with either
zero or the faulting virtual address. The faulting virtual address for
an mcontrol6 trigger with action = 0 is the address being accessed and
which caused that trigger to fire."

A similar text is also found in the Debug spec section 5.7.11 w.r.t.
mcontrol.

Note that what we're doing ATM is not violating the spec, but it's
simple enough to set mtval/stval and it makes life easier for any
software that relies on this info.

Given that we always use action = 0, save the faulting address for the
mcontrol and mcontrol6 trigger breakpoints into env->badaddr, which is
used as as scratch area for traps with address information. 'tval' is
then set during riscv_cpu_do_interrupt().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu_helper.c | 1 +
 target/riscv/debug.c      | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index fc090d729a..f9c6d7053b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1717,6 +1717,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             tval = env->bins;
             break;
         case RISCV_EXCP_BREAKPOINT:
+            tval = env->badaddr;
             if (cs->watchpoint_hit) {
                 tval = cs->watchpoint_hit->hitaddr;
                 cs->watchpoint_hit = NULL;
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index e30d99cc2f..b110370ea6 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -798,6 +798,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
                 if ((ctrl & TYPE2_EXEC) && (bp->pc == pc)) {
                     /* check U/S/M bit against current privilege level */
                     if ((ctrl >> 3) & BIT(env->priv)) {
+                        env->badaddr = pc;
                         return true;
                     }
                 }
@@ -810,11 +811,13 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
                     if (env->virt_enabled) {
                         /* check VU/VS bit against current privilege level */
                         if ((ctrl >> 23) & BIT(env->priv)) {
+                            env->badaddr = pc;
                             return true;
                         }
                     } else {
                         /* check U/S/M bit against current privilege level */
                         if ((ctrl >> 3) & BIT(env->priv)) {
+                            env->badaddr = pc;
                             return true;
                         }
                     }
-- 
2.44.0


