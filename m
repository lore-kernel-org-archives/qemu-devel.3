Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9852CF4BB62
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuw7C-0006P5-0q; Tue, 24 Feb 2026 12:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuw7A-0006IV-BG
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:22:28 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuw77-0000mP-TD
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:22:27 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64acd19e1dfso4975547d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 09:22:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771953744; cv=none;
 d=google.com; s=arc-20240605;
 b=g7botBVB6m4LrjkLjI0iXL18PAYQ3jICjB51j5UAzfRHrrbEgmKGPNm1+dVzOrZaKc
 Aq0pUNL7XyQLmw63dxA1Y8LbO0Y8nGrWpQ9YNKKAry4ZrcUcwPxcBjSmQJoG1UbW4K2v
 YTL7i/ZNzghSVUox90AUAZ9XTB2FaPncbUSl4RIRDquxzWiyHuVYZA4kumi921fU/cFb
 Fu+ivv/y+BwxEVFPkN9SqmnElgvJrNKARIRskIOJe9fboNmjamGrBnMSShIRBdFABWgo
 kNnPHRHImE1JIyFtrqeBdXS6bMx5wG4wCUfhqF2yarbSyYtC1R79HIfk51hCrDQ2mqrZ
 28cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Orn1JOa1PVG3BwpWTOwY4K2r8CY+lXtlrRqPU/SJolc=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=k2GHYlN3d1mw+Zl3oedTGiHDLpK9rTVMaFcAvcifB1VkSFu7dmD7DVjNXBRPv/El3k
 ARPN9wiIqbhVesf8yVo5H4RNzmvNiCHGHpxPYmQqFb09pAZOP61Ockre/Rx3IMfIWWTP
 iMGCX6YDPvisJwANsRBnSVfKpaXWj8jaKpCZ6PMwpAQuOIvN9QL5x0TWGrG3HKq67j6M
 fFmFZaeEtHFikHMg3CyTM/HOz6qP3LvHiLM56KvwQpU1OasNq6w7SLlBOheOgUq8cCcu
 12KqZJCIHm03+4LSGlzZFuGU8oZSk2nfW/uK03vigCWK/Kwzdlm5zmwNlxuiIglMv6C6
 oDRg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771953744; x=1772558544; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Orn1JOa1PVG3BwpWTOwY4K2r8CY+lXtlrRqPU/SJolc=;
 b=Oqn74hhySwQxunK0b3WbCeCpByEfk9XhOib+6KGk0wxiKuhNLmTCtp2cZOr5JzTLj/
 NrtkwGaFGR9OelWbG2gtfoOjS67RO/8XNixretoBOz2Rn211yRhQk5bjqJjShwlZuCB7
 Dy7jumx35IyYbr8Ae93QLFaXKEorMVS/WfObBlRIpQwHUUCNCu6dYbBtMKw4hVC9fmMo
 eHpa6ix4s9GuHFSNOxrn0Ne31dYRxhQsoaQdtwa0EwCYthHX/PMWS7r5UkRhWPAnJgsx
 V+8QKezoPC/3zHeJCwcR0pAFigOOb1ukdwJeBYrUraEif2bcLt0TiHw0MscPQa8uBLL4
 wL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771953744; x=1772558544;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Orn1JOa1PVG3BwpWTOwY4K2r8CY+lXtlrRqPU/SJolc=;
 b=WrI7AH5A3JnFBeAksyrfD2b90Kaim5xOvJ7k3VUVgTMgRGAG9m+cnmgaDAPF8o8qJu
 B7S1Ijc2cEU67ws1gmOs93B8/LQxeGED6lX25dpS4m2nzQuftVsjEeNjNxVTpmn6fBPw
 fewTz40UjG27ivACqVOIb37DI8Rg1w4nDqqzyYIwN6TkuhuuhWeF+GrjgT7P5Y7LYFwR
 Y9xZiIopShosnYrWQkcxbjbDqv+F9dk4hJrUPNtEGfYybDB5hIIBcEXYyT0+psaEzFjL
 gFGCDyU+VkBn7wJdZMuQzL1ZU/UVQqL8KsfDWXn7mV/PL2p/9YjKrey6Fw3q+5/rP3sa
 Z47g==
X-Gm-Message-State: AOJu0YyeaqrAIOu/9KYDSJDbarygX1VruQgDUjhd0XcEVtM+hysCCByv
 pZOpPKDCMDKyhjHbBNFONCfuxDwCw8JirrK8d9njdyH9VbbcBj6Wlmq+8Tc0rFLbX2zOiEZwIhv
 8PO9qdM0AMV7WRlNQOt4+s1qh/64DIv5fPlUkKEvwBA==
X-Gm-Gg: ATEYQzw54DiuCOU2CFi34WHDfFmH1Yc4DUUR0b6o5aXHYrldkVqrHMJyhi0skkwwlAo
 8yfDbC0TnZ0+5dj74uaPSLuTEQMJktkzOHBuOC1q9ffpsgX3JxbAsQhWY8ZjwSHzar6BzA9HpfA
 bCfobm7/zCK2JFsB+rZeIxSRyq6OJzXpcV3VfTkY5fbboJcuAdnjSDKAqZEjpbTDLR29gHeYk2D
 9wAOBMufZ4sXn4d8kMz/54ED3bisRx1F1MSS+2yck/3vj1nvvAZpQQfyA8hUaNHgX1O02x2s8LQ
 Sr0R5AZ0S+qRa9BmsnWUAiPWDChyHNxGuPAfbCOCITLxokhXbzi5tnxU3mWdzTeFidMvjqykHA0
 kWw==
X-Received: by 2002:a05:690e:16cd:b0:64c:a5f9:9b2d with SMTP id
 956f58d0204a3-64ca5f99b88mr599662d50.21.1771953744249; Tue, 24 Feb 2026
 09:22:24 -0800 (PST)
MIME-Version: 1.0
References: <20260216034432.23912-1-richard.henderson@linaro.org>
 <20260216034432.23912-10-richard.henderson@linaro.org>
In-Reply-To: <20260216034432.23912-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 17:22:12 +0000
X-Gm-Features: AaiRm51LGLymf5kvEerbN_PZYN7YUyOlOZEFC5As_CZhVBj3iGtv5aXPnj9YzqI
Message-ID: <CAFEAcA8UMgAD_OT_qOrwmgUX9aEMs7s28w8PFsxug7gFht0uCA@mail.gmail.com>
Subject: Re: [RFC PATCH 09/13] target/arm: Detect SME in
 kvm_arm_get_host_cpu_features
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Mon, 16 Feb 2026 at 03:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/kvm.c | 54 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 51 insertions(+), 3 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

