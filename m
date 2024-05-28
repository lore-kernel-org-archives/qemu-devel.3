Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30172C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByhX-0001kh-Ap; Tue, 28 May 2024 11:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sByhO-0001kI-8F
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:25:14 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sByhJ-0002W3-JC
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:25:11 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5785d466c82so1198012a12.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716909906; x=1717514706; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tuYbUX0jEKAJo497J8aCi9EQcdhBOOBJ9uU6ueA4eYw=;
 b=e9tyGIwAvx5iMoWI8G3mnNYl1sV8M0WOOpskyr1jGGzYSvyeZ37+groFuaqdyALw/P
 X9v9E7GehDDZWsFAZzt3xxSOl2U3f3H4vJNJTvHNMGgXpa6YQUaenaa6igLlnbK0BlSz
 t4dYLloJGK5C52XeQEr0k2hVBDUYs6BVZ3Fj8QoAZChb7wc/d/A2+IxOGdE+x30R/Po+
 WtsBoR5p0RkTovqgp0x6vkcQlXj+fh5han+McfK1+/1HNPtGxPwDJpdmE65laoXF1HMl
 x8S+xd0YayvTK2zGkNyD7TeSZqmaFn5ANQBDtEa4sMeoWM+17x/Ong69ykpQoW/hp9tr
 GaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716909906; x=1717514706;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tuYbUX0jEKAJo497J8aCi9EQcdhBOOBJ9uU6ueA4eYw=;
 b=PrJhyDGsuzNXOx0IP5/25Hn6jwJZnX6+eqPtazA6TafgGOEGfV0o2MQiIdLwxANucl
 1PvEK/UXxCR+BfmtECvkejIimJjNedPjPJIqr036VZT1hySAcM/LDFNo8pUWXaDto1cJ
 QlesMsXV6VNZGxpv4Cm+YnccMcCJPvYyf2/EKnAfzLu1r/srvB11qjjvXX/icYY+nOpF
 tSWwB/EBuz2617zkroYd8slYnrDRZdDGPrbe+UpUl1OC2FkuQHhbSjQ3hlmFauFzZ9aH
 ZuE5riQaocRUgg7BkXMq2mmA3xwE7rY8DH3zbazotJJNuMGlKaQWdW916h/ze7yIlMMt
 G3jg==
X-Gm-Message-State: AOJu0YxNB/2DFIbwuS5K1qyxHrtQ0gvRgfiPWdXIunCzdQas0u2e5uao
 HGbEgQQ5ZMeScFLOovxcEyk0y69BSdo30RI5aFL8mMYliaGMZ4CZ+7iKGavBh05vJtWu53KleID
 anGQoP8+QpV+Yy4Ch90Afape9IxjzGyjh1rjxXA==
X-Google-Smtp-Source: AGHT+IHI7PLmdn7AQjRiVLDDjjYLCW591tEiiWx2OGDf5LvDRtyhAw16AtvJfealjd0if17zR0ZXSyfQUGkg02zEqDQ=
X-Received: by 2002:a50:c94d:0:b0:574:eb22:3629 with SMTP id
 4fb4d7f45d1cf-57851962420mr7365309a12.19.1716909906677; Tue, 28 May 2024
 08:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-38-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-38-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 16:24:55 +0100
Message-ID: <CAFEAcA9yfzS_SGH0v83gb3VtY5UXGBSdM56PoRHWRLewhvzOVQ@mail.gmail.com>
Subject: Re: [PATCH v2 37/67] target/arm: Improve vector UQADD, UQSUB, SQADD,
 SQSUB
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Sat, 25 May 2024 at 00:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> No need for a full comparison; xor produces non-zero bits
> for QC just fine.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

