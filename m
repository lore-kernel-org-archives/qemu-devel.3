Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4E1C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 14:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCgYD-0004jS-7A; Thu, 30 May 2024 10:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCgYB-0004gd-Ag
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:14:39 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCgY9-0002Bv-BV
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:14:38 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-35dca73095aso541215f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 07:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717078475; x=1717683275; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RFgNJYalW0yR5x9Qi6OEJHL5l+8acjKaSa1a7Cx9nfc=;
 b=mOBNFMP6h4EpadHzUFFKcPyRq5KVH4g0ul5C1oyvEHu1QGiKHGCgTa/eTIsAuzwNd6
 IINGM0k0cGSweHeOWRym5sc4XWGw2cMFdH2MP8FQWfnJRG53ymD5n36Y9qCjfp1jA/fi
 Oi6TWbFEkb3OjEJJyCWl382hl3yEl6bf7xL5lyMzQVmc/x+fiTVw6P1kj5hKRTUv17Xs
 SzbMPKdcfd2q0gh+pv3Qw/m7zhaiOVi458jlhzRu0tj6MbvoMJZrV0HBdXQ8FY0GBexP
 ftmp9/30yvj/7JEHKWlSpP6UVGnXlaZ66RbAGASdyNGZBNFDukXM5gbat85p5lyyeOpm
 EtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717078475; x=1717683275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RFgNJYalW0yR5x9Qi6OEJHL5l+8acjKaSa1a7Cx9nfc=;
 b=BF8byyqvg4IYvp4UF+m4ZjQBfCcPnbjXxbuVtHeFnT9PKlo95eEsKg8YD/+FN7tOU1
 XgL1Hdl/6N1hLCaKkQygwQlvpRaAotbtPRMEKcPr3hUyQm41KKn4xYIPpfb8JUTD2PbD
 m4kuHc/aGXQSi0n7N1dVwiGnFfBNskV/vkfxua9f9i0KFfwx3B1iE8nO+Akx0m6Dt40P
 4RP8G0fXE4T6U9EN8BE+zlFObaSyvBFNjHlaJjMFYPbvVZocRCefS64UtqMPf2Vm8Evw
 8AJliuhBVo3HpTnnIqU7jDkEwqE9lnroKNdn6AGWCYksOtJNlwlEv1uP7ptU7Qegk0bv
 GCyA==
X-Gm-Message-State: AOJu0Yyh7ExnnAjSFe9f3jDVNwTfcLMQi51nOJrQfaeX2h3E00HvqGzY
 Up/6L5DLoozsI+O5iKeBRr24d7eI9r4TTSXVhT4cp+zRHAQTOBvU9emqfJAHM5rzr3ME/4zLaVo
 64pbi/0cTZScZT0dDU+AShGLGDbSpHjZObgfFxQ==
X-Google-Smtp-Source: AGHT+IGsaOZ/OVKzjipLivN9p5RBaWRRQX/SH6AXfbk0BUSAnqBCc4REATKDsoJ1ip253QN3scVX79sZy9qWkEURNvQ=
X-Received: by 2002:a5d:6912:0:b0:354:e0cb:8dd0 with SMTP id
 ffacd0b85a97d-35dc0086d0dmr1454497f8f.7.1717078475574; Thu, 30 May 2024
 07:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240528203044.612851-1-richard.henderson@linaro.org>
 <20240528203044.612851-4-richard.henderson@linaro.org>
In-Reply-To: <20240528203044.612851-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 15:14:24 +0100
Message-ID: <CAFEAcA8rJW6nVGK53aLkf6r5Y0fcfdGH=MguNRxWRx9KcL4Rng@mail.gmail.com>
Subject: Re: [PATCH v3 03/33] target/arm: Assert oprsz in range when using
 vfp.qc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

On Tue, 28 May 2024 at 21:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

