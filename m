Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A40C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 21:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ozz-0001DY-NS; Fri, 04 Apr 2025 17:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0ozw-00017V-TC
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 17:54:49 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0ozv-0002Z9-7X
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 17:54:48 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39727fe912cso1179781f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 14:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743803685; x=1744408485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JTni5fZeQAcr/r1PDYjVJlIxzIJmlvntKms+GuGROnY=;
 b=sVQfPna9tRxoHN9+ZuCOeuKysLmQm51ncvkP/0JWFT+YbD5z3iYP5DN+B/Zcn4vkum
 LtvCcBULtF3mbg/jkpD0KqL1o9LcAnw+ES3bX4GM+XgvQPwlcEe0SQREue7yW/6koGGr
 YxZCgAqXfgt36t4InQRJ/dJEPjYO2fw8GMmMwzE+wNNKSj/mrSzg8Ym9u3dGDEMFZP34
 5SV9pHvjrWAG0OWxI89q3Wz9tnse1rerQkGzXpcnobprCuIU/ov6BuqpfPruASCNweD+
 04oU8Xvdq7H191THVK0Y3EO50tYXrenC+2QaF9gUMdfUgY6EsW+ziP0JpwCoDMczFOv1
 4LIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743803685; x=1744408485;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JTni5fZeQAcr/r1PDYjVJlIxzIJmlvntKms+GuGROnY=;
 b=H4AJq6D+MdmokYaHx6oRjHQCZgZhE1cKzVaW/KquOo2Lq5SUMZpD9esgX0L0UDLife
 KLOiTucBJFw6bkLOxCPtouasVI7PdbgpZcRu8MKtYj1xiRh7iOOGjbsO6Te0ZqiHZDc1
 cYlbFBmNG2TtH/BOLl2dNxV0CTmw7vrpizsrR/FMlCTnSO2vnMSIcxV2R69t00INLfG7
 V8aqD59uIYLMdHbB36ZXtdfCDKVBx1swim+b18y1G4DnbBKdEsJFjcV+B8jO0yisAJN9
 FuxiSJO+rrE9l9RCYLiJs2GM0CNJX4K1Bz1Bd4xvs/ReZymeQ4AhQNOu5J3iOE9rYvrh
 6onQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw6YTFdqHG7SyBmpHR8RlZyKCN42iz39kvAVZJvNVHLNemzerPZ6bQwKM0ZExfFKNWWPjIG/JC8VDE@nongnu.org
X-Gm-Message-State: AOJu0Yw613I5SLnRmf95fl14L5/mwy2kNIpcaKYNKaeA/dnJAv35/ogv
 J5U9JM/2iDLH9BxZlfMVHa2TT2S5ffqfWZkRcYygnEf2cRElgbyhaV/YqWnlh6c=
X-Gm-Gg: ASbGncty88NV9NZ1cGsM0TGoN+uu9WggzZRqBjjlaiGguDxR50jmmPIXrwh/dwP66sm
 7wA2qRyX42IDB8PiT8qtGEdghkveMth/vXOVQWyCVMCV4SkDBkME1DTFU0KnMFeMJwQd/2KqdDq
 P6Qbr4kRaQGohNy3XJV2UTzmOkfhe4OWEwMrnkBpB+3/T1u32UzP0kKlOsnhf42dwBF286lyt5H
 Ub9pWX4/OwcWTKvloP1fJukXKX9U11aHE/M/mLqq3cL+CEO+jOxIun7Fzd9r6OoHYw4R3JTiGjI
 vsoG8zdHWUJHPFLXY9x6ScoLUg5u0Fylo+hQW4i8ewknx0U7iClvpeAt4UyOamS96R/GhcxFvFo
 VFp/6cJq/d+9llv071g==
X-Google-Smtp-Source: AGHT+IEX5hkiWt5Yeo/NmgeZnqRar49UsvVeHIIj1+h5uktKTU7PlfhMnLmnAMAAObrGZLWBz9Qskg==
X-Received: by 2002:a5d:5888:0:b0:391:412b:e23f with SMTP id
 ffacd0b85a97d-39d6fc295f9mr619596f8f.15.1743803685570; 
 Fri, 04 Apr 2025 14:54:45 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d661sm5447717f8f.66.2025.04.04.14.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 14:54:45 -0700 (PDT)
Message-ID: <49ff72e2-24ac-41a8-8aee-f923d9b48cee@linaro.org>
Date: Fri, 4 Apr 2025 23:54:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 20/39] target/arm: Extract PSCI definitions
 to 'psci.h'
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <20250403235821.9909-21-philmd@linaro.org>
 <09bd795d-e62d-44fb-b80a-374efee32034@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <09bd795d-e62d-44fb-b80a-374efee32034@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 4/4/25 20:21, Pierrick Bouvier wrote:
> On 4/3/25 16:58, Philippe Mathieu-Daudé wrote:
>> Extract PSCI definitions (which are not target specific)
>> to the new "target/arm/psci.h", so code from hw/arm/ can
>> use them without having to include the target specific
>> "cpu.h" header.
>>
> 
> Including cpu.h is not a problem to have common code (per architecture), 
> so there is no need to do any change here.

Again, this is an old patch from my heterogeneous PoC branch.
I'll remove from this series to not distract you.

> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   include/hw/arm/boot.h      |  3 ++-
>>   target/arm/cpu.h           |  6 ------
>>   target/arm/psci.h          | 18 ++++++++++++++++++
>>   hw/arm/bananapi_m2u.c      |  1 +
>>   hw/arm/boot.c              |  1 +
>>   hw/arm/highbank.c          |  1 +
>>   hw/arm/imx8mp-evk.c        |  1 +
>>   hw/arm/mcimx6ul-evk.c      |  1 +
>>   hw/arm/mcimx7d-sabre.c     |  1 +
>>   hw/arm/orangepi.c          |  1 +
>>   hw/arm/sbsa-ref.c          |  1 +
>>   hw/arm/virt-acpi-build.c   |  1 +
>>   hw/arm/virt.c              |  1 +
>>   hw/arm/xlnx-versal-virt.c  |  1 +
>>   hw/arm/xlnx-zcu102.c       |  1 +
>>   hw/vmapple/vmapple.c       |  1 +
>>   target/arm/helper.c        |  1 +
>>   target/arm/hvf/hvf.c       |  1 +
>>   target/arm/tcg/op_helper.c |  1 +
>>   target/arm/tcg/psci.c      |  1 +
>>   20 files changed, 37 insertions(+), 7 deletions(-)
>>   create mode 100644 target/arm/psci.h


