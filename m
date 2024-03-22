Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B95C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 09:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnalh-0002bD-B7; Fri, 22 Mar 2024 05:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnalf-0002Ok-G4
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:00:51 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnald-0002GV-Qi
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:00:51 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7db1a2c1f96so986399241.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 02:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711098048; x=1711702848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eain6TjZs4KlayZqmfzJXWzUESCa0jrf8H67G9gsemE=;
 b=lenyC2nxTJaKTWfzJMvsm8cgJEgAF1aYRSBHLlJ1RlHo1GrZ9UmySNsG3TPYHq7Uuc
 E+y38IbRiixDd2Q9EuPcCGxKum6bhUZsobkJQFMSQ81ah9Mp0HxCpWNSQniSKOTHFms+
 251Zp+6wPmV3Kc9+QYrR6Swv9mxN2zcJrhQqv/xA5jYJJw+3Qoc/g+dausRdoNrFN/XK
 /RFpyUgyj2qritXK0tutkE7YsTMyVkyC7CVYRZifp1J3zkS8qBIXDw4fRqGRODWqhIA5
 wNdW/IElmjxjqso6Hj689Ay6sENr89ZbG+0NKTaZrzLVn0pHD1Z6b2LSgRRCLQfE0mmt
 8oNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711098048; x=1711702848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eain6TjZs4KlayZqmfzJXWzUESCa0jrf8H67G9gsemE=;
 b=iQ42ki4TKouEjzvWUyKyIimN7BAAm1kKswYhrZIHRlf4cwfaT6w+ZZ0Ex81I0Ic+Co
 wArKRnkhUoLMsPdDo4z7z4gRUN+ze4YMFClMf6tG6HvJHzJh6+yAyho16o4Yek6pNrPd
 //zqSm0eFYwwNY3c4clF2DwWVlOyZtWd/eWPNqE1YF4DZBnP+eVnFsR/IURs/znUWFP6
 47xM58MPJviZgpheKoJVU2KHZQL6E2YABXq6/Z/9fGRQMWOfFQyLPqzIufe9hyCADKAw
 ElYoyIlKJ90uvqE+fIwESKPsKlOi+uw65WlYVn8x8gyYN4KRP+A7blhbh3NIvfMxSjRj
 iq5w==
X-Gm-Message-State: AOJu0YxCYbkDTTVeghVPM8HHNIvwhw1U+5iT2CHkOu+COailuQ+BTBVi
 D6+fIzar/RhjED6t91ukQNC9TXBlSKIywuqq3o0LxAjywDVsHqrj5yHWmM8ABR80ZQ==
X-Google-Smtp-Source: AGHT+IHMePlEEepUGlYPmQwDEOZ9wktx9ltXupP2zK/RW7bH2Vs1khYrvVAmbixcH7mgpT7feW91ug==
X-Received: by 2002:a05:6a20:3d1d:b0:1a3:6f9a:5434 with SMTP id
 y29-20020a056a203d1d00b001a36f9a5434mr2224347pzi.62.1711097625574; 
 Fri, 22 Mar 2024 01:53:45 -0700 (PDT)
Received: from toolbox.wdc.com ([129.253.180.114])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a170902680500b001ddde07af12sm1369048plk.143.2024.03.22.01.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 01:53:45 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/15] target/riscv: always clear vstart in whole vec move insns
Date: Fri, 22 Mar 2024 18:53:09 +1000
Message-ID: <20240322085319.1758843-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322085319.1758843-1-alistair.francis@wdc.com>
References: <20240322085319.1758843-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240314175704.478276-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c            | 5 +++++
 target/riscv/insn_trans/trans_rvv.c.inc | 3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

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
-- 
2.44.0


