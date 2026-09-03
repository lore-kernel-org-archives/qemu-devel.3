Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C387C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2606-0003p0-Ht; Thu, 03 Sep 2026 07:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x2601-0003ii-Lk; Thu, 03 Sep 2026 07:52:57 -0400
Received: from mx1.catap.net ([2a01:4f8:271:125e::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x2600-0002hD-0Y; Thu, 03 Sep 2026 07:52:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=mkxIAet
 Ae2rPfCniM5YpP4wcj1aTEzLB9fcaa+dqTjsFGXL3uObNsSu0mCk/ECSJELhJU4VuQ9OcV
 CCi1sbJtemLvC8JymKpyR7FQzAR151A013PXkkHyVD3bC3ZADkK1Hlsi32mT9QuMFThZnl
 pir0rLV53k5ElOrtZBGD8czthJNuehLNxa0KQrRxJxsI3cIRgNKjtApSo8cCRjbOs98NaM
 ctITy9AdgEbPT04+0fUVUhmKLwiLGWrvzi4f70h5xNxM0cipW4AVs9Qrjp1fnNCxvZpEOL
 P1go4+5LiXMGQUwMJNUOFrTwmNhT2GuuSAI6ZFEirhNI52P3qjhC/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=k
 oHFNGi4Fw3yPpaGm3FaF7mlvXRBicgrFjENxa3+hOw=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=MCwud1Dl3Y1Kstp4aYEZPa3ctrn/5E2Sr5RqzeZAcuvXgIMJWtEwy3VH9Nf96x6WakQw
 wn1cwEBIQfW0g0Fj0Y8IYs5Djuy1K87vUbnMjt8NATqY6QfM29FeOVSlZH69sFgkDQ2gaZ
 Qkvh4/lQdMkS62YenIP4uDjiA/Kb1S4BWE/JpW+Xecp2IhgABjUcQ/mIZvD1rmSnmDMRzP
 KjpFbEzL0idTyGSXMBXE7XchI9F5Y0VacpsOgaYlRCs5IDM1SurSDvphUC/wRo5ondu4ew
 5kaByfYMnzoe0KIp8wreAo82UHmJQ8T3uxmJL87AUiwgeMD1J0YdTyy+Yaur2fPw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=NVbsQ3/e; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=QI+SDLrs;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=koHFNGi4
 Fw3yPpaGm3FaF7mlvXRBicgrFjENxa3+hOw=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=NVbsQ3/eRgR2bURBDLS6Dd1qglKLM2dFOaS
 zQX5GG6crSY2+TiW6GFT0ANAfbxiKtXKy/r+dGUIJAiKA6HK9zZTheRSXPJ5z7QlbWhqUA
 iYYGegfoMk/uOJtHAxs1bn2iXK8kuHJABq6+6oceGF0afSt6BPrwsvgVUJUjFDpw2ODDgu
 N1sJGQyZejsr2oDmwPJ3w0r6u60OGWwYd0PBnCgR0n74QL2aEqRjKIvDH3Z0dMyPYcjvri
 5szH81PqmKjgvysd/mp6gnvq0X8DGN0Za5KtQC8ArJ1oY16eloUe4jhMc7k2gm72Z549DT
 h+PKcTYsGtEkmcNY4b70S6TFC1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=koHFNGi4Fw3yPpaGm3FaF7mlvXRBicgrFjENxa3+hOw=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=QI+SDLrsxIH2zBJ4UA
 bB6Y0DxACiFGOyjuCMl2kpE7NUTAQyQk5/yVg6Zb1/hmzdIVC00+dLNYSILHs/PDRpBg==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 80a74f4f
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 3 Sep 2026 13:52:50 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 63054464;
 Thu, 3 Sep 2026 13:52:47 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH 3/5] cuda: Include command in successful ADB replies
Date: Thu,  3 Sep 2026 13:50:28 +0200
Message-ID: <20260903115229.95811-4-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903115229.95811-1-kirill@korins.ky>
References: <20260903115229.95811-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:271:125e::2;
 envelope-from=kirill@korins.ky; helo=mx1.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

OpenBSD and Linux expect the ADB command between the CUDA status and
reply data. QEMU omits it on success, so guests consume the first data
byte as the command and lose it from the reply.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/misc/macio/cuda.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 312dde242b..ccb3e1d74b 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -431,11 +431,12 @@ static void cuda_receive_packet_from_host(CUDAState *s,
         {
             uint8_t obuf[ADB_MAX_OUT_LEN + 3];
             int olen;
-            olen = adb_request(&s->adb_bus, obuf + 2, data + 1, len - 1);
+            olen = adb_request(&s->adb_bus, obuf + 3, data + 1, len - 1);
             if (olen > 0) {
                 obuf[0] = ADB_PACKET;
                 obuf[1] = 0x00;
-                cuda_send_packet_to_host(s, obuf, olen + 2);
+                obuf[2] = data[1];
+                cuda_send_packet_to_host(s, obuf, olen + 3);
             } else {
                 /* error */
                 obuf[0] = ADB_PACKET;
-- 
2.55.0


