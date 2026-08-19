Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D62C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfdp-000813-Hi; Wed, 19 Aug 2026 08:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <opensource@fvhovell.nl>)
 id 1wwfOH-0004cq-OV; Wed, 19 Aug 2026 08:27:33 -0400
Received: from outbound.soverin.net ([2a10:de80:1:4091:b9e9:2212:0:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <opensource@fvhovell.nl>)
 id 1wwfOE-0003AQ-Dv; Wed, 19 Aug 2026 08:27:33 -0400
Received: from smtp.freedom.nl (unknown [10.10.4.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by outbound.soverin.net (Postfix) with ESMTPS id 4hQ5Ry0HXhz1Plp;
 Wed, 19 Aug 2026 12:27:26 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [10.10.4.107]) by freedom.nl
 (Postfix) with ESMTPSA id 4hQ5Rw5t8zzQQ; 
 Wed, 19 Aug 2026 12:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=fvhovell.nl;
 s=soverin; t=1787142445;
 bh=fIGCt0HuhqRiwHHqhQVNywIZD8sxFC9pKN5As+LLnqU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ox4Xzv7ZZGSQ0Ru1pz1UCWYs/VYIq8ljhMuSTpNX2vUa8tz5xjzK33qWV2Q34PmkE
 gsjjElUGvHs6FSJrRLA9eWYsTKt345i627vO3caZLNG+qTMmyz89QzKYjgSbEOzAMT
 sCfAdK2FPgm1VgGeLjpoqWJoJ+Io2qhEPiGGkO/Mh6Y0ElJWKUPAR+/6nalcf1Luzq
 avpFbhhqlepupr1KpPun6uCO13PFj5acssb6Mp6WK9zwvAz+EFSZw1ALDIExOhXmgD
 bdvBXnvyk+07rxsfClJ4FfHvB/fsxq6irIwt1jDicrf2VYEthNLTH0mCsAXphCkfCn
 FLdjt+zEq3FuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fvhovell.nl; s=soverin1;
 t=1787142445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e4L5h0rIR2MSXkN+TKrBKcLE783NPx32/GwBNHF6fLM=;
 b=kopZPLDje1WrFJ3IyZxGtIZJRqMhSsCnY77M6Wwaz89ElkLcq4Yw8Xk4BJEWEDKYlnzbt3
 X4gKFEvTiwNhAbw9WOrX6D4IYr+BjyK9heTPpyezgqcaN7DCDRJREvXNNTGhvvD5dBLzaR
 kSogWWTLKw5lefGgXVYvF8za+dGK40S3ZVJVQk+5FEiXPRJzh3+wbzMDbiORtBIw5DK620
 EZihFO6e5cTHDyIRrrDTkbXexitEVWP8wQziBVVrOZaLmd4CzJWBr7+79lM4AxAiU+RbUU
 kUm4c6fWgFPpARclx//LKbT2yeYyp1weMlBw0+BLtLRyMbr1FbEyxGJcegQqkg==
X-CM-Envelope: MS4xfJHMb/pf0EDw4TA83x9VluMoi+zj/oWCDoDAph5dMnI1y26HJ7X2B3UM9gcQM+e94Gl7u8cWTH/ZuXFf7f2HoLuKWWrAA9Pgml4haGfwN3+XuDtXrXlb
 f++ax980722iyQT7DswIIqsDRVt3hxbPBE58ocK8zABA0K7bmsFHlfwu8PXLIlMAl1yQFVucmXC0yIibT7cWbPFlML/9LIj8d0jquLk4S+CZ6RnaHwXmwd5y
 j3/FKxz40LbxB8W+APm8/fNxjweIT9l9FZKW4p1qZML77C45zU7ULWAFJxfDlbLSKAopAnoZutgYSvLd/3S6ueKnyNUWTyznytbYZmerSC2mc2Xnfg6Ahx91
 RM2mRPS2tBvCahntakPBFUWvz/vgfJdzXoZ3GwBY8n6RGTd5m1I=
X-Soverin-Id: 01a019fd-97c8-7503-a165-d6922a5c24cc
From: opensource@fvhovell.nl
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Peter Maydell" <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Frederik=20van=20H=C3=B6vell?= <frederik@fvhovell.nl>
Subject: [PATCH 1/4] hw/misc/bcm2835_property: fix
 RPI_FWREQ_FRAMEBUFFER_ALLOCATE response
Date: Wed, 19 Aug 2026 14:26:59 +0200
Message-ID: <20260819122702.54173-2-opensource@fvhovell.nl>
In-Reply-To: <20260819122702.54173-1-opensource@fvhovell.nl>
References: <20260819122702.54173-1-opensource@fvhovell.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spampanel-Class: ham
Received-SPF: pass client-ip=2a10:de80:1:4091:b9e9:2212:0:1;
 envelope-from=opensource@fvhovell.nl; helo=outbound.soverin.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Aug 2026 08:43:31 -0400
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

From: Frederik van Hövell <frederik@fvhovell.nl>

The value is used as framebuffer base address, but seen from the VideoCore[4-6] processor view of memory.
This GPU view uses an offset of 0xc0000000 (i.e. bits 30 and 31 always set to 1), compared to the CPU memory view.
Above interpretation can be found in below kernels:
  - UEFI firmware [edk2-platforms](https://github.com/tianocore/edk2-platforms/blob/306137738faf9f31eba9823d0f818397755cedaf/Platform/RaspberryPi/Drivers/RpiFirmwareDxe/RpiFirmwareDxe.c#L1045)
  - [Upstream linux](https://github.com/torvalds/linux/blob/0031c06807cfa8aa51a759ff8aa09e1aa48149af/drivers/gpu/drm/vc4/vc4_drv.c#L312)
  - [RaspberryPi linux](https://github.com/raspberrypi/linux/blob/3e44c7fdf879208adf51be589d60962269d25d18/drivers/video/fbdev/bcm2708_fb.c#L464C1-L466C29)

Signed-off-by: Frederik van Hövell <frederik@fvhovell.nl>
---
 hw/misc/bcm2835_property.c      | 3 ++-
 include/hw/display/bcm2835_fb.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 216a746c2bd..a90c7e6c863 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -168,7 +168,8 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
         /* Frame buffer */
 
         case RPI_FWREQ_FRAMEBUFFER_ALLOCATE:
-            stl_le_phys(&s->dma_as, value + 12, fbconfig.base);
+            stl_le_phys(&s->dma_as, value + 12,
+                        fbconfig.base | BCM2836_DMA_DEVICE_OFFSET);
             stl_le_phys(&s->dma_as, value + 16,
                         bcm2835_fb_get_size(&fbconfig));
             resplen = 8;
diff --git a/include/hw/display/bcm2835_fb.h b/include/hw/display/bcm2835_fb.h
index f7ef076f1f4..bcc87ad5390 100644
--- a/include/hw/display/bcm2835_fb.h
+++ b/include/hw/display/bcm2835_fb.h
@@ -15,7 +15,8 @@
 #include "hw/core/sysbus.h"
 #include "qom/object.h"
 
-#define UPPER_RAM_BASE 0x40000000
+#define UPPER_RAM_BASE            0x40000000
+#define BCM2836_DMA_DEVICE_OFFSET 0xc0000000
 
 #define TYPE_BCM2835_FB "bcm2835-fb"
 OBJECT_DECLARE_SIMPLE_TYPE(BCM2835FBState, BCM2835_FB)
-- 
2.55.0


