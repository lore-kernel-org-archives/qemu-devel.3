Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18E2C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 07:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwakn-0000qM-M6; Wed, 19 Aug 2026 03:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1wwakl-0000pz-Sw
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 03:30:27 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1wwakj-000885-JZ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 03:30:27 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso5126385e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 00:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787124624; x=1787729424; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vDXwFjdZGRE6UEogEeXgLT8E+AZZ+Pj3Tcn5HrNbF/A=;
 b=b7MXSsEG8gcRUu3oq+taYkIeGEQ/K3Q/hGJfvnVDYTikmGbqQF5fVv3s+I7HrKemO8
 GJM2aNVv+A3FB6kxdzY67BJk/D6oy4MDffv6hNawWwEq4lHc7F1cgrNW1YuZTEdqGrtv
 IW7dlgNT4W4t8RmHbNVK5Ca3s3JdQJ1lw6Dvefi6rB+V469wmCbR+5UrBBg1E5m1t97P
 oXGGX+IqdBtkyE8Q0hgGH7jTONEOgLPAa8yGe4SuHcJ6lLU3ejO6FgKOl52TlUOY102I
 qNQPYJcGW18p2lUdeGTmhijsR9X+mwFiY4ojPP8de6tQ1091tgwiHPDOgrvoyTCk3KoJ
 MnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787124624; x=1787729424;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vDXwFjdZGRE6UEogEeXgLT8E+AZZ+Pj3Tcn5HrNbF/A=;
 b=tRFpjVErT2Q+8jRZGUwJLMgZlIiVfh4HD5u3YlATYqC+UlGyQScOVJGQXucMZdOSC7
 Jl0M+T5atFQ42nZFJaOlFpiVLIndnFKD9JjJQzp5mvC9Fs6amvRX1p5q8Va1R7mAD2jC
 dCIUG6QcDOs8iMZgdJRnIDsKOYtBjNncXguuzks+lMwwHVhvh5yeu95UFtfstgrQcEEq
 p0xcTIBvnyPsD5MPZbHxkI/8KPGYfcyqaxDBhf0RjG4HyIQou78f4B5b3Uy4RS4z/92Y
 C4IFfdEwkQXW3SBCEg4T+z333bgECVU5A9gkzW50THs9UPbQ3CSUouJrbSGVM8+t1yU8
 NGJg==
X-Gm-Message-State: AOJu0YyFWuKiQinqr9uAAawN8IzZLi9nC7HSCbyh9MXzq9GXEXV21QpJ
 SBsCXkVUNTx9diJH6ujFV2ZkmU1EN/TWkAiR1CMXf4crQBo3eWrf4NiA08lEhFoZrA==
X-Gm-Gg: AR+sD10TlWNvEwZ+MziDtvRvFIdghMFjuSiEF93X/gGLAtLmd55YChh02y8aEE/OAl/
 dN7+tPsAtpJ8dyWKbiN51QakBl/TAIx8BmuhzRCg2/ywC3H1ctifNFT9pWpBPIf/BaHOhH83L3B
 ec0bepO9I+S/m83LNTez5OUjPqrq5Xbt0Clmov4XJM2ANhDbGTmCQ0dDcyzppbpWLb3GmlbNEGd
 nP7OAo7TaWXm96dK/D5MUsVZby8Cs2/IPKVUQQZz8a7bsl6rWaH+7dIQkrUak2BIqQRKOS/oPGr
 9/FGXilxJvBtzDVxibce7h88skQIbvAU8AxaAqILTo4CYAC2h8WoEyR5gTBW0BCs4o8OQj5aYJo
 CUF3bcpTPBNAWbYJcA4cgCmaRPxfDl2lbvZl3PVnCI93PD9wYlfjQClWq5/QaVxoGcbt4FQ/hf6
 1xob7zeX6hKS3dCBy/d4bsiVb7mp4ZRejtwCmwHSrblly7yLR9UwFFv2+U51LEDCZHpKS49hFYZ
 RgCBXUriS4j/GqRbs+J7zJIhMbcPGYWyFm5BKYEpovrfuj8jZ4s
X-Received: by 2002:a05:600c:6308:b0:499:80d0:8b73 with SMTP id
 5b1f17b1804b1-499aa171fd8mr42828625e9.4.1787124623716; 
 Wed, 19 Aug 2026 00:30:23 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de.
 [37.24.206.209]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa111113sm32778895e9.4.2026.08.19.00.30.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 00:30:23 -0700 (PDT)
Message-ID: <302ed12f-40ca-405c-80ca-ac4f2785d754@suse.com>
Date: Wed, 19 Aug 2026 09:30:22 +0200
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
In-Reply-To: <db8fd04d-bbc7-41c7-8473-b821d7f77d5f@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jbeulich@suse.com; helo=mail-wm1-x32f.google.com
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

