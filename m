Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C2ECFA446
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 21:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMBy3-0006uy-IV; Thu, 20 Nov 2025 16:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vMBYJ-00014Z-Nt; Thu, 20 Nov 2025 15:47:02 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vMBYH-0008BU-Sc; Thu, 20 Nov 2025 15:46:51 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 36F6160017;
 Thu, 20 Nov 2025 20:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66C1C116B1;
 Thu, 20 Nov 2025 20:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763671607;
 bh=RBeOhL/CgfUpTHt8umSR3W+eU3MgqXNfL66GUtmQR24=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Pee27FRxnbB/aVxV3da77SXwsG3F+H01ruDJp8j16vjnfayD97xfVdJMTsQqPt6SI
 T5pcFmbD3axRcugWLOEwWOVuq9IObcYEwuRr+04T/h72HT9c664NsDe4rPQjEEa7nK
 PVfKpy1vL402HLFr/fTf9fYeJaf760PO07u76HAZQfFyFH189S0AYNdEFojKZgNQFd
 NQRKOmw6ghqcYPzAJDHK+eGauFhYTA04f6G/3Q4JKjHvLhQ4WCq3E6R4lYENMxU/QE
 fuZD1JYCrJ7GE78ZXxCmVL0qoayZeJxLLwtQZay5Rg9FzpkRSAav7MztpF4joQgtB8
 I+P4opVK3oK5g==
Date: Thu, 20 Nov 2025 12:46:46 -0800
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
Subject: Re: [PATCH 1/7] riscv: implement Ssqosid extension and srmcfg CSR
Message-ID: <aR9+NoQVkxq3mcP6@x1>
References: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
 <20251119-riscv-ssqosid-cbqri-v1-1-3392fc760e48@kernel.org>
 <DEDNGGQCPNKP.25HNT2IHYB0C2@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DEDNGGQCPNKP.25HNT2IHYB0C2@ventanamicro.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=fustini@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 20 Nov 2025 16:13:22 -0500
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

On Thu, Nov 20, 2025 at 05:07:03PM +0100, Radim Krčmář wrote:

Thanks for the review!

> 2025-11-19T16:42:17-08:00, Drew Fustini <fustini@kernel.org>:
> > From: Kornel Dulęba <mindal@semihalf.com>
> >
> > Implement the srmcfg CSR defined by the Ssqosid ISA extension
> > (Supervisor-mode Quality of Service ID). The CSR contains two fields:
> >
> >   - Resource Control ID (RCID) used determine resource allocation
> >   - Monitoring Counter ID (MCID) used to track resource usage
> >
> > The CSR is defined for S-mode but accessing it when V=1 shall cause a
> > virtual instruction exception. Implement this behavior by calling the
> > hmode predicate.
> >
> > Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/download/v1.0/riscv-cbqri.pdf
> > Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
> > [fustini: rebase on v10.1.50, fix check_srmcfg]
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > @@ -216,6 +216,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
> >      ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
> >      ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
> >      ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
> > +    ISA_EXT_DATA_ENTRY(ssqosid, PRIV_VERSION_1_12_0, ext_ssqosid),
> 
> Just out of curiosity, where does PRIV_VERSION_1_12_0 come from?

Ssqosid was originally ratified as a separate document but it since was
add to the Privileged Architecture document [1]. However, the Supervisor
Level ISA was version 1.13 when Ssqosid was added, so I should change
the above to PRIV_VERSION_1_13_0.

> 
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > @@ -1759,6 +1759,37 @@ static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
> > +static RISCVException check_srmcfg(CPURISCVState *env, int csrno)
> > +{
> > +    RISCVCPU *cpu = env_archcpu(env);
> > +
> > +    if (!cpu->cfg.ext_ssqosid) {
> > +        return RISCV_EXCP_ILLEGAL_INST;
> > +    }
> > +
> > +    /*
> > +     * Even though this is an S-mode CSR the spec says that we need to throw
> > +     * and virt instruction fault if a guest tries to access it.
> > +     */
> > +    return env->virt_enabled ?
> > +           RISCV_EXCP_VIRT_INSTRUCTION_FAULT : smode(env, csrno);
> > +}
> 
> The check is missing interaction with mstateen0.SRMCFG.

Good point. It looks like I should check mstateen0.SRMCFG which it bit
55. I'll add something like the following to the next revision:

---------------------------------------------------------------------
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index ebb400bf6f2c..bd73f9232d70 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -359,6 +359,7 @@
 #define SMSTATEEN0_FCSR     (1ULL << 1)
 #define SMSTATEEN0_JVT      (1ULL << 2)
 #define SMSTATEEN0_CTR      (1ULL << 54)
+#define SMSTATEEN0_SRMCFG   (1ULL << 55)
 #define SMSTATEEN0_P1P13    (1ULL << 56)
 #define SMSTATEEN0_HSCONTXT (1ULL << 57)
 #define SMSTATEEN0_IMSIC    (1ULL << 58)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 06a6212c672d..8f609e826fcd 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1767,6 +1767,11 @@ static RISCVException check_srmcfg(CPURISCVState *env, int csrno)
         return RISCV_EXCP_ILLEGAL_INST;
     }

+    RISCVException ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SRMCFG);
+    if (ret != RISCV_EXCP_NONE) {
+        return ret;
+    }
+
     /*
      * Even though this is an S-mode CSR the spec says that we need to throw
      * and virt instruction fault if a guest tries to access it.
---------------------------------------------------------------------

Thanks
Drew

[1] https://docs.riscv.org/reference/isa/priv/supervisor.html#ssqosid
[2] https://docs.riscv.org/reference/isa/priv/smstateen.html#state-enable-0-registersmstateen0.SRMCFG

