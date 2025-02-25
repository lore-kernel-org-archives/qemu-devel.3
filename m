Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4F8C021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzVv-00060J-9c; Tue, 25 Feb 2025 13:18:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmzVp-0005xW-NC
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:18:34 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmzVn-0004ES-Ta
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:18:33 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2fc0bd358ccso11813496a91.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740507510; x=1741112310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ijv9f7hpiK9093kBSmXBeiQ3+/bF+m4lCqQfD2s671U=;
 b=vzBTWqHP1d0T43gkQsEyaiA85Akk1KRdceJ7dD0Grb2jOvb28ofDRxj3ktVDNKzL0X
 Iq1dz4Ub7IsS/+MN4uJXVrsE6eww/crJcRUPkMgck1hYr2L2fieo/i2DFcbhvdW9ghX4
 sIfMcDv342UvLc9vU//rBvZD8L92wVztKOzr5vFGvfdhw1FOhyeeJCYm8KaDqdmZ4vaH
 uIlCjJ8qnqgqEEa5TafYHHidhSEiiMrFbLgMmJ0s7ZPrHD9Rog+KrQPc2WLlicGQPvF/
 LP0e3iTywfMMSBGoFLgv2Hch3BHKBOrStnHWY7dbuB1A0mD3QaYiIzBzD9wEBghzG+3K
 PHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740507510; x=1741112310;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ijv9f7hpiK9093kBSmXBeiQ3+/bF+m4lCqQfD2s671U=;
 b=FWOJCFYirXHgMJeAru9FSALN3COhKySRmIBqvgzZ8sDGpPrBCyFGilug22rpJ3AMqg
 f18vH3MmBVumkZBdbX+wf8ShxaJz6I8WS3tnI1NKpDW2UTetkwkLpoJStjn10gEG6f2L
 M5uLLaXjmO0Bf24P246IUNqTZhZo2f3bmRJ+mMIDN5WD0Dc0C1fDIAgIpQnGfIXmB+FV
 FSgdScYS8RJahgJSiaPtBKcMVgaLy/TjaWOnLcncdUJkAVKK5BWj4M+w7PVpBsiOjZOl
 YtORTMMkX1WeDMoEOokhj9dOYsc4M6tIlTB2CoUFcQ0M3yJ68MmwBvY00yFTUZstpLyx
 oLlA==
X-Gm-Message-State: AOJu0Yx8j2MIcJygqYqmrXWMYb+B2TzvBbwkssFeM26hsXkEuDyywbaS
 R3DLqHzjIZlAEINJNAUNbvAqPOmHX7ZmnG14Xf8dM2bGZLo7F/XvZytgIe3XjNcSr6jBkipRBHB
 L
X-Gm-Gg: ASbGncvMgltWlPAT/fXCjIiUp+BRePYKNrzhdn5CUpLse4+PQKW1fEAfUl/RgmHnyZJ
 tBY/0sLJhnglSq/r6ImPGVuFOaBeIhJbReDjZu4c54PcAjev3Rp2kcTcX63f0NlSc3EnapphiJm
 kFNRIVJTTttambpUkQOOYgxG1RT5udWjgzDUdQIKaqWoRN/mRerRv+DQUFqgv0IwMU+n0RHjc+W
 d493TUdmOkViriHHzPRk9lH4irIhqMafoU7+bHGs5zNZaq7PrFVCWKz1flpM04TT8gr0DZWj3Jj
 WOmNiMM3ok99WuJEJSx34hekzAv4wVlW6eYig0op7PSGJ3L3wjeqX0UwZ1zRMLx8HGZYJ7ItoS8
 6/kbxDGk=
X-Google-Smtp-Source: AGHT+IEu53oz8EhV83Almt5I3/vu0GjrvnrcJ5h2ZIt+okODeHilksykM20zhPhrvXxcYZdryGeI+Q==
X-Received: by 2002:a17:90a:d00f:b0:2ee:9e06:7db0 with SMTP id
 98e67ed59e1d1-2fe68adee7bmr7243568a91.11.1740507508916; 
 Tue, 25 Feb 2025 10:18:28 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe6a43ccb3sm1889771a91.39.2025.02.25.10.18.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 10:18:28 -0800 (PST)
Message-ID: <501d7645-fbda-4f66-9ecb-fec47016fbbe@linaro.org>
Date: Tue, 25 Feb 2025 10:18:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] plugins/loader: compile loader only once
To: qemu-devel@nongnu.org
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
 <20250225110844.3296991-7-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250225110844.3296991-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 2/25/25 03:08, Alex Bennée wrote:
> There is very little in loader that is different between builds save
> for a tiny user/system mode difference in the plugin_info structure.
> Create two new files, user and system to hold mode specific helpers
> and move loader into common_ss.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   plugins/plugin.h    |  6 ++++++
>   plugins/loader.c    | 13 ++-----------
>   plugins/system.c    | 24 ++++++++++++++++++++++++
>   plugins/user.c      | 19 +++++++++++++++++++
>   plugins/meson.build |  7 ++++++-
>   5 files changed, 57 insertions(+), 12 deletions(-)
>   create mode 100644 plugins/system.c
>   create mode 100644 plugins/user.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

