Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9454606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=KKg305gU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMYCZ-00044d-92; Thu, 29 Oct 2026 18:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xMYC8-0003vD-Ml
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:02:05 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xMYC2-0006Wo-Gd
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793311304; x=1793916104; i=deller@gmx.de;
 bh=/ytFg8llYcAFax05RoNhk5LQslOLDQR0UBjmQ9yZlu4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=KKg305gUf6CF9mj/ld0EBMUSbznr4ejKqmu2OuBc7N1sFeQt+a/Sk/Mo9/uQQtWO
 0iNJCdFX0vOJvvJyY8RUAPf2CmXK8S05xjpr59mn43Qm7A+aqTzKHGGi/UMWd9cCw
 IUeEMUS5ArNttZLu3Sdx4cPsVlhaKAvJdYJnvV4fubgbGlcD3uFkxB3AMnSwE67L7
 T3Qf/uAige4wlGi235DeCVpyNDO3XWlMASQuGmOvGOk+MHqlljdu4Ps6y5ndJIPlB
 jGLGNPDP3UPgtjUnqwj/cdiStcMdjG/GdEn5//UZgpZNpPUh1bb0kxemzgmO8lHhz
 5dhOZxdQPipWiWMQeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b6b-1xU0Rh0LeP-000fsi; Thu, 29
 Oct 2026 23:01:44 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v3 08/10] hw/misc/lasi: LASI Harmony Audio presence emulation
Date: Thu, 29 Oct 2026 23:01:33 +0100
Message-ID: <20261029220135.412284-9-deller@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029220135.412284-1-deller@gmx.de>
References: <20261029220135.412284-1-deller@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c0yGCPgt1CT2iH7A47xt2jSJnvEEHRjCpAgv923IfHLEHj/R+HJ
 dNGqdZJoYiJy88/vM1gIHMZZJ2+DX0zIhcGru/oQligfUnmqEeVtOcUKSAQ1dqgVcBqImNJ
 UMMFNAkQq1mFadarpUbor6A49lnb85u4UCfER7UX5vbOIvI5NxFMiIPkuvf46tu3nBk5emG
 QhtzcekFF03bjjX/eDXDA==
UI-OutboundReport: notjunk:1;M01:P0:8/3eiJlRFHM=;XzneDx6WoE5Bk16S3Z3/EyP8nsS
 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
 sMYuaw
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

HP-UX 9 beeps through the harmony audio chip, and it panics if there
isn't one, because the 715/64 has no HIL keyboard to beep through
instead. Emulate the bare minimum of the chip's registers and report a
running audio clock. There's still no sound.
In the long run we plan to add a Harmony driver, but for now this is
sufficient.

Suggested-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/misc/lasi.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/misc/lasi.c b/hw/misc/lasi.c
index f0dfd78b4d..76029804e1 100644
=2D-- a/hw/misc/lasi.c
+++ b/hw/misc/lasi.c
@@ -36,8 +36,7 @@ static bool lasi_chip_mem_valid(void *opaque, hwaddr add=
r,
     case LASI_IAR:
=20
     case LASI_LPT:
-    case LASI_AUDIO:
-    case LASI_AUDIO + 4:
+    case LASI_AUDIO ... LASI_AUDIO + 0xFF:
     case LASI_UART:
     case LASI_LAN:
     case LASI_LAN + 12: /* LASI LAN MAC */
@@ -87,6 +86,13 @@ static MemTxResult lasi_chip_read_with_attrs(void *opaq=
ue, hwaddr addr,
         val =3D s->iar;
         break;
=20
+    case LASI_AUDIO ... LASI_AUDIO + 0xFF:
+        /*
+         * Harmony audio not yet emulated.  DIAG (0x3c) reports a running
+         * sample clock, which HP-UX 9 checks before using the beeper.
+         */
+        val =3D (addr =3D=3D LASI_AUDIO + 0x3c);
+        break;
     case LASI_LPT:
     case LASI_UART:
     case LASI_LAN:
@@ -158,9 +164,8 @@ static MemTxResult lasi_chip_write_with_attrs(void *op=
aque, hwaddr addr,
     case LASI_LPT:
         /* XXX: reset parallel port */
         break;
-    case LASI_AUDIO:
-    case LASI_AUDIO + 4:
-        /* XXX: reset audio port */
+    case LASI_AUDIO ... LASI_AUDIO + 0xFF:
+        /* XXX: Harmony audio is not emulated */
         break;
     case LASI_UART:
         /* XXX: reset serial port */
=2D-=20
2.56.0


