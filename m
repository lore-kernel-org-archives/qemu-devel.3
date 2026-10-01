Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597AACA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 23:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCPmV-0004S7-Vw; Thu, 01 Oct 2026 19:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1xCPmF-0004O5-U2; Thu, 01 Oct 2026 19:01:25 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1xCPmC-0007jJ-1U; Thu, 01 Oct 2026 19:01:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=C7kwGQU
 Js4dEHLCE6s0OP+dCEh/G3wPn4grDylO4+tU5LnOLanpwivURlaAlDGo0BiFQHVLWOm9iD
 TfYB3+8tQ3MoPakfMahGvtSmCd4L8FsULHP1dNjYB7IWZMxx+mmwTbok43qaFQtcwXTNsj
 yjm5d7QBkYUae9H87aAx7Z8jeaVDr/s56hRkYKTrxkHuRgOG3fkNE95jBVyDiGe4hml5lH
 96JPO/7+Vy2gYpqligy9mMXw9qpY2ICyB4k+JPIfusSxQiw0nIYYO41ei3hMVpWsTlmr8l
 R1jRBSvQxHxUlh7IIaapIZmfEdxxN/sR0P3KZ+cXsgnkK1nYoUCO2FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=r
 8RxrIuKF+SSKpGnXLnXksMXwzKdo+kIEVyUUZgk3/Q=;
 h=references:in-reply-to:
 date:subject:to:from:dkim-signature:dkim-signature; d=mx.catap.net; b=
 Hg5BJNA/bVEz8nFBgCkzmw5mZJsg6mCQSRC56YjeTnop1hB6kQXh0eP8qHjnFpPj+tXj3M
 KZQ/aBOxjiqQQdRN1oKcWsQfUlIeLhShhd/B8hGqxUkfi6yso6s9AJLJ62KKTSPQ3aGzve
 b4aARr+fulsyf9XHkDbU624cmZDpvm4t/fbtn4+bT6Q7jAmVv4Ep1sikJsDUP7cwd3Rizk
 tZFpkCej4VZfyihiVsZx2UyOfp13mFkLsghjY4/vscgWTtXcrJN4Qxmu2Y1sFW4RcFAfPq
 L2UhPAD54ARrDXDaYrsj5fAE4LrWcz8XGQJURmRw78d4ZohTVweVtJ1UEBzACA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=FMSkFWPK; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=ioLpxsBS;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=r8RxrIuK
 F+SSKpGnXLnXksMXwzKdo+kIEVyUUZgk3/Q=;
 h=references:in-reply-to:date:
 subject:to:from; d=korins.ky; b=FMSkFWPK4PrLf6e6yK6jC1K7hktD7F3z2qbs6P
 USt35RcjirA8+xdxEm1QWs5Zhvlzv8SULpkb9Y85AEvb28Sq8NlaCea5oXMn7TlCBBdw1l
 4DeTqT6t6JcZJkNPYtyz7GB4Sy8xmm8fUtqgJBLAKq0SQJkWe8Fs4W0JUSSk+DY86HOl+X
 eU1vwC655CfMLgNrhmtma8fYXrYVQ8Y6PSlGsibwDORCefInB+C5OvUkvFKttJYY2eWc80
 FYjYTe+pB8NCngHGh2L3D5NTQryCW/hnpgLnKbLjfDBOdSEAUuCejDZu/PrAG7kem4u8py
 3CcgLaCtgn70KLpWNW6Wisbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=r8RxrIuKF+SSKpGnXLnXksMXwzKdo+kIEVyUUZgk3/Q=; h=references:
 in-reply-to:date:subject:to:from; d=korins.ky; b=ioLpxsBSAebYdA71fhao7
 g+qg5ccWmZbtSjCww71QiIZHx3cCqfALFmBaYdaFKYUGPwo3lP1zQWIOQdP1Uf9Ag==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id ad663969
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Fri, 2 Oct 2026 01:01:11 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id a9dabf87;
 Fri, 2 Oct 2026 01:01:07 +0200 (CEST)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Kirill A. Korinsky" <kirill@korins.ky>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Miles Glenn <milesg@linux.ibm.com>
Subject: [PATCH v3 4/5] cuda: Make shift register delay configurable
Date: Fri,  2 Oct 2026 00:59:03 +0200
Message-ID: <20261001230058.11465-5-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001230058.11465-1-kirill@korins.ky>
References: <20261001230058.11465-1-kirill@korins.ky>
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

The CUDA model assumes a 20 microsecond delay before each shift
register interrupt. OpenBSD times out during device discovery with that
timing, so retain the existing default but allow an override.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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


