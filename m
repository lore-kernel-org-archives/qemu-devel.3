Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0053E77183
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 15:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNDCi-0001hx-FV; Mon, 16 Dec 2024 10:40:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNDCh-0001hm-8E
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:40:15 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNDCa-0002zP-O5
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:40:10 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3eba50d6da7so875169b6e.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 07:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734363607; x=1734968407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uraAge8yPMarUwxubRojb2vedNF55rEATzfhwxH+lmI=;
 b=Od4wLN7QDyYoNRHQuE1dG0WkXEhdLRt69rxBqPNnJB3F6uNdkgFr8qtQr5US79XKzj
 mfiCZB9WvU3MH6pR0YZnoWuDbwxjHb0LJritmRAaTSA5foOvdx9GvJ8bG9BGibTKyjQE
 V4dSxZPQ5Cf/eBIt4asSNZ23iBR89FRbzggy85DSd3EpkzejmreApXFf1B5QBySmwOUO
 zsl42cSSxxvOx/ipl6h/hAdF2xxZA01I5gJjQJSQpfhN+MF0JI7d73vwZUQHEYHja4Tn
 KZ5z4BsyCmw6tnqZ5p+H9gzwZD64y1sLYIXOILRwo91q4yKvyZrF8LLq4vp1YgkgNfS8
 1mLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734363607; x=1734968407;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uraAge8yPMarUwxubRojb2vedNF55rEATzfhwxH+lmI=;
 b=LBElOqEBmlwCgmpZRC4+CyAcOWKYY/E8/M223Q8HbR8BX7oYYnEJz+BQFMtYYZKI51
 p/fdhonwCVnDZkTBDT8utV6uyOJvpqhs7dgRMyHnItPU4/utEel01nFQNLxHrTDei/tw
 HVU9RrQWZviS3eIUk/A20CsPXI0HpoluA2jggcSjyj2qtmfTuNHTLp6cqJZ68nCVsS9e
 AbI/q6ksR1E43n5gBcDV/XoOH0ezuvjTCwvWo32nLAcnqXoCii3ZtUtdw0/+e0+fFKWE
 N1RpLcUzaZDCKyvtNFbiczDgaQS0uIw2VexGQ+VQ/DP+z5Vhq7EPDosXICfS5cZOmv0O
 Ea3Q==
X-Gm-Message-State: AOJu0YwaptNop7z19jwUVQIHuwRbjiVny/wQPQSEfPQdREwOltLSVrHF
 /fEegD3dSEBxfmQBVLOIpNBCUbHbTMcxahYU5LP5lgqzBdNYhXQiP1kx8cUEv9s=
X-Gm-Gg: ASbGnct3h+J6QY6CN+Y3ee55eF0PKLOl73t/uAELFcIgLemk4MGexuIG7uxNjjkUj/h
 2DMpXJL7XFgT1/UhQO3ANrni2pmiUtgDD/CrIH8hESzGJXvZTNzvgIolkrs80ypubq81eXk/Huq
 RXmHA8u4CUNwv4G6pfU5cYlp/PjxnpH4bDfaixTB9zvq4ZD0jrsz7xmi35QVRd2cxFBadXPldSw
 +3c478BU1K/D2IqCCuPnKIoI5KZYEq8kGeNxLseOIi3p82vst+5cZQ2qpbeqrF8Af4c8N6VzG1H
 qtFdgbTC8z6qbrz/TL7r3LvfH2kVYmpNk2w=
X-Google-Smtp-Source: AGHT+IEJqO1mZ7O8Wr8s4n9QlZngLjcjESucLtdQ6PL/hghp9TPGmXRXDrWgIZRAhr6aIfMsn4za7g==
X-Received: by 2002:a05:6808:181e:b0:3ea:4b7c:eb5d with SMTP id
 5614622812f47-3eba698322cmr7023529b6e.43.1734363607365; 
 Mon, 16 Dec 2024 07:40:07 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb4968303sm1572800b6e.54.2024.12.16.07.40.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 07:40:06 -0800 (PST)
Message-ID: <f1a2bd4e-5678-42d6-9ea0-cdc602757a06@linaro.org>
Date: Mon, 16 Dec 2024 09:40:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg: Do not use inttypes.h in
 multiarch/system/memory.c
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-devel@nongnu.org
References: <20241010085906.226249-1-iii@linux.ibm.com>
 <59b7a93e-7acb-4a73-9aae-bbfb36101c5d@redhat.com>
 <4f0cab2f2d564037e1a36a75ad1fb9d350c0f0e1.camel@linux.ibm.com>
 <727d4d4f-a299-4cdc-9723-c6b943d526ab@linaro.org>
 <5d1097953195fefec40d5d00e480d2697d44deac.camel@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5d1097953195fefec40d5d00e480d2697d44deac.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

On 12/16/24 05:26, Ilya Leoshkevich wrote:
> On Mon, 2024-11-04 at 11:34 +0000, Richard Henderson wrote:
>> On 10/29/24 23:29, Ilya Leoshkevich wrote:
>>> On Thu, 2024-10-10 at 11:20 +0200, Paolo Bonzini wrote:
>>>> On 10/10/24 10:58, Ilya Leoshkevich wrote:
>>>>> make check-tcg fails on Fedora with the following error
>>>>> message:
>>>>>
>>>>>        alpha-linux-gnu-gcc [...]
>>>>> qemu/tests/tcg/multiarch/system/memory.c -o memory [...]
>>>>>        qemu/tests/tcg/multiarch/system/memory.c:17:10: fatal
>>>>> error:
>>>>> inttypes.h: No such file or directory
>>>>>           17 | #include <inttypes.h>
>>>>>              |          ^~~~~~~~~~~~
>>>>>        compilation terminated.
>>>>>
>>>>> The reason is that Fedora has cross-compilers, but no cross-
>>>>> glibc
>>>>> headers. Fix by hardcoding the format specifiers and dropping
>>>>> the
>>>>> include.
>>>>>
>>>>> An alternative fix would be to introduce a configure check for
>>>>> inttypes.h. But this would make it impossible to use Fedora
>>>>> cross-compilers for softmmu tests, which used to work so far.
>>>>>
>>>>> Fixes: ecbcc9ead2f8 ("tests/tcg: add a system test to check
>>>>> memory
>>>>> instrumentation")
>>>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>>>
>>>> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>>>
>>> [...]
>>>
>>> Thanks for the review!
>>>
>>> Could someone please pick this one and also [1] up?
>>> Both patches are aimed at improving the situation with the test
>>> builds.
>>>
>>> [1]
>>> https://lore.kernel.org/qemu-devel/20241023131250.48510-1-iii@linux.ibm.com/
>>
>> Queued, thanks.
>>
>> r~
> 
> Hi Richard,
> 
> I noticed that this patch doesn't seem to be in master yet. Could it be
> that it was overlooked, or is there some issue with it that I missed?

Sorry, I'm not sure what happened.  I must have made some mistake with destructive branch 
pushing somewhere.  I've queued it again.  :-}


r~

