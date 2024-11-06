Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993DFD29FB3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 08:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8bZG-00041M-I3; Wed, 06 Nov 2024 03:39:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t8bZD-00040f-TR
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 03:39:08 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t8bZB-00061A-Hi
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 03:39:07 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7ede6803585so482676a12.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 00:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730882344; x=1731487144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9iQwRWQz3sbPdtuIOsuxjy5ZLO5E38CiwHVxyC/5QA8=;
 b=iYF12NGH4F4RxptZq5JttFWHMQOwWSsNXulaWYjDo0cY3FPJXWEB1sdt4zDn7ou7lY
 CHPaTR977hyZ0guc7tK0MS61gD3x8EZjeueISXkVK+JZHyYULqzZSuAZmcNX1Cq2o246
 8+EkASlM+T8Qo6UT732Gf9Oe80FWlrBTNmvpnzqmDde2+FxE/SbewDkx5S6MdFK0iPdV
 9PHG4uAI43r531X4VfMWJgVSkp18MblxBTs0Yv+/UPRKb7hXzTzMVuK8qjLKLBsewXXX
 rHRGCH6k7VMBircgjsh+V6yVf3omhGWz2Ni1jnEcvDXfp45EXPWBPyVXMnv0OjtXQ60s
 PeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730882344; x=1731487144;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9iQwRWQz3sbPdtuIOsuxjy5ZLO5E38CiwHVxyC/5QA8=;
 b=YYVYYJtVjXLYhpRmQCAFuSkhJcKM18w7YXKIqe2LWTgKPS4SfQVrD1iYigDnI6Q/OG
 e9V0wlqPNkqMxqikF0XI+HUww7MqviBGYj1frcwfio55eu/iEopwKwQoXcEZFs2/48wH
 FhCiqOnPqRbGaVQQWxfX00hrSyO5WDmYZmh8+lEK6eSE5JAmRRniaokDztUYleE0TVL/
 LRHMJNI8H1dW57M6swHoUnjHkYj5akQTMvxwBXJmUyYu4uy0HvNZUOT4koVXdT00bn6b
 L7ap+18SLrKSzND0A3S8O8bIz3151H3BNUo5MAL7vYp1InWTcqSZTWj7gCE6zXnHdSA0
 ddTA==
X-Gm-Message-State: AOJu0YwPpdcUN9yvhbLwYmpNnm11OotmwJzqqeir63anMq9ZKUx8kafi
 jT8lF4WdPGAI8YfdSnUgw4abi77xkIb8Hx5ysQNEto/UplXxV48oH6mBlPjFYrw=
X-Google-Smtp-Source: AGHT+IE5qNex3nAU1KXW3Pi2fD8QAtSoakel3K9q+isu8f/DGh3d6nw+AybAmKBp1v2+U+SJIN09Gw==
X-Received: by 2002:a17:90b:4f90:b0:2e2:b94c:d6a2 with SMTP id
 98e67ed59e1d1-2e99956d0bemr2928933a91.0.1730882343842; 
 Wed, 06 Nov 2024 00:39:03 -0800 (PST)
Received: from [192.168.68.110] ([189.79.22.174])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a62bf50sm905084a91.51.2024.11.06.00.38.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 00:39:03 -0800 (PST)
Message-ID: <4bb3fbf2-7f0b-48fa-9b9c-39108e261d31@ventanamicro.com>
Date: Wed, 6 Nov 2024 05:38:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/riscv: fix build error with clang
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Bin Meng <bmeng.cn@gmail.com>, tjeznach@rivosinc.com, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, pbonzini@redhat.com,
 peter.maydell@linaro.org, Cameron Esfahani <dirty@apple.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20241104222225.1523751-1-pierrick.bouvier@linaro.org>
 <CAKmqyKN+mYMRqA7=Tb+-qNr_b7TQ8rapaB_YDPqjgKWAggeygA@mail.gmail.com>
 <a9c03f45-13d5-49ef-9c26-f3ab81c5932f@linaro.org>
 <edcb0654-bb2d-4b39-9a7d-8c4d5f384618@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <edcb0654-bb2d-4b39-9a7d-8c4d5f384618@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x531.google.com
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



On 11/5/24 7:55 PM, Philippe Mathieu-Daudé wrote:
> On 5/11/24 05:29, Pierrick Bouvier wrote:
>> Thanks for the review.
>> Feel free to pull the patch in your next PR, so it can be available for release 9.2.
>>
>> Regards,
>> Pierrick
>>
>> On 11/4/24 18:37, Alistair Francis wrote:
>>> On Tue, Nov 5, 2024 at 8:23 AM Pierrick Bouvier
>>> <pierrick.bouvier@linaro.org> wrote:
>>>>
>>>> Introduced in 0c54ac, "hw/riscv: add RISC-V IOMMU base emulation"
>>>>
>>>> ../hw/riscv/riscv-iommu.c:187:17: error: redefinition of '_pext_u64'
>>>>
>>>>    187 | static uint64_t _pext_u64(uint64_t val, uint64_t ext)
>>>>
>>>>        |                 ^
>>>>
>>>> D:/a/_temp/msys64/clang64/lib/clang/18/include/bmi2intrin.h:217:1: note: previous definition is here
>>>>
>>>>    217 | _pext_u64(unsigned long long __X, unsigned long long __Y)
>>>>
>>>>        | ^
>>>>
>>>> After a conversation on the mailing list, it was decided to rename and
>>>> add a comment for this function.
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>
>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> 
> Fix queued via hw-misc tree.

Do you fancy taking the riscv-iommu Coverity fixes as well? They're somewhat trivial and it'll
spare Alistair from making a PR with just a handful of patches.


Thanks,

Daniel

