Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0221C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77Jf-0002ki-BC; Thu, 17 Sep 2026 04:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77JC-0002ez-M2
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:33 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77J9-0001tj-N0
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:29 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2caced6038eso4940925ad.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789633045; x=1790237845; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aM5GazrmTsSs4YpTLVmzO3nGyDRcEg1ZWw1nkFowSsc=;
 b=HqjSUZP83Xk46cmUxdHim3bYemu7Ym8THZlhmAhpuArLYwhsTY22IZmaQ1ehsyEHO6
 Z5dkVX0GPaSjU+duKDdp3cHhBgq3co2cLlt90Tkyhaf/TewwEsqC9UOkUPWsHHBVcL5b
 VVLowtkvVUPuBXPptXfygPvLdLJ9iHWbAnRarJzfuKqsmRaYWnWBrR3LL/Si7s3GssP4
 Rx4Asdl84RETh0dZ/szO3NT3yPnp6Q5JWAr+6s7uayiRJit27oI2gBV7XGdecbZfGiaw
 VYYctADA75dN6KSRGZzZRBSlX2F8L/zaBHSL08l1OOKld05QRefrmvyb9s5/Mo3EdOjp
 Ukkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633045; x=1790237845;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aM5GazrmTsSs4YpTLVmzO3nGyDRcEg1ZWw1nkFowSsc=;
 b=EhFyfRaBrHEk20LzyQGpf3Au/w59DWqznCEH8Yl6+c63I4sYq42Rx/oaunSzCH8a0h
 LwSYYtwIQk2KqPb2VC2i8chK3XN+NW3L3/r3vb5THUd9Ib7PfPnS+i3H4uY3nX1DGroe
 Fo2oMYo9l16gmo6HRvJlxDA+RsefPioXX7GbGRr6XdNJi0iAhxaEjoQ7rrFqIvktQ2yD
 tz1pzIOXJH1PHVGsBGbwcElZ2lEmhMZRqcqlNarGEV6prRggXI5QCiPeiYOpU8x+Sx/U
 GDvOl2igBEnrMKWFeqt0yhgpgzGs3nUapHOOHO/7paIPEWw2zfeZHLpObaBNyMGudjK4
 l3cA==
X-Gm-Message-State: AFuF++mdaWsHn06K8Hr9EM0k+ZZOwWH6cDZ8IeJpx32T9n7gq3nzg/0g
 lPM2NGqqBg/zWw4HROICL6jnJz+pIzl6dM8UUQufLlb9kc4nKMiJCDxKVMETNgyeCvsjirX+65g
 KqJ+F0ow=
X-Gm-Gg: AYBFou0qMACdRsNbDpnFFj6daXcyCwQBHhzro/lSkqzZHhkyBbAxs7I39sMHUReWybH
 tP9Kxc2YXo9eQP4pGMeT/83oCVKJ/Zvupp3UNkhc8/31RvDEKkMVeqo9wXhuQBKjoaEbvcwbAIE
 yZEhWBi5iWSZKaArpsOFhM90xMAEX0k4ovmEl/AC6h2OAf9GJWiv5KkDhdKjvotvTB4pb1eYNbf
 kB7p0pXi6hp+r6eTLpChT1kqxE8YzsfqA+81TH4mgO0kIWeq88aIwUQfgusefzrzhqXaKHwWpsc
 1Hw4wKejfSUyTl8U0HjqwhiTacBKNXejfounXO8MM5Y19cIbpqmGsKebsjrVam7+MMOds5ikC4c
 ZxupbheFHS2uL3HMszhe1hggtDG1AO68cF+V4M12+Dh+166MQFGIDXZSxP/MNtPYpmUBDLFTrRX
 9VIzstnrQeKhd0hf5uPOD3idrzAX3qbIhUNlQwHW/ybJmJCwPJtlf0ENS8F2WLlblWZ9Tu3DBry
 SLYKAM=
X-Received: by 2002:a17:902:cccd:b0:2d8:d4d2:d137 with SMTP id
 d9443c01a7336-2dd9ca26d17mr43862095ad.19.1789633045392; 
 Thu, 17 Sep 2026 01:17:25 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c1943f4bcsm127638eec.21.2026.09.17.01.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:17:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 06/16] target/mips: Use tcg_gen_lea() for [D]LSA and MXU
 S32LD*V opcodes
Date: Wed, 16 Sep 2026 22:17:06 -1000
Message-ID: <20260917081716.946668-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917081716.946668-1-richard.henderson@linaro.org>
References: <20260917081716.946668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260831062630.58771-1-philmd@oss.qualcomm.com>
---
 target/mips/tcg/mxu_translate.c        | 3 +--
 target/mips/tcg/translate_addr_const.c | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index a38f4da12ba..5361c94b343 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -1596,8 +1596,7 @@ static void gen_mxu_s32ldxvx(DisasContext *ctx, bool reversed,
 
     gen_load_gpr(t0, Rb);
     gen_load_gpr(t1, Rc);
-    tcg_gen_shli_i32(t1, t1, strd2);
-    tcg_gen_add_i32(t0, t0, t1);
+    tcg_gen_lea_i32(t0, t0, t1, strd2, 0);
 
     tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx,
                        MO_SL | mo_endian_rev(ctx, reversed) |
diff --git a/target/mips/tcg/translate_addr_const.c b/target/mips/tcg/translate_addr_const.c
index 1d140e918da..910177e43bc 100644
--- a/target/mips/tcg/translate_addr_const.c
+++ b/target/mips/tcg/translate_addr_const.c
@@ -26,8 +26,7 @@ bool gen_lsa(DisasContext *ctx, int rd, int rt, int rs, int sa)
     t1 = tcg_temp_new();
     gen_load_gpr(t0, rs);
     gen_load_gpr(t1, rt);
-    tcg_gen_shli_tl(t0, t0, sa);
-    tcg_gen_add_tl(cpu_gpr[rd], t0, t1);
+    tcg_gen_lea_tl(cpu_gpr[rd], t1, t0, sa, 0);
     tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
     return true;
 }
@@ -47,7 +46,6 @@ bool gen_dlsa(DisasContext *ctx, int rd, int rt, int rs, int sa)
     t1 = tcg_temp_new();
     gen_load_gpr(t0, rs);
     gen_load_gpr(t1, rt);
-    tcg_gen_shli_tl(t0, t0, sa);
-    tcg_gen_add_tl(cpu_gpr[rd], t0, t1);
+    tcg_gen_lea_tl(cpu_gpr[rd], t1, t0, sa, 0);
     return true;
 }
-- 
2.53.0


