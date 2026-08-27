Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B22C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcQH-0004cW-Fa; Thu, 27 Aug 2026 11:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wzcQD-0004bC-Jh; Thu, 27 Aug 2026 11:53:46 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1wzcQC-0003sh-0Q; Thu, 27 Aug 2026 11:53:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=x2UXr3m
 qrh6WQtSxyYLOiCDVgpPh8EH73WIcHn1P76DVu1p18JKzUI9lceiCkCM/4MTVRlNCB9kQJ
 L40pZ/JzHP/8C/eYk6zEpcfUzZuaK2GicpqP6jXJXrl1L5mLpjLz/N9KrzcJij8cBiQCvq
 LRp1Z9OFte1fJDYXefWKVbnMxnwf0AEr+EmwIWOtiUDiQVIb4N2ix9+dW/zmP8geJi0PE1
 PNWrung367ggAkH1MpreVNwUbKD/kM5eZPMnP2RNeDUib8YT1/QQFBppF0P5UWgYokQ4r0
 p3wao/YgUnUrMWKQIHLwxTQDm/Tqi4DhtRSFGSyfjoAzvHum7rzAMzA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=O
 qTl22l5p6/CPHHVITgZQsvYvoHPLOjk9ekmkSr5Lw8=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=lHgv9R8kT6V7B3lBrlzMLu7xSh4L+RiyXqhKVnfKh9Gp9uZeEm9lK9bG9TKTSBUaXrXT
 HtTdHfoeCcRX8CgE/rtFbpFYOyN/rtdXIQXprAK44WqNCYep0e9X9u66fQ8nWXtEJhNdN5
 NH6uM8gdf1O7+7I8D+Iu2FMSCWpJqkZnkBCDzw8cJJHtJumR189ZMmvJG+dQhgbrHHaZeC
 kFJrkmENTSv4+8iZEOoHt9deDdS890sxHmhTsLvEeZgnBFNjM7nRUWlMl6QnkMKh3gRIrv
 reMhyEvgd18K3+9ZCOwfwwuvJ9bk8VOtqQHvDVahe38gAi0IuITuENCpiPq3MWgA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=wixdn/9S; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=aTLgopHq;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=OqTl22l5
 p6/CPHHVITgZQsvYvoHPLOjk9ekmkSr5Lw8=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=wixdn/9SgZpgk5Fsiqd45E0baA++ykbys7O
 cuzLTmGPZAqqUKXzmRh8WnKgy9WHvQEOTeOfptGbnPq7v+Tnyxtov6niBzxOA9Jc7o/GAe
 UhQa443NE4rDR5+M7EUYXiia+8rpJdDAp2R5m/QTnx87ermBLvS3105+vkAZGoK4s8xDCW
 MxnEGEvZdOhu7JVpEBqN388Muv0tfk84fTQgEHGewGmoLzITeH44LWqyGFg3Bcjg8F+Vbq
 zmVB/CKoBCvEcrjhMbavhBo9Yosh1Kf8HgzP/536VpDskvjnLhy8HoJnorzZxfmlKh0I8a
 mdtoYvOGX6CnB6gfBnNC77BSDlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=OqTl22l5p6/CPHHVITgZQsvYvoHPLOjk9ekmkSr5Lw8=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=aTLgopHqy9/0TPRG+a
 qlvtDbGndC2HcZQhDnwYKZmLdIsc17R+WtdORuc/EV3Cepi5YiBnwT8rmFRPUvVsaZAA==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id 70ef1772
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 27 Aug 2026 17:53:35 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 9b442a94;
 Thu, 27 Aug 2026 17:53:33 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v1 4/5] cuda: Make shift register delay configurable
Date: Thu, 27 Aug 2026 17:50:37 +0200
Message-ID: <20260827155310.7223-5-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827155310.7223-1-kirill@korins.ky>
References: <20260827155310.7223-1-kirill@korins.ky>
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


