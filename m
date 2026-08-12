Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7182DC5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7tg-0005vj-85; Wed, 12 Aug 2026 08:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7tJ-0005JR-KV
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:17:10 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7tH-0000A2-Hi
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:17:04 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso6131955e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537022; x=1787141822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VFAGvdUzF8Q2nO8sgm70jMuASLCRJi0pDi5OWo1q7GI=;
 b=HL/AAm72iY/u63EV1M/6WIVnRZU4ddL6h2eFrxDuGLbsMHzUPAXHKLgQDJK/PBg4t5
 6Wme8j5qwwRIZgHjBFI3WDIQxxigsL55IlsR7V5zKqWfmCaMIl5EGVx6fbT+eMGmQ5Ir
 HA1ybgbz4YR5UaFoh4VpP5esry3zH3vdawVDFXq2uTcOP3xmlZiTthqfNPt+dqAqA4ze
 REyx3ZEUU7w/aYmaJUnzsrdLoxgE69+6UrgLUalMMFqWH6aVk/lCALkTs43aSVefTaA/
 800qP10ct2RgHuSXkgwMJJHTdyTzhE/P6l/K9aq2GVSNQobUSV87y68G50jSnlLwq5WI
 mrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537022; x=1787141822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VFAGvdUzF8Q2nO8sgm70jMuASLCRJi0pDi5OWo1q7GI=;
 b=rjSR5RR5jOFLEDlSq6AdhG1yN3I36sGaIm4EytqVcYsQM7lxQIeO1dUb29l9GYRt9h
 GA0o3Zr9cq//RdPV858ANZ99V6zm7GxeGr0RI6Kdfp+gDpmmAIJXYdES2S3wrkZJvUyd
 Rydh5y9rZQOc4kNft7hJyYu091zdpMdOWnz3v7EniF2BWI/5y9y/VEyVBs7ihMzWuhyo
 lXQypb2hxllDWe+y1coyBU97560MVmuX78P5wY/9BDbqRO39E2YSo7xpntwWwgDOnHoe
 xl2r+rzbMjVsyhzJbJIHd20BvHvosy/hptSzvx/AQEZ2RrBPYnQ36RugEIbTJYzIzvtb
 lLCA==
X-Gm-Message-State: AOJu0Ywd7dZSSJhavXa5h7VI3uny2QEqbu7OMuS8SBl/dLTnpvbYe8Hl
 Mns+CfXXUGEaXNpKTpAN/84NHHo/radupNQsqIfZJEiwHDjeaE0upP4FsE6gD1TxwsklcEaPj9Z
 mxn3c
X-Gm-Gg: AR+sD11RSEPbcZpdAlhFjGNn+lG6iWzvFe0+tte89tEDVgG3SJa7Pu1TEqV2+/ASISi
 Nb66NeYbYlBFB8SfJO4FquvomEB8LiwhM38Hc8zCqpJDChiSl2Tumcwdw/U9jZh4hy402OHMe1K
 enxhmXxr8r7CtKtswlS+bT9HOUhx3HCp8n5eY/9f/A5OTKI49br1KiVvUVJV8TrR77WO85S28Gm
 Z78h/+LY4sbuEhzlVy8gRbb2LoL8X24unRUdgkruRqWRy/C4jfpDP5enzpSOdTVE9dZrYNxxNZU
 +uag67ONlcj8FkN0VXE/Oq/jrnI8ep0I3IwxgEmwa3HWNWWkKRcJRgkgQtk8TxA+HA6QxjX354G
 oK4rAav54EoJeZRiouXPSzzQqqpCd3DI2kEitHlwNCBhVJmubgjlRspCRYjiwnOtWBH6r4GNyza
 KaSWXen7qVj26SYLJy+hHwyYKKeWKf+VrmZ53Tyh2jK0b6cxRL1ynMnY/NPcHftfKb5uug7s0My
 YoGTCt7HL53AElBfTrqHSo73NbASWFo+c+JtGAFygvkAJ6wUg9H0d8rOq45sjbcRAcYNw==
X-Received: by 2002:a05:600c:3586:b0:495:5890:8f6c with SMTP id
 5b1f17b1804b1-4997c116f31mr60235685e9.7.1786537021594; 
 Wed, 12 Aug 2026 05:17:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.17.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:17:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/26] hw/arm/mps2-tz.c: add AN547 AHB PPC EXP1 DMA ports
Date: Wed, 12 Aug 2026 13:16:18 +0100
Message-ID: <20260812121622.649730-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Simon Xu <simonxhy0404@gmail.com>

Page 42 of the AN547 TRM defines the AHB PPC EXP1 ports with DMA 1-3

AN547 TRM: https://developer.arm.com/documentation/dai0547/latest/

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
Message-id: 20260805191257.11303-5-simonxhy0404@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps2-tz.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 81e64a91de..d6d178642b 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1113,6 +1113,14 @@ static void mps2tz_common_init(MachineState *machine)
                 { /* port 7 USER AHB interface 3 */ },
                 { "eth-usb", make_eth_usb, NULL, 0x41400000, 0x200000, { 49 } },
             },
+        }, {
+            .name = "ahb_ppcexp1",
+            .ports = {
+                { /* port 0 reserved */ },
+                { "dma1", make_dma, &mms->dma[1], 0x41201000, 0x1000, { 62, 60, 61 } },
+                { "dma2", make_dma, &mms->dma[2], 0x41202000, 0x1000, { 65, 63, 64 } },
+                { "dma3", make_dma, &mms->dma[3], 0x41203000, 0x1000, { 68, 66, 67 } },
+            },
         },
     };
 
-- 
2.43.0


