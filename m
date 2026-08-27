Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A42FC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcFW-0006It-By; Thu, 27 Aug 2026 11:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wzcFU-0006I3-Pa
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 11:42:40 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wzcFT-000181-17
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 11:42:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=TGAIoAG
 gJBuEUS2WrIOZ0+EXWRqbBSrPGBvK6aWU6Zh6T4xEsLrmE06BOtWO3cZ/NmAkrBj+76Edl
 m/yCkFA48KrFY/h9iIk0eUDMOQpNPDrPIVbny1iz91qva3RbztiPEACzN6DPKtTYx00NcQ
 Etc9eVoDL+Yp7/phtUKd5ddwdzGUZIoxawOdjKUkFJRstpVJJLR4lqblTkYO68U1KknH4G
 l7rKRDSvhd/fca4ywu8jCwO7FeO5DwTubG++k6TCp9uwrcfbF1OVflhXhvG5/FkM6Ar2Fo
 w4iXPdRap931/BKokfNkPFw9k8K4nrgQI198Kngprz0MbMTOludTY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=O
 qTl22l5p6/CPHHVITgZQsvYvoHPLOjk9ekmkSr5Lw8=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=MO/Fpn0gaFRA4nvl3mJzW6Tj1vIhLPkKW7CoCMzbZEzdULFu6l+JiP9KoEqUqPR/LZdy
 VVP6T469/mtUgSQSiScJfF6bbcN8fiAhlhkR1W5n2xJDc4I8oJeOfDabJ6Dhxpp0zYGUbJ
 6r9V0pPWB1pxzhyvmN6fW20K7CtOas7s/d8BMhmr2f7rcNZmEz2IvDAQWPlpzoNR95oJxE
 VTo1k85QbZiEySa1ij7jqyBBeMHjlbgZp8gTwwm3FWl/Q81/o9L1aQ5nM/dEubGln90Up+
 v6WejEsvByHVaJY3UHNviC6bLHDhFYtG3eiuRNq8JzTs6nMZDgm4GZqZHXRr04Kg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=nOMoO3AF; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=aKqL3bFQ;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=OqTl22l5
 p6/CPHHVITgZQsvYvoHPLOjk9ekmkSr5Lw8=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=nOMoO3AFzjrxe+6UiPQysSIfckuPNTW8FxY
 Y6220vPUj9ZMDmnm5tgNxb4pj0lDwEWrHxCvSZhAo90HOpGFBTeiTgrM1vRdLqUMAGj9J5
 QxhKJoK3JVR3gTXEn50An2n/rBeB6VC0M44/KfYGvJfQF7hYkN+lTGrLmB7OezkhVvyROp
 Y4BrLSxS/zrSYY38zkcdxY2etwhbW61h+oOQgOocukL1oR+cL7+mzt50NOBnc0BGeI2hhl
 GkvDc3x5eaoWTqV3a3qUJjRimSS/dzTFy69tKr74LZWmR/lVL9pqzrJL7pmwzWWhUw/Wi4
 gb+6CYlRZ6rUSEA0hoe5JPbjsVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=OqTl22l5p6/CPHHVITgZQsvYvoHPLOjk9ekmkSr5Lw8=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=aKqL3bFQXu59vvbVIS
 DuBeVxMdYOyie+IHDQ6BewIKKVizTmz0DMrr4A99yb7hWyXzdwKFqcmK/IK216DFDWCg==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 764c51b0
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 27 Aug 2026 17:42:34 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id c12e42ef;
 Thu, 27 Aug 2026 17:42:32 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH 4/5] cuda: Make shift register delay configurable
Date: Thu, 27 Aug 2026 17:41:16 +0200
Message-ID: <20260827154220.84845-5-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827154220.84845-1-kirill@korins.ky>
References: <20260827154220.84845-1-kirill@korins.ky>
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


