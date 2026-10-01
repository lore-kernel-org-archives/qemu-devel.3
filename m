Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4755CA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 23:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCPmT-0004RF-GW; Thu, 01 Oct 2026 19:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1xCPmE-0004Np-0l; Thu, 01 Oct 2026 19:01:23 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1xCPmB-0007jM-Qz; Thu, 01 Oct 2026 19:01:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=ftwxGnX
 N4MFJk9QaRk9gjcAgizFyBCUnNKypfgzy1yFFLXWRdFcgduI+4xjiguWWwWycZAInoT+po
 ntLPezLiGpN1X+gt5mnNz9oDkDTvwKquzOGAl+WMyIq/cURxNsph6L+53tKPpHABHRsuch
 ZI2xp2v3PD+grySI7F9GYP6rYNotWbs24WuZQ1q+5nUx5BgPYzLYMrAkPGgpnUv/SbrR2R
 csXF7ZOH+0MCk3YjNg313mpRfsuax+1NoucZshJkLMD0r18kxIC4nZHArKLogZUEiJQbkH
 tL8LFWRryCtQ1izyy24NtVpJ+0Z+jR2NrKvY6dsrT2livuKXWYGiILA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=0
 VvGzzvtw6mkJpUk2FBAT6jJyveAIEvnR/DUkN/2r+c=;
 h=references:in-reply-to:
 date:subject:to:from:dkim-signature:dkim-signature; d=mx.catap.net; b=
 lgi7mJGU0jXkdAoyHrUamLiWrHwHdfkdeSi85a4GlsqsKpWGWr1dpZH98RNnTSmgfcwuF4
 UFyMD87czxLNmj4fEfLe3r8HSB/VcTj3UMUSLtrmCWYVx52VWY+y43U44chlAohTsWRXkE
 XHOx0hRZDTKOI/DpNPFhyMwrui/a7Ld+StY3aj2VOFnUZK0wrggutGTNI9X3fN2psFENOe
 17EFnzX4gjA8bA05H9GnAM3vnhUS72LjGaSTwZ6xtMA3lUJCqINSSdOX/zXbvrbj1CsgI5
 FAItm3vUnFXxL8H8bCP03KEmXuiIQkOF2uL1BUtlMUGvam71B7K+QTn6+pdyEQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=Z4IwGeSD; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=mwZVB5KX;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=0VvGzzvt
 w6mkJpUk2FBAT6jJyveAIEvnR/DUkN/2r+c=;
 h=references:in-reply-to:date:
 subject:to:from; d=korins.ky; b=Z4IwGeSD4uu0QIPf6R9xep8Rgn3eeLJTneBK54
 QUyh7uLTVnaEfCq8D2Dd7PkycNL/3FVaAFch5eL9N7tnq9cz4Dbv0kiwz4anqnePyBJ31/
 /uzH/pMfwpXnrcWiACqSjDK7e9Lws8ASP2poV8wAaWr5xlCTqUXN1GszAh04hilFbAooKe
 x1xUJHtPtGX5wq2Q976sL4hmyvkz5oUkYlTTCecUAjV6oKTkka48AXwH7p1sNzMJpW33In
 7jWJZV/9Mlv+BoHoJrVAmoG9vVQsaDIsxtY9xi4YcvWywh9O4fwomg/72gJ7IRNkhu+dNS
 V5E57v428NJEScxhM67mexkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=0VvGzzvtw6mkJpUk2FBAT6jJyveAIEvnR/DUkN/2r+c=; h=references:
 in-reply-to:date:subject:to:from; d=korins.ky; b=mwZVB5KXzHkpz9Z4pQp1B
 EOz91I5eH7f/qakemm+Dj3UUMLqHJqp+XtnVBi8dQGfyKsF95ILb4eA/jXqJo6BBg==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id b8e0d167
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Fri, 2 Oct 2026 01:01:10 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 0fcfc3c6;
 Fri, 2 Oct 2026 01:01:07 +0200 (CEST)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Kirill A. Korinsky" <kirill@korins.ky>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Miles Glenn <milesg@linux.ibm.com>
Subject: [PATCH v3 3/5] cuda: Include command in successful ADB replies
Date: Fri,  2 Oct 2026 00:59:02 +0200
Message-ID: <20261001230058.11465-4-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001230058.11465-1-kirill@korins.ky>
References: <20261001230058.11465-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: "Kirill A. Korinsky" <kirill@korins.ky>

OpenBSD and Linux expect the ADB command between the CUDA status and
reply data. QEMU omits it on success, so guests consume the first data
byte as the command and lose it from the reply.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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


