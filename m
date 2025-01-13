Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727A6C02183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 20:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQqe-00034i-1E; Mon, 13 Jan 2025 15:15:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXQqT-00032x-3x
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 15:15:34 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXQqQ-0001Xo-0e
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 15:15:32 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2166f1e589cso98837855ad.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 12:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736799327; x=1737404127; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jok5TFWkxjvFxrhDzJJepVefflGzTmcAaNlIEo8m5xA=;
 b=u22uEkLxZuer+XMbxkZTyD2jd1mTl6sLgLvZbcL3iMIB8hcy57B8QrUQJUY42tyjn9
 AZrER1hwOJmE3Z+CPx+e+4WlAX3Hxc4EjbC40TdH/phvwmTdHVIV1eySc7jJgVAd/zp5
 MuJpG+3ryWGZK0FqcnIIqgVlm6lbed4TiiXGnzqYSkndYmAYlnkI2VdOv0VSa07WKtuV
 OlCC8kqrdILkr9abG2BoWPzFt80falmlCW51ZzsszevlU598YtFxMPjqgB0eGTBB3C70
 ip978iaj+UWnlkcHxXfIZqeMzghzxIWuspqWal0az/jPH4i9ThDzcFgLRgawkwxyFbQF
 RlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736799327; x=1737404127;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jok5TFWkxjvFxrhDzJJepVefflGzTmcAaNlIEo8m5xA=;
 b=noP6+lzWNkOuL8wlj87Bqiw5HMVZ4rce179o0Ert1oOtVdCKEwqsSggiN+lASl7KfG
 T7K7iPjLLq8hOy/ET32NVOXy+NX2evWDvz26hvGgHAkxB00YxZJyCUNtwN+t825nxCHK
 u7vmSXOtSHBLE6bmULkdEyQMfOSPe7tfWSc6+7Y+xIXfnTQlzIapRhbCCuw2LUTLjdti
 FPA9Dc+3yGfL8R5RmaMhl8MpGyHZ240aX7hWZbCPQp/0GeciE0xEDGx/VJHK11OSs/Ed
 E5jKH7aqAgkFLnSDVOuYzg5QFhdYeM+r61h9D5Zgd4z1nmvdLDDV949ypqNnS/MFnRpe
 GHeQ==
X-Gm-Message-State: AOJu0Yw4hnbMqKo8Sxfq/H+vjjxzysllq/eDxE5SbxK4lrP3bHlK7VHW
 CAY5wSjVI2OfXRRE5pOzIpsXyjC6Y9WQgfA1uZaAODHYWYszqFcvp8XxRilrActiIzOJ4IJgIkj
 dmy9uFw==
X-Gm-Gg: ASbGncueB0QWYuWiQnWtN2yOahhlJNiNRfeJjN8FpMOhWHttvPWPCTeTvHsyJTE9JyO
 KOlOS9M2HWv9wz99wuQX16uvxIkD9GxeFehNJpfSxpWDzbZqJmGq1X+HLNmDUZ2YG9RTszaJZYi
 /HCj+53arwwbjJHfUoxZC+Mm5CLioBbzTtgyLEublkMeZn8SIKYCuxY0DtbmHjn48iwiXLQTRsv
 bOh4D7uF64ZbVMWw+LjrSHKijZDqnc1DvydKwop+GATcG3x2hcRQE1/IvgM81dr8EBKAw==
X-Google-Smtp-Source: AGHT+IEYTN8ffsSwmjrHeZH3LsJjgfWnN96miImNiwji//eL24qr8ccl+q5r/Hs4nifik+zwzXAG3A==
X-Received: by 2002:a17:90a:da8e:b0:2ee:b0b0:8e02 with SMTP id
 98e67ed59e1d1-2f5490ac09cmr31280515a91.28.1736799326695; 
 Mon, 13 Jan 2025 12:15:26 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f5593fead5sm8185401a91.11.2025.01.13.12.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2025 12:15:26 -0800 (PST)
