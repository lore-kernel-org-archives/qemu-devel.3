Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0947EC9830D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 23:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9W1h-0000J4-3G; Wed, 23 Sep 2026 19:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x9W1c-0000Ht-SW; Wed, 23 Sep 2026 19:05:16 -0400
Received: from mx2.catap.net ([2a01:4f9:3b:5410::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x9W1b-0002Uj-4r; Wed, 23 Sep 2026 19:05:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=ks7wy88
 9ZzVOpVTZoF2kRIDukXOej0Qa5GFZ0aR+X6X+5X7kaRedU8dgpuxBqQ3pF82ClTBMeQxMZ
 k88tDpv0mtKZ6WxJwPNRxS3weiFhW/11TBPcR+G5oD7PL92MVOAWb+/vC4HHH8LuFy61O2
 xZqktT9ltsmKQkNo9fvDMl92APzKLmzBMjhvUow/9NERE82nDNugXq0JkRdc7uChfRz8qx
 svvLZTnkrjaEHBUEM8qpZRL2+MxnqX/Kh6M9AggPvHuYVw37yubXABCAL4XKpo6a70638j
 hXbhx/ICeBzVwyH3pF0YNWb05tbr18LO6up9oSMcP/9xtiysvtQoi8A==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=j
 mhdMfhDq60vgJ+jMlgvi0rNRY/D0fggYG4fvks+BTc=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=N/+UvV/B6WyysgIUpkftRIOtIXf+EBayiUZs1NU0eR1gggB0C0ixWrG3WSrGiCBh8FDB
 iKo8nLI8sqTcIQ2+RtbZ2E8pyAxWEp1B8dZmUkE8jKOAx6nfatytMiZ0JNhAmL3kI8rs7h
 26laOpv4aTyImrzLdwDw9IAL8F2Wn2g+2rCkFEzJAgneWJhn5cR+89idQ/poQkKaVIzVtM
 oWVHY7EM6k/+tJB1Gw14Fv1aLC74Pe2Fc2rsHJiMxj4QvJgAYVq1jRcGKcLdtj1iUN+02L
 xdO8Kzpp60epincYXNoEincX35DY73KS+NzRDA2suP5nrqMe0UkNvKXTGmEWSgIw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=baI4sjaT; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=3916D7o7;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=jmhdMfhD
 q60vgJ+jMlgvi0rNRY/D0fggYG4fvks+BTc=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=baI4sjaTtnQe9LH9cfqWZZb1oF+Z/0y1Zsc
 D9il1MHS6zkgBSIll5GGVdzxh7M0Wf4qSlB52R9+RtsFm37lBJAt5NtwmWjmYD3KUSbfvz
 QeSZ3ebd7R0gox8Vs8AHayxBk1FKpyTseXTC4kzqv8sMV7UuT8agPdIoYDuJ1q3GDmaPBN
 XFVYGVtAXC5WyEGFJOP38upg53aHLhXk+j8rIxYS69auHjIr09g9rnmalFL4XcokF0HA2z
 oWZhq2WznqmBCsvLh6kQXqkKMRPxeH/6j7Rcy/6Il3aA1ssS4z1cGU2IpvrS+CKPLhQ17Q
 S2NNIhcSipOdO8tilvD/evVU6Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=jmhdMfhDq60vgJ+jMlgvi0rNRY/D0fggYG4fvks+BTc=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=3916D7o75d3MOFVj7n
 IS6Bp1KIQo4s+AXTfR8eMvwhRwqXiD+WAQBzKRjLn7Tc4thGDV77zHJ3Zpqqp4IzAgBQ==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id 14b57557
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 24 Sep 2026 01:05:07 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 9395963f;
 Thu, 24 Sep 2026 01:05:04 +0200 (CEST)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>
Subject: [PATCH v2 4/5] cuda: Make shift register delay configurable
Date: Thu, 24 Sep 2026 01:03:10 +0200
Message-ID: <20260923230452.3765-5-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923230452.3765-1-kirill@korins.ky>
References: <20260923230452.3765-1-kirill@korins.ky>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f9:3b:5410::2;
 envelope-from=kirill@korins.ky; helo=mx2.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

The CUDA model assumes a 20 microsecond delay before each shift
register interrupt. OpenBSD times out during device discovery with that
timing, so retain the existing default but allow an override.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/cuda.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index ccb3e1d74b..f06583377a 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -535,7 +535,6 @@ static void cuda_realize(DeviceState *dev, Error **errp)
     s->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
 
     s->sr_delay_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_set_sr_int, s);
-    s->sr_delay_ns = 20 * SCALE_US;
 
     adb_register_autopoll_callback(adb_bus, cuda_adb_poll, s);
 }
@@ -557,6 +556,8 @@ static void cuda_init(Object *obj)
 
 static const Property cuda_properties[] = {
     DEFINE_PROP_UINT64("timebase-frequency", CUDAState, tb_frequency, 0),
+    DEFINE_PROP_UINT64("x-sr-delay-ns", CUDAState, sr_delay_ns,
+                       20 * SCALE_US),
 };
 
 static void cuda_class_init(ObjectClass *oc, const void *data)
-- 
2.55.0


