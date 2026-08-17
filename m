Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBC8C5DF70
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvsvz-0007CH-NZ; Mon, 17 Aug 2026 04:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1wvsvu-0007C6-Vb
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 04:43:02 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1wvsvs-0006IM-Fs
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 04:43:02 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so1879472f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 01:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786956177; x=1787560977; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=x622Wrre38R1Vn44VSt++jkbOnTxGwZvj5cTSBQsfXw=;
 b=Y3L0wG20fC4SHn0ct2qHB+EjYzwxlhhG/ASH5FDIScjQci103VjYzCg2awolcMWxet
 wisDGW3h54pxsknbfQeQMCw/y0oPjcunhH3uKyHCnV9g1e+HWz91dAGimMEpLlsDT1YM
 M+Cs8DuqiHma9BNkbiahfIk0JnQtXdO2GYzeFxry0IHKUbRKSAzCETwZGuxaNYBKZO9l
 +qa0sqCcT8jbsg62J/PyIaSqJbgLMMicujZacdhQg5QgVF31FYs3qCLEuxuOwQcnEQSU
 CBDFuccZ5uZ8n3dmHK6yBxU0pGSUuDAJMal7ea+y34WHbhWcTZljI9gb2jwxDuDclG2a
 m14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786956177; x=1787560977;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x622Wrre38R1Vn44VSt++jkbOnTxGwZvj5cTSBQsfXw=;
 b=hn3SEXRdyxqoX/Rvq8onvS/M+DOv94gbLiJeQL0J1JW9mP8NFjfn6MQeWdvOhfgrU7
 UU3AKiiFrntOLxEedkE7+PXHtWSq8LUXBEp03/mQIp7d2SwwZkDTiqpoMEq54eGTPmFA
 qGwLmEA7l6rSv/eQy50GcOfwRCTIjKRtAH8uRu1t4Tcd0Uirg/rf6FKWb7kWuecxtkBC
 WUv7GNfrhJsehEDEO0fTsdraAAIc0y1M9btNb0uIpdt/SNJmTxs4C98alR/3AXlgBs24
 WnevC7KRV4HJZQYe7nNAFdjh+Gf6uryqtyCCETMgEniZJaKBs/NxsT5Sebm180GhJmIu
 0hbw==
X-Gm-Message-State: AOJu0YxaJnmb5V+UmtwItrCMkCAn2LCYG5Atq8NmqcJMrpvOSRAQ2a4Y
 Z4F70YFgFsNrcSoERN4oVAPF3K2OML10pUtATjys0lhRAzXLEkROS30OuQ8ZeZAVSXU9mIiJ7ft
 lTyedCg==
X-Gm-Gg: AR+sD10rXKeCOE7WhYiaycBRu4Gqm3dzTK97DW0FQfTIt0TguuXY8FXxsMmLd8EvIDD
 am4sF6W1UQPHckpDnXmKy4ljJLs+5DANkw6dKzeNzoXpc4/8MCAC1nQmLvQJzyUjTnQzfDBTL4r
 Z8Fp9XZKCEbJM5pe5ykZHVhFs1ZV9HGVfT/aaO7vLKzmN4tvm7hrevwqAvWVdHUKJo4kasIKG/N
 It5kmY17vLmL1e3tzNNCv5gCYxgwmYV3FKlf7YaFo4B3B2yUGKTF9qc63oI+WFSCcVWJS0WnQX+
 ThepCAuPkcJnSQPqr2Oebiqu/vPeudrq7XgVP2yQy/IQfW19Tv1astKyV3mzmo3BBpURNhlLwuV
 wsgkzCbrT9I+REXridDn67ixJ/JvyIx9xqQcsieE9jq+hEO4DdrtzF6JVGJ1jlAXge3J9mbP4um
 DzKZhHd8Z6kcsGje3nmO2s7WdWdWMgT5vp5tK9MhNcbGJww0ceITVF5TZ+UboC62QDfA2vzoDqs
 iqeBIDGezDVAklvRYEM1DXPpI7PHgUZhT2kBzW50vQszLSSYBA2
