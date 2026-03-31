Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A1DFF60F1
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7VBM-0001gQ-1Q; Tue, 31 Mar 2026 05:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7VBK-0001g3-QJ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:14:42 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7VBJ-0002o2-6z
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:14:42 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-486ff3a0fc1so49110835e9.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 02:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774948479; x=1775553279; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PTI1lNAHwXLvHOavXN6hxUHvOTTzBYQseQWDlBBJNaM=;
 b=JHeKL2BiIz3UeGz16P5MTGox/s75y3vbA9ZD2relky7oRo3x+SXwEx40p4lvSXJvir
 +aA6DfwEFihZJzIWxWcnUQFMJTGqCkdRA+mK6xnX1PKJL7/vTbjPvjLXl5sd/OIeEPyU
 bmQxzb3fgWg90y0N7n8ctAfyz7nSOIvq8ExZHVWtiLN2dMkcvW4OD/h8dqdBBGufTKXX
 1gMFD86LvDGYnfkPykJ99vq2LxX7FxZDHxjjW2JXQKI1YKIrsX10FOKXMmn6WkMoRVBa
 uu8m5RHKKTNpoWQY6xM/V0hx18YM5Piqw8IP8RLCMSAm7pJNO8xnYQfq61vZRByLMXVv
 +P1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774948479; x=1775553279;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PTI1lNAHwXLvHOavXN6hxUHvOTTzBYQseQWDlBBJNaM=;
 b=smh7uI09WRMXjXgMdjaAtERhgNqnNsQZN+9KTMSglHpYs5Mc+CwWnPSiok8e8kt7Oq
 RODs2m2ISk8yIOehHb10QbVKqZk3XBgrRLUt9FwyKrd0KeWpz4lkq0XtLG5p+0zwsZ7S
 8cRtxP1aXeac9LItBGCRobfIUbKVF945zSghlF2r7KYEAdZhHy7aKvSCeSoJf3ZQKXgc
 q+W9CqxM3JO7frNzrHtHQzczY1wd2w7yMXRxHDx8gVQGzYWD/5YYDx3LXgo3eJQU78mA
 VaGjhi30I9ajR40ra6lQ9KQZkK/D/hlvC6DYE0lW3Z3TPpUBuFOV/5xJNpTdQ6Dwz9Nw
 34Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFBFhfCYdSthOdkhqEO6qvpfv0MCKuV2mFSnqcj6drcrwUXFKxheLrj9wEXScD0Wpr8LwvOdLuLIG0@nongnu.org
X-Gm-Message-State: AOJu0YyzmQt7+jnwG8r2qFrAcCFmDNdII8dcejd3qL5izWStw4nHjMQe
 MUlc3CBuGl12qDQgwfG2jh3tOu2n/3jt+QukFt7kmnYwXdq5br/cUtAeg/GuTi8hxnY=
X-Gm-Gg: ATEYQzzsNLZGJ5sJXglEaJ/sSsNSLJQVdLC23ZxpqkkkE2vxywXe+mntSbwQbsmpKCa
 eHYokgp9x5Jz7tOU7npNvNPV30/8jP/KQVZHrnQ0cJZgWVGWP6d7reCDIuUDvKHzY1Ri4Hm/zIq
 PKtT/Mn/exoHIvBsqCL/PRt7paphzeB46dNl4luYBCuXISi+JQhBoEd9mN6XTSQSFpVH8yCDc/Y
 07oNptF7ZKLvWOvsaA5UZGPqjeLmcmStgqawXS5j2GhTruRIZ3eLHAwRXwn1fEQlj1ul4Uywo9y
 lrMW95z5/Mxk7SN9x0GA3+fEszPBcXvCyZps3WYgndRs1zLF+9eZXlrnS1I/r7BD2JLFT2VYd8w
 0u39ThyS2pUpYrQKfZ9IRp5mDuBf9XjHBqqZhZIWCtvS7LghPTi6uk3zif8nwwQNCk2ssBiBSUQ
 CEIrCL9sYOTPy8ZfvuGPeXZlsX1e003Ft1ca/NOBGFPD0mo9BxSD8SKE87AQ==
X-Received: by 2002:a05:600c:c87:b0:486:fe83:8621 with SMTP id
 5b1f17b1804b1-48727ede17amr267811305e9.23.1774948478670; 
 Tue, 31 Mar 2026 02:14:38 -0700 (PDT)
Received: from [10.193.39.66] (43.149.216.82.rev.sfr.net. [82.216.149.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e81a2cesm24950835e9.8.2026.03.31.02.14.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 02:14:38 -0700 (PDT)
Message-ID: <e3ec8476-27f3-4c92-a48e-2665425e0580@linaro.org>
Date: Tue, 31 Mar 2026 11:14:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] hw/pci-host/astro: Add GMMIO mapping
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20260330211859.19317-1-deller@kernel.org>
 <20260330211859.19317-8-deller@kernel.org>
 <9aaf1736-c355-4ba6-b6cb-6bdd03930eb2@linaro.org>
 <5b6b67e4-6a2c-454c-b30a-0692496b640c@gmx.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5b6b67e4-6a2c-454c-b30a-0692496b640c@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 31/3/26 00:29, Helge Deller wrote:
> On 3/30/26 23:56, Philippe Mathieu-Daudé wrote:
>> On 30/3/26 23:18, Helge Deller wrote:
>>> From: Helge Deller <deller@gmx.de>
>>>
>>> Implement the GMMIO mapping.
>>
>> As this point in the release process, this is a bit out of scope IMHO.
> 
> Well, no...
> SeaBIOS has to initialize GMMIO at the same time and report
> it along with LMMIO and IOS to the operating system.

Then it is an incomplete/broken feature, not something buggy
that can be fixed in time. Anyway, not my judgement call, so
feel free to ignore me, just I don't feel confidement enough
to review and test that implementation for the release.

> 
> Helge
> 
>>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>> ---
>>>   hw/pci-host/astro.c | 71 ++++++++++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 70 insertions(+), 1 deletion(-)
>>
> 


