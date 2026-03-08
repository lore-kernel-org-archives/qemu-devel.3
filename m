Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B72EA8536
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 16:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzH8w-0001Ez-Sd; Sun, 08 Mar 2026 12:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vzH8t-0001Ei-HG; Sun, 08 Mar 2026 12:38:11 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fustini@kernel.org>)
 id 1vzH8q-0005rh-FM; Sun, 08 Mar 2026 12:38:10 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C87C1600AD;
 Sun,  8 Mar 2026 16:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F70FC116C6;
 Sun,  8 Mar 2026 16:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772987886;
 bh=ZlUDcKaiGODDwu+v9xRwXqrgBUij9XuHDlBn6RcGNng=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hkfqpAiYCCHVEczEhMwaVkSfRZp7z08VsW/pf1p56Z5sCioIsNQQX0Hf7soXKWrnF
 QnhkhXCuf+nD2skxQl/AVOI0fZMiOU2Hizf/rnRpNScSjgEbdr/8oz3C4QE1rcPURW
 ku6/sHNfM2QZnrsUnP6bPMb+04IxDZtsv8p/yBip5L1WzPD6Ea9DYJwgJqrI8IFp17
 WeonfwWDjZuuz9726S8KgAfROKlIqGeSrxcEWsQmnEL6hchd2l8aM3stsEVs1PyPI9
 SZCHh3OaQwZLmuFrmdpWYKEv691FeyMgD0N+4wKkjZA1E1qm0iBdgR7cssnQ2xfP8m
 r7GnbKx4eSpTA==
Date: Sun, 8 Mar 2026 09:38:04 -0700
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
Subject: Re: [PATCH v5 4/6] hw/riscv: implement CBQRI bandwidth controller
Message-ID: <aa2l7OUNTq5+9XeR@x1>
References: <20260201-riscv-ssqosid-cbqri-v5-0-273ea4a21703@kernel.org>
 <20260201-riscv-ssqosid-cbqri-v5-4-273ea4a21703@kernel.org>
 <DGSIWQJG3RDB.I5PHN8YZ2953@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGSIWQJG3RDB.I5PHN8YZ2953@qti.qualcomm.com>
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

On Mon, Mar 02, 2026 at 06:55:10PM +0000, Radim Krcmar wrote:
> 2026-02-01T15:58:10-08:00, Drew Fustini <fustini@kernel.org>:
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
> > Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> > Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> > [fustini: add fields introduced in the ratified spec: rpfx and p]
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> > diff --git a/hw/riscv/cbqri_bandwidth.c b/hw/riscv/cbqri_bandwidth.c
> > [...]
> > +static uint32_t bandwidth_config(RiscvCbqriBandwidthState *bc,
> > +                                 uint32_t rcid, uint32_t at,
> > +                                 bool *busy)
> > +{
> > +    BandwidthAllocation *bw_alloc = get_bw_alloc(bc, rcid, at);
> > +
> > +    /*
> > +     * Bandwidth is allocated in multiples of bandwidth blocks, and the
> > +     * value in Rbwb must be at least 1 and must not exceed MRBWB value.
> > +     */
> > +    if (bc->bw_allocations[0].Rbwb < 1) {
> > +        return BC_ALLOC_STATUS_INVAL_OP;
> > +    } else if (bc->bw_allocations[0].Rbwb > bc->mrbwb) {
> > +        return BC_ALLOC_STATUS_INVAL_OP;
> > +    }
> 
> "the sum of Rbwb allocated across all RCIDs must not exceed MRBWB".

Ah, so it should be checking the sum of all Rbwb and not sure the
current rcid. I'll fix.

> 
> > [...]
> > +static void riscv_cbqri_bc_write_mon_ctl(RiscvCbqriBandwidthState *bc,
> > +                                         uint64_t value)
> > +{
> > [...]
> > +    if (mcid >= bc->nb_mcids) {
> > +        status = BC_MON_CTL_STATUS_INVAL_MCID;
> > +    } else if (op == BC_MON_OP_CONFIG_EVENT &&
> > +               bc->supports_mon_op_config_event) {
> > +        if (evt_id == BC_EVT_ID_None &&
> > +            bc->supports_mon_evt_id_none) {
> > +            bc->mon_counters[mcid].active = false;
> > +            status = BC_MON_CTL_STATUS_SUCCESS;
> > +        } else if ((evt_id == BC_EVT_ID_RDWR_count &&
> > +                    bc->supports_mon_evt_id_rdwr_count) ||
> > +                   (evt_id == BC_EVT_ID_RDONLY_count &&
> > +                    bc->supports_mon_evt_id_rdonly_count) ||
> > +                   (evt_id == BC_EVT_ID_WRONLY_count &&
> > +                    bc->supports_mon_evt_id_wronly_count)) {
> > +            if (atv && !is_valid_at(bc, at)) {
> > +                status = BC_MON_CTL_STATUS_INVAL_AT;
> > +            } else {
> > +                bc->mon_counters[mcid].ctr_val =
> > +                    FIELD_DP64(0, BC_MON_CTR_VAL, INVALID, 1);
> 
> This caught my attention even in the capacity controller.
> Maybe a it's worth a short comment that we set INVALID, because we don't
> actually do any bookkeeping?

Good point, I'll add that.

> 
> > [...]
> > +DeviceState *riscv_cbqri_bc_create(hwaddr addr,
> > +                                   const RiscvCbqriBandwidthCaps *caps,
> > +                                   const char *target_name)
> > +{
> > +    DeviceState *dev = qdev_new(TYPE_RISCV_CBQRI_BC);
> > +
> > +    qdev_prop_set_uint64(dev, "mmio_base", addr);
> > +    qdev_prop_set_string(dev, "target", target_name);
> > +    qdev_prop_set_uint16(dev, "max_mcids", caps->nb_mcids);
> > +    qdev_prop_set_uint16(dev, "max_rcids", caps->nb_rcids);
> > +    qdev_prop_set_uint16(dev, "nbwblks", caps->nbwblks);
> 
> Missing mrbwb.

Thanks, I'll add that.

Drew

