Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4CFC36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzXD1-00073c-O3; Tue, 01 Apr 2025 04:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzXD0-00073I-NZ
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:42:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzXCz-0002ET-08
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:42:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so37093065e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743496975; x=1744101775; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RyAi7PW4u5nACp5HzUwobdOGKsb//ExYQOdMUc8F5uw=;
 b=RWxyYA4tjfxFZxCqJeDTbqxglBb83kU8E/n2wQNfxcVlM3KZr8+vbM+JltZPwzNU8h
 YmIa7W9JLR/Z58jqYD610WC+SJ7LFq/CRQ441QTunUOJ3fiSEpCoorD3Vge6L7+O1cLD
 VrQysre3iPgAYr6C7fF3CgCTDBSSZuQ+SqfNBlKqqzjWd/3pyFj4HiYCVfu42JHeCLwj
 tXGs4GiMrR9aBmYIYJEwux+YanwjdPY0vi8UrdfquwwKQs96U7ZyQbSTaDnCnaMcKPMU
 aprM+j2KGzCCeyHqlzUFQ/j5Z3B78x5b+W7uFrYc7eLmZcTkn6WEUzUu5EmrBiBegvKY
 NISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743496975; x=1744101775;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RyAi7PW4u5nACp5HzUwobdOGKsb//ExYQOdMUc8F5uw=;
 b=vjDe3zGrgPVgA0hU+eA3j9w1gJG8xCUL5iLvyuET6lxIZiorORPIZRuweAs2ahvCBK
 sUyNv+myhx99nFbW3nXc7qrra8ymc7HWFz5qdaJnGl/kgukiWbH3dwI2p00nDTgR62L7
 S8JFXsRqSlfLOpA1wCRs210nczuh+Ec6yT/KmAIMt232FDoHHyyTyCtuhKb1prhuFzLu
 EWbI6XvFB+smWCaR8naNAzbvbj/3Im4vpCiACpcNfLtSW4dxykoz/6OpLtT3LkFIXeSO
 O+eJ7wekFjHLf2FxsMz4QgBeYAXGGGYCFsEwDpKcZV0Q3mLX2+0oY3M3NyX3x84ULHik
 T3RA==
X-Gm-Message-State: AOJu0YwbNqIdoXIN8bBs6VQawypiYsC0JWmN8sx+D1gTlHz2d80rfJ92
 tujyLU+7WvK5Wrqt16DxYBSfk9gk8MRCR5JLXnBuucsTXRmm+Pk24KcH5rYwzCg=
X-Gm-Gg: ASbGncvRCFL88KkYX7YqtJI16mHnAZJmV3c6eaW0CE7I5pjLbxpdd3C3Viw8VNWbO/J
 koZpFvcCDIqHu2OC1w63vQag7MPFU/bUEfkIbVQUTCPwK3FI0l83wY9jCJHZ1swcjyyZ9my4ZL+
 zdWrzyGTApKzOsmS0Cc0S1y5nqqlDtdUQH92iJHY7KhbMAtCWLfDP2PnyCGyLDWqzBiXLERV9Ij
 JsqqliG4X0iXoi0lxGcVcIPqkFFzZyZC7qx7+MMH9HNHCXsZiA/1Ncp7o4xTwfF1p0NvOXPeosC
 yh94WbtroIQsxL/ZgwfvitqkA2/WaYQLB+aqYsdq/Tn4pfSuAoJ72r/lHCFxaC1ZSngp6KJgDyu
 1yYM9mKUpw7G3
X-Google-Smtp-Source: AGHT+IGLwXeP0puRBlobzZDu+SdkPm05ZvxZoct//bxW4Qy7Wxe71aopdVvV+WEYNdMWywqBxY3OGQ==
X-Received: by 2002:a05:600c:c86:b0:43c:f050:fed3 with SMTP id
 5b1f17b1804b1-43db61d1becmr105830605e9.11.1743496975184; 
 Tue, 01 Apr 2025 01:42:55 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8314b9e9sm191048925e9.37.2025.04.01.01.42.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 01:42:54 -0700 (PDT)
Message-ID: <9fc09597-7df5-4094-89b5-8b736a419f7e@linaro.org>
Date: Tue, 1 Apr 2025 10:42:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] accel/tcg: Option to permit incoherent
 translation block cache vs stores
To: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250331155423.619451-1-npiggin@gmail.com>
 <20250331155423.619451-2-npiggin@gmail.com>
 <baa70d58-d599-4b81-9333-7982b82f1167@linaro.org>
 <D8V5XAKJ9ZYN.12HHKNW227769@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <D8V5XAKJ9ZYN.12HHKNW227769@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/4/25 10:34, Nicholas Piggin wrote:
> On Tue Apr 1, 2025 at 5:51 AM AEST, Richard Henderson wrote:
>> On 3/31/25 10:54, Nicholas Piggin wrote:
>>> Add an option TARGET_HAS_LAZY_ICACHE that does not invalidate TBs upon
>>> store, but instead tracks that the icache has become incoherent, and
>>> provides a tb_flush_incoherent() function that the target may call to
>>> bring the TB back to coherency.
>>
>> We're not going to add another target specific ifdef, as we're working on removing all of
>> them.  If we were to add a feature like this, it would need to be done another way --
>> probably via TCGCPUOps.
> 
> Sure.
> 
>> How much benefit did you measure for ppc for this?
> 
> It's noticable, I'll get some numbers.
> 
>>> XXX: docs/devel/tcg.rst says that this is not permitted because TB must
>>> be coherent with memory to handle exceptions correctly... I'm not sure
>>> where this is, maybe it can be worked around and is not a showstopper?
>>
>> I presume that note was for x86.
> 
> It is actually for RISC it says. But it is very old so may not apply
> any more.

Commit 998a050186a from 2008 =)

