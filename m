Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC2ACCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 13:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCHkg-0002yR-BY; Fri, 24 Oct 2025 09:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCHkY-0002sd-Bu
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:22:34 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCHkV-0005JA-Jt
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:22:34 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4710683a644so17287745e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 06:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761312149; x=1761916949; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RMOMosQl9MIfBuDe4FsTvoDMMN3T75GWwRSeAMfRXNM=;
 b=FJm7KmBHSTUT3HQMx72TfjTXcsM9SfAHni3V/NxVmqwEbflkxCw7XjBYgxeS4VIiN7
 ZR/CfJ1Qacm8imOBpNlD04rxk/srStztXhT4w2GF6IGcdpZtOhOl/5yUjR/EgqquxPQw
 Da99sjUeMRifMREpVJH6jzdel7k7clRoKllaqbHWS6fiJ2JZaHmI4QLsyzUqyxWHivVg
 Kz3VPs8PILVJsOkYm5XqTxSfdWVQvwWgXIxCYglTlmcHvCT+NxVCHNY69HRH+CAlySHK
 vQkcKt6WHWW5H//9leEd9efL3tGVbHnNpzkGmYDZyeOtFdr8Mk0GmQUL4+mSa1wRi2k3
 oMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761312149; x=1761916949;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RMOMosQl9MIfBuDe4FsTvoDMMN3T75GWwRSeAMfRXNM=;
 b=ZAnan3EC9QDmPi4UdvnNn8D12C+9gfvBqDGrDRTnycIVtzA4lJA5efwTYl7+/CmJnk
 9iBGOlpRiCqogAcg6iexbQQgEN/A86Sn/UAkNjg0qbM7msDvgGFYrjeWNk0R+gRIdn+h
 0Ot//7dk1HHLu6eNBJWuFGN0e652QUDb4CpLXTFjRmV8Hi+K5vDPZAfEsJ6SLY/J+q8c
 8xmOEghgEYHbnZlBx/y1UprvFnc92eYBX69YYPiiMSqK6gLHbvy+gzT52TwjdBTvkOoX
 jirWf+fhQw1n+RgT0+GdR3IxZ52NezDir++L6AXfFqFpCWCkWZ043t1LVYDxC+ydwtbE
 +AAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOH5m1Nrv/cEd2sn7fczbQRZ4eVX5HcWkN/WeyIK5sPmkclyHcb1oVAPFjlERHcI6ucTkwp1uTaoxR@nongnu.org
X-Gm-Message-State: AOJu0YwvkB00C3ALkGy3snISUOlfFcKe3PPyk6t4asWp2mJFx8BydOpz
 oNKII8dyP9krKpgZwlOsTSTmJW/4iy5Mol/H4uNkXzZoV3+8EEqaQQGT/96NwSAIwMo=
X-Gm-Gg: ASbGncsGbb0Lv1eRqNWbJHU5VN7f1XhiM7lABv4a8nSY5+ZBG2FTVtII8UCu+W6BJ2Q
 SD8hl6tPXtECjcdn9MBoHSxZLvMoYrN+f6aAJDZ0N76hVvYqDHxYxyqLxusIMPajThuDs42SqNv
 qNaf+0WIruL5e80as6knH0KTRdK3bbKJHxICTPV2MNSvBxYbK6xDNxdDzHOaiBmTKHwZrpHAeo/
 7efRIlV01DE1Yi4FtffT40HkxQp7aX7vUU2zpSkte3MBSDEK88sq397G+o/ECsiDCWBuifZP+1R
 kLNpua4P7++ID1PEbR6R5pmlvB14LHEs3nbgV0zMD43KMUr91kEGFnbCHCW1UXn3u8NbkSvRyQh
 ZF9JCZbRJMizgO68ISKiMk4AKnZyG8IL8hhwGtdWSETs5YBUUSOkncmT8h6d1RmcQ/eIPVGHZrv
 JeOGVvAIltbLzrasGf8RVr/MhtHdLNo1BrciA1RIulLinwStmKTuzX4Q==
X-Google-Smtp-Source: AGHT+IGWWisBwhPD9v42K/lZv+z8Afbxf3S7mpLhSCR15mbe8Rz3kKEWfmcDmTJLw2r0UOKnjha81A==
X-Received: by 2002:a05:600c:3f10:b0:475:d278:1ab8 with SMTP id
 5b1f17b1804b1-475d2781b2fmr22486665e9.2.1761312148884; 
 Fri, 24 Oct 2025 06:22:28 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475d8172443sm16204495e9.11.2025.10.24.06.22.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 06:22:28 -0700 (PDT)
