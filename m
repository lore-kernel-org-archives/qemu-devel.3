Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E203CD3E77E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SSy-0007Yc-Rq; Tue, 05 Nov 2024 17:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SSt-0007BW-2G
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:55:59 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SSr-0006Ff-Da
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:55:58 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso53293705e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730847355; x=1731452155; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hTnJj25eeK8NPPfgmb/bc4XCMhwrCci9uGcKOx7Ci2w=;
 b=aAJ0IhBvgKliAjlKbUBXq+nQd2LpqwmCMyNWqZVfAg/aawhumaSJYytH5Od83vdFfj
 CAJqEevKt9ga8yst1S6PnFo9ciGHEGpZ8UqWWFBI6Mf/DlrNAJraKJfyVqLoMY2Ib1HJ
 QVNneSI1KE6Md7m8DXCoYa7XgVKufQCCgs+julbYxnoivo6ok9xpGQVqrCD6skvRYQNU
 CqZx4ANLa18ymqQrZgs+lGc572w2LtLBFic5lplHV0OBNkR5baKr54MTz9HM3C371rfF
 sibQlvXPsaRQ2yERJFA+uAUqirxVU9HIcKlHjxt6LbkhQaJ1fPlsMT995iwjFKlQ7rQ3
 24HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730847355; x=1731452155;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hTnJj25eeK8NPPfgmb/bc4XCMhwrCci9uGcKOx7Ci2w=;
 b=lrgtrwJ5J6AOmEeGDTXi34/NYgs4KDDjy+uxPH8rzHTnWZXd9afiQYkwoaZQv9U5Mr
 zZF8S1+IJDGPz/MKwjeDi5Pm8EGag6SyOoSiiNAwwEafx6k2GEiwlZ/L6Hn2RHUDDY9j
 PKWQEELuNw8HG9mA0DKlBd1pg9MGznReIAjBJMbPBIsYIEmVL27mrMGMHjOHASwlP/U5
 WQAfg5XMXdpHTrAkAaWVr8Qj5vkFCBbGtkj912NHPAks5ttujjBPCzs09r+yMe8LdxZb
 5NJW+DgYDUlijRefUB25Dck6D/EfvM62gM1e8Ma1MghaT3jIckmCgqT3nTkWTozmmpPC
 vfng==
X-Gm-Message-State: AOJu0YwaRGj4wlActtUjCEbBbkM2tlZk8KboAjgTX36vaaPvJUUBjp5I
 oOySYS/iEqAF2m44dG2a44mvvgdX4radUrbCK2/8lIQwihkCGwTUoT+seOeAxUg=
X-Google-Smtp-Source: AGHT+IFHxhge1ZorXaw4QEuoqaTEsOwyy89Vxr9FhDJSvA+uMeOUUatNEHOfDTUkNtH4L1rWcsmpPg==
X-Received: by 2002:a05:600c:45cc:b0:431:52a3:d9d9 with SMTP id
 5b1f17b1804b1-432831cb2ecmr151285905e9.0.1730847355612; 
 Tue, 05 Nov 2024 14:55:55 -0800 (PST)
Received: from [172.20.143.32] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a2732e10sm23890835e9.2.2024.11.05.14.55.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 14:55:55 -0800 (PST)
Message-ID: <edcb0654-bb2d-4b39-9a7d-8c4d5f384618@linaro.org>
Date: Tue, 5 Nov 2024 22:55:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/riscv: fix build error with clang
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Bin Meng <bmeng.cn@gmail.com>, tjeznach@rivosinc.com, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, pbonzini@redhat.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 peter.maydell@linaro.org, Cameron Esfahani <dirty@apple.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20241104222225.1523751-1-pierrick.bouvier@linaro.org>
 <CAKmqyKN+mYMRqA7=Tb+-qNr_b7TQ8rapaB_YDPqjgKWAggeygA@mail.gmail.com>
 <a9c03f45-13d5-49ef-9c26-f3ab81c5932f@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a9c03f45-13d5-49ef-9c26-f3ab81c5932f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 5/11/24 05:29, Pierrick Bouvier wrote:
> Thanks for the review.
> Feel free to pull the patch in your next PR, so it can be available for 
> release 9.2.
> 
> Regards,
> Pierrick
> 
> On 11/4/24 18:37, Alistair Francis wrote:
>> On Tue, Nov 5, 2024 at 8:23 AM Pierrick Bouvier
>> <pierrick.bouvier@linaro.org> wrote:
>>>
>>> Introduced in 0c54ac, "hw/riscv: add RISC-V IOMMU base emulation"
>>>
>>> ../hw/riscv/riscv-iommu.c:187:17: error: redefinition of '_pext_u64'
>>>
>>>    187 | static uint64_t _pext_u64(uint64_t val, uint64_t ext)
>>>
>>>        |                 ^
>>>
>>> D:/a/_temp/msys64/clang64/lib/clang/18/include/bmi2intrin.h:217:1: 
>>> note: previous definition is here
>>>
>>>    217 | _pext_u64(unsigned long long __X, unsigned long long __Y)
>>>
>>>        | ^
>>>
>>> After a conversation on the mailing list, it was decided to rename and
>>> add a comment for this function.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Fix queued via hw-misc tree.

