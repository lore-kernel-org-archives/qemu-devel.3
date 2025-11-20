Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1CBCF857F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 10:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM2GY-0003ut-5F; Thu, 20 Nov 2025 05:51:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM2GF-0003tV-Kh
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 05:51:37 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM2GC-0004k7-60
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 05:51:33 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42b38de7940so346405f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 02:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763635890; x=1764240690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1M/18t6moVlkRgWVwoPcK84uBvdA6yoMjg+D+edbTko=;
 b=wfSc+JgJ0dI7VOXGQZ+KxVreJ+fO9QOTpcR9mOc0tauYvgoulOvQ+o2cWdaPdqcsEq
 Jw+lE0nxDogD8auAyXVkuooER8BTCmmOWt3EAWfuDvc5Pr+Kl7zqeEGTefScxP8tJnrq
 VIe9S3nQThB5+3xcsD30sNgXOt/EbUwJupk3Fx9WpOVImJJUQBs5bqMuOlrB3XDXj8/b
 2ygQ7W5NzGybYIGcXJOEMgyUPw/AkRno0kMi7Wqk4jYloDQbKvpyjKdhNnBEpraNYQkp
 GbO4qK401M2S2pca29OuEoC+Ub80PGyxjStn7svYq8N5y3CENRneph6iGz40H3WbghRf
 n3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763635890; x=1764240690;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1M/18t6moVlkRgWVwoPcK84uBvdA6yoMjg+D+edbTko=;
 b=YGz6nC/QyvUFzH+5Cj/GOAFTca0samvwxCnkGnXaI8wnxyML+P2DPaFNyYJKCV36sd
 NtvJOZvkKMbDWUQqZU6nUefUeeIbjJDgWqTTikrI8xj2TJq0KqPdPrtwu8DSqiyZqtm5
 0kQVNriNwJ4Yb6xJRQcHvOeit1JQH+l+cp2qU8XnqVva1g0PsdZ7kOyjb49W93bxjQQV
 b+ejYvkl5ekkjqX1Ve8jn8mn1GreITkBmxnVIcubYZZfEv5dvRYpUD/LGYSsYMAXOTZN
 MJuc98nyMgw+LaV2uRW7mpuRi4T0Uc45SfTgu++XtSn6STkUvcbYKPb/6arhKQUvhfOP
 8a2g==
X-Gm-Message-State: AOJu0Yz8hsSlROncS3TByxQT2BSSzOGYDUKlcftDxknv9MUVkRwqpvwb
 AlP62hTgXG90qyh+4vrFVvE+P9YkWeBrhNurJNJeBqdz7iTes/sxWGx5kC0soFprQJM=
X-Gm-Gg: ASbGncs7xrC+wXMJX7E3fR1GjooincModkoS5B6JCvXT1JbafAkvr3T+sMTe2T3Kulg
 AGm72S9IhFMKVNGDwOHiWkZE13NhB1BLMyMpH3vV/E6DRNUxge8t1yrLR0Y22AOktBQG8Uav4OW
 aMYsIZNrA1kpQIoKyGKcdWWHYrh++PleyKXbXmmgTmbUT1+V4WIBEqgzLFzUCsJE18PlXyuXTsf
 gm74yINz5jdM1JnvQ/+Ogac+DcEFjO/pK/u1+d/ilarXsL7/Bi+j11cPnOL6bGENrzJZrMx3JSw
 mk1s2jaYSFI6+pv6gFG3/hpUTUfp+gMxCgjT1LsKz4o+pmq79gdwtCkd1taFCLPB+EdFQN1mWtz
 WX4aPbvreZfv1T6PSgnbqAwbT0X49o/vyTrRi7VvGzJpzXMyXhcejYlTWlgNF06ee5mYtwyet3b
 pZdsHrplxiI9JZKkSaOmc33UMH+LFgAPiDm8mGjX8lNeDKUqf7P0XC+Q==
X-Google-Smtp-Source: AGHT+IF1uX4P9Ldl1MKPWCI4CVFASAXHm93mBmH2oSNKZDSuBThVvq6LdHNkjvPuApS7MKVFsJt3HQ==
X-Received: by 2002:a05:6000:228a:b0:42b:3131:5433 with SMTP id
 ffacd0b85a97d-42cb9a2decbmr2359371f8f.26.1763635890108; 
 Thu, 20 Nov 2025 02:51:30 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb9190sm4912620f8f.33.2025.11.20.02.51.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 02:51:29 -0800 (PST)
Message-ID: <ab69153d-b162-47f2-90c9-22cd248c94a5@linaro.org>
Date: Thu, 20 Nov 2025 11:51:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/core/loader: Make load_elf_hdr() return bool,
 simplify caller
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 gengdongjiu1@gmail.com, peter.maydell@linaro.org, alistair@alistair23.me,
 edgar.iglesias@gmail.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 palmer@dabbelt.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, sstabellini@kernel.org,
 anthony@xenproject.org, paul@xen.org, berrange@redhat.com,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com, zhao1.liu@intel.com,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, xen-devel@lists.xenproject.org
References: <20251119130855.105479-1-armbru@redhat.com>
 <20251119130855.105479-2-armbru@redhat.com>
 <bf44d9cd-806a-4d2c-8cff-0a88222959ed@yandex-team.ru>
 <875xb5x2ds.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <875xb5x2ds.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 19/11/25 20:12, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 19.11.25 16:08, Markus Armbruster wrote:
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>
>>> ---
>>>    include/hw/loader.h |  4 +++-
>>>    hw/arm/boot.c       |  6 +-----
>>>    hw/core/loader.c    |  8 ++++++--
>>>    hw/riscv/spike.c    | 10 +---------
>>>    4 files changed, 11 insertions(+), 17 deletions(-)
>>> diff --git a/include/hw/loader.h b/include/hw/loader.h
>>> index d035e72748..6f91703503 100644
>>> --- a/include/hw/loader.h
>>> +++ b/include/hw/loader.h
>>> @@ -188,8 +188,10 @@ ssize_t load_elf(const char *filename,
>>>     *
>>>     * Inspect an ELF file's header. Read its full header contents into a
>>>     * buffer and/or determine if the ELF is 64bit.
>>> + *
>>> + * Returns true on success, false on failure.
>>
>> I don't really care, but IMO, it's obvious contract for bool+errp functions, not worth a comment.
> 
> Nearby function comments all have a "Returns" sentence.  I try to blend
> in :)

New developers might just have to look at a particular API such this
loader one, without knowing the global errp contract. With that in
mind, I'll documents @return everywhere.

> 
>>>     */
>>> -void load_elf_hdr(const char *filename, void *hdr, bool *is64, Error **errp);
>>> +bool load_elf_hdr(const char *filename, void *hdr, bool *is64, Error **errp);
>>>      ssize_t load_aout(const char *filename, hwaddr addr, int max_sz,
>>>                      bool big_endian, hwaddr target_page_size);
> 


