Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAADCD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 10:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKDPA-0000Th-E3; Tue, 05 May 2026 06:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKDP7-0000Se-NO
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:53:30 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKDP6-0000Ol-9J
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:53:29 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so17730105e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 03:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777978406; x=1778583206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wZcto8NJzu7Jb061zr98OlAizQo6g6r8VFlO7Q1jzps=;
 b=LK6RNyehUO1UJm8eui2v/zqUhihLp/VHTP+6xvSWlLqJr0U7HrXqtgMDXfCFV2plJo
 HB7A66iIqWfqRW/938VyAE1FXIo+6dZ5ZnOwowjorUGFFFW4ZL62btUSyn/HXZFvXmoc
 jurIiVoDPFg9PI7V/Sp/8UBbLoR5/iU9HxTwsydu/ZH/f4wjRPl6dGnHpKLSCk9KmK4Q
 j5uwsYTBI0wn6DJL0o6i2rCZPahHrQkSOEnCyRReAjF06ymGbG0IRtAwHH7eWa+TLvG3
 axnE9nKbv2m6bW2D5R71dZPjo/KnWTHZm1YTsPYBdo8nZkrENfaQJomjj6znvNpS5UNO
 L8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777978406; x=1778583206;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wZcto8NJzu7Jb061zr98OlAizQo6g6r8VFlO7Q1jzps=;
 b=ecB6KFewT/Gf922DUICizH42GGT2A7g1u92cQOjINnKJTjHeYqyGngctFjQveiIsmD
 5L+XRAAIkf8C/kqEt2c9KN/bgHHiXd0k335CjB59aYrU0mzVmJPp4IHOCG6rPMiWe36B
 Us7XddGWHbwqipAso/oDdPasEO6tNfPwDYcf0qyrvlp8Nqsu2SptevixOJVbD9N2vJjk
 J0o9AJwZrykHKm6o46rr+FvzGl4IXsWONBxunCueHIwLkRDYVPATrhKeozl2cZk8/nks
 7G2oYODup8x4RGPFwrCpFSXgA6cDfIbnCnfAvEd/rMM+tfGSbmaKgz0l2YNRwxtLvqw0
 4S+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WeYO+fygc8yx0FwlAKV6e4sp5Mw5dxhicGkLexOv0QAydh5ugrxDgbI5xtgVcNwXTtKKwWpx6g9NH@nongnu.org
X-Gm-Message-State: AOJu0Yzh6yga8iALUQ7p8J3OlCVFk7i83Wi6xopA1dp/HPsOXX6z4lvY
 AEyDrqtr+NvHNSL99XcglLxkHattUkNZuVIvYRQDU1or/oPCH4pZu71R0+w26q+L2j8=
X-Gm-Gg: AeBDieuRN/aQgypXY6QE+BRyKoe8dnYLCuDass3vErrqJ13YydvrZKyrCdXaNznguQ/
 x8ELTpmWDdn4x9K7kQM/PGpJgDDgcA6HOi9SwNS8hQyRzmZRFPmYlNxg3v9zxgHnWadOvwSZ95F
 /VyAswiUL/yUBrSXAdL93co5sHc9PvGeWBURsXOSgjhny/nrFjTld8xLD8U6oYSryu1bOCGR8CB
 cS93WpTxjdzmCVNljc3WQHhw9OOMyuE0Fj95/GhRP1FvxJPf0U97h2RJkKH0uslaXvpPwNQ5iNe
 MyR6DKf81tR/mV0Wpv2HuAWPCTgTVe+Ta6XO1cEPFAOZ4F54Rsk5+qPnS4g5MeFHoyYdbblebxE
 XaQtNd4CRpb63C5sH2WcDBGlvaAsfAn65ejkEUNw82ZsNOMuUEJLbkhkQJJojNSoDIKa38sF2nJ
 ulEHGZOifBWOLxtfJNbvnxD36CMYK5DohK29RWagNjqc4pYfMULEG5qGV6HsZ8DtNlt7R2zroyT
 Pvi
X-Received: by 2002:a05:600c:6092:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-48d107073f1mr102822295e9.25.1777978406201; 
 Tue, 05 May 2026 03:53:26 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d181ed5e7sm14965525e9.21.2026.05.05.03.53.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 03:53:25 -0700 (PDT)
Message-ID: <ca1dcc16-3344-4cd8-ac6d-e0dc5dbd84bd@linaro.org>
Date: Tue, 5 May 2026 12:53:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ci: drop cirrus MacOS build
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <th.huth+qemu@posteo.eu>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, Fabiano Rosas <farosas@suse.de>,
 Kyle Evans <kevans@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260505103649.68361-1-alex.bennee@linaro.org>
 <20260505103649.68361-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260505103649.68361-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 5/5/26 12:36, Alex Bennée wrote:
> CirrusCI is closing down soon so time to migrate.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/cirrus.yml           | 14 --------------
>   .gitlab-ci.d/cirrus/macos-14.vars | 16 ----------------
>   tests/lcitool/refresh             |  1 -
>   3 files changed, 31 deletions(-)
>   delete mode 100644 .gitlab-ci.d/cirrus/macos-14.vars

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

