Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9BAD29DF7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 10:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfbFV-0000qn-Uj; Tue, 13 Jan 2026 05:03:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vfbFJ-0000ou-2o
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:03:32 -0500
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vfbFG-0006qY-2k
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1768298601; x=1768903401; i=laurent@vivier.eu;
 bh=HSbgJ/1VS+TqTvkTZnifrLNWcol7TXzwMJEBDNjkg/8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=nkfPXF3MJ2shkXoNL0wBJ5TJnQuGzlN/4F73GX16T2McW7o4sjIotja60OPhlKfB
 voxrsl8plPvBemnAwvMFOkFF7SfhyjmmedbBeNevuGXJLWamkinzWHj1HvWLSgZkQ
 70+olc6tgz9XZlUzaywdoecsL4GE7lKwMzBy7fymebx6GuQUWakfKAg/UR85Iv0Fi
 DaQzOysggcHtiimKdRZcQbKjf/egC7J5lvjsHG0JrUT6Zf2jaYmG6s6DHAT1VTrH+
 uplt5kW8pLcq9+Ppph9Tg8oxE0FbgapiHZKwlXGOzCxblJB+LjsPD6JFrdO0hrOpn
 qP0qLSsASKhVcnF8dw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from quad ([82.64.211.94]) by mrelayeu.kundenserver.de (mreue010
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N7Qkv-1vuOV20MJB-00zjlG; Tue, 13
 Jan 2026 11:03:21 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/3] m68k: fix CAS2 writeback when Dc1==Dc2
Date: Tue, 13 Jan 2026 11:03:18 +0100
Message-ID: <20260113100320.1009608-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113100320.1009608-1-laurent@vivier.eu>
References: <20260113100320.1009608-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mLQJucg1R8OfkwrTVD4IsH3WLcRtmDjD49oeDnz3000c9+/e9O/
 fKmlC2CehyX2nwTYweWjVpWuNL/VdUzUJzVuMjQzWetHexaMgmLsEfsIYzfec9xS0V73c99
 zDWPhLxtw1UDxXH5TAfRbkLgx9eYD8P3f3/zZaXZn0cUWpKh2cQc+v1TkqboClsJ00c6w0b
 6OpTPvo4dOaYP+MEhMvbA==