X-Received: by 2002:a05:6000:46c9:b0:481:5eab:e1ba with SMTP id
 ffacd0b85a97d-481607bb9f7mr26744691f8f.30.1786956177425; 
 Mon, 17 Aug 2026 01:42:57 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de.
 [37.24.206.209]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a6c449dbsm897264f8f.8.2026.08.17.01.42.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 01:42:56 -0700 (PDT)
Message-ID: <d6e603bf-8dc5-4ac7-842f-ff9d1f67b98f@suse.com>
Date: Mon, 17 Aug 2026 10:42:58 +0200
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
In-Reply-To: <1858e8e6-73fa-4017-93e2-c733fbf0ec8d@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=jbeulich@suse.com; helo=mail-wr1-x42d.google.com
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

On 14.08.2026 17:23, Chuck Zmudzinski wrote:
> On 8/14/2026 9:46 AM, Jan Beulich wrote:
>> On 14.08.2026 15:18, Chuck Zmudzinski wrote:
>>> On 8/14/2026 3:35 AM, Jan Beulich wrote:
>>>> On 14.08.2026 02:45, Chuck Zmudzinski wrote:
>>>>> On 8/13/2026 6:35 AM, Jan Beulich wrote:
>>>>>> On 02.08.2026 07:08, Chuck Zmudzinski wrote:
>>>>>>> -- snip --
>>>>>>> To address this problem, this patch implements support for
>>>>>>> Intel IGD devices with an extended VBT and OpRegion version 2
>>>>>>> and higher which is required for most modern Intel IGD devices.
>>>>>>
>>>>>> First of all: Where's the spec of all of this?
>>>>>
>>>>> Well, your first question is quite provocative. Certainly more
>>>>> social/legal than technical.
>>>>
>>>> Well, it was very much meant to be technical. I've had a hard time following
>>>> what your new code does, and having a spec to hand would likely have helped.
>>>
>>> I agree that having the spec at hand would be better. To be more precise, I
>>> can say that what this patch essentially does is port the support for
>>> the extended VBT with OpRegion 2+ for the Intel IGD passthrough that exists
>>> in KVM/vfio to Xen. Should I explicitly say in the title of the commit
>>> message that this is a port of KVM/vfio support for extended VBT to Xen?
>>
>> Not in the title, as that would likely make it too long, but perhaps in the
>> description.
> 
> Ok.
> 
>>
>>>>> So my answer is as follows:
>>>>>
>>>>> I do not have access to the official spec that defines "all this" but
>>>>> I do have access, as does the general public, to the Linux kernel's
>>>>> implementation of support for the Intel IGD from many sources such as
>>>>> git.kernel.org. The Linux kernel has enough accurate information about
>>>>> the spec of "all this" to provide very good support for the Intel IGD
>>>>> on bare metal.
>>>>>
>>>>> To elaborate a bit more, the spec of "all this" can be derived from the
>>>>> Linux kernel code that supports the Intel IGD.
>>>>
>>>> So you expect every reader to locate and decipher the underlying information
>>>> from a (afaik) pretty large piece of code in the Linux kernel? If the Linux
>>>> kernel sources are the reference, please can you at least provide pointers
>>>> into there?
>>>
>>> No, I do not expect every reader to decipher the underlying information...
>>>
>>> That is why I provided these two links at the bottom of the commit message.
>>> Perhaps you did not notice them:
>>>
>>> Link: https://lore.kernel.org/kvm/20211012124855.52463-1-colin.xu@gmail.com/
>>> Link: https://lore.kernel.org/kvm/20210325170953.24549-1-fred.gao@intel.com/
>>>
>>> They are the patches to the vfio kernel driver that added support for the
>>> extended VBT for KVM/vfio guests.
>>
>> Patches can still be in flight, so provide only limited help. Would it be a
>> problem to instead reference commits, or the actual localtion in Linux
>> sources?
> 
> No problem. I will format references to kernel commits the way it was done in
> this commit message of commit 99794c8a8ff8 in the Xen tree that references
> some Linux kernel commits unless you suggest a better way to reference Linux
> kernel commits:
> 
>  xen/acpi: Import PPTT definitions from Linux
> 
> Import the Processor Properties Topology Table (PPTT) definitions
> from the Linux kernel header (include/acpi/actbl2.h) into Xen.
> 
> Signed-off-by: Hirokazu Takahashi <taka@valinux.co.jp>
> Origin: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git b8355bcac253
> Origin: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git e62f8227851d
> Origin: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git 091c4af3562d

