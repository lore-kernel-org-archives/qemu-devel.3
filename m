Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E66CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZSps-0006jw-C0; Tue, 16 Jun 2026 08:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZSpr-0006jY-Bp
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:24:07 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZSpp-00038Z-V2
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:24:07 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-66077c46c5cso4188102d50.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 05:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781612644; cv=none;
 d=google.com; s=arc-20240605;
 b=GBu5l9l+MdRl1NexBaYAib7JOcnY/osfaik6wjO6QqppMz78iDB7F9xByMS+Poll0r
 TK3dM3kf0OYarm0cqq3c4IuyHPcGnjlFIdzyfoL2V1pekw4sVN13Gn7z6A0u/VfLTmrS
 jYipgpAx2YEPwZ6A2w7N4zB8ewSA9S43f5YZwy2OK4cVQ4X9o9E8DVKJ5qyjt9AAfmy/
 S3ITFgpP5vpwfzuQedlMtFywgc3DxaA3hkukmvKIiugBZLqMCc9fSZIROzsfg6OT+Fyp
 PgtBrWwbzW+zRmacvDhuwzj0PJRgUp5pcu1W8y2680OMmeL3agjAVgmZEnLRzn/dBiOO
 mF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/B94nqu8Guq8yp5C/hGc7K7TeKF1J8c/HoyWNijNJWE=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=XVfzQMRt3jx9437cHBqub06n6xpT7sEldbdtvxxyoZHngrUVFWPlA10euggPv9jmXe
 cE+87LTGQPny0+jRUS3j0GupecCnAl84T9CdEgB3hOPLQiCoii5E3ffnY10cXV2Uf1Dn
 /UbtoY36GfaE4QS9U/6Bd+tmZYM+gpIIhLpnIQ48XxOpxeqwQe7dyQZ+LyHP11YPZiCH
 qL4jy4qhzBMXGFnWa/U4QvPCBo3EJkQCsrtvMiGArd7OR/LLEwMsHRyyzeGI9MqyFwfR
 HVXOCprKbP2+bkpNIiJLkwqQzhPeY8WQZ4wrmyL2C0xWuG3TLHy9Z658qiIuMROhC1Yl
 tD1A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781612644; x=1782217444; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/B94nqu8Guq8yp5C/hGc7K7TeKF1J8c/HoyWNijNJWE=;
 b=F2riTnGqMfKNqWxgVolm+dwXIrL09YfLH40H61dIZFBkJ1GoYoq+HhAW3wXbP8Lzcc
 7gb5L0pnhHyDrIE3wDqmKlUeIRhNtYtOUVU1B1t3GlmaTxuTImgBak//RChIcMrEImMY
 g4BL9uFvIh4Dzc5ACJmY+vGalYI+L6IBffPfgrMMy06gRa8PzbQMX+CBAmpz4pmLjJO+
 LVT1frlNoHa836lfj/5FuLWAcvswpbxdp5GE3T7cRVXyNXFpEzBDiJH7HR0ekkTWvAWy
 ufmy1VCOGLhMVb8zN2KKca0RlMPUSuO4QsacvM1ZcyxHu+yYhhn8EMXx6jvuh9OCnfkd
 5BRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781612644; x=1782217444;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/B94nqu8Guq8yp5C/hGc7K7TeKF1J8c/HoyWNijNJWE=;
 b=JQcOfKWvplKnvESRdZ6WZwrKLrggm7zdFp2W2zV7ZETJqghd7RHYBw9Pp2ovwAhDs2
 M2XnPFiD85vGBm8dnrzkjGkSE/hA/lXb7M/npFLZHitpTqKQ/5ITTLVfU2xHeih/SNQk
 qC8BqpPKLGx0cxevPDCUorgIdnuDF/cpbn/AKG0brghzKVr1ivprs2Ca/dzzOLRJYfxu
 1wYbaqyPUlQRN02C1vUESaIWvYLhBKj472rUPqgwHIgRrHtbIpVSLgjeHQyXzqrxO7Qo
 VAE6Au3f3EmapfNlmWNaoZyBknOnOxipVCE/17IPUYrwa3Q1+G2hfa+wf+rMKA0Whk9D
 CkJg==
X-Gm-Message-State: AOJu0YwgCa9WPLd1CCrPEoH/kISnGh+R44VAH4QbRQSlFfJ0igW85r3G
 lWBwJFM/hKO0XOw5qFx3376XEkgJRJCNCcwIKnDK+f7Kh3WdPsMppn2QsFjCBevd1R5FqJyQY6e
 ZEYWoi7ckVGEa4tSZQsXbuxJb9Vc+zQKNUMf84WSoHg==
X-Gm-Gg: AfdE7cmoGfhvla+zGOpjj+NYstH1RcInU6/7cnloZHeJEdpjgtZRnHEffmXS8FIFpaS
 1pTVClYwKuwslqZckZoQKvBoW+fucT6Vp/vPc8o4jtLO8V3GyLhHK8LiGgITffYRbf5jJN8DlHj
 rhDVIC7+tmrA4OYW+lRS/h/2ze3bDqk+kZA/OJT2AOirb9eqcJrMkQNtUI9esAh2l3jVZ4bMLav
 XWwRCovIyuGvmXjDyBToVV/rWKr0Qdcdsj1KoSQkVQ9ZGoCf3KMLki0Wo2uwNCrozbSBAz33bvf
 bIgLIdnqTAlxD0ASdaBMFQPj7HjhSSR/UnCYic+TrWpCRRort8u1eiqTNLnNcqz8TXk=
X-Received: by 2002:a05:690e:4390:b0:650:789b:a3c with SMTP id
 956f58d0204a3-662b6105c9cmr1704342d50.35.1781612644509; Tue, 16 Jun 2026
 05:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-6-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 13:23:53 +0100
X-Gm-Features: AVVi8Cf9_dhQLNh4XVACnboRTQYHWGRkBc7jEPJugMFR7ckYNT9TwXQfPUbeiKc
Message-ID: <CAFEAcA_-c_Q8uwM3qdP76HE=OcHokEEjL61PPwPrnfWBz4N+HA@mail.gmail.com>
Subject: Re: [PATCH 05/25] target/arm: Implement SVE integer unary operations
 (predicated, zeroing)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Fri, 5 Jun 2026 at 00:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This includes ABS, NEG, SXT{B,H,W}.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 15 +++++++++++++++
>  target/arm/tcg/sve.decode      |  9 +++++++++
>  2 files changed, 24 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

