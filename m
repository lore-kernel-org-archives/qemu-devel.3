Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFB9CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 14:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up65d-0007xZ-BY; Thu, 21 Aug 2025 10:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1up65a-0007wG-DI
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:16:26 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1up65X-0004sb-DQ
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:16:26 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45b4e5c3d0fso1780705e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 07:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755785780; x=1756390580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oNZ97lk26reFJphw6dWJiEJAcXFPI+x3AOP0qIPfixU=;
 b=iASZqf/J20ysKtfsoxAGE7ybiwxNml94K6/zkSMjavvKTnpig/8VflGU7AwRISdAO2
 3o+2Jq1PlqQ7Ak1uwV+AnmNm2LevEIxKX5UxnRqweV5dW43Gkzn2IbbpU6TQ82/C13oE
 fEsL5iLWqxvw5P7kQmbbLYeJERx/hmBCAGkdhTX7tp4MKcFiRSbFr1adlNLRhi31wmmv
 k+qdu4Kfvep+RBP6+abN3Cs3/EoowEC98wZxjwJ/tL45F3w6UHcTmzHmHmQte4mIZ69q
 s7NQ2ZB9a+x26Zlmn52U7TxtVNKfvltiRx37yKn+seYlBPoSPmWLfjD1TnfOJlOTU0jb
 YwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755785780; x=1756390580;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oNZ97lk26reFJphw6dWJiEJAcXFPI+x3AOP0qIPfixU=;
 b=deEzHw49gC5DBYPHle0yrnGKrH+WyOteOrP09rdT8fBMXK/f8X/1qmwW+vd/sWkGMg
 xa7YEmh9L+ZuvmyTTk1PlnMjan5IcM9WNv4OEmcymYd5Fc8RfZXNkif6zLPVZENmF8ls
 Teu5g3kRls4bUactZRJMwb4c7jZutr2qwjmM2K17AUoNwriA6KytQ76l/b0CHHTVbksk
 fNeT5GUlaZwnv+nid1V02OQ8GOel10a/BbYXsf45mVHS/8Vp+gkTVUvLCQuJCnLvaLnK
 Ff5SXTW/iQqGVt6jpvX66KhqDKnVAMe6z0J/fgxB2BD0yVnwfhPFIOL1QEbtHewnVl7j
 TYoA==
X-Gm-Message-State: AOJu0YwpyUoDkEhyOjZDWTJFHYou/67sll2HAgAeWIh6Zj+eNmv2lzzg
 I4+XEq3X35h6fXsoElgOys+XsPxYs/yQDQnfFiJli4oIzuj8cN4bjOytDwdMt6EQYq4=
X-Gm-Gg: ASbGncvZsnrYi0MHlVFlmNxgaoPWksWLmQgmnqJJ5hd64+dQ0JwwqMZBp7yBTJFcyW1
 OA5v3SaFhDdwzkcpHPHY7lKWrqEwka0QrBQtoROdAS7UqIs1ncDMdsCapN1uTE4w/Tkgp7YqhRy
 b4zPjSSnQiVCtncGkkQ76YD8XRsNwcpUPNatJeQEgNdaq5pVjbFe7q9wMZ6oIrk1puB/FTtJkdf
 Qz/4W7LwFYIe5pHv3JJDwTBjT6u6gYlguwFRY3GwyqAcAdEkc4Tp+PKTwiIv3blUl3DzjLvG3uO
 UyD1u5/+vV+WhF+YnjhiKOI8pEFldqs8ZecPcN1lkMrRowf5WRSQG67Xwj3tufgjGz0I+t/curg
 OJ9eslVvS72BKl5ifB07wMog=
X-Google-Smtp-Source: AGHT+IF3CA7cOZqosBC9SlQFOUGnq02GsB7JvoIT1Y1wd+EQDKWmq+7Bphp+Ph0+BIVquuHquk2uSg==
X-Received: by 2002:a05:600c:c1d7:20b0:456:fc1:c286 with SMTP id
 5b1f17b1804b1-45b4e4f57bcmr10626365e9.1.1755785779808; 
 Thu, 21 Aug 2025 07:16:19 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b4db296aasm32863765e9.7.2025.08.21.07.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 07:16:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0DA435F79F;
 Thu, 21 Aug 2025 15:16:18 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: snek testsuite breaks in 10.1 for qemu-system-arm on armhf
In-Reply-To: <CAATJJ0K6coKjwwmkzaWP7dzQHLsEoL3rkU95T69rxZ6fdbnXqg@mail.gmail.com>
 (Christian Ehrhardt's message of "Thu, 21 Aug 2025 14:52:46 +0200")
References: <CAATJJ0K6coKjwwmkzaWP7dzQHLsEoL3rkU95T69rxZ6fdbnXqg@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Thu, 21 Aug 2025 15:16:17 +0100
Message-ID: <877bywlpzi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=unavailable autolearn_force=no
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

Christian Ehrhardt <christian.ehrhardt@canonical.com> writes:

(adding qemu-arm and Richard to the CC)

> Hi,
> Debian and Ubuntu run the self tests of snek as integration tests like:
>
> `make SNEK_NATIVE=3D/usr/bin/snek SNEK_ARM=3D/usr/share/snek/snek-arm
> SNEK_RISCV=3D/usr/share/snek/snek-riscv -C test check`
>
> Those tests recently generated signal by failing in the arm emulation
> tests with `qemu-system-arm` - full log [1].
>
> ```
> 224s Running test pass-precedence.py.
> 224s     pass python3
> 224s     pass snek
> 224s pass-precedence.py:72 Syntax error at "".
> 224s     ***************** snek-arm fail *********************
> 224s     pass snek-riscv
> ```
>
> 14 tests failed, but all with quite similar signatures.
>
> But that only happens when executed on armhf, the other host
> architectures are all happy [2].
>
> I've separated the test and ran a git bisect on qemu 10.0 -> 10.1 as
> somewhere here is the trigger.
> That worked fine and identified this change [3].

This is:

  tcg: Convert deposit to TCGOutOpDeposit

  Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
  Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> I must admit, I was able to debug it until here, but I can't see how
> these snek test failures could be caused by that change.
> And yes - arm emulation on an armhf platform isn't the most common
> scenario.

Are any of your other hosts 32 bit?

>
> I can't predict if there is anything wrong in snek which now is
> treated differently by qemu to trigger this or if snek is all fine and
> qemu broken something - Therefore I've also reported it to snek [4].
>
> The tracking of the initial finding in Ubuntu is here if you want to
> see more about how this commit was identified [5].
>
> [1]: https://autopkgtest.ubuntu.com/results/autopkgtest-questing/questing=
/armhf/s/snek/20250818_045020_246a4@/log.gz
> [2]: https://autopkgtest.ubuntu.com/packages/s/snek
> [3]: https://salsa.debian.org/qemu-team/qemu/-/commit/cf4905c03135f1181e8=
6c618426f8d6c703b38c0
> [4]: https://github.com/keith-packard/snek/issues/103
> [5]: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2121124

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

