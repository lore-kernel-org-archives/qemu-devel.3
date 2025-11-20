Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBA1CFA446
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 21:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMCIr-0006cg-21; Thu, 20 Nov 2025 16:34:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vMCIp-0006cH-M3; Thu, 20 Nov 2025 16:34:55 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vMCIo-0002bv-0N; Thu, 20 Nov 2025 16:34:55 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EE0226016D;
 Thu, 20 Nov 2025 21:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFD4C4CEF1;
 Thu, 20 Nov 2025 21:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763674491;
 bh=7Egq1sciUUk0YsMo5GPNySLiYMQB/2kJAv3LRWY41eQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gYzi27gLyBQ6XS0OEvcjtIKYA80gT5BV52G1qew17+LKKhyvyEI0pnK7eRJR5ChMz
 uQjfdv8KEePgcPVkHk/iQnRO0nkbBvf5Mw7X3sZ0uDGULH71i1ng25dmJpw7lnRFza
 h1Gh9xaTqtMv+bonLJJA5GLTD4TXJruLHwbdrO7H5ZhzxG4iACYXF6VD9yDyqnxrSL
 e7WGtffTMf6PzZK04pCac+oTKyTHmnfYQ08kPe60ZFoUIyWnqFUXkIR8xrEKHG/rK2
 KgRraJZBmwjjaXdMKyrzSEs0/uQse0Hs5rMAd2E8D5dkz4PvzHSBMkW4t0/em8De72
 j5qC/5dF/Q8mA==
Date: Thu, 20 Nov 2025 13:34:49 -0800
From: Drew Fustini <fustini@kernel.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
 Atish Kumar Patra <atishp@rivosinc.com>,
 Atish Patra <atish.patra@linux.dev>,
 Vasudevan Srinivasan <vasu@rivosinc.com>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
 yunhui cui <cuiyunhui@bytedance.com>,
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn
Subject: Re: [PATCH 1/7] riscv: implement Ssqosid extension and srmcfg CSR
Message-ID: <aR+JeXdCIfOCCpI8@x1>
References: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
 <20251119-riscv-ssqosid-cbqri-v1-1-3392fc760e48@kernel.org>
 <3592062a-f5f1-4350-87c1-ee9c4753ba15@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3592062a-f5f1-4350-87c1-ee9c4753ba15@ventanamicro.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Nov 20, 2025 at 08:30:50AM -0300, Daniel Henrique Barboza wrote:
[snip]
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index 5c91658c3dc4..06a6212c672d 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -1759,6 +1759,37 @@ static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
> >       return RISCV_EXCP_NONE;
> >   }
> > +static RISCVException check_srmcfg(CPURISCVState *env, int csrno)
> > +{
> > +    RISCVCPU *cpu = env_archcpu(env);
> > +
> > +    if (!cpu->cfg.ext_ssqosid) {
> > +        return RISCV_EXCP_ILLEGAL_INST;
> > +    }
> 
> env_archcpu() is a bit heavyweight and we usually avoid it. Since you're using the 'cpu' ptr
> solely to access the CFG pointer I suggest using riscv_cpu_cfg() instead:
> 
> if (!riscv_cpu_cfg(env)->ext_ssqosid) {...}

Thanks for letting me know. I will change to riscv_cpu_cfg() in the next
revision.

Drew

