Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7B3CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2pE-00019Q-IL; Mon, 01 Sep 2025 07:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2pB-00018r-Du
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:35:49 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2p4-0008If-Qc
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:35:49 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45b82a21e6bso17234505e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 04:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756726537; x=1757331337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2ydF3eBBLT05orvArgEiXLs4Qlc5lLSPeNeohwBsc0k=;
 b=YuCcKde+9z4/29nEu0zvj4Lqg/XoL9Ff9BDnZoiIHyWTqQH3m2+Fuip6f4uEUMOXmD
 eEsvgwgyLJ71Vb6tLaEFAFnnzC0w1OSR8Q1oHFfhUH6S3UnxsiKbvNBTtWllMXlgBWpI
 De3fd88syxg9+WKNtO3N7NzyedIPoSC2AoE73uOsNfCxPn3lVpWDYIUqsg94/jxSHVwJ
 +H9zacxMCWB1O/2Amk7asM0QrqFEcZSxGWjx103Lr1OTKgHYUsJj0ImKkb9gS1Qb5yu5
 A0FxltvpCktW8jYqsX/RSAbwZsyavmEP1rHCuNIMGgloS2ricY11c/GR11gzqHLu8Tw3
 vt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756726537; x=1757331337;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2ydF3eBBLT05orvArgEiXLs4Qlc5lLSPeNeohwBsc0k=;
 b=fSXpMly0PQL/DsORpZsMMLE9Q1DSDVBFBSh//mWyKGRH4Z+QW2rWwUqk9ZR1AXge8v
 X0c+cz/UcZzdngPIf3nW6IpbKtwgUlYOxTKZz9CSyDfQs2SDHlQ4P4Z9yw2lKEMMTM2R
 M7ON/FkWKcgx2Nw4QO5/imTYDIwxcE7NxY+MEcksa0LvVGLoR+8SOZT6egCFZ2oUYMLG
 4T+DZZd8jEM72aElM5o147RSvn4ibLrzMzpdTZfrgXXcxFZ4POA8srILWr21OJ75UcQf
 Bezo6p25q0BAmFKN+Nbau1F8ZHXh5bxCZjIjUsmUdgcksLoh5HlzvozP8w+c+Zr4GeXt
 JUGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKRUtp2p1M9g1pjxxBkc052i5UZUH8Z426wLR0Sa0jRI4uW+HHgBSLwi+WwQUFx3LVFWzX/iTsWokT@nongnu.org
X-Gm-Message-State: AOJu0YyAIwHV2bK+P39PoeTz5gBbyvLhsr4iJQTlX3xZeEmRs9VFl/8P
 JeIlQKJBn1Lx+NQxedFn40EJyHHH/DsG1mhlxZ5vyZaCG/qFKfzZ+i10Ufkk7g7nMnI=
X-Gm-Gg: ASbGnctHIq4eJv+vf8OV+ETKqsye39yvJCtq21tEu81GdtGo4kf2FfnrHthiV1rauY4
 IXukkhCuzt54mbckdqZ8nuCWwwbWFL8yfN+tq+955zkHCVYuDEP+KPY0To2I/GwtRugQ+RUI2oy
 XjtyVGhi/uBqoLX2gaoFsxvPjZ9Khwr+t7EJUd5+7qRpZBJWcC7b9Ud1eMPMOb2rvKCTVqbCwV5
 bnPO3WX9NRsstyS7mVrMG1v4khdVVwgYjJ5J2K3W1nVyYq3RzX9Ek9zUJ6ygvtpQTwyWwCUkI+H
 f+JUxbEFO2fUfd5rlFqi+VMRBLpNnOE1cQNLez3xum7nCChRG29FzDRFDK9EeJsdoyAmVHpXFZU
 iIO5ugcbJBcSN3elfAXfqibQDc8gtk3nzT9uRXIobtfLdn9U0EIBt/CVRpCV42wpbe+UIVWbex6
 MF
X-Google-Smtp-Source: AGHT+IHMSktGVOZJDBpTtnV3GtYVniOuwPFd7AUfnxkWfrs11m8i3d4n1gQNmSwKPRSqyrwEoB/LZQ==
X-Received: by 2002:a05:600c:a4c:b0:45b:7bba:c7a6 with SMTP id
 5b1f17b1804b1-45b85598aaemr57404905e9.32.1756726537492; 
 Mon, 01 Sep 2025 04:35:37 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b87b38fcfsm49909745e9.0.2025.09.01.04.35.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 04:35:37 -0700 (PDT)
Message-ID: <87f22e89-945d-43b8-9fff-48959674c00e@linaro.org>
Date: Mon, 1 Sep 2025 13:35:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] treewide: clear bits of cs->interrupt_request with
 cpu_reset_interrupt()
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, richard.henderson@linaro.org, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-2-pbonzini@redhat.com>
 <c81b9ccb-179a-4858-96be-b9b4baff1232@linaro.org>
Content-Language: en-US
In-Reply-To: <c81b9ccb-179a-4858-96be-b9b4baff1232@linaro.org>
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

On 1/9/25 13:23, Philippe Mathieu-Daudé wrote:
> On 29/8/25 17:31, Paolo Bonzini wrote:

BTW, missing your S-o-b ;)

>> ---
>>   accel/tcg/cpu-exec.c                |  6 +++---
>>   hw/core/cpu-system.c                |  2 +-
>>   target/avr/helper.c                 |  4 ++--
>>   target/i386/hvf/x86hvf.c            |  8 ++++----
>>   target/i386/kvm/kvm.c               | 14 +++++++-------
>>   target/i386/nvmm/nvmm-all.c         | 10 +++++-----
>>   target/i386/tcg/system/seg_helper.c | 13 ++++++-------
>>   target/i386/tcg/system/svm_helper.c |  2 +-
>>   target/i386/whpx/whpx-all.c         | 12 ++++++------
>>   target/openrisc/sys_helper.c        |  2 +-
>>   target/rx/helper.c                  |  4 ++--
>>   target/s390x/tcg/excp_helper.c      |  2 +-
>>   12 files changed, 39 insertions(+), 40 deletions(-)
> 
> Good cleanup.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


