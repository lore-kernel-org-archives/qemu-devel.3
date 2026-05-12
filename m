Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C085BCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 11:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMl5k-0001YF-TO; Tue, 12 May 2026 07:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMl5V-0001XM-QX
 for qemu-devel@nongnu.org; Tue, 12 May 2026 07:15:52 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMl5Q-0004DO-Dh
 for qemu-devel@nongnu.org; Tue, 12 May 2026 07:15:42 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48e6db3ff7eso19227515e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 04:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778584538; x=1779189338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9lq626Xcnv/TaXJEeyKC5Q3TVDBpLmy55MYABy31hiE=;
 b=Ialyd+2JP7myCVTQ+HsPfGmyUm/FS94vpqsRYVCCQkJzuo9rUo1iyTD8es/7KC05hN
 M3k1nr14/85FAwq2W8c5LXhCz0Iv5VG6+SnIAVvLH2gfpUKT9mwJFe8b6Ru1WvWu+oRf
 BqC+BM17UChfiCRvM4smWcbEvKZSxG1TKYV3Is/L7QBzVWoFzC0fnk+Yd4qpnEn3MC4E
 ojoEPDxmt47eJSUndvDgNjegqRhnmvPU82khMFmQm7lfaekB5g+6QzDFMRrgOnHGMVuF
 0KPlQNW7cZoHAbgtoPAgW+R+43UhywFjV2kms0abT4IgbuBSCezmtRlfdiBaZ3uqF4dW
 ND3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778584538; x=1779189338;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9lq626Xcnv/TaXJEeyKC5Q3TVDBpLmy55MYABy31hiE=;
 b=gD33wkgt0CmXOzAg1//eZJyv3U0F1J40RqpF7s8P0RREMJNoGX4W1mbVE46D7PwHtu
 pVBw5Nr81paDzibso+ATrNGVBt8v6NRKP6ODIvLRu9ep8Ubb3hnzZQsJ0vF/kHiWS4kG
 AP5fFczKuvUaI7c+GLFa7ASeaDYWVVXduSlWK1bBmCN9zPuqncLHTbxd5SMyV/MAfrdJ
 F9LWE8chfM3ywSiZPnoB+HPCegJ8KYyYQ4FNnLPhHSmgcvBEjaKy1m0zIQywwcvUulia
 2Nq9afeIpesddYiK5TckxE+IMAWJ0z1gMH8WKEiRBNrzNAfZXNlVg/YrlzKHN3JJBBbp
 Kg0g==
X-Gm-Message-State: AOJu0Yzu2TVkKpdJj9u+ek5YimC5bfgncu+dwSwKPsBXpJ0dcr8m/BAW
 n7lD47bx/weVXEm0DTtqzyCQkKLtUhCh6XyWGlkFQQhaKBD/rPll5lQIYaBAz5ija10axCzqotB
 qPOXj
X-Gm-Gg: Acq92OEVPZF43U1eXvSd6l0dYgt+VN59SyAfC1Ptg0xH5nMPpJbPRdevgtTYFeki5Mc
 VMlTEjhYQhOR61/oQSpUrgHsu5YjOjfhZNn5ouXFh6DCPhu3H4WkFKR58HeZOLWOf8Pg7xwzxkb
 jHPfe/50kQTLU/g8KzJQ1Aep0sipau+S6KyyqZW9wxkIkbcBDDBBc2B9DTaZLL+cWQg7245tCQQ
 xWY59J4m/i9aw4HiHQC/QTAr8FKsed6i60iMquV5K8ThYRNpa3y18DZtAdGl8hWoEcEvRcuo//v
 1/y0LBYhn0U/zP/lAgBWPohT6meYIaVi1+5j3e8a5MWR5LR4Pj7zHCkJ9OsJstyNprkgecV5uel
 I9NwdEg+Vxa1vsOKCfo3vGwMegA56cJPYVipklFsZBEwM3q016DxOu1CyZpoPBdFcGcgQYkXdi0
 gZHVebCRtHEWRuRkEe27GQmSsFKwVjh/Uu1VP9T25Rakr8yL/qrOJOrBS1YZcEF+wi9gSSegGMx
 LVkKXowkS2pmHrBf45xRLh3PMPGJTY=
X-Received: by 2002:a05:600c:34c8:b0:48e:8741:fd3d with SMTP id
 5b1f17b1804b1-48e8fe71c09mr39375085e9.14.1778584537720; 
 Tue, 12 May 2026 04:15:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e90678268sm42769255e9.10.2026.05.12.04.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 04:15:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] hw/intc/mips_gic: Avoid Coverity complaint in VP writes
Date: Tue, 12 May 2026 12:15:36 +0100
Message-ID: <20260512111536.3437645-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The MIPS GIC does a check for a guest error in the write path for the
SH_MAP*_VP registers which triggers a Coverity complaint because it
assigns -1 to a uint64_t. The code doesn't misbehave because the -1
case will be caught by the following OFFSET_CHECK(), but the code
could be improved:
 * there is no need to special case to avoid passing 0 to ctz64(),
   because (unlike the compiler builtins) QEMU defines that this
   has a specific behaviour, returning 64
 * the OFFSET_CHECK() macro will go to the "bad_offset" label and
   print an error implying that the guest wrote to an invalid
   register offset. This is misleading about the actual problem,
   which is that the guest wrote a bogus value to a valid register
   offset

Make the error check print a better log message, and avoid the
special casing on ctz64(); in passing, this should also make
Coverity happier.

CID: 1547545
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/mips_gic.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index ad9363a4c7..d337a76603 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -326,9 +326,13 @@ static void gic_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
         /* up to 32 bytes per a pin */
         irq_src = (addr - GIC_SH_MAP0_VP_OFS) / 32;
         OFFSET_CHECK(irq_src < gic->num_irq);
-        data = data ? ctz64(data) : -1;
-        OFFSET_CHECK(data < gic->num_vps);
-        gic->irq_state[irq_src].map_vp = data;
+        if (ctz64(data) >= gic->num_vps) {
+            qemu_log_mask(LOG_GUEST_ERROR, "Bad data value 0x%" PRIx64
+                          " at MAP VP register offset 0x%" PRIx64 "\n",
+                          data, addr);
+            break;
+        }
+        gic->irq_state[irq_src].map_vp = ctz64(data);
         break;
     case VP_LOCAL_SECTION_OFS ... (VP_LOCAL_SECTION_OFS + GIC_VL_BRK_GROUP):
         gic_write_vp(gic, vp_index, addr - VP_LOCAL_SECTION_OFS, data, size);
-- 
2.43.0


