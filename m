Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8333C5DF67
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 07:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwE5C-0006bC-JM; Tue, 18 Aug 2026 03:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1wwE5A-0006b1-F4
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 03:18:00 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1wwE58-0004kZ-KJ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 03:18:00 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso32646385e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 00:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787037477; x=1787642277; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=L7FAbteNVTVo+lqbCQIlVu+Buu38SbMZ2XQYRGm7L2E=;
 b=FfcQYFStwRzQlw7Bl6YCepiktWIRX8uxbIikBxAE5zVBgsG7vorWexeOtqKIwDNZdQ
 6zDLoFxgIYsowCYy2Sx3aCw/rH64qNSneRSPQVGaYI76uRUIvBxNjs2jc3NUHQLiZq4w
 gh11dDmdimJ+sp/2ibAC9ier3vt0ZMc4Rk9gd+VZRL6opG6DQqk7DzW4epRVS5ZnGQZY
 bsb5GRBFGN7PqPw3ImpBrfRhy6tdHMGNtqGumqBaD91xcC6oRFFfaxGiKPkKQmzRndjq
 7h67eY36ewiuDP9Q1Y53XRf68sKO4Nh0GTA24Kz+uay4UBRDwTGTPKPShrzp/DqroPVJ
 NV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787037477; x=1787642277;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L7FAbteNVTVo+lqbCQIlVu+Buu38SbMZ2XQYRGm7L2E=;
 b=ZKALUS0e/39WoonYwT8g5vS5Gmfg2IxfCMgihaLfgeHtmIymL5cxuDwW+A1aIwnyzN
 b0f5E7p00oxfuzqnDml4/VtqIWYYM8ci5r/FbeoRLD4WLBKDCB+1NuT9E9SkmPG5pmE7
 j92HxOHUkVxF/PpHOqiYZ0HeWCWLdJn6h9IMt3/KGBdOFx6uO4Vx17dIQFBn0InhqEol
 D44zc+WHQHdJZtfUnQ65YQRCJYEgdJ72l4HKykAFQew4BjL9lvqfH8s8ZZJeix2WPatQ
 JGSJf5UZtGmOjnshd1hESiBDRavgYNlmDh6UCoWB1B3nZFQwyWnkxF458IpscUoMY4hg
 sSwQ==
X-Gm-Message-State: AOJu0Yw/y/DQwJ1tphKYhbS3hfhfQk3P+JY/zOQe/2OAtnSwc0NQbGsd
 qWHN/eRxuuzANDPNMAt5QoVzphwHgxHEAZq3a6FpJRly/YU1rU+5uUW31kBz80OKMA==
X-Gm-Gg: AR+sD10OPMvvQbJypbXljqbwJVx8P1vUm1/ZK6Kn0buKhHoW42XtYS7EbknSkvY6KCW
 9gI9lOomwsR1kC6YDCZrUDHdDZeaODLYorX7pIbWIcTc34xNsT0LrMXRdpJGZIIoZyOaw/3GnL1
 MWiIw0pH0R+gxtecHzamseDGEjZzj4QSAIIorJIwdve6KxRp/BPCOXRVU5YJCsMb1Vuu9uZwJAR
 oZezzRx1ucYpZ5BPQnyjOr8Lkf6IFjGERQcA0QupkreIaxSPJwRrwNHw+G97jJgK3pZ8Ut35ddA
 LINt9nkl9kObsuBJ7rBUrXPJ0JxaKW/e/tcnx0d7jJD4cjUKXJ2C4ujTQBzj7sgSF5dKaWnYAwf
 QkmiIJRtFYG3gqI22QfPhOZyCN0oGjpmZTG/Z5OCwI9EsKSlUK+dxnncLZ2+HBu66mlvmkIGg2E
 f3wAkPAf5E3mg9gUaVZnAygmQVyoPgQwHHX/5BrmqKfJ3ZcVu7YyvDvniBBGqS3JZFoFMCLzu1O
 LE54FSWE3TptcNcu3Kvu5d21v4cYyKQGUbKW3LPy+qc5djFzypq
X-Received: by 2002:a05:600c:3b8e:b0:499:a660:f926 with SMTP id
 5b1f17b1804b1-499a660facemr1547315e9.11.1787037476748; 
 Tue, 18 Aug 2026 00:17:56 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de.
 [37.24.206.209]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5b7840esm8853223f8f.29.2026.08.18.00.17.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 00:17:56 -0700 (PDT)
Message-ID: <6ecf80ef-2f0e-44fb-beab-dbcf065a4431@suse.com>
Date: Tue, 18 Aug 2026 09:17:55 +0200
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
In-Reply-To: <fdec0b6b-eddf-4a36-a755-c67963daa9ea@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=jbeulich@suse.com; helo=mail-wm1-x32a.google.com
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

