Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B7ACCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tsU-0005Jf-A3; Thu, 09 Oct 2025 12:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tsS-0005JG-9z
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:52:28 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6tsL-0005f4-7G
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:52:27 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-78f3bfe3f69so1166584b3a.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760028733; x=1760633533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WxZ4ZM44esRbDQGVy8vQ0avVmUT2iuUyxw40BEe9dsE=;
 b=Wpq0dqUcbhTJlHwG1wQjQQ1Q8hAbQ6nALGFbOrfUJnSqMRxx0y+A9NxO5rzLDwiKAS
 vgMjEW0195a08xksoWhT9nD0WGZoGiVdwDjhKpv1HPgFO7+Fy6Yj9YfXzd0ZJlJM4CQd
 bfdFDMur4lKPY1lkvbREOZO07GhkhHVErRbFU/pILteR3YPFaegb8YyfMb1NGBaZH7Yn
 y3KmGbxW439ntY2+FoTth//z2yicErk8GsDcGGXGoQUpKN9XN5/oe1J0HbqEOUOI+LAE
 WO79RHpnllHa1IHwIa9Kit2b6YqSnAkOU8U1XIwJdv5+NP9a0k4S/JfbxUA2jCzpFwam
 3lCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760028733; x=1760633533;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WxZ4ZM44esRbDQGVy8vQ0avVmUT2iuUyxw40BEe9dsE=;
 b=DkNc8AXcBqDmBygy9ct7aqxSimv24lzwMSNvtKaA33PURzEBlyHPoG2Ok8u6cWItVJ
 DouHfp92j2r5jcu/u35lXNPm5vzd5OMX4aF6oT/sa6TyLNejdBy8ty7+v0aALvxgaDYB
 H/H0KvGQ5jG3YQYulSV8f23/+kok1n2+AJ+A9LIN21lpIT9/RH1OkAsblyYEO3Wga4Hg
 fj2WWpgn8XNPpnsNvZSJrILK7JwdoiEc4eicY2bub0T/E1pM6AxmwcSl7vrET0jMVFuo
 vuaPHA2QvofBv0hPls8RxgSbJiVGuPJyK4+OHaBnYIT6Cv/ZmplEG+uZsjrLos6fykN3
 +0PA==
X-Gm-Message-State: AOJu0YyN1FF3DXd35aZtU+4iFSe+0cqYwV4Ubjh2tWc2kN33QY0tNsyE
 ebZLIVVh5HXQs/IkmhyTOAooI+57fHJAXOaWhBvlqy9XuAR/HO36eqzI98ExTHWO5ZXtnQt6N+D
 3tJ7Xnp0=
X-Gm-Gg: ASbGncuP7+a1KCrQDMZBDkKhZqxpvX/qZofyKXoPrDqYkGJxhJCIJVM8z+O+s493DvC
 PX1xgdJ9x8z1uVMXH/A+h4JR3CFq9hJmb+CnWZ3Kv3A4k9nAzOs0p7DJa/DQEY94gzBiubG7meF
 0ZF5uakD291XNrghrQHLgkPJ2Ba4CbFz3yK5Ei9nzzHUlk4xi8iRp9igZT/X9h7zp8TSt8nn0aX
 UbQfyc0/C43Y7/yTwRr/w//iuf95plBwQMel/s97oMCEeNQGXstOYmNMYkBHSzrg/oDKHZVi8WC
 wtuc0eNhvKKDlEuUeSIya4y7D5nQDAF4e+BZTzcb7hn0wkEAfelmg0DvYsdv1nDuc6T0Fe+zW2L
 OgCJ69RM3rZNB+D0vnHqhBdNhX7T/104iZQSKXJHzM/TdrIfz32LNR3EhMSYnu+qf
X-Google-Smtp-Source: AGHT+IFIWlzsxNu1Zfj4ZjegfpcK+rChSz/iYiBuvm6c90dmlPm6AG+STfw1YXBkYtsGQ5guQ57m/A==
X-Received: by 2002:a17:903:252:b0:267:a231:34d0 with SMTP id
 d9443c01a7336-290272e3d1fmr94842435ad.42.1760028733273; 
 Thu, 09 Oct 2025 09:52:13 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f36738sm33606975ad.87.2025.10.09.09.52.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 09:52:12 -0700 (PDT)
Message-ID: <373bd3ae-ab88-4442-9986-4d0d9703a6bb@linaro.org>
Date: Thu, 9 Oct 2025 09:52:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] target/openrisc: Replace target_ulong -> uint32_t
To: qemu-devel@nongnu.org
References: <20251009081903.13426-1-philmd@linaro.org>
 <20251009081903.13426-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009081903.13426-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 10/9/25 01:19, Philippe Mathieu-Daudé wrote:
> The OpenRISC targets are only built as 32-bit:
> 
>    $ git grep TARGET_LONG_BITS configs/targets/or1k-*
>    configs/targets/or1k-linux-user.mak:5:TARGET_LONG_BITS=32
>    configs/targets/or1k-softmmu.mak:5:TARGET_LONG_BITS=32
> 
> Therefore target_ulong always expands to uint32_t. Replace and
> adapt the API uses mechanically:
> 
>    target_ulong -> uint32_t
>    target_long -> int32_t
>    tl -> i32
>    TCGv -> TCGv_i32
>    tcg_temp_new -> tcg_temp_new_i32
>    tcg_global_mem_new -> tcg_global_mem_new_i32
>    VMSTATE_UINTTL -> VMSTATE_UINT32
> 
> There is no functional change (the migration stream is not modified).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Anton Johansson<anjo@rev.ng>
> ---
>   target/openrisc/cpu.h        |  22 +-
>   target/openrisc/helper.h     |   8 +-
>   target/openrisc/fpu_helper.c |   8 +-
>   target/openrisc/machine.c    |  16 +-
>   target/openrisc/sys_helper.c |   5 +-
>   target/openrisc/translate.c  | 382 +++++++++++++++++------------------
>   6 files changed, 220 insertions(+), 221 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

