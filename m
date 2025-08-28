Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09728CA0FF7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIH-0006lq-3k; Thu, 28 Aug 2025 13:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdcb-0004bZ-Kh
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:29:01 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdcZ-0007Ue-35
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:29:01 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-71fd1f94ad9so9117187b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756391337; x=1756996137; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jAhd32F5CCjvDrAOEsOXSSVNN6qUgpl6tLXJJE+dNt0=;
 b=c4aFUXcdLGDTRkT+gL8+3UiSoFSYEJ0GkyXTx7YpWqgf6HBzEYNwvEs3TF8MqzMTsY
 Gau1S5ElJ6FKkwdBY4ifzsMgZNHnzzAT48H6da6ydoeru4EksjA2gcHt+o7nRyjlVg+s
 N47ENUpQtWdXG7g8S6Nq7xS1d56zRG/ZUOsr+4KZgoEV35DJeNpryAVSCnI5+Lbfan0m
 ux2kaqruyeV0L7ExsH76I0rPHLwNT9LHe1n0PyADgD86g4E2R7CB3RfOQtSgMLtJmSD3
 i/mmGT15pC0COfGiQOBWxqmK1elkGbXHm6bjJx2m80N4m+9PmDH6zNC/UR73x24u7bNt
 ywyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391337; x=1756996137;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jAhd32F5CCjvDrAOEsOXSSVNN6qUgpl6tLXJJE+dNt0=;
 b=G65PFaVnLT07tF17ZBpDNvA64Nwt2ui/Zh4YQ92MQO9x2NR6ZhaKGOTceVpFYqA1Uk
 dbOuSPjNI5b0yYHVCUBfMiW8U4FLKuG8/ijTtTI/GegmOZiGnYcebSLNqhIp5j+3BGSp
 zs8tUIU/DxYBut7EUVXn/g+sdRTdDenDIA1LLa5qHlGGiI3HkMJGIMcQaD6xOrAd2yhI
 pmG0hdgsFRu1fsbE1PSb9yCsbBeoB8KybGtG7/CVzSRQ58ZDUEVuB6+dUOqp/X4D9Jap
 wD4NL+ZF+1rx5gvYERIdu4cjsi6p8vrcMFBhg3gIR66itVJqNq9/gkd5PlDzC2GltPK/
 +4Bw==
X-Gm-Message-State: AOJu0YymwnGfu8sUpOyVl35Ms60sZwzH91LWU2EYovgQhkoBSddo3jvx
 4tWmQOFMwgmNy8m2ducG+nxpss6haInpad4SQcn9Tfn3FwbqT841wCAzDG/Pz7PPSq0LNeoZLYx
 1J24SCGLOsmC4AzhAnP5F33rNZ5ibOhy6zbfcRtle+/mmsbTMVjDr
X-Gm-Gg: ASbGncsmRMETUkkHOHVc/qtQoDh5r5ipSg8QUtqbuuvx8RUoTFPcp2Oyd30C1PL9qSl
 DCLuI1FYywZ+vgG/5+mn0lQYs9PTywq05a8YLFWucBAmuWPZuKVaICJXvRRHzGMvrlwNyHIwPjh
 hYQ3PUnySIatf6y+BytAiZU1CkRJpUrWGpXqnN9gUz3I3CsjF3x35+iogJM+YlgY4lteSTQxuBk
 NwwuUL3ITz/sY+I2H0=
X-Google-Smtp-Source: AGHT+IElfb2/0BgNVqno2R48ylqe0NM7cV1R4oZHkL1Mmofk1yTPr/Su4+/dQ4o67mlZ6PcdvoQvpU7YfXSrsNnUN34=
X-Received: by 2002:a05:690c:7482:b0:720:4ec:3f7a with SMTP id
 00721157ae682-72004ec494fmr198557287b3.31.1756391336863; Thu, 28 Aug 2025
 07:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-17-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:28:45 +0100
X-Gm-Features: Ac12FXwga7FaxYBexiYRDAWhxT7cLRXZlrf65X7YOlH5sUeNNa0govpVNao2f1o
Message-ID: <CAFEAcA81boKrN2EHLbLEord-cc=iLTvXpVY_nGA7u3R5y3gtLA@mail.gmail.com>
Subject: Re: [PATCH v3 16/87] linux-user: Rename USE_ELF_CORE_DUMP to
 HAVE_ELF_CORE_DUMP
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The other knobs in target_elf.h are all HAVE_*.
> Rename this USE_ELF_CORE_DUMP to match.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 38 +++++++++++++++++++-------------------

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

