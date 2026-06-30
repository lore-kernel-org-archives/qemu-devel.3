Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD51C44500
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weglG-0003gk-GX; Tue, 30 Jun 2026 18:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wegl0-0003db-JA
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:16:42 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wegkv-0000vP-NH
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:16:42 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B195E600FF;
 Tue, 30 Jun 2026 22:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65EDBC2BCF6;
 Tue, 30 Jun 2026 22:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1782857768;
 bh=L6IISu+Ef5DMiwb6NE2E84F0pPZO0hJVnrXkzVidAic=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=YfDI1e3k54vCpzwpHuMWjpcPb6AM+zyBTkHfwQUnhaT9zFC4XVspWLItk84OdHgYb
 v+DNvPFmMlaC2ce3hvLM3YzQufEUl8a11xnze6eiThPlgXnKh4Omm/GeQNFTjJPjK/
 mQ0ICIoToERmOui3exhC+dFsEdAhzdtDi4y9MQrT6dinfPEdwI9jbXirf3bK/SoUtp
 DaHErWDK2QWsf/67lCNFXkp12b9yVioeuQi4t955YqWqDO3l2s8qjrpdke0kllmgdE
 UIRhs9swmZyoUXLA4S3IKqMn86C9pEKlUuVxp13kUue9fGBlLqioFlrCFu4bUkCaTe
 p1Hxwxxn/ZN1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 5972EC43327;
 Tue, 30 Jun 2026 22:16:08 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 01 Jul 2026 06:15:57 +0800
Subject: [PATCH 3/6] target/loongarch: gen_vreplve: Fix offset calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-loong64-be-v1-3-9c7d65e00697@gmail.com>
References: <20260701-loong64-be-v1-0-9c7d65e00697@gmail.com>
In-Reply-To: <20260701-loong64-be-v1-0-9c7d65e00697@gmail.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Miao Wang <shankerwangmiao@gmail.com>, b4-sent@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277;
 i=shankerwangmiao@gmail.com; s=20250715; h=from:subject:message-id;
 bh=bC5SqslKnEPRqmw7UZDsgSavAaNwn/tX4lGdinMQfiM=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBqREAl3N+hxcxcq0u1qJyanEPHRKJo+Psrg6oJ7
 Py6YFFIKeSJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCakRAJQAKCRCwMePKe/7Z
 bqqFD/90jfPSAFlcgay7PWLh0sTEnyfvqZ3J/xtOAcZudwA6HYfL5LNyaxiel/59YEn0tXeKobp
 fuL+sOnfcBbUXQApM1CkJMk6nhwgavHPw42s19O2ppEyWlgtimobR+sbGnHnoI8GP/guOyktqbz
 wGJqm6B51Fb389TIxaekNsZzaKNOGlHP+RevUvz4UHdYv3cLq/nwKnc9yIh6FlJR4ibOE7pgNBm
 W81WXW1Dr2V+YfHF693guguA/6gxahn0CivpOSxLF4QH0G5PyuCmjzCuepEPH3FUJaRNJWMm41u
 8mH7kRV1R3xlm3m7I6n92UE5LQwKuR/p+5HU/NChSsW7/wV84xgVwxa7ow6TUyzafA5mFbMKa/r
 TZ2IZtLPS41GvWxaxxZO2KbVnBjZzFmCwgAE9msQh9Ipj56S2tNrP+9Xoh5Rr+Lt0ZDLCg7WmyB
 xBaLfc2Fn5UDAg+uRQGE3T/CXfKm4tZhXpcOZUNgcQ/FW8Q2ri8XEEqPyT/S4P4LVaOohdgqM6I
 xv8Af3tT3O6cOjOjZ9tMDAUeHvN1PwKBnuBWXJs1LAH3zXihrNYgpOr9XR8t3w/F6mtv96XLaBa
 qR2uIo8mY32V+Jmp6PiGTGN+oZoG1gipgYzlGMXaM2krF6LRah1/hCL6eoQYkteSE2KXryhXk/C
 qdhp74IYeghk3sA==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/20250715
 with auth_id=462
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=devnull+shankerwangmiao.gmail.com@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FORGED_REPLYTO=2.095, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: shankerwangmiao@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Miao Wang <shankerwangmiao@gmail.com>

When generating tcg instructions for vreplve, the calculation of the
offset in the vector registers from given channel in the general
register should be done using tcg op codes. The algorithm should be
similar as vec_reg_offset().

Fixes: df97f3380760 ("target/loongarch: Implement xvreplve xvinsve0 xvpickve")
Fixes: 008a3b1662b6 ("target/loongarch: Add LASX data support")
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
 target/loongarch/tcg/insn_trans/trans_vec.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
index 195b89f78834b208f0ba83930b844e792dc488b6..df0e809d544678490ca3ccfddab3fd4d74f7189a 100644
--- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
@@ -5036,7 +5036,7 @@ static bool gen_vreplve_vl(DisasContext *ctx, arg_vvr *a,
     tcg_gen_andi_i64(t0, gpr_src(ctx, a->rk, EXT_NONE), (LSX_LEN / bit) - 1);
     tcg_gen_shli_i64(t0, t0, vece);
     if (HOST_BIG_ENDIAN) {
-        tcg_gen_xori_i64(t0, t0, vece << ((LSX_LEN / bit) - 1));
+        tcg_gen_xori_i64(t0, t0, 16 - (bit / 8));
     }
 
     tcg_gen_trunc_i64_ptr(t1, t0);

-- 
2.49.0



