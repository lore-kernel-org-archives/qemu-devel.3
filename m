Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C592C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wusEs-0004ZQ-6l; Fri, 14 Aug 2026 09:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1wusEh-0004Y3-ND
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 09:46:17 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1wusEe-0007uw-8y
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 09:46:14 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so8875945e9.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 06:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786715169; x=1787319969; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0YsDTahv4URfKLt37kOy8jHhvTySEzNjHEH99JLGqhY=;
 b=Mcp8dzZA5RbTY95upKaR6zCQwYE2AxKaBbhpZ1J3Zkgk+z44ISX7z58GWhZQ4ECe/5
 1zt6H3kKGezm/8eEOKnsfxHh3SvrqKt3K2NccSUeRemSlLaltQPqTsRQqa0c/c3XkWja
 fJ4x42DcVEvEr54iVf6iIhVnGQDT6PS6dtljH75e4CbhN8YmZFRPUNjyt4yRWWvRx0Va
 yju7JcvMQmKEu4SN91JtnKgJP3gTjNkkQ90dh0WICqwPXWv3f+8xOoUuUVoX74wo7ALj
 mTNsRdPHqBToxFQIqEAKtRg+7ga6V3Vs6YjeFlWFDeBgZ+UdO0PUBYYBBJ1wUn5gWspK
 rnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786715169; x=1787319969;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0YsDTahv4URfKLt37kOy8jHhvTySEzNjHEH99JLGqhY=;
 b=gkFrKAJvdGXf2ah9cREjqqUnK3I5iIDrJQHbJLSgrrUkElKkse/l+f+fHrxf1pG0jG
 74HIQ6I50Ef3rX/fLPCBjxyYsPubF3FmGe1VO80LjFwu0drz4SxX+LsFCv0QBwWTgAwb
 Wtr5SpTgL9mteCz1xPBqoB3x53TD8BYfb+IFYFJhq+mop9/4YW2q38oZMcjo0OXwtZgY
 FEmI1reqpziLUN1fbZp7BAO10Ec5Z4czShzAtHtgrPO0e8rjB0OXZxV2dT3Qf0VQZmhg
 mkHcUylB21X5W1h7oxSb+MM5CKquC16xMI7PzYbWaNg1UjS4tG1tfgv/Z5ZxU2Zefii0
 +o8g==
X-Gm-Message-State: AOJu0YxpQm6VakoRkQlzV5cXrWlUBYo03PFQe68B5W6D2ZUhwnRDQlDF
 MCY8BhlYKVN90WqixlDys+ZKgSY2L49Rs8swBVap4opPmZYgTk1vKIlFZcRDxJBMvA==
X-Gm-Gg: AR+sD10l0MlDWe+1gtm27RvA25ZSMhNJSU5tFyz9AAQmXZy9beN9Nii88gWwAQfXo6X
 F/yauGbMVjo1xcN1G9ikS69Bvp989K+le0MZJMfuZ26v3k/yn46lXAXpNqxPrieGW27Oswi/wdi
 cx+o00cQySGVd+OisIg+XZ/j9eQ/QR+uZIn0xT+5Ddm0BFHokMHNXVvfo16Xo4ni69w3+4oWusw
 3fdw9+Z8HMPFHnAdNJky2yg2Mml9SlE4sjDwEI5Sx5jIKaw8+Zw8ATcIblC2H2aBXPtmi5QI3vY
 T25iTvCU5wK8MPP2qQKyLTzBPQpC6s1EXFzdWwMcgBBEWE2z1LRtdDn4rVfjjPImWkua/p301+w
 cn7+32WrHIKg2F8m/B4JIn6ESNI9J5Nrif7xNwwZYawtDozxPx6m3+hGldJdg/96oXFUzICWc4T
 iLqv2p0ZXTTE2HzORwMXMANFagWnF1Jihtgswg+boWY8cEa1XF+vEfUHF+X6Z4fZWXVpb+PRyar
 BiDb658RtvPhUaogCKwD/78Q3KVkt4qMKGZCQ2NqLwr/t81SptB
