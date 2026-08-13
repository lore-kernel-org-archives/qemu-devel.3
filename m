Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DF1C5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSmf-0006AS-7p; Thu, 13 Aug 2026 06:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1wuSmS-00060n-LR
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:35:28 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1wuSmP-0000EW-KY
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:35:24 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so14134475e9.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 03:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786617317; x=1787222117; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E6bsn9NFfxkJnh520dPejRsEERuDcuHfX7DObfEzi1s=;
 b=dKDtzo9+irPUkQSNWrZgnn0JhQMpOOhQu0b8dKaJU2GyUh0dbiB+49Hpa7FP63kumH
 NcCptDO1BVuOp+QuqxcD/js/yHSgzYWDVGq1RLFk3n42Lr2aRX1sxJjuUnSaEHS00HeO
 +CXDCk+eQY8XClqQQIk7ffyu08DGXL9Su1b27YeU2Egoi0Rey49a3U9SaYxo3zWlPVyV
 hhJVc9ofwMwzvEK826flqoQoSxL6omz70e5ppLRU7J9j+jNKrRVJhbiIzcczalM6RujO
 CNIQq2lA9ChJzN5Gx5dThcr/pe4eVbkYmG3Xr49/1xw3JI86jchT93/ptj4pK3spN2HF
 WL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786617317; x=1787222117;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E6bsn9NFfxkJnh520dPejRsEERuDcuHfX7DObfEzi1s=;
 b=Kp5i6ya5koesvZ/KZjbqNqk/Dx6Mr9ETJpaTiegqgGuZl0ErdVYu4MLBYZJmtHR6DH
 zXK49VR124UCP14+k8yw/Gx0+WnDF2uRaNh20yDGcxRijY6HCAxDgAsSsGrq+Jzg4wCp
 tWVWhf9LD19NWQqgdYZ4/5rMQfcNiYucF9HbvEJZCQLdbPu5zCBadfaSNydJ5tZ+FkbC
 W7mFei+ycoFuXrTLpg8hPMkuXFpOKmBySuhSDBz7PbdzGlcbJKCHsq75djIiISBGiWG5
 2hwZF9cmvjWX7W4wjKGBdSatqteZ0zZ8eah2Xakr4g8HJqgc5ervg1B0eg5uD559E2kV
 gnOQ==
X-Gm-Message-State: AOJu0YxjiqSTOFTDyVFGgPV4tpL/tbFlYnozq7Vh0TNQ1LoHkETcDbsR
 pRzeGcqbg8krDqfHJ835UDS/g7eyh0Is6VAfw/ssZJOw9unm0hk8uy6XSqmnCU8T9Q==
X-Gm-Gg: AR+sD11jUxw3IsddOeS31SKezDd7CWXxFsxyVrYNNjzKnfnyN6Q9wolz7Zxud7Wd6LF
 PIt1em5W1UZZlcuak8wkof2+MLbUbTqc6ihNF8OKJJOh7lUAvJh1ywFHecPhFkCFQMhGooDv0G5
 Ur6BGDF4iroPshn2u3BgXBO2PPCkWQDqnCuYhlxcE6sg2QmuQP8l84NsaQu5JCblM67R7s0OjhY
 3ExWlxModWIy52gu1TPjLVoN0to5NYbjGnhCaDzsFnxttxPBmNaYNComjwM5wsawkVRL7F7v/Uw
 8VUAJIShp5nRK5PtJnEr/FEve6K5T+MRKzNXss5XXnLyCyj2O1lJe7gxQrPy/UCVKw1WyjDO8LD
 IuYgWZ0T5M5ejJ0lf0kC55AK8NLOIPjEbjhD5yY09/6Z/Wtv+bLfIA/ekRsDtqhzYXfNLf0Za/z
 BN+XXBtbgBMHpV8Xke8htEAABdvYMqA6r5wTdH1on5eFKUHDTpdvQkLLf3LDWeWTt+NmYQN1A+V
 XcfK8oem8Qq9CmH27BrdSnYfPf+XVSTlFKpxd1DN1yBhD8DpWRw
