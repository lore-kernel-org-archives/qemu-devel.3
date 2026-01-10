Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20F5D2502C
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Jan 2026 23:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veiHC-0006RG-4w; Sat, 10 Jan 2026 18:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veiHA-0006QZ-Eo
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 18:21:44 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veiH9-00015j-3j
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 18:21:44 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-81345800791so2735369b3a.0
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 15:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768087301; x=1768692101; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c76ovT6RQ0RrtgNNvv2rNGa4Kxl6DvpsZgf13p3BF1w=;
 b=iamAPWP3JcqBTSOW6kMpgb7cpmjghhV3Xc0uythuRl90kyn8UOU/kUfgS6waNXMGCn
 uOxQFa/zzkBfaZ5WQaIR4t9qoaR4lsE2ZAUY0LG2bR2t6A/VsUofEzawoNdC53kHvOdt
 HtcIqHQQke8eKhYteslE8yVnaMK+tMjP2DUi2H3JzjIK0xYLAwHlSMozO/jk1jHqG3ij
 TcC8a2U+7NpgNj1I5w8ONjksxeajY9M3EtGSvqrk94lQd5kxksKivydgXHkT5moqlSQ3
 773kbwCBOxIZv4TZUk3fDB+PTWsDDwR2vX2Kvb/xF25B/NaK96Y1rIA35z5KnOvqLroq
 iyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768087301; x=1768692101;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c76ovT6RQ0RrtgNNvv2rNGa4Kxl6DvpsZgf13p3BF1w=;
 b=bZrTfeafvtAdhdupOQ60LvzzX+u1EsLm6KLsia8uwtFA8dxO374WiBBnqAfyF3WlXZ
 EOlY7vxscoDGXYtrH/c1f+gJSOzhJ3nsp5yl2mxrcS7NcVeHwYoRmKRrUjf4pzDo7Y0o
 6Ml3EUDociuI77r8LlxVf4qtTBNaAtrjcYre33A9C9S0t3PUytmWltl7hHKfCX6J73El
 +RlSX9fZv1jswkFBAjNIb1KfZqPPSR3AEFWEVDz6cDAGy4a2VkEmgONgbqxUpklGbVuh
 Xfow8WSnVltP0lg8xgtB7TZQ+XPawHe+zMSVRW1U9gSibR1urrkx3Ero0E7THvs8CpHk
 DZNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWNmu+6dpBJpQ49SGOtSohZGm7qYwCwhy56P1cbf7RMFXsKgOEqVijzeopD4aWdMOKmFPvInWAEx7A@nongnu.org
X-Gm-Message-State: AOJu0YxKJlnQ11c/x5Rts2geKyFFXs9o4EBt2pZXJ9Wnsmn2Vkydspkq
 PjmJGyItKipGJFWkAWl6UCrwW4N5qj2Qs1uuwXkPaVzjFIfI7IyVvfm1AysagGmH2sgPzGNCdRp
 6T7WpVhQ=
X-Gm-Gg: AY/fxX5NkTogy69ps7JjHVG/PS0HD7YY6Xmi3WyDMh/ABU+iQK6e1i2N7dopANZ/YEm
 qD3sUTCVXyAxMwwFFHCKji/8dizXWjTw62q04CLNIEtNge0c3ThRbAxgN/Qgq3lrl+bLrviktao
 469TG2i4K8ePxfGvPTjdgHIBVqReQJZAxyQrBOqB/6bF6TohWdDVEUDGbtVOPyvorWQmeMrlBTU
 +61g8QK4JBNvGTtNbuagBTPGf7thBJlASeu52u48uiNO6DLqdG9BLUcgMABhX2ywtaIm+9irBhd
 equTYvRy3FFNQQdmzzMJlzhv3/AA0BH9AVTmBrX7srME7ipI6PNUGzQJrkIsLKNKp8tgjtvbhMD
 NgJs5cCVwvRb0Yjxi97Efl5z9xJs2hra5uCbsUovZVJxBAeIcIpMRlJzLfvsYbCw2azZFcBdD1P
 6m4R/j6jnNxMdcTX6MCtwUkPgWfw==
X-Google-Smtp-Source: AGHT+IHTAVf4YyK9l0eLbjWxodbD40W1U8LANlWHGOtfzzHBL2Ri9VDdG5NtLFYvpJlAwwk7DxW6og==
X-Received: by 2002:a05:6a20:2584:b0:361:3bda:7155 with SMTP id
 adf61e73a8af0-3898f8481dbmr12342773637.7.1768087301487; 
 Sat, 10 Jan 2026 15:21:41 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbf28f678sm13791589a12.3.2026.01.10.15.21.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 15:21:41 -0800 (PST)
Message-ID: <13e2ff15-12c6-48d2-afb7-fd2542cfdddc@linaro.org>
Date: Sun, 11 Jan 2026 10:21:36 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] linux-user: implement epoll_pwait2 syscall
From: Richard Henderson <richard.henderson@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20260109090937.599881-1-mjt@tls.msk.ru>
 <20260109090937.599881-3-mjt@tls.msk.ru>
 <44e74d67-b32d-45d9-98e2-ba452bdf69ae@linaro.org>
Content-Language: en-US
In-Reply-To: <44e74d67-b32d-45d9-98e2-ba452bdf69ae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 1/11/26 10:20, Richard Henderson wrote:
>> @@ -13644,6 +13655,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, 
>> abi_long arg1,
>>           switch (num) {
>>           case TARGET_NR_epoll_pwait:
>> +        case TARGET_NR_epoll_pwait2:
>>           {
>>               sigset_t *set = NULL;
>> @@ -13654,8 +13666,13 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, 
>> abi_long arg1,
>>                   }
>>               }
>> -            ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, timeout,
>> -                                             set, SIGSET_T_SIZE));
>> +            if (num == TARGET_NR_epoll_pwait) {
>> +                ret = get_errno(safe_epoll_pwait(epfd, ep, maxevents, arg4,
>> +                                                 set, SIGSET_T_SIZE));
>> +            } else {
>> +                ret = get_errno(safe_epoll_pwait2(epfd, ep, maxevents, timeout_ts,
>> +                                                  set, SIGSET_T_SIZE));
>> +            }
> 
> This second test needs to be vs pwait2, lest you break epoll_wait.

Bah, seconds later I noticed the switch in the context.

r~

