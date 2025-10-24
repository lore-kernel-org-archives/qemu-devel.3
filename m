Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AA0CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 12:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCHCM-0003GI-Af; Fri, 24 Oct 2025 08:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCHCI-0003CV-0Q
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 08:47:10 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCHCF-0008Pa-BU
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 08:47:09 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4283be7df63so886463f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 05:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761310025; x=1761914825; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nzH7c0etDGBlNJ2iMVoTd2g9FZa+ihLhuhIhZ8ERDQI=;
 b=HSQjQflTre+kfZ7nCppecs3fkQuVdSntOjEoJqRYPhqYt1r777QBzeFYYHwgJYd9CF
 SQO+1ZgqtwQWwCVRG6eybAp2T8RzeigR1ou7KCWqaYt8Q22FQaqC/5jcKsalTmWUooZf
 Nr7u/HFu52Y3g3Jn4mXt26Sf6xPO81VgFwFAf/Sf/KlENH4pGTLnuyFg6Qs/pqUkYk+p
 4406NrZLdTEBH6ZNZpYji+a4PVSwXKsJszMSoCwPZEJHoIg6SgzrJUKjkfMwDlxGiJsR
 b3p8kwug6smj58zWJzbpeWpXoirY8Jsy/DCj4J0grXylBOOAGap+El/W+S8Xyg8GxxGq
 Jwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761310025; x=1761914825;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nzH7c0etDGBlNJ2iMVoTd2g9FZa+ihLhuhIhZ8ERDQI=;
 b=ljAzdj6Jw1qlXiup/UBFQUNWOPGxYGQ5wYpCQ03hHa6RZbzHN1DOVNIoY6uLzoqu9H
 B/h/nvfB1MkwMbSBSNv/T574gR9eBm0+Q+4W/38vp106V8B2Pek+/elyN128k2avMxy+
 wq1nbXHMTIK4S6eOUywjq6JJV1Z5pf96sNkhdr2VsWdUkLhgGKsTZUdAED31ejIsfTqB
 kPLADKYIEMERS0L7aRaqd8WLm2GSfcvP7kox41KuZxLhKwnW8saCpkkUy/n2hmCJhMII
 DwWd8uYvg9nD6xVC12aeWvPa2/08Q8CoBJTa2oaxFkBsu4azNY/nfgVNbtOqH1/WNZ8c
 15GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmlVY3Aoc37Bu8lmzQyTQoCXqm0rTDYE4UQZZ5mXkqY7zDb0HW0w4reZkKq6jOtZr8eoUKRBkGl679@nongnu.org
X-Gm-Message-State: AOJu0YwWUVrYMiykGz/9Id0JYf12wVWm6J/Ez1yP1wrfgAEIJ4IQASff
 f7IjD7U8UOaxacdjaxEt/bYlgSRpaoNM+bb1u0Z3TiTphE7YRPhvgUeqolikNSm8fVg=
X-Gm-Gg: ASbGncs9xnfMte8lJzJrD+AyAGjs5Pi4gtC1kaex9Fg4lao1PDJ12VPQCc6LRh3Kat8
 T7KunU7VjyngV129IVOJ8OXy2IF89NWqNtVBvVdvzib5VblBfbfYP5pz7dpBoYmlXenpp4x+jyn
 xnieq+IEnloolXVqabjIQWyaW9er5I7W7udfacHngyiY7n+RfRfGc/Z2wDUvFSPxvmaH942Pa0w
 W88PwkP3l+daVUI9DOja/YRkDO7r4Rub5Z5GviEHUO3gAJz1pH+enfgM4o6L5FECzNo4DZNGLMr
 +lzzMuCl+JKO7XorNcaT30pHTmjg5lnXnl6k12Erh4zSKJw3Yu8xoJOB3KZjDFGAsBZ/E5Etnpw
 dy5KGmaVWNlPZScF0+K6yq4FZQwiuCrhxo7nlZxjpgZ6AE85GJmXGDnKuNp/OTSpi4KDUK04/a6
 +RzPfHtyQTxyRJXkinNirQPztY1tLtPm4cmXpbBtuNYL3GOmQ6NBp0Bg==