X-Received: by 2002:a05:600c:620a:b0:495:6bc9:62b0 with SMTP id
 5b1f17b1804b1-499879b9c2fmr88881595e9.17.1786715169438; 
 Fri, 14 Aug 2026 06:46:09 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de.
 [37.24.206.209]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49989ae1ef2sm27190105e9.9.2026.08.14.06.46.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 06:46:08 -0700 (PDT)
Message-ID: <02a7dc18-4184-4e86-84cb-121769187f71@suse.com>
Date: Fri, 14 Aug 2026 15:46:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools/hvmloader: implement Intel IGD extended VBT
 support
To: Chuck Zmudzinski <brchuckz@aol.com>,
 Anthony PERARD <anthony.perard@vates.tech>
Cc: qemu-devel@nongnu.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>,
 xen-devel@lists.xenproject.org, Chuck Zmudzinski <brchuckz@netscape.net>
References: <20260802050824.10554-1-brchuckz.ref@aol.com>
 <20260802050824.10554-1-brchuckz@aol.com>
 <2110d4b7-ae37-47aa-99be-ab59e16f6167@suse.com>
 <67579eba-e222-41dd-84bf-8440d2eaf2a9@netscape.net>
 <da2200cd-def7-4cce-a6c2-9f9ac9e202ce@suse.com>
 <de56c8bd-f0e8-4fe9-8cf5-f6807698176c@aol.com>
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
In-Reply-To: <de56c8bd-f0e8-4fe9-8cf5-f6807698176c@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=jbeulich@suse.com; helo=mail-wm1-x331.google.com
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

On 14.08.2026 15:18, Chuck Zmudzinski wrote:
> On 8/14/2026 3:35 AM, Jan Beulich wrote:
>> On 14.08.2026 02:45, Chuck Zmudzinski wrote:
>>> On 8/13/2026 6:35 AM, Jan Beulich wrote:
>>>> On 02.08.2026 07:08, Chuck Zmudzinski wrote:
>>>>> -- snip --
>>>>> To address this problem, this patch implements support for
>>>>> Intel IGD devices with an extended VBT and OpRegion version 2
>>>>> and higher which is required for most modern Intel IGD devices.
>>>>
>>>> First of all: Where's the spec of all of this?
>>>
>>> Well, your first question is quite provocative. Certainly more
>>> social/legal than technical.
>>
>> Well, it was very much meant to be technical. I've had a hard time following
>> what your new code does, and having a spec to hand would likely have helped.
> 
> I agree that having the spec at hand would be better. To be more precise, I
> can say that what this patch essentially does is port the support for
> the extended VBT with OpRegion 2+ for the Intel IGD passthrough that exists
> in KVM/vfio to Xen. Should I explicitly say in the title of the commit
> message that this is a port of KVM/vfio support for extended VBT to Xen?

Not in the title, as that would likely make it too long, but perhaps in the
description.

>>> So my answer is as follows:
>>>
>>> I do not have access to the official spec that defines "all this" but
>>> I do have access, as does the general public, to the Linux kernel's
>>> implementation of support for the Intel IGD from many sources such as
>>> git.kernel.org. The Linux kernel has enough accurate information about
>>> the spec of "all this" to provide very good support for the Intel IGD
>>> on bare metal.
>>>
>>> To elaborate a bit more, the spec of "all this" can be derived from the
>>> Linux kernel code that supports the Intel IGD.
>>
>> So you expect every reader to locate and decipher the underlying information
>> from a (afaik) pretty large piece of code in the Linux kernel? If the Linux
>> kernel sources are the reference, please can you at least provide pointers
>> into there?
> 
> No, I do not expect every reader to decipher the underlying information...
> 
> That is why I provided these two links at the bottom of the commit message.
> Perhaps you did not notice them:
> 
> Link: https://lore.kernel.org/kvm/20211012124855.52463-1-colin.xu@gmail.com/
> Link: https://lore.kernel.org/kvm/20210325170953.24549-1-fred.gao@intel.com/
> 
> They are the patches to the vfio kernel driver that added support for the
> extended VBT for KVM/vfio guests.

