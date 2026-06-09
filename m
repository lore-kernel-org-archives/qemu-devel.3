Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A105CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWz5b-0007hv-RK; Tue, 09 Jun 2026 12:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWz5a-0007hE-Ff
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:14:06 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWz5Y-0006j7-Ne
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:14:06 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bec450b950dso829983166b.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 09:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781021643; cv=none;
 d=google.com; s=arc-20240605;
 b=JqJ3ixs5kkfjBbtXvAxilq5x2Kqc6LATb1aEdjufNK2XejaQ+aTROAQ9MCzjF0pHAU
 HqPNE7pOARjDKJ1c7Oe8TJaukzS4OU2AA/xgjmMQV/Bffdb4XcFv/T9JX2rEFtaSeIQN
 u8Oj88yNoZQTudKC8Byesw6BQlmaswKFkdDXqDxBGc4QQLD/r5oCk0dPy6j624I+wtYr
 L+F81gFyuNtFCfWSMOrlB3l+km72rBWbNALb8AR7Rp8neznyo3WSGLe14XiDDPWWY9xy
 eCrxjC3vv2prChcQu8GibLatolAyFRtvGZ7VE/XW3lTnoy3f+9BJYYPNvG7QUewtyTMm
 KtYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QH8QnGRoMGOpdIvL0G00X1FWB9M3SwC/e58ot5dOTso=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=f3/2TDc4cpyWPlGaCzMdSQIFwOGLQeuSkKmzzhdIHJvsAB8+o8IdNXBmzJgRHJIh1F
 mGiqx35jMg7f+K1EFKvvK183GxW6ly/j1Fjh5Ux3kdAGTfrpPLFwgEWX12S4jhVYidh+
 3/5UkjN56DQbJQHOmVWhTLuMw7mDd9RMFxoDYkcAotZs5qjyL0UrR+blIjqDnURn8BtD
 5QPasJz/0UH6lgXjSLZLCm0t9Qro2Bqv6UsN4kbN4ud3LqEd1926ZfOm5x/+yRKaU0vg
 cJy2EyVfP6h8mNIGPnKFOJl8RT1ZFIuYfdrevB5S2jP7njT0a/oc31uTuAQljAsz01zH
 wHfQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781021643; x=1781626443; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QH8QnGRoMGOpdIvL0G00X1FWB9M3SwC/e58ot5dOTso=;
 b=FYndp5Kv+DFsNJ+TfEy+aI/t0Mlva4pWwKa7jeeCYIJUAt9o2J2kAKYB6jfPRxBlAx
 klnZliY0D7TXuOwaj199fduH7XItXEGsU3N5hM5W8oJSniSOdQfKZ+OG9hfnBi1Z7TpB
 ZsDYzGe8gITVzmQ/SCYCuYSGJncjRFuSCyK2gwPtONVrvzrfcHR/iFD8oPxEFlLrsiqO
 V2Z/+KrazbkN8+o+GxuReAaMQErogVEx27HTO8aSt3siMmCD/yMTHntGaUg2O/mmgjAp
 H+UlOJXSAcHW8pd75kg1FZdh1WT4T4fmoovHCdfrexl6Xq+eZC8nNSqGKYA5AzgVIEBH
 r4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781021643; x=1781626443;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QH8QnGRoMGOpdIvL0G00X1FWB9M3SwC/e58ot5dOTso=;
 b=NFuc5LUsQJ3SxGx7s3CPpAWhkozfkCeSIXG/6WG95P94geZ8G2GYl+SELru6xlJW1A
 N5W6BHlOMQtKEwg7kLMVOmUNxJyTXCv4L+xLDLcIROmrNP+fdjgRKhrwMroelPcCSVDw
 /H4QFjATs3ZV87HNU+UwE5XJAaEnt2X0LEijAuM89hXG69X7wJXVp0O/oBA0NuWZI5us
 zAQ6kKAh6WI2Z4wJ3LY6qL2coWfAW/CVsjUJI1TLjRYba5gYiEfl3v+Nw2bjNTBIbt3v
 FigcCbsQ8Fm/TYCjmTXhjZxk3YslnOP6VtV7H9MqwpnUFeVbeqwQY03LU9p+mhrQbYU8
 RILg==
X-Gm-Message-State: AOJu0YxEq04jvVz7lmBps3S0ayaw8R2zBWqMsuJaSY3XoKPWDWeJ1H9l
 BHxOHIBHpJd4sLCdzMcsvKH00jrKaFhw/v/0v3+3hL0gTmfXvemEesKOA8+4x6A/po6NRXkw66l
 +8/JU/cmqv2aYnuPOO/aAm0v9X1PpAA/3iZG/XUUI2A==
X-Gm-Gg: Acq92OHcm9LSo0jgorNB8mvWq6eP+lkf7HKDQbGdnooXQcsqL7JcRVPe1UDfvoDloXf
 3DMo3M24Uf1izPIKLt3pcxHv34BSOXR4tC7SBEVPsAvQ9AiVfhNNlpUPM8knNZxE6ZtMFM2nq33
 qSDQGmKf3R3RNU10e4OI+rSPH1UCZkz/0wPeWUjgyOkW/P6FHpNWRV2FSadfjdFc3qd+G3nJOsB
 GWV7Z1WDz5hCaveKwaPqpEam4Dmyaq6e2wZ3b3CS2AitrjJtLtkB8Y93Vt5jzB71LxI1Zs32VVT
 UaZJWGJYRhWY9MHKHpIJx25FKWMgFRqACcMsvfWPKX4zBlDuDHPc5dr/p+RypMTrrjaSVtyCF52
 RKw==
X-Received: by 2002:a17:907:c398:b0:beb:5b37:751b with SMTP id
 a640c23a62f3a-bf372e22c07mr981693866b.37.1781021642998; Tue, 09 Jun 2026
 09:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-36-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-36-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 17:13:49 +0100
X-Gm-Features: AVVi8Cdh5j0xz9JLrtykdZgFzsh3VbsTlWQ6aQ7bnXJveUvjNC5D5h0tsndj2UI
Message-ID: <CAFEAcA8fCKHkmpedmxKLLrfEU6rMJO9iUU-pwTzdTnFuoRiKuQ@mail.gmail.com>
Subject: Re: [PATCH v9 35/45] target/arm: Implement FDOT (FP8 to FP32) for SVE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 3 Jun 2026 at 04:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

