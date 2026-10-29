Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AFF606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=gg1Zr7cg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMYCL-0003y4-7r; Thu, 29 Oct 2026 18:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1xMYC4-0003un-Ic; Thu, 29 Oct 2026 18:01:57 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1xMYBs-0006W7-7f; Thu, 29 Oct 2026 18:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793311299; x=1793916099; i=deller@gmx.de;
 bh=i/etBb9tlyRNik8N1opBJ6dpfP0qNlvTeJc5kkT+eaw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=gg1Zr7cgIk84qiyzy7QNQw9tAnD1djL5Fd5U302cgu8QaU9JXpwPo4m0Bpd+D0u0
 xak2udpNXp7j8vxrYQmCcAEqw1BkKb7mvRGwirEIMsm827EkCEy7NgTWGdxe9/LfF
 /Y8OoacY8ZrYpC/0CQbj+rgQr3yWM4iGhttWn6UdqPUhIC4yZD19a/inX1363E5nD
 t9gRSdRewMyg2g8qMzSkGJauEy7vlP+erH+soMIhf2bKh+XDo+GcpSHmNMw47YtZl
 gWibjf2fqlDm6XtKFSDBt6YyocH5qO38O+eUXX7gqWIV3oSuzDdk4pFWNH6B48KCl
 ApsoSC/qssnmKyzbcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHG8m-1xICcE2ZRg-00D1HF; Thu, 29
 Oct 2026 23:01:38 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, qemu-stable@nongnu.org
Subject: [PATCH v3 01/10] target/hppa: Use 32-bit load of PSW in rsm and ssm
Date: Thu, 29 Oct 2026 23:01:26 +0100
Message-ID: <20261029220135.412284-2-deller@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029220135.412284-1-deller@gmx.de>
References: <20261029220135.412284-1-deller@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BeOL0eepnmp6llekS5Pz8qNI9lxamFK59ER1ODCYPKwHFawEIOc
 RBOAKwEFxsX7pZg64p3OvdgmKIBaYcTgTk1tlD1dkgQfy2uoZYs+qErQ/HagJD84B0wuR04
 RN+GniU0gZ2FfaGbO0ppadpLWAaAtt67tzl74TBk2KjjG3x5kGGtWb8OVHN6pmNi/8z9aqT
 PfAO3xKZv0SrfjLOzf4ng==
UI-OutboundReport: notjunk:1;M01:P0:NCVdWHo4gxE=;YMuC65zvNFaOtD1KFgheXDqxOfA
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
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

Fixes: ebc9401a4067 ("target/hppa: Split PSW X and B into their own field"=
)
Cc: qemu-stable@nongnu.org  # v9.1+
Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 target/hppa/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 41300c0dd7..46c0408846 100644
=2D-- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2367,7 +2367,7 @@ static bool trans_rsm(DisasContext *ctx, arg_rsm *a)
     nullify_over(ctx);
=20
     tmp =3D tcg_temp_new_i64();
-    tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
+    tcg_gen_ld32u_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
     tcg_gen_andi_i64(tmp, tmp, ~a->i);
     gen_helper_swap_system_mask(tmp, tcg_env, tmp);
     save_gpr(ctx, a->t, tmp);
@@ -2387,7 +2387,7 @@ static bool trans_ssm(DisasContext *ctx, arg_ssm *a)
     nullify_over(ctx);
=20
     tmp =3D tcg_temp_new_i64();
-    tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
+    tcg_gen_ld32u_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
     tcg_gen_ori_i64(tmp, tmp, a->i);
     gen_helper_swap_system_mask(tmp, tcg_env, tmp);
     save_gpr(ctx, a->t, tmp);
=2D-=20
2.56.0


