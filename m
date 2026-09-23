Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25187C982EA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9HjP-0006qL-Qo; Wed, 23 Sep 2026 03:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1x9HjO-0006qC-ET
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 03:49:30 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1x9HjL-0000r3-IC
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 03:49:30 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e4ad9so2928895e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 00:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790149764; x=1790754564; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bNNRMwXYfNfMtNHDBcL5O+NwJVmpzrAMXA+Pmy4bEG4=;
 b=Bk671JehiLDi7vNxIq2ZelPdrEZihnvOxlGaxc1P140nTFfr67e/Ao6PCbToKIXFbQ
 9pOGToyWtDYKW60odz4DZ9vPwdQ13ERi+uSSeBKa/zCbxjp+3YtkVgp/axjcI6pYYoeg
 l7B8VE4oMMaNz/lp3NA4sHkuX2V8nEDrXJW/jIpJBlvBUyRM3Bs0JUgmV2Lz2bdUmsi9
 akyMmaDP4vSNOMeV2b4/me8nibUau//0IF832duV6oeFHXRD2TnyXW8zgIFCNejR+ulb
 Z5MKNIVvQPTM39BIvKRMClOOJUAtDTTk2nSHmVCMWBrILTij+6cyUguPAMYGL5dYQAnT
 d3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790149764; x=1790754564;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bNNRMwXYfNfMtNHDBcL5O+NwJVmpzrAMXA+Pmy4bEG4=;
 b=o9EuP+0svRq+LRwkYAKqyUZz3J7jJVaG/Y4VOV4lw+0eMJt/502Zs38HpDjTrbHz/r
 3CUdyJy206hs+e2dc7qg7f/ARkXcdBlxTihy9X2YGkT5odgzgjMNduHqt+pfgqTsBQgP
 he7soViSIHWIKK3lEKD/ILJzO6j1Z72ve2R0qnSYZPMM6lPTRXKUr5y5eE87e2IQQ+ou
 RjqjM4p+zuVEAYmaRddEAdCjuhAtOlnXzvRKHnIsNp5LMZsx+ofm4GsEHmAodyZwsUXz
 kFAHAdfFEwttdga7tgzKypkJMhPn7xoIpqj8izUBahlLJV7YgzW1cvjApc5cSa9/wvZj
 PEcA==
X-Gm-Message-State: AFuF++lK1I/OcR0HD3Vv6lirJ6dbfQIUMVxP+tHCthxnxs3plHXYMWnj
 hkYyzus0QUcBEb/NCj8Bzgy5euRghvpR0cB+7/lOcUl0J/v+eBNeX8Zfq67gcdHDgg==
X-Gm-Gg: AYBFou1Dcr8/N50UhrnYvjN7I9aexpZkXx2j/3DkQjFy8RsoYLeZ8P7tQFQoNIhjvr4
 Gyi0FUDeKB2qUR2GO297dJcG/dzCLafvYQ0Vd5YxtYrQo76Eo6l+W1QMebpnhIluXcR91p0PLEa
 siakm6QLhvhEnk8yZuju6UrzfXhHxGrFN8cvRJ70udM1paoFpcA+AgJw3YwA0IimV32zrxd6ZrE
 WTU4MJi4YXUSC1b2+JWNz4mEgnXe7KUBjNnCB1octerxRENwLUyNPayjG7A0ka+fvla4sXp6Yr1
 8gUgrevLHbmaeMo0QBycK5HHRMNPh+bTuQI+epVh0ojVeh/4EVAN7Bb1IeQAETJ4ZgWWqfH/6hy
 FPIVtGzqpFxTXMpUYD/nIc72R/dkNDnlhax29cro9dMi8GhSr3SZ8+hP1QyO11qyVAHHhm1cFdk
 8kjfjzIqaBNQbDoO3Nj5++fMNvXSeSu+nx6I2tOXEmskXUCJ3KPRzL7PVbsqvXQZTZbckyhqao4
 mLuFUHttT+bDcvUJz9fq+R1QBSMB1rXBFdI+SG42Q21DXAsf5x5I9KVwcpfXfbxbibHA+wF
