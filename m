Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3F8C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6Bp-0005Nx-AK; Tue, 21 Jul 2026 04:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bn-0005N1-Hd
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:50:59 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bl-0005gA-TW
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:50:59 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so9686252f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784623856; x=1785228656; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3pdZrBiJ/ZHAwvk1OO5i4mEcP54HyOUllZ94ugx0dKk=;
 b=WUbiVUhdRUmeJLXuw5HvHOBdsp6X+Pbj32TTryT+WDqdOrZmWi4KtrCpMKM8L+s9JY
 AjLo1TEFga3tx7nWmolEkmUghUvjeIdnchfATAoKS5VPv3C3WUenDpAYvpkz69y+e0e/
 GxkQFQVknkAmQCwpWo1TXyF3u5F2Go+YJ4q41vm7SwiajfpzbyqhCQnfgUnqqgN6lYf2
 udRKpY76S3mXbe1OCGpwH5EkOquFN9/0i/Rge87jhxjgUttci/Ht4KmlFJEOGs4nwF2V
 cC7tk/aJpWqSm84GKsPpIsbA4Na/6qFhgt2IbZpNZXyoyYG3gZXFbBcxXBT05/2hJg9b
 ngWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784623856; x=1785228656;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3pdZrBiJ/ZHAwvk1OO5i4mEcP54HyOUllZ94ugx0dKk=;
 b=qBBTaf2XbxAHsyEiPXhQNNuBGygb3Ah1B86WM4IPFNMmUAQIzhgGmi31L1j+Srl2WS
 qIoPyBLmKQK3CMBFkr/HojjrjoMSZ9aRA3m1axnIOaliI9CjVu6T+mMw4hhuBnw5wXHi
 Iop3ygh4bvc3NK14C0kmKpAaNCduychsbhe97Dy0Ytcw+goY/NldCJ+XXADsJgrlB31F
 vAH88URAkCO9jYGs+YVLKZvlCOxceCJw1DX0oghC0/jGtB5H9TLdeh82ndAymSylR/FN
 Pi+MlhDedjne4zTEfAq1hnowv+3siue3ZVK9XmHeA31zCayXbPDpNL1hUHQeteBM4AoQ
 gyIg==
X-Gm-Message-State: AOJu0YzuF8KYyJFQp2M0UI+aGU0MFMtRPtNzePOBF2PPBBoLUqIUoYf9
 iWNYnrrdsBIjMYhhpneufZfOyrdz3AM6wYISeTvYpQ7lUsDpfSSetI+2bKJRn1dtGirlXneDG/C
 glRWEHkD0EA==
X-Gm-Gg: AfdE7cmY9COzLo89l0crgOf5b0xY+lH3KhInxlTY42XVxSvbJGnpW/EHLk5H1KpdgvC
 ELw1gF/AyCuh3XMq0Wsn22bM3dDqQTuOw5q+oe/YEEDJQeHmbPGE6FTVAMWyBZ/AZ55WT9lZ9kX
 geGXSiBQJgbFAP19p0p26UvNwv4zxKr6LU4p0MYDoTp8LZzdMwjv0f0uSkNRiRbamVJBC7kS+17
 EpRJwVWEEnrzIq7Pa71glA8OVeDt0pcCXgSXM4L4h+B0Lw9FEjYCg7wk/sGy506RPCRm4/6nDUD
 PemC1XRt5siqe13SMaX0ogzd1tTbF63RXycBfdnc2+eU1B9InIkgMJ1C8zUYQZO5SFQCAwhVdoT
 FtUtH34K8bBM9ORiTyWNynMj1YlAo8VLM9f4NJKZTl70zI0OI/epez7KeOBgYRKMdkYL5QDgX1l
 iXIKHp/BVVg6U0pZjamp2Vfy8MMy9BvuCTMT6RTC8pDz5cjGgJXkV2p5MMTQe4hsIBPCQ3IE/7c
 hOsrfvSdrw2zlqdeBWsEA==
X-Received: by 2002:a05:600c:3baa:b0:495:52a5:8815 with SMTP id
 5b1f17b1804b1-49552a588admr178032185e9.6.1784623856487; 
 Tue, 21 Jul 2026 01:50:56 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c7desm68707245e9.7.2026.07.21.01.50.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:50:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/16] target/arm: GICv5 cpuif: gicr_cdia_read() ppibit should
 be 64 bits
Date: Tue, 21 Jul 2026 09:50:37 +0100
Message-ID: <20260721085050.421257-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721085050.421257-1-peter.maydell@linaro.org>
References: <20260721085050.421257-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

In gicr_cdia_read() we turn a PPI interrupt ID into a register
index and a bit mask with a 1 for the bit we want to change:

        ppireg = id / 64;
        ppibit = 1ULL << (id % 64);

However, we used the wrong type for ppibit, making it a uint32_t.  If
'id' is too large we'll shift off the end, so we won't ever update
the state of PPIs with indexes above 31.

This didn't have any visible effects because the currently allocated
architected PPIs are indexes 0..31, so you'd only see this if for
some reason a guest was manually marking as pending a PPI in 32..63.

Fix the type of ppibit to the intended 64 bit width.

Fixes: 3f79212abae89 ("target/arm: GICv5 cpuif: Implement GICR CDIA command")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260714091806.3568281-2-peter.maydell@linaro.org
---
 target/arm/tcg/gicv5-cpuif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 1cdd4103d0e..8e2a08fdb6f 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -633,7 +633,8 @@ static uint64_t gicr_cdia_read(CPUARMState *env, const ARMCPRegInfo *ri)
     switch (type) {
     case GICV5_PPI:
     {
-        uint32_t ppireg, ppibit;
+        uint32_t ppireg;
+        uint64_t ppibit;
 
         assert(id < GICV5_NUM_PPIS);
         ppireg = id / 64;
-- 
2.43.0


