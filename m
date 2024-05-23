Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578B3C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 12:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA7Hz-00017A-BQ; Thu, 23 May 2024 08:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA7Ht-00016g-FP
 for qemu-devel@nongnu.org; Thu, 23 May 2024 08:11:14 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA7Hr-00044z-T6
 for qemu-devel@nongnu.org; Thu, 23 May 2024 08:11:13 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56e48d0a632so15729961a12.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 05:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716466270; x=1717071070; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SvLubM133Y1oQ1PaVzdQ3YepdyZNnd83vLc3wjbvM7Q=;
 b=DEsRMJPDXVuOYc27uG09hlvb/kJbNdUFRezSofxdjyzZYVqKUiKEsC32EoqRkPlxHC
 W6qo79uMTPsWQawuHznBUaLmUdisldc8ymK7wzLlOhPjXcMgGaccIYecteqKU93cPn/2
 gYTadqteyjVRlzM7jt6yDdcbfEBhyNEQFZae8jvUaHx7LVj9PIkspv+vwoSyKLFWvG6f
 QaJHBiqfk/ytuUBa3ithiJwqfdZNQSi12PfhQVS2o6msvEoDZxEdsCGBNSv2j2qlbM+I
 cFysUlSr+SGYdZBqJptpbYj97lTq5g0DacnWkV+/oK8GkcHgsHe5ZVCLabduiiqSVrSI
 US6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716466270; x=1717071070;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SvLubM133Y1oQ1PaVzdQ3YepdyZNnd83vLc3wjbvM7Q=;
 b=gRNZvRYd6AvFSjOrm6lZapOlka42/n6tNu4130Wum5wTnujXS/yVX6NwVjOyByiN/x
 mBJcMARvJZJnYkCtpOqOZTfHN72pwmXpLyEZEK1YQu1VL5AtGqjPWPclTD55aUQe6Rws
 25GVECBE/a19nUzPCb3dCEphoRyIolGAOOuUHslqCsI+zj3EXh2OvhQcJnY3tH6+sUYh
 mOUvEifN95l+NJZ2kejwLl5KrL9OVIoJPGg/bPxqhtx8pwP2vsMv+2fHfTx5+/vq0lyx
 kYZ/Cyilq64wF42h3DFUwpLpdHdXpNyb3vBdaqFCNaKRjyi6dsZc/4+Aapgvik8b5Uh3
 1KUQ==
X-Gm-Message-State: AOJu0Yzo+REVRTHddt3Q6CHBXUyQbar1FFccBFkEMlJQDu8ZW0ITHXEI
 bfYX+8udJVWEZo9S4AWgYe96VqpB7xh7FOYqNGxC9vzdbr7UraJ4zLmy1k0OSWJam7idcMK3oSZ
 XQlceCjxoe7uHmeGybFHsV2zFcagAUI+81y/TVQ==
X-Google-Smtp-Source: AGHT+IFk7wgVB2Yo5M5Dfk1W8Be4Bx1m7tJYsflH9Sqe3o2tgYaii/iM+quabfs9pFZmdV21Vfdtk04ai1bkwlPSuXk=
X-Received: by 2002:a50:d581:0:b0:572:5f4b:bf2e with SMTP id
 4fb4d7f45d1cf-57832a3fa43mr4101108a12.23.1716466269820; Thu, 23 May 2024
 05:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-18-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 13:10:57 +0100
Message-ID: <CAFEAcA9zPQLzGPHcB8iFRga0cySG8uwRLE+V9iaxnhf_gij4aQ@mail.gmail.com>
Subject: Re: [PATCH 17/57] target/arm: Convert FMLA, FMLS to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Mon, 6 May 2024 at 02:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h            |   2 +
>  target/arm/tcg/a64.decode      |  22 +++
>  target/arm/tcg/translate-a64.c | 241 +++++++++++++++++----------------
>  target/arm/tcg/vec_helper.c    |  14 ++
>  4 files changed, 163 insertions(+), 116 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