X-Received: by 2002:a05:600c:46d1:b0:49d:15b9:2a2a with SMTP id
 5b1f17b1804b1-49fdefffe1fmr21341335e9.10.1790149763103; 
 Wed, 23 Sep 2026 00:49:23 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de.
 [37.24.206.209]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde18af34sm53025975e9.6.2026.09.23.00.49.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 00:49:22 -0700 (PDT)
Message-ID: <96c36c5c-eb07-4724-ab73-a6153ced1e33@suse.com>
Date: Wed, 23 Sep 2026 09:49:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] tools/hvmloader: implement Intel IGD extended VBT
 support
To: Chuck Zmudzinski <brchuckz@aol.com>
Cc: qemu-devel@nongnu.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, xen-devel@lists.xenproject.org
References: <20260913032724.62438-1-brchuckz@aol.com>
 <20260913032724.62438-2-brchuckz@aol.com>
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
In-Reply-To: <20260913032724.62438-2-brchuckz@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=jbeulich@suse.com; helo=mail-wm2-x10.google.com
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

On 13.09.2026 05:27, Chuck Zmudzinski wrote:
> Modern Intel IGD devices do not work well with the current implementation of
> support for the Intel IGD in hvmloader because it lacks support for an
> extended video bios table (VBT).
> 
> Code 43 errors in Windows guests and failure of the guest screen to light up
> are some of the problems that occur with the current implementation.
> 
> To address this problem, this patch implements support for Intel IGD devices
> with an extended VBT and OpRegion version 2+ which is required for most modern
> Intel IGD devices, as noted in the Linux kernel vfio commits referenced in the
> Link tags below. This patch ports support for devices with an extended VBT and
> OpRegion 2+ which was added in those commits for KVM/vfio, but adapted for Xen
> HVM guests with PCI passthrough.
> 
> This patch depends on compatible support in the device model. If hvmloader
> detects the device model lacks such support, it will fall back to the
> currently implemented protocol for configuring the OpRegion to provide
> backward compatibiltiy for systems that lack a device model with support for
> an extended VBT.
> 
> The primary reason the OpRegion needs to be patched in some cases is that with
> the addition of the RVDA and RVDS fields to the OpRegion, the OpRegion is not
> position-independent and may need to be patched if it is moved to a different
> address in the guest. This means the current protocol of having the device
> model directly map the unmodified host OpRegion to the guest is not compatible
> with the requiremnts of the newer devices that in some cases require that the
> OpRegion be modified for it to be compatible with the guest address space.
> 
> In this implementation, the device model has the responsibility to read the
> host OpRegion and patch it as needed before exposing it to the guest. Since an
> extended VBT means more pages are needed for the OpRegion, depending on the
> size of the extended VBT, hvmloader has the responsibility to edit the E820
> map to accomodate the additional pages needed to contain the OpRegion + VBT.
> 
> To implement this in hvmloader, use a variable, igd_opregion_e820_pages,
> instead of the constant, IGD_OPREGION_PAGES, to represent the number of pages
> to reserve in the E820 map for the OpRegion + VBT. Also, to remove the
> confusion introduced by setting IGD_OPREGION_PAGES to 3 in an earlier patch
> to account for the fact that the OpRegion is not guaranteed to be aligned on
> a page boundary, reset IGD_OPREGION_PAGES to 2 so it matches the actual size
> of the OpRegion.
> 
> Instead of only writing to the PCI_INTEL_OPREGION register, first read from it
> to provide a way for both hvmloader and the device model to discover if both
> components have support for an extended VBT and more than 3 pages reserved for
> the OpRegion + VBT. The device model detects the read of the register before
> the write to learn that hvmloader has support, and hvmoader detects that the
> device model returns the number of pages to reserve for the OpRegion + VBT
> instead of 0 when it first reads the register to learn that that the device
> model has support. When this new protocol is supported by both hvmloader and
> the device model, the device model will not expose the host OpRegion directly
> to the guest via a direct mapping as the old protocol does but instead exposes
> an emulated copy of the OpRegion and VBT using its ioreq server. This has the
> added benefit of preventing extraneous host memory in the regions before or
> after a non-page-aligned OpRegion that should be confidential to the host from
> being exposed to the guest.
> 
> Testing reveals that when the device model exposes the OpRegion to the guest
> by mapping it to the device model's ioreq server, the Windows Intel IGD
> graphics dirvers are unable to access the OpRegion and report Code 43 errors
> with the result being that the guest screen never lights up. So after the
> device model exposes the OpRegion to the guest using its ioreq server, make a
> copy of it and use a copy of the OpRegion and VBT which is backed by RAM
> allocated to the guest instead of mapped via the ioreq server. This fixes the
> Code 43 errors reported by the Windows IGD graphics drivers.
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/vfio/pci/vfio_pci_igd.c?id=bab2c1990b78
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/vfio/pci/vfio_pci_igd.c?id=49ba1a2976c8
> Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>

