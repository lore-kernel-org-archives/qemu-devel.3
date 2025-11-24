Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68936CFD345
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 18:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNba9-0006Q1-Pv; Mon, 24 Nov 2025 13:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vNbZW-0005gH-11; Mon, 24 Nov 2025 13:46:00 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vNbZU-0000wx-G6; Mon, 24 Nov 2025 13:45:57 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2A93360103;
 Mon, 24 Nov 2025 18:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B3EC4CEF1;
 Mon, 24 Nov 2025 18:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764009953;
 bh=DsLiqUKlZbkTBxGPGK7T0QsWhWUjQggUuXJ1BfiIPzg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qVHIfounDZaTg3eXpqnZrEBXs+ANmSHrw26ZV/vLtmcvjW6ssLRjjUsQwUCVUEMH+
 appVmiQ99J6LRIJZqWrY7npDPvyo7dikYeqLc5qbq+xt+bx2BvKi2FjW2i4pDDs7Wk
 Bf2SJbcoGwhO3wDk5QRaAEKMGmqbhqe2YHY8rFQVYSiFmksaEmo54tK/wILKf/9OiM
 nTX0SY4BNs/e10tRo9GOfnLRG74DY3oXqBDG44z5BzyYZfR59GReNW7GYVstHOCRVr
 KOXTngMzCAh0fMqLsX+YZlkDmqHCwDK8jkVID2FtIZlKK5zvHNHrPgIulM3tZ8ZouS
 WATK6us8wuFHg==
Date: Mon, 24 Nov 2025 10:45:52 -0800
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
Subject: Re: [PATCH 4/7] hw/riscv: implement CBQRI bandwidth controller
Message-ID: <aSSn4G/66lhFKoyE@x1>
References: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
 <20251119-riscv-ssqosid-cbqri-v1-4-3392fc760e48@kernel.org>
 <DEH381ZF2STN.G7QL6LUEEBKQ@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DEH381ZF2STN.G7QL6LUEEBKQ@ventanamicro.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Nov 24, 2025 at 06:06:21PM +0100, Radim Krčmář wrote:
> 2025-11-19T16:42:20-08:00, Drew Fustini <fustini@kernel.org>:
> > From: Nicolas Pitre <npitre@baylibre.com>
> >
> > Implement a bandwidth controller according to the Capacity and Bandwidth
> > QoS Register Interface (CBQRI) which supports these capabilities:
> >
> >   - Number of access types: 2 (code and data)
> >   - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
> >   - Event IDs supported: None, Total read/write byte count, Total
> >                          read byte count, Total write byte count
> >   - Bandwidth allocation operations: CONFIG_LIMIT, READ_LIMIT
> >
> > Link: https://github.com/riscv-non-isa/riscv-cbqri/blob/main/riscv-cbqri.pdf
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > [fustini: add fields introduced in the ratified spec: rpfx and p]
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> > diff --git a/hw/riscv/cbqri_bandwidth.c b/hw/riscv/cbqri_bandwidth.c
> > +static uint32_t bandwidth_config(RiscvCbqriBandwidthState *bc,
> > +                                 uint32_t rcid, uint32_t at,
> > +                                 bool *busy)
> > +{
> > +    BandwidthAllocation *bw_alloc = get_bw_alloc(bc, rcid, at);
> > +
> > +    /* for now we only preserve the current BC_BW_ALLOC register content */
> 
> There are a few checks that we could do even without any real
> accounting, like rbwb > 0, and sum_{rcid}(rcid.rbwb) <= mrbwb.

Good point, I'll add basic checks like that.

> Doing so might help us find some bugs in the software management layer.
> What is the level of ISA correctness that you're aiming for?
> (I'll tone down my review if nitpicks like that are not needed.)

The original goal for the Qemu code was for the software proof of
concept needed to freeze the spec. I am working on upstreaming the qemu
code in order to have a "hardware" implementation to reference when
upstreaming the Linux kernel support for resctrl. I do also have access
to CBQRI controllers in RTL emulation but that won't be very useful for
the purposes of public review of my Linux resctrl patches.

Thanks,
Drew

