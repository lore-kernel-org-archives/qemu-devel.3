Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECCCCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 22:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSjDr-0002wE-9M; Thu, 28 May 2026 18:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjDp-0002up-Hi; Thu, 28 May 2026 18:29:01 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjDn-0006wV-RJ; Thu, 28 May 2026 18:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780007322; x=1780612122; i=deller@gmx.de;
 bh=arHu2vPzOJK4EjB5mG+HarlYnmZ50qWksR9QmMZvlpQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=d9MJAmUQJFgju1IPEpurmyFowkic/JZRXWykjb25psqP7oWmrS4Vbi2LVGN3kl2V
 DWbH2dU725RaSAoi4TOcAp78jmxm2nVuAUzqUqojAPzQR5V/bXi2WwXKxHtghrDXf
 qH7ja+uOLkHdGsNEu2HRL90D0EWD4xFi1ti/1dG0KMeie7DuCrp2FWpVOTy62FkEW
 SgF0EOF+uzwvla3TdKG9nOMhK+R7+EcR5fC6Kwft5YzhgwZA40rgN1VWoeF+4kEFH
 eNjXFpXJ/giwUVO5nrhtLYP8s+wxcaWOBoVVGYB9lBEKPiFeDRSCcmrTzJ/dtWlAg
 Y9sx89EXz3mjrGqxIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4Qwg-1xToCd31ra-018Djk; Fri, 29
 May 2026 00:28:41 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Helge Deller <deller@gmx.de>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Matt Turner <mattst88@gmail.com>,
 qemu-stable@nongnu.org
Subject: [PULL v2 01/10] linux-user/ppc: restore fp_status from FPSCR on
 sigreturn
Date: Fri, 29 May 2026 02:25:38 +0200
Message-ID: <20260529002548.19293-2-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529002548.19293-1-deller@gmx.de>
References: <20260529002548.19293-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GeH1Edu/dVPgY6IX6EJs3niglT3o/RzbU7go1BttdgIbg/UMajg
 UJpdmgmevGJCmLoriBIN4Q+Dy3Y4RdDz/NNtM2sukLxwvx9xEhP55qWt3qsmthvI2HEEKw+
 Z90X5cAsabV3vxrrLAIIG5LGpknVw8MRbgYRzfQp38Fks/1QACCq3UhZYvojZqZ4klL2EcY
 RI9gvyzIYcawQvtyAZSnA==
UI-OutboundReport: notjunk:1;M01:P0:hXm3jv8ksuE=;MqtFlG92BZgIxVDD3TgugrZrbq3
 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
 qZUf+pFuyv+3OS/GV0=
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


