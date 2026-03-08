Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579CDEA8536
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 16:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzH6h-0000d9-Ou; Sun, 08 Mar 2026 12:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vzH6f-0000ct-Uy; Sun, 08 Mar 2026 12:35:53 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vzH6d-0005oG-Gh; Sun, 08 Mar 2026 12:35:53 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 741A960054;
 Sun,  8 Mar 2026 16:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922A7C116C6;
 Sun,  8 Mar 2026 16:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772987748;
 bh=hSbk/wyjfU3JvGHUtQQqDcJti9jRRYA96PVoJl1DTYA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Xop/67HVnd9l+tcROc86loYGvXYu6cK7CoEgmkksH9ER0FECW8kvpRjKKUWSZUfKs
 7Tsl3wxG/m/mUgKPxG7kVJ5GdOFliE4gyaQq5/mV4TaMQd2JXSsLNDVSBjieYJmrWD
 vYLbixSTzVDt03/KI+iFI7NSjhMBlrFF7ylaDDkRGmxgAl6cTOTI6JEHUJsCvfZJaQ
 STsJ0ZGYbmMJrNqVft6x0kfG28xwpwLga3IgGjs20+wd6T5nWV5TWjSO+t+BdDwmP/
 FM1J5BvgEciAaZQo4VBxEHiE9kOjIvjKyg0YkWeKtls0BWSQq6mdHtx+pp3Q8//Iiu
 RYipSMzBkBMlw==
Date: Sun, 8 Mar 2026 09:35:47 -0700
From: Drew Fustini <fustini@kernel.org>
To: Radim Krcmar <rkrcmar@qti.qualcomm.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicolas Pitre <npitre@baylibre.com>,
 Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
 Atish Kumar Patra <atishp@rivosinc.com>,
 Atish Patra <atish.patra@linux.dev>,
 Vasudevan Srinivasan <vasu@rivosinc.com>,
 "rkrcmar@ventanamicro.com" <rkrcmar@ventanamicro.com>,
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>,
 "guo.wenjia23@zte.com.cn" <guo.wenjia23@zte.com.cn>,
 "liu.qingtao2@zte.com.cn" <liu.qingtao2@zte.com.cn>,
 "qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Subject: Re: [PATCH v5 3/6] hw/riscv: implement CBQRI capacity controller
Message-ID: <aa2lYxv4jjPCJ0Tt@x1>
References: <20260201-riscv-ssqosid-cbqri-v5-0-273ea4a21703@kernel.org>
 <20260201-riscv-ssqosid-cbqri-v5-3-273ea4a21703@kernel.org>
 <DGSIOY06X4A5.1HW34JPQV2IGB@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DGSIOY06X4A5.1HW34JPQV2IGB@qti.qualcomm.com>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=fustini@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 02, 2026 at 06:44:59PM +0000, Radim Krcmar wrote:
> 2026-02-01T15:58:09-08:00, Drew Fustini <fustini@kernel.org>:
> > From: Nicolas Pitre <npitre@baylibre.com>
> >
> > Implement a capacity controller according to the Capacity and Bandwidth
> > QoS Register Interface (CBQRI) which supports these capabilities:
> >
> >   - Number of access types: 2 (code and data)
> >   - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
> >   - Event IDs supported: None, Occupancy
> >   - Capacity allocation ops: CONFIG_LIMIT, READ_LIMIT, FLUSH_RCID
> >
> > Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > [fustini: add fields introduced in the ratified spec: cunits, rpfx, p]
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> > diff --git a/hw/riscv/cbqri_capacity.c b/hw/riscv/cbqri_capacity.c
> > @@ -0,0 +1,733 @@
> > [...]
> > +static void riscv_cbqri_cc_write_wrapper(void *opaque, hwaddr addr,
> > +                                             uint64_t value, unsigned size)
> > +{
> > +    if (size == 4) {
> > +        uint64_t reg = riscv_cbqri_cc_read(opaque, addr & ~0x7UL, 8);
> > +        if (addr & 0x7) {
> > +            value = value << 32 | (reg & 0xffffffff);
> > +        } else {
> > +            value = value | (reg & ~0xffffffffUL);
> > +        }
> > +    }
> > +    riscv_cbqri_cc_write(opaque, addr & ~0x7UL, value, 8);
> > +}
> 
> I know I wrote it like this, but I wonder if QEMU prefers ULL or even
> MAKE_64BIT_MASK?  UL shouldn't break unless we compile with MSVC,
> 
> Reviewed-by: Radim Krčmář <radim.krcmar@oss.qualcomm.com>

Thanks for the suggestion. I'll take a look at MAKE_64BIT_MASK.

Drew

