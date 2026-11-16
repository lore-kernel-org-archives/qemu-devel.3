Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6019C606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=Q7ehl9OK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3J0-0003E2-OC; Mon, 16 Nov 2026 15:27:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Is-0002Vq-Be; Mon, 16 Nov 2026 15:27:51 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Iq-0001So-MF; Mon, 16 Nov 2026 15:27:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860764; bh=ANEyYj4q13neqA8L6r5lsRnbAzusxPUZ+KNpTZFU5Jk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Q7ehl9OKZEJ/g1v7V+Zqnk29uua24iiqcyhu/r6cI4Rh6UjKCmOJ8Z0lII7viRE7I
 MLtV+0gewm6ap5vrsqIA0BzZjlujA8cGDNyQYrfNQWutgY8jTYZxWaNq1Xh9L0DHL4
 GVYDAbKuHAnHAEbHh/7Bu1PYOuB0raRhh1VHpXIWketljlaB1oAwZ68eBxr/5nWaBr
 9iC+kUP/BzWGPx16Y7Rb8F815OgaCDtlEUJYZtJO8NJ1rUNtwxTg9VP44B6wP8ZrzP
 yfWU6aZk4r+IwDw+SiPSG7mlX5QgF7w0Du4KeymFOzwR+VP3+BJi+Pkksu9l9oUqDj
 TNVynZfSwz6Xg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 265F01E71AB;
 Mon, 16 Nov 2026 23:26:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2400745FBD7;
 Mon, 16 Nov 2026 23:26:04 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A978AB8E72; Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Keith Monahan <keith@techtravels.org>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 22/63] target/hppa: Use 32-bit load of PSW in rsm and
 ssm
Date: Mon, 16 Nov 2026 23:25:01 +0300
Message-ID: <20261116202554.535325-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
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
index 002189ddfbd..4415eb73df7 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2367,7 +2367,7 @@ static bool trans_rsm(DisasContext *ctx, arg_rsm *a)
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i64();
-    tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
+    tcg_gen_ld32u_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
     tcg_gen_andi_i64(tmp, tmp, ~a->i);
     gen_helper_swap_system_mask(tmp, tcg_env, tmp);
     save_gpr(ctx, a->t, tmp);
@@ -2387,7 +2387,7 @@ static bool trans_ssm(DisasContext *ctx, arg_ssm *a)
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i64();
-    tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
+    tcg_gen_ld32u_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
     tcg_gen_ori_i64(tmp, tmp, a->i);
     gen_helper_swap_system_mask(tmp, tcg_env, tmp);
     save_gpr(ctx, a->t, tmp);
-- 
2.47.3


