Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE60606A329
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S+h5N8Kt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM8Mv-0005cS-Rz; Wed, 28 Oct 2026 14:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xM8Mh-0005a7-Bk
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:27:14 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xM8Mb-0003Ji-RS
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:27:07 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 53A1743EB5;
 Wed, 28 Oct 2026 18:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13ADD1F01825;
 Wed, 28 Oct 2026 18:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793212024;
 bh=+gnzdvy0CCdCGT8bLxvlqtrh/ZI6VuK7vXYb6nUotf4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=S+h5N8KtFf3DUAC1VtDRFhpg8XDI6jbQZvx8z3p9qlU685KS6BC1gkTnwbbpYsDq4
 1cDtaspDj2HMk0JSPDgqYqpgkB0eSC0+iVarcgJOEvrmhJUtu1c4e2O/YAj3EoI8L9
 DWyC8fqg/kUlkYHQXVSmgLKNmzI5+BaYa1lpHKqUe7OWCzAk/+nLFExMI7zZbkiiA8
 8V0N1C//KLXCwYpMlt4mJN1bsr7EHti2ImITSD3olLOVpNzUPQbfQ8mSeMiAuRrNBc
 aqugN2A2jA2SmVts1DWc8mX3F2UaGvIWY2uRpMi46rUKS45APYuPgdEXDSWmKYeLAe
 ULJr6L88wOjQw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 6/9] artist: Redraw screen on colormap changes
Date: Wed, 28 Oct 2026 19:26:48 +0100
Message-ID: <20261028182651.5950-7-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028182651.5950-1-deller@kernel.org>
References: <20261028182651.5950-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Monahan <keith@techtravels.org>

Invalidate screen on colormap change, as it affects every pixel on screen.
This fixes VUE GUI on HP-UX 9.05.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/display/artist.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 288d466ec6..300ad40e72 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -855,6 +855,12 @@ static int vram_bit_write(ARTISTState *s, uint32_t pos, int posy,
         vram_write_bufidx(s) == ARTIST_BUFFER_CURSOR2) {
         artist_invalidate_cursor(s);
     }
+
+    if (vram_write_bufidx(s) == ARTIST_BUFFER_CMAP) {
+        /* A colormap change affects every pixel on screen. */
+        artist_invalidate(s);
+    }
+
     return pos;
 }
 
-- 
2.54.0