On 18.08.2026 19:15, Chuck Zmudzinski wrote:
> On 8/18/2026 8:29 AM, Chuck Zmudzinski wrote:
>> On 8/18/2026 8:18 AM, Jan Beulich wrote:
>>> On 18.08.2026 13:52, Chuck Zmudzinski wrote:
>>>> On 8/18/2026 3:17 AM, Jan Beulich wrote:
>>>>> On 17.08.2026 18:04, Chuck Zmudzinski wrote:
>>>>>> On 8/17/2026 4:42 AM, Jan Beulich wrote:
>>>>>>> On 14.08.2026 17:23, Chuck Zmudzinski wrote:
>>>>>>>> On 8/14/2026 9:46 AM, Jan Beulich wrote:
>>>>>>>>> On 14.08.2026 15:18, Chuck Zmudzinski wrote:
>>>>>>>>>> On 8/14/2026 3:35 AM, Jan Beulich wrote:
>>>>>>>>>>> On 14.08.2026 02:45, Chuck Zmudzinski wrote:
>>>>>>>>>>>> On 8/13/2026 6:35 AM, Jan Beulich wrote:
>>>>>>>>>>>>> On 02.08.2026 07:08, Chuck Zmudzinski wrote:
>>>>>>>>>>>>>> -- snip --
>>>>>>>>>>>>>> +    /*
>>>>>>>>>>>>>> +     * Write rvda_host as 2 successive 32-bit values
>>>>>>>>>>>>>> +     * to communicate location of the VBT to the device
>>>>>>>>>>>>>> +     * model. If rvda_host is not 0, The device model
>>>>>>>>>>>>>> +     * unmaps the OpRegion and eventually maps the VBT
>>>>>>>>>>>>>> +     * after we also write the guest address where the
>>>>>>>>>>>>>> +     * VBT will be mapped.
>>>>>>>>>>>>>> +     *
>>>>>>>>>>>>>> +     * If we send rvda_host = 0 to the device model, it
>>>>>>>>>>>>>> +     * will assume we do not need OpRegion 2 support and
>>>>>>>>>>>>>> +     * it will not unmap the OpRegion.
>>>>>>>>>>>>>> +     */
>>>>>>>>>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>>>>>>>>>> +               (uint32_t)(rvda_host & 0xfffffffful));
>>>>>>>>>>>>>> +    unsigned long rvda_host_upper_32 = (uint64_t)rvda_host >> 32;
>>>>>>>>>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>>>>>>>>>> +               (uint32_t)rvda_host_upper_32);
>>>>>>>>>>>>>
>>>>>>>>>>>>> Why would you need to communicate a host property to the DM?
>>>>>>>>>>>>
>>>>>>>>>>>> The DM cannot access the host rvda value because it is only accessible
>>>>>>>>>>>> from the host kernel, and the DM is only a user-space process on the host.
>>>>>>>>>>>
>>>>>>>>>>> I don't follow this: Anything the guest can access should also be accessible
>>>>>>>>>>> by its DM.
>>>>>>>>>>
>>>>>>>>>> I think the host OpRegion is not currently accessible by the DM.
>>>>>>>>>
>>>>>>>>> Can you explain to me how the region becomes accessible to the guest?
>>>>>>>>> That would then (hopefully) help me understand why the DM would not have
>>>>>>>>> access. Fundamentally any MMIO and any I/O ports that are assigned to a
>>>>>>>>> guest are also assigned to its DM.
>>>>>>>>
>>>>>>>> Currently, in the device model (Qemu) we have:
>>>>>>>>
>>>>>>>>     ret = xc_domain_memory_mapping(xen_xc, xen_domid,
>>>>>>>>             (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT),
>>>>>>>>             (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
>>>>>>>>             XEN_PCI_INTEL_OPREGION_PAGES,
>>>>>>>>             DPCI_ADD_MAPPING);
>>>>>>>>
>>>>>>>> That statement is in the igd_write_opregion(...) function in the
>>>>>>>> hw/xen/xen_pt_graphics.c file of the upstream Qemu source.
>>>>>>>>
>>>>>>>> If I understand our current implementation correctly, this statement
>>>>>>>> is what gives the guest access to the host OpRegion (3 pages as defined
>>>>>>>> by XEN_PCI_INTEL_OPREGION_PAGES, and in agreement with IGD_OPREGION_PAGES
>>>>>>>> in hvmloader code).
>>>>>>>
>>>>>>> No, it introduces mappings of those pages into the guest's P2M.
>>>>>>>
>>>>>>>> I don't think this statement makes the host OpRegion
>>>>>>>> accessible to the device model, though, so I think, if I understand your
>>>>>>>> comment in an earlier about my patch resulting in what you called a "layering
>>>>>>>> violation" correctly, that our current implementation is also guilty of this
>>>>>>>> same kind of "layering violation."
>>>>>>>
>>>>>>> That code, if it can be successfully executed, indeed doesn't grant any
>>>>>>> permissions (to the DM or the guest). Instead it proves that the DM has the
>>>>>>> needed permissions to access the pages itself.
>>>>>>
>>>>>> So, are you saying it should be possible, without any patches to either Xen or
>>>>>> the Linux kernel, for Qemu to get a pointer to the OpRegion? If so, how?
>>>>>>
>>>>>> I think I could implement what you proposed in an earlier message and do
>>>>>> all (or most) of this in the DM instead of here in hvmloader:
>>>>>>
>>>>>>> The more correct thing to do might be for the DM to
>>>>>>> put in place a copy before the guest (i.e. hvmloader) even gains control.
>>>>>>> (How in turn the DM would learn of the contents of the opregion is a
>>>>>>> separate question then.)
>>>>>>
>>>>>> Actually, when I was developing this patch, I tried first to do it that
>>>>>> way, but the problem was, I could not find a way to get a pointer to the
>>>>>> host OpRegion in Qemu.
>>>>>>
>>>>>> So, how can I get a pointer to the host OpRegion in Qemu?
>>>>>
>>>>> You don't ask me this question, do you?
>>>>
>>>> Are you offended I asked this question? If so, I am sorry. You make me
>>>> afraid to ask it again so I will not do so unless you permit to do so
>>>> again.
>>>
>>> "Offended" is the wrong word; "very puzzled" may better get it. I'm not a
>>> qemu person, and I never have been. I can't really help much there.
>>>
>>>> All I can say is that surely qemu
>>>>> has an existing way to map (host) physical memory; see e.g. how
>>>>> xen_pt_msix_init() (imo bogusly) maps the physical MSI-X table of a
>>>>> device. "Bogusly" there because that's another layering violation. Plus
>>>>> (independently) there and here there's the issue of how to accomplish
>>>>> things when not running in Dom0, or when running de-privileged in Dom0.
>>>>
>>>> Well, that only proves Qemu *might* be able to access the MSI-X table of
>>>> a device, that is, if the calls to open /dev/mem and mmap it succeed.
>>>> Why is the MSI-X table all of the sudden relevant? Even if Qemu
>>>> can access the MSI-X table of some device, that does not prove that
>>>> Qemu can access the host OpRegion of an Intel IGD. So I think my point
>>>> still stands: I still don't see proof that it is possible for Qemu
>>>> to get a pointer to the host OpRegion without any patches to the current
>>>> implementations of Xen and the Linux kernel.
>>>
>>> The MSI-X table (and it being accessible to qemu) is the best analogy I
>>> could come up with, as that's one tiny area of qemu that I know at least
>>> a little.
>>>
>>> From a Xen perspective, this analogy should be sufficient: All you need
>>> from Xen is for it to permit to establish mappings of the underlying page.
>>> As I've pointed out when commenting on a code fragment you presented, the
>>> DM (domain) looks to have permission. Everything else is a matter of
>>> establishing such a mapping. There the MSI-X table code may also guide
>>> you. (Sadly it may also misguide you, since (a) I don't know whether it's
>>> appropriate to do things this way in qemu, and since (b) it is, as said,
>>> imo a layering violation.)
>>
>> I agree that accessing the host /dev/mem directly is cringy. I would not
>> really want to do it that way for the host OpRegion.
> 
> I looked at the current mainline Linux kernel code about access to memory using
> /dev/mem and modern distros set CONFIG_STRICT_DEVMEM which forbids access to
> ordinary system RAM but allows access to what the kernel developers call
> non-kernel memory. Here is a quote from a comment in arch/x86/mm/init.c file
> in the Linux source code:
> 
>>  * On x86, access has to be given to the first megabyte of RAM because that
>>  * area traditionally contains BIOS code and data regions used by X, dosemu,
>>  * and similar apps. Since they map the entire memory range, the whole range
>>  * must be allowed (for mapping), but any areas that would otherwise be
>>  * disallowed are flagged as being "zero filled" instead of rejected.
>>  * Access has to be given to non-kernel-ram areas as well, these contain the
>>  * PCI mmio resources as well as potential bios/acpi data regions.
> 
> So I think things like the MSI-X table and the OpRegion would qualify for
> /dev/men access even with CONFIG_STRICT_DEVMEM set, so after seeing this
> I expect I could get a pointer to the OpRegion running in Qemu using
> /dev/mem and mmap, as long as it is running in dom0 with root privileges.
> But as I said earlier, I agree that /dev/mem and mmap does not feel like
> the right way to do it.
> 
> So I would like to come back to something else you said in an earlier message:
> 
>> (How in turn the DM would learn of the contents of the opregion is a separate
>>  question then.)
> 
> Let me phrase the question like this: How could the DM gain access to the contents
> of the OpRegion, and for that matter, also the contents of the MSI-X table, without
> also committing a layering violation?

As said previously, I'm not a qemu person at all. Yet it's entirely a qemu
question you raise. From Xen's perspective, as also said previously, the
one prereq is there - the DM domain is permitted to access the page(s) in
question.

Jan

