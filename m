Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB736606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Ey2XG3K/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN4Si-0001lN-76; Sat, 31 Oct 2026 04:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xN4SX-0001jF-Sf
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:29:06 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xN4SV-0001sP-3l
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793435340; x=1794040140; i=deller@gmx.de;
 bh=Bf5fL3ZdKn+Lnz5iOUislhUhjwKLDe3hOtmZp4wbrTU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Ey2XG3K/WcZphCX5xK4UCgtPZ4u84CHKXj+j85QiSILUDcUm+Blu+H4l/JIWXggx
 d0DDDgVxAR3k56cyIbisVUgVOckqJ68orWosTeF+AL9+Ig8kE5JcYSv2XEn/ZgTHk
 j2H/pCeyu+VcLR4MHwiKM7HhLndJexbDkLdLuNFUO9ShsuV8WyKboss2BOY73RB8Q
 0G3ZYZ2Hi/WOwz07evhW6f+B7Xv7ce2abVyIve8brBRASWrRy6BxgksbiJ/wUFmZG
 MFEwCiSSQrHBUO/sQtY/Lx3uEIoU8sLpU1Q0fcwXy8KVyEzIrEj2wv+eO2JFQJKSo
 EdUZccIouZzQCQlZBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJVHU-1x7kUm0k6S-00QTgT; Sat, 31
 Oct 2026 09:29:00 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Fabiano Rosas <farosas@suse.de>,
 "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v3 07/10] artist: Redraw screen on colormap changes
Date: Sat, 31 Oct 2026 09:28:47 +0100
Message-ID: <20261031082850.439293-8-deller@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031082850.439293-1-deller@gmx.de>
References: <20261031082850.439293-1-deller@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9kQezSaaq2hyMzCM/ZQfbgyPRglinnCe19zzJ++CLZIXFhH73k1
 gW8FgZPswEjWGWlqrweydAp1lzoCUTJ0JYyxBOs8RtMfPneCFNbeG/wubK0spPuVcDduYfB
 KemJtdjsB2oXXBUdgBMXNK0lNkiUri+JLnZOJSBimFrtxRcI0j3AKdqt4y/mafEInIQb3fQ
 7VJ0YbUl5REXfkBZ2+vaA==
UI-OutboundReport: notjunk:1;M01:P0:fTxaI7piiNs=;TDe4BwdArOGgJccFngYNOzuKDfD
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


