Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66585C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 23:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9W1a-0000FH-Dy; Wed, 23 Sep 2026 19:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x9W1Y-0000Ee-Rf; Wed, 23 Sep 2026 19:05:12 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x9W1X-0002UZ-1j; Wed, 23 Sep 2026 19:05:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=W2siyaP
 QgpQZmNRQFOReEaIGYbxclUMqMyBPgtVydBl5qOHL5T+ifWAcTgCcQaC6yWub0Tgjmcfyi
 ORfAlytzeuNbHDP///XrGj42MkCml4YU9gLvJP/2JW+trFWlpV64TW7fjR/uGIXaSCl28Z
 V8zPKXw0+UNr2CpyoFu2FZLYk1BZMUstJiL+9fRP4RIjl5yVBOxf5IJDz8f1hRD9LsIq23
 mzxyGSyd+aHc9gWhrvBLCEH4E4+0m4HGO7yunfCsw2Alx7qMrH/wLHqmFH/PxkrJ3xDR9E
 GP/sk6tWy7/IoL6Znhc/C1Dm77+Z+YUzST4p1ApOuzJ7+5WydY+TcOA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=0
 VvGzzvtw6mkJpUk2FBAT6jJyveAIEvnR/DUkN/2r+c=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=t3b3KdKY8PWrLrlG1Npf7OeKYReYG00Sy3tjiZtGu829vVjGOd6bsAhgt97YpvRVuR5C
 skMZCWfInFY4JQG7WIMks5pbhf7XTzzTgBgOIDDWEurLWt8/Z/B5b6Nq9vsfmHlg7rFV2l
 TKHCczdDBVU0aPVNX0jC8XUphqxVH8DJHdqE8s9uhSXc4NNbUwJ55rDyH03RXwTvfJWUnY
 rngoEsLI+RPWt2Lms8zqGuUQxhQG9O1nPkBtAxlsdRP7Efx1rqMcqEV7najGlPrJiWJghA
 pN+n0p3tORfj6VFCBt3zvS+b9B9GQI6rGAd7H0w5nzPL+3RREW7JUKeO5QncDpag==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=d0vZaptq; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=oRN9xfsR;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=0VvGzzvt
 w6mkJpUk2FBAT6jJyveAIEvnR/DUkN/2r+c=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=d0vZaptqy/A+dSV5L3GrvKATDFQw083RccT
 RuKsme2h5REa/c656NwEXI/HWYPKQV73ZeAWqF3fmggJdRtgmHaTDghHqOOGVHe4G/vZN3
 3QpgKRqDJy1p9K44bQcafmIr4hmGfemB3E5zraG5mbp5kfZ+cfMSW+png3EqeFyt/p2Hg9
 u+tgv0V8YJf5Tzxcye6Y9MtM6fNKdntji6jH0FrwITkjVnFxIyojQdFUhCMQ5XYNiItVNo
 3hWtmz2L6n9gpMmnpBJZZbzKb25Ap9lm3w9MKMwsbEsLBB49tVlVKRy/eNYV07z2jdTBZV
 sIoP/VgWiGkmgSwTw4cu+ilvUjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=0VvGzzvtw6mkJpUk2FBAT6jJyveAIEvnR/DUkN/2r+c=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=oRN9xfsRgE/4i1Vn1w
 nc1ryNCNQcoqDB4STPGSdmXRLSY076mjMzg+3aTvZ2nP6B1MTOrXtpgQXFiTiUfhc/AQ==
Received: by mx1.catap.net (OpenSMTPD) id 5777cc3d;
 Thu, 24 Sep 2026 01:05:07 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 3cd5539d;
 Thu, 24 Sep 2026 01:05:04 +0200 (CEST)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>
Subject: [PATCH v2 3/5] cuda: Include command in successful ADB replies
Date: Thu, 24 Sep 2026 01:03:09 +0200
Message-ID: <20260923230452.3765-4-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923230452.3765-1-kirill@korins.ky>
References: <20260923230452.3765-1-kirill@korins.ky>
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


