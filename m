Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C71C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 17:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0OQB-0003YF-D2; Thu, 03 Apr 2025 13:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0OQ8-0003XR-J3
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:32:04 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0OQ6-0007D2-Qi
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:32:04 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736c1cf75e4so985778b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 10:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743701521; x=1744306321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I9t72SvxHJHwR7VXXENUvyeoxFJMEGXR3JFXvAvha2g=;
 b=AAzGEkgs5WvL3XmTKA5EAmplVaKdep9slcWntVxMJYKe/Xtq2UrjzLXtW/7RLAi1wC
 vL6PtVbQVp8DGhmezrlua9ys9oT6+Of1HgN4HIFN8CgTNOAGf/v0PXl153w4u4yIX5EG
 rvNav1AEhjGvy0SxfrCf0kzO+qTtei8smge0tdb09w2B5Dczl5L7+G6iXACp/AQxs8yh
 +V8j/bx9MiQEJjDMEI5m8Dmw6DpC6ocd/LB34PIQEihVu6L51yIx/OpBpJSM/LPFTLuu
 qXpqo8QqBnFnN0oF+Fvm1bkMyDdad1eBnu8cc7sjHKkLM0bTe8qHN6ia5vtK42+dGY7A
 DGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743701521; x=1744306321;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I9t72SvxHJHwR7VXXENUvyeoxFJMEGXR3JFXvAvha2g=;
 b=HOiZO9pRS//6Ucx4Jmt5ZIvsffXS0bGymOmn1IwZj7Jjw7Uhgd22TJhlYebFUpVazH
 3ujikuMsX9kSpnub2k+GPru7psbtB5tPI7MJbHpYJaIIJ7NDDWu4bWPmgGb4uerWC8Rb
 O+n57WNQUPb7ODbDAO5xej6JuVOaHMPaDc+O0pAITLBif1fKLB+KRrdBWThDTUzSLmcQ
 /l6yRKC34DiIo9fsQcnSN4s1j/BfgUztxcPyu38IfNMh/ufUTLWY+gduL/wYm9R5wO8H
 e9iBNhuY3SHnUmXwdSJQDhzL1Iz8jviDsS455KjFg3X+deHHwFwEmloOzkyWj5sRS1is
 mrSQ==
X-Gm-Message-State: AOJu0YwcIq3Vey5XyWr1ijG+pK9uOcgrHCuxKPiWJd4kq6EVH0jh0Ybb
 5wBcCaDla0Z9n+wE9ENZ0+GJlK7nWIim6wS+qF9uQ1jHHE1A3LTSgdiHT4rOflJR5BaHJqslNSw
 u
X-Gm-Gg: ASbGncvVXw4iTrb5rEqTVq1pyc9eS0LziRK3PX0tqITsWAcVfM9qNBVJ4+INQ3xBB8B
 I8rVZ/hM6TIvI0j8jqSFuUSMiYLpbSSeaNabyzm2lPZ6hlMsGivOH+GUgg/Fb1pG1asRm/rbyOA
 NGag/3PlAmhpmPM6qA9y7TyK3AzrzgmrAQ0yXzZOmCZiVYwDhsQFto6Xy9vdsQG4ONwtKPWi9fm
 iNYGVy/gBU/eX19TsLAGpKBy787Qw5zOAeIxCXbmE2B+EMg4BjODDBY3ZXSH5xGSM69XL6ahAw0
 1LXiYkG4ApTaVG0q8fZkkc48SWjOcf0n1wLcZM4xl1iIQzLA1KHWXUlgjtJRHIUPe90DW21HvvR
 VeQs/Uvg5
X-Google-Smtp-Source: AGHT+IEEcKWUPK6OLUtrLOXPDvab+5It1IFbTf104yF/3TRjPn1k70uo4A4hSHKiSdSi3Ug12hI+iQ==
X-Received: by 2002:a05:6a00:2343:b0:728:e2cc:bfd6 with SMTP id
 d2e1a72fcca58-739e4c15233mr508135b3a.18.1743701520851; 
 Thu, 03 Apr 2025 10:32:00 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97d1befsm1773971b3a.30.2025.04.03.10.32.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 10:32:00 -0700 (PDT)
Message-ID: <24b7fa86-611a-464a-934b-186df86ba31a@linaro.org>
Date: Thu, 3 Apr 2025 10:31:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 v2 03/14] tests/functional: Skip aarch64_replay
 test on macOS
To: qemu-devel@nongnu.org
References: <20250403151829.44858-1-philmd@linaro.org>
 <20250403151829.44858-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250403151829.44858-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 4/3/25 08:18, Philippe Mathieu-Daudé wrote:
> As of v10.0.0-rc2 this test is still failing on macos:
> 
>    $ make check-functional-aarch64 V=1
>    ...
>    ERROR:../../replay/replay-internal.c:235:replay_mutex_unlock: assertion failed: (replay_mutex_locked())
>    Bail out! ERROR:../../replay/replay-internal.c:235:replay_mutex_unlock: assertion failed: (replay_mutex_locked())
> 
> This is tracked as https://gitlab.com/qemu-project/qemu/-/issues/2907
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/functional/test_aarch64_replay.py | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/tests/functional/test_aarch64_replay.py b/tests/functional/test_aarch64_replay.py
> index 04cde433bcf..029fef3cbf8 100755
> --- a/tests/functional/test_aarch64_replay.py
> +++ b/tests/functional/test_aarch64_replay.py
> @@ -5,7 +5,7 @@
>   #
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
> -from qemu_test import Asset
> +from qemu_test import Asset, skipIfOperatingSystem
>   from replay_kernel import ReplayKernelBase
>   
>   
> @@ -16,6 +16,8 @@ class Aarch64Replay(ReplayKernelBase):
>            'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
>           '7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7')
>   
> +    # Failing on Darwin: https://gitlab.com/qemu-project/qemu/-/issues/2907
> +    @skipIfOperatingSystem('Darwin')
>       def test_aarch64_virt(self):
>           self.set_machine('virt')
>           self.cpu = 'cortex-a53'


