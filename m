Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5E6D49212
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD16L-0001N2-Kr; Mon, 18 Nov 2024 07:43:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD16G-0001MT-49
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:43:31 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD16D-0004gY-P3
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:43:27 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5cf0810f5f9so1371351a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731933803; x=1732538603; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YzwabnuQv63aa5IySU446WinUGgLuTW6edTfloKaV2E=;
 b=tU6ZIhZxC2x06FgmuQaXEocFUAc/WaYQm6nMBmaOQHwZzpMRhGARhNi0gQhdYbzLQ0
 72fwbiuxR8R2z0XDRNtwnKbB/k4YXVoeZehwG4HifGkJfwaJpIavneQjw6TADL0cg1py
 ARJ8CX6zm6Zx4AT6wFfNKk+WZqxEgdByOoHNawQFs/n07OWrcDXILs3C6h5ky1Sg2Wws
 4i3wtsQLFtc7AIdYhUglO6F0+hBAK9kw3AF8kk2qViutpO7908VelV4FO+oToe+BKLpv
 RpxytRO4dpQLZQ4MvbzjkSUWb9ZI+2VIqpETPOvdFCh6vQQ9kZ1/XsfD3aFx2oFWN6MI
 HIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731933803; x=1732538603;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YzwabnuQv63aa5IySU446WinUGgLuTW6edTfloKaV2E=;
 b=wFTs1YvUA8mdrmz21ZbtndJ0pvIgltFmbfye+axIjfoKiNL5qb1GCrKgQKkSPzJxZ8
 U62b8BJGV9+1nvpiM7odVgCjLLQ8S2R9jySeLCjMBX+KHkSE6PMEszMw4pNytLV6rL11
 cMyYF1igS0ZgCVZZhgBM/8BFhQp/E4WSqPeyBkCEmI0znEjGY7VCIaYTv+VM6nfwMC74
 ZiCRAXa7lLwuDi82vibJHlsUR2OfFRko3zGu2Kuq4FhcdoJIKPiGUuGIZ+XjIfvVO3m8
 JNMCOgVlCmpDugr47z6n0Ye6ZsPCn1/bhn3z7l47F2xxkmLfFCSAOLeiu3EUlnmS78MA
 lvVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHBFze7zsYfVpINvLOKoYYudS1CtmJ4JF5Ev6CLI91mD0pJHa93MyAdaIztOsW6UC5+3HuSLtgEv2r@nongnu.org
X-Gm-Message-State: AOJu0YwL8kakURKIuETQsFJL56ydAPEP27PYi6hgUoo7tARxkB7OPF1y
 lBXqWxNTyjS8jc+snEXBDfDhEcVvPrfqf5LhbP6ym/uS/g4J5UVk8QqhLpP8IkA=
X-Google-Smtp-Source: AGHT+IE+w3c/3LRgKREr0wAajXGtik9S5o1KBWCzdz/Rx49IiCR37ShfDQHn6Mh2Z8NXPoyJfNsCtQ==
X-Received: by 2002:a05:6402:2794:b0:5cf:66d1:f97a with SMTP id
 4fb4d7f45d1cf-5cf8fcc6f29mr16080450a12.15.1731933803190; 
 Mon, 18 Nov 2024 04:43:23 -0800 (PST)
Received: from [192.168.69.197] ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cfb99af32esm1860129a12.75.2024.11.18.04.43.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 04:43:21 -0800 (PST)
Message-ID: <1638d4d8-82e6-4738-b947-e0d21fb584fb@linaro.org>
Date: Mon, 18 Nov 2024 13:43:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Fix !CONFIG_SYNDBG build
To: Michael Tokarev <mjt@tls.msk.ru>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20241114130152.352009-1-vkuznets@redhat.com>
 <f202f7b5-5840-45c7-8b4d-a93c71c4aad5@linaro.org>
 <f60d1429-ab8c-44b4-a864-5a5937dd844c@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f60d1429-ab8c-44b4-a864-5a5937dd844c@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 18/11/24 12:40, Michael Tokarev wrote:
> 18.11.2024 15:39, Philippe Mathieu-Daudé wrote:
>> On 14/11/24 13:01, Vitaly Kuznetsov wrote:
>>> Commit bbf3810f2c4f ("target/i386: Fix conditional CONFIG_SYNDBG
>>> enablement") broke !CONFIG_SYNDBG builds as 
>>> hyperv_syndbg_query_options()
>>> is missing there. The idea probably was that as "hv-syndbg" is now under
>>> '#ifdef CONFIG_SYNDBG', hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNDBG) 
>>> cannot
>>> be true anyway.
>>>
>>> It would have been possible to add a stub for 
>>> hyperv_syndbg_query_options()
>>> instead of resurrecting '#ifdef CONFIG_SYNDBG' but avoiding
>>> HV_X64_MSR_SYNDBG_OPTIONS altogether instead of zeroing it when
>>> !CONFIG_SYNDBG seems preferable.
>>>
>>> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
>>> Fixes: bbf3810f2c4f ("target/i386: Fix conditional CONFIG_SYNDBG 
>>> enablement")
>>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>>> ---
>>>   target/i386/kvm/kvm.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>
>> Patch queued to hw-misc, thanks.
> 
> Please note once again there's another fix from pbonzini for this.

OK, dropped.