Message-ID: <c76ee7b7-5eb2-4124-b70f-c437b787c241@linaro.org>
Date: Fri, 24 Oct 2025 15:22:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 3/6] core/loader: improve error handling in image
 loading functions
Content-Language: en-US
To: Vishal Chourasia <vishalc@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
 <20251024092616.1893092-6-vishalc@linux.ibm.com>
 <aecf60d5-8bb2-48bb-28b5-20b58729fb56@eik.bme.hu>
 <5c2da466-1e2f-45be-a3be-d1dbcfaba8fa@linux.ibm.com>
 <75aa6f52-4bf3-4e07-a8ea-29bda1cb42a7@linaro.org>
 <5bfb5c2d-5215-4ca7-9a8b-48f3520add20@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5bfb5c2d-5215-4ca7-9a8b-48f3520add20@linux.ibm.com>
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

On 24/10/25 14:58, Vishal Chourasia wrote:
> Hi Philippe,
> 
> On 24/10/25 18:17, Philippe Mathieu-Daudé wrote:
>> On 24/10/25 14:11, Vishal Chourasia wrote:
>>> Hi Balaton, Philippe
>>>
>>> On 24/10/25 16:55, BALATON Zoltan wrote:
>>>> On Fri, 24 Oct 2025, Vishal Chourasia wrote:
>>>>> Add error checking for lseek() failure and provide better error
>>>>> messages when image loading fails, including filenames and addresses.
>>>>>
>>>>> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
>>>>> ---
>>>>> hw/core/loader.c | 16 +++++++++++++++-
>>>>> 1 file changed, 15 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>>>>> index 7aca4989ef..48dd4e7b33 100644
>>>>> --- a/hw/core/loader.c
>>>>> +++ b/hw/core/loader.c
>>>>> @@ -79,6 +79,10 @@ int64_t get_image_size(const char *filename, 
>>>>> Error **errp)
>>>>>     if (fd < 0)
>>>>>         return -1;
>>>>>     size = lseek(fd, 0, SEEK_END);
>>>>> +    if (size < 0) {
>>>>> +        error_setg_errno(errp, errno, "lseek failure: %s", filename);
>>>>> +        return -1;
>>>>> +    }
>>>>>     close(fd);
>>>>>     return size;
>>>>> }
>>>>> @@ -129,14 +133,24 @@ ssize_t load_image_targphys_as(const char 
>>>>> *filename,
>>>>>                                hwaddr addr, uint64_t max_sz, 
>>>>> AddressSpace *as,
>>>>>                                Error **errp)
>>>>> {
>>>>> +    ERRP_GUARD();
>>>>>     ssize_t size;
>>>>>
>>>>>     size = get_image_size(filename, errp);
>>>>> -    if (size < 0 || size > max_sz) {
>>>>> +    if (*errp) {
>>>>> +        return -1;
>>>>> +    }
>>>>> +
>>>>> +    if (size > max_sz) {
>>>>> +        error_setg(errp, "%s exceeds maximum image size (%" PRIu64 
>>>>> " MiB)",
>>>>> +                   filename, max_sz / MiB);
>>>>
>>>> MiB is arbitrary here. This function is used to load all kinds of 
>>>> images such as ROMs which may be 64k-2MB or even executables in 
>>>> generic loader that can be a few kilobytes. This might result in 
>>>> errors saying max size is 0 MiB if the allowed size is less than a 
>>>> MiB (e.g. amigaone PROM_SIZE = 512 KiB) and integer division 
>>>> discards fractions. Do we have a function to pretty print sizes or 
>>>> maybe this should be left as bytes or at most kilobytes?
>>>>
>>> Yes, for images sizes less than a megabyte.
>>> Perhaps we can leave it at Kilobytes
>>>
>>> I will send out another version.
>>
>> If so, then please use qemu_strtosz().
> 
> There is another function size_to_str() suggested by Peter I was 
> planning to use it, as it was doing the expected job.
> 
> It seems qemu_strtosz() converts size strings to bytes.

Yes, they are the opposite ;)


