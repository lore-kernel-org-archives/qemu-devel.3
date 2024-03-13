Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C69DC54E60
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 19:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkUKN-0007Th-3L; Wed, 13 Mar 2024 15:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkUK2-0006w1-4z
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:31:44 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkUJw-0002S2-Hc
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:31:29 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e6b5432439so285362b3a.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 12:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710358279; x=1710963079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ELeCOTtjUnA85j28WZcFUxsvLXuw80p1LClwDiZunOo=;
 b=HB5fk0W4DGM4cv4rrcUgPyGl59bJofbvFSq/Lln1V7kpQmbR24hlb5lqluxQlQizwF
 EO2nbw6nzi2+cM5sV0aIQxaLYbzkjc2gS8QpgLN0VzgS7NVqTI9DKLIw3G91rktguzBe
 xNiEwtJz87+77LOHhcgxt/ywCFmxpWnxn0I+Aqk55e5+xy7r/NEpN+uZcSJ7ducyuqF7
 hu4I/Qztjcyd7ojbix/hB0nw3fr4/zu3k+PQgnnlNm7qnRxdBVymYl39mINuaWhxlc06
 TZP6O8HGLAzY/3TauLYAhVvv5czoPgpsn7a2DdrXhv3U14AmIjhfzQ+l0+OeePClS/03
 W14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710358279; x=1710963079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ELeCOTtjUnA85j28WZcFUxsvLXuw80p1LClwDiZunOo=;
 b=ZyjWvC8LElvY+EqdH+TK6wMUIO7+32baN+X8XdCov6zx96+hoJhXGTZnuS3uk6rW3y
 LE7YfcY8vqK/34K64hasxd6QCXjgsJabLQ3GjPJsogb1nesm5j0wIDYBBYKsVPPEz53H
 igDztrUuklp3nBIQL4bj94nm4gI6nqCiUhXJMBljSFIzEU5BG2jtXYbx0Wm9HZrnucay
 fbcjfaegz6WMVJSrjRDBCLnG4lPexYynipHEZ/enKCPWfJRz5kpR4yNnO8JaiqU1T+Vx
 /zT5xzwMBQXI8sPzhn6i85SJdENufB3nIwpgNffsQpPi6Gxeqi6osKhTHCVhvnZmb4Oc
 dFmw==
X-Gm-Message-State: AOJu0YztEshRMtEgcNQQxC0dXR0BwQelacvBkL7jOCWwM1ufhzfiQ74t
 KktNd+BWNCeYdthPJe0Vsxn12qvFNSGZdRPr53uLrbEYCSEGt1NTSwSt+Tr1YqdoIuoi81xGeeJ
 g
X-Google-Smtp-Source: AGHT+IGUQSluHaa4uJMfMwCyWBsS/1bJOQBdG0UNqh/+k+i2zDnziTXTew1MCpaZX9WokGBrToIs6A==
X-Received: by 2002:a05:6a20:42a6:b0:1a1:6f4f:30d0 with SMTP id
 o38-20020a056a2042a600b001a16f4f30d0mr5126681pzj.32.1710358278895; 
 Wed, 13 Mar 2024 12:31:18 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 k10-20020a628e0a000000b006e5a915a9e7sm8912421pfe.10.2024.03.13.12.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 12:31:18 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v13 4/8] target/riscv: always clear vstart in whole
 vec move insns
Date: Wed, 13 Mar 2024 16:30:55 -0300
Message-ID: <20240313193059.405329-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240313193059.405329-1-dbarboza@ventanamicro.com>
References: <20240313193059.405329-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
happens.  This way we're now 100% sure that vstart is being clearer in
the end of the execution, regardless of the path taken.

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
index b4360dbd52..7260a5972b 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5163,6 +5163,11 @@ void HELPER(vmvr_v)(void *vd, void *vs2, CPURISCVState *env, uint32_t desc)
 
     VSTART_CHECK_EARLY_EXIT(env);
 
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


