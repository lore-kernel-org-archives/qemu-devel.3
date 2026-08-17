Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9092EC5DF70
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvtUK-0005mP-VE; Mon, 17 Aug 2026 05:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1wvtUJ-0005mE-LX
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 05:18:35 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1wvtUH-0003r9-EO
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 05:18:35 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4955aa106b1so27941555e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 02:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786958311; x=1787563111; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hbkYtSJwMzBKBO/qIaZ9S5VqcBP390ZyMFSdmF8cAK0=;
 b=ccj3ToIfAbFLQWp7TOvv+KlGOrc1q1aaElpaTfe/Eioj926O8n4Xz40WTK8X3bCpg0
 xocO2VdAb30QqsKoUgqLEabJTnRbE41e2hjJ2fRl3vMGW+NpMwdQJ2KXMIDvl7CJuBFq
 bU5IIJq5pEM8TbCdx0NBtu8qyDuNKYgVy46DkVQEN6qW8VIksZ5ufQ/qRfhxGWX4oINa
 O+9jk9HyObbFoD2mEhNE/1MhqmAOBJ4ufqHvJ0iZPMakHhLQiBOcAeVazQ/Bf5Q5jqcY
 PKc//av6iycHuSDKCTrlpiqKqZPKfuk9kpR63kbmZWbFP6flCHHNFtYo8DV9oaGJXTbz
 VfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786958311; x=1787563111;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hbkYtSJwMzBKBO/qIaZ9S5VqcBP390ZyMFSdmF8cAK0=;
 b=k2vE4DxEnQO2ikth+lmeq+Ucmuw5yTkBVO6+aesvUx/LgQyAKBRgJsODJlP7KBrQTV
 rY2KXBhG5hr3Q77RhjzreQz1amd54liDu2JwQLcf1gqY9ZgoMkzo+vKv7HWujRSop9YP
 3OyBbtY+49RDZXbUAuHMmDEu88UlXynvxoialhWg5FM7K+1grXKg6/vjaqgt9bjxCyKl
 p7tBodswtquyL+CfFPtjaQ2u8zK9hBekB08h4B03Dm0tNxfKWwff5j3xA9GOUTliVVsE
 ABd4y80nRL7VAJkj2q2sOy3N7QvPrjNLXO9nSJ4VL1WcQIizzxT9nRe1HjQ8hKP0bBZ3
 ywzw==
X-Gm-Message-State: AOJu0YxbEwW1e+4bPObXfsEyNWc7of/yglyxIRuqzWmDMSa0aSXa0cSU
 dp0JEBNrUPb/gFI3eVIQ14NsdKNZ/RiGQPYrYG3h0sL2mdv5NY2JgdEJeQKYD/AZig==
X-Gm-Gg: AR+sD13SSpCJTzre0aK1qieUiLpGxWpow0Zb92EOjJ7CFfCTBGwEBM3juhhMt2Qgk5d
 nRlkyFU02XqQeAM0QSJRvp3rABpBsFA2DU4s/mAJJe4d5//jj+AJq4O6/54MGYOjxuaRrW9yg8u
 SxmPYEmi16T4bG3+smjX4ypR8eaC+E1EVsCSDI7D6pmgwoTDtxsF32LfUxsQnblQHDqIPPCb7KK
 fuvSNqgrjj7kbsGpc0qZRltcUy5mAo9Kerl45/dRc1o+EhfTMPV+IxhyOtTPPKd8U1QkiWSuYBc
 oAxec8eXCtWklA29MDXreQEq4TuyRzKLjHOKwKK+VQbLUiltaK+7ODBSCVLVv0QAsBTufQKzLUl
 MmKiNkJ4uDRoVYMy1HOZ42qNiTy9zuiK3yITLDJIZ2YQCQkXlO6qCamoQgI/v9QVo4ms279trBQ
 9uGZZzZFEvNQVGky8krkGDqVRKFYnn45S0FsuCp/dKQUN05pFerm3x8WHvIR2HfA4X9KvgUPMlp
 tDN9+3YMh9Uzpv6dfxOPDjyuhJBCLr6ByueX7UWGKi6GX2ueFM3zMFZZNIza1Y=
X-Received: by 2002:a05:600c:871b:b0:499:8b00:5261 with SMTP id
 5b1f17b1804b1-4998b0052cdmr336753065e9.8.1786958311160; 
 Mon, 17 Aug 2026 02:18:31 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de.
 [37.24.206.209]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d0876b8sm33985065e9.8.2026.08.17.02.18.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 02:18:30 -0700 (PDT)
Message-ID: <0086d141-f434-41ef-8048-078882bf3818@suse.com>
Date: Mon, 17 Aug 2026 11:18:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools/hvmloader: implement Intel IGD extended VBT
 support
To: Chuck Zmudzinski <brchuckz@aol.com>
Cc: qemu-devel@nongnu.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>,
 xen-devel@lists.xenproject.org, Anthony PERARD <anthony.perard@vates.tech>
References: <20260802050824.10554-1-brchuckz.ref@aol.com>
 <20260802050824.10554-1-brchuckz@aol.com>
 <2110d4b7-ae37-47aa-99be-ab59e16f6167@suse.com>
 <67579eba-e222-41dd-84bf-8440d2eaf2a9@netscape.net>
 <da2200cd-def7-4cce-a6c2-9f9ac9e202ce@suse.com>
 <a98b7e5f-240b-4642-b488-fac69846b3f8@aol.com>
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
In-Reply-To: <a98b7e5f-240b-4642-b488-fac69846b3f8@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=jbeulich@suse.com; helo=mail-wm1-x330.google.com
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

