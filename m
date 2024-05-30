Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46592C27C44
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 14:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCgcE-0008Au-CU; Thu, 30 May 2024 10:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCgcC-0008AP-RX
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:18:48 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCgcB-0002qc-BH
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:18:48 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-35b6467754cso624941f8f.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 07:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717078725; x=1717683525; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P69wEFVx7llWBHk+r3X+KDwvbROibHbPpd9g/4wHp0Q=;
 b=GKSGgBDssnoIX/BI1vdaOMQ4/KCJsr5BMGSJ7dzuQvZTYGiwYx9QewWuwvyEnwb5DD
 Nl/kEYZhfOtPayJWOwE3O5BKdshVqm2/AEK4A4j0eH2ngCBiDmp5LKrIHN4pqoXjrXAq
 ilbDsuS/rThTmUMTY8RqYvS27Cby7zMQbIEOO/vHShZZJO0/d9Np/zhcnfPkpNbaLaOL
 KZNz6FwDVLd1XM9invL3RYhR6FC0jvqeyua/A4meZMUhycOSHq7+DDy+NQeGoQx1vVMj
 gJoNSILGvaO0G6zEgMaLhOTIWX8kExRuzjcgw5xocAC96ksdP8aoUr30DLZisQfPrXuE
 Y80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717078725; x=1717683525;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P69wEFVx7llWBHk+r3X+KDwvbROibHbPpd9g/4wHp0Q=;
 b=Ol7BNQ5WPU591Ou4eDSzePYf/2jDvfkS5A/yn5PmOezqZ7qpLhMwyrpGCF+3Go8XZu
 HvTBimdxsGcOMBZqP1A05liQavs5kE0wruLb++/zdihZ/Fhpr/FvUpvFFrskzYMCLmbt
 3+U5O4xPpyRHf6cwY3PbFifYqWP5wWPlNVGqvo9Xa7gHy6njMjFSBfAupBwlDu6Awqvh
 nN4VPFROyl582BlJjxw742ovMzB5ujTY68nodP4MukC2MCdMbl8tae4FzPNMUHYkNySA
 yi1bNq890JfRT1V1K2MJKJEtxFzfU2fng8aKpAw2GkXeOOzGrysPYDsznuF/3QwLKChP
 FpHw==
X-Gm-Message-State: AOJu0Yy8Ny517rFm/Au2Av7UyjWbXHDvJ+aysBTnclBf4mZviy5t3LF/
 7vSVGijZ4JU5veULoLuFgLn62AQEYg631vfmpUzTTy6Xj1Yjg141sj1KDzEfarDupR6TKXlctj/
 PMUuVJ/JIf/Tioa1Q0uKVML6zyxBHifOY+6HbN9zG+sqzvEdp
X-Google-Smtp-Source: AGHT+IEx47EJiATH+yu2lNCmdNY1VbGc4W6fb5b+s/6C72BB+0LSkuFdERoGdU4UMf1GAvZxCwrQYwoBrFUlRyI+pow=
X-Received: by 2002:a5d:51c5:0:b0:354:de8f:daa0 with SMTP id
 ffacd0b85a97d-35dc00bdce0mr1486652f8f.53.1717078725410; Thu, 30 May 2024
 07:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240528203044.612851-1-richard.henderson@linaro.org>
 <20240528203044.612851-5-richard.henderson@linaro.org>
In-Reply-To: <20240528203044.612851-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 15:18:34 +0100
Message-ID: <CAFEAcA9UdKOh3YxtD=Oy6jBQYaCqAYzNpf1tR0WAWm9rkpY7Xw@mail.gmail.com>
Subject: Re: [PATCH v3 04/33] target/arm: Convert SUQADD and USQADD to gvec
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 28 May 2024 at 21:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h            |  16 +++++
>  target/arm/tcg/translate-a64.h |   6 ++
>  target/arm/tcg/gengvec64.c     | 110 ++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-a64.c | 113 ++++++++++++++-------------------
>  target/arm/tcg/vec_helper.c    |  64 +++++++++++++++++++
>  5 files changed, 245 insertions(+), 64 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

