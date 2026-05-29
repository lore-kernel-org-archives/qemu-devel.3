Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CBCCD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 22:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSjDn-0002ti-Tq; Thu, 28 May 2026 18:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjDm-0002sR-40; Thu, 28 May 2026 18:28:58 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wSjDk-0006vb-BQ; Thu, 28 May 2026 18:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780007329; x=1780612129; i=deller@gmx.de;
 bh=gODMNuhvgHlBYZzBASbq0dpAQ0bio20BLo7tEclCz6Y=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Q09S8W2YAPCxeDuiLTUs46Q/Y/CYrRGoh1OTnCYW0fE5Sjxwi8YI/aYYghRUYUBW
 crM1A3/St3oGPZnF3CNCk4PmCa0XnXh1thPmp9JsGti/ZFgd13/QzjD9jO23gc4Ma
 BdSoBC2fCgwYdCZvr2T067ocAjwz8Y86gCqBBLBvPOu3/pmyBfzxs+aK3wApGgXbu
 wTBSWD4oTi8ib5yPCViJ+umBBWveLom+hCsBL/alWOgkQuokKFWGz7qFBXlxUspBQ
 une/vW1D+mynurcuxbNjQTIs4RqybXovU0hXse0owWCplbbS2gFVrOYbY0bu65oeK
 m+eHp0BIgtCuW2HugQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89Gt-1wPAig0XVD-002vwD; Fri, 29
 May 2026 00:28:49 +0200
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
Subject: [PULL v2 05/10] target/sh4: sync fp_status when gdb writes FPSCR
Date: Fri, 29 May 2026 02:25:42 +0200
Message-ID: <20260529002548.19293-6-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529002548.19293-1-deller@gmx.de>
References: <20260529002548.19293-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W4FNIMpIi4c0d7e5SnZ8pdrdP9lTYtzshEh5UYarQXDyLsS4aHY
 ghgGoFgLgjY5jGRsVCkZ9Y1rqeVvwuFp6oMQo7DomKimgxcAKzO7KNMV62VUbchT7qUlkix
 J/B6Pk3Ki+n9fE2ZglwU3tsv+LvNeCwiUwygIfNi+9xzU6l5MD9CqJsSclaYFE+axzx6Pn3
 IFqzbvbB3AH/9tbKONVgQ==
UI-OutboundReport: notjunk:1;M01:P0:grGwnsyFAUU=;lXuTlQ5GU2ZEb209r38+A6G9WqV
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


