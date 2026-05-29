Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A78CCD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT57k-0006Cy-Ep; Fri, 29 May 2026 17:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57d-00068x-NZ; Fri, 29 May 2026 17:52:05 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wT57b-0007aA-VB; Fri, 29 May 2026 17:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780091504; x=1780696304; i=deller@gmx.de;
 bh=gODMNuhvgHlBYZzBASbq0dpAQ0bio20BLo7tEclCz6Y=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=bLRm6qvco883xx8kmePPhAFZI1QGXKlEE+yJtMzZVSyI80gZjhOd8y57o2JAC+1J
 90ehxj62wQ2X9F/GINLHaI8SPFerXemAeawH8L0yjUA4Ah2RckyRfFfn/lyhkwRfG
 7H8E+n2rz46/A+1NmxeB4F9JTvrtC7kxyY7b4yP8LDQwSZV7t3bh7OL0gKrvr5oGk
 jEQnEqKmk/MfDXeF/45mtIXBAiYNMcH+RBoxlOe3ZuogFPPnt/thxA7KUIeC7/Lml
 RSvOn1wJQL4ivqI8ud9Ps4+zWnTtIVJ1KK6BRd9s5KBYnbxr0I0v1wVyeeSCMUqVq
 E0Pn+Y/gTVOHzEY3CA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mn2WF-1xC4y02EER-00qHGm; Fri, 29
 May 2026 23:51:43 +0200
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
Subject: [PULL v3 05/10] target/sh4: sync fp_status when gdb writes FPSCR
Date: Fri, 29 May 2026 23:51:14 +0200
Message-ID: <20260529215119.73244-6-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529215119.73244-1-deller@gmx.de>
References: <20260529215119.73244-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V6YLi6Ub9WQBpXA/QK0CbcAyO6zuNEktATsXrJgrm72llwa0fxr
 0eZ0KBqB4PTOGzQO7AGpzzvoWHL3xPnYquX3ZAaIXO7XqrmUh11yAqcDfzmKC/QjloHIK31
 ofwuuw9vtAOHesMQbDsRq/Cn8uRZlF0rNfjs9ORSS7rh8jUyaFngzVqhZH4e/HFa8R/MEd1
 kZ4joBU0abVUeQ4gZyIAA==
UI-OutboundReport: notjunk:1;M01:P0:AR6l39y6T+s=;sG3cdeX8p5nksV8KnpqBmOFcmxB
 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
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
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

sh4_cpu_gdb_write_register() wrote the incoming FPSCR value straight
into env->fpscr, leaving the derived env->fp_status (rounding mode and
flush-to-zero) stale, so a gdb-initiated FPSCR change did not take
effect for subsequent FP operations. Use cpu_load_fpscr() instead, the
same way the adjacent case already uses cpu_write_sr() for SR.

Cc: qemu-stable@nongnu.org
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 target/sh4/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/gdbstub.c b/target/sh4/gdbstub.c
index 4f36e800d2..bdc8c1d164 100644
=2D-- a/target/sh4/gdbstub.c
+++ b/target/sh4/gdbstub.c
@@ -113,7 +113,7 @@ int superh_cpu_gdb_write_register(CPUState *cs, uint8_=
t *mem_buf, int n)
         env->fpul =3D ldl_p(mem_buf);
         break;
     case 24:
-        env->fpscr =3D ldl_p(mem_buf);
+        cpu_load_fpscr(env, ldl_p(mem_buf));
         break;
     case 25 ... 40:
         if (env->fpscr & FPSCR_FR) {
=2D-=20
2.54.0


