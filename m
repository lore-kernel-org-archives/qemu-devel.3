Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2A9CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 13:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umuUW-0004zf-OP; Fri, 15 Aug 2025 09:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umuUU-0004yk-Nm
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 09:29:06 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umuUS-0000Th-Ud
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 09:29:06 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e931cdd710dso1657328276.3
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 06:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755264543; x=1755869343; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NtUg4zCP1cQxctfX7RM1duig9eXJcS9WA10ZXGZod/o=;
 b=eQP3Ju5aP2bnyKK/tVL6z/p+K1W3PogHJlKca7UsACN7MbRNQxQzu1AhmyDuM3XQLp
 97UUnhbb++sCqSJY8/JzGwVZMJnAYuj3iOs7surqGEk3ICURUPm0gTCiAKp1S2cA+rPx
 /TNVtIBNie6TBPSlu/UMCXkU+3RB0GY3GAtyciBT9hsZ2vgI+rOEPtf0mN2xC7VrmOi7
 sjQTfue8FNsZRl1fOCKIzioRvViL3UyLiC0GhvvoNFjB+6DGM2j241lXbu/is1+n2aV8
 jHfVH82QGGstaoLGR2vg/4VU9Ikt37p7dLvDCDwyKAHQZjPv/J4Hrptwl3ljBHAviAJW
 uK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755264543; x=1755869343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NtUg4zCP1cQxctfX7RM1duig9eXJcS9WA10ZXGZod/o=;
 b=sxvvNE8OSoHTljKxUIU+oqb3F4jGphoOQibLCollgMEWmtdrX8K1JOHFuUv5fk8rgp
 eZeuPfmnEBFb6O9o9YpnZQmF28JPrm7zg7Ilvp3APzZ7/kNVcN6rTTlA996Iasn6yodq
 D6fpXUrfNc4dalMLgzPj4s6WLTJa6E7NZ+uOgFsYdGsDeDOfmzezd80ZUmCQbO5lPCnK
 5yd4sEuijDDU0k2ifoafopxw2PMVH8JbRl3jZ+GwkrvwgTyTB770IF0Nl/ARyob/XlX8
 Lfq6QMZCCLXWdDmTxXf1rCI4wAtzoKnd2zyDzNM6c4rUB34dP6mh/hD15IAYSKk4FFv7
 zHpw==
X-Gm-Message-State: AOJu0YzMvVUwE182uGmHWSubD8R9scZxwQAIhcWY8oCygh0B+s++lsHK
 EdGkfcC8x/I7TaF7aHU1FeHRRqRAIJD8a029Zaum21iIuDl4AfY1eCuFPmlx9P/rOr2YGKzc4rp
 YxAOk+gOruyOpq5zigZiLKzQj/jPYgvtIApTuDzpkgg==
X-Gm-Gg: ASbGncvVehW2V9NDCWdLCMa2+lg1BYT7wFg+0UWz+m4J+Y9g24rkUXLuUPtIxh0RwoD
 EjTqoIZy8I8bP5/EJVjjHs1qD77kltmx0N3dzb9GfTO+bJ1cSQioSgotmcWb18VwUxn/SfvSgyi
 gctzNtabufeYV8U6AYXObW1EDarYxXwrfLucRwTTGwVpaXcG8zJGoKnQWMgnpBfzNnJOxr6vPMj
 PVXH3f0
X-Google-Smtp-Source: AGHT+IE+3IYRpsJ6UGQXreWYIzjdg5nNmd2++7jhB5+ujaTE4tTVahps0SEPRY0/q31xj8XjMxaLhvoWnnVxc3HEyN8=
X-Received: by 2002:a05:6902:330a:b0:e8b:4282:65d7 with SMTP id
 3f1490d57ef6-e93324af7efmr2350411276.25.1755264543433; Fri, 15 Aug 2025
 06:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250803014019.416797-1-richard.henderson@linaro.org>
 <20250803014019.416797-11-richard.henderson@linaro.org>
In-Reply-To: <20250803014019.416797-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Aug 2025 14:28:51 +0100
X-Gm-Features: Ac12FXxZ35oXsPBq5ZH_If_vK91Mav0NZnunQR61fnHf--8K2RmXzmJ77El2zTU
Message-ID: <CAFEAcA--tAuxyo_-rS7JN6a8twzwd9q39HJHULrt=wG7Y+GpqA@mail.gmail.com>
Subject: Re: [PATCH 10/11] linux-user: Change exported get_elf_hwcap to
 abi_ulong
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Sun, 3 Aug 2025 at 02:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> AArch64 is about to add the first 64-bit hwcap bit, so we
> have to expand the return type.  Since the only user
> assigns this to a abi_ulong, match that type.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

