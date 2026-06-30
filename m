Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BA4C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegl2-0003eI-6d; Tue, 30 Jun 2026 18:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wegl0-0003dZ-Fw
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:16:42 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wegkv-0000vN-Qn
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:16:42 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B621E601C1;
 Tue, 30 Jun 2026 22:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C5D3C2BCF5;
 Tue, 30 Jun 2026 22:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1782857768;
 bh=5fwfbfm2AOGh+atLQwyd7JdVbW3RzArPPNJV814p4uc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=DgQrKYORwL+MQvo09bXogUhuM39Ug2jjClvKU0N5ySF0JPiral2rds8y0OjXm0GIH
 ni6sYoEyPYQnokpZEpxSwHlW7eE+VJGDzX/3pOM5iip54IKH23wIZRJVE1HsgpR6DO
 1rvEw+udgdVLB+GgZzRfZPvDRC3cskotG+hsFLIk/xwEmZgGzM0OMGr/TjbkG8jkWO
 lMESYf5Y6YpHbuWdMqIIZExW7KaVp8Xi05oBgI8BbNqlhGWIGCtU7XzL5Uup+XwSmv
 ABlBhCJSwRs8PHBAFBOHdkZESiIncZMcQT77D+HYK8+IWrP0Ao2lEHt2/qj1NBLQDy
 UamrpUXrpNJdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 65C5EC44501;
 Tue, 30 Jun 2026 22:16:08 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 01 Jul 2026 06:15:58 +0800
Subject: [PATCH 4/6] target/loongarch: gen_xvreplve0: Fix elem0 offset
 calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-loong64-be-v1-4-9c7d65e00697@gmail.com>
References: <20260701-loong64-be-v1-0-9c7d65e00697@gmail.com>
In-Reply-To: <20260701-loong64-be-v1-0-9c7d65e00697@gmail.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Miao Wang <shankerwangmiao@gmail.com>, b4-sent@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113;
 i=shankerwangmiao@gmail.com; s=20250715; h=from:subject:message-id;
 bh=moaNZILUTzChJGSSSUB7fQ2em+5SHk2AQhoSA/9obmI=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBqREAl/AvX/TREG7mBTgwyhOylN3Moeb4f7cmBi
 +wnSDFqhfGJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCakRAJQAKCRCwMePKe/7Z
 btUND/4qCUDVgECThnqGATsX5KczhGHIp7CeSCNjCTk8ODudZRfHrvmIVSBYe9+GXZHGK+j9+3H
 RVP0M6/Beq1+VkfectI4mGOT4I6nYvkvpqK8aIxShCyFi3+GAy60EZtP56BvlU3btl+hrWVMkwl
 UE2wyru+M92DyZYvnAsIonvEu593UiuqmxxtbfrX9w7Si+9SnQueFb0yMe8TwuAE+rhQP5+a8kn
 lra6nN/2nh6QCsuxTrUK/kH4T/28CbDlWLDDJKM1QMoFAgkA+23giXT8MVNM7orLcEfhyCwvmvM
 NsrQrH4En3UqtV9dKkR1kJoq5g3oB05qZ+8yGnYy+XXEwQo+vTHe8+eemEJM5C1G+FHKBbdKU5e
 3T5X/Ndcf0jOocPocJw8IU5EllOqjJOk9blQ4Y1bNpZNxsA5EBP5VR1FQeJiqKE4Eo0SemSDwU7
 vMX1RDaYH3k1NU/3ZRVvleSemkHrjc0CN43gdqAye4L6ANGx13EsNpOAHXXMZJ8Yzh8Dj42z6+L
 sGzvLRyCfZmsuL4XLUeRJCQZv8drMFJmBpihkjgdQslclSQ2shvugk7dCLK/+HusJKjKDjvOn0y
 g7ZiqA6nKL2Js0c9Z2EktHMfHvPk76Fw+6eU0bZ3AOR66jqyEhWQG1AKFDq7hYNK8WsBrT+7dXp
 7ULwfcSNyxXMg9A==
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

When xvreplve0 is implemented, it should not be taken for granted that
the first element of a vector register is at the starting point of the
vector register on big endian hosts, vec_reg_offset() is used to fix
this.

Fixes: df97f3380760 ("target/loongarch: Implement xvreplve xvinsve0 xvpickve")
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