Message-ID: <a9b0cec7-2d2d-4f3c-8c07-588aed491920@linaro.org>
Date: Mon, 13 Jan 2025 12:15:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Change default pointer authentication algorithm on
 aarch64 to impdef
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Fabiano Rosas <farosas@suse.de>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, alex.bennee@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
 <CAFEAcA_ChARwKyvRXsEk1U3q1T2528753Eu7LgDSsDbF1s5tNQ@mail.gmail.com>
 <CAFEAcA_SHz2a0ZU=3e9AmZyJ_qn3e7nNhNm-hR9MdiTRjOyqWg@mail.gmail.com>
 <359e6921-fe3d-4f53-8ba9-5cf2b7ab6a6d@linaro.org>
In-Reply-To: <359e6921-fe3d-4f53-8ba9-5cf2b7ab6a6d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 1/13/25 11:32, Pierrick Bouvier wrote:
> On 1/13/25 04:34, Peter Maydell wrote:
>> On Fri, 10 Jan 2025 at 16:28, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>
>>> On Thu, 19 Dec 2024 at 18:32, Pierrick Bouvier
>>> <pierrick.bouvier@linaro.org> wrote:
>>>>
>>>> qemu-system-aarch64 default pointer authentication (QARMA5) is expensive, we
>>>> spent up to 50% of the emulation time running it (when using TCG).
>>>>
>>>> Switching to pauth-impdef=on is often given as a solution to speed up execution.
>>>> Thus we talked about making it the new default.
>>>>
>>>> The first patch introduce a new property (pauth-qarma5) to allow to select
>>>> current default algorithm.
>>>> The second one change the default.
>>>> The third one updates documentation.
>>>>
>>>> v2:
>>>> - ensure we don't break migration compatibility, by using a specific backward
>>>>     compatible property.
>>>> - added some documentation about migration for arm virt machine model.
>>>
>>> Other than a minor change to the 3rd docs patch which I'll note there:
>>> applied to target-arm.next, thanks.
>>
>> I just noticed that this series breaks 'make check-tcg', because
>> the pauth-3 test is explicitly checking the output of the
>> pointer-auth operation. I'm going to add in this patch, which
>> goes between patches 1 and 2 of this series:
>>
>> Author: Peter Maydell <peter.maydell@linaro.org>
>> Date:   Mon Jan 13 11:42:57 2025 +0000
>>
>>       tests/tcg/aarch64: force qarma5 for pauth-3 test
>>
>>       The pauth-3 test explicitly tests that a computation of the
>>       pointer-authentication produces the expected result.  This means that
>>       it must be run with the QARMA5 algorithm.
>>
>>       Explicitly set the pauth algorithm when running this test, so that it
>>       doesn't break when we change the default algorithm the 'max' CPU
>>       uses.
>>
>>       Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> diff --git a/tests/tcg/aarch64/Makefile.softmmu-target
>> b/tests/tcg/aarch64/Makefile.softmmu-target
>> index d08d9b01ded..9c52475b7ae 100644
>> --- a/tests/tcg/aarch64/Makefile.softmmu-target
>> +++ b/tests/tcg/aarch64/Makefile.softmmu-target
>> @@ -91,6 +91,9 @@ EXTRA_RUNS+=run-memory-replay
>>
>>    ifneq ($(CROSS_CC_HAS_ARMV8_3),)
>>    pauth-3: CFLAGS += $(CROSS_CC_HAS_ARMV8_3)
>> +# This test explicitly checks the output of the pauth operation so we
>> +# must force the use of the QARMA5 algorithm for it.
>> +run-pauth-3: QEMU_BASE_MACHINE=-M virt -cpu max,pauth-qarma5=on -display none
>>    else
>>    pauth-3:
>>           $(call skip-test, "BUILD of $@", "missing compiler support")
>>
>>
>> thanks
>> -- PMM
> 
> Thanks Peter.
> 
> I'm a bit surprised because I ran all tests , and didn't find any failure.
> 
> I use container 'debian-all-test-cross' and ran 'make check-tcg'. Is the
> container missing something that doesn't trigger this test?

I found that the build step I was using:
- ./configure $QEMU_CONFIGURE_OPTS
only builds user targets in this container.
But failing test is related to a system target.

I updated this on my side, to make sure I won't miss that next time.

Thanks again for the fix.

Regards,
Pierrick

