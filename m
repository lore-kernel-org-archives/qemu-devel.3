Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DD8C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2604-0003kf-1V; Thu, 03 Sep 2026 07:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x25zz-0003hw-SN; Thu, 03 Sep 2026 07:52:56 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x25zy-0002h2-4B; Thu, 03 Sep 2026 07:52:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=PcsW2/r
 KJGro6qfT3w4RfpEaZeFaKvZhyozCRYxMDjWyytTqupz1Ep66PRC07IJaJAYNdHM+1jdUw
 nxlIT47n1sRCDukQU2/BIY9Zdb2vMuImaswgw3Zb1gKxqe+M9OHrY8xEQ17UBekIXBCXY8
 RA/kBqVYn7OAlfgMmDDLXTFWVXFo3Cb/ZTV1XH4C+3Smhqur8sglxNcQ36KcW4vwZ68hxc
 fg+GrmfKLuaEvtdJ5fWc5dnfwKeNUK2YaX2CIanJyTIb6wuIafRLyzJgA6sEqY0uAk0vMU
 dfD9AmFTU5ghGFTp0G+6JtYC7pXVxsHSpmHwGTNhQEMAOYPgcCLo3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=L
 38mssKJShTqPMLPvNfwMyO1HAru0zAlCLDv1fhZDAs=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=LeG3ZikxumWJigEHkgb61RzkGd5BDwn2JbRDW6ly4Aa2fHiPvCCXEsWbYmdmPKoHZt+p
 gzy+5Ifs3oaY6WnCitUrdpZkIv0+4SBAekBTIFIPFZStxI0LpR54Uky4WuJyNiyJ7W0n6M
 Eue2K6YjXEL793nEmZ7/8DjuTDpi7+9OgF/gUzrnddjZQtWulS4g5OASvu3FUVPD5h+PIk
 Vm4qz6le6yERo2u0ORxLiZFXd91rNuh4Uy2GcZ6SW1+RiVNF5xCKMhfU9JoMTA7nCTjUbs
 2S7ou4kQQkjxK509ZUXrclThtCifglT7v+l62YcehCvwzz+/uOkgKI6uspxe8oUA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=JNl7wiu+; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=qZQBEu0z;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=L38mssKJ
 ShTqPMLPvNfwMyO1HAru0zAlCLDv1fhZDAs=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=JNl7wiu+UcKrs0S3Btf9saOKlGsGfLMY1uC
 WL03XZ1KBcsQqJXk/cz7Lsk37XA8WJtsCqy4+3cSrAL6QDMTBozhhT0puRCAVwmJRmXd5f
 f2N8ZsS/mWhOSvM6J1slgRvrQAbEaXlJhSU1N3NgaLj6fbKupXB2LyPTp/hPDpTLlDBjt9
 RvpfLK4+ysNQ2U3olaioHf1qRsWQEBjiZRmCgJ0ybcM6bUe7nJM+s2rvWhIrGzPcIIE/vo
 LO5MSpHXfx2zmIIlwMT+DMX7Uir+85/wcvobxe1cgp2SV4i+ubbCUDrcw9Be3BQwIPHd0D
 R/vtnmv0gievPReviKGi5rS/KFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=L38mssKJShTqPMLPvNfwMyO1HAru0zAlCLDv1fhZDAs=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=qZQBEu0zJnUToy07Ec
 4PPtxvhll9KVLSUF/m1SjdEZlHRKQ+9eeFU49gV/3QNeCXcFdaF9vsz4Jic9Ycya7WCA==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id facddbdd
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 3 Sep 2026 13:52:50 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id ffec5fd8;
 Thu, 3 Sep 2026 13:52:47 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH 2/5] ppc: Raise decrementer IRQ on zero write
Date: Thu,  3 Sep 2026 13:50:27 +0200
Message-ID: <20260903115229.95811-3-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903115229.95811-1-kirill@korins.ky>
References: <20260903115229.95811-1-kirill@korins.ky>
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

OpenBSD writes zero to an edge triggered decrementer, then enters idle
expecting its interrupt. QEMU defers the already due edge to a timer at
the current virtual time, leaving the guest stalled.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/ppc/ppc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index b123b4cc1c..d99e47d532 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -885,6 +885,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
      * an edge interrupt, so raise it here too.
      */
     if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
+        ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && value == 0) ||
         ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
           && signed_decr >= 0)) {
         (*raise_excp)(cpu);
-- 
2.55.0


