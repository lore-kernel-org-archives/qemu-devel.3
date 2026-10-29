Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C4E606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=K9OA9KXg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMYCO-0003zq-H9; Thu, 29 Oct 2026 18:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xMYC5-0003v6-JZ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:02:01 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xMYC2-0006WR-Fr
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793311303; x=1793916103; i=deller@gmx.de;
 bh=Bf5fL3ZdKn+Lnz5iOUislhUhjwKLDe3hOtmZp4wbrTU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=K9OA9KXg5NIRgnWaqe13cjHUBiyg7SjCnNL5OkjUZzC/QZ++O8aS9veNbzzQ4v2J
 w6Gxp+ahLgZ0cekDeNCN6cPh3cEy/V/LQGFJd9Z0owXAJR32pkgadmv6i+GtBAJ6L
 ewL2QEQIGuStE5jPRhkWsrrc7rQf9u/ysiKjTzxWisYzI2OESgRok8OC4lHpESQco
 98/OM7RiIwqBUKhnWjrA4uBgpkY5jqrfewZUiMVrf6prvLpN4eyU86gte3VbkG+mi
 rNnWopstxlTgTEPO90nJve525/nzwtWr1D2PIleKJXclWqwLcqyVzCEcgaf0CWuZJ
 ahXtkqPsr0vmGFJTKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mn2aN-1wejGC1gCV-00ook2; Thu, 29
 Oct 2026 23:01:43 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v3 07/10] artist: Redraw screen on colormap changes
Date: Thu, 29 Oct 2026 23:01:32 +0100
Message-ID: <20261029220135.412284-8-deller@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029220135.412284-1-deller@gmx.de>
References: <20261029220135.412284-1-deller@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Cn5RBDmfli71QQRLDKcM9kv86P4GYBmn7pxVo+UoAX4B28ioH/R
 4RkNYtiugqjd9W6bpgWbte0pVUglg1orFXTXK/HKOFxopzIXoDVDyjB+fqm1vYxHzkZGcQx
 6erS8YbRV0A5wiGndssLrWbkcJfITCRwCTjUyzJtvrbttqlpbUvxGoAk7uF4w5vb1Lk6WKD
 DI0/IdHiC9VlLb4o2SZRA==
UI-OutboundReport: notjunk:1;M01:P0:noY45wiuBZE=;OMSFwRngxgtYkZMAtIrmPOVSvAd
 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
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

Invalidate screen on colormap change, as it affects every pixel on screen.
This fixes VUE GUI on HP-UX 9.05.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/display/artist.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 288d466ec6..300ad40e72 100644
=2D-- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -855,6 +855,12 @@ static int vram_bit_write(ARTISTState *s, uint32_t po=
s, int posy,
         vram_write_bufidx(s) =3D=3D ARTIST_BUFFER_CURSOR2) {
         artist_invalidate_cursor(s);
     }
+
+    if (vram_write_bufidx(s) =3D=3D ARTIST_BUFFER_CMAP) {
+        /* A colormap change affects every pixel on screen. */
+        artist_invalidate(s);
+    }
+
     return pos;
 }
=20
=2D-=20
2.56.0


