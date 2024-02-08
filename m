Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE2BC4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 16:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY7Jn-0001Uz-Mt; Thu, 08 Feb 2024 11:32:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY7Jm-0001Uc-Kw
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:32:06 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY7Jl-0005bC-1c
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:32:06 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-55c2cf644f3so84600a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 08:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707409923; x=1708014723; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P9K8qveqsA6AK+WWjpuA/0kpRq6NKjPYEhUNDNSmBk4=;
 b=RANYoZF4NZgMGfhHApJ5sb9nnVcWVHGUpwrrBExWfExis6ro+MKmToVZL6pPwkSFPL
 IarWeTv8pawly8zYWNurEjakc4Q8W6pXxvtoFiSOsgvr3Lym9JPkYJWKNQYuSfruKAzU
 1auQTujA0uVp+0eNcooxqB1uUuPMf0J8rRB5dxzLEgwQroqPZhcE3nYAxhFapEPrkVcK
 NLRqCDPeo45YePmSjb4MtqhdT4omhkr47QNTkZh2N+sDkshW4FjcnDeqrX6gX7JTmnKI
 A/wuQPwBD4UnwTcUE3n3AC6UWl6Hor4tEMB9yN1U6xc8IzexkuNQUVEZaz1OHPuvsrzx
 TA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707409923; x=1708014723;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P9K8qveqsA6AK+WWjpuA/0kpRq6NKjPYEhUNDNSmBk4=;
 b=mMcm5Ml6uEkyT5nfcoA6Cq2l2x6Ptz572AVJIb7rkTEovytTOhIjvhvx/4wfJhQpUs
 XEytLR4MkoDPrccO3A8zqsoR/OAgFhNGwQnadxSWMC0Q9K0+Yf77pePMWyzA4yRifC2k
 7avn3LL9Ifr85Y2oLeJXDIVKQ/SlaTkCqPvv3OWO096NhjJWSgKUv4BLq2YqCveUiOZd
 kZ14+9uJaHuajrPe9SypgdxV4OdsevJ058H75yuDUZEG17H3bbiQgQecIEiQZyQptsjJ
 eoJoP4aXhVUBLI4Pb2uBtb7i9zwbokuTgE1CFEat3p2PXWTDeLPgw4wVt2AN4PhD1nnT
 bsUA==
X-Gm-Message-State: AOJu0YzXV1M/VL38+dA2pH9ncWnz6zdy3aAJ+zc8YkQxPofEePnpHyaO
 jxqEJrmGyFjjg+TzW/slzCekjJsoo0qrbAM/ItwPFkEMnuFJ8tnIvHUjycwfyf5ghtwy/1c8fYA
 81xzpsLSUxp7xERfzS6/7MalB6vodQz1CM4pG9UdsUDk9AMTc
X-Google-Smtp-Source: AGHT+IF+E+mZkn4kzbeUph/+agUHUlZ4xawjSoXRJFE7Pevk6KZUZSyIrDzN+u36FfBNPhGwiuhiXW5QtMAhJRA0wgU=
X-Received: by 2002:aa7:d98c:0:b0:561:1e53:eec4 with SMTP id
 u12-20020aa7d98c000000b005611e53eec4mr739716eds.10.1707409923484; Thu, 08 Feb
 2024 08:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20240202204847.2062798-1-komlodi@google.com>
 <20240202204847.2062798-4-komlodi@google.com>
In-Reply-To: <20240202204847.2062798-4-komlodi@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2024 16:31:52 +0000
Message-ID: <CAFEAcA_ijb0fx-m4gTBAXOknPMFh985rFtZW8BoP_-AUwwWT3w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] hw/i2c: smbus_slave: Reset state on reset
To: Joe Komlodi <komlodi@google.com>
Cc: qemu-devel@nongnu.org, venture@google.com, minyard@acm.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Fri, 2 Feb 2024 at 20:48, Joe Komlodi <komlodi@google.com> wrote:
>
> If a reset comes while the SMBus device is not in its idle state, it's
> possible for it to get confused on valid transactions post-reset.
>
> Signed-off-by: Joe Komlodi <komlodi@google.com>
> ---
>  hw/i2c/smbus_slave.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

