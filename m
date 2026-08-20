Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51802C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 07:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwxZ8-0003wo-UX; Thu, 20 Aug 2026 03:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1wwxZ6-0003iM-RH
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 03:51:56 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1wwxZ5-0004yN-4C
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 03:51:56 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso15124205e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 00:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787212313; x=1787817113; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PhBK6YnNsECh8KigWIjCiZjoLxt1fp8hP0W1MkIlNMA=;
 b=X12/3yVBHdTdAa3pUUc4CStFBZ4jC75sOg0bamANeXe+WYsQdN1riUYZ8lZ/w31kZQ
 gZPBDRYL7NI+MuKfy3Hlc9d/VjmMCIjg/oDveYSf+yMqBpracTXMeWRQW5mvKMSB7rYy
 nBc1fwyTvZ75lQAgZbzifKNMttHqEgr9xx3qBhIPqcg8QwwRFuxnkylZ2mLzEFsvZlLV
 aehVnTld0gyBiaWYAXRCu3wXo7O3b6rD3ESqrXKDe8pRCpA3ObKhr4g09CIdXXKeNXdk
 ZQBHIJBQwKqcTvYDcNjLA/An9nwfXxNNMRmcJEIP0wAPKvGzuW1scp4qXYnM0EPdHOvw
 nTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787212313; x=1787817113;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PhBK6YnNsECh8KigWIjCiZjoLxt1fp8hP0W1MkIlNMA=;
 b=sxoTj2/yZaxGp7pYrNYFghQuGwU86OzKC8IEJAloNgcw/66e12GwSaWdNhv3DN53Z6
 nKVE8suCOCW2AzgeDP/JvnHie9NBxe9sxJ85CSDJev1mFpmg4PGH9dj1Vsk9JaTzqcih
 SxPNnJgRNGTsrqyivVAB4DYGlB9PQxxkBHA43czCcUB3Nk3V9hbsn167kw2q2NzJb62g
 CuBJXthL+8FI2D/jw6RuANCH2h/nOLP/sEN9fRuyKO+pPj4oHeppY8B4D0ftpMugwyNO
 O7czq90I9Xrm/EEP9Oil6VOr9yHGTedxgylXKFjm+8MgW6eWOBmVjtZVhK+1ToGFEw2t
 9fCg==
X-Gm-Message-State: AOJu0YwzgKcPCmjT0bpFb6zb33aoJU0fG+yr1SEzbIB1aO4V/67TtBF7
 c3OyKF+q8NlS3DlI35bieAKDiHlqaQB+m+nBuVdtJ27izZ/O7cE/2gylf1yU25ncpw==
X-Gm-Gg: AR+sD11w1xlWqxwlQqYW1yU1MKl6f7GXCxleexSKke5i5hlbvtBqpJCemkMr8UlcLKj
 XcggMUkmJ6Jhpo5qPdiyBAidIsfPk4jEtARMj1ZgzVNmH0s2hdHOR7SbOy+VPpDitfou1bXJAKO
 HMvuahd9B0mtLzwdc+WN4Isx/1QyW5uoCy506akIb91B5G53MMh+hcedLfN8HAh6dlesm3V1Xa1
 GZSK6EhoV/MPqIFM3d1Hha6Zvew85mCq/x3r3hNPrUB0t0nYADcom8kQmTVssQx6+BSv3S3Zba6
 A5kpzsz5wKVozYM+4r6LmS0yjF+hP93MEoAc3IRSN76CfIQoOU5p8F+JrmIZWbATP2ckKme5ggl
 B7niPIPsFnch2tLoWZg/Or7No63zdJ+vT2NcOpK7cRdtNrMQXL01OTLc1o1iD/HZp3Vg0G2vdbu
 HxrzMKPh6hAOs5j4E3t8kRVeu4hnU8yca3mduhcTDFutP41HrPsHugHdHd/shM/krZ9m1e8Pi57
 n1APH8+EpdTD7NKmAoQf8I9HuegOvM2XS6/D2VVH9i2hdNb7ySY
X-Received: by 2002:a05:600c:a012:b0:499:593b:a15b with SMTP id
 5b1f17b1804b1-499aa1431a5mr203011985e9.1.1787212313335; 
 Thu, 20 Aug 2026 00:51:53 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de.
 [37.24.206.209]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b20a14c6sm32137555e9.0.2026.08.20.00.51.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 00:51:52 -0700 (PDT)
