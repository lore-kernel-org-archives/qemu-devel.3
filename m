Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DEC606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=Fee0m73R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3C4-0007sW-Qb; Mon, 16 Nov 2026 15:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3C2-0007km-7c; Mon, 16 Nov 2026 15:20:46 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3C0-00086g-7Q; Mon, 16 Nov 2026 15:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860369; bh=ikuXXfCFjRnH2i59Ync0gKKIoB2cCb7V8BNkDPOWdmQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Fee0m73RFlmcDGyReddowGVJWe9QRukLIyr7F4upLJyg8N7ZwDnvWcGEgsL49pjAQ
 gA+Ey7IRJd9/692muri07x5yISLqnis0N6ra+M66feGdFwEXrw0K6yjAvmAP2oaz4R
 bb3sEa/hHMEn3ssQiscQiM7Rt0c9XXNVH5ZfRmjsRLL5zXJroaelu599mgYL+MEkra
 zVNT6W2cmZJpwieTswx5zBBPENWJzhcfZmb3ETg3gNersod4ozMEFHx21ERxgmXQSl
 HQ9E+Q9gARuV7n8rZcmOw87mcJONi1g8g2A3yDckE0ICdRLQtWdBCdv3YF6H0wqM9E
 XpLzG3dcehF6Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B137D1E7146;
 Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AE14E45FB7C;
 Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6C8ACB8DEE; Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Keith Monahan <keith@techtravels.org>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 16/59] target/hppa: Use 32-bit load of PSW in rsm and
 ssm
Date: Mon, 16 Nov 2026 23:18:20 +0300
Message-ID: <20261116201922.534306-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Monahan <keith@techtravels.org>

Since commit ebc9401a4067 ("target/hppa: Split PSW X and B into their
own field") env->psw is a uint32_t followed by psw_xb, but trans_rsm()
and trans_ssm() still read it with a 64-bit load.

On a big-endian host the low half of that load is psw_xb, so the value
passed to swap_system_mask() has none of the current system mask bits.
SSM and RSM therefore clear every PSW system mask bit except those named
in the instruction. For example, "ssm 2,r0" with PSW_Q set clears Q, and
the next interruption does not record IIR, ISR and IOR. This makes the
hppa-fpu-test dtlb-load case fail on s390x hosts.

Load only the 32-bit psw field.

Fixes: ebc9401a4067 ("target/hppa: Split PSW X and B into their own field")
Cc: qemu-stable@nongnu.org  # v9.1+
Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit e0c80f0b9ca5792a91a0d14d09c3da05641d8402)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 0d0d1bc99bc..504b29fcca0 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2359,7 +2359,7 @@ static bool trans_rsm(DisasContext *ctx, arg_rsm *a)
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i64();
-    tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
+    tcg_gen_ld32u_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
     tcg_gen_andi_i64(tmp, tmp, ~a->i);
     gen_helper_swap_system_mask(tmp, tcg_env, tmp);
     save_gpr(ctx, a->t, tmp);
@@ -2379,7 +2379,7 @@ static bool trans_ssm(DisasContext *ctx, arg_ssm *a)
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i64();
-    tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
+    tcg_gen_ld32u_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
     tcg_gen_ori_i64(tmp, tmp, a->i);
     gen_helper_swap_system_mask(tmp, tcg_env, tmp);
     save_gpr(ctx, a->t, tmp);
-- 
2.47.3


