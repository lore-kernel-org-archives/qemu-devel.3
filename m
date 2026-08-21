Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F62C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxKTR-0005Mg-LC; Fri, 21 Aug 2026 04:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1wxKTP-0005MW-IM
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:19:35 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1wxKTN-0002SK-M6
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 04:19:35 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c2074710751so133511766b.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 01:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787300372; x=1787905172; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xJgbi0Hxi0iwuDDgvhe2MiVZefgarGN88Is5Ns8OqNQ=;
 b=CMuOQxybI7AES+fUgsT5c0s+esJlMPhhFRLHJZoN3SmJyiouETkLsK+GtOUJXlzsRh
 FVlCVSfsociayDx7oNXHNwAxkBGequlLNlwptxTbRf2X2WBsjWljJUJiMqPd/fe81XBP
 bXGQ/xE+FFbAm9nDzNgCS2W9RAWPoWZV/HiOjPjTtDbTxAWvbj9Uxbvm+L9IqMZwH4+4
 s8myPvDc+KGRTk2DX6ocEef4ogpXXi3oFWOzZazJeIa+H++T3Fox+NqlHkp9kRWKYB7m
 PIPbnxztVa4CMkLCd9xTyOWVmmB9L/zJZhWTH5yQE+Wa0lBBgH/0YTeyBIqw4qku0Uop
 Pc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787300372; x=1787905172;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xJgbi0Hxi0iwuDDgvhe2MiVZefgarGN88Is5Ns8OqNQ=;
 b=goUCv4wI4fTHUGTx/gN49Wsx1QM6WupRfpLqgYRYUOmv2WoLqDo+zbviJPVs7pY60S
 py2yW6z/vhtFX6k07GGcwhgXFSKaAEDyRGfI0lZsq0EQkR9tQBcn45dDakp2YClRzXda
 Um4Y6LLCxeu/X/A7NBRBKZ3nlIaw7+w7y9usHkZEDxspX2O+UTh6zKQocpWZUUpIy9iz
 5s8jr56A6Xc85IG0iJppVedbU0BDfSeqUOS4XgIRBQPRS8utNPWYixgHzxXAcYSUUbcu
 7614xkEj5EZQuM2DfNL1yiJ+BcJLT462GNiuJYJPznLJuVyUBjTFPRaOnSSHKrFLovx2
 2xIw==
X-Gm-Message-State: AFuF++lAnwngI11RC0k1T8Z1yNYUmBLls12lKTwKjEN2/l9GBqfhTj8n
 JOOIVfk7iLVvTWgu+wlUGNPhlxoYRbaamMCTBMsN5GN7YtxtvEWNG2IpTPcyEumMAQ==
X-Gm-Gg: AR+sD12jFLrHLSLjYRkWa794gCMShq0j+dBCYOOqb+TfipaaAWGH2rucS0aJEAAVIRL
 v98qJZeRTCWEIT5yI3/RO/dfBttP+/Z1WBJ8bX37qsyg5jQqIbVHHOSXMzdY+i6ZM4NTRdnM5Yb
 E6YDT7lAzXuZlZL6T2svJXLoTqRQX0Tqm+4aLYEh6lXzRAWaoy9tz4rH3EFlq35BbEDws2Igur4
 bwE5cISutqYrSirf7CHfSx8CyvAUbUPs+nkdeJDcFtsKGoNq12eX92aZD5IDnIhHhblG9x4TArz
 KE1XnnJ/Fd7+OWB0cBILm/hFSL2ohUCgoKE9f+muVYhOOkX1JxoSMle615HSpMaLJXNdwSfP/Mp
 ZQK5auQz8hHYDqXjr0aOEFNQOyr0ZiUPBnC3HFJGmejIYEInicQkUQMLp89CxnYVDIVGEF5iH/p
 a6pGTnwebcpMlYIQ4eqkA8w9qt8jDrd6sOP2aOCxr38EbxoCgF43n1mavd34WWF9MD2W1XY+VvA
 daoHPBf6MLpnQsck8riQmPT18VxCYifdyVV5SI+kfhee3DhMTa/
X-Received: by 2002:a05:6938:a08f:10b0:c20:f871:1018 with SMTP id
 a640c23a62f3a-c246b4bc19bmr333973866b.21.1787300371859; 
 Fri, 21 Aug 2026 01:19:31 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de.
 [37.24.206.209]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2459223816sm387149366b.57.2026.08.21.01.19.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 01:19:31 -0700 (PDT)
