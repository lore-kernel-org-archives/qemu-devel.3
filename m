Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E723C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJbi-00033m-PW; Sun, 11 May 2025 23:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbL-0000u6-4R; Sun, 11 May 2025 23:13:11 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbJ-0006xW-6L; Sun, 11 May 2025 23:13:10 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so3505869b3a.0; 
 Sun, 11 May 2025 20:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019587; x=1747624387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9w++bAvN8vY6RrHl+wdnpOqtJIv5ZRw48Wl8ZlID+Zg=;
 b=ilNZ7QgDERKBVKJ7pHj76QEVabkuYT4hJP9wN6vSDjdKh2RzuNqoZV/YfjTbJxUFgN
 mowkscFrhFbjeOMP3em2l4K36kN7dRZvNE2XDSDincy+ae8eAqEEloB6uKWodOwQYx/e
 4hMtsxQqYinb94A3jW4THqeGlN4UvU+3cCXwqy3APFwuuy6Hc1zbO2yJv5g5evpsfqkk
 Azlk1CGSp2Ha9n45bBtYe1JUSo0KiNXhSSHG9RhQUpB0GZMvAqQ94uZxPmTv8piumJLs
 C/zqclY3L/2s3sQ+whwy7pxUawXf1CwbZIqcKqqGlVBKNX1Ij4kcXInNsT2BGDZ90YWE
 GY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019587; x=1747624387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9w++bAvN8vY6RrHl+wdnpOqtJIv5ZRw48Wl8ZlID+Zg=;
 b=Qo4EOcf8ye2r0h0bSV8Y+F1tYrVBgq9DwtO7k9fB3/cu190C+w9XgbKNFh034VcTTk
 dOoz3U3uXZxb7NBECjQbwjx34F2sJOEZCuhO9VGperqacXFw958C68NS7kWhlaEevGX0
 BX+mPpp0JghG1pz2oqbpFpy8MULXN33C1hT8pfJnfyQE/v6z4h2hfBxKiYALwRiNbp41
 EmU9C6MR0LkrUtSh4LgpX0mfeocZYy9bpsEAdot39RtjqGBytQ4L4sXwGW4mgQaPKTTC
 m8IX8C7NCcEjsNiP4dPNK3uOX1qXFMxGPzqyBMyEkt+sKNS8ungs7g0kq9iuDs+ZbqpU
 bZ5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv1A/bcJ5TtjTf7yvsGX14luvc8mAYR8HPAo7VNCOgT90e/y5I0YLoTv0bvLUDD+uv4WUIpfMoc+/R@nongnu.org
X-Gm-Message-State: AOJu0YwAGZVeUgQevKHsvLsBv0p+SUzvOOTCCcIiEA43kX/zyriZRvEi
 sRg+PjRVRQUi7Og1QnY19aZVNlzXRvpwSDsVdtQct5J/jto4hjs9ox5YtQ==
X-Gm-Gg: ASbGncuvy8voo5rcy+aUP4Z/esJVB7ZIe9jIluWtMa8+6OCqlDC6cDqMTMpASOTtMEg
 20OPEnaf8MfGwlArzdkOrVsq3m5VX3Zod/b4ZBEe7VhKUKjLx1IPtO31I9AJFGb6ZFhfssS8x6x
 Gi1/JWP7awxAMn0u7WKyOARe04LXYdXG9aMA5NWS8S33EaK1ZCg83t5ZSzARPIhnTVifr3rlfG6
 xHyBPhIpfn/wQpTbkIwUoavjO73sGsdv/7kBP5PdfLu6UqV+k6oPc3+aj66+Od74D6p8ZvLJGVc
 n+wk5apQakIR3lpnsAU8OK4ox+DPeOFltBRX7Y9186BIoOg6B8AqTRZrvg==
X-Google-Smtp-Source: AGHT+IEm1dzfEUSHqVroAQ5eqYxuFsSfuQ2pGc+6eF2nbEL19jNQZP7TUo39HviOllZXtl37gKmeIg==
X-Received: by 2002:a05:6a20:cfa3:b0:1f5:80a3:afe8 with SMTP id
 adf61e73a8af0-215abd4f275mr17038863637.39.1747019586938; 
 Sun, 11 May 2025 20:13:06 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:13:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 32/50] ppc/xive: Split xive recompute from IPB function
Date: Mon, 12 May 2025 13:10:41 +1000
Message-ID: <20250512031100.439842-33-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Further split xive_tctx_pipr_update() by splitting out a new function
that is used to re-compute the PIPR from IPB. This is generally only
used with XIVE1, because group interrputs require more logic.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 25f6c69c44..5ff1b8f024 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -225,6 +225,20 @@ void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
     xive_tctx_notify(tctx, ring, group_level);
  }
 
+static void xive_tctx_pipr_recompute_from_ipb(XiveTCTX *tctx, uint8_t ring)
+{
+    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
+    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
+    uint8_t *aregs = &tctx->regs[alt_ring];
+    uint8_t *regs = &tctx->regs[ring];
+
+    /* Does not support a presented group interrupt */
+    g_assert(!xive_nsr_indicates_group_exception(alt_ring, aregs[TM_NSR]));
+
+    aregs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
+    xive_tctx_notify(tctx, ring, 0);
+}
+
 void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
                             uint8_t group_level)
 {
@@ -517,7 +531,12 @@ static void xive_tm_set_os_lgs(XivePresenter *xptr, XiveTCTX *tctx,
 static void xive_tm_set_os_pending(XivePresenter *xptr, XiveTCTX *tctx,
                                    hwaddr offset, uint64_t value, unsigned size)
 {
-    xive_tctx_pipr_update(tctx, TM_QW1_OS, value & 0xff, 0);
+    uint8_t ring = TM_QW1_OS;
+    uint8_t *regs = &tctx->regs[ring];
+
+    /* XXX: how should this work exactly? */
+    regs[TM_IPB] |= xive_priority_to_ipb(value & 0xff);
+    xive_tctx_pipr_recompute_from_ipb(tctx, ring);
 }
 
 static void xive_os_cam_decode(uint32_t cam, uint8_t *nvt_blk,
@@ -601,14 +620,14 @@ static void xive_tctx_need_resend(XiveRouter *xrtr, XiveTCTX *tctx,
     }
 
     /*
-     * Always call xive_tctx_pipr_update(). Even if there were no
+     * Always call xive_tctx_recompute_from_ipb(). Even if there were no
      * escalation triggered, there could be a pending interrupt which
      * was saved when the context was pulled and that we need to take
      * into account by recalculating the PIPR (which is not
      * saved/restored).
      * It will also raise the External interrupt signal if needed.
      */
-    xive_tctx_pipr_update(tctx, TM_QW1_OS, 0xFF, 0); /* fxb */
+    xive_tctx_pipr_recompute_from_ipb(tctx, TM_QW1_OS); /* fxb */
 }
 
 /*
-- 
2.47.1


