Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2F2CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmD-0008E0-3r; Tue, 26 May 2026 10:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmB-0008Dm-EO
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:28:59 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmA-0001Cz-2L
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:28:59 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-45e8a834cc2so6036319f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805737; x=1780410537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qMeAAySKM8Ob/XB+juiZkU7uyGySsRerpqUnl91/6Mw=;
 b=PXd6Oml9kjEZk1CcMRMDlOgi0cLsmZNh2eMbdPsV1DiZzMl7vMx4Xd3wZIB5PmQv/L
 SSN3sUpI/OMLbuSSF4ZOc/V6ERlehEEOXne/c1Z7JxGQ/xIJguk1l+ubyL2KbkQYv/Cu
 jw3i8wg230lOqZQkAwpTrM8KbghrNSEmncbxthteGn8fovDolSwTds1qxMacgGYAz+9N
 9VyWlotdcZxFtncliS2CHy5+iujP/+uO6swIp9vKancopZErwZPZyPBrcgEHCWSOsrWv
 uJR+cqW6giUQYtlQ3dX62gjuf2cL5VwIE6UwjU856ZjAb9K7sBCS/+RLfCW30y9dS2f6
 cCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805737; x=1780410537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qMeAAySKM8Ob/XB+juiZkU7uyGySsRerpqUnl91/6Mw=;
 b=jpusC7UVynRmql7yeeHzKLqC4jr8bIeKxmjGWohmODrlkwCz/8K5QgakccJpWZjfWo
 4zlj5dsr5wn2I7VAsTMcH6YgQoTdgE3/j42v3zQk3AqEu5VnoDwHW7mmpviuC3mcUQPJ
 tA9WrkHN+DZK8VwsE1FQZ80De+bByVgYvzKa+wUpyYjktTh+YWUnFdUaCMt4kxbnQkYE
 4/lqvd3zW1veyHHn9/QyLUJxYmpVFrDSNaIm5LygiFnDwmJ3x0ZSLjELZvzPs7nDxhtg
 9ukQhSBftLxK59iXEzdgOShSMOXb5N89OiW+u1SFwtz3Z++E7GazRaYOnXjHzznpYcmo
 41tA==
X-Gm-Message-State: AOJu0Ywtgi9NOqq1JRymaGXnRkyfHMhWlF45WCQwOxj7g/9XNp47EoaR
 ndKY+BI5O44KaZeN7ntPGOJwjDtdhdYw5m2FtT2WjnnrLoMFEKjwi2HZo4m2f0ZMHmFryqhlhTq
 MCaNA
X-Gm-Gg: Acq92OH0nJDZdTJnDmvd43YzOUtTZ/UAUd+9q2MDVG64Y+Vzxbzb49qeTLqKlDvrRc0
 87J8ekVQg4iGxEzLdRTMOo9gNeoTDqV8GR9MOW8jkx1fAeEZN+bXIs+UGgIjxliLd1izTYInW1M
 tD+MAVSj5YkgpUhLo7qzgyPsDNZqGHy6RTgNdEJUTMIVXGrl/WBMEoAMqRRlaCKhW4ILgWt1m9C
 ekORxdpf/hx93Fdtd1s0S/L6ROYVVYQxLAFIJ4sAorKfX80x2oe/XhqXi/YvX78hHVZu3k7E0/1
 flLvsZUOD1j9dsZdmE41KksZwnkS3o/qJnn5PxguRQH7HpJVn9M1LXFf8PjPUusU76nm20sw8jh
 WOu4HApEwNKNdjH7O+sKzKcmpos0n7qxNaa7wK3qMSBq50S718fT6EnJ6F9YWvCM3G044JmETQH
 9y+2N3L01Q/njlUmOH6mtXVH8suE1Nett976F63Zwnqb8Nh9fBz2cFKY7Ar6WF8atOBQgWzugEf
 NtpgHoMBy3mgiLNhJhnL9j9+pDknyZe/IbTxHSxhA==
X-Received: by 2002:a05:6000:461b:b0:43d:1c21:ead5 with SMTP id
 ffacd0b85a97d-45eb38b31aamr30032590f8f.22.1779805736768; 
 Tue, 26 May 2026 07:28:56 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.28.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:28:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/54] hw/arm/omap: Remove unused omap1_dma_irq_map[] entries
Date: Tue, 26 May 2026 15:28:01 +0100
Message-ID: <20260526142850.2326589-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

For the one remaining OMAP board, we use only the first 6 entries
in the omap1_dma_irq_map[] array; the rest were for OMAP1610.
Delete the now-unused elements.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260512203414.3633237-5-peter.maydell@linaro.org
---
 hw/arm/omap1.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 15087ba03e..40ca8c9890 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -3710,16 +3710,6 @@ static const struct dma_irq_map omap1_dma_irq_map[] = {
     { 0, OMAP_INT_DMA_CH3 },
     { 0, OMAP_INT_DMA_CH4 },
     { 0, OMAP_INT_DMA_CH5 },
-    { 1, OMAP_INT_1610_DMA_CH6 },
-    { 1, OMAP_INT_1610_DMA_CH7 },
-    { 1, OMAP_INT_1610_DMA_CH8 },
-    { 1, OMAP_INT_1610_DMA_CH9 },
-    { 1, OMAP_INT_1610_DMA_CH10 },
-    { 1, OMAP_INT_1610_DMA_CH11 },
-    { 1, OMAP_INT_1610_DMA_CH12 },
-    { 1, OMAP_INT_1610_DMA_CH13 },
-    { 1, OMAP_INT_1610_DMA_CH14 },
-    { 1, OMAP_INT_1610_DMA_CH15 }
 };
 
 /* DMA ports for OMAP1 */
-- 
2.43.0


