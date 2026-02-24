Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A688F4BB7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 19:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuxx5-00039a-9Q; Tue, 24 Feb 2026 14:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuxx3-00037g-PB
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:20:09 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuxx0-0006rC-Lz
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:20:09 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43638a33157so5492346f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 11:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771960805; x=1772565605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b5BYHve34Gr4m6COmESIyRNQJUMygD4tF25AUIydfN8=;
 b=tls8oV5rfQPXNhD555BmyrHYxD7mjfgaiMMxm9t4LRIHTBnRBlPdYcZJW+XWFkq6Tc
 dmJ2M4LwSkjxr+cXHJ9B+TWSkGVwQJX9ROxblYoMhU7mgw8Md+1E0wUV1EAST4AX9ZPr
 7MvQFL24SmjCZdH+JurIjoaHF4dXN6xiZk75KT0EOcd5AKflH1rvEoet5fzDrINQYW/y
 YtrJ+VRH1Q4Qyo8ZbnYXx1xJ821ur0ZW9B9uxASvF8aKfzP5Z073Y/WM0vnrZ+RwEU3t
 MpRN7iCNIELaURkrCq3NREzg0+l4UuVshNSDyO3kw/0F29tz6twqG0UUG9sUyrynywpI
 C3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771960805; x=1772565605;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b5BYHve34Gr4m6COmESIyRNQJUMygD4tF25AUIydfN8=;
 b=W0KHM7Cqc3NtYLCYP758Vdiplqk8gRszZS7vLapSDshv5iaxnTsFahsL8B/C1+aUc5
 BEDIq9fYDlwB7+d/bjbUR772nw6QNOg5nHVXlREO5vezlw96zLbj8gkP3nPmRg/YiRS9
 93Oez4kW1O9nXzZKthZa6ifko6vQAWIiuDEFqGM5z3d5fOgqgdCwEmdIXJpWD4TzHZ2r
 DCRKAYR7iDtxmjPzUkjRk+HwAEUXrU7bAznwh5FowmVhD249jLnEwRZgJivlWPUw40o2
 xucv7mKLU+e0pQMSuVlQ9ja958R0t3WinLxcf75qeyapmBo0SIDFAczdmgBdzp0kfdZI
 4pkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/668Oy0qiC03Hnub2JctrOGpcj6+bYgjLgklcl+zgdL3Zhb7khG4kCvvuhAdVdO3TtMBJUiZhS1T2@nongnu.org
X-Gm-Message-State: AOJu0Yw7Uk2JElzJn31VEk35cy8BMieRV9/hWlExQK/a83WXp5RpBqIa
 2rMBjM3f1wpJC3ZO1OBmhW/cHnDfwqxIH/ccbZy5yvagXD7c+/ufW6h4+L54dWZL3KQ=
X-Gm-Gg: ATEYQzzKZx3EuxtcldMQrtuRG2hILfYICy3yAeqiV8KHc/YA+eQlosMWp3L6NrcFxo6
 iaBOicOhLajAZjpCSIM4xjTq2pmUnvsZJnhvpnI/8fc8grzaBLsgcKeBn5irk0+9ju5bGzUlIE1
 +Fh4WC6veSdnGE7nWo0wY64soM+IrwcvNMTyWbIa33N04z5FMA/bRcFTjcWVk6lDMdIZpzmf8E+
 17I5hmM9TL2l95+OL94bcTGkh7sspCo+avhlqqvSQAzRLc8cuti2G7DGajILB6C4SYvN22eeG8r
 bFsuL7UCXZHbAtvwa6HS7xYjFj91EHVuPHwYCYHABTl/lcvA6f1ecHavvGTdORSJYUpBuVeO7o8
 yGBDryvQwvPdN8L4WawY+zno6DjhIQXYOGQb9e97W5Bg3xA8ZwMoyxpjG6pb5ye91zHVTPL6w7I
 bY/SHomkySnejRWJKG3NqZRxEkkUji3vkHxRuNvy6YvnN4RLkVExCCZaRCJ8jtOtK2iA==
X-Received: by 2002:a5d:5d11:0:b0:435:a2f8:151c with SMTP id
 ffacd0b85a97d-4396f175439mr23415544f8f.28.1771960803930; 
 Tue, 24 Feb 2026 11:20:03 -0800 (PST)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970bf9f77sm29537621f8f.5.2026.02.24.11.20.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 11:20:03 -0800 (PST)
Message-ID: <07184078-fd62-438d-ae60-47c71ba46fbe@linaro.org>
Date: Tue, 24 Feb 2026 20:20:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] Drop TARGET_PHYS_ADDR_SPACE_BITS
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260218-phys_addr-v6-0-a603bf363218@rev.ng>
 <20260218-phys_addr-v6-7-a603bf363218@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260218-phys_addr-v6-7-a603bf363218@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Hi Anton,

On 18/2/26 18:21, Anton Johansson wrote:
> The macro is no longer in use and can safely be dropped.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/exec/cpu-defs.h       | 3 ---
>   include/exec/poison.h         | 2 --
>   target/alpha/cpu-param.h      | 3 ---
>   target/arm/cpu-param.h        | 2 --
>   target/avr/cpu-param.h        | 1 -
>   target/hexagon/cpu-param.h    | 1 -
>   target/hppa/cpu-param.h       | 3 ---
>   target/i386/cpu-param.h       | 2 --
>   target/loongarch/cpu-param.h  | 1 -
>   target/m68k/cpu-param.h       | 1 -
>   target/microblaze/cpu-param.h | 2 --
>   target/mips/cpu-param.h       | 2 --
>   target/or1k/cpu-param.h       | 1 -
>   target/ppc/cpu-param.h        | 7 -------
>   target/riscv/cpu-param.h      | 2 --
>   target/rx/cpu-param.h         | 1 -
>   target/s390x/cpu-param.h      | 1 -
>   target/sh4/cpu-param.h        | 1 -
>   target/sparc/cpu-param.h      | 2 --
>   target/tricore/cpu-param.h    | 1 -
>   target/xtensa/cpu-param.h     | 1 -
>   21 files changed, 40 deletions(-)


> diff --git a/include/exec/poison.h b/include/exec/poison.h
> index 21eed4c54f..ffb34faf28 100644
> --- a/include/exec/poison.h
> +++ b/include/exec/poison.h
> @@ -43,8 +43,6 @@
>   #pragma GCC poison TARGET_FMT_ld
>   #pragma GCC poison TARGET_FMT_lu
>   
> -#pragma GCC poison TARGET_PHYS_ADDR_SPACE_BITS

I'll keep this line for now: it might be useful for rebased forks,
helping them to notice they need to update their cpu-param.h (we
can always remove it later).

>   #pragma GCC poison CONFIG_ALPHA_DIS
>   #pragma GCC poison CONFIG_HPPA_DIS
>   #pragma GCC poison CONFIG_I386_DIS