On 16.08.2026 18:38, Chuck Zmudzinski wrote:
> On 8/14/2026 3:35 AM, Jan Beulich wrote:
>> On 14.08.2026 02:45, Chuck Zmudzinski wrote:
>>> On 8/13/2026 6:35 AM, Jan Beulich wrote:
>>>> On 02.08.2026 07:08, Chuck Zmudzinski wrote:
>>>>> -- snip --
>>>>> +    /*
>>>>> +     * Read the value the device model is initialized with.
>>>>> +     * If the device model supports OpRegion 2, it will
>>>>> +     * return the host IGD OpRegion address. If not, it
>>>>> +     * will return 0. If the device model does not support
>>>>> +     * OpRegion 2, the device model expects us to give it
>>>>> +     * the address to which it will map the OpRegion in the
>>>>> +     * guest and then expects us to do nothing more to setup
>>>>> +     * the OpRegion, so that is all we will do in that case.
>>>>> +     */
>>>>
>>>> Hmm, exposing the host opregion to a guest certainly feels like an issue.
>>>
>>> Well, that is how it is now. I am only retaining it to maintain backward
>>> compatiblily with DM versions that do not support the extended VBT and
>>> OpRegion 2+. My previous comment about backward compatibilty and DM
>>> compatibility also applies here. If we don't worry about that, we can do
>>> away with any cases where we are permanently mapping the host opregion to
>>> the guest and implement this new approach of always exposing a copy of
>>> the OpRegion and VBT to the guest instead.
>>
>> How does "permanently mapping" matter? hvmloader runs inside the guest, so
>> exposure just to copy the data isn't any better in terms of this being a
>> layering violation. The more correct thing to do might be for the DM to
>> put in place a copy before the guest (i.e. hvmloader) even gains control.
>> (How in turn the DM would learn of the contents of the opregion is a
>> separate question then.)
> 
> I am working on v3 of this patch and I want v3 to address this problem of a
> "layering violation" that you mentioned here, but I do not understand exactly
> what you mean. Do you mean to say that the current code we have in place and
> have had in place for over the past 10 years [1] in the Qemu DM that traps and
> maps the OpRegion into the guest is a "layering violation?"
> 
> [1] https://xenbits.xen.org/gitweb/?p=qemu-xen.git;a=commitdiff;h=5cec8aa38cc
> ("xen, gfx passthrough: add opregion mapping")

All I can say is that this at least smells like a layering violation. It maybe
wouldn't have if, in your patch, you didn't demonstrate that the machine page
range doesn't really need mapping, as copying the data and providing that to
the guest is sufficient. In such a case, the machine range should (imo) never
have been exposed. After all the guest then can fiddle with it, potentially
breaking later guests that are to also use the region.

>>>>> +    /*
>>>>> +     * Write rvda_host as 2 successive 32-bit values
>>>>> +     * to communicate location of the VBT to the device
>>>>> +     * model. If rvda_host is not 0, The device model
>>>>> +     * unmaps the OpRegion and eventually maps the VBT
>>>>> +     * after we also write the guest address where the
>>>>> +     * VBT will be mapped.
>>>>> +     *
>>>>> +     * If we send rvda_host = 0 to the device model, it
>>>>> +     * will assume we do not need OpRegion 2 support and
>>>>> +     * it will not unmap the OpRegion.
>>>>> +     */
>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>> +               (uint32_t)(rvda_host & 0xfffffffful));
>>>>> +    unsigned long rvda_host_upper_32 = (uint64_t)rvda_host >> 32;
>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>> +               (uint32_t)rvda_host_upper_32);
>>>>
>>>> Why would you need to communicate a host property to the DM?
>>>
>>> The DM cannot access the host rvda value because it is only accessible
>>> from the host kernel, and the DM is only a user-space process on the host.
>>
>> I don't follow this: Anything the guest can access should also be accessible
>> by its DM.
> 
> I also don't follow your comment here so permit me to comment and ask some
> questions for clarification.
> 
> I was thinking it is enough for the domain the DM is running in to have
> access to the resource for it to be legitimate for the DM to map the resource
> into the guest. So I also think that whether or not the DM itself can access
> the resource is irrelevant to the question. But you seem to be saying, no,
> that is not enough, the DM itself should be able to access the resource
> before it can be allowed to map the resource to its guest. Is that what you
> are saying?

That depends on what you mean by "access": The prereq is that the DM have
permission to access the pages. It may not have an active mapping thereof.

> Perhaps your comment here is related to the concept of a "layering violation"
> mentioned above. Are you saying it is a layering violation for the DM to
> map an MMIO resource to its guest unless it actually has access to that
> resource? If so, what kind of access to those device resources should the
> DM have? Read access? Read/Write access?

No, I'm trying to bring across that (as said above) access to machine pages
should not be granted when that isn't necessary. As in here: A copy of the
pages looks to suffice, so simply give the guest access to a copy.

> If the specs only say the DM "should" have access to the resources it maps
> into its guest, then I would think it would not be a layering violation.
> But if the specs say the DM "must" have access before it asks the hypervisor
> to map the resource to the guest, then I would admit that yes, we have a
> layering violation because the DM is mapping the OpRegion to the guest
> even though it does not have access to the OpRegion.
> 
> So, where are the specs for what the DM can and cannot do? Are they publicly
> available, or are they proprietary or only available to members of the Linux
> Foundation and/or the Xen Project?

Sadly the source code (of Xen and/or qemu) is the spec.

Jan

