Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31CD606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=jTCbPzBv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN4T6-0001ot-9F; Sat, 31 Oct 2026 04:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xN4SY-0001jH-1Y
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:29:07 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xN4SV-0001se-45
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793435341; x=1794040141; i=deller@gmx.de;
 bh=/ytFg8llYcAFax05RoNhk5LQslOLDQR0UBjmQ9yZlu4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=jTCbPzBvLapFkKtSXkiZMONOQLELPh7AyUjspt2fa8ONZ147iOsuLHTjkU905NQ7
 ZStdju23SZ+pgpjyKO3UAlN3VMR9Zqss7OTtDQzJY9617B1zo5hKqC8N1oVRrGYSr
 x9tU9JmHlwLI/Hvm7qhtmbl0qnCvaN/GEh8EcgcjcbCDR11dH6kxD4rqsqCExZav6
 V/Y1ouUH43XG2FXw/Tbv1YqCOWwFANp4+TpVWa6ZPaNIcIeNAKODOQaVfbJ9AsV3y
 LAblnMU8I8vHzwPc7boXBqv0Qk7BpZ2k8ytKvJobnX5dixItmYI+b61OWJF0fuDnu
 2YcRegEyTPNQBLyuDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0XD2-1wZW930WHs-017WbZ; Sat, 31
 Oct 2026 09:29:01 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Fabiano Rosas <farosas@suse.de>,
 "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v3 08/10] hw/misc/lasi: LASI Harmony Audio presence emulation
Date: Sat, 31 Oct 2026 09:28:48 +0100
Message-ID: <20261031082850.439293-9-deller@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031082850.439293-1-deller@gmx.de>
References: <20261031082850.439293-1-deller@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1mFZthQ8EjJY9N8ZzwPjoYgeqmhl+P6u2S6ttkWTzyG8yLkqcwO
 aV0rkGpsfvDHrumEzzD/MRAdeGuubs9BHU7DMG3yQDiSLYO07tBlj8TSo2rvIwm7AqVCCYX
 050h/+lf3g+Yg7hCccZqoZn/dYrwD6s7E3/DrEp57G+pvQ0qaGExsC1NgLlZPnWmJ6wHW7i
 csZSiUrzRSHWHG/pWVi6A==
UI-OutboundReport: notjunk:1;M01:P0:w0zE8g5bH8Q=;boXH+jGytlhMZIuRn17zNeM7/Jy
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


