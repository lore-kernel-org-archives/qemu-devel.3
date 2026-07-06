Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61C6C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 20:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgpWd-0007gZ-Hq; Mon, 06 Jul 2026 16:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wgpWa-0007el-8o
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:02:40 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wgpWX-0005hh-L2
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:02:40 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D25242DF5;
 Mon,  6 Jul 2026 20:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F034C2BCF6;
 Mon,  6 Jul 2026 20:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1783368155;
 bh=PGtILCCznYPPfwmkvHBVmzqvJj+eSX2Kce9+VmIen3k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=S0SvdHluG1Bg9+2N7bCMPVsyBby8so8b2KrZ38uFzhB28z8FSrDmMxVGlJjbw1aFc
 w6wgsHT5F7biNxwKPoGoZmWjeuh9Dn04PSVE0p+HrT4kIpmg6D+e5OBGBDZn9pQTDf
 +b06VdDl8NHY7ucDphNGND4yTTCYasOI9/9FTyuIao9Z00cnL0H2+jzyRi0I4L2rj5
 OrEIOuZNwewkyCcGCwYPQ2mlaSK3UCJZlW2gS46aqrIbeA/XrkFTnLtL7jZ6QaAS2Q
 euETctQWQDIEHLrxBBgEVHQDcQ35fCuoqZPqXZO0BwXTtQb5Ox0618w3E6njYtP9f4
 vJA2xb2CzYVdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA04C44500;
 Mon,  6 Jul 2026 20:02:35 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Tue, 07 Jul 2026 04:02:04 +0800
Subject: [PATCH v2 4/6] target/loongarch: gen_xvreplve0: Fix elem0 offset
 calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260707-loong64-be-v2-4-8634f93c1dc9@gmail.com>
References: <20260707-loong64-be-v2-0-8634f93c1dc9@gmail.com>
In-Reply-To: <20260707-loong64-be-v2-0-8634f93c1dc9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Miao Wang <shankerwangmiao@gmail.com>, b4-sent@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177;
 i=shankerwangmiao@gmail.com; s=20250715; h=from:subject:message-id;
 bh=JVeeeYSYmuNx8G6YkhYHh9AnFOY8pRrWSpHwtr34lFg=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBqTAnYtNN+KK4/+Kng0gO/ykCyo9h6WMWH8ORYi
 931tMbOTK2JAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCakwJ2AAKCRCwMePKe/7Z
 bgIHEACZbPxGekTV/dsvZToilBU6OYzCQ6YxQ7H3mRvz15AcFwb6xRW15l01VSuni97lRyfCSPg
 6WRyxGdPLmQeJQej/2GCAOJ0A/yGqHcX/AbTtoRGdLPSjpX61XbPdQbczFE1bo3p3vOZ56wnwdO
 r+mLzaVDQSxf7EjrPmHYE8a13hC9PiD63LZ5zyL2mz5BVVS/dqhJmI3r8F4FKy8v9IWauhoPZwN
 J/MF7h2+jVaATqVZVbudhRfM5QC+URbSo2V5sfg+F1PQtF6dPwjswxj7/Afvbn7/P5PTdvJ0rH6
 g+Wwr2n7eLrX1cxAn1+zmVXPRx68u/Bof3brz0SMjrhr2cILsFRGLex0b7udrE7N+iy2VY0Zd0K
 TFVf8fiwYp2PdWDF5IQMX4mxY8+N2Y4RDB3OWedOk9XLQ3xF9RcfR0m4HWJbwAaTebqz+n/UExq
 uSY8LdCz7WgA3chP5BHNwKoIP81Hv+oSbvWfdOnfrXD2ldfegVGANlbwr+MNlGqwauXR6384Txz
 EAI7MsSqOQSTKosL21HZEbUhhSS+M9vwx5ZACrQv5J7uMTLiLp3cOgL7D1gW5JjGYoI5GRTfCv0
 MXpCuKPCliMzPvqxOx/bXTkUWi5feqGc3cnYuogs6LKx4HZveVvtqlFGx9vdj9MGpT2JnknkrSL
 OsbG5Jm9PZo3yXQ==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/20250715
 with auth_id=462
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=devnull+shankerwangmiao.gmail.com@kernel.org;
 helo=sea.source.kernel.org
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

When xvreplve0 is implemented, it should not be taken for granted that
the first element of a vector register is at the starting point of the
vector register on big endian hosts, vec_reg_offset() is used to fix
this.

Fixes: df97f3380760 ("target/loongarch: Implement xvreplve xvinsve0 xvpickve")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
 target/loongarch/tcg/insn_trans/trans_vec.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
index df0e809d544678490ca3ccfddab3fd4d74f7189a..03938b1f052335190cdc437fc2d453b4f4fe16a4 100644
--- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
@@ -5099,7 +5099,7 @@ static bool gen_xvreplve0(DisasContext *ctx, arg_vv *a, MemOp mop)
     }
 
     tcg_gen_gvec_dup_mem(mop, vec_full_offset(a->vd),
-                         vec_full_offset(a->vj), 32, 32);
+                         vec_reg_offset(a->vj, 0, mop), 32, 32);
     return true;
 }
 

-- 
2.49.0



