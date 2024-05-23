Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD2EC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 10:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA5NZ-0002JV-0S; Thu, 23 May 2024 06:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA5NW-0002Ie-Mh
 for qemu-devel@nongnu.org; Thu, 23 May 2024 06:08:55 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA5NV-0005gy-4Q
 for qemu-devel@nongnu.org; Thu, 23 May 2024 06:08:54 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-51f71e4970bso9318521e87.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 03:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716458931; x=1717063731; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5M4AJuHJDFz41iRl6LmXlJMXhZQlHK8b0XnLffpBY3U=;
 b=QMGMB7ixqwU00dS/JAjOcG5N0YxXul4oFXH0X+pGTR5Q0NHVVNX/OWn+z2ItwMX28Q
 78pX6Yo/p8ZVcDyH5SFru3bZ/rBf9ie66GB3PXXY/40jPrCTXEOutDREX/Z0ZluzM3E7
 DJG7oB2I7VShItUXN7YYJXpXvDRR6aYCEdY/qGjXbRjsnNOqSKw5FZxxe6UrMoqXYsUI
 vW5KJg6jXG1uwDKZ1xtHMWjbGnbKkpttbkM88uRpbpJwCSDPuuBP6VXwlWh3I6Gbu6Ki
 fUg3GRYse7Q8dRZKwQ2bJFDzgHftCUpiWa1qSEmfnh4ZtkC6eWSN7HpFF5xXSZcszMZS
 FGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716458931; x=1717063731;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5M4AJuHJDFz41iRl6LmXlJMXhZQlHK8b0XnLffpBY3U=;
 b=sCzH+A7QWA22hjwRT4VomjTVrRIzZaI3agxYq4TtxBQ7qXpTEJLhky33ZCgsIh75Ja
 n8OZPi8uSQyCybsbIWALEvt9p9FfT9/nx9sAoJNiX9n83zWECzkxt1rJIpcpy9fD/XuY
 Gbz0wr1QscQ4/eL/A3DkEq3qNFg5UxCp/xalIGRIT+oPikza9aVb2PZBVltd22ZZ0pSW
 U/NQkD75w9/WHLZ+LbI0ZkqRzDE8Dcw3MfAJZIIhHYP/tpOrhbhVnLC2B7kaXxBQMnQy
 r+Rx9Ku2y+eP7ZOsua3giM8ZAWttrpB59efNpJq8C68KxLXHx0SdtA83N6cWT1XJLvf2
 09Kg==
X-Gm-Message-State: AOJu0Yw2Uh0tXSzUjIduAjDMXgYiXJ0FXJcI3wqAuARhlIQpHOY+D0bR
 Sspam4cbJLbvSrH58+bhPwkX6Nei8TitE3G5Ep8GwMWMKuuM9Gc6Gj80aT00aO6yF7PxfbWs/v8
 WExfu8Vj2zYqA3g1QqiuwpMmTTtMaICjIrlhkXA==
X-Google-Smtp-Source: AGHT+IGZ7wewcuwDMxZwJJ9ldsD8OsF76s5Rv5Yp+lvsGMf4UFqNqCnFra6B6nMsBSaW1nvRfMCix9B8Oupvml+2qN0=
X-Received: by 2002:ac2:5a1c:0:b0:521:4f20:6275 with SMTP id
 2adb3069b0e04-526beca95e1mr4152165e87.10.1716458931311; Thu, 23 May 2024
 03:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-7-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 11:08:40 +0100
Message-ID: <CAFEAcA9zumBr2nQ10bRK21KU9MnB9ouYzirA8MVyb3hb4a4tGw@mail.gmail.com>
Subject: Re: [PATCH 06/57] target/arm: Convert Cryptographic 3-register SHA512
 to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Mon, 6 May 2024 at 02:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      | 11 ++++
>  target/arm/tcg/translate-a64.c | 97 ++++++++--------------------------
>  2 files changed, 32 insertions(+), 76 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

