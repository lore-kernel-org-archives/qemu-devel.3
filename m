Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E1ECAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 12:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v12Kb-0004C3-Ge; Tue, 23 Sep 2025 08:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v12KX-0004Av-Mk
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 08:41:13 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v12KO-0001J0-5y
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 08:41:12 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46b7580f09eso16086105e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 05:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758631254; x=1759236054; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fylltS+b9l30N6vRuSwxtvk6XxZgtx+gRWoTwdHfxTQ=;
 b=EylF7PhQhrLFNn1qvWJ37yDeuovJTAL6T1OlvuZ5szehkiFhjXVJSqWjolARB5i47y
 KTmnYXfXNfSvg1GD4+EuzcIo6v4/my0/D3uJJBWNz423CTJO5C/OCgs0NgeMmrCQqGJO
 c8HHWva+xnMA8QnHFdHPmttj16HZbLG71AZUIxB0u988Tbt3LrhlBoHOdMi6KgopZMg3
 xCMzJoZwCvDBLN2LyRGx0Uw2vLKO/dHp4v06NVphsUnE//LwCA/yImaTY5C/HfHOx9nJ
 ArTcrbp+cSpQBIzwo6Ve9DhmDo0ECCNUoyLGgt9fLKgzOfAl3n5yZwI10p/00YhJ3eW6
 q5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758631254; x=1759236054;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fylltS+b9l30N6vRuSwxtvk6XxZgtx+gRWoTwdHfxTQ=;
 b=D+KeKvwOgDO5Y2oYScJH6k5CZO79rdwL0+Sj87J25TgQB4RT8igXTerNjKmoIZbwLQ
 EC3bhw4tcvHtKjC7J0PnjdKPBhDGV/ZGzenW2RyzhpOZslOX4tCHwto36G5fl+p9Nkmv
 hIScgBqGTEt/qsZ12QXMi3zcun907nz4BzcdmmhBaFcFl5GFVPtEEcSLA1lDCvttfDFD
 tgljwm/pOjmZFlixv/vFEPg5QCf6PaGG0cLlw5U8R0Rf0XNsrIZK1/Pe/MBWaYHELaiR
 fKptISv7bugUTr+AQClmyu7ucRUKWKDVv69ARtpNZem4I7KTxMp2zGVgdqF34YQDB58L
 qecQ==
X-Gm-Message-State: AOJu0Yw1I+w6nvzLFYwBYgToppkHOyq9eF7hFFgmm98Lh/pSP9L8dipc
 ROfsecXxOrpKy6s0SofUVmER/O7hOPzt762WoDW7BCsKzUL14le1CTnvgyZBYJb9Fvk=
X-Gm-Gg: ASbGnctLJx1AhGnGeqDIIrgumEDEkXm+datIg0fFKZcE9qzjZJ00kGHY+Iez250SrqY
 eQPEtOZw4LkH724VQxYj10mA9Iyij22J0bvEGXTZHnn3KCUwW48P8lwc8EJKD+3wAQp1UbdQn/v
 CRSvJKNS4meOlMWSZp3SYuc3mm902zfGpwzIx4e+6cpuuTa8r6CKUDFH8GzZ0PXCZXqlqwpFdPr
 M8a4VHWSuG2bOaGYYMs/RlNW7soXQvtsmL/12hCB/BrSiXqu/zda1OXQgXxTbpbegouMcdfx6GK
 ZsWx1SV99eV2jX2UyS+GWxKCFCnGJwUyDIlOQazCCXCjYNWasCUSG2O9Ml5b5kYAbUOrdeJxith
 auncOHLgvsArY8oS+G6hmMCeUt52idV8BcEowmlScFgkOWQC1kVYjSuAe0yfx6xPdCdyi8OIvq+
 L/
X-Google-Smtp-Source: AGHT+IHqvXHj6kCQbD5xn3M2nMVZu/BiGKXkJI+jOUM/PevHdwYZsZVHKhkyS6VEOcSQjmjXlxMdwQ==
X-Received: by 2002:a05:600c:3b82:b0:45b:8477:de1a with SMTP id
 5b1f17b1804b1-46e1d974657mr26156765e9.7.1758631254364; 
 Tue, 23 Sep 2025 05:40:54 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e1dc3c53dsm13165795e9.7.2025.09.23.05.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 05:40:53 -0700 (PDT)
Message-ID: <40c337f8-4bdc-4335-b004-357873edd99b@linaro.org>
Date: Tue, 23 Sep 2025 14:40:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/13] tcg: Fix error reporting on mprotect() failure
 in tcg_region_init()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 berrange@redhat.com, vsementsov@yandex-team.ru
References: <20250923091000.3180122-1-armbru@redhat.com>
 <20250923091000.3180122-3-armbru@redhat.com>
 <6ebc31f0-c6cf-4e14-a87d-5b59f6c6105f@linaro.org>
 <87h5wta071.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87h5wta071.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 23/9/25 13:16, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> On 23/9/25 11:09, Markus Armbruster wrote:
>>> tcg_region_init() calls one of qemu_mprotect_rwx(),
>>> qemu_mprotect_rw(), and mprotect(), then reports failure with
>>> error_setg_errno(&error_fatal, errno, ...).
>>>
>>> The use of &error_fatal is undesirable.  qapi/error.h advises:
>>>
>>>    * Please don't error_setg(&error_fatal, ...), use error_report() and
>>>    * exit(), because that's more obvious.
>>>
>>> The use of errno is wrong.  qemu_mprotect_rwx() and qemu_mprotect_rw()
>>> wrap around qemu_mprotect__osdep().  qemu_mprotect__osdep() calls
>>> mprotect() on POSIX, VirtualProtect() on Windows, and reports failure
>>> with error_report().  VirtualProtect() doesn't set errno.  mprotect()
>>> does, but error_report() may clobber it.
>>>
>>> Fix tcg_region_init() to report errors only when it calls mprotect(),
>>> and rely on qemu_mprotect_rwx()'s and qemu_mprotect_rw()'s error
>>> reporting otherwise.  Use error_report(), not error_setg().
>>>
>>> Fixes: 22c6a9938f75 (tcg: Merge buffer protection and guard page protection)
>>> Fixes: 6bc144237a85 (tcg: Use Error with alloc_code_gen_buffer)
>>> Cc: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>    tcg/region.c | 7 +++++--
>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>> diff --git a/tcg/region.c b/tcg/region.c
>>> index 7ea0b37a84..2181267e48 100644
>>> --- a/tcg/region.c
>>> +++ b/tcg/region.c
>>> @@ -832,13 +832,16 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_threads)
>>>               } else {
>>>   #ifdef CONFIG_POSIX
>>>                   rc = mprotect(start, end - start, need_prot);
>>> +                if (rc) {
>>> +                    error_report("mprotect of jit buffer: %s",
>>> +                                 strerror(errno));
>>
>> I'm not keen on handling errors differently in the same function.
>>
>> qemu_mprotect_rwx() and qemu_mprotect_rw() already print the error.
> 
> Yes: they call qemu_mprotect__osdep(), which uses error_report().
> 
>> Why not add qemu_mprotect() as a simple qemu_mprotect__osdep() alias,
>> then call it here, also covering the non-POSIX case?
>> (Question for Richard, after looking at commits 22c6a9938f7 and more
>>   importantly 97a83753c9 -- wondering about WoA).
> 
> There is no commit 97a83753c9.  Do you mean a97a83753c9?

Yes.

> I'd like to merge this commit as is.  It's a minimal fix, and it's been
> reviewed.  We can always improve on top.

Right (we'd need to map non-POSIX protection bits anyway).

No objection!