X-Received: by 2002:a05:600c:3113:b0:493:c634:952 with SMTP id
 5b1f17b1804b1-499821aa438mr45883185e9.7.1786617317332; 
 Thu, 13 Aug 2026 03:35:17 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de.
 [37.24.206.209]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981e47441sm41360855e9.4.2026.08.13.03.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 03:35:16 -0700 (PDT)
Message-ID: <2110d4b7-ae37-47aa-99be-ab59e16f6167@suse.com>
Date: Thu, 13 Aug 2026 12:35:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools/hvmloader: implement Intel IGD extended VBT
 support
To: Chuck Zmudzinski <brchuckz@aol.com>
Cc: qemu-devel@nongnu.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>,
 xen-devel@lists.xenproject.org
References: <20260802050824.10554-1-brchuckz.ref@aol.com>
 <20260802050824.10554-1-brchuckz@aol.com>
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
In-Reply-To: <20260802050824.10554-1-brchuckz@aol.com>
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

On 02.08.2026 07:08, Chuck Zmudzinski wrote:
> Modern Intel IGD devices do not work well with the current
> implementation of support for the Intel IGD in hvmloader because
> it lacks support for an extended video bios table (VBT).
> 
> Code 43 errors in Windows guests and failure of the guest screen
> to light up are some of the problems that occur with the
> current implementation.
> 
> To address this problem, this patch implements support for
> Intel IGD devices with an extended VBT and OpRegion version 2
> and higher which is required for most modern Intel IGD devices.

First of all: Where's the spec of all of this?

> ---
>[...]
> 
>  tools/firmware/hvmloader/Makefile         |   1 +
>  tools/firmware/hvmloader/config.h         |  15 +-
>  tools/firmware/hvmloader/e820.c           |   4 +-
>  tools/firmware/hvmloader/intel_opregion.c | 297 ++++++++++++++++++++++

Nit: Please use dashes in favor of underscores in new files' names.

> --- a/tools/firmware/hvmloader/Makefile
> +++ b/tools/firmware/hvmloader/Makefile
> @@ -35,6 +35,7 @@ OBJS += smp.o cacheattr.o xenbus.o vnuma.o
>  OBJS += e820.o pci.o pir.o ctype.o
>  OBJS += hvm_param.o
>  OBJS += ovmf.o seabios.o
> +OBJS += intel_opregion.o

While this list isn't well sorted, I think your addition still wants to move
up by a line.