Despite the non-negligible number of comments below, I think this is in a
much better shape now.

> --- a/tools/firmware/hvmloader/config.h
> +++ b/tools/firmware/hvmloader/config.h
> @@ -8,7 +8,8 @@ enum virtual_vga { VGA_none, VGA_std, VGA_cirrus, VGA_pt };
>  extern enum virtual_vga virtual_vga;
>  
>  extern unsigned long igd_opregion_pgbase;
> -#define IGD_OPREGION_PAGES 3
> +extern unsigned int igd_opregion_e820_pages;
> +#define IGD_OPREGION_PAGES 2

I wonder if this is a good way of expressing things. Specifying a page
count here kind of implies page alignment. Imo specifying a size in bytes
here would be better, as that then makes more natural that an extra page
needs adding in the legacy case (to account for the area not starting at
a page boundary). See also a comment further down, likely leading to
elimination of most of the users of this constant.

> --- a/tools/firmware/hvmloader/pci.c
> +++ b/tools/firmware/hvmloader/pci.c
> @@ -44,6 +44,7 @@ uint64_t pci_hi_mem_start = 0, pci_hi_mem_end = 0;
>  
>  enum virtual_vga virtual_vga = VGA_none;
>  unsigned long igd_opregion_pgbase = 0;
> +unsigned int igd_opregion_e820_pages = 0;
>  
>  /* Check if the specified range conflicts with any reserved device memory. */
>  static bool check_overlap_all(uint64_t start, uint64_t size)
> @@ -93,6 +94,9 @@ void pci_setup(void)
>      uint16_t class, vendor_id, device_id;
>      unsigned int bar, pin, link, isa_irq;
>      uint8_t pci_devfn_decode_type[256] = {};
> +    uint32_t igd_opregion;
> +    void *opregion_vbt_scratch;
> +    bool opregion_is_direct_mapped;

Please declare these in the narrowest possible scope, i.e. ...

