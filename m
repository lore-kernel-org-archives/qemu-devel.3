Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0ACC44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIea-0000BP-Pe; Mon, 13 Jul 2026 11:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeK-0008Sn-TX
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:52 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeH-00019K-VE
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:52 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4938d5f86f3so25057025e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956768; x=1784561568; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H10FEuulm4nuHT4cz8qHX6pRrD8O9NpO5njTcbHZkv0=;
 b=emq6UEKK5UHLwNXxmFrm8e3J7rZB1/9qcY07x1jOJoKAbZEHn0RbkIlUJFl9BOtoMJ
 woPKKR9UloNWhoXLiUD8nMA8r0cBw1sfm14dT+FTKucxsY2NNsYYMkwRClKnYQZU7+OF
 pGjLUR8hqax7hUSlkmXCg0339XHF5DtVNIwtD774JGuGiaNOmg69px2peqPTETFaT6AU
 tehlcTiKzfMY95pXokk2fUQ741fA1M063E+A3kAuQHbs/LBmeM57pQGVt8DEQ2bshqhW
 xHwVyVdqwnwSLjhnuoNCsl9PRlLcdYPNVdWI02Y31WubYm4hZgntic0JzC+Xfaihj3N2
 Fstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956768; x=1784561568;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H10FEuulm4nuHT4cz8qHX6pRrD8O9NpO5njTcbHZkv0=;
 b=rDjGOtx273L5XLKI6YpVIe3G2MLL0tC696rWFSKrfmPTQa6U3thzEU4vhGi/S1g61d
 B+7odUsVmuLdle3LJYMeytFUAimhYJQRbpYV3xFSqTJBrTs0OL2Cdn18Yz7Zl2BgHyeW
 fhXlE52JeMcMkDTfKYw+YeOogrG980BOKCXwgmXQvCuV4GHqKjP3z2NtTn+WL3HhrNPR
 Hayn05LYTguLtwl9W/e1p0AfYbVwjTkp+8IHVAqNnw5kWMWhm82MB0PkczR180R6Y9G2
 1lWoZV/ZjM+b3IyP1rz6fRc5Pey4K5FQLY5YoUpJzmBieVU5YhaOGGUvKruwu+Can+WI
 KZig==
X-Gm-Message-State: AOJu0YzlQnR5lGFFb3S0wZ4JAASWnjAmye6F7fY2st99cMipapoXweio
 EAV1odUHytKPaGD8FSQDwCATm63HjSLGJGVBVJYhAFh/tc920HmOapY7xNgU2umtKBJ9yi7ZJnC
 198bsjQsk4g==
X-Gm-Gg: AfdE7cmOCqpqR1PkM9P72ixOdOFG+reIFiNMnOmYcW7IKkodTactxcRvzmeTCUhLUhd
 hs6zOrHWvwc599Sl4wWA3JjHgax/PRh7rT7ykH7bYyY9oNL7zvplFI20UFinjE2iTKFtVBcVhHB
 FYpDiNNHJQ+acqZAl4406Q9LD4W64ab+tupxiPfNSxw2b7v3UN4fuNtltItOoEtQzbPgTnULoPv
 0+r154ogotFHjrYVr2m7Niptt6lqRnuf7Th05f8Jikc16JSqJqBJ6ce01OvujP4IuTBBIUbzpAf
 Z2iDsFfoSSbysYYFqqkjjnA5pjdvWe2MKTy+fr+3UiHe54KsAFOHja4L4m/vVyeWtLGPFmSxvzT
 vpJ/6AiJCAxQ/EpkIEdgCnT/gBNdWtEQzf2/J+IAhCERNL1gPli5tx2qq1RCD2pGvCHrDCnJQPB
 6OzRGSsDZ5ICEHDaR29FQj5btQtOCk0ZXroRp/y7VFywSDTeKxzdvxFAJ8HGLimW9vHCaTqRGUn
 Gqg0KSKJjCq+vRO8UnmSxYLxcpWST5y
X-Received: by 2002:a05:600c:6749:b0:493:edde:54c8 with SMTP id
 5b1f17b1804b1-493f8885b92mr105539245e9.8.1783956767050; 
 Mon, 13 Jul 2026 08:32:47 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/26] docs/system: document FEAT_IVIPT
Date: Mon, 13 Jul 2026 16:32:20 +0100
Message-ID: <20260713153233.3391818-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

This is for documentation completeness - a system implements
FEAT_IVIPT if it implements any permitted instruction cache
implementation. QEMU doesn't model caches which is a
permitted (non)implementation.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260708145841.3032079-6-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 05e85d7a367..7806982e0d6 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -104,6 +104,7 @@ the following architecture extensions:
 - FEAT_I8MM (AArch64 Int8 matrix multiplication instructions)
 - FEAT_IDST (ID space trap handling)
 - FEAT_IESB (Implicit error synchronization event)
+- FEAT_IVIPT (The IVIPT Extension)
 - FEAT_JSCVT (JavaScript conversion instructions)
 - FEAT_LittleEnd (Support for little-endian at EL1 and above)
 - FEAT_LittleEndEL0 (Support for little-endian at EL0)
-- 
2.43.0


