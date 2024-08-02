Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71CAC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsD2-00087g-MK; Fri, 02 Aug 2024 09:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZsCo-00080q-3L
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:20:27 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZsCm-0002Wf-Ga
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:20:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42803bbf842so72080875e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 06:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722604822; x=1723209622; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WrEZu6nyJazvpwdG4DLuA6n59C3JvsgZMtnUKZZ9qRY=;
 b=ESIM7yBg90dmJ6VPEXhA6LfQB3r0D6Y40FRxQmwIfT6Hw0QaKb50cJnf34MudUWKo1
 7tC4aeoV2lkBGZioEcCS0hX7Rn9YsmjkSXTtp20ZE2yMurdewUzcpnWx0JNcIbYI5I9K
 DeaIaV5jW5hrjIKZWg2ZuMogXmu794Eg9lJ8RAUAsj/3+xXuBdbfbaDtgJTAgMUhsrtx
 z/Nei7UoWm18uOD1biiUwk9nWChWi0ptk+8qosxxPAR8Ef8CHcxLCl34KRuFpIHtCN+R
 pH0VCGqNHdkfBZfB2zWFtIyqO02Z7H849Ep5Q/6AXF18VdIIE2Mo7lz4DHfirH6+kZ0f
 lrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722604822; x=1723209622;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WrEZu6nyJazvpwdG4DLuA6n59C3JvsgZMtnUKZZ9qRY=;
 b=awG6sYKlhkDr0/gk7rJwZsEpEoUVfgIb42jRLQnlLV+x4HDEpZeP8vJdeVm6q4uvFG
 P9KGdg8OB5C4kFJorrad2tWxknPWQvWhwnqMdSUI78RrXtCABLpB+CEOzWt1lVULf18F
 Jweeff2Bod/AK6Kq1XhZvQQn8+iYsjA5gXlc6mmnBUYL5k1xHsHairTRs0sg7qnTRxJ3
 QNbGpEjAPcT5rN2yzRgzSCLnLMNdp0gnD2MnleM9D1axzv877mOVx8qTJKuFz/my5++w
 hEKF0h1HJprNe5cokp2WkiYC7wqqUXXvauP7xuwIMNuRBKJbFrjeVWUjH1zwaTONIUe0
 Y9Rg==
X-Gm-Message-State: AOJu0YzuG84eHsO8hcbIBcOGqnPU6BUEnIg38nADUoeKZzaf2itjvfro
 PrI6/VVmwHyni63Ti21raJ0rHDHP6KHdNPBkRo4FbIT1cmI17BGM5zXK/qhKEEI=
X-Google-Smtp-Source: AGHT+IHSfcx0fQ+13XwvpZpHwu/VYQh/YphZOnLvWeWYztkzTLsrbgtWMb2NoHazPlyYaupVzo3Frw==
X-Received: by 2002:a05:600c:4f07:b0:426:6714:5415 with SMTP id
 5b1f17b1804b1-428e6b7e993mr26762205e9.30.1722604821948; 
 Fri, 02 Aug 2024 06:20:21 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6d6b902sm33097525e9.4.2024.08.02.06.20.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 06:20:21 -0700 (PDT)
Message-ID: <a218c0ba-3527-4e31-b8a7-e34b6f2bad1f@linaro.org>
Date: Fri, 2 Aug 2024 15:20:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/elfload: Fix pr_pid values in core files
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20240801202340.21845-1-iii@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240801202340.21845-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 1/8/24 22:23, Ilya Leoshkevich wrote:
> Analyzing qemu-produced core dumps of multi-threaded apps runs into:
> 
>      (gdb) info threads
>        [...]
>        21   Thread 0x3ff83cc0740 (LWP 9295) warning: Couldn't find general-purpose registers in core file.
>      <unavailable> in ?? ()
> 
> The reason is that all pr_pid values are the same, because the same
> TaskState is used for all CPUs when generating NT_PRSTATUS notes.
> 
> Fix by using TaskStates associated with individual CPUs.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 243c47066253 ("linux-user/elfload: Write corefile elf header in one block")

Isn't it

Fixes: edf8e2af14 ("linux-user: implemented ELF coredump")

?
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   linux-user/elfload.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


