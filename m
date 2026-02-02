Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE6AE7316A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmtwv-00020O-1Q; Mon, 02 Feb 2026 08:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmtwp-0001zN-Gk
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:26:36 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmtwo-0001fA-1y
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:26:35 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-79430ef54c3so40869267b3.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:26:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770038792; cv=none;
 d=google.com; s=arc-20240605;
 b=bTtCx6w/ZD32uBTUPQnyJayWR1eyOAO+G/4IJAUA5Fo3Kc9o+f7r3coRXBWkrV46QC
 kzvnC5NtpJ5lJSjZzAP+eZhoF+guDQ4fN4TJGTuA3pYGeNq7Luy+aKI7JOWUuIH3aUxl
 Mg3av4a0r9ZjlP/Fwyp795VRst74BLjoDCbcUsVxcfqSOzHrxFPtIOaCeDw3KkPWdZpo
 PsXNttZjtogr8NdSY37f8cE2G4vhuDekz7PJXoqDzt+6P8+vtuUtbphwkCEo1JOMoWhL
 84QuGciQdi1wjEyzrqbG5/zRFHJyBuXvRuATg5KFIBPJmih+UxHLShH6l1xC/Ssl5frG
 KSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xUr2iLqj0bG6Qv5DjBsBK+LbeYrLOtHNrqUPsHTb2rY=;
 fh=ekUqqrjZvs3EiCbmM+uxXnDTDwuxrXCI5rm0DRfrGAQ=;
 b=H+RtsspXfZGbfaNAOwQP6m0kVoH0RXYMv8SS6OiwtSMKCJzyn2eDU8s+ltIWa1SJds
 F0bpGYvnce19ILMlF1Gf/BMwPN6XPvrAq5DhK5mYVBQigumhReTL6Z/QRkdzg5ltLsgp
 o6igB3BVoWGj50c/Ru5L1axzDu3adulpL+vakN8Pw1SvTOYhBW18+v56GOfYdke2U2Hd
 kQ8eW8B0MgKA9PSZ3OhHUb6yejgpzGhEAiYRxm9e+LM09uHX7mXAh0krqSsctQ2MU8M1
 YEEswAUqkPza44QjY6SE19wY/Kn4zVIZARW3ATwrDgMHf9j0uDyleO4JvsW8JxycKK7e
 1eew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770038792; x=1770643592; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xUr2iLqj0bG6Qv5DjBsBK+LbeYrLOtHNrqUPsHTb2rY=;
 b=HfM41Kaq4vciN74eHcBBD0/vrhxJiRs7ifB6EEr0xC9j5RZ+fnKSu4soP8yWXJ2cki
 2WsuD//v1DAzt+VCtlIW7/gkHIWWEfI2a5MWp4g+aM/kBPNc1MC+OqQdlvOIk9qkjy6d
 BmvxbPAuAaL+D3uRRP4HRjx+TYksBelfmmRGq2IMRDkb9mLtyFqvfmUO0g7gx9IhlQLM
 VL69uolK+0Z0xw6NUUMYwVBK2NZIS0WJ8ODt22b/pUh4z3CMVfw6rTLFNUqjinJmnQl5
 oobBfjypQF3GX5I3ZQCQ+KWZihAxoa9u4gO5VT1YeoNoX5acQuLis3W1pTA8VJFaCetD
 4iDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770038792; x=1770643592;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUr2iLqj0bG6Qv5DjBsBK+LbeYrLOtHNrqUPsHTb2rY=;
 b=K1MCV/YeJHMluS/dw4SQAkS/c7x0hLjMAdQMLiwNGQzXr0T9sdrjjgbKZVgI+1R0E1
 tJ041n28YM9HiJAjdaoAWB3ChysbvhYrdSbNlVWOicHAm8ck2eezzV2AfB/Ffh8Qa9S8
 tHk4TgrcprFD94WSY+/QowSNd3+rlKHnA4xbMf7Y1U9ygqrfxK8W2ac8ClYFOYsxclja
 fo7APVJaFFG4gaj9ufbNLa7q2M2NQ4mF4ebOW9p81UgzkuuhTVv7HC36wvXtFnniItB+
 pg8HVoIGxdIJethxB+aAAxqpKhDk8LISQ0xoOj24q7Z0zg2oFCRwdoaOt9z3Dk6Rp9PF
 JfRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUADe/FUSpL4md+OUxqaojxkUEn2JrWIlEjUgfSxBcId4OhnK5pmkH9btTqDFIaHtJL/eGWkNTgcjlF@nongnu.org
X-Gm-Message-State: AOJu0YwZkZF3/bN1YKpggJrV6kORspmdgKFmFwVJP6NGRadI8gV7xHRv
 2Rrg/zADfeLb6y2lbNo1yPZffEotrwUhM1ek/yDzVdJmgLYB63J1GSXsc2Ns7M1BtqUuKxln7ju
 ZlsXOQCbklY9zWZjWR7ly4Hd9eDREPIGbe4a082TB7g==
X-Gm-Gg: AZuq6aLFXKV71Y7O05z3r9dTj/Tngwre1m4avUpkZgFl4S8X5Rl2ehBYA57x93e9UJ9
 nUzRsulAT3TrGVhNJQn38C14Q0zPLP63+IeeT0IHP1gYU/p1NKhLtHnSGzQzcExddLsC9IogaTA
 NPpkq9NDdYNlfX9pc86KJME2J5EPYJ2rNztsPB6W5WqKxwpImRohrceRwqZQBaOnZ+Ks9vOzsap
 GPa0KxfyoCjMNKUE4wKnWFryB0VoL7T9m+3wb1nutNrsgQnBsJxqLxEfHpbIwZHSUKp9w==
X-Received: by 2002:a05:690c:9692:b0:78c:3320:9c5d with SMTP id
 00721157ae682-7949dfa9ff2mr93275907b3.42.1770038791676; Mon, 02 Feb 2026
 05:26:31 -0800 (PST)
MIME-Version: 1.0
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
 <2d69de6e-da9f-4f90-b805-9553bb72c78d@linaro.org>
 <7ac8fe1f-8098-4417-a97b-1a82c0fd23ca@linaro.org>
In-Reply-To: <7ac8fe1f-8098-4417-a97b-1a82c0fd23ca@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Feb 2026 13:26:19 +0000
X-Gm-Features: AZwV_QjmPfV_0BPiQ4U9qR2i7rZOVdX7rE2sNQBCGpdtBQffq4DK8DyS0xJzE7A
Message-ID: <CAFEAcA_zghZeA0PzivCY9vCcFk6rVLwvP3in35rA=bF8yrdeyQ@mail.gmail.com>
Subject: Re: [PULL 00/21] Plugins patches for 2026-01-29
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 2 Feb 2026 at 04:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/30/26 04:41, Pierrick Bouvier wrote:
> > On 1/29/26 9:37 AM, Pierrick Bouvier wrote:
> >>        contrib/plugins: add empty cpp plugin

Hi; this fails to build for me on Linux (Ubuntu 24.04) with clang:

In file included from ../../contrib/plugins/cpp.cpp:33:
/usr/bin/../lib/gcc/x86_64-linux-gnu/14/../../../../include/c++/14/coroutine:38:3:
error: "the <coroutine> header requires -fcoroutines"
   38 | # error "the <coroutine> header requires -fcoroutines"
      |   ^
1 error generated.

thanks
-- PMM

