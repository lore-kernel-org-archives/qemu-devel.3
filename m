Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88D5CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUwc-0000Kv-2R; Wed, 07 Oct 2026 12:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xEUwa-0000Jy-5n
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xEUwY-0000EY-2c
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791392197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UatQT68T3Y1N+OsYslNAjwUJIF+/+h1urhB1lsxs2js=;
 b=A9EZXKhb2EMU2W9AZJqVH1ePYO+eryQFjFe0wfJDYmTbmTdL9hGIP1QaDIbiBDTcOV/gb2
 oToobgzAispz+TrCRlsM7GmTQ5ciLhZuBKw28nBOkU609bena/bSkiVsyxMDzHz9R0Cs/O
 Wu4hpOCBs1gPiCz+sVtB0c6w/Je+qRA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-zyLfcaHqNOWLZWu1Y_nYsw-1; Wed, 07 Oct 2026 12:56:36 -0400
X-MC-Unique: zyLfcaHqNOWLZWu1Y_nYsw-1
X-Mimecast-MFC-AGG-ID: zyLfcaHqNOWLZWu1Y_nYsw_1791392195
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48af4a0bd0fso2409326f8f.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791392195; x=1791996995; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UatQT68T3Y1N+OsYslNAjwUJIF+/+h1urhB1lsxs2js=;
 b=ZWoRl1w9qt9gYTMAeYxV7wLkIdCEg8fXwnfyQMajBibhnd5YrngVr1ILqbEvGUZyWV
 4TmYcfcaCT3WE4kd05HSHQlrC0f5YVXjP+hFiBE4EaOYD6VzIm0kK2+oBjJ89N6xGehv
 QLhi0CR2nhM9h9PPoUO4b/xH2aMgGP7esrLK+Urzd3f1awbdd+rTQNSyX0eImQTSVOS8
 VNqXkikcGz93Ma2cuPxmNISI0Pf4RXE1tsznTOvxQ8jsH2lC/zn/MYZhBrBLdkSkOPlb
 3Jxiq9P/xdiXi1ysDqMYv8kAweJJIElYXPjz5lJpE1u7R9BRmwfhNh3pSByFG7nm8SQq
 2y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791392195; x=1791996995;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UatQT68T3Y1N+OsYslNAjwUJIF+/+h1urhB1lsxs2js=;
 b=C+wnOzlwoJ48XUGX9IEvdgnaFkX97j4KhZuM3lXSajAQQ0+tz43/Vl1kHqWgV2GqqN
 BUDTghdqulIUIdeoJwa0aYmqsPNH0SvlqoTA+xpTme7U7Q4L0RKFl16oZOm6zfj9wBh0
 xTSjhbyOgfuudebQIb4ZRhI7RE+ijafwuHEWdMrpKUkyiiddlr3QDAuEmkst/OglUbeL
 YQJ2y1WBZqgunVdkAu7iw5h/YKy0sqx4H4g3Tj45UOz1oWslUhaYTVHJahay/fVoxfUH
 MjhcxCaxIMcA4gGRtGdldtBz25WMmCc57BKGppkcWj+GobMXrOx41MKtKs+IZNmxj87f
 P18g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxU0EmXuu606RtuwKpc924V8qDO/Slq+nckVzFmCUun37E8TsdFVmHO4om4B2pU4ZnTheF6TPDotRRl@nongnu.org
X-Gm-Message-State: AFuF++nEMqFxDsq/0r6MWB1hnanZt9bJx0TKC2H6KufBbXqOUyo4kBpE
 JNvBUn6O/Ww++mNZeVDMKHm+P8+QlI6rcsPbp60Ch/EmfQTN4WUgBLSlVxJg+XmWho2HKyurMPI
 3Vfgp8QR+5ajBVAVKMaGscU0xnSNVRWcbBL+jXF2Z7AFu9izDZZchf9iq
X-Gm-Gg: AYBFou0XZNfnGDL0GWLDroDayPiT77Z3pthMLq/gOE8Td0xs/CAhRRrlU3q5UFfIbCp
 Pa0pG+EuJevEKAQx756af9bR+Ny/5BDR3PqJEhNCkBFGm9AJJnIGLUmiS2NS3eDCMvD6r6lD16d
 vHF0/hZ4PmtlQYqYhIzkwSK/MrWVSc3EJHvFITOuLN62sd8nDH9tUWG5Pb7phSoKYfAgcBmj0u+
 BbzzvBDNQ3M7qCZ5U3pzNdcTMuBPMuhtt73eWu08mcTEH61MvAoMxPp57ximt0qb9XkqNXtMSqo
 OBnO0V7e4hm+DinrIgHG0Ng0gJCzAsicmOp+Hp2ceXg4k41+7nWU7Wt1rA==
