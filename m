Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2F0CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 17:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7HKT-0004K4-OP; Fri, 10 Oct 2025 13:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7HKR-0004Jp-KJ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:54:55 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7HKK-0002dR-6c
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:54:55 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-782023ca359so2393581b3a.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 10:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760118882; x=1760723682; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+o62HiOBN0vfdNFdXALCbDGMgYdmZaceJz1TkhvtDXU=;
 b=l+xMf/bklNdDsuOJ1GyXzhNgfInpIH9ceg886glRaM1x/trUkmpv4C+c1LgdGg6a+U
 ZgbRHohE5SKtLvGKk+S0yjZvBGbIyhjknieOX8EmqhuQG+YgMsemf+p2K4Vj2miNTL2v
 /nP7BfeuCiClB1FgGooBPwhPkNm4/XEBvk5Sx+HX7GxiRX8GncZnWRevDVJy4KVTzOtD
 zGyqS1C4RuqGQxch/psR4odM6JJW49HKRXvhtAMdkYVCl0ieMuC+PEJaT56cjz8Bwn3l
 BFhjKYJJRGRcysZ7t3QJxSu1cypqAuprK/GZ5ynSgJIMtYrbqYZjqt0N/YSfep8pSaen
 UvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760118882; x=1760723682;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+o62HiOBN0vfdNFdXALCbDGMgYdmZaceJz1TkhvtDXU=;
 b=sWbhrxGb8VXmBCFqZ1bqWlvRJuQYf3uDbnAauGpUSEL5PC0NIcAXJlALOmFxT8pNxN
 HtrYKL1zooNfpXnfaDLXMRWy9Tn9cmAZW9kTzWlNuwPDnEQWa4BJrMs3ZHDgr8fov3Ur
 WrHgrZVy6ufdpfgJ+ZIr539+SBBn1TaxT1xsjfvF2frKW4toD4QQaCdutdt42136nM2h
 AvvGsOweBlYkto7bOgmNi3IHcyvyoUQaOCD2B4LHy+sQZHBACuQYyyBF8EYT3uVvAWWW
 ObMhzvRDY9wo+ZAENaPmZ5NF160jXInqsmZxuC1kq45LPpyVxX4jSuGjL7juUMKXhx+4
 UW9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV3hHdmMOJ27BgLSUSbN/rEcpOR7fHg73Y62CM5/SJI2bM2lhhv6OXbE9UkmnWwg1ibIsCey6/XQPy@nongnu.org
X-Gm-Message-State: AOJu0YwNfIoRVXleO5aU47QXdWZMBo5La2KP9vG3WP1xdea3dgyHLVuL
 sqKYV/LnKZotSsvwn8zzYd8LCv4VCuRRIsVjREhKp/KPWJ/fmLeo7xPwV8Hs0ndGxasQorhRaWb
 6n85WRyc=
X-Gm-Gg: ASbGncsV6Xl0AGyAAChQnDtJCS9PWGULV41sTRxtq3hvb+OHyR84pf15XO3JKS/dloP
 drOHTU0yrRWgGfj1EXvT+InxNFhQKBCx51CE7/t8wSwOYWrFT2H44xP6Pg6fXhzmj5sHxN3lq0L
 WRZkYTUDq1/vT5KCpTVmo6KZSfz8hTsOr2k2lejcsxnnykpJoWXGVJfo1Kc5sVPSybht75wbYCc
 O/s9oH1OBpEOLuZw73bnaBFyQFUMqplpeSwp8Iq6B8MVXyR1D2rcj3V/MpMjK9qnsdlfypfba3T
 IZbuLwYK9FQ9960OYw3S1iVDwBUtjcglZbV0yr6KW0s7rkzYEG1o1x4KZ28rDTJ8PTZXAIwaSQ8
 CwWYZ3D9kQS/0OSyB+7WsjfKQRKC/WhWtn5hhzzSZAOGVwx9eB4HhzLvEMxU=
X-Google-Smtp-Source: AGHT+IGe9SaOxmrCuZmAF110TO59X0rKrUibgQ4Iuju7dR9iLgUUjwybUqKjlIjlyBto9DSGaPKPYg==
X-Received: by 2002:a05:6a21:3086:b0:307:a015:37ef with SMTP id
 adf61e73a8af0-32da813c536mr17821405637.20.1760118882443; 
 Fri, 10 Oct 2025 10:54:42 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b678df8b381sm2880140a12.41.2025.10.10.10.54.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 10:54:42 -0700 (PDT)
Message-ID: <df6c8e6e-931b-4403-802f-50977ea6d3e5@linaro.org>
Date: Fri, 10 Oct 2025 10:54:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] hw/hppa: Move CPU::kernel_entry ->
 Machine::boot_info.gr25
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>
References: <20251010061836.45739-1-philmd@linaro.org>
 <20251010061836.45739-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010061836.45739-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/9/25 23:18, Philippe Mathieu-Daudé wrote:
> Current code uses CPUHPPAState::@kernel_entry to hold either:
>   - kernel entry virtual address
>   - firmware interactive mode
> and CPUHPPAState::@cmdline_or_bootorder to either:
>   - kernel &cmdline physical address
>   - firmware boot order
> 
> Besides, these variables don't belong to CPUHPPAState, they
> depend on how the machine is started, and only apply to the
> first CPU.
> 
> The MachineReset handler initialize some registers of the
> first CPU. Hold these register reset values in the MachineState,
> initializing them once in machine_HP_common_init_tail().
> 
> Start by addressing the kernel entry and firmware interactive
> mode values, stored in $GP25.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hppa/cpu.h |  1 -
>   hw/hppa/machine.c | 28 ++++++++++++++++------------
>   2 files changed, 16 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> -    }
> -
> -    if (!kernel_entry) {
> +    } else {
>           /* When booting via firmware, tell firmware if we want interactive
> -         * mode (kernel_entry=1), and to boot from CD (cmdline_or_bootorder='d')
> +         * mode (interactive_mode=1), and to boot from CD (cmdline_or_bootorder='d')
>            * or hard disc (cmdline_or_bootorder='c').
>            */
> -        kernel_entry = machine->boot_config.has_menu ? machine->boot_config.menu : 0;
> +        hms->boot_info.gr25 = machine->boot_config.has_menu
> +                            ? machine->boot_config.menu
> +                            : 0;

There is no interactive_mode variable, so the change to the comment isn't great.  Perhaps 
just mention gr25.

As an aside, the expression involves two booleans, so better written as

   machine->boot_config.has_menu && machine->boot_config.menu


r~

