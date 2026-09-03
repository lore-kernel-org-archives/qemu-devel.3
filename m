Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01815C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2604-0003l2-Rr; Thu, 03 Sep 2026 07:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x2602-0003jU-Lm; Thu, 03 Sep 2026 07:52:58 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x2601-0002h1-1D; Thu, 03 Sep 2026 07:52:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=aKqfIPv
 8iJzdFI3a75NoeR/ynDbmY4jBIJAEuy9biFf6iMjnADlyhJRvCJA00kMXFFKhX6/lL527Z
 hqfZ+wMgV6hwM+ov3414222WR01BnwrvZyAnAXO1kEaiKMKPDvEmGw8zz6O98ak2rvEywF
 mbuJwdAmVcNEaxDoRI9PzVKsy1fFvhP+wOe8GSLwqj1pftVIJYxagSPbUqK7mOST9fJCe4
 klOwX5M5dOFYjvs2D12cRMsATL2FMlaVagOqq7oOLE7BVY1Zt8pLs0DIJpzSF4qKcvmZNS
 lag/awCb8RpBw8oGJ5gPl/Ol40jtvnSEMtXjWv2FNM8cwVz5qhgrCAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=O
 qTl22l5p6/CPHHVITgZQsvYvoHPLOjk9ekmkSr5Lw8=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=c6+6Wzgtpv28oM1hyQZoOPGyBIfT5WSBJr2v5mbXHw4OCCjqDvQVM2OPwBTil2oha7pZ
 OHecLkA1G7HSq4GOTVuSFuszSPW5zoRIM89o4iUHkGph0CdqRoUjWE+tL4pBELS0ZaV0tT
 wgdWCTdyFhDvYWa3kQdyJE5hFXunjTOcJylySdWlUV31255QAvSKx36jPXXFqbD73VXZvw
 oirxWJMQAtur8/m9L3r+il5IWx87ubT2/H568xMJsb6j7gCQaYgMeH0QGZoGUkE6YwW4Qp
 dtk9nBFdJZKJLIV/kATD4pjfTb4OwJwRu/mWF6vmg7pGGMu5qi6aUqkDjBdA0R1g==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=VqiKPQPw; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=K9n70op4;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=OqTl22l5
 p6/CPHHVITgZQsvYvoHPLOjk9ekmkSr5Lw8=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=VqiKPQPw+HWuORViuXT9LzJWG4ztr/2K1zy
 MIOzux4UGJLxJ2BgowMs8IsU1lZc3Wz/KsEW4/MSENSMC2I6yBTzw89GqPLvDh843bPH2V
 XttrsU7LPnIBcgXmwkXqw1GuYnoNorK0K8u36M+naiE2zKjL1z0ZcvlT6oXPKxjbOyy5zu
 GVlzmMhmMPLuzXlOwXSg39MyMflB3o7a9BkvYCHDycJrSZj/NgxHUlOnIRWqzL64wtcxls
 kQ7I8YQgehh2xGjSYyw3WfRew5klgII1f36D6JDs8ypJKPAubFJ0BjuqrVmRmHUEkvdphM
 CZOSqpd4jGJUfDrEzH6GBhkQ+3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=OqTl22l5p6/CPHHVITgZQsvYvoHPLOjk9ekmkSr5Lw8=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=K9n70op4XJjzRvXAXr
 YWbrsTuVl4Al7UvdfqVUEt8DJlpUTY815Gov3vlohsOz8NIjkzar1277UJMuQ276cmBw==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id ef7efe5f
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 3 Sep 2026 13:52:50 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id ac6433a2;
 Thu, 3 Sep 2026 13:52:47 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH 4/5] cuda: Make shift register delay configurable
Date: Thu,  3 Sep 2026 13:50:29 +0200
Message-ID: <20260903115229.95811-5-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903115229.95811-1-kirill@korins.ky>
References: <20260903115229.95811-1-kirill@korins.ky>
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

The CUDA model assumes a 20 microsecond delay before each shift
register interrupt. OpenBSD times out during device discovery with that
timing, so retain the existing default but allow an override.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/misc/macio/cuda.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index ccb3e1d74b..a62fdf23b9 100644
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
+    DEFINE_PROP_UINT64("sr-delay-ns", CUDAState, sr_delay_ns,
+                       20 * SCALE_US),
 };
 
 static void cuda_class_init(ObjectClass *oc, const void *data)
-- 
2.55.0


