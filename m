Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA619C5DF70
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvtNE-0003sP-Qp; Mon, 17 Aug 2026 05:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1wvtND-0003pi-Rh
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 05:11:15 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1wvtNB-0002p8-Mk
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 05:11:15 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so29941625e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 02:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786957871; x=1787562671; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=h0XiEa/dg7Ps/rOaNVwO3/fLFGtu4AMy8RPHfE0rkwQ=;
 b=g5oWXkvef0d7J5FnNYIX3VOSVbw0rU7dQJryOBYEFNcmbvbhG3BHrPUxD31nwIMaOB
 9g7MYgijwlKD6Oq6UYpCjRi2fOyH0MS9Z6b01da1azibOiJnQgtg7f+ejrjMqTuVHIpP
 gwJu+HWGrq9C2fKVPZ/UCrQOzpxR8mX7gmxEncIj7T8R/dxhjcoru5Y/DM0cFjmDh5yY
 cOXhMRwpoGgIJ6LKX4wKreoS8RyECZEzQbGsZJMtC64H5rgj6i7U01EWxQYEjXKIj5c3
 Txfo9qTSpxnb98Xkjj0LozcHYiAJzhT0Q/rnuWsVHqv6sHDZG6mU5iBsp0K7QYqyvVjv
 iKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786957871; x=1787562671;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h0XiEa/dg7Ps/rOaNVwO3/fLFGtu4AMy8RPHfE0rkwQ=;
 b=Zf/OU97AAK8NW2nI6J5upE7zotF64pWP0+y7HOWy+p17UPEJeJeqdv35cbg0slYjzq
 fG5+UzGcMyL3CJ0DMfMi1nt4WJipkAX7+2CBmSMbyuN7SmaWqaQyOB0itLMJPpBxhb/6
 /xuweTHH3xpSuwqxe+5frpAwgm30ONzocqryfJermJbr+p1cNSEyTc5l7yZkOIX5CP2I
 YgHhLV8Hs44IgSDQfGl7rCkUsniLejoTv2jpbWR3NV5Nw6pmxo0OLu0zdEUNSEKISDFf
 40pCuLjQGrwFggzTIkoXaKhXhHf3AUd+qqfLcQdg/kwXAYqumuWBDdSBX3W1VpHJjzCf
 VALw==
X-Gm-Message-State: AOJu0YwvzIE6g6r3D1CJXlxG8rq/OnSptLSwC2R1+yhuqzPjeM7lF9Rq
 tf1NJpyH8Kg4Mr2ZqqDIEpXsqTtJkYdt+yiZXnNp4TCRipjaDG+/FAv1AL6OQY8Z443vR26JvWs
 qNBMVeQ==
X-Gm-Gg: AR+sD13JkTMCZqqeoPQ04+Q/jrcaWGF9r8ajS2RUVFPMgOzB/1ANf4k7GViZ12TdUBM
 9n/VvRBHm/QJO5iCvkkDFG5OT4KUzEt79duH3JWVNLJ1obNCil7I3IYvCUbbeE+gQPB/PcHkSXj
 DyRWgT7KXeSIAIAwy1kmz+kVMY8qvgz1oslpYoTx8AbFnG5P0cHqMtnc2ESSxt7d5EjE/9+El7M
 bHTGkvc32zm9ypGldNzKuS49U0046+ANMDluqXspOsubfcVTro0JYx9CwDxu9iynnXGRgBqMsDw
 BtRHDnITLSxhcc/S7tbKMJtixg6x68dIXryu8GVjorkh92ySDOIiCVCb/0hcIBbluMC/ZDT3iIo
 xvONRGcNLzOJZRQHW8lu8vQPEZEDb5iaEPZbNCF2AnUyw0EI7ZELau7PQ/xZ75Z9kiC5RQ3yBAz
 2OXCcOekrOnM4q7AjYhFHiIp/JDb6pNcLGXJbFKgliwp3yOixc+6yn6rD5twFceD9DetmqU0NkI
 BRk5AtizQbec2PiKfCIADROA/kBjRqZ4LIVoj/sALpEV54cC6oqMA==
X-Received: by 2002:a05:600c:3398:b0:499:52dd:c1f0 with SMTP id
 5b1f17b1804b1-499879298c4mr237379625e9.1.1786957871379; 
 Mon, 17 Aug 2026 02:11:11 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de.
 [37.24.206.209]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999610966dsm172724165e9.5.2026.08.17.02.11.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 02:11:10 -0700 (PDT)