UI-OutboundReport: notjunk:1;M01:P0:sTCnfeH6X9c=;vrQEfCflQVIU8ZdXwNhCpbMt4PJ
 SmPpgu0+bztKTje1AGu/ahk7LVwIULLChthsAfhgYGvvhc2ztv1vd1loZRwZRWCmTrIZz4Nvc
 5XwTtdTJLc97Ei5yYDx9MQA9QuClvJ0TwYz8gHbVe2xxMVNDwl7hEhTYWxA0RXAQzbJ60DvlD
 NTNucCS+kVeHnW9wuajDtSSGYvBhqvSzbMe3BGQ3YGiKmPj3XFeiJM9EMcXUDZ8/rRpRiET9g
 wQDfKclrRGg2MpwcEa55VODn5tOc8NrIeKsHQtsIyD8nUnC1ytocVQwKhRVJjUQIfCCudwvLj
 +KWnQjncfgBDFX3Oz62o4vLjGHJMGruFQ3vzWJfbmMQcHbA6jywE73Y96M8ZHky1gcCVAsJlf
 7kibNCzyZsVd+m8HDf0jrW3tvzLmMpljS0ukz2c0vF5Lvq81ludn+LcAuGzjbeQVOwwKnGy0z
 bnYupNWwYPuDo02gDfQMkrzb6wUcKz49tum/6Fdu5efk1msDxOf/aUZgUDhirI7QGsmVdJkX1
 +qGii89pj8FpTXE2pT8Mc/F7zoW40b17iIinXagEsn6ciAO+c4Hb20TD1KXDfpg9XFgZ5QsCy
 ex0IU0de+TOzaAt847V0s8VelZCdp7qHL7rBLGGGJ+NMh4/+pTQVEsqTTSKG23y4pqUeJjAL0
 SizGPYNwJwKwmbYqP4eELwPzbkyd3W11pjE5Az5I8RIsiSiF/mTbMrfpJFleNZJh5kXMAdOXk
 Xrvce2qr9A1rNd0FuwlaFqqpNmFNi0XFIfHL2gF3tVs1lz/7yNNjarKndhuTDPjXYMZUtrhdf
 Nu+CaJpXN2ejv4t1TRmZVcyNkIKGaAVgcOC235O2HJ4SCdqqXvRODTS3YygothKr9cQtsy7fM
 A6Y9l4VQs9MdzwBNvT0eM706QwnrdUZeXZYAFoCWoKzxD8PdEiC7z4QWV4muUHgHD8BdEl4QM
 nRoJebJ64oW8j+t7UVZqCwOQl4c4nmyj2wyHj7gpLecyzI3xBEc+y6key21ZwchA4LJ5C3x+2
 1NMptqiIZ1Ddyy6uKW+/vVs3DkbgR6ukIxTDx+/r6kdxs08bQeM5FBTh2koi/DVq61298DodG
 0XXTdhfsQk7YYcKRxbrKwMSO0wy9Dvtpd1r9Vu39wP/NBYlwfLFVEaKDE2WfbHnEV/2uocUoy
 xAlyjhRj0Aq979GwFjP/4omN5Qw17ti9fkXRf/MUSeyS1wtIqZtxk3f3TlWFI8uU+/ETOmroP
 zHJqK7tx/PwSnMstc8sQddhIdnupeNOGz9nFaAgylSHKmX0BMhLsaH+QZci1NLwDh/9hxlqIx
 dlnfqwqNXIRQLrN2NuC8Ud+kheMAqFl8xSOCUofv/Ns5pAE3gJsqHupa8aEB+5oYLi37PNoR/
 YIC4iRL7IytQMl8uDCzSO3YcBZ8mY2dEecshD0RFR8bkOXQw9SoG+p8TO6dXrqBmJO3GAJExF
 4liL/YuNn4pr4Z/2TKu5knAD66sAJJMnnhkMbm9qY8RJXaD6FYqNNP9TGe+uIcM0GlMXzCV46
 ME7LBmGmRWRxSDS07Unkm348fqsCFJduvezR26GU2DguxLP8VkQxaQWRXgcmjV08xQbH532U+
 WoiIbsBE3mDGM+I0TxKZsdYFDRAVHR7pFtr/jwkrMYGPIMpnxgh1FEeRkGFVvgMZlRI1jUYYb
 n8pBzGQPByYAmTjRbOsh/aLuGVj0LeA+3W9ac40KC+Tgp8b/GGmy6RAwf+e9D+MXxArYI1lqn
 oj6ISMgglUgRqr7p2Gz3hGIpr6ycttYbjgoMIc+2VOJP2MNbF6fLWFv0=
Received-SPF: pass client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

According to Programmer's Reference Manual, if Dc1 and Dc2 specify the
same data register and the comparison fails, memory operand 1 is stored
in the data register.

The current helpers wrote Dc1 then Dc2, leaving operand 2 in the shared
register.

Swap the writeback order for cas2w/cas2l so memory operand 1 wins.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251226213707.331741-1-laurent@vivier.eu>
=2D--
 target/m68k/op_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index e9c20a8e0322..10266b1e0e8b 100644
=2D-- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -799,8 +799,8 @@ void HELPER(cas2w)(CPUM68KState *env, uint32_t regs, u=
int32_t a1, uint32_t a2)
         env->cc_v =3D c2;
     }
     env->cc_op =3D CC_OP_CMPW;
-    env->dregs[Dc1] =3D deposit32(env->dregs[Dc1], 0, 16, l1);
     env->dregs[Dc2] =3D deposit32(env->dregs[Dc2], 0, 16, l2);
+    env->dregs[Dc1] =3D deposit32(env->dregs[Dc1], 0, 16, l1);
 }
=20
 static void do_cas2l(CPUM68KState *env, uint32_t regs, uint32_t a1, uint3=
2_t a2,
@@ -861,8 +861,8 @@ static void do_cas2l(CPUM68KState *env, uint32_t regs,=
 uint32_t a1, uint32_t a2,
         env->cc_v =3D c2;
     }
     env->cc_op =3D CC_OP_CMPL;
-    env->dregs[Dc1] =3D l1;
     env->dregs[Dc2] =3D l2;
+    env->dregs[Dc1] =3D l1;
 }
=20
 void HELPER(cas2l)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_=
t a2)
=2D-=20
2.52.0


