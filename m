Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE127C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 23:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trQ7T-0004cj-TR; Sun, 09 Mar 2025 19:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trQ7P-0004cC-Bp
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 19:31:39 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trQ7M-0000ym-Ry
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 19:31:38 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22548a28d0cso31488985ad.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 16:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741563093; x=1742167893; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YS2rr9SoXAtjUZVrZOI3r9ah/SgoOeDyjFFUywmpf7A=;
 b=q4IMDZWY2/84J83a2b5JWTAdVFA2hjtypFSt6AhGJr8lYyBeM1Oks0Tv/vytCIfH42
 8mPyVc4WQvilsYqMLoPdzt1M1TlgiLDfrZxlcM5UvSwgsCPtrRaFu1IiUzbpXgx9wqB/
 4N70MVRMGptdDfgwsnZwWF1riTGYwnaE12ZWgaBXaqNjna7/j3OZW0Q25ZgbYvHNa6B8
 vPwxFpycC6P9eqyfYqrZdhhagH+DiSBiyWgGDMA6Fu75dSO5Sg5FBsC2xLIgQzDbIhWr
 4WANaWvRI+vioz9FymYoaOv4mmtV2syy0Y9fzlpFy5dc5fV4CVOSBi/h4f4KooM3fyQv
 ykZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741563093; x=1742167893;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YS2rr9SoXAtjUZVrZOI3r9ah/SgoOeDyjFFUywmpf7A=;
 b=TX4KlMiE1EjcFkL8GAHkeuCqOJs4cATZeQn+39hkqebt42ynOMM02GQOp8Cug0gqSp
 /LrOJVPGUkl7QI5tcc4uCwWYSd17NXWM/Mzctva4d9uVcM+LN+nlxFeXGyP7VyOY2tR8
 qDWd6xjfM8v9dhycx1PRLo6ppcgvko3ykcIXlgTOVyYpEcJynQjoEFsz/D6O5lQi2bnu
 AqKr66kZmjztrMd/3LctXXu2DU7V3myOBJSqBEaI48G9znulF0b8bqCCvsif2O5ON2T+
 7A80wf1qU45HCN7zz2vnONlVZdjgE8LWedRIMfCqIz/bnUP/i3m3QM5rtAA/pf9ILtDT
 AJCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFXWo62mf6VGrxRnP2gJb5zejGKw+7gQX0KwsJeo41qnmy+wFtyRy4KWWQ6gJ2d/RJKw/fLfIdRkW5@nongnu.org
X-Gm-Message-State: AOJu0YxnuojU1lj1R1ClPlGw8bHkRvtebSPouFsnaf4+fym0IyT2mb/z
 0q4cOy0RVqxpuoTv93Poqb+Ixj6B3yf2g/L0T1XsC7Q39gDXpVTh1MEpHNZ8FVJ1t2NM6wJQQ75
 S
X-Gm-Gg: ASbGncsWb44OiWwNl5rVRF+CV3Eydm1NQ7WJGkHWzedPZOxiF4O2XPS3pkLTOISDesn
 oE3Gy/HHys4sTow+mZpbDAFxsRbgGm3Mn7XS1+RA2g83vgKa2ABtJ2FLYU1a3PamTkWEVk/rJ3Q
 KCBqZtScLk9PQeE3YIGQCBSZC4jwewsNeTBXPKp3nmhtNHsDaURVOSCPmtr+uVbtftWzkrVGyf1
 +V/sMhjdRfPzvFoFRDlEG5BjtcoXy8+tSrQ7KHTiJToNwgzklRV8HvakErpdCh/FYydN1foYlTY
 Pxgp36HEEkhfDGDGJ1Zq/+c517Zpm7RvUjpdPLTtnsCQuDYHOUWZO9BT7g==
X-Google-Smtp-Source: AGHT+IGoEjCrAlwIvxyCgmbsdbXI1EMy9DL5MtmXxDg1TR2P7rQPEOeZMBoE1RMuLg2XPpbxFJovGw==
X-Received: by 2002:a17:902:e543:b0:223:28a8:6101 with SMTP id
 d9443c01a7336-22428a9fe42mr139307135ad.29.1741563093646; 
 Sun, 09 Mar 2025 16:31:33 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109de255sm64826155ad.45.2025.03.09.16.31.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 16:31:33 -0700 (PDT)
Message-ID: <65c8d1b7-17dc-4682-8a09-a165d4161802@linaro.org>
Date: Sun, 9 Mar 2025 16:31:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system: initialize target_page_bits as soon as possible
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20250309193712.1405766-1-pierrick.bouvier@linaro.org>
 <172cb398-4859-4ed4-9e1b-9f05a88de6f4@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <172cb398-4859-4ed4-9e1b-9f05a88de6f4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/9/25 16:12, Richard Henderson wrote:
> On 3/9/25 12:37, Pierrick Bouvier wrote:
>> Allow device init functions to use it, which can be convenient in some
>> cases (like hw/hyperv/hyperv.c).
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    system/physmem.c | 1 -
>>    system/vl.c      | 3 +++
>>    2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/system/physmem.c b/system/physmem.c
>> index 8df9f30a0bb..c5fb784a9e1 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -3281,7 +3281,6 @@ void cpu_exec_init_all(void)
>>         * do this much later, rather than requiring board models to state
>>         * up front what their requirements are.
>>         */
>> -    finalize_target_page_bits();
>>        io_mem_init();
>>        memory_map_init();
>>    }
>> diff --git a/system/vl.c b/system/vl.c
>> index ec93988a03a..c64f8c8e808 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -2848,6 +2848,9 @@ void qemu_init(int argc, char **argv)
>>        bool userconfig = true;
>>        FILE *vmstate_dump_file = NULL;
>>    
>> +    /* Set target page info before creating machine and associated devices */
>> +    finalize_target_page_bits();
> 
> This is far too early, and therefore incorrect.
> 
> You have to wait until after all possible calls to set_preferred_target_page_bits(). The
> only relevant call is in arm_cpu_realizefn, invoked from the MachineClass.init, invoked
> from machine_run_board_init().
>

Thanks.
Moving it later is not possible in the case I was solving (assert in 
hv_syndbg_class_init() from hw/hyperv/syndbg.c).
I'll simply move this assert later, but if a device needs to query 
target_page_size in its init function, we'll be in trouble. But maybe a 
device should not have to use this information anyway.

I'll drop this patch.

> 
> r~