Message-ID: <4f2c7c16-74b8-4a93-868e-94628bb9fa78@suse.com>
Date: Mon, 17 Aug 2026 11:11:12 +0200
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
 <de56c8bd-f0e8-4fe9-8cf5-f6807698176c@aol.com>
 <02a7dc18-4184-4e86-84cb-121769187f71@suse.com>
 <9cf5c34b-65a9-4e19-8dfb-9f1264988d5b@aol.com>
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
In-Reply-To: <9cf5c34b-65a9-4e19-8dfb-9f1264988d5b@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=jbeulich@suse.com; helo=mail-wm1-x332.google.com
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

On 15.08.2026 04:22, Chuck Zmudzinski wrote:
> On 8/14/2026 9:46 AM, Jan Beulich wrote:
>> On 14.08.2026 15:18, Chuck Zmudzinski wrote:
>>> On 8/14/2026 3:35 AM, Jan Beulich wrote:
>>>> On 14.08.2026 02:45, Chuck Zmudzinski wrote:
>>>>> On 8/13/2026 6:35 AM, Jan Beulich wrote:
>>>>>> On 02.08.2026 07:08, Chuck Zmudzinski wrote:
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
> This is what I don't understand about your objection to how both the current
> implementation and my proposed changes makes the host OpRegion accessible to
> the guest. What do you mean when you say any MMIO and I/O ports assigned to
> a guest are also assigned to its DM? What does it mean to assign an MMIO
> region to a DM? Is it the DM you mean or the DM domain, which need not be
> dom0 if we are running the device model in an unprivileged domain.

The DM domain is what I meant. I thought that was clear / unambiguous here,
but apparently it wasn't: Sorry. Beyond that I hope that my reply to your
earlier mail provides sufficient further context.

> I also
> am presuming you know that dom0 for Intel IGD passthrough is a PV dom0,
> not a PVH dom0. I have never tried Intel IGD passthrough with a PVH dom0,
> because as far as I can tell vt-d is not supported with PVH dom0.

I don't see why PVH Dom0 would start to matter here all of the sudden.

> Take a look at this code from our current implementation in qemu-xen. This
> is from the current master branch of qemu-xen on xenbits.xen.org, the
> hw/xen/xen_pt_graphics.c file, the igd_write_opregion function:
> 
> --- snip ---
> 
> #define XEN_PCI_INTEL_OPREGION_PAGES 0x3
> #define XEN_PCI_INTEL_OPREGION_ENABLE_ACCESSED 0x1
> void igd_write_opregion(XenPCIPassthroughState *s, uint32_t val)
> {
>     int ret;
> 
>     if (igd_guest_opregion) {
>         XEN_PT_LOG(&s->dev, "opregion register already been set, ignoring %x\n",
>                    val);
>         return;
>     }
> 
>     /* We just work with LE. */
>     xen_host_pci_get_block(&s->real_device, XEN_PCI_INTEL_OPREGION,
>             (uint8_t *)&igd_host_opregion, 4);
>     igd_guest_opregion = (unsigned long)(val & ~XEN_PCI_INTEL_OPREGION_MASK)
>                             | (igd_host_opregion & XEN_PCI_INTEL_OPREGION_MASK);
> 
>     ret = xc_domain_iomem_permission(xen_xc, xen_domid,
>             (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
>             XEN_PCI_INTEL_OPREGION_PAGES,
>             XEN_PCI_INTEL_OPREGION_ENABLE_ACCESSED);

So this is where permissions are granted (wrongly imo, as I think permissions
for MMIO or I/O ports should only ever be granted by the control domain).

>     if (ret) {
>         XEN_PT_ERR(&s->dev, "[%d]:Can't enable to access IGD host opregion:"
>                     " 0x%lx.\n", ret,
>                     (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT)),
>         igd_guest_opregion = 0;
>         return;
>     }
> 
>     ret = xc_domain_memory_mapping(xen_xc, xen_domid,
>             (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT),
>             (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
>             XEN_PCI_INTEL_OPREGION_PAGES,
>             DPCI_ADD_MAPPING);

This is where, as said in the earlier reply, a mapping is installed in the
guest's P2M.

>     if (ret) {
>         XEN_PT_ERR(&s->dev, "[%d]:Can't map IGD host opregion:0x%lx to"
>                     " guest opregion:0x%lx.\n", ret,
>                     (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
>                     (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT));
>         igd_guest_opregion = 0;
>         return;
>     }
> 
>     XEN_PT_LOG(&s->dev, "Map OpRegion: 0x%lx -> 0x%lx\n",
>                     (unsigned long)(igd_host_opregion >> XC_PAGE_SHIFT),
>                     (unsigned long)(igd_guest_opregion >> XC_PAGE_SHIFT));
> }
> 
> [...]
> 
> Do you understand now?

Yes, and as said in the earlier reply: This demonstrates that the DM does
have permission to access the pages in question.

Jan