Message-ID: <069cb01d-47b2-41c5-9956-611b338964e9@suse.com>
Date: Fri, 21 Aug 2026 10:19:30 +0200
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
 <92022f85-9a53-4db8-b489-fc91c86b413c@suse.com>
 <fa497825-c8f0-4caf-94f5-b37108e31952@aol.com>
 <42521391-885c-4b96-96e9-5da2e4b5efa1@suse.com>
 <e86404e8-9966-44ab-86d1-4bd01a551313@aol.com>
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
In-Reply-To: <e86404e8-9966-44ab-86d1-4bd01a551313@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=jbeulich@suse.com; helo=mail-ej1-x635.google.com
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

On 20.08.2026 18:53, Chuck Zmudzinski wrote:
> On 8/20/2026 11:17 AM, Jan Beulich wrote:
>> On 20.08.2026 13:47, Chuck Zmudzinski wrote:
>>> On 8/20/2026 3:51 AM, Jan Beulich wrote:
>>>> On 19.08.2026 19:13, Chuck Zmudzinski wrote:
>>>>> On 8/19/2026 9:51 AM, Jan Beulich wrote:
>>>>>> On 19.08.2026 14:36, Chuck Zmudzinski wrote:
>>>>>>> On 8/19/2026 8:16 AM, Chuck Zmudzinski wrote:
>>>>>>>> Yes, I agree that v3 of the patch to hvmloader should presume that the DM can get
>>>>>>>> a copy of the OpRegion and read its contents so most of this can be done in the
>>>>>>>> DM instead of in hvmloader. So from hvmloader's perspective, the patch will be more
>>>>>>>> about avoiding the layering violation than anything else.
>>>>>>>
>>>>>>> However, there is one advantage, from the viewpoint of the Xen virtualization platform
>>>>>>> as a whole, to do the patching of the OpRegion in hvmloader instead of in the DM.
>>>>>>>
>>>>>>> If we patch the OpRegion in hvmloader as v2 of this patch does, we provide a common
>>>>>>> solution for extended VBT support for Intel IGD devices that would be compatible with
>>>>>>> all DM implementations, not just with Qemu. So why not do the patching of the OpRegion
>>>>>>> in hvmloader?
>>>>>>
>>>>>> As indicated before: If the OpRegion holds data that is needed to drive the
>>>>>> device, and if the OpRegion is exposed writable to guests, then guest can
>>>>>> screw up that data such that subsequent guests won't work anymore. Hence
>>>>>> exposing to guests (which includes hvmloader) needs to be stopped, or at
>>>>>> least be limited to r/o. That, in fact, includes exposing to any privilege-
>>>>>> restricted DM as well.
>>>>>>
>>>>>> Exposing r/o may be entirely okay (i.e. may not be a layering violation),
>>>>>> depending how exactly an OpRegion surfaces for a device (on the host). Aiui
>>>>>> it's not addressed by any of the BARs, yet it looks like it needs similar
>>>>>> treatment.
>>>>>
>>>>> Yes, the OpRegion is not one of the BARs as specified by the PCI specs, but
>>>>> it functions more or less like a BAR region with the devices's ASLS register
>>>>> at offset 0xfc in the PCI device config space of the device acting like the
>>>>> BAR for that region.
>>>>
>>>> That is, on real hardware a write to that register moves the OpRegion? That
>>>> would need following by the DM then, i.e. the DM would need to indicate the
>>>> original position in the register, and the guest (incl hvmloader) would
>>>> then be free to relocate it.
>>>
>>> Why would that "need following by the DM" when the register in the guest is
>>> fully emulated, [1] which means that when the guest (incl hvmloader) writes to the
>>> register, the register on the real hardware is not touched, nor is the OpRegion
>>> in the host address space moved?
>>
>> You said it's BAR-like. If the guest writes to a BAR, the referenced MMIO
>> region moves accordingly.
> 
> It's BAR-like, but it is not actually a BAR (and the OpRegion is not exactly
> an MMIO region either (it is actually and ACPI thing), so that is not relevant
> to this patch.
> 
> Also, it is fully emulated so when the guest writes to it, the real register on the
> real device is not touched, as I have said multiple times in my responses to your
> question.

No matter how often you said that, I never put that under question. I was asking
about the behavior of writes (where the behavior on bare hardware would need to
be reflected in the behavior of the emulated register).

>>> Here is how I understand how this works in the current implementation and how
>>> this should be done:
>>
>> I'm sorry, but this is getting out of hand, at least as far as I'm concerned.
>> I've been trying to help, but even just reading your replies has already been
>> taking way more time than I would have wanted to spend here.
> 
> Fair enough. Thank you for the time you have spent on this patch, and also thank
> you for clearly stating that you don't want to spend any more time on it. So
> I consider this patch dead unless and until another maintainer shows some interest
> in it.

I didn't say I would not look at future versions of the patch. However, for me
to (usefully) do so, things need to be presented in a way that I can understand
without knowing all the details of IGD.

Jan

