Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C75D0C601
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 11:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Ite-0007fm-On; Fri, 25 Oct 2024 07:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t4Itd-0007fY-0r
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 07:54:25 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t4Ita-0003m9-G7
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 07:54:23 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso25670605e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 04:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729857260; x=1730462060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fOGekrrWp/VyksWfpuy1zl08MfMS91SwIXaqa9Q2qkY=;
 b=NKLBVJL9fYvkIODrj1X/xZBwogU/9vW7yIDVF6EeKT2nX+nnrN16HLcWFbqoT/gwLB
 4roI0x1I58ZN1BOAk/3C/Z6v/TrMHIvdRR0A8tGcX6UlI1RTye5t+XumoKsJBCHwydld
 GeLKXaLTse/Qvmijpq10wAkp0Zo4ZX99DP3lJ2CGEBiF5nugWiALeeXK9uEd8oFHW9OK
 ss8KMZJEHLY7HN2m01a+kCx0jvvSYAmp5hloXlNBDtnGQMNk5Kbh+JMy2SI/4GnHnjtF
 tz/WJBH14aSwFVNG/miZ5i0mz1oZR9TXB1FptrUVzESYIalR+0zvwFeWyFACd8jzl1dn
 9sZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729857260; x=1730462060;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fOGekrrWp/VyksWfpuy1zl08MfMS91SwIXaqa9Q2qkY=;
 b=fIIMVr1Kbn4sPJwKqdrO1o0NkdWx1JbSs9MnE2vimcyHm8LRCXXlhzfNLHgt8R5+jn
 wRr9DTH2uAVPjxgnSJUpL9M+thU54f6WrD3UHzwgrHjV3+wpmxRGO88SubIH6dCwuQL7
 KYypGxHsJkyo63H7I3iFoEJ1zk8lNMeqeGfmuL9IBkIN8ApSltrrxP9woshOJgM0Npu4
 TgWnK+6TR5Ge7ezKtnq3h9Zg8Kg3KdjqESfJ+5/+TlVSutwOBhKp/Tb2+ofcm2GDaoGd
 1Y/YrnA4WoPmUAwHcV/k0MyOkvBGBA1h0EeY4BeFER2z/5I0CqXy/l8Xi2amMjuMDuVb
 B5Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgu/m55YoZvhhcVlIt8Zv11JD0L685FLLcuvT0sr2UzwjA48kxfpC+9vI/Gw+uNHjqN2xDiTUcTd0F@nongnu.org
X-Gm-Message-State: AOJu0YyRA85jyZExJyGN/wC359w+T/Fxs3lDUlNCnBOvVIdmw9Rd0x01
 HzPMNeYwqZ2M+L0rjl+RfW5jgvBRvGQhEhKh5gnVfnoWtrsd33UMXqpTjFIVetE=
X-Google-Smtp-Source: AGHT+IFg4xi1wsi0ydDsqA2Fn2Ft5PfqfwLpP6i0lsqgE4DnV8zWk4BwKwIlo4KaS+IFgMVwyBvUXw==
X-Received: by 2002:a05:600c:4691:b0:431:4b88:d407 with SMTP id
 5b1f17b1804b1-431841eae7fmr98478285e9.5.1729857260431; 
 Fri, 25 Oct 2024 04:54:20 -0700 (PDT)
Received: from [192.168.200.153] ([185.201.60.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360833asm15653565e9.39.2024.10.25.04.54.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 04:54:20 -0700 (PDT)
Message-ID: <5467fd9b-bec3-4e8f-b513-c74c7b6eb9e7@linaro.org>
Date: Fri, 25 Oct 2024 12:54:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/i386: fix hang when using slow path for
 ptw_setl
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
References: <20241023222026.1430014-1-pierrick.bouvier@linaro.org>
 <20241023222026.1430014-2-pierrick.bouvier@linaro.org>
 <66320518-0270-4426-8daf-9be3ae7bfce7@linaro.org>
 <849abe8a-9fae-490f-8fef-b3623ae6408b@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <849abe8a-9fae-490f-8fef-b3623ae6408b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

On 10/24/24 18:14, Pierrick Bouvier wrote:
> On 10/24/24 09:25, Richard Henderson wrote:
>> On 10/23/24 23:20, Pierrick Bouvier wrote:
>>> When instrumenting memory accesses for plugin, we force memory accesses
>>> to use the slow path for mmu. [1]
>>> This create a situation where we end up calling ptw_setl_slow.
>>>
>>> Since this function gets called during a cpu_exec, start_exclusive then
>>> hangs. This exclusive section was introduced initially for security
>>> reasons [2].
>>>
>>> I suspect this code path was never triggered, because ptw_setl_slow
>>> would always be called transitively from cpu_exec, resulting in a hang.
>>>
>>> [1] https://gitlab.com/qemu-project/qemu/-/commit/6d03226b42247b68ab2f0b3663e0f624335a4055
>>> [2] https://gitlab.com/qemu-project/qemu/-/issues/279
>>>
>>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2566
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> Oh, wow.  I believe this will be fixed by
>>
>> https://lore.kernel.org/qemu-devel/20241023033432.1353830-19-richard.henderson@linaro.org/
>>
>> which is in a pending PR.
>>
> 
> It might the issue by not triggering the situation we observed.
> However, we still have a hidden dead code path where start_exclusive is called from 
> cpu_exec, not being related to the plugins.

You're right, this would affect mmio, were the os so careless as to place page tables in mmio.

>>> +    /* We are in cpu_exec, and start_exclusive can't be called directly.*/
>>> +    g_assert(current_cpu && current_cpu->running);
>>> +    cpu_exec_end(current_cpu);

Better to use env_cpu(in->env).


r~