I expect though that Origin: tags would be questionable to use in your case.
Can't you simply use URLs pointing at the commits in Lunus'es tree?

>>>>>>> +    printf("VBT size: 0x%x\n", rvds);
>>>>>>> +
>>>>>>> +    if ( !rvds || !rvda_host ) {
>>>>>>> +        printf("guest OpRegion address: 0x%x\n", igd_guest_opregion);
>>>>>>> +        rvda_host = 0;
>>>>>>> +    }
>>>>>>> +    /*
>>>>>>> +     * Write rvda_host as 2 successive 32-bit values
>>>>>>> +     * to communicate location of the VBT to the device
>>>>>>> +     * model. If rvda_host is not 0, The device model
>>>>>>> +     * unmaps the OpRegion and eventually maps the VBT
>>>>>>> +     * after we also write the guest address where the
>>>>>>> +     * VBT will be mapped.
>>>>>>> +     *
>>>>>>> +     * If we send rvda_host = 0 to the device model, it
>>>>>>> +     * will assume we do not need OpRegion 2 support and
>>>>>>> +     * it will not unmap the OpRegion.
>>>>>>> +     */
>>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>>> +               (uint32_t)(rvda_host & 0xfffffffful));
>>>>>>> +    unsigned long rvda_host_upper_32 = (uint64_t)rvda_host >> 32;
>>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>>> +               (uint32_t)rvda_host_upper_32);
>>>>>>
>>>>>> Why would you need to communicate a host property to the DM?
>>>>>
>>>>> The DM cannot access the host rvda value because it is only accessible
>>>>> from the host kernel, and the DM is only a user-space process on the host.
>>>>
>>>> I don't follow this: Anything the guest can access should also be accessible
>>>> by its DM.
>>>
>>> I think the host OpRegion is not currently accessible by the DM.
>>
>> Can you explain to me how the region becomes accessible to the guest?
>> That would then (hopefully) help me understand why the DM would not have
>> access. Fundamentally any MMIO and any I/O ports that are assigned to a
>> guest are also assigned to its DM.
> 
> Currently, in the device model (Qemu) we have:
> 
>     ret = xc_domain_memory_mapping(xen_xc, xen_domid,
>             (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT),
>             (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
>             XEN_PCI_INTEL_OPREGION_PAGES,
>             DPCI_ADD_MAPPING);
> 
> That statement is in the igd_write_opregion(...) function in the
> hw/xen/xen_pt_graphics.c file of the upstream Qemu source.
> 
> If I understand our current implementation correctly, this statement
> is what gives the guest access to the host OpRegion (3 pages as defined
> by XEN_PCI_INTEL_OPREGION_PAGES, and in agreement with IGD_OPREGION_PAGES
> in hvmloader code).

No, it introduces mappings of those pages into the guest's P2M.

> I don't think this statement makes the host OpRegion
> accessible to the device model, though, so I think, if I understand your
> comment in an earlier about my patch resulting in what you called a "layering
> violation" correctly, that our current implementation is also guilty of this
> same kind of "layering violation."

That code, if it can be successfully executed, indeed doesn't grant any
permissions (to the DM or the guest). Instead it proves that the DM has the
needed permissions to access the pages itself. This is what the handling of
XEN_DOMCTL_memory_mapping has in this regard:

        ret = -EPERM;
        if ( !iomem_access_permitted(current->domain, mfn, mfn_end) )
            /* Nothing. */;

Subsequently we check that the guest is also permitted access:

        else if ( iomem_access_permitted(d, mfn, mfn_end) )

Jan

