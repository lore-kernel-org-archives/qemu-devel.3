Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EF5CFD347
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 18:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNbRZ-00065t-Sn; Mon, 24 Nov 2025 13:37:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vNbRY-00064Z-Et; Mon, 24 Nov 2025 13:37:44 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vNbRW-0007YE-Op; Mon, 24 Nov 2025 13:37:44 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 26E524395E;
 Mon, 24 Nov 2025 18:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20B2C4CEF1;
 Mon, 24 Nov 2025 18:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764009454;
 bh=6vSYOm/w1nH31h/tLpAluGjbv2+KaYbc3h4Rq2s0UVs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z+x07sTMpzB8H6QVgT0c6V5ELY+mlkLuBEVuxnDntszNdR37ZQRnbsm03Hgrm4q/v
 afbNesvl9G/cLvxqEOXFwSGkX5gngfrZWOTTq1Zlo5fZwQ6QDV7pzxCETy11JnP4hY
 R6hAn1IWgcgr4F83A5ng2oZpLGMvt+ygzTUGjST66p3cfiTHLSrB44ocP3WUEze4fo
 RmIIEGDNbvYX4P83KTdJS/5jp8xA/1BloFCY7Sr/AOLi+HmNgP0sYsZ08mA6kCB+Ra
 lSNbS4RJxOjYEeWob1mbyeKfCcd61JR+4rXHmVyXCDVTilXG6rpiK7SITn1NRcT7Kx
 tvTk1A+QpySwg==
Date: Mon, 24 Nov 2025 10:37:31 -0800
From: Drew Fustini <fustini@kernel.org>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
 Atish Kumar Patra <atishp@rivosinc.com>,
 Atish Patra <atish.patra@linux.dev>,
 Vasudevan Srinivasan <vasu@rivosinc.com>,
 yunhui cui <cuiyunhui@bytedance.com>,
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn,
 qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org
Subject: Re: [PATCH 3/7] hw/riscv: implement CBQRI capacity controller
Message-ID: <aSSl6+i5fa4+kD3Q@x1>
References: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
 <20251119-riscv-ssqosid-cbqri-v1-3-3392fc760e48@kernel.org>
 <DEDROLF9I9YQ.2MQIEGB7I4BKH@ventanamicro.com> <aSDCmrvONUgvzqbV@x1>
 <DEH356RBYAIG.IS7SP4D5XLIQ@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DEH356RBYAIG.IS7SP4D5XLIQ@ventanamicro.com>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=fustini@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Nov 24, 2025 at 06:02:37PM +0100, Radim Krčmář wrote:
> 2025-11-21T11:50:50-08:00, Drew Fustini <fustini@kernel.org>:
> > On Thu, Nov 20, 2025 at 08:25:44PM +0100, Radim Krčmář wrote:
> >> 2025-11-19T16:42:19-08:00, Drew Fustini <fustini@kernel.org>:
> >> > +static void riscv_cbqri_cc_realize(DeviceState *dev, Error **errp)
> >> > +{
> >> > +    RiscvCbqriCapacityState *cc = RISCV_CBQRI_CC(dev);
> >> > +
> >> > +    if (!cc->mmio_base) {
> >> > +        error_setg(errp, "mmio_base property not set");
> >> > +        return;
> >> > +    }
> >> > +
> >> > +    assert(cc->mon_counters == NULL);
> >> > +    cc->mon_counters = g_new0(MonitorCounter, cc->nb_mcids);
> >> > +
> >> > +    assert(cc->alloc_blockmasks == NULL);
> >> > +    uint64_t *end = get_blockmask_location(cc, cc->nb_rcids, 0);
> >> > +    unsigned int blockmasks_size = end - cc->alloc_blockmasks;
> >> > +    cc->alloc_blockmasks = g_new0(uint64_t, blockmasks_size);
> >> > +
> >> > +    memory_region_init_io(&cc->mmio, OBJECT(dev), &riscv_cbqri_cc_ops,
> >> > +                          cc, TYPE_RISCV_CBQRI_CC".mmio", 4 * 1024);
> >> 
> >> Shouldn't the region size take cc->ncblks into account?
> >> (A bitmask for 2^16 ids is 8kB.)
> >
> > cc_block_mask field is BMW / 8. In the case of NCBLKS of 12 and NCBLKS
> > of 16, both end up with a BMW of 64 which would be 8 bytes. I think the
> > the only reason the allocation is 4KB is that is meant to be aligned to
> > the page size. Otherwise, the capacity controller register layout is
> > pretty small.
> 
> I understood NCBLKS as the amount of bits in the capacity bitmask, and
> NCBLKS in encoded in a 16 bit field, which means up to 65536 bits.
> Is there a lower limit?

Ah, yes, thank you for correcting me. NCBLKS can be 2^16 therefore BMW
can be 8 KB: 

x = 65536
x += 63 => 65599
x /= 64 => 1024
x *= 64 => BMW is 65536 bits
cc_block_mask = BMW/8 = 8192 bytes

This would yield capacity register layout:

cc_capabilities	8
cc_mon_ctl	8
cc_mon_ctr_val	8
cc_alloc_ctl	8
cc_block_mask	8192
cc_cunits	8

Thus I think the mmio size would need to be: (BMW/8) + 40

In the max NCBLKS case, that would be 8,232 bytes. I am wondering if
that a problem as it would not be aligned on a 4 KB page boundary. Do
you think that would be a problem?

Thanks,
Drew

