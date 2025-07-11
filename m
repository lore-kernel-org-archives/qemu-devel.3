Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E6BC83F1D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua9xD-0008ES-D9; Fri, 11 Jul 2025 05:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ua9wp-00088S-9P
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:21:45 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ua9wh-0003kh-Md
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:21:37 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e8600a33792so1298066276.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 02:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752225686; x=1752830486; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JBK3ePEWjvVjPev4cHFtsdsiP/pjj5vJWvBnCJvZz/o=;
 b=eJVN/jSi+gLSeWncmv89nfQ3pwUtfj+na0ZhiMbMqDyonh0rcR2w7IuwVhrke/iioi
 mFZFT7s9FE4SziS5PuN+YTPhCYXLdgRAEX0GWYMmMOb7+eJZgK/DpkV0QjQPnCUfY+Tb
 2W/YGkuEa9P/CIRKZX3IJGC4q6YXm4cPpT58tGkTg0Paz4DLqjrgYUcXW8b8RLDC/yvB
 hTtew7ZQtgbkd881invLnUmYhsfMTacuMWxbSKYuqS13LkCbGNQIML54pWpnHpyabAYA
 WOpQHUmJQOExUhwoSX+pSp7WoR40THYsD0evbC5MTIG1V5+zCvTI7+iO7eVUJbdCDkkQ
 kFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752225686; x=1752830486;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JBK3ePEWjvVjPev4cHFtsdsiP/pjj5vJWvBnCJvZz/o=;
 b=llG5hV9Uyh6lFkdfDJQ8lH1X225iGt96uamuC/9AJRSaXegNPF/SuRYGz8MD0d68kW
 JcLjttY0iSu4T3NX5LUvFMxPZY/i7AvWqRa6lFGzia56OUWlVSCCy7wtrRIsQRMsFb+L
 oYixbHyyEe4/+Q38MBR1GJwHjrnpg1yHTyPf5uikUai+p3bVmgkqVbRt2yJXeRk1zF7y
 i7+XPwlkQNQ9Y+Lv1W3baKIDm3ejV2rQVWUh6G8MedFesHzQ2Qubtdtos4kl6ql6Pwem
 T8q6Ov/riGR5KrdxGNIGan44+/b8oZaJSFgsgp5Dzh4nU9k/H5K1PWaCfXqu/Zyzv8iC
 Rv5Q==
X-Gm-Message-State: AOJu0YzdG+i78IsX7nVynQjSqog8bLbHZWfaK6rArtgT+9SA/U1IdZNh
 UQ/ZP6JdfEOqLt2D7QZft0gkA8KZlz/JnO/HoN96R3ti79kO2DY2lwFYIzhZrTlemUMuSBHRp8a
 hIOsyeT8J5SElDZnchzN+6ubRKYHGll29cH6r8Pxbmw==
X-Gm-Gg: ASbGnctWb6vneFkMBSWbdoVUV5YAV9f1+s/OKBDdMvJcD5fMaGBPDFkkSVRjMGQamXw
 AtQYVcKPotx9vH0l0D8EgXvbKl19XhaUS8qD0ErBf4CV2aDGM3SIWmQJql3ap1tjr2Pniyl72/A
 O+V9j4IIk8xDzKKgZMCYG9e5GTvgSjJ+JuE8KdYEOfb5fjzoI9DrN58+NOhAloB/AMcc49SU5HA
 y97+LcX
X-Google-Smtp-Source: AGHT+IGhScNy1QoZ9V7SEoU1ko5x8tugAFMtojRlU87mWt+pS3iCOkgsRmnR0gYtRg+QbdkVDe1qyJl7cMXPQCHWfdE=
X-Received: by 2002:a05:690c:4c01:b0:70e:a1e:d9f8 with SMTP id
 00721157ae682-717d5dade00mr42174647b3.22.1752225686442; Fri, 11 Jul 2025
 02:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250710173945.115428-1-richard.henderson@linaro.org>
In-Reply-To: <20250710173945.115428-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Jul 2025 10:21:14 +0100
X-Gm-Features: Ac12FXw7FjjTpKMhpqKvQDQMei6e4MRrjqENgG4HjSGfcA1xYsESkSozoAt7Ibs
Message-ID: <CAFEAcA_w5jTEjNWmk-RSCvS1H5HJGKsB5_KDmsikqAjXq25_Cw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Remove helper_sme2_luti4_4b
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Thu, 10 Jul 2025 at 18:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This function isn't used.
>
> Resolves: Coverity CID 1612139
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper.h     | 1 -
>  target/arm/tcg/vec_helper.c | 1 -
>  2 files changed, 2 deletions(-)
>



Applied to target-arm.next, thanks.

-- PMM