Patches can still be in flight, so provide only limited help. Would it be a
problem to instead reference commits, or the actual localtion in Linux
sources?

>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>> +               (igd_opregion_pgbase << PAGE_SHIFT) |
>>>>> +                IGD_OPREGION2_SUPPORT_MASK);
>>>>
>>>> This looks to imply qemu is the only possible device model.
>>>
>>> Yeah, this is an issue. Other device models that intend to support
>>> the Intel IGD with hvmloader will also have to be compatible with this.
>>> It would be easier if we did not have to worry about backward
>>> compatibility and supporting what we had in the codebase for many years
>>> in both hvmloader and Qemu and we would not need IGD_OPREGION2_SUPPORT_MASK
>>> in that case. Instead, we would just completely deprecate all previous
>>> implementations of the Intel IGD passthrough feature in both hvmloader and
>>> the Qemu DM as unsupported. So my previous comments about backward
>>> compatibility apply here again.
>>
>> As said, I don't think backward compatibility can be dropped. My comment
>> also didn't really mean to hint in that direction. Instead I was wondering
>> in how far, even if perhaps by only a few #define-s, the necessary
>> interfacing couldn't be put down in a public header, for any DM to consume.
> 
> Ok. Perhaps the IGD_* defines could be moved to a public header to define the
> interface to be used to support the Intel IGD. Would it be OK to move those
> to a separate igd.h header

This may require input by others, as in the given situation I'm not quite
sure what is best. Anthony - do you possibly have any suggestion here?

> and include it in hvmloader/config.h?

I don't see why that would be needed. The few files which need the #define-s
can include that new public header, without impacting anything else.

>>>>> +    printf("guest OpRegion tentative "
>>>>> +           "address: 0x%x\n", igd_guest_opregion);
>>>>> +
>>>>> +    if ( !verify_opregion(igd_guest_opregion) ) {
>>>>> +        printf("error: IGD OpRegion signature "
>>>>> +               "not found.\n");
>>>>
>>>> No full stop in messages please.
>>>
>>> Would it be OK to just get rid of the error message here?
>>
>> That would then leave ...
>>
>>>>> +        BUG();
>>
>> ... an un-annotated BUG(), which generally isn't very nice.
> 
> I don't think I understand what you mean by "No full stop in messages..."

That's the period at the end of a sentence (when in log messages the term
"sentence" is of questionable nature).

> We have code like this in hvmloader/e820.c:
> 
>     if ( rc || !nr_entries )
>     {
>         printf("Get guest memory maps[%d] failed. (%d)\n", nr_entries, rc);
>         BUG();
>     }

Well, you'll almost always be able to find bad pre-existing examples.

>>>>> +    printf("VBT size: 0x%x\n", rvds);
>>>>> +
>>>>> +    if ( !rvds || !rvda_host ) {
>>>>> +        printf("guest OpRegion address: 0x%x\n", igd_guest_opregion);
>>>>> +        rvda_host = 0;
>>>>> +    }
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
> I think the host OpRegion is not currently accessible by the DM.

Can you explain to me how the region becomes accessible to the guest?
That would then (hopefully) help me understand why the DM would not have
access. Fundamentally any MMIO and any I/O ports that are assigned to a
guest are also assigned to its DM.

> On the KVM
> platform, this is made possible via the kernel vfio driver and then Qemu exposes
> the OpRegion to the guest using the Qemu FwCfg device interface. How should we make
> the OpRegion and VBT accessible to the device model and then, to the guest, on Xen?
> I think it could be done via the xen-pciback kernel driver. Should we do that
> instead? I think to do that we would have to convince the kernel developers that
> the Intel OpRegion, as you say, "should" be accessible by the Xen device model.
> I can imagine them saying, why not use the vfio driver?

I can't answer this; all I can say is that it feels wrong to involve e.g.
xen-pciback here.

Jan

