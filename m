Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA147D1D48A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwNN-0003BC-7V; Thu, 08 Jan 2026 15:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwNK-00039N-EE
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:12:54 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwNI-0000js-Uk
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:12:54 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-29f1bc40b35so41712885ad.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767903171; x=1768507971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KhMfWxqSZzlJtBxKgXeqxk2yt3R16sJrE7uipa2FreU=;
 b=vDTqqVwll8XIclUO+qGpQND1xL1d1t5i/YMlwOHAzbvAFxyu6rhZGRzbCEKtqNwxar
 +uZplrQRDzdS6xfDkSQKjqK5s+BF7K/FnRwa8P8Dm7ZmtZeKY0dPHUX9d8g2mU9p6tIh
 TZqUdy+cFw690SaJ4oxaJ9cIlV9K6/IQgYHTm+PVPT2c3bZILfZ2OgalsSAEWkNhyqfS
 YHKD/EJ6r1OFPTLCRBTDOT10gVsHGx52iNb6jDB6mP0AiSTRZ9GEKl30FpVF3UHZuUi9
 mvb2AYEXotGggsGNQolKWpM94m7bgVKxgoJ/cmVC1IRm7QgJ1JHkQ1hcwpqpTeoqAWlt
 MNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767903171; x=1768507971;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KhMfWxqSZzlJtBxKgXeqxk2yt3R16sJrE7uipa2FreU=;
 b=pNAeHvTWO3/cKEsObQvnz1qWl6taHO57ar9RXTX9Ncdk2UraRjlzQrRaF1oBlibVxd
 dnrb2uRRGd4pbGDU6x0cKMOSu/GeiTJmZFBv72DWP8nhdkXCHqd5wzsFLtuBasmOk623
 3J3kC92NX2Z98XxMs2KLTMizxEX9BYjsgAU/DuLnGcE+daRR42UMMx4kCDCDdlVMmYAR
 2q2+m95d3z/uU9jrpv5a6g0ubj9t/t1gukxm4SpRDJ0y+gmiSR28QBeyaK+g2HIhD8EV
 1ANSlNMqe17v4UcCpVBw+xyOZAUfST54C6SSNQt9QABgjhQPU7GPd3/YJTtjw3eTTy22
 b0CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIOZfD7RG8JdPCBaKY416ATG1d42bf3Uf7lgnC3sG/bo6Yqo52rjQTQLLk619MfUUa22uKmVrhD0Ff@nongnu.org
X-Gm-Message-State: AOJu0Yyxl+zWZuupZWr8E0oULXGbZG4rgfmdunJpMEJmyC66ynmz2OWm
 CH8TFC+9GHg9THcR3TVYu4ioHSd7zn3DDSbyBVgU0/TOlX+KHv5/u/m/sRaVA0zDdtY=
X-Gm-Gg: AY/fxX6fy4BM+ymPgWhs34OoEsgq5p8qhKgQ2pm+Z87JGytVkxfey9uP3FwAIGbGVe2
 sJ0yxzPJ0ICy+rUb9mt8z4+NR5e1oHVul8ozg2dqLcoha03leME/QlSIH0NRVAPr7U+1HXLI5l4
 jS0Txs0QhB1X+pHbLskuQag8B6OD7xyt7pefYFW12oPTNs+p22gRx2rf8lwjke0iHIlhaHd+V5r
 pJQCahLVRECY6vBDKh2LU7TOU1/5E9IZJeXdd+Qj+Ref+Ix8qSjt9AGwCfzVYETWXcIhUOebEdd
 lzL1aECk/UJ+6KrX2svUY1xz1hrlUHyRDcZZSEhBg6C0n8fxJkYANep1DBIsVfmScsASj9+GaRI
 /NRBj3FIFQns59D6Q14qcZifZ0Ju7PCHSU6T8PnqK71GDpcgudIOlNcbH+J68D+qNHiycEcBzNv
 3h/kN2d9H8MLnpqmrq0VbNjD3mydZdBPeIejcSUiwHA0fKeMr+o6Xkotbh
X-Google-Smtp-Source: AGHT+IGQsL6fAyHTQEvW/1DqR/7JfpECjtA7HNp9Jy4x90mi51JszynWL7izXmS7T53Ub2kghFOs4A==
X-Received: by 2002:a17:902:cecb:b0:29f:2b84:652b with SMTP id
 d9443c01a7336-2a3ee484c56mr75763695ad.29.1767903171405; 
 Thu, 08 Jan 2026 12:12:51 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cc8d76sm85778335ad.84.2026.01.08.12.12.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:12:51 -0800 (PST)
Message-ID: <90150853-24b3-43f7-a50d-400293cfc8d7@linaro.org>
Date: Thu, 8 Jan 2026 12:12:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/50] meson: Remove cpu == x86 tests
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-9-richard.henderson@linaro.org>
 <fe780bfb-11f4-46f6-a40b-4aa5e233f88d@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <fe780bfb-11f4-46f6-a40b-4aa5e233f88d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 1/8/26 1:50 AM, Thomas Huth wrote:
> On 08/01/2026 06.29, Richard Henderson wrote:
>> The 32-bit x86 host is no longer supported.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>    configure   | 16 +---------------
>>    meson.build | 49 ++++++++++---------------------------------------
>>    2 files changed, 11 insertions(+), 54 deletions(-)
>>
>> diff --git a/configure b/configure
>> index 00e455be57..846fab904e 100755
>> --- a/configure
>> +++ b/configure
>> @@ -440,13 +440,6 @@ case "$cpu" in
>>        linux_arch=arm64
>>        ;;
>>    
>> -  i386|i486|i586|i686)
>> -    cpu="i386"
>> -    host_arch=i386
>> -    linux_arch=x86
>> -    CPU_CFLAGS="-m32"
>> -    ;;
> 
> Ah, it's removed here, please forget my previous related comment about this
> in an earlier partch!
> 
>> @@ -300,9 +296,7 @@ else
>>    endif
>>    accelerator_targets = { 'CONFIG_KVM': kvm_targets }
>>    
>> -if cpu == 'x86'
>> -  xen_targets = ['i386-softmmu']
>> -elif cpu == 'x86_64'
>> +if cpu == 'x86_64'
>>      xen_targets = ['i386-softmmu', 'x86_64-softmmu']
> 
> I wonder whether we should limit xen_targets to x86_64-softmmu now?
>

The i386 target still exists, and it can be run with xen on a x86_64 
machine, so I think it's supposed to stay.

> Anyway:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 


