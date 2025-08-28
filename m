Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D02CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgFb-0001Cj-Jz; Thu, 28 Aug 2025 13:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdV6-0001Xn-3e
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:21:16 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdUy-0006H1-Bh
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:21:15 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e970e624b7cso208260276.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756390866; x=1756995666; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W+pwYfhE15RM0lWEieT/Yy0PeY0BjQe3dqJRrOXQPf8=;
 b=DJTWpIV6Aj8Umop5/8OguY62eja3lo5Z+beZIktVkbKJihZ+BDsCksq/AUxPjFF90W
 uPQedhtJHkphVnBeL85tURwZ3IG0j3iY2ze+qvBj1Au8L2DfCZ5JqZDFwCPUvybeEQul
 fhgGV3owAVhWzhjyOjOfrrYcBU/DGhSNr/D6uVgyHELdFbAIJ8+EzoLCqdy6wm/pgYBz
 bEqjqYV9Ws3qB+MyM5Qp13Z8dUalTeBwSd3hzKEJVPSbmvPIhy6qDbJDtNeTDamuvYKN
 2E9b5WzvIay6uOaU2c7zk0Td+h6frCj1AYo/BBdbFQ8rJIo0V4nXSf9TT2QEvTqCpzPr
 Od2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756390866; x=1756995666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W+pwYfhE15RM0lWEieT/Yy0PeY0BjQe3dqJRrOXQPf8=;
 b=cGlQ0UFknw/XYDMiNKlRG1nyNuQ/v3Sw5Aq2logMSmZutDrPvlAlPVW6M2xcjHPuBI
 bCxTf5XqJTC0SKCQSsUxvWB7Os9ts3abIyZ6cWg5eRY72rD9wrTDprOMHoZxlxisMHWH
 IR6b8QZXWX0ItOhlcpN+Njt/GIOqtEUI+AJPlN1hRLJwCyfwcsIpJauMnFM3SUhDB7Fb
 0CSSrX+/gJaWDRcq91JxvVSlEQ6x80TlDmdD5XUstmyQRH5GLLZeEnpeqThXa7tplqhK
 cNFjzX9d64Rvd6ZcbeqpPt8WKd0+lo6RGqtmmLyczugenQKXo63oMHRdPRqmcbEadDdy
 uY8A==
X-Gm-Message-State: AOJu0YyMcmpz/YdHHgBdfKvLxTmkWPYWZ0NBOdT3LK/g7rRxaDOdpnl3
 9wKK3jlrjLDfLgilVTNNganzU1aTe850LZ9EZlsCv2wVTdts0A9WbK37tmEAZXT5r8u5jD2A31P
 RMDoD8iVqaMFevQwPccgZJ3ppjLVhGAQtaGqcW97dxBe9SqsqhHR4
X-Gm-Gg: ASbGncuHkZpB67PsMFW8GnG0f/go4KOjWs2FeeozD6R/Y5TL3OJJ5mtOLd+9+PCpEcE
 0D1zbYIOtwD3mgZS5vDcEcqLCPHkH5l06eOaO3TBsj0BoVHWl1bihYdUpsDnd+Nd7v1AubsBQVt
 jruqKxYXJzdk3DR0sa7f2zpYgYmqekZx4MUFw12hE6VH4slD3cFEU3G1nk2Z+tWIJL8z4FY9Tq9
 3PL/5MlZ2UrKmw5los=
X-Google-Smtp-Source: AGHT+IHfZ+b96KkmkYBSsCj+NStFdVT2UvXU6Cut305ZsVGkQ7pBClPPl5b6kTMru83yD8Rvmjd67p6I+0nyX1ETrEo=
X-Received: by 2002:a05:690c:eca:b0:70e:43e9:6149 with SMTP id
 00721157ae682-72132cd775bmr110242757b3.16.1756390866037; Thu, 28 Aug 2025
 07:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-9-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:20:54 +0100
X-Gm-Features: Ac12FXyI4pwvUEaGUTNSxrutrU8A_Adkohu6a6p8haP0CV8ZaWUVzREy2ry9DCE
Message-ID: <CAFEAcA8R+p51nvo4Nwrbh=OHGyV8SaRzXXWcu_-bx8HZPHc8Yg@mail.gmail.com>
Subject: Re: [PATCH v3 08/87] linux-user/microblaze: Convert
 target_elf_gregset_t to a struct
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> While we're at it, drop "pos++" and simply open-code indexes.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

