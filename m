Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A1EC87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 01:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uheRC-00033d-41; Thu, 31 Jul 2025 21:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhdsV-0005Cn-HQ
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 20:44:10 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhdsS-0007TM-RX
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 20:44:06 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b3f7404710aso1380640a12.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 17:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754009043; x=1754613843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jn8cOTNuDgNUjCAeMtF8KbapySG754XSIIlIjC1w+Tk=;
 b=gyPOcia2o1viB7DCBB2z91SRhsbyO/UZ6x6Lz+Zhp5Q5iquVnwRpR0jDrFe4NykHyl
 V5BHyluwS2+8IwQ04m8HPyB4/9Pxu2wZPNnnQOHUxuFNZuukVcRgTeeuiP8gZbK0M2WX
 D4CoJUELZwvJj8X8RVCg23JoOhmTjxG9sBgWdODRJ1N4vpgMxaEF+ZtLe29+YwY3Ro8L
 ZDoy9s8Cc/hZU6f5r6RNUCJqKVbQ6rVGg8p53XgpBisflM7HQIgA+oYLFVSF8X6Ofr8n
 zhoeFQWQI3WlInHg/oXnyPfQUMCflmhVcBe5YwbW40f6Cbf9zWRf17nO7TOsJ7p0MtRQ
 bCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754009043; x=1754613843;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jn8cOTNuDgNUjCAeMtF8KbapySG754XSIIlIjC1w+Tk=;
 b=d+gRcKS3WyB1ow5sRllHSitrByBdxU7YKYNMKQWptDdmPUNvW7Qv0mLPE7wSaNHw4m
 xR7TXTaMjEw15XlZqwBbCAi0oJiE0HzF0YPZzglDj4VsO8dtAbS6ZTiWH3QxaqBslECQ
 8X+5DMMPDy+/JIwvIYSY4fxCBENqdvfAuqseeM0AHZk55VUeC61EIDDVOACduVtBgcKd
 1jBJI8p3kGgDSQYZZQ4o8Z00+OYdtBlTdC3i2nqpYPqmlApcjsu+AiV4ohOgLcps+n3N
 Hye83+rtgp1QDJy1+T8mnWVtbB/Pdmxgc7r3z4DbAH8NHgj7UATAfsVaqyrOVsKE6I+t
 h1lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7wVO0Ax43b5ukkXjhqRo21tCHNpFHWQaCWFGxTNPtY0SeEFUcg9JHMwwrJfdqr0pS8P9JvdEZfwHE@nongnu.org
X-Gm-Message-State: AOJu0YydEiprjQkDFRKLI74rWbOVgVqIqTAtOkowdX5oZANekJ+ygQOt
 atRnu/KHeIRUKjTuz31O5a6fA1VDXFAfuRKiIkAzjMgUBMU9xRkCJ6f+QzwNFV6Wkm1LClM4OC6
 CZ9vu
X-Gm-Gg: ASbGnctxBOXl12ZqZFrDLKa+RVg9E9kH0hwx3btrM2W4QU52N7xuBO9SmI+3WkmU1cR
 W7o54zSeoHR8vkMiQOEqPFdR1DQfTYhprDCm5COWJCU5x5hHE/ZcehmAjwBDlG7pnc/jgE/eHHi
 G3dY64IWWKEuVR1lJPklpOHn0oN6mgTG+lvBiy9khPHpemD5HsYfHVXEQj5ZEtGOsVA6MDAaCcq
 e/7ZCS4CJxZt0rVkV8xbaVgn53WPTe7SzWHlMfx3253e3MrSDqtE7QJrq/qEFOPiufgLK3alq5A
 5Bn1o/HU0qG7UOnKpYUdQ5xRtiSqfpvHNH0dtq92t/WGmcmc/ODtXoy8OPzBdp3v+wXRiZ0UyCo
 WPyFxBFR39AHKM1MTQbPsLeRBgGvSewR51aw=
X-Google-Smtp-Source: AGHT+IFaYZ4qSKvL6lL3RZ5++KunPq14AZIZBYtvBrKclImx8Z2dr+8F4D4cFoQo2vYnNZ4ud6Rx1A==
X-Received: by 2002:a17:90b:3c91:b0:31e:cc6b:321f with SMTP id
 98e67ed59e1d1-31f5de7da73mr11967628a91.29.1754009043121; 
 Thu, 31 Jul 2025 17:44:03 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b422babfbbdsm2462468a12.35.2025.07.31.17.44.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 17:44:02 -0700 (PDT)
Message-ID: <bd67bf00-90df-493d-a322-5266c570fe2c@linaro.org>
Date: Thu, 31 Jul 2025 17:44:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/tcg: Fix run for tests with specific plugin
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, manos.pitsidianakis@linaro.org
Cc: qemu-arm@nongnu.org
References: <20250801001305.2352554-1-gustavo.romero@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250801001305.2352554-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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

On 7/31/25 5:13 PM, Gustavo Romero wrote:
> Commit 25aaf0cb7f (“tests/tcg: reduce the number of plugin test
> combinations”) added support for running tests with specific plugins
> passed via the EXTRA_RUNS variable.
> 
> However, due to the optimization, the rules generated as a shuffled
> combination of tests and plugins might not cover the rules required to
> run the tests with a specific plugin passed via EXTRA_RUNS.
> 
> This commit fixes it by correctly generating the rules for the tests
> that require a specific plugin to run, which are now passed via the
> EXTRA_RUNS_WITH_PLUGIN instead of via the EXTRA_RUNS variable.
> 
> The fix essentially excludes the tests passed via EXTRA_RUNS_WITH_PLUGIN
> from the rules created by the shuffled combination of tests and plugins,
> to avoid running the tests twice, and generates the rules for the
> test/plugin combinations listed in the EXTRA_RUNS_WITH_PLUGIN variable.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   tests/tcg/Makefile.target                     | 20 ++++++++++++++++---
>   tests/tcg/multiarch/Makefile.target           |  2 +-
>   .../multiarch/system/Makefile.softmmu-target  |  2 +-
>   tests/tcg/x86_64/Makefile.softmmu-target      |  2 +-
>   4 files changed, 20 insertions(+), 6 deletions(-)

Looks ok now, thanks.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