> --- a/tools/firmware/hvmloader/config.h
> +++ b/tools/firmware/hvmloader/config.h
> @@ -7,9 +7,6 @@
>  enum virtual_vga { VGA_none, VGA_std, VGA_cirrus, VGA_pt };
>  extern enum virtual_vga virtual_vga;
>  
> -extern unsigned long igd_opregion_pgbase;
> -#define IGD_OPREGION_PAGES 3
> -
>  struct bios_config {
>      const char *name;
>  
> @@ -43,6 +40,18 @@ extern struct bios_config ovmf_config;
>  
>  #define PAGE_SHIFT 12
>  #define PAGE_SIZE  (1ul << PAGE_SHIFT)
> +#define IGD_OPREGION_PAGES 3
> +#define IGD_OPREGION_SIZE ((IGD_OPREGION_PAGES - 1) << PAGE_SHIFT)

This is odd, and hence wants a comment.

> +#define IGD_OPREGION_RVDA 0x3ba
> +#define IGD_OPREGION_RVDS 0x3c2
> +#define IGD_OPREGION_VERSION 0x16
> +#define IGD_OPREGION_MASK 0xfff
> +#define IGD_OPREGION2_SUPPORT_MASK 0x1
> +#define IGD_OPREGION_SIGNATURE "IntelGraphicsMem"
> +#define IGD_VBT_SIGNATURE "$VBT"
> +extern unsigned long igd_opregion_pgbase;
> +extern uint32_t igd_opregion_e820_pages;
> +void intel_opregion_setup(uint32_t vga_devfn);

Blank lines please ahead of the new #define-s you add and between those new
#define-s and the new decls.

For igd_opregion_e820_pages I further cannot spot any use which would justify
the use of a fixed-width type; unsigned int will do, and will then be in line
with ./CODING_STYLE.

> --- a/tools/firmware/hvmloader/e820.c
> +++ b/tools/firmware/hvmloader/e820.c
> @@ -243,11 +243,11 @@ int build_e820_table(struct e820entry *e820,
>          nr++;
>  
>          e820[nr].addr = igd_opregion_base;
> -        e820[nr].size = IGD_OPREGION_PAGES * PAGE_SIZE;
> +        e820[nr].size = igd_opregion_e820_pages * PAGE_SIZE;
>          e820[nr].type = E820_NVS;
>          nr++;
>  
> -        e820[nr].addr = igd_opregion_base + IGD_OPREGION_PAGES * PAGE_SIZE;
> +        e820[nr].addr = igd_opregion_base + igd_opregion_e820_pages * PAGE_SIZE;

Are these new multiplications at risk of overflowing? I.e. how many pages can
there be in an extreme case?

> --- /dev/null
> +++ b/tools/firmware/hvmloader/intel_opregion.c
> @@ -0,0 +1,297 @@
> +/*
> + * intel_opregion.c: HVM Intel OpRegion setup.
> + *
> + * Leendert van Doorn, leendert@watson.ibm.com
> + * Copyright (c) 2005, International Business Machines Corporation.
> + *
> + * Copyright (c) 2006, Keir Fraser, XenSource Inc.

What do these cover?

> + * Copyright (c) 2026, Charles Zmudzinski.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program; If not, see <http://www.gnu.org/licenses/>.
> + */

Please use an SPDX line instead in new files.

> +#include "util.h"
> +#include "config.h"
> +#include "pci_regs.h"
> +
> +unsigned long igd_opregion_pgbase = 0;
> +uint32_t igd_opregion_e820_pages = IGD_OPREGION_PAGES;
> +
> +static bool verify_opregion(const uint32_t addr)
> +{
> +    const char *opregion_signature = IGD_OPREGION_SIGNATURE;
> +    if ( memcmp((const void *)addr, (const void *)opregion_signature, 16) )
> +        return false;
> +    return true;
> +}

Style: Blank line please between declaration(s) and statement(s) as well as
ahead of the main "return" of a function. There further isn't really a need
for an if() or two return statements here. Also please avoid casts wherever
possible. Finally, the local variable isn't really needed here either - the
string literal can be passed directly to memcmp(). All of this helps
readability as well.

> +static bool verify_vbt(const uint32_t addr)
> +{
> +    const char *vbt_signature = IGD_VBT_SIGNATURE;
> +    if ( memcmp((const void *)addr, (const void *)vbt_signature, 4) )
> +        return false;
> +    return true;
> +}

Same comments here, obviously (and potentially elsewhere).

> +void intel_opregion_setup(uint32_t vga_devfn)
> +{
> +    uint32_t igd_guest_opregion;
> +    uint32_t pages_needed; /* for OpRegion + VBT */

The former probably wants to be fixed-width, but for the latter I see no need.

> +    void *opregion_scratch;
> +    void *vbt_scratch;
> +    void *vbt_source;
> +    /*
> +     * absolute value in the host/guest except
> +     * as noted in the comments
> +     */

Nit: Comment style (see ./CODING_STYLE).

> +    static unsigned long rvda_host;
> +    static unsigned long rvda_guest;

Why static? The function can't be called more than once, if I'm not mistaken.

> +    igd_opregion_pgbase = mem_hole_alloc(IGD_OPREGION_PAGES);
> +    /*
> +     * Tentative value for the number of pages to reserve
> +     * in the E820 map for the OpRegion and VBT.
> +     *
> +     * This will be the final value for the E820 map if
> +     * the device model lacks support for OpRegion 2 or
> +     * if the host OpRegion version is < 2 or if we never
> +     * allocate more pages in the E820 map for the VBT.
> +     */
> +    igd_opregion_e820_pages = IGD_OPREGION_PAGES;
> +
> +    /*
> +     * Read the value the device model is initialized with.
> +     * If the device model supports OpRegion 2, it will
> +     * return the host IGD OpRegion address. If not, it
> +     * will return 0. If the device model does not support
> +     * OpRegion 2, the device model expects us to give it
> +     * the address to which it will map the OpRegion in the
> +     * guest and then expects us to do nothing more to setup
> +     * the OpRegion, so that is all we will do in that case.
> +     */

Hmm, exposing the host opregion to a guest certainly feels like an issue.

> +    const uint32_t igd_host_opregion = pci_readl(vga_devfn,
> +                                                 PCI_INTEL_OPREGION);
> +    if ( !igd_host_opregion ) {

Nit (style) Brace placement (throughout).

> +        printf("device model lacks extended VBT "
> +               "support. Continuing with legacy support only\n");

This message can easily confuse / worry people. (If it was to be kept, it
would also need style adjustment.)

> +        /*
> +         * Write the the OpRegion offset to give the OpRegion
> +         * address to the device model. The device model will trap
> +         * and map the OpRegion at the give address.
> +         */
> +        pci_writel(vga_devfn, PCI_INTEL_OPREGION,
> +                   igd_opregion_pgbase << PAGE_SHIFT);
> +        return;
> +    } else {

No need for "else" after an unconditional "return".

> +        printf("host OpRegion address: 0x%x\n",

The shorter %#x please (also elsewhere).

> +               igd_host_opregion);
> +    }
> +
> +    const uint32_t igd_host_opregion_page_offset =
> +                   igd_host_opregion & IGD_OPREGION_MASK;

I think like in the hypervisor we don't want to mix declarations and
statements just yet.

> +    igd_guest_opregion = (igd_opregion_pgbase << PAGE_SHIFT) |
> +                          igd_host_opregion_page_offset;
> +
> +    /*
> +     * We know at this point the device model supports
> +     * OpRegion 2.
> +     *
> +     * Indicate to the device model that we support
> +     * OpRegion 2 by setting the least significant bit
> +     * of the address we give to the device model.
> +     * The device model will notice this bit set and
> +     * respond appropriately to our writes to the
> +     * register where the OpRegion address is stored.
> +     */

Specifically noticeable here: Please make better use of line length in
long(ish) comments.

> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
> +               (igd_opregion_pgbase << PAGE_SHIFT) |
> +                IGD_OPREGION2_SUPPORT_MASK);

This looks to imply qemu is the only possible device model.

> +    printf("guest OpRegion tentative "
> +           "address: 0x%x\n", igd_guest_opregion);
> +
> +    if ( !verify_opregion(igd_guest_opregion) ) {
> +        printf("error: IGD OpRegion signature "
> +               "not found.\n");

No full stop in messages please.

> +        BUG();
> +    }
> +
> +    opregion_scratch = scratch_alloc(IGD_OPREGION_SIZE, 0);
> +    memcpy(opregion_scratch, (const void *)igd_guest_opregion,
> +           IGD_OPREGION_SIZE);
> +
> +    /* Read OpRegion version, rvda_host, and rvds */
> +    const uint16_t version = *(uint16_t *)(opregion_scratch +
> +                                           IGD_OPREGION_VERSION);
> +    printf("OpRegion version: 0x%x\n", version);
> +    if ( version >= 0x0200 ) {
> +        rvda_host = *(unsigned long *)(opregion_scratch +
> +                                       IGD_OPREGION_RVDA);
> +        /* It is convenient to make rvda_host absolute */
> +        if ( version > 0x0200 )
> +            rvda_host += igd_host_opregion;
> +        printf("host VBT address: 0x%lx\n", rvda_host);
> +    } else {
> +        printf("guest OpRegion address: 0x%x\n", igd_guest_opregion);
> +        rvda_host = 0;
> +    }
> +    const uint32_t rvda_host_page_offset = rvda_host &
> +                                           IGD_OPREGION_MASK;

Why host_page_offset here when ...

> +    const uint32_t rvds = *(uint32_t *)(opregion_scratch +
> +                                        IGD_OPREGION_RVDS);
> +    const uint32_t rvds_page_offset = rvds & IGD_OPREGION_MASK;

... it's just page_offset here, and when further you use it below to set
rvda_guest?

> +    printf("VBT size: 0x%x\n", rvds);
> +
> +    if ( !rvds || !rvda_host ) {
> +        printf("guest OpRegion address: 0x%x\n", igd_guest_opregion);
> +        rvda_host = 0;
> +    }
> +    /*
> +     * Write rvda_host as 2 successive 32-bit values
> +     * to communicate location of the VBT to the device
> +     * model. If rvda_host is not 0, The device model
> +     * unmaps the OpRegion and eventually maps the VBT
> +     * after we also write the guest address where the
> +     * VBT will be mapped.
> +     *
> +     * If we send rvda_host = 0 to the device model, it
> +     * will assume we do not need OpRegion 2 support and
> +     * it will not unmap the OpRegion.
> +     */
> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
> +               (uint32_t)(rvda_host & 0xfffffffful));
> +    unsigned long rvda_host_upper_32 = (uint64_t)rvda_host >> 32;
> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
> +               (uint32_t)rvda_host_upper_32);

