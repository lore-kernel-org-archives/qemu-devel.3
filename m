Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F18C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZme-0007AX-Gc; Thu, 27 Aug 2026 09:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzZmc-00079H-8k
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:04:42 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzZma-0003D3-Mo
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:04:42 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-85aeb506b78so14929637b3.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 06:04:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787835879; cv=none;
 d=google.com; s=arc-20260327;
 b=rdqen6RiGNwe8C58V4YU0NBXdQOwhONcfdoRvSyRMQn4gOjaeZgCO4ayghhG0xZBA6
 noJF933Swrfpc3/7mz/5Fn8wlVcPZ8iMpY4+8Wz/l+Q+goJGR8/7j0j8wvcFZYqM9jCG
 B0aPp6jRFgSxJhcnIcFm2pB9v6IZUQAeQmfJUoR2s40HTyL1FM9zaPDkHXLH1JV3NW4M
 HHokwm/8s2xesnHKzForvssWprUP+BbDn7bDL+3F1HX5tQcUTuPhIq9CPYbVC8R1loVh
 GwAYrnHnixf+fRBJSepu3vXw2dNXVQ6GWzug3gCVjQSZi2DKRZdfyY2UqMF2kQqq04yk
 lDOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=62k/CJQ0lXxi9UZloI9PLMrWhr2gyA6vlJXi0b46kZw=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=gyGLKhd4f8Bp4cyOP7Yn5sS2Cn4/ikzS/GlBcJXA2kA8pmqSG6fLdlTWcQpkkEnkV5
 2U98XP0KsZ60x3X9dTuB8hD7kd9hMLiFhSfByp7ZHooDwcWmdyOP1RS45cgRQckjme/I
 9+lSd0Ovy+KWidbEX7YXkqK+Lx9I+kxiuIDsDHIqUZdc9BsjPb8b+cWlkTloLQgrmi3S
 2XUPddJVLephAK80d3WV/PIQ+l2O9e9tIe/V6ToqUnyYZ8K9w4j/NiwtDlsVY+vLJX6z
 vCDR8Ipic96XFPgOJj718vtxi8e7SLDYncLcTc1MdEuK+iETTkAGD9jtsIexUxkKDOL2
 JMFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787835879; x=1788440679; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=62k/CJQ0lXxi9UZloI9PLMrWhr2gyA6vlJXi0b46kZw=;
 b=QQxni7tJJQ9EXOa/RYnizOH5NizPop/yKZvaOL7nZrqPfeMOKI5c+N2FXe4+EFa46k
 sqFQI5sAe5/u6KWUkoqwigMohKS+XNByN6vHuUSAkk4GcdJFnb8Hlrg7iZ3SvlXtMgC3
 ZDBZISlGFw2wC/+Owh0i7WJ0i6e6/1PLAHFQLTTNOltA/m79qzKQM8hDF8o6SAhM2Oeb
 YZpjYL+U1tRWEqujxszL0WcywCNR26l/jgyRkDQ/RcMnEhW9zNKUA6vnc5ZGx5AFMYHM
 sba2g7hzMWYQZnVG8iQDdkPtYvns0CQ3AlmEcNK6TyqIIPdeYsbZ3/bEVhZdJ0IC0ySZ
 Pxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787835879; x=1788440679;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=62k/CJQ0lXxi9UZloI9PLMrWhr2gyA6vlJXi0b46kZw=;
 b=I4iNue2cLe+hke5L/iuL1RhJlspwVe4wGJBfOA66yf4slG+dGbSAUGnFSf35lZqVc4
 YeCmbo76NeCeYZAq0iVkVb1LVCjxvjkv57oj7/rPCgI6xOXj2jcrq609s2rD9j8oIm1P
 BDvra0/jHWR2/qzg4JgfNtK1Slc7vpNb8gF98vq5laW+FXtj3Kkpi/hq1BBMJkT+seIw
 00/GgB+86O7SaNSI5+wQLbIqrCCluVQRtKmhDIz0RkhO8xmQXl0K5WueUi1UwIL0NTke
 5r1OY08TFdDuxF926TquFpQdLqbD1Fs4iI8TBmm7VXiUSxCOM/YhW/yDGSKs9+3+2cyo
 7wIg==
X-Gm-Message-State: AFuF++kbUEULX7hnX2qIgw0i2S5PVDHmWhiuPrqYvz1ewHcN6Ftj5fhh
 l7PomlKVw55ywDpBwK+tVd9PJPVREcGoVn9FyvNNPp759qxfd4L3oI0QMnhacgU4z1TgnJtZ40r
 dtoVfVi8tCOYqfslkim52HuN1tygvEVqXIMr67bqX5A==
X-Gm-Gg: AR+sD13y3eBizHZw5rWtu2qD7hXhOcnqhEeDF131VgrCIKXSsv/7iFyQVqQ4jrbuS1L
 dqF1bhz4KL8hOHTYWYQa4YlLCOEtXbUkzLa2JW8rDwelf8rnpe1AU/pRtypIV5L3O0z8CAFXRdl
 txZUbol7Q9KGWLm+NuPkvQZo+sgETJiJ68YHLwDZOXi0SnZO09PA5umh6eyTiXmGzoJ8nKt+mvx
 WVKtfsTi5p0kekTAwxecmL3DTshbOYM88TpW31a0hWuZz90k+f66aYfGA/7p/mB1JC0HnKEmnp/
 iF+SKS2BL1QyW7cG1WwKEaeoXLs9LmaqoC2y1pevXs33MU5cUXQvQDySL5yS7Y9pHf+ygcFr9MV
 Z6lsFWMuq2xnAoJQtjCuhXZSCsIPV
X-Received: by 2002:a05:690c:6e86:b0:844:c27b:35dc with SMTP id
 00721157ae682-8573fdc504fmr65654557b3.18.1787835878777; Thu, 27 Aug 2026
 06:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260826174213.614571-1-richard.henderson@linaro.org>
 <20260826174213.614571-4-richard.henderson@linaro.org>
In-Reply-To: <20260826174213.614571-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 14:04:27 +0100
X-Gm-Features: AcwNN1VJMqMelFR4tDdlXLYqB4WnnfO1N6VtQm1Lh-L67GaGKysUICvbidjcmPM
Message-ID: <CAFEAcA-xh=2BR1-C+50nV_rR=R3pk9ET9qH_oE9-=2awKhi9MA@mail.gmail.com>
Subject: Re: [PATCH v2 03/25] target/arm: Split decode of BFloat SME FMAX/FMIN
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Wed, 26 Aug 2026 at 18:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Split decode so that feature detection can be handled
> external to do_zzz_{n1,nn}_fpst.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