On 17.08.2026 18:04, Chuck Zmudzinski wrote:
> On 8/17/2026 4:42 AM, Jan Beulich wrote:
>> On 14.08.2026 17:23, Chuck Zmudzinski wrote:
>>> On 8/14/2026 9:46 AM, Jan Beulich wrote:
>>>> On 14.08.2026 15:18, Chuck Zmudzinski wrote:
>>>>> On 8/14/2026 3:35 AM, Jan Beulich wrote:
>>>>>> On 14.08.2026 02:45, Chuck Zmudzinski wrote:
>>>>>>> On 8/13/2026 6:35 AM, Jan Beulich wrote:
>>>>>>>> On 02.08.2026 07:08, Chuck Zmudzinski wrote:
>>>>>>>>> -- snip --
>>>>>>>>> +    /*
>>>>>>>>> +     * Write rvda_host as 2 successive 32-bit values
>>>>>>>>> +     * to communicate location of the VBT to the device
>>>>>>>>> +     * model. If rvda_host is not 0, The device model
>>>>>>>>> +     * unmaps the OpRegion and eventually maps the VBT
>>>>>>>>> +     * after we also write the guest address where the
>>>>>>>>> +     * VBT will be mapped.
>>>>>>>>> +     *
>>>>>>>>> +     * If we send rvda_host = 0 to the device model, it
>>>>>>>>> +     * will assume we do not need OpRegion 2 support and
>>>>>>>>> +     * it will not unmap the OpRegion.
>>>>>>>>> +     */
>>>>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>>>>> +               (uint32_t)(rvda_host & 0xfffffffful));
>>>>>>>>> +    unsigned long rvda_host_upper_32 = (uint64_t)rvda_host >> 32;
>>>>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>>>>> +               (uint32_t)rvda_host_upper_32);
>>>>>>>>
>>>>>>>> Why would you need to communicate a host property to the DM?
>>>>>>>
>>>>>>> The DM cannot access the host rvda value because it is only accessible
>>>>>>> from the host kernel, and the DM is only a user-space process on the host.
>>>>>>
>>>>>> I don't follow this: Anything the guest can access should also be accessible
>>>>>> by its DM.
>>>>>
>>>>> I think the host OpRegion is not currently accessible by the DM.
>>>>
>>>> Can you explain to me how the region becomes accessible to the guest?
>>>> That would then (hopefully) help me understand why the DM would not have
>>>> access. Fundamentally any MMIO and any I/O ports that are assigned to a
>>>> guest are also assigned to its DM.
>>>
>>> Currently, in the device model (Qemu) we have:
>>>
>>>     ret = xc_domain_memory_mapping(xen_xc, xen_domid,
>>>             (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT),
>>>             (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
>>>             XEN_PCI_INTEL_OPREGION_PAGES,
>>>             DPCI_ADD_MAPPING);
>>>
>>> That statement is in the igd_write_opregion(...) function in the
>>> hw/xen/xen_pt_graphics.c file of the upstream Qemu source.
>>>
>>> If I understand our current implementation correctly, this statement
>>> is what gives the guest access to the host OpRegion (3 pages as defined
>>> by XEN_PCI_INTEL_OPREGION_PAGES, and in agreement with IGD_OPREGION_PAGES
>>> in hvmloader code).
>>
>> No, it introduces mappings of those pages into the guest's P2M.
>>
>>> I don't think this statement makes the host OpRegion
>>> accessible to the device model, though, so I think, if I understand your
>>> comment in an earlier about my patch resulting in what you called a "layering
>>> violation" correctly, that our current implementation is also guilty of this
>>> same kind of "layering violation."
>>
>> That code, if it can be successfully executed, indeed doesn't grant any
>> permissions (to the DM or the guest). Instead it proves that the DM has the
>> needed permissions to access the pages itself.
> 
> So, are you saying it should be possible, without any patches to either Xen or
> the Linux kernel, for Qemu to get a pointer to the OpRegion? If so, how?
> 
> I think I could implement what you proposed in an earlier message and do
> all (or most) of this in the DM instead of here in hvmloader:
> 
>> The more correct thing to do might be for the DM to
>> put in place a copy before the guest (i.e. hvmloader) even gains control.
>> (How in turn the DM would learn of the contents of the opregion is a
>> separate question then.)
> 
> Actually, when I was developing this patch, I tried first to do it that
> way, but the problem was, I could not find a way to get a pointer to the
> host OpRegion in Qemu.
> 
> So, how can I get a pointer to the host OpRegion in Qemu?

You don't ask me this question, do you? All I can say is that surely qemu
has an existing way to map (host) physical memory; see e.g. how
xen_pt_msix_init() (imo bogusly) maps the physical MSI-X table of a
device. "Bogusly" there because that's another layering violation. Plus
(independently) there and here there's the issue of how to accomplish
things when not running in Dom0, or when running de-privileged in Dom0.

Jan

