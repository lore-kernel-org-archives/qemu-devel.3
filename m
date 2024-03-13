Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520F6C54E68
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 22:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWgK-0007VI-9q; Wed, 13 Mar 2024 18:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkWfr-0007OU-Nm
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 18:02:13 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkWfg-0004Ij-4O
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 18:02:11 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e6b6e000a4so320781b3a.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710367318; x=1710972118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CfFgw9URtygopPhOgbzJ9EGeFoJg6+PXSkK7w0QGBRo=;
 b=Yvtazkhld1epol0LZEQ5SOx5+2z6TPvAD59tIiLLpsmm1U1hLIeqd01wsj0VsHM40Q
 AaZ5zx7WfnVt6FCfjCplwm1YjP/r5kfn1T3Vj9xoeWI+8wJLgaAlS4UYBg6r4UMGltYu
 J+fIiIIQ7K6oMeQkSEkcQHA+GdXdbBMNWliD22zbioFdlEw6CVhCMKQfAV93IUR76/Ro
 BWm7uq91MWgZ5M12AdRDpqVZmvgj30iJeO4XaVy/acH0FdLANCHztigK6PUNeSvCSm9d
 1zDc+AkH3MP7ACkkHi2n4K16YL18Pv9SvMT2G4Ue3z5dORCu9QichW3Tn/l7Y7rsNvsx
 qFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710367318; x=1710972118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CfFgw9URtygopPhOgbzJ9EGeFoJg6+PXSkK7w0QGBRo=;
 b=EqdqM1r6Z+qld6hyNldbKfdudVzVKuXNWT1LJ7nP97Gs97dPfF6108W7sow6+Z+oSp
 DSb4MaJD/Ewt/sd9WOmbypFliMdG2rAi57T237SmGmMHLabmlbemsYqGwUe1Xmamu6lf
 R1maHzuRtrtQzhgj2mSN1fLTByPwHJttp1CezTWT75eFNPp76HjGuMQ95LByc+R8Acjj
 aq6QEV+bvRwCxrWWIwAg7871xp1U9U+ZJBQDKOx20Dx2dWljDgCzUkpX3To9Yi5n58tu
 QTc7TUFQOfNq9qDjkYjWNmfixC0bHo+/UQIbT3R0I9T524R14wgCbxIsvUwkH2ukI3Pq
 fkww==
X-Gm-Message-State: AOJu0YwBNzdWUzep2X5PvcBWYfRapOEVEyW3N+xqthhS1uMiWVLGHex5
 5A/zUsNuRjShCALMxNTVYdsEUsHX8CJ8iPS/dB3xp+q2++kEiIYR89fj/kVDzegJV9vIfOFN2ri
 r
X-Google-Smtp-Source: AGHT+IFYCls9YSFH+X05Q7X9LuLa+hHy6rj8HAIHenlhmK0C7XmWg0UxKgusNJEcJIZW53AOkziNqA==
X-Received: by 2002:a05:6a00:181f:b0:6e6:96cb:3ab8 with SMTP id
 y31-20020a056a00181f00b006e696cb3ab8mr133749pfa.10.1710367317887; 
 Wed, 13 Mar 2024 15:01:57 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 ln17-20020a056a003cd100b006e6bcbea9e0sm95812pfb.88.2024.03.13.15.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 15:01:57 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v14 3/8] target/riscv: always clear vstart in whole
 vec move insns
Date: Wed, 13 Mar 2024 19:01:36 -0300
Message-ID: <20240313220141.427730-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240313220141.427730-1-dbarboza@ventanamicro.com>
References: <20240313220141.427730-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

These insns have 2 paths: we'll either have vstart already cleared if
vstart_eq_zero or we'll do a brcond to check if vstart >= maxsz to call
the 'vmvr_v' helper. The helper will clear vstart if it executes until
the end, or if vstart >= vl.

However, if vstart >= maxsz, the helper will be skipped, and vstart
won't be cleared since the helper is being responsible from doing it.

We want to make the helpers responsible to manage vstart, including
these corner cases, precisely to avoid these situations. Move the vstart
>= maxsz cond to the helper, and be sure to clear vstart if that
happens. This way we're now sure that vstart is being cleared in the end
of the execution, regardless of the path taken.

Fixes: f714361ed7 ("target/riscv: rvv-1.0: implement vstart CSR")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 3 ---
 target/riscv/vector_helper.c            | 5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 8c16a9f5b3..52c26a7834 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3664,12 +3664,9 @@ static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
                              vreg_ofs(s, a->rs2), maxsz, maxsz);        \
             mark_vs_dirty(s);                                           \
         } else {                                                        \
-            TCGLabel *over = gen_new_label();                           \
-            tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, maxsz, over);  \
             tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2), \
                                tcg_env, maxsz, maxsz, 0, gen_helper_vmvr_v); \
             mark_vs_dirty(s);                                           \
-            gen_set_label(over);                                        \
         }                                                               \
         return true;                                                    \
     }                                                                   \
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ca79571ae2..cd8235ea98 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5075,6 +5075,11 @@ void HELPER(vmvr_v)(void *vd, void *vs2, CPURISCVState *env, uint32_t desc)
     uint32_t startb = env->vstart * sewb;
     uint32_t i = startb;
 
+    if (env->vstart >= maxsz) {
+        env->vstart = 0;
+        return;
+    }
+
     memcpy((uint8_t *)vd + H1(i),
            (uint8_t *)vs2 + H1(i),
            maxsz - startb);
-- 
2.43.2