X-Google-Smtp-Source: AGHT+IHezue8uVzvBOWg0rWfzCNvIbboqlYjObIPLldT5ZNU8TUpyqC8GTASMbU5wttEVICkhQmj3Q==
X-Received: by 2002:a05:6000:2f83:b0:3c7:df1d:3d9 with SMTP id
 ffacd0b85a97d-42704d99325mr21071219f8f.39.1761310025191; 
 Fri, 24 Oct 2025 05:47:05 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898acc6esm9001643f8f.25.2025.10.24.05.47.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 05:47:04 -0700 (PDT)
Message-ID: <75aa6f52-4bf3-4e07-a8ea-29bda1cb42a7@linaro.org>
Date: Fri, 24 Oct 2025 14:47:03 +0200
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5c2da466-1e2f-45be-a3be-d1dbcfaba8fa@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 24/10/25 14:11, Vishal Chourasia wrote:
> Hi Balaton, Philippe
> 
> On 24/10/25 16:55, BALATON Zoltan wrote:
>> On Fri, 24 Oct 2025, Vishal Chourasia wrote:
>>> Add error checking for lseek() failure and provide better error
>>> messages when image loading fails, including filenames and addresses.
>>>
>>> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
>>> ---
>>> hw/core/loader.c | 16 +++++++++++++++-
>>> 1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>>> index 7aca4989ef..48dd4e7b33 100644
>>> --- a/hw/core/loader.c
>>> +++ b/hw/core/loader.c
>>> @@ -79,6 +79,10 @@ int64_t get_image_size(const char *filename, Error 
>>> **errp)
>>>     if (fd < 0)
>>>         return -1;
>>>     size = lseek(fd, 0, SEEK_END);
>>> +    if (size < 0) {
>>> +        error_setg_errno(errp, errno, "lseek failure: %s", filename);
>>> +        return -1;
>>> +    }
>>>     close(fd);
>>>     return size;
>>> }
>>> @@ -129,14 +133,24 @@ ssize_t load_image_targphys_as(const char 
>>> *filename,
>>>                                hwaddr addr, uint64_t max_sz, 
>>> AddressSpace *as,
>>>                                Error **errp)
>>> {
>>> +    ERRP_GUARD();
>>>     ssize_t size;
>>>
>>>     size = get_image_size(filename, errp);
>>> -    if (size < 0 || size > max_sz) {
>>> +    if (*errp) {
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (size > max_sz) {
>>> +        error_setg(errp, "%s exceeds maximum image size (%" PRIu64 " 
>>> MiB)",
>>> +                   filename, max_sz / MiB);
>>
>> MiB is arbitrary here. This function is used to load all kinds of 
>> images such as ROMs which may be 64k-2MB or even executables in 
>> generic loader that can be a few kilobytes. This might result in 
>> errors saying max size is 0 MiB if the allowed size is less than a MiB 
>> (e.g. amigaone PROM_SIZE = 512 KiB) and integer division discards 
>> fractions. Do we have a function to pretty print sizes or maybe this 
>> should be left as bytes or at most kilobytes?
>>
> Yes, for images sizes less than a megabyte.
> Perhaps we can leave it at Kilobytes
> 
> I will send out another version.

If so, then please use qemu_strtosz().

> I will also address the *errp vs size<0 comment from Philippe.
> 
> Thanks,
> vishalc
> 
>> Regards,
>> BALATON Zoltan
>>
>>>         return -1;
>>>     }
>>> +
>>>     if (size > 0) {
>>>         if (rom_add_file_fixed_as(filename, addr, -1, as) < 0) {
>>> +            error_setg(errp, "could not load '%s' at %" HWADDR_PRIx,
>>> +                       filename, addr);
>>>             return -1;
>>>         }
>>>     }
>>>