> @@ -192,12 +196,98 @@ void pci_setup(void)
>                  {

... apparently here.

>                      igd_opregion_pgbase = mem_hole_alloc(IGD_OPREGION_PAGES);

Why do you leave this untouched? By splitting the mem_hole_alloc() calls, you
rely on implementation details of that function without there actually being
a need. 

>                      /*
> -                     * Write the the OpRegion offset to give the opregion
> -                     * address to the device model. The device model will trap 
> -                     * and map the OpRegion at the give address.
> +                     * To be compatible with this interface for programming the
> +                     * the PCI_INTEL_OPREGION register, the device model must
> +                     * check if the guest reads the register before it writes
> +                     * to the register. To indicate to the device model that
> +                     * we have support for an extended VBT, we read the
> +                     * PCI_INTEL_OPREGION register before writing to it. If the
> +                     * device model supports an extended VBT, it will return
> +                     * the number of pages needed for the OpRegion + VBT. If
> +                     * not, it will return 0 which indicates that it does not
> +                     * implement this interface for supporting an extended VBT.
> +                     */

This approach will need buyoff by qemu folks before it can be acked here. (Buyoff
doesn't necessarily mean the change must have gone in there first, yet of course
it would be best if things went in that order.)

> +                    igd_opregion_e820_pages = pci_readl(vga_devfn,
> +                                                        PCI_INTEL_OPREGION);
> +                    if ( !igd_opregion_e820_pages )
> +                    {
> +                        /*
> +                         * This case provides backward compatibility with
> +                         * device model versions that lack support for an
> +                         * extended VBT. In this case the device model
> +                         * expects us to allocate an extra page in case the
> +                         * OpRegion is not aligned on a page boundary. Also,
> +                         * in this case, the host OpRegion is direct mapped
> +                         * into the guest.
> +                         */
> +                        igd_opregion_pgbase = mem_hole_alloc(1);
> +                        igd_opregion_e820_pages = IGD_OPREGION_PAGES + 1;
> +                        opregion_is_direct_mapped = true;
> +                    }
> +                    else
> +                    {
> +                        /* Allocate extra pages for an extended VBT */
> +                        if ( igd_opregion_e820_pages > IGD_OPREGION_PAGES )
> +                        {
> +                            igd_opregion_pgbase =
> +                                mem_hole_alloc(igd_opregion_e820_pages -
> +                                               IGD_OPREGION_PAGES);
> +                        }
> +                        opregion_is_direct_mapped = false;
> +                    }
> +                    /*
> +                     * This ensures the OpRegion + VBT does not take up more
> +                     * than 1/32 of the reserved region. Also, we must reject
> +                     * a value of 1 for igd_opregion_e820_pages.
> +                     */
> +                    if ( igd_opregion_e820_pages >
> +                        RESERVED_MEMORY_DYNAMIC_PAGES >> 5 ||

Parentheses please around the shift expression.

The 1/32th also looks to be entirely arbitrary. If so, the comment also wants
to state this fact.

> +                        igd_opregion_e820_pages == 1 )
> +                    {
> +                        printf("too many or too few pages (%u) for OpRegion\n",
> +                               igd_opregion_e820_pages);
> +                        BUG();
> +                    }

Why does this entire if() not live in the "else" branch of the earlier if()?
It's applicable only there afaict.

> +                    /*
> +                     * Write the the OpRegion offset to give the OpRegion

Nit: As you move the comment, please also drop the stray extra "the".

> +                     * address to the device model. The device model will trap
> +                     * and make the OpRegion accessible at the given address.
> +                     * The device model is also expected to verify that the
> +                     * OpRegion is compatible with the guest address space and
> +                     * patch it if necessary to make it compatible.
>                       */

The last sentence of the comment is new, and I fear I don't understand what
it is trying to describe. How can one "patch a region" to "make it compatible"?

>                      pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>                                 igd_opregion_pgbase << PAGE_SHIFT);
> +
> +                    /* Don't use our own copy if OpRegion is direct mapped */
> +                    if ( opregion_is_direct_mapped )
> +                        break;
> +
> +                    /*
> +                     * Windows IGD drivers do not work properly when the
> +                     * OpRegion is exposed by the device model's ioreq server,
> +                     * so make a copy of the OpRegion and use that copy which
> +                     * will be backed by RAM allocated to the guest.
> +                     */

I'm struggling with this comment: What does "do not work properly" mean here?
How the region is backed should be of no interest to the driver?

> +                    opregion_vbt_scratch =
> +                        scratch_alloc(igd_opregion_e820_pages <<
> +                                      PAGE_SHIFT, 0);
> +                    memcpy(opregion_vbt_scratch,
> +                           (void *)(igd_opregion_pgbase << PAGE_SHIFT),
> +                           igd_opregion_e820_pages << PAGE_SHIFT);
> +
> +                    igd_opregion = pci_readl(vga_devfn, PCI_INTEL_OPREGION);

Aren't you reading back here what you wrote above? Why the read then?

> +                    /*
> +                     * The device model will unmap the OpRegion from the ioreq
> +                     * server so we can use our own copy of the OpRegion.
> +                     */
> +                    pci_writel(vga_devfn, PCI_INTEL_OPREGION, igd_opregion);

Despite the comment this looks like black magic: You write back the value
you read. That's hardly expected behavior, and hardly how real hardware
would behave. I think the comment will need extending, and I think this is
another behavioral aspect which needs buyoff by qemu folks.

One further request: As you're already tidying things, would you mind also
correcting the comment on PCI_INTEL_OPREGION's definition (which I think
means "bytes" when it says "bits")?

Jan

