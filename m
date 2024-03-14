Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C516C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 17:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkpKm-0005Un-Ik; Thu, 14 Mar 2024 13:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkpKl-0005Sp-5I
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 13:57:39 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkpKh-0005Xu-1i
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 13:57:38 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dd9066b7c3so8832315ad.2
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 10:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710439044; x=1711043844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T5A4nX3r8zSRTiumUSB8VPtRrJ7wQQkRoyZB7HA8ErE=;
 b=i6D22zG/y6VkHJ92kWo6t/gZ6Vu6zvguarRgQR5nJTBCV158YvShJJnd8RNlKo9xx2
 HRObCKKEtLtXLwMdLl5ivNhdNfKdFp0pPkUqBYM/aX1yLuPmV95w6u/ctwfFG5XLJnUO
 yobJS9/p0uF/4HExuohHPX+Fg9H/mH1kuXkS64O4ChngczVMdzZbH+csCUswmohOyoCO
 +3VDi8Lyo7BqzvKst2PlaP1z6idXFqLaFXCIgmu6ZUTLj43AhEJdN74egFvIWk5JKZQ5
 yvBix1GQ4NkDWc6tglAyocBf9WCnonS4W9X95y0cX7jmh331cVs6WIuhA/DPpmPYbK8b
 CKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710439044; x=1711043844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T5A4nX3r8zSRTiumUSB8VPtRrJ7wQQkRoyZB7HA8ErE=;
 b=SYjJTjWgHNaQ/wpFFtlhpOlgkozEnu99z4C/wmcD0yE4d5jNduoN6A+S3svKIr+pou
 h82XmcDHI5l3EujC/cs7X0WQ3Y2vJxR6deNeAXSbB5cgs0YO9KBwmDbHAqbDWhH0ZvKa
 NYHOZCzBfAdJaZ1kNZzoyCD3lyN6R4bT85TNI9BQtXUyndboJNlEOcBzguLCl/NMkv8M
 Edlc+vc38tyNarh2He46J0i1mTPaedCAzfX6XJ8kc43YMOAIEz0VZdQvvzQEjnTDNfPo
 NIW2c4r5io/ZKsxARAPmVoqH/8FKfmixMQcqG+sVIztI5mgW23vJ9pSUMrt15l3Av/GI
 Em/g==
X-Gm-Message-State: AOJu0YyWGmhkN+OZdCjQu/vwhy+KeoPmzrFkxPRkcJR3pzOw7l0aBGq5
 M7TRzQq6am+hQRzGKs4thtjYTqHlie47lhZXKMLf5MuKJsmTFJJS0QtFZ/IcCFHjMaxZywX9ebd
 s
X-Google-Smtp-Source: AGHT+IGaybWc75PKRIoCdx42wEIfqBwBL+E7PrBZeI4zPnbYNXzRrc+gg4ShYmGmoxmHnZyJga+NPg==
X-Received: by 2002:a17:902:e808:b0:1dd:a285:b41c with SMTP id
 u8-20020a170902e80800b001dda285b41cmr3617956plg.7.1710439044553; 
 Thu, 14 Mar 2024 10:57:24 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 i7-20020a170902c94700b001db717d2dbbsm1991776pla.210.2024.03.14.10.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 10:57:23 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com, richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for 9.0 v15 04/10] target/riscv: always clear vstart in whole
 vec move insns
Date: Thu, 14 Mar 2024 14:56:58 -0300
Message-ID: <20240314175704.478276-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240314175704.478276-1-dbarboza@ventanamicro.com>
References: <20240314175704.478276-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

For starters, the check itself is wrong: we're checking vstart >= maxsz,
when in fact we should use vstart in bytes, or 'startb' like 'vmvr_v' is
calling, to do the comparison. But even after fixing the comparison we'll
still need to clear vstart in the end, which isn't happening too.

We want to make the helpers responsible to manage vstart, including
these corner cases, precisely to avoid these situations:

- remove the wrong vstart >= maxsz cond from the translation;
- add a 'startb >= maxsz' cond in 'vmvr_v', and clear vstart if that
  happens.

This way we're now sure that vstart is being cleared in the end of the
execution, regardless of the path taken.

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
index 34ac4aa808..bcc553c0e2 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5075,6 +5075,11 @@ void HELPER(vmvr_v)(void *vd, void *vs2, CPURISCVState *env, uint32_t desc)
     uint32_t startb = env->vstart * sewb;
     uint32_t i = startb;
 
+    if (startb >= maxsz) {
+        env->vstart = 0;
+        return;
+    }
+
     if (HOST_BIG_ENDIAN && i % 8 != 0) {
         uint32_t j = ROUND_UP(i, 8);
         memcpy((uint8_t *)vd + H1(j - 1),
-- 
2.44.0


