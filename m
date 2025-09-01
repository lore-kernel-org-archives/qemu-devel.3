Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB50CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 16:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut7Ku-0003Z2-Iz; Mon, 01 Sep 2025 12:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut7Kq-0003Vu-6N
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 12:24:50 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut7Km-0006zK-Ba
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 12:24:47 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e96ee32f86bso3899221276.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 09:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756743881; x=1757348681; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZiO3bgGR3inXbuuVf3DZOKCf6oPacdTtsD5CIWBAUh8=;
 b=RM92iHj+xkgMh+bnOlNr4QzK/lAZPmi/zcoeEimcHBG18f7byyNvvdYykXR7e5Nb2L
 ffAQNaLPuKzj9BCR3VeG33EfFOYKAUgABlZUAMC8+FPKR+vk4CU3/wVvqklPzd6Ogrfk
 2JBVytHoeZyq3Wa2ABSULzceWU1NOkSxnlUXS/t0dMOWP9kpuai2ZNAjgC6mMdYT92iI
 IPwLeXOh8NMWR9UxSnsl05NS2JL3Iox756ZjFImnMA7wjCy1Ip7/7YvEow+baNDTACBD
 JqOhByQuJB03GlNV8TI2qKwBdfLLNChaNQk8XL3IKcYKw4CwEhdkPXs4vSVeNect7o21
 BQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756743881; x=1757348681;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZiO3bgGR3inXbuuVf3DZOKCf6oPacdTtsD5CIWBAUh8=;
 b=BXeaHoqkRS0ave+/TMSwnTWRaHiaa60DN40dZJtY2ptU+R0arU8x6sjHdYQ0cXT1Ut
 EMFCvJcry3BDkEc5KJLR7nuxIq6gV14bl2G2FVSAWPw41cvE+t1+6DvECXaUUtkJ0TS/
 uedKcFDX/zqeoW9sE/1ud1pUeMBM7MF6x4F5pvjSPeFgrkOVZPVffHDll2DajdifiG1P
 KXtUJ9f8dzNrAVDcmSRexEyVs3/HFn1YWa9eViAvFXXPI7ZzZaEs7uR0C8fRb8maJuga
 2BNOpXwHQhgYbFHGOrzyOhr5viti5pfZH59KJfpj2fRQBT9FDL+hSyM7SCpuQheezxtu
 oM6w==
X-Gm-Message-State: AOJu0Ywm8WPp1LESUdWVB+ooPU9vECUtIeYleIc0FGA1NFR3cm+vXo05
 18xjff0uBKC8hk90tqSjkLs6JNXIaYxgDYuVEZC41NBNKQMmQrVv2sVDsMosraf6Rnb5CPagpw3
 4peasa0xZgSpxSaOUnDqLd23UHPQnSYDsFQCyDcpirg==
X-Gm-Gg: ASbGncveG2gihFpBmUrKRPtIXDPKAnHlP1SAoG7ylZYpzIv4eQOjRBQPKiPe6kfF7ef
 PABdYc2q9DNYbqAMc7tf/NMgTXb6aKsNwmrE6R43CGpRusA2DtfL9969+L8jzH9hSYbaWmcLvcK
 iAraxFnAczWlnNDYOUrfsyX3JQYWO57b/2nX+7WnAwKLV6YBc1gPbOu+vIDYj4jASkxQq0dhieq
 1E9zqjS
X-Google-Smtp-Source: AGHT+IGrlwuSzh5xqBTHQq3gYvKeoiVbuDREEyVeRqxuJmxIetmA1yvFdxzghWa8JKIu/8706cQkKsSfzTsWxuVlbDc=
X-Received: by 2002:a05:690c:6c85:b0:720:378:bee0 with SMTP id
 00721157ae682-72276333625mr96283437b3.11.1756743880700; Mon, 01 Sep 2025
 09:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250823150321.135527-1-osama.abdelkader@gmail.com>
In-Reply-To: <20250823150321.135527-1-osama.abdelkader@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Sep 2025 17:24:28 +0100
X-Gm-Features: Ac12FXzANCKs638TJhCJYAYTs4DygvlAzhCszA2C8iKjkMVFwy6aXuJs7GPa0NU
Message-ID: <CAFEAcA-GpC3ouaXTQ18VhcY7c-jXK_SF0MLiCMFW471U5Cqr9Q@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/boot: replace fprintf with error_report
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Sat, 23 Aug 2025 at 16:03, Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:
>
> Replace direct fprintf(stderr, =E2=80=A6) with QEMU's error_report() API,
> which ensures consistent formatting and integrates with QEMU's
> logging infrastructure.
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  hw/arm/boot.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)



Applied to target-arm.next, thanks.

-- PMM