X-Received: by 2002:a05:600d:8654:10b0:4a0:2391:6533 with SMTP id
 5b1f17b1804b1-4a1815a2080mr29725685e9.21.1791392194799; 
 Wed, 07 Oct 2026 09:56:34 -0700 (PDT)
X-Received: by 2002:a05:600d:8654:10b0:4a0:2391:6533 with SMTP id
 5b1f17b1804b1-4a1815a2080mr29725405e9.21.1791392194395; 
 Wed, 07 Oct 2026 09:56:34 -0700 (PDT)
Received: from x1 ([151.67.89.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71c0b37csm6193363f8f.9.2026.10.07.09.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 09:56:33 -0700 (PDT)
Date: Wed, 7 Oct 2026 18:56:30 +0200
From: Gustavo Romero <gromero@redhat.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Will Deacon <will@kernel.org>, Itaru Kitayama <itaru.kitayama@linux.dev>, 
 Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH v2 3/3] tests/tcg/aarch64: Add a test for the 52-bit TTBR
 base address layout
Message-ID: <4ajscli4c4ef7agtizxzdiopjseck5qwa6s4n4mmwwjdrqlnby@xit5l76dxm2w>
References: <20261007080019.350315-1-fuad.tabba@linux.dev>
 <20261007080019.350315-4-fuad.tabba@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007080019.350315-4-fuad.tabba@linux.dev>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gromero@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Fuad,

On Wed, Oct 07, 2026 at 09:00:19AM +0100, Fuad Tabba wrote:
> With a 52-bit OA, walk a two-entry level 0 table through an IPA with
> bit 50 set, which stage 2 maps back onto the table, so the walk
> succeeds only if TTBR[4] is cleared from bit 4 of the base address.
> With TCR.DS or VTCR.DS and a 48-bit OA, check that setting TTBR[5:2]
> is a level 0 Address size fault.

Maybe move this commit message to ttbr-baddr.c header and just replace it with
something like "Add a test for checking if with a 52-bit OA a walk ...".

I like better the test split done in v1. There there are two tests and the
changes are clear, helping to understand which parts of the test are related to
each fix.

So the organization I think is better for this series is:

Fix 0
Test 0
Fix 1
Test 1


> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> ---
>  tests/tcg/aarch64/system/meson.build  |   6 +
>  tests/tcg/aarch64/system/ttbr-baddr.c | 197 ++++++++++++++++++++++++++
>  2 files changed, 203 insertions(+)
>  create mode 100644 tests/tcg/aarch64/system/ttbr-baddr.c
> 
> diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
> index f51feb253f..270d4d6c31 100644
> --- a/tests/tcg/aarch64/system/meson.build
> +++ b/tests/tcg/aarch64/system/meson.build
> @@ -79,6 +79,12 @@ tests += {
>                    '-semihosting-config', 'enable=on,arg=2',
>                    qemu_base_args]
>    },
> +  'ttbr-baddr.c': {
> +    'cflags': cflags,
> +    'qemu_args': ['-M', 'virt,virtualization=on', '-cpu', 'max',
> +                  '-semihosting-config', 'enable=on,arg=2',
> +                  qemu_base_args]
> +  },
>  }
>  
>  tests += {
> diff --git a/tests/tcg/aarch64/system/ttbr-baddr.c b/tests/tcg/aarch64/system/ttbr-baddr.c
> new file mode 100644
> index 0000000000..b36c14aa29
> --- /dev/null
> +++ b/tests/tcg/aarch64/system/ttbr-baddr.c
> @@ -0,0 +1,197 @@
> +/*
> + * TTBR base address with a 52-bit layout and a small initial lookup table
> + *
> + * Copyright (c) 2026 Google LLC
> + * Author: Fuad Tabba <fuad.tabba@linux.dev>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <stdint.h>
> +#include <minilib.h>
> +
> +/* from Linux's include/linux/stringify.h */
> +#define __stringify_1(x...) #x
> +#define __stringify(x...)   __stringify_1(x)
> +
> +#define read_sysreg(r) ({                                           \
> +            uint64_t __val;                                         \
> +            asm volatile("mrs %0, " __stringify(r) : "=r" (__val)); \
> +            __val;                                                  \
> +})
> +
> +#define write_sysreg(r, v) do {                     \
> +        uint64_t __val = (uint64_t)(v);             \
> +        asm volatile("msr " __stringify(r) ", %x0"  \
> +                 : : "rZ" (__val));                 \
> +} while (0)
> +
> +#define RAM_BASE    0x40000000UL
> +#define HIGH_IPA    (1UL << 50)
> +#define TEST_VA     (0xffff000000000000UL | RAM_BASE)
> +
> +/*
> + * Stage 1: 16KB granule, 48-bit VA, so level 0 has two entries.
> + * Stage 2: 64KB granule, 52-bit IPA, mapping RAM at its own address and
> + * again at HIGH_IPA.
> + * Stage 2 with VTCR.DS: 16KB granule, 47-bit IPA, mapping RAM flat.
> + */
> +static uint64_t s1_l0[2048] __attribute__((aligned(16384)));
> +static uint64_t s1_l1[2048] __attribute__((aligned(16384)));
> +static uint64_t s1_l2[2048] __attribute__((aligned(16384)));
> +static uint64_t s2ds_l1[2048] __attribute__((aligned(16384)));
> +static uint64_t s2ds_l2[2048] __attribute__((aligned(16384)));
> +static uint64_t s2_l1[1024] __attribute__((aligned(65536)));
> +static uint64_t s2_l2[8192] __attribute__((aligned(65536)));
> +static uint64_t s2_l2_high[8192] __attribute__((aligned(65536)));
> +
> +#define TCR_T0SZ(x)     ((uint64_t)(x) << 0)
> +#define TCR_T1SZ(x)     ((uint64_t)(x) << 16)
> +#define TCR_TG0_16K     (2UL << 14)
> +#define TCR_TG1_16K     (1UL << 30)
> +#define TCR_IPS_48      (5UL << 32)
> +#define TCR_IPS_52      (6UL << 32)
> +#define TCR_DS          (1UL << 59)
> +
> +#define VTCR_T0SZ(x)    ((uint64_t)(x) << 0)
> +#define VTCR_SL0_L1     (2UL << 6)
> +#define VTCR_TG0_16K    (2UL << 14)
> +#define VTCR_TG0_64K    (1UL << 14)
> +#define VTCR_PS_48      (5UL << 16)
> +#define VTCR_PS_52      (6UL << 16)
> +#define VTCR_RES1       (1UL << 31)
> +#define VTCR_DS         (1UL << 32)
> +
> +#define HCR_VM          (1UL << 0)
> +#define HCR_RW          (1UL << 31)
> +
> +#define PAR_F           (1UL << 0)
> +#define PAR_FST(par)    (((par) >> 1) & 0x3f)
> +#define PAR_PA(par)     ((par) & 0xfffffffff000UL)
> +#define FST_ADDR_SIZE_L0    0x00
> +
> +#define S2_BLOCK        ((1 << 10) | (3 << 6) | (0xf << 2) | 1)
> +
> +static void tlb_flush(void)
> +{
> +    asm volatile("dsb sy; tlbi alle1; dsb sy; isb" : : : "memory");
> +}
> +
> +static uint64_t at(uint64_t ttbr1)
> +{
> +    uint64_t par;
> +
> +    write_sysreg(ttbr1_el1, ttbr1);
> +    tlb_flush();
> +    asm volatile("at s12e1r, %1; isb; mrs %0, par_el1"
> +                 : "=r" (par) : "r" (TEST_VA));
> +    return par;
> +}
> +
> +static uint64_t at_s1(uint64_t ttbr1)
> +{
> +    uint64_t par;
> +
> +    write_sysreg(ttbr1_el1, ttbr1);
> +    tlb_flush();
> +    asm volatile("at s1e1r, %1; isb; mrs %0, par_el1"
> +                 : "=r" (par) : "r" (TEST_VA));
> +    return par;
> +}
> +
> +static void setup_tables(void)
> +{
> +    /* Stage 1: TEST_VA -> RAM_BASE, 32MB block, AF */
> +    s1_l0[0] = (uint64_t)s1_l1 | 3;
> +    s1_l1[0] = (uint64_t)s1_l2 | 3;
> +    s1_l2[(RAM_BASE >> 25) & 0x7ff] = RAM_BASE | (1 << 10) | 1;
> +
> +    /* Stage 2 with VTCR.DS: RAM_BASE -> RAM_BASE, 32MB block, AF, RW */
> +    s2ds_l1[0] = (uint64_t)s2ds_l2 | 3;
> +    s2ds_l2[(RAM_BASE >> 25) & 0x7ff] = RAM_BASE | S2_BLOCK;
> +
> +    /* Stage 2: 512MB blocks at RAM_BASE and HIGH_IPA | RAM_BASE, AF, RW */
> +    s2_l1[0] = (uint64_t)s2_l2 | 3;
> +    s2_l1[HIGH_IPA >> 42] = (uint64_t)s2_l2_high | 3;
> +    s2_l2[RAM_BASE >> 29] = RAM_BASE | S2_BLOCK;
> +    s2_l2_high[RAM_BASE >> 29] = RAM_BASE | S2_BLOCK;
> +}
> +
> +static int check(const char *name, uint64_t par)
> +{
> +    int ok = !(par & PAR_F) && PAR_PA(par) == RAM_BASE;
> +
> +    ml_printf("%s: PAR_EL1=%lx %s\n", name, par, ok ? "ok" : "FAIL");
> +    return !ok;
> +}
> +
> +/* A level 0 Address size fault */
> +static int check_fault(const char *name, uint64_t par)
> +{
> +    int ok = (par & PAR_F) && PAR_FST(par) == FST_ADDR_SIZE_L0;
> +
> +    ml_printf("%s: PAR_EL1=%lx %s\n", name, par, ok ? "ok" : "FAIL");
> +    return !ok;
> +}
> +
> +int main(void)
> +{
> +    uint64_t mmfr0 = read_sysreg(id_aa64mmfr0_el1);
> +    uint64_t tcr = TCR_T0SZ(16) | TCR_T1SZ(16) | TCR_TG0_16K | TCR_TG1_16K |
> +                   TCR_DS;
> +    uint64_t base = (uint64_t)s1_l0;
> +    int ret = 0;
> +
> +    ml_printf("TTBR base address test\n");
> +
> +    /*
> +     * PARange 52 bits (FEAT_LPA) and TGran16 with 52-bit addresses
> +     * (FEAT_LPA2)
> +     */
> +    if ((mmfr0 & 0xf) != 6 || ((mmfr0 >> 20) & 0xf) != 2) {
> +        ml_printf("SKIP: no 52-bit PA or no FEAT_LPA2 with 16KB\n");
> +        return ret;
> +    }
> +
> +    /*
> +     * The test runs at EL2 (arg=2) and walks the EL1&0 regime with AT, so
> +     * the EL1 MMU settings below only affect those walks.
> +     */
> +    setup_tables();
> +    write_sysreg(mair_el1, 0xff);
> +    write_sysreg(sctlr_el1, read_sysreg(sctlr_el1) | 1);
> +
> +    /*
> +     * TCR.DS with a 48-bit OA: TTBR[5:2] are base address bits [51:48],
> +     * so setting any of them is a level 0 Address size fault.
> +     */
> +    write_sysreg(hcr_el2, HCR_RW);
> +    write_sysreg(tcr_el1, tcr | TCR_IPS_48);
> +    ret |= check("ips48", at_s1(base));
> +    ret |= check_fault("ips48 ttbr[2]", at_s1(base | (1 << 2)));
> +    ret |= check_fault("ips48 ttbr[4]", at_s1(base | (1 << 4)));
> +
> +    /* The same for VTTBR, with VTCR.DS and a 48-bit PS */
> +    write_sysreg(vtcr_el2, VTCR_T0SZ(17) | VTCR_SL0_L1 | VTCR_TG0_16K |
> +                 VTCR_PS_48 | VTCR_RES1 | VTCR_DS);
> +    write_sysreg(hcr_el2, HCR_RW | HCR_VM);
> +    write_sysreg(vttbr_el2, (uint64_t)s2ds_l1);
> +    ret |= check("ps48", at(base));
> +    write_sysreg(vttbr_el2, (uint64_t)s2ds_l1 | (1 << 2));
> +    ret |= check_fault("ps48 vttbr[2]", at(base));
> +
> +    /*
> +     * 52-bit OA: TTBR[4] is base address bit 50. Through stage 2, the
> +     * table at HIGH_IPA | s1_l0 is s1_l0, so the walk succeeds only if

I struggled a bit to make sense of this part: "Through Stage 2, the table
HIGH_IPA | s1_l0 is s1_l0 ...", not so much for the duplication of s1_l0 in the
text but because Stage 2 uses the s2_l* tables. Any chance you could enhance a
the explanation here?


> +     * TTBR[4] does not also offset the two-entry table by 0x10.
> +     */
> +    write_sysreg(vtcr_el2, VTCR_T0SZ(12) | VTCR_SL0_L1 | VTCR_TG0_64K |
> +                 VTCR_PS_52 | VTCR_RES1);
> +    write_sysreg(vttbr_el2, (uint64_t)s2_l1);
> +    write_sysreg(hcr_el2, HCR_RW | HCR_VM);
> +    write_sysreg(tcr_el1, tcr | TCR_IPS_52);
> +    ret |= check("ips52", at(base));
> +    ret |= check("ips52 ttbr[4]", at(base | (1 << 4)));
> +
> +    return ret;
> +}
> -- 
> 2.39.5
> 

Otherwise:

Reviewed-by: Gustavo Romero <gromero@redhat.com>

As always, free feel to respin it only when you get more review comments.

We probably want an additional review of the series from Richard ;)


Cheers,
Gustavo


