Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2980EC87FDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 09:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uirpF-0001Tk-4k; Mon, 04 Aug 2025 05:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uiroM-0000sj-86
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 05:48:58 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uiroJ-0008Ma-Ia
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 05:48:53 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-458bdde7dedso11523715e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 02:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754300928; x=1754905728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vwnSZBavO1r0NUe6ExmwfzIRMJxhOCPBdY11cAgGSQo=;
 b=WHLPeQn81/J0AaStnHOPQ2hkFqY4yPNLL5orhtt2hUEUwrRTR4WTKsZ9vHLT7pxpM7
 UoZ1KbMBnDBywBCE5qsnG8pA0tCWKER1pnsJCffYYhQaW8K/FZQapLRbdrR9wVhEfvB6
 yzsl4UnD7UU+tCfGJsRpQsMKON+IA/FxHWT1lLgwHFjn5ULwkLnmW4Bj7G1MjvfT1GuJ
 tvK+F/5rFFk0itQNmuIkcDTu0SP1rDECVmyUVHG/oiO0KJmO+0I2CPCbe9bZepURRtzg
 wWGMoYplpAIQu0Op6f4mBw/4Z+rsnyLe8DTlQaHDmvvpPpEcwEauAbfFukB743NyYwSV
 p2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754300928; x=1754905728;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vwnSZBavO1r0NUe6ExmwfzIRMJxhOCPBdY11cAgGSQo=;
 b=L6/JEYpq6PBwv9PIiLmVKsBqfjAJKBHCvBfyAbK4dWkTPwocs0Mu1/kPfWwOlkE5Zg
 VPuWotJvdaJaJ8QYd5oEFsoW5C4Dj1C+NX0pYJwWts0Gbd1HWNyGyahSrLas4wcUMpEx
 oYI7Cv/qnW+WfP1figS3q9c+gwPs+p8IaEUeXDk/lIzjF4IxqoWY3oQnytvpi8Ivm+ST
 sry+DsDNEhS4ikSf51w1T1zYJJ9Fg+8fv6oCe8HcGgZ1EUz++BB7LJ6TfkZVBa7/uiTU
 RNimkIG77Q/BeI/Xz36uzlR8/sXVWErtShfzrvTNuZ3iFy3sEEmYJl+AGi5RJWYZ74jm
 xwFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwrm5onuedbprnnhOrEQ8Zom7Z5g3Ged7kfxTRsgb7tAsfcbAqzJAN1qfVUqiF9ZRb9Hu35C3n3jeQ@nongnu.org
X-Gm-Message-State: AOJu0Yw5EIHFtoBiOQOH7IOlkN0g6rGozpRQT6piFgMIsBQFpR7//aCY
 Y1cu92cvZ8+mEMBWIbkSxgFloKS4QTVyVGNh/nIgmOINcDatUF05iCjRwcXA/6J7RLw=
X-Gm-Gg: ASbGncus2LSRwZ1UY7HPSuVKFZ1AZOD49A2WNl5Tu7kiJwoq1+dPJM2/x4Zy8OZd3/T
 Alo6T4wOgOYfhdmMsquqncMM3GPY4FMR1kGvoNWC0ggbgKcGMSvZtzpb1BKbUoQ3SRYpSNvju1o
 KOeQoSRQ9dpgTdEY3lvoNG9mTLnAiqsgaw7r0z7V9xLy3oy69ShEK5NmZEgv1HqdTosJaKYpH96
 gvRR7kRCeQuRORlztBHDcnu37OqStm55YWApncMorLl0c71TIV8Kio94qrDl+ycgfVMe7ugpne6
 w34tYzH31PV45lhLhymLcuWglSO8F/cyM6NknNmzx2NqFbakv8jQiLDw3R5+Revkx3exZS+QjJm
 NTrHXNb6RUqYK4U0iLL2lPxjgtvyw+mKVZg==
X-Google-Smtp-Source: AGHT+IEmTlMWXDtMIYS++pJJ+l8caoWzOoV0D+GsQcmjsSVkKUNiyOZJTCgJqc16v4t//qibu0XxWA==
X-Received: by 2002:a5d:5d10:0:b0:3b7:97c8:daae with SMTP id
 ffacd0b85a97d-3b8d94ce6e5mr5588922f8f.58.1754300928326; 
 Mon, 04 Aug 2025 02:48:48 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e0846777sm5010750f8f.48.2025.08.04.02.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 02:48:47 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9C1F95F88A;
 Mon, 04 Aug 2025 10:48:46 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,  qemu-devel@nongnu.org,
 pierrick.bouvier@linaro.org,  manos.pitsidianakis@linaro.org,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v2] tests/tcg: Fix run for tests with specific plugin
In-Reply-To: <CAFEAcA-6wr+frdc4idVs45POcPVG54FFTbtqPu3x9Jzfa-gwow@mail.gmail.com>
 (Peter Maydell's message of "Fri, 1 Aug 2025 14:29:33 +0100")
References: <20250801001305.2352554-1-gustavo.romero@linaro.org>
 <CAFEAcA-6wr+frdc4idVs45POcPVG54FFTbtqPu3x9Jzfa-gwow@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 04 Aug 2025 10:48:46 +0100
Message-ID: <87ms8f76yp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 1 Aug 2025 at 01:18, Gustavo Romero <gustavo.romero@linaro.org> w=
rote:
>>
>> Commit 25aaf0cb7f (=E2=80=9Ctests/tcg: reduce the number of plugin test
>> combinations=E2=80=9D) added support for running tests with specific plu=
gins
>> passed via the EXTRA_RUNS variable.
>>
>> However, due to the optimization, the rules generated as a shuffled
>> combination of tests and plugins might not cover the rules required to
>> run the tests with a specific plugin passed via EXTRA_RUNS.
>>
>> This commit fixes it by correctly generating the rules for the tests
>> that require a specific plugin to run, which are now passed via the
>> EXTRA_RUNS_WITH_PLUGIN instead of via the EXTRA_RUNS variable.
>>
>> The fix essentially excludes the tests passed via EXTRA_RUNS_WITH_PLUGIN
>> from the rules created by the shuffled combination of tests and plugins,
>> to avoid running the tests twice, and generates the rules for the
>> test/plugin combinations listed in the EXTRA_RUNS_WITH_PLUGIN variable.
>>
>
> Since Alex is away and I'm doing a target-arm pullreq for rc2
> anyway, I'll take this via target-arm.next.

Are you sending that today? Otherwise I'm happy to pull it now I'm back.

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

