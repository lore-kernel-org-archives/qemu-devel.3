Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD13CD6E51
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT57l-0006E9-EA; Fri, 29 May 2026 17:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57f-00069p-Hd; Fri, 29 May 2026 17:52:08 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57d-0007ac-CR; Fri, 29 May 2026 17:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780091495; x=1780696295; i=deller@gmx.de;
 bh=arHu2vPzOJK4EjB5mG+HarlYnmZ50qWksR9QmMZvlpQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=cPFMsrkg/ByVbG1z0HTN8bqlLHezoDXN+VyeA4p/K+ztgu7G1exE6jrJTir83rmr
 w+GYcf5OOqhnz9TBlKkoO9PLeG09tk/BoWtZCbtN1iAOfDk/IZz0FqZYkmevcgXRZ
 ZAAkdUJlfHZiDBpwAjoau/cezEg8b2jV/xnf53RvMBg3xUgtMx601BI9nL+zNHeu3
 2CQ60OYxN2GGdjf2AiWT/UxBSSsWZS1MyALYyoRudwlNY9rrxn08sY5LYHuuEaahZ
 WKZBGyMGmJoqWHc4M8aXqKtdVY0LUknAVNkB3k3Lm+VTx59PL4Iwx9PtrRwlLexu1
 dGZ+VLs1X5FPScyF7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIdeX-1wYufL2VW9-00CFgU; Fri, 29
 May 2026 23:51:34 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@kernel.org>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Matt Turner <mattst88@gmail.com>,
 qemu-stable@nongnu.org
Subject: [PULL v3 01/10] linux-user/ppc: restore fp_status from FPSCR on
 sigreturn
Date: Fri, 29 May 2026 23:51:10 +0200
Message-ID: <20260529215119.73244-2-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529215119.73244-1-deller@gmx.de>
References: <20260529215119.73244-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/stq796Y+IuQ6HW10CT39UfCPfQidYLxhKtLaHYfZksbN05eQKJ
 +/RneQWHxwJaEdipvw6N/LUXe6XrQ63WmzAsX7wcxhGx+cB9ptQY5m4sd8JLdNQ2G+f54R8
 KOZaGaCS2lw3/dqXErfUG2TjZYeZDWINT31jNsWMY4X4/n6m9i2jjyuj15AS1EVsgSnEgLn
 5hm9UFXvh6l2nfNWqX67w==
UI-OutboundReport: notjunk:1;M01:P0:ppwC5E++3zE=;3dCuHpWdoEY06n/Oq4fGJVO5cN0
 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
 oGHczO8K1DbmzgguGk=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Matt Turner <mattst88@gmail.com>

restore_user_regs() restores the PPC FPSCR with a direct assignment:

    env->fpscr =3D (uint32_t) fpscr;

ppc_store_fpscr() exists precisely to write FPSCR and keep the derived
env->fp_status in sync: it calls fpscr_set_rounding_mode() to update
the softfloat rounding mode, and set_float_rebias_overflow/underflow()
to reflect the FP_OE/FP_UE enable bits.  The direct assignment bypasses
all of this.

On sigreturn, interrupted code resumes with whatever rounding mode and
overflow/underflow-rebias state the signal handler last installed in
fp_status, rather than the state that was saved at signal delivery.

Replace the direct assign with ppc_store_fpscr().  The FPSCR_MTFS_MASK
applied inside ppc_store_fpscr() only excludes the computed FP_FEX and
FP_VX bits, which it re-derives correctly from the exception and enable
bits in the restored value.

Fixes: bcd4933a23 ("linux-user: ppc signal handling")
Cc: qemu-stable@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/ppc/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index a9c10e0987..ab1afea30a 100644
=2D-- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -420,7 +420,7 @@ static void restore_user_regs(CPUPPCState *env,
             __get_user(*fpr, &frame->mc_fregs[i]);
         }
         __get_user(fpscr, &frame->mc_fregs[32]);
-        env->fpscr =3D (uint32_t) fpscr;
+        ppc_store_fpscr(env, (uint32_t) fpscr);
     }
=20
 #if !defined(TARGET_PPC64)
=2D-=20
2.54.0


