Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C05EC98312
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 23:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9W1e-0000IR-W7; Wed, 23 Sep 2026 19:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x9W1b-0000Gf-Hg; Wed, 23 Sep 2026 19:05:15 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x9W1Z-0002UK-NT; Wed, 23 Sep 2026 19:05:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=I3f3aSh
 0MfeZIbWNSLSO1naWWxgLHNqSA0KP3ooldU33qbyYdecfr4l22EtRxK/xNjFramK68YQFA
 k+Wm56UHABgKktZEbGe2cpRQEZBPNhqTGiVwRWAnemF6AB6d7RQz7JHv/tacNJoZccjpKC
 wyYJFiNLfNkrH0ztjnoUCocim1wmjF+cGtfHKCzd+gOiK1SHypBZd7pA79WfW4OpyhMXrh
 +DgVtLyglh6ulHUliHJajc0YU8W1x5dP6uiPWSArjP5thK02dEopFD5TDRq95+T7ctDBHe
 QcQTPb5jWBRI7nTqn4IvVrbTVs98zJGnKYbMfzEuhBbqINg5kUoO9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=S
 0NTA0YEh0iySGAAs7Db5F2ShRlK5P+pRPEHwRHbeDo=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=yHsTUM+tHW4umvSdCtRbKsRWVPkhI/p7agrqYqI1EkP5KP+Sym+t3Ol4EsFh/TXW2JKW
 Xe6cRtje1E/enZe81R2w1G3EtgSVnU1tfcFvvGHqBeVnMBaQ2AWABbjel+iVZcyTOs/b/d
 /EgSWqanJc55pKqgmcLWtE/BMCG3kaANQMJWS2QNN6ebp4GpepXN180ASyAtl87fzNgfsj
 2RGOUyN9uW4neIsOgsxAQa/Wet+tMxezWlvSMrfvWwA7Blz9aEp7WaHEd2AyXAnK7sKHB2
 bp3ZefMSahNgHuIvaJ7i/GOFkWpIoB7pFBPA0H0j3jK7RYRZRibg6NHEcoNgZrEg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=QTzqXLa/; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=nI4hTMTv;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=S0NTA0YE
 h0iySGAAs7Db5F2ShRlK5P+pRPEHwRHbeDo=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=QTzqXLa/VsTWy6hKbu5qzTaE8fSrCkbmonz
 rMZn2GZpAxUuBhdC1JmLkqfCjCfTdFen4HhF2kjLm3gavwi/HHZGFhMpvKV679qEI00Qwl
 w+La/KM3WKiKOER+VqqQhfCnUZY8aZYyw9e5Gw4BF/ZueVD4EVRCqshXv3VnutQ55GNgff
 irxlfR+EX0mKzj2mCryBTJEIyDsihkMrbHbhynHBC1mtxmLsilXv0s+eq/ZxHaX/Zcnu4O
 D5pj402+HEeQgHRaReMgOFP1ikZof2YZYEMoAe2xlhzWmBQlYEwL01QggkTa21nnvxJXha
 461otUaHvm6bdjUCHvimB4rQgwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=S0NTA0YEh0iySGAAs7Db5F2ShRlK5P+pRPEHwRHbeDo=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=nI4hTMTvffv7PULEhE
 rOhCILn+PoQb4/nEBQ4hElGcl32gGVqMhs9UlnSPe0Hg94mpWubegjun3Xj+gX0vOnAg==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id 5d7766f5
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 24 Sep 2026 01:05:07 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id d3af0043;
 Thu, 24 Sep 2026 01:05:04 +0200 (CEST)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PATCH v2 2/5] ppc: Raise decrementer IRQ on zero write
Date: Thu, 24 Sep 2026 01:03:08 +0200
Message-ID: <20260923230452.3765-3-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923230452.3765-1-kirill@korins.ky>
References: <20260923230452.3765-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
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

OpenBSD writes zero to an edge triggered decrementer, then enters idle
expecting its interrupt. QEMU defers the already due edge to a timer at
the current virtual time, leaving the guest stalled.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Suggested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 hw/ppc/ppc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index b123b4cc1c..736a37d32b 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -885,10 +885,17 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
      * an edge interrupt, so raise it here too.
      */
     if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
+        ((flags & PPC_DECR_ZERO_TRIGGERED) && value == 0) ||
         ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
           && signed_decr >= 0)) {
         (*raise_excp)(cpu);
         return;
+    } else {
+        /*
+         * Classic 32-bit edge-triggered decrementer: zero write fires
+         * immediately
+         */
+        tb_env->flags |= PPC_DECR_ZERO_TRIGGERED;
     }
 
     /* On MSB level based systems a 0 for the MSB stops interrupt delivery */
-- 
2.55.0


