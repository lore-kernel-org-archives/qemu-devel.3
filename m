Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93F5C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtm8-0007aX-4Y; Wed, 19 Aug 2026 23:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtm3-0007Xi-Ah
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:49:03 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtm1-0004Sz-Fl
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:49:03 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso13270245ad.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197740; x=1787802540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SdRM7x1qzPNyHLcBH9MizyM4AFSQfbw/UNmU055a3dE=;
 b=kenkvhzRdyAUl+mfM8mydfX1BF4VET5fVBB323FlAUhMQ5deLGJ4Au7oH92yfR17Po
 knEQTLQfcZk/wu42hAZp8zlgedcqoQqVFgT7kTIxj8x4IkrfxuzzDFCER8fr9ygz6ny2
 vENsasRLLTJH297jg3Zd+9PAI9GARqRBWwMqcKLoAZoFJKqiyJsLThPXGCs5vMDDZuo0
 xk82rJ3v2pJ28gLOjedkWjHoaio4BFstRQ70AKNXrgYtL84Yjs6bBiLMH+/AByTeb5Yb
 CPOisJvg/jdE05BzOjUDvPGaZeFQSPxwGVjaU8c9DTd7xcbskvc6Fr0XtuF4Uy9i+7Oz
 /VLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197740; x=1787802540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SdRM7x1qzPNyHLcBH9MizyM4AFSQfbw/UNmU055a3dE=;
 b=soaQhNgXfbhtKysJRLrlBy4S0ribJMZIzxyrnEtTMoHov/baEFCUzuPnK4J5VPEGFG
 tMrIchYYmyXdbwGF9dvDFJr+78bouUwdO+mQwO9I/xHrYhPtqokUGgs4Kw+D6IImD/xx
 aR3VVnVuxooEW3QfTl3zULC/MBZ3sbAT6Me0p1S05V5UPD9ODrd7+Sqxx2cHVLUF7sN3
 +DVG4BIkG1lmPkqvAlj4pK5iEqWXVd4SLztO++Ej8YHcvzfZfYK+SPfnzRcPzUBFBb0J
 gd2IUYQRnGAUVgSwq+NyIHOiNegQiKb/6EUj6azXd1qDK6K/MDxPghR2YfYY/uuF+5Ej
 m9Bw==
X-Gm-Message-State: AFuF++l6DMWI/PKI3YoFlgboj2pHiJPMxLT0VAo3YnZwkl62aOWcwblF
 BZvELRXn4+utBS7ouCGoxexAAquTwv7siGDwsVVY/JzO+d+7znwNaxmJq/P4qQ==
X-Gm-Gg: AR+sD12+XrD+rk1WRzymMIg2yxn5u57XhqE+JQqHQBS497ndZfNflIahkcVm6m66H4x
 9yqLrdqw+H2OaVLi+aluCGbr5NtfywKrcrAibaPsVgMrv1hZUY/ihkirothCVgSiRw2Io66oN5Y
 em9GswczPbgBk3wRO0v9r6OKPCCe7ZK6VLrGTr18RbiR5deMCsPGE25j7dFJ0AWw1feRkONUpP0
 P+tT2EtTka5iaC33VDKCVKwW+VGbRHerSuwQ62hjGbrPCZX6vAvzu7cqhBXVM1+a+FpmzUi7ja8
 PyUlI7rRvDoG1gwDcvemuNoPyjF9BOBJlJWmXmxpriZIF+0On2+rrwCEX/MIJ7GDL+V1xW9cz6k
 6pOf22AcSn3J2p4kWlPGML+v+2h79FwraQsh5/0SlahnXLLDkJggebBgwQ3Lu4mqSuEqxXwHj3O
 YGdYEsL/66eRbc3YWYepJin1BTpC4XRyCdp+85x/spLreotXmAaEWZntTbpV3d0YQ8wbZs9St/R
 PgHLA==
X-Received: by 2002:a17:90a:d60d:b0:392:6638:2e6a with SMTP id
 98e67ed59e1d1-3958146f387mr18207523a91.13.1787197739962; 
 Wed, 19 Aug 2026 20:48:59 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:48:59 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 89/93] target/riscv: honor zicbo* envcfg gating in linux-user
 mode
Date: Thu, 20 Aug 2026 13:44:26 +1000
Message-ID: <20260820034430.1186695-90-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: wangyang <wangyang25@otcaix.iscas.ac.cn>

In user-only builds check_zicbo_envcfg() skipped the envcfg check
entirely (#if !defined(CONFIG_USER_ONLY)), so cbo.inval/cbo.flush/
cbo.zero retired unconditionally in linux-user even though the
machine-level envcfg fields are never initialized.  Give the
user-mode build a senvcfg-based gate, and initialize SENVCFG_CBZE at
reset when ext_zicboz is enabled so cbo.zero stays usable while
cbo.inval/cbo.flush remain illegal, matching the user-mode view of a
typical firmware/kernel setup.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4107
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
Message-ID: <9b2f22fc402b48b8ba81f72be8ed04bc@wangyang25.otcaix.iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c           |  8 ++++++++
 target/riscv/tcg/op_helper.c | 11 ++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d8f239e41d..79ddde419a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1062,6 +1062,14 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 #else
     env->priv = PRV_U;
     env->senvcfg = 0;
+    /*
+     * Match the user-mode view of a typical firmware/kernel setup where
+     * cbo.zero is enabled for user mode; the CBCFE/CBIE bits stay zero,
+     * so the cache-management operations remain illegal in user mode.
+     */
+    if (riscv_cpu_cfg(env)->ext_zicboz) {
+        env->senvcfg |= SENVCFG_CBZE;
+    }
     env->menvcfg = 0;
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index acdccd1a97..a7bd42d2c6 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -152,7 +152,16 @@ target_ulong helper_csrrw_i128(CPURISCVState *env, int csr,
 static void check_zicbo_envcfg(CPURISCVState *env, target_ulong envbits,
                                 uintptr_t ra)
 {
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_USER_ONLY)
+    /*
+     * linux-user: the machine-level envcfg fields are not part of the
+     * user-mode environment; only the user-mode view of the enabling
+     * bits (senvcfg, as initialized for the guest) applies.
+     */
+    if (!get_field(env->senvcfg, envbits)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
+    }
+#else
     if ((env->priv < PRV_M) && !get_field(env->menvcfg, envbits)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
     }
-- 
2.54.0


