Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C524AC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 14:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRBjL-0002PQ-Qc; Tue, 09 Jul 2024 10:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRBjK-0002Hu-2p
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:22:06 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRBjI-0001rs-Jk
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:22:05 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-58b447c5112so5938185a12.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 07:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720534923; x=1721139723; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r+3l+j/Hlofy6QABQMrAG7pxbpS8gpF0W5xXlJYtjjM=;
 b=BFQdXU2EqFsJiadnO1cTw0YOHwkY3N68IS4jXpMFJqlM4IO63JejOukUwajwCjDj21
 zboyFJyGK1++ju7AYETLc0lG8F6NlRHVq3exeDclHfYyuYaKWqFAVjOJ/N2mEcf0Me4N
 2JlkkCD1DnKZecC+7A1T7HNjxtJkRrYS2iT0RYLVvxlywdD/8j8I93CtUj2QJZL7XQ74
 a+FX7t8Bd3mofLxrNkcAWdVwHTa7wBdEkEjNrSlkn2N74kTMiEPDBIe7oPQiZtipJcLh
 CUaFwF6FJ2N7CSPqF58Sz+GJ3E6zJipYiZlHozrcjmN/e8LNpLSMhHaTNNyt5SOFu/Ll
 yrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720534923; x=1721139723;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r+3l+j/Hlofy6QABQMrAG7pxbpS8gpF0W5xXlJYtjjM=;
 b=to9fJJUMlcNX0cySRMB9NrM0nRYSc+vl4wn5LC3k1F59TPP7HMMFspcVIVT/CqCI2d
 1mGuH3/HuAaDWbjmqXIt6IMAKpnEAKTwnanZu6B1ZvjuWOsNe1Xoy03svy7IRiah+lBs
 ckG7OezgF4Q9MiXkHYfePsCYbRaC3kkS/EFHXZ2slDnYIXgrL0ER6K7iR2nQJYG7yG/6
 xhPztyiBNlbcugbVAw7jnH5x/Fy8v7FZeG4t2XB9MNEp0sB1pc29vRvwbFaxCMC1II4g
 4b/qj3seoZ8NmzGvFGAyX8P3tye6K3RR3Pfm+BB7IbKFLzJXA/CI+VKw/LgERGDcJJ/W
 O6zA==
X-Gm-Message-State: AOJu0YzrxcLXVU8C3rKRUPjRNjXZZ/AoWQpAvBIsg1bdDRD2707TFP3/
 mfr6nNmV1sBbxircR6E3iujSrsz7rj04wqE65k3CW+7qhwd2COlLIQcTtxipUpFIOvFLK+pIXRR
 Z/dmTSSVGJ24IQbR6ywbjWddz/wAlUvoQnuBBiw==
X-Google-Smtp-Source: AGHT+IEIZvRrsjIi8wedgJTZfVlfQnwXIObFhsuzaaxjg2GOVpwM6pJhUSvrrv7VFgA4PDVR0/18g0e38AC42yK74TM=
X-Received: by 2002:a05:6402:2c4:b0:58e:4e62:429b with SMTP id
 4fb4d7f45d1cf-594bc7c7e95mr1578999a12.33.1720534921993; Tue, 09 Jul 2024
 07:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240709000610.382391-1-richard.henderson@linaro.org>
 <20240709000610.382391-6-richard.henderson@linaro.org>
In-Reply-To: <20240709000610.382391-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jul 2024 15:21:51 +0100
Message-ID: <CAFEAcA_S5sFHruuRwPpVd9BzHVNCLf=v1uM_mt0=kkF1APXHPw@mail.gmail.com>
Subject: Re: [PATCH 5/6] target/arm: Convert ADDHN, SUBHN, RADDHN,
 RSUBHN to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Tue, 9 Jul 2024 at 01:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 127 +++++++++++++++------------------
>  target/arm/tcg/a64.decode      |   5 ++
>  2 files changed, 61 insertions(+), 71 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

