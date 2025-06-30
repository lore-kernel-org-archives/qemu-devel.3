Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5F5C8302B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 14:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWFi9-0005V5-LZ; Mon, 30 Jun 2025 10:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWFi8-0005UX-CM
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 10:42:20 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWFi5-000319-3K
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 10:42:19 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e8600a33792so1513133276.0
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751294533; x=1751899333; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Gw3pshEDuG5m8wQHnpPxuFF7G24ZNHeA8enyCxVD3xg=;
 b=qACRAgYpRk1TOpYvlGHtIljvV4h4fOo/YPpkVasRRwOWVygAJ3jLK+yAchjJiYoYkL
 cf8077Nxiyp2NHMmLawA48R6EUjs+wUN1Yaw/zR7bYOMFhom0vbG/cGeWcijxX4D3++F
 Rc0eVE3JBSeqLgsGI9ZPMSeRhtCHvTD+w044Za5576rFMNjatAJadjm5VZiTmdRGbiiu
 iwJ5DMm3ooHXCM1OG+6uSao65u+OK5Yw2BzF7VaFHL6ZZaA71LTtPjXfJ88nxNkrWKo/
 cCEI/3U7kJ1acXNtv16bd93S2nZOWbPhxOADNj6litQsS22I3P2DWIcuhSfU94Qzj5uM
 s2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751294533; x=1751899333;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gw3pshEDuG5m8wQHnpPxuFF7G24ZNHeA8enyCxVD3xg=;
 b=bOVBWry4nd+iFAOagb9huMtdQ4RkXJ0zUAORBIuVOlEo13ETpp5z1JZ6gbmDYzNfCG
 oC7GmpoBxj4twAbq9v74IU32U3CUIGop/6dNcQdJ91sCVyV9YWe8nwOwsoXNmLuUx+m+
 lhMBWPt9EQYcfukL0R2xwPiIJxXWfIoqxq6UsIF413UXgZ3+sN/iBS/4VLdLU6ZVXVe4
 d3nesnptsOfB+pGj8GF6dmwz3PkKMq4fN6gMVYf8M09hhtup+I2u9fivIW7Vu6pVrfmu
 iOoMipIe5rwKvZhpDXKWsFwEFmFrLj+AQvfUYkTqPzpplYSGozsFgabNLJAA75THJ6Jy
 cPEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHFB5MNGgImtQPe/Xb8KUlMDcnL+bVGGlSC4sKPlLZupk6vYHy7m/jCAu/xobvEYI59+SlOgvmIam0@nongnu.org
X-Gm-Message-State: AOJu0Yx3SJbId2kwfKxeAl3Z5T9PCS99NmliSirrM2GytjhzWDBYBxdY
 d8VpLrXxN7avdAVS5T3+t8D3qHjqj+m0jWmChRVOCtKnOLEz8frCAKvOLTkHnSdyf6NmkcImfBw
 afPLY8vMtohJyiQ6B80PCfvuEoZuUIm82hw6EiOMPSQ==
X-Gm-Gg: ASbGncshel5aGh8AMmoP+B9yn7jZyCswAgt4xEB5S3hO5fokri7Twm8/Hdm02z83Q0g
 upkuH+bznRCshAUR2tHEWETJDyO2vsw1vOTewPbbW9u1MotvfDXK6/SVetiN+nsro+s0cRfYv1o
 eGl/++Ntay0WhsgUhb/nU8y8PQbIx0vnxJkpT+P5HLgHpz
X-Google-Smtp-Source: AGHT+IEYxlLWTt7epLHJRn7XI+jwi9R26rHwSNRuRCq1AtQ6X4Cfv1GH4lmqwxeYNdmsMvaNiW1b7OAwKMqfPXJxeqE=
X-Received: by 2002:a05:690c:ec1:b0:702:d85:5347 with SMTP id
 00721157ae682-715171bd0famr209094617b3.36.1751294533411; Mon, 30 Jun 2025
 07:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250616171549.59190-1-root@wjsota.com>
In-Reply-To: <20250616171549.59190-1-root@wjsota.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jun 2025 15:41:59 +0100
X-Gm-Features: Ac12FXxaR2RpH4nY5-6Z3GSaypeVZVjT6XfD35APqIWFsEaMijhiD5JgmfURhbw
Message-ID: <CAFEAcA9PTTbRjh+eYb9uoBFhV7JqaSjRN5_8mp1bsCCPbACQzg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Make RETA[AB] UNDEF when pauth is not
 implemented
To: Solomon Tan <root@wjsota.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Mon, 16 Jun 2025 at 18:15, Solomon Tan <root@wjsota.com> wrote:
>
> According to the Arm A-profile A64 Instruction Set Architecture,
> RETA[AB] should be decoded as UNDEF if the pauth feature is not
> implemented.
>
> Fixes: 0ebbe9021254f ("target/arm: Convert BRA[AB]Z, BLR[AB]Z, RETA[AB] to decodetree")
> Signed-off-by: Solomon Tan <root@wjsota.com>
> ---
>  target/arm/tcg/translate-a64.c | 4 ++++
>  1 file changed, 4 insertions(+)

Thanks for your patch! I've applied it to target-arm.next,
and it should get into upstream git within a week or so.

-- PMM

