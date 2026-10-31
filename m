Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DA9606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=M/o0nGgy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN4Tj-00021M-6X; Sat, 31 Oct 2026 04:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1xN4ST-0001iH-QJ; Sat, 31 Oct 2026 04:29:03 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1xN4SR-0001rt-Vp; Sat, 31 Oct 2026 04:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793435334; x=1794040134; i=deller@gmx.de;
 bh=i/etBb9tlyRNik8N1opBJ6dpfP0qNlvTeJc5kkT+eaw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=M/o0nGgy/g0VRwKkBaQDZGo7Kaw2VRCTve5wOx/hYXHb28b3ETvrmAn9TmAU/cjd
 sD7dM4J7pZDotQ6RQkkrRKZdWhWBebc4fHH1lg236p7u1K8XkYZ3PiIVjDGxyf6uk
 k7rKOBtt0BMq4DGegQfksGFQcWFQ9QWE1CPimhq3GxLf+TuTQaMpsATWJ10IklN2H
 3nQsiRi+4toTEVl49V2PEFALppUyW/kNGxZWmSo0ACf473Wcwyte3nWYS1lTzkL6F
 wgg0qmkFqtzQbsOtecL8gtSxBsBnVfZbl5Rwcemi8OEKUERCtqmlkL1yOixR+lowj
 IMNdehSl9EZym/wLQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8hVB-1xRDKG2wkL-00Fh6C; Sat, 31
 Oct 2026 09:28:53 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Fabiano Rosas <farosas@suse.de>,
 "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org
Subject: [PULL v3 01/10] target/hppa: Use 32-bit load of PSW in rsm and ssm
Date: Sat, 31 Oct 2026 09:28:41 +0100
Message-ID: <20261031082850.439293-2-deller@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031082850.439293-1-deller@gmx.de>
References: <20261031082850.439293-1-deller@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:97yc10aG3OiO3NsA9CoXs6vhHo3pP4yWNZLTmzVknQ38iMdeg6U
 0z3gGigV6GOqE3y/SvrYYaCvBE6YmeB7Lb7N76HkHMp5Q/nkOhgsj1j5SuC3xkMLaOhd9cX
 Y3O6iv1IVolwCAMAVe7CbhC8PiQvGw8x5Rl5Wt4tgrjAlFqgTZ37xrD26fcuMnuXvuvdmJ6
 rPOB/rLAXlDyq5J/MxB+A==
UI-OutboundReport: notjunk:1;M01:P0:95dkaEfFUn0=;fTGvt/xhes92BIRBsxOYuV+JGao
 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
 f988z6up1trQPRdA9fLXdgiaGE7AohKRi0MQ==
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
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


