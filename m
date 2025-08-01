Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017C8C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 17:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhtAY-0003av-4m; Fri, 01 Aug 2025 13:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrlQ-00070U-3S
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:33:45 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrlO-0006Cl-JX
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:33:43 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-708d90aa8f9so24732887b3.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754062421; x=1754667221; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BQNPETmCopuBJJBEyZsY7oN3ogVx/nhnC3R4zxFXhc4=;
 b=l9fbdYBu/SsnHqMfBO/QWbaR42nY4lJMsWZU/rYNZ4pSnM5cOXSPcECfkRqx+Sbjby
 ASI1RponUAI+wDH2W1Y9meJcob1GPKy/bHIyu32k7rNlCOhIpj7qWuCTNQFABj6SAhga
 IuMD4+DofrXK1LAHwaJNKeVwCf7cIe+7vWP3KgVw/JZwh1fta5CZxs1/j1jsdQ5hXB+7
 k+Gb7iefOUT4zwKolDCweCoseWt91k7sJ95CnyceSuCw2QxNJrV5TbA+ZQnEjoh6EjjJ
 9NNsU1kIVDfr2YgtBbLaPseXbZYcVysYNBK7jyftxNUkxxhlSSTWGpnl9MAXcnXr1nTT
 TbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754062421; x=1754667221;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BQNPETmCopuBJJBEyZsY7oN3ogVx/nhnC3R4zxFXhc4=;
 b=I40oSZ3SvFYe4i53NVribJfFAm/6SbhWFbbA9rp2+sQ1ZG4vpb0E3LedhUUYqiiXa6
 j6dJDfhc0v/CAe8kjvEsZvWM5Gj8iJ4X0vXk7wi2qGitcYBtsUz83e5bxa9SCPhcPyvf
 1D056zvGvENEXy0ujdzCafe8TawZFAWr4qHkCWBP3QaumiSNhrFXGtZLYBmH15hWBrbW
 lTu5oDg5P/ukfBtbE8kQdnC0vq/wuAvYjrRKU3z1T2gt8+Iw61p0WRtvJMKWXmAs5IUf
 NhoS8ZYUancK1QWxXi1zv8ZyqDolzzrfHcXwRTazrZrFWUuT3Rpn76hhyXGD4gigoCPq
 75BA==
X-Gm-Message-State: AOJu0Yw5b+kb4v9/1ZFv9Ck6OAXnOJ2m2wnrYzcihAj/xzjpTSnWwyrZ
 4mLmbh3n0oZDb+MKoVONSkIRkETeGaVcSBrN5tEC0CiJzpYzOWLB9TXBpSRUI31Kh3Q4IFOrS4r
 YAhgjavN19TbCDI8RGR+g562/PE3InuyDCoFogjbdXhL9xFSquoUv
X-Gm-Gg: ASbGncsl+yvoDhPbzM64vtm/pLHc/CBKTZWCmFeF0Ab2cFExbpjTk20iv5O+8JmByzI
 Rq5fryY0kKZf2vP2rkIG5RAV7ySGBf4+jB+Omtd1y5jKGzgoaS4DdBR4jmR2HaSdotOCJaDQ9fa
 UFuB8DwG/+HxCJHHkQU8GJz+F03VTcsq0UBj2Q9UetVqK3ANHZZoQPb6FqhkYgfB2YtOJ3Xq2xY
 g7Ap0Ua
X-Google-Smtp-Source: AGHT+IGwbpfHj3vp3NojB5kQUGoeNXLslsHsvS8E0BbfgqvxP6azJo+CRODiCJODO2NOA4aIKPGeb7nsxrjsu79c++o=
X-Received: by 2002:a05:690c:f91:b0:712:c14a:a388 with SMTP id
 00721157ae682-71b7ed127abmr1345617b3.7.1754062421242; Fri, 01 Aug 2025
 08:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-19-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 16:33:29 +0100
X-Gm-Features: Ac12FXwZn6sIejeN7JrT6NT649UMJR2aFAX3P0y_ZUNyaCE8s8iUwu4dJjKWp7g
Message-ID: <CAFEAcA9adhT8AO-2C7MQfVJV8A=D_LahaZtdN9-UYW0Yz8DZKA@mail.gmail.com>
Subject: Re: [PATCH 18/89] linux-user: Remove ELF_PLATFORM
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Wed, 30 Jul 2025 at 01:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> All real definitions of ELF_PLATFORM are now identical, and the stub
> definitions are NULL.  Provide a weak stub as a fallback definition.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

