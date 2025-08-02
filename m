Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B922C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 22:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiKHw-0008E6-H7; Sat, 02 Aug 2025 18:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiKHM-0007WW-Fx
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 18:00:41 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiKHI-0000cr-DI
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 18:00:34 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-71a38e35674so12154067b3.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 15:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754172029; x=1754776829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uikbF0PaE/bErYV4ihFKmzhy6cllmIEST00stxQMlQY=;
 b=ZIddwpwK+bumQ43nP6+87G1aHu+LQbQNLCLQafBLGnKAqDQd/OJswu6Aus/1iIa9hv
 o8jVv4xG+QdS7xvdgp2Xr8UMilu1qclo392MFaU/x1BAWghB3uD4IhwIinWX7tZzCXm8
 5QdwuVoHMydTJwyvS208hyYK4/fh3gHcEqTzJNJgHV3t7+bp1Ram/26EWV/ZPW0U2Gyk
 FuNu38NvgQY95Z6x5bMhQdFQQjJSSj8r2n/BRO4i1KeamB0KzemvTVM1BcOCeZevbtnF
 Lbk9e3lbbwrjWupJqYI8IE9RGA4aaWGfwSG0zwSUVxt3gvZ/tVI4k1+YRpV24qHYTBEp
 1XSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754172029; x=1754776829;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uikbF0PaE/bErYV4ihFKmzhy6cllmIEST00stxQMlQY=;
 b=HECuWZU+e/wKRAHB7j5jmuus8SHA7IQmH9XhNOrTyimsyQcsG8B1bq1OxAf8r+5r5k
 B74PPdYnRKk3eMCjy0XyQI4E3QSNU+R/0Y/MZ32a46wGL93USaU9eDuU0i3Zo9IckvcT
 q6KvhbDVpV9k3RvF4X56G+fKZJeOEwtljl3uMZ4O/yfuh7iriZWsUGpH7NrvRgSUWKH/
 tgTFu8gaXWKBO4+zjpMDGkFwdf7VvwB9WP+6gzC03udumBrhL1+5q7fxi70cpSuiLZqV
 ad9n00RRGdtHuj00NC+cnoBLbUafhT8BZLyqvjwG5h9/xHAnNPEDlnj2Ub5eAzL5WH77
 rmYQ==
X-Gm-Message-State: AOJu0YwcaB1wFTk5jm/YLdeKDM9ytwv1XO9Pwi7OE57CXn3efrC9uMOL
 EV4MH/Supptl0MINfXrR9OShHLp7j/T88c3sNONoipV3OtIOL9YsJly7x2TbZz7684A=
X-Gm-Gg: ASbGnctuMmhatJA8uvGGnGgNu+lAmzhYkkhNhg+0dCijAy4pFfFrWSQxb8vM8cYjwDt
 sP6puCqJxh1u3k8BK2Vwti6B7u9U7thghF0N81weLsO3tuOJdZpUtDq1jk33fXYPXve3VLcJaUf
 /Mfgnan2AFpNMqX2NcaiOskM2jtrBE7B7q2JW1H1Nt4g2V3iFCA/Eb/CSOic5jw6fPspDZzRy7z
 yJIIIqlVfwuZH/VQDtsjNivXxx64yGRFNHqf7mXsTA/NVhf6QQhBTmh93hGY2kCLByVD9HrX5cx
 qqEycQ20isYWF+CHlz0zcNDtq8Ixnr5zJ6ci2CwyJksjG9k54u0hcxuFVWGZqbSJRI/0MVN1bmN
 3xxKLuy/zWr2HRO9NIENHH0bSJVPU3l90fcEmLyNsVuuY2LIrG1TIJozVBdv9sOD0
X-Google-Smtp-Source: AGHT+IGrRqYpadLuuBW4u9255dI/+PlJ7nM/cMjSwHlq6JviQnF/Kk2tE5uYjq92e7yAlQ1RHQ0NbA==
X-Received: by 2002:a05:690c:eca:b0:719:f582:be17 with SMTP id
 00721157ae682-71b7f0a74ffmr63238197b3.35.1754172028824; 
 Sat, 02 Aug 2025 15:00:28 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.111.133])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a3a9b89sm17865917b3.15.2025.08.02.15.00.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Aug 2025 15:00:28 -0700 (PDT)
Message-ID: <8638a426-3d60-4a25-8d97-859b901d57f8@linaro.org>
Date: Sun, 3 Aug 2025 08:00:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 62/89] linux-user: Move ppc uabi/asm/elf.h workaround to
 osdep.h
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-63-richard.henderson@linaro.org>
 <CAFEAcA9hXSfzRMuU=9qKC=rb53qtTTRZy1yxZQ=aHs6J1-mWhQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA9hXSfzRMuU=9qKC=rb53qtTTRZy1yxZQ=aHs6J1-mWhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1130.google.com
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

On 8/3/25 06:22, Peter Maydell wrote:
> This should allow us also to remove the hw/core/loader.c
> 
> #ifdef ELF_CLASS
> #undef ELF_CLASS
> #endif

Oh, excellent.  I forgot about that.

>> -#ifdef _ARCH_PPC64
>> -#undef ARCH_DLINFO
>> -#undef ELF_CLASS
>> -#undef ELF_DATA
>> -#undef ELF_ARCH
>> -#endif
> 
> Your osdep.h change is missing ARCH_DLINFO -- did our uses of
> that symbol get renamed to something else in an earlier patch?
My osdep.h change includes the symbols in the actual 
linux/arch/powerpc/include/uapi/asm/elf.h file.  The undef of ARCH_DLINFO here was 
knee-jerk, I think.


r~