Message-ID: <92022f85-9a53-4db8-b489-fc91c86b413c@suse.com>
Date: Thu, 20 Aug 2026 09:51:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools/hvmloader: implement Intel IGD extended VBT
 support
To: Chuck Zmudzinski <brchuckz@aol.com>
Cc: qemu-devel@nongnu.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>,
 xen-devel <xen-devel@lists.xenproject.org>
References: <20260802050824.10554-1-brchuckz.ref@aol.com>
 <20260802050824.10554-1-brchuckz@aol.com>
 <2110d4b7-ae37-47aa-99be-ab59e16f6167@suse.com>
 <67579eba-e222-41dd-84bf-8440d2eaf2a9@netscape.net>
 <da2200cd-def7-4cce-a6c2-9f9ac9e202ce@suse.com>
 <de56c8bd-f0e8-4fe9-8cf5-f6807698176c@aol.com>
 <02a7dc18-4184-4e86-84cb-121769187f71@suse.com>
 <1858e8e6-73fa-4017-93e2-c733fbf0ec8d@aol.com>
 <d6e603bf-8dc5-4ac7-842f-ff9d1f67b98f@suse.com>
 <fdec0b6b-eddf-4a36-a755-c67963daa9ea@aol.com>
 <6ecf80ef-2f0e-44fb-beab-dbcf065a4431@suse.com>
 <bb44067c-6739-4e83-a0fd-cc7ea797048f@aol.com>
 <4c58bda6-e9ed-438d-b96e-feda74a6c4c7@suse.com>
 <31a5870f-2a4d-4dc0-af9c-f0567e0f6fb3@aol.com>
 <db8fd04d-bbc7-41c7-8473-b821d7f77d5f@aol.com>
 <302ed12f-40ca-405c-80ca-ac4f2785d754@suse.com>
 <cdae1785-4d9a-4aab-929e-de55c26b7b94@aol.com>
 <10cd9f6b-678b-407b-a51e-70e9ed7a35fd@aol.com>
 <131b1252-b108-4b4c-8457-673ff0d20d5e@suse.com>
 <b14969c8-9676-404e-b7cc-ce13a6d7ff94@aol.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <b14969c8-9676-404e-b7cc-ce13a6d7ff94@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=jbeulich@suse.com; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19.08.2026 19:13, Chuck Zmudzinski wrote:
> On 8/19/2026 9:51 AM, Jan Beulich wrote:
>> On 19.08.2026 14:36, Chuck Zmudzinski wrote:
>>> On 8/19/2026 8:16 AM, Chuck Zmudzinski wrote:
>>>> Yes, I agree that v3 of the patch to hvmloader should presume that the DM can get
>>>> a copy of the OpRegion and read its contents so most of this can be done in the
>>>> DM instead of in hvmloader. So from hvmloader's perspective, the patch will be more
>>>> about avoiding the layering violation than anything else.
>>>
>>> However, there is one advantage, from the viewpoint of the Xen virtualization platform
>>> as a whole, to do the patching of the OpRegion in hvmloader instead of in the DM.
>>>
>>> If we patch the OpRegion in hvmloader as v2 of this patch does, we provide a common
>>> solution for extended VBT support for Intel IGD devices that would be compatible with
>>> all DM implementations, not just with Qemu. So why not do the patching of the OpRegion
>>> in hvmloader?
>>
>> As indicated before: If the OpRegion holds data that is needed to drive the
>> device, and if the OpRegion is exposed writable to guests, then guest can
>> screw up that data such that subsequent guests won't work anymore. Hence
>> exposing to guests (which includes hvmloader) needs to be stopped, or at
>> least be limited to r/o. That, in fact, includes exposing to any privilege-
>> restricted DM as well.
>>
>> Exposing r/o may be entirely okay (i.e. may not be a layering violation),
>> depending how exactly an OpRegion surfaces for a device (on the host). Aiui
>> it's not addressed by any of the BARs, yet it looks like it needs similar
>> treatment.
> 
> Yes, the OpRegion is not one of the BARs as specified by the PCI specs, but
> it functions more or less like a BAR region with the devices's ASLS register
> at offset 0xfc in the PCI device config space of the device acting like the
> BAR for that region.

That is, on real hardware a write to that register moves the OpRegion? That
would need following by the DM then, i.e. the DM would need to indicate the
original position in the register, and the guest (incl hvmloader) would
then be free to relocate it.

Jan

