Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F37C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 20:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgpWa-0007fN-Ol; Mon, 06 Jul 2026 16:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wgpWZ-0007eC-44
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:02:39 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wgpWX-0005hl-Ke
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:02:38 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 81FC66182F;
 Mon,  6 Jul 2026 20:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36BDBC2BCF7;
 Mon,  6 Jul 2026 20:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1783368155;
 bh=L6IISu+Ef5DMiwb6NE2E84F0pPZO0hJVnrXkzVidAic=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=ZEmxaQONoh97auqmYQebkWygRN0sxJUxRKSrQ2EGaZ+L7fEFwBfUNlv0CUA2/7QEZ
 peizEA4Bw5s9mzk6t4+f8v15cTpqzZSsT5lCI7kAa2aQrhEJVk9yatt2FLmqHcS5E9
 fxls87sBoLw5uIEtdU5lALjQ9Wo0PpVsGoNEkCl3Mclt5xYKOpLcyahwF4C3iB3VRN
 Xg0WfaLP6efKJ5ZukgjM4Lkt1s2V4tseROztmZRvtz83ek/noK5gV1B1rYnA6BkWXP
 HHhcJITJc/xHd7rDkVtyBIjfX2zi2qN498aSQE3mQs1fOPgP5UhaqjqZWFCE0QMOmo
 GH/aFgVNaPXwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF53C44502;
 Mon,  6 Jul 2026 20:02:35 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Tue, 07 Jul 2026 04:02:03 +0800
Subject: [PATCH v2 3/6] target/loongarch: gen_vreplve: Fix offset calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-loong64-be-v2-3-8634f93c1dc9@gmail.com>
References: <20260707-loong64-be-v2-0-8634f93c1dc9@gmail.com>
In-Reply-To: <20260707-loong64-be-v2-0-8634f93c1dc9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Miao Wang <shankerwangmiao@gmail.com>, b4-sent@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277;
 i=shankerwangmiao@gmail.com; s=20250715; h=from:subject:message-id;
 bh=bC5SqslKnEPRqmw7UZDsgSavAaNwn/tX4lGdinMQfiM=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBqTAnYscDls0eB4JiNHScwXQeJOVLTKEidTGKjm
 kyqxRx7m8yJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCakwJ2AAKCRCwMePKe/7Z
 bm13EAC6I8w3R4d7yFSrRVdd73QdLS8M7IjTtulokzm/xZ70nQfgtSoEzD39FnorbxmsUJ9I74K
 z5dMh3rLAcl74+adtdmkFCrEZImPalS81glsSzuWJmM5Tap1+/HTwTfAXaLdWGfCi6pKwrtGJWO
 8ZQ+qXzq3zUxZbLXJ0OFy/bgDuMJZYei0ynpInEfb5EhpLwFzX9mchG44feSeDSWV4O6vg6qt/J
 LlB/VXir8hQzmWhQdTstlTzNhZz1ZXIw76BHiXwqEDh3D7DMmdna44WREcV4495FKicDU1nPuA/
 LWNJtAohCU93iymw9jSEM+90KK6wHw/MiT7VbEoaoBohgzNo1D3iXDj8UK9C3Z0Qr/0abS56XHz
 Dek4tD6kjB3CattiDdHN3bThh0oKbhr5Dnll3MI+y4aq12L+a8sH9OoB+bD1pIc9tGpiSd8MFWM
 BlTG3heaL3oOzrkEql0YmD5nd3/5u5MeILgs/08zGHzcet6XnGS7nru2GvxITWJzD3SBJQlhPOI
 V/u4PQyM0S9EaALEZhBON0kXzZByTDDL8tg9dgPw2yEQItOideIyG6iDLAunMq4a7ECiEicqh0L
 xfJOasqS+BDqrc99fLqAtVTAxbYP6VYaUwIidsNwT2UTkQDs+6jaU50FYSzTzhEYHLBTW2tkrnO
 jb0pcIledTa2sSw==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/20250715
 with auth_id=462
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
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