Why would you need to communicate a host property to the DM?

> +    /* In this case, we use the mapped OpRegion */
> +    if ( !rvda_host )
> +        return;
> +
> +    /*
> +     * Update the number of pages the device model
> +     * needs to map for us to get a copy of the VBT.
> +     *
> +     * N.B.: Here, igd_opregion_pgbase is really the page
> +     * base of the location where the device model will
> +     * map the VBT.
> +     */
> +    uint32_t vbt_pages_needed = rvds >> PAGE_SHIFT;
> +    if ( rvds & IGD_OPREGION_MASK )
> +        vbt_pages_needed++;
> +    if ( vbt_pages_needed > igd_opregion_e820_pages ) {
> +        igd_opregion_pgbase = mem_hole_alloc
> +                              (vbt_pages_needed - igd_opregion_e820_pages);

Nit: Indentation.

> --- a/tools/firmware/hvmloader/pci.c
> +++ b/tools/firmware/hvmloader/pci.c
> @@ -43,7 +43,6 @@ uint64_t pci_hi_mem_start = 0, pci_hi_mem_end = 0;
>  #define BAR_RELOC_THRESH GB(1)
>  
>  enum virtual_vga virtual_vga = VGA_none;
> -unsigned long igd_opregion_pgbase = 0;
>  
>  /* Check if the specified range conflicts with any reserved device memory. */
>  static bool check_overlap_all(uint64_t start, uint64_t size)
> @@ -190,14 +189,7 @@ void pci_setup(void)
>                  virtual_vga = VGA_pt;
>                  if ( vendor_id == 0x8086 )
>                  {
> -                    igd_opregion_pgbase = mem_hole_alloc(IGD_OPREGION_PAGES);
> -                    /*
> -                     * Write the the OpRegion offset to give the opregion
> -                     * address to the device model. The device model will trap 
> -                     * and map the OpRegion at the give address.
> -                     */
> -                    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
> -                               igd_opregion_pgbase << PAGE_SHIFT);
> +                    intel_opregion_setup(vga_devfn);
>                  }

With this preferably also drop the figure braces.

Jan

