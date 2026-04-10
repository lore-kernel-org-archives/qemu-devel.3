Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D88F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 18:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBGf4-0003DO-Im; Fri, 10 Apr 2026 14:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBGf1-0003Co-3s
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 14:32:55 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBGez-00051x-1P
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 14:32:54 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso28048655e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 11:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775845971; x=1776450771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xzwcL6GsKaz7inyBzILY3eyTSUx2j00KOrd+KLESyRU=;
 b=xR3lxmSgNlk1kDrNvrX0gt4+wgglPhBasy7XWFy1FyOpReYtiIGbn7lUPZ4QO+C4VM
 NPDKgLyHzlK8c0l+7TnE1qFGJKpjZPmSRIudlP+8xBGrCh5Jh+gUIDkkq308qHPyQLVc
 xDgbAhR51nYoKAoR1W4wIssRXcisocT0VudtPS0wTyXCm3TvZdlRtasyAd5302tWUYU6
 IBJbSB+Ju/JqyOUNYsa++WVlslUUO2FYM9jslG6/HDkLUuAcUjvfsSPwOnTHoeW56jQj
 L+sCwLn+vcLzrZFj8FIIAJeD9OKs/uLLmeFaz3JgKM7h2yhuYeIU3W/R0SY7bh8FY9LJ
 U+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775845971; x=1776450771;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xzwcL6GsKaz7inyBzILY3eyTSUx2j00KOrd+KLESyRU=;
 b=NMOok8qSrBth3YtesZ1Hc3KWvlWWNHuXqNodu+f6xaGZCkXEDpesuqfmyxcWUlYSgd
 BLMbIItBZhERuNg44ReDWZYRUsnCBrssW6V7wR+w3rakgz4pe2JDj+BjqwLNagpR5Qc4
 KOMuajnphupayuP87ROXTcDiFRdKYvHBipboGeN+NPRUvhO99DlmDBBJUTKYRo8QoVvU
 AxLugj7AOfUrtCrRfgadwP4djZ7aCWjVBpRNt/zUmKVdNxWV+JpxLUdpKG1rU4F68b13
 xSsPU7KSyaSRcL1WOpTZB5xPyuqLxbEEtM9f0uw7CsWK828W48t28nQIIwxulJVFQc6o
 pjFw==
X-Gm-Message-State: AOJu0YyTuB4r2T40WXZKxemGwkOyx5BmQYG6F5w+PTal0cRyWOvJsdXy
 R1h5iByc79XRlsr892c/fChBo6xC437FwrKvXJ55ZOgWZrEsMX0q/d2fnsE6vTb8tvT4HsSJGAS
 QRKXNip8=
X-Gm-Gg: AeBDieuSSeM6EoPgSCDrveryC1l5efaBklc/p8PhmKRm9KIeZzFksKutWLgGLqwnonx
 wcIcHrOGwEvm5fd0a+Tj3oN0MNP0Px77bNhnKMe7Irz6e4vBi5qHbdTGih5bZ2pHWgZf0rLRa30
 rVThZHA9jmYfq6u7QDCwfeCmWhyLKIIZ2v+KKmAgoMkyLlr9jtctpMCCnnTLEpuuQmn/cvSri8L
 S79ME0ymrJIysmF5F8y3d0NZRsuXF3hLyE56jIQ1xg4HRiYGmhXMbD07Pz4K75GwDeqj3mVOQvh
 9A606r9rcQ1c1tS09qtKziv3QNOY49MkqnbwWXDfS4aVUQmXIjtqktUmZTUVdTNr5j+YNQKXV1/
 EDVjNz8qpdrr3L7Sns/QxDrBUyqWS8p94xryH314pI6Bnpzrm+RhN5Ntf9IvvscmhA2EhHZoA3T
 eC+HbAnKw8N1XGh4wTvXtKR+E5zQ5Ck3bIuu2cz2SyKgiqK/k5FbJjFsH2mi5ZS2HyF8PCCrWXn
 +59dY+A2cr6tLurzSt5hEaALS0Oaw0HRUDJnwrwCg==
X-Received: by 2002:a05:6000:401e:b0:43c:f52b:8000 with SMTP id
 ffacd0b85a97d-43d642cb005mr6697655f8f.44.1775845970839; 
 Fri, 10 Apr 2026 11:32:50 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e46a85sm9344714f8f.24.2026.04.10.11.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 11:32:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 0/2] hw/display/cirrus_vga: Fix packed-24 color-expansion ops
Date: Fri, 10 Apr 2026 19:32:47 +0100
Message-ID: <20260410183249.4046456-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

The Cirrus Logic VGA card raster ops allow the left side of the input
source to be clipped (or skipped) based on a "destination write mask"
field in the GR2F bitblt register. For 8, 16 and 32bpp, this field has
a simple 3-bit format indicating the number of pixels to skip on the
left edge of each scanline. For 24bpp, the field is 5-bit, and is a
byte count of how many destination bytes to skip.

The card also supports a "color expansion" mode for raster ops where
the input is a monochrome bitmap or bitmap pattern, where each bit is
expanded into a full-color pixel which is either the background or
foreground color (or not drawn at all, for transparency).

We have a bug in our implementation of the interaction of these two
features: for color-expansion to 8/16/32bpp the 3-bit destination
write mask field doesn't allow skipping a full byte of the input
monochrome bitmap, but in 24bpp the 5-bit field means we might need to
skip a byte and a bit of the source. We weren't accounting for this
need to skip a full byte. The result for the "pattern fill" raster op
type (where the input is a repeating 8x8 monochrome tile) is that we
attempt to shift by a negative value, which is caught by the
undefined-behaviour sanitizer. For the other color-expansion ops, we
merely write the wrong data to the display.

This patchset fixes both bugs. The UB one was reported as
https://gitlab.com/qemu-project/qemu/-/work_items/3377

The technical reference manual says that 24-bpp color expansion
"*must* use transparency" and doesn't say what happens if you try to
do it anyway, which is presumably why the other raster op functions in
cirrus_vga_rop2.h don't try to handle the 24bpp write-mask format. I
have left this as it is, since we don't have any reports of UB there.

Big disclaimer on this: I have no guest images that try to use the
Cirrus bitblt handling at all, so I have only developed these against
the reference manual and confirmed that it fixes the UB repro case
from the bug. If anybody does have test images for these that would be
good to test...

This bug has been in QEMU for decades, so I think we're OK letting
it slide to QEMU 11.1.

thanks
-- PMM

Peter Maydell (2):
  hw/display/cirrus_vga: Fix packed-24 color-expansion transparent
    pattern fills
  hw/display/cirrus_vga: Fix packed-24 color-expansion transparent
    copies

 hw/display/cirrus_vga_rop2.h | 52 ++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 5 deletions(-)

-- 
2.43.0


