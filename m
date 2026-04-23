Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160DAFC0340
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFvqN-0005Ts-HT; Thu, 23 Apr 2026 11:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFvqD-0005Sn-3h
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:19:46 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFvq5-0001pI-EP
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:19:44 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43eada6d900so6639877f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 08:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776957573; x=1777562373; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=27s9xoydCmoqaf8+7Uuu1ckK4PAczzBgfi1JCn/Q090=;
 b=WGU0ShI5iDwL0tUsE9g4ziOvyniCHidqiy7YCW8GVhlSKmLwdyxiRstBl9R9RBsljI
 uXZvbA/RZWkxecIrjVfxm/oMpFhB6Z+3MHTgP5o/ax6p41NLbNXXdu4CzhfUdoOJUEOU
 0QqCe5yRiw78eQLkUNw8uKt4onEoG47gdM8wegJG2dG5zjr2Ym5EnT0tfrGM83y5ZK48
 sElLtrY0zDnY/qYxx58eabaYeXvyilPcE0rdVJssoCAirw8H6t+bd7XqV86g4jdvBGFN
 hu3BqdBl25Sx6worU3OjjRGkmt749U8ZIB5azP942A8hbEHx63johKAUj2QMU/FHR/2v
 x8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776957573; x=1777562373;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=27s9xoydCmoqaf8+7Uuu1ckK4PAczzBgfi1JCn/Q090=;
 b=OFtfCvDTWHQMtkYb6vpFUWEXqpeWso6JIWibDSrYKpDZVZcr5QkaHsj1DzBF3s61SG
 sTpUo7Jz4jluheAnnH+YcihMh5jYdAERD+lS14CGGZd+Jo6bB06Ypqe+KPcWK3ZWz+Y1
 RwZh5FVlfnHyrN2s1f8K9yCRbW8tM8vYVbrTjjPpVFDaNxP3boDXYhXvuMwxOYselDQh
 jJ48gK6kpDzQEv54l6W0YS8GJpuYfeXAoJpcoj8GqxSZzCxwdN77RRHKy4gnwJzdqATm
 496Oiu/qbatHjT9TS1jPyJYp/SJl1jsrHe7pgVKy09owmEivjLSHN9lj+bUTZqx1p42e
 lrMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9F7qG7D6EyDVNv026yUimaCCsEWAvL/0fjOtDRMPRT6aybK4ucI59ezRSqOC6/L0uSDnoB5WBdrQW9@nongnu.org
X-Gm-Message-State: AOJu0YzMchysDI8dKSS//zsz8sD6iHwPrhGvxsFxzbxyXw4m2kM8q9gD
 QVqLfjlTEhUzn5+oO8KEDT7ZsKZOCf795VOBTX4WIukd1U3qMdevCSyeBI5w4Iv2/zk=
X-Gm-Gg: AeBDieswdbSZC+uJpcjAB1eQF2M0oKGpgxdMNiZ4zYsFOJE/cOINrzn6k0kWC5lFk5K
 z3aZfM647pClaQO1bPZqNzYyzs77/YvMJXRFBeJRMZBsKL/S4qzLVS6ImNEa0N9XHo4IR0CeoSZ
 sec/8SnKhN5E1eOCoUUMFHzMRCzzIMHHl77Fd/B2/UGceNlSqFGHrEXl8Q0An3BafX60M6gJv0z
 Rzwh8nOMxA0RyjKwjiOIIG+iC6acbLQkc7v1uQs2+B5tjdalkzICSYEShRpkgfgOQ3HI2EaEjQU
 gE0LmS5S5EYEv+n358puq0VNur0wbvhdOW9W57jqZ89VTRzB4htBfXgyk9u7wPuP7UfcxKSvrxM
 pdhKpOuk+bbnYf1U3/HgT99HHSbbN9xhDWaFpo5IyqATXmgf/svGQ3SeBoSugcZ4NX5qe9RLDMY
 ehiSDyv1fT7gnKcfgaaKfzzc4leyf5QVw64v/ZSQW/cO4Su8sWKxZeQD1w5mkHhPFgJubWXVnU0
 aNi7E9lr9kp+uM=
X-Received: by 2002:a05:6000:2212:b0:43d:68dc:9ca6 with SMTP id
 ffacd0b85a97d-43fe3dc7b4bmr42221253f8f.18.1776957573089; 
 Thu, 23 Apr 2026 08:19:33 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e46471sm51979209f8f.28.2026.04.23.08.19.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 08:19:32 -0700 (PDT)
Message-ID: <052dc9b7-2258-493a-a6ac-74cf50ece341@linaro.org>
Date: Thu, 23 Apr 2026 17:19:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer for linux-user
Content-Language: en-US
To: Helge Deller <deller@kernel.org>, laurent@vivier.eu, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20260423151521.3969-1-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260423151521.3969-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 23/4/26 17:15, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> I'd like to step up as maintainer for linux-user. I'm actively using
> linux-user to emulate a HP-PARISC (hppa) linux environment on my debian
> buildd servers, so I'm very much interested that linux-user is running
> good and stable.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

