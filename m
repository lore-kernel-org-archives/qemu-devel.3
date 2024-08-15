Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE2CC531DD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 17:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1see0B-0007xl-Kc; Thu, 15 Aug 2024 13:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1see0A-0007xB-LE
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 13:11:06 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1see07-0005Nu-Fx
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 13:11:06 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a61386so1526550a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723741861; x=1724346661; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OHpC/wISg7fXHkMWSZi8PZo82atmWJMxlsoGxe09h4Y=;
 b=KCmhvvuLZp2fXcaokzkOpMMshdNeDrxKrrzxNq4wywG85c/zTtSPZfyl9LIG4WrqgT
 uImlEJwVkojXOd8EfX4gjRrcTaIhGwu4DghA9BGQC9uoLBPl0U0dJMlx+YMO3vewMLB7
 2oWUXzOZvVmsPkAdt0Arbst+q7AflUbrMJmcgMcVcDBL6OuqWm5Xrk8aB3o1Wa7sWYqz
 jyO5auF5qvL3W3S9POGvHlrsZh6dTGuRMXvp9riiY5Rzo207xiQdaYGmw+n87TIEf4oP
 notdQ98tBHOqzAZ0yd7FfEAg6lR/oVQGhYalbZ925Teroa383r8AdyiCtUxtUr8WFK5q
 IG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723741861; x=1724346661;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OHpC/wISg7fXHkMWSZi8PZo82atmWJMxlsoGxe09h4Y=;
 b=uPpIQaByk5+3fQhkHRqt26MIBtu6Ul2JEDX/CswqLAI3U8dgEnQpcdoT7kMZdmvOf+
 wPkVYIN8deajbV+LIIoKqyCwqNseQefWEmlS4WWq+katHc7ZSIZfrHCFtIF7+1aIk9wo
 zIqki5gg/l3Xp+QabQ/4xCfuCtQNFedZ04CvGqZKNjgfRemLDpaZdV1Do6yd99c8Gujc
 yotHHsKIgB663EFWAXCVbf2VQ2Q4RYEgjUtBunzucoYIGnVcuDyHWPRHzpFTuekbMC+W
 AYBjIdhzMDO1K0Sie0uYv35nk61uArZp71F96d3DUDSpLs/RjGpTIH4ThZRHdzaIJIxh
 h/3g==
X-Gm-Message-State: AOJu0YxX6aKlXHomF+b6+AL9sdE7MInLU4I0XrzQXviF2H6Sb+GYlBG9
 5DjzcyJCm5R/xZlPWlrp3owBtrgSjceyuqIYfX4UayCOrZn3OSzuKjXeWXtwMGknHrMaIZKVtWW
 wJZIIaPYhaqFz56bVudwJpTvXLPG3rJ5Ag6L6NCMxwEI5MHsb
X-Google-Smtp-Source: AGHT+IE41STyMRSD0RB62mfL0YGV9Zc8KuY9gIiuBsK0/W1rnyGZQ3t2Rqd/73X4D1+0fmjyioax0pQsGs6+Ps8xpOQ=
X-Received: by 2002:a05:6402:51c9:b0:5a2:ec88:de7a with SMTP id
 4fb4d7f45d1cf-5beca7a93f8mr60524a12.33.1723741861012; Thu, 15 Aug 2024
 10:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
In-Reply-To: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Aug 2024 18:10:49 +0100
Message-ID: <CAFEAcA9qfNRuuDJbwwGZVzkBeW04Q6Wk5w5ySraQBkxvV9=Fbw@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Add Rust build support, ARM PL011 device impl
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, 
 ARM TCG CPUs <qemu-arm@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Junjie Mao <junjie.mao@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, 
 rowan.hart@intel.com, Mads Ynddal <mads@ynddal.dk>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Thu, 15 Aug 2024 at 12:42, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> Outstanding issues that are not blocking for merge are:
>
> - Cross-compilation for aarch64 is not possible out-of-the-box because of this bug:
>   <https://github.com/rust-lang/rust/issues/125619> in llvm which when
>   fixed, must be ported to upstream rust's llvm fork. Since the problem
>   is an extraneous symbol we could strip it with objcopy -N|--strip-symbol

I asked around internally and found somebody willing to do
code review on the proposed LLVM compiler-rt pullreq that fixes
the root of this bug, so hopefully we can get that fixed (though
presumably we might want the workaround anyway given it'll take a
while to percolate through to a rust release).

-- PMM

