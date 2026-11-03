Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3A4606A338
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MS1xzk3t
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO4nJ-0001I3-8f; Mon, 02 Nov 2026 22:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO4nA-0001Fp-0N; Mon, 02 Nov 2026 22:02:34 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO4n5-0003Pz-Ny; Mon, 02 Nov 2026 22:02:31 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE93F41783;
 Tue,  3 Nov 2026 03:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067191F000C1;
 Tue,  3 Nov 2026 03:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793674945;
 bh=MMvzBhnL7ChzrnuFCyht7rA4veNoaeBB1CGcGKV9bSE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=MS1xzk3tNaC5tZDr3MQIfBI0UjlIWFBMqE6dA1Cpcl7poQB1kd5l37Tk8NgXjds1u
 BXf5qDR2gutlKx2LGU3ePd9jwkVpo5maVGwEvogVocBPbWzPZsBj90S21DKsexI4KQ
 9g5EWTSJdlWjaSdmULgCx3vtMLgA0n7oWhKu7NOUY9em5e4HQT3XMw5JnRPJ71UX8p
 1OwHwLQPn+w53T6nkMsgXcDjQvVh5SiABMA+IV3+FvR/fFSnahayJpZ8ntkSH81j74
 xMWVb9sFYxqwvGGp6gZfOaHVYHSgF2nfeVLVJgTxFmzyhTb7eu2EFV4jTP74lyjW15
 OURqiXad7n6KQ==
Date: Tue, 3 Nov 2026 03:02:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 24/37] hw/arm/mpam: Add MSMON monitor selection and
 window configuration
Message-ID: <20261103030217.19ec8290@jic23-hlaptop>
In-Reply-To: <tencent_A8F7986545254D664209D1EB165DCA754605@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
 <tencent_A8F7986545254D664209D1EB165DCA754605@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=jic23@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 18:10:44 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Add the monitor-side plumbing shared by the monitor types: the
> MSMON register definitions (MON_SEL, MBWU_FLT/CTL), the per-RIS
> monitor instance array with the num-mbwu-mon and bw-nominal-bps
> properties, and the read/write handling of the selection and
> window registers (monitor/RIS selection with range clamping,
> filter and control storage, write-one-to-clear overflow status).
> 
> The monitor selection resolves a (RIS, monitor) pair through
> mpam_mon_ris()/mpam_mbwu_mon(), and mpam_nrw_id_for() maps a
> filter PARTID onto the internal PARTID whose configuration
> governs it.  No monitor type is advertised yet; the MBWU counter
> model arrives with the next patch.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  hw/arm/mpam.c | 134 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
> 
> diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
> index b484509..77e0277 100644
> --- a/hw/arm/mpam.c
> +++ b/hw/arm/mpam.c
> @@ -109,6 +109,36 @@ REG32(MPAMF_MBWUMON_IDR, 0x0090)
>      FIELD(MPAMF_MBWUMON_IDR, HAS_LONG, 30, 1)
>      FIELD(MPAMF_MBWUMON_IDR, HAS_CAPTURE, 31, 1)
>  
> +REG32(MSMON_CFG_MON_SEL, 0x0800)
> +    FIELD(MSMON_CFG_MON_SEL, MON_SEL, 0, 8)
This look wrong (LLM found it) seems to be 16 bits.
Now narrower than that is fine, but we haven't been modifying these
masks for other field defines to suit what is implemented so
should look to be consistent.

> +    FIELD(MSMON_CFG_MON_SEL, RIS, 24, 4)
> +
> +REG32(MSMON_CFG_MBWU_FLT, 0x0820)
> +    FIELD(MSMON_CFG_MBWU_FLT, PARTID, 0, 16)
> +    FIELD(MSMON_CFG_MBWU_FLT, PMG, 16, 8)
> +    FIELD(MSMON_CFG_MBWU_FLT, RWBW, 30, 2)
> +
> +REG32(MSMON_CFG_MBWU_CTL, 0x0828)
> +    FIELD(MSMON_CFG_MBWU_CTL, TYPE, 0, 8)
> +    FIELD(MSMON_CFG_MBWU_CTL, MATCH_PARTID, 16, 1)
> +    FIELD(MSMON_CFG_MBWU_CTL, MATCH_PMG, 17, 1)
> +    FIELD(MSMON_CFG_MBWU_CTL, SCLEN, 19, 1)
> +    FIELD(MSMON_CFG_MBWU_CTL, SUBTYPE, 20, 4)

3 bits. There is another field in the top one.
(LLM spotted this was different from Linux)

> +    FIELD(MSMON_CFG_MBWU_CTL, OFLOW_FRZ, 24, 1)
> +    FIELD(MSMON_CFG_MBWU_CTL, OFLOW_INTR, 25, 1)
> +    FIELD(MSMON_CFG_MBWU_CTL, OFLOW_STATUS, 26, 1)
> +    FIELD(MSMON_CFG_MBWU_CTL, CAPT_RESET, 27, 1)
> +    FIELD(MSMON_CFG_MBWU_CTL, CAPT_EVNT, 28, 3)
> +    FIELD(MSMON_CFG_MBWU_CTL, EN, 31, 1)
> +
> +REG32(MSMON_MBWU, 0x0860)           /* 31-bit counter, bit31 NRDY */
> +REG32(MSMON_MBWU_L, 0x0880)         /* 64-bit counter */
> +REG32(MSMON_MBWU_CAPTURE, 0x0868)
> +REG32(MSMON_MBWU_CAPTURE_L, 0x0890)
> +REG32(MSMON_CAPT_EVNT, 0x0808)
> +REG32(MSMON_CFG_CSU_FLT, 0x0810)
> +REG32(MSMON_CFG_CSU_CTL, 0x0818)
> +
>  REG32(MPAMF_ERR_MSI_MPAM, 0x00dc)
>  REG32(MPAMF_ERR_MSI_ADDR_L, 0x00e0)
>  REG32(MPAMF_ERR_MSI_ADDR_H, 0x00e4)
> @@ -232,6 +262,21 @@ typedef struct MpamfPerNrwId {
>          uint32_t cfg_mbw_prop;
>  } MpamfPerNrwId;
>  
> +/*
> + * One MBWU monitor instance.  The counter is lazily advanced on
> + * access: value = base + rate x (now - t0), where rate is the
> + * nominal bandwidth scaled by the MBW_MAX fraction of the filtered
> + * PARTID.  Monitoring therefore reads back values that track the
> + * configured bandwidth control.
> + */
> +typedef struct MpamMbwuMon {
> +    uint32_t flt;
> +    uint32_t ctl;
> +    uint64_t base;
> +    int64_t t0;
> +    bool oflow;
> +} MpamMbwuMon;
> +
>  typedef struct Mpamf {
>      uint64_t idr;
>      uint32_t iidr;
> @@ -257,6 +302,8 @@ typedef struct Mpamf {
>  
>      MpamfPerNrwId *per_nrw_id;
> 
> +    MpamMbwuMon *mbwu_mons;
> +
No blank line here.  Like the one above should have
been in this patch, this one should be in whatever comes after
the white space.

>  } Mpamf;
>  

>  typedef struct MPAMMSCMemState {
>      MPAMMSCState parent;
>  } MPAMMSCMemState;
> @@ -405,6 +497,20 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
>          return mpamf->csumon_idr;
>      case A_MPAMF_MBWUMON_IDR:
>          return mpamf->mbwumon_idr;
> +    case A_MSMON_CFG_MON_SEL:
> +        return s->mon_sel;
> +    case A_MSMON_CFG_MBWU_FLT:
> +        return mpam_mbwu_mon(s, mpam_mon_ris(s))->flt;
> +    case A_MSMON_CFG_MBWU_CTL:
> +    {
> +        MpamMbwuMon *m = mpam_mbwu_mon(s, mpam_mon_ris(s));
> +        uint32_t ctl = m->ctl;
> +
> +        if (m->oflow) {
> +            ctl |= R_MSMON_CFG_MBWU_CTL_OFLOW_STATUS_MASK;

See below. Either the write needs to actually clear the bit or this
side needs to mask it from m->ctl

> +        }
> +        return ctl;
> +    }
>      case A_MPAMF_ERR_MSI_MPAM:
>          return mpamf->err_msi_mpam;
>      case A_MPAMF_ERR_MSI_ADDR_L:
> @@ -623,6 +729,30 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
>          mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_pbm[array_offset] = value;
>          return;
>      }
> +    case A_MSMON_CFG_MON_SEL:
> +        s->mon_sel = value & (R_MSMON_CFG_MON_SEL_MON_SEL_MASK |
> +                              R_MSMON_CFG_MON_SEL_RIS_MASK);

Mask on whether HAS_RIS?

> +        return;
> +    case A_MSMON_CFG_MBWU_FLT:
> +        mpam_mbwu_mon(s, mpam_mon_ris(s))->flt = value;

I think this wants a write mask and bits of it are conditional
on HAS_RWBW as well.

> +        return;
> +    case A_MSMON_CFG_MBWU_CTL:
> +    {
> +        MpamMbwuMon *m = mpam_mbwu_mon(s, mpam_mon_ris(s));
> +
> +        m->ctl = value;

Probably wants a write mask as some of this register is read only.
Given this doesn't mask out the oflow (to match a write one to clear)
and the read path isn't masking that bit out, how does it ever appear to
clear?

> +        if (value & R_MSMON_CFG_MBWU_CTL_OFLOW_STATUS_MASK) {
> +            m->oflow = false;               /* write-one-to-clear */
> +        }
> +        return;
> +    }
> +    case A_MSMON_CAPT_EVNT:
> +    case A_MSMON_CFG_CSU_FLT:
> +    case A_MSMON_CFG_CSU_CTL:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "MPAM: cache-usage monitoring not implemented (write %lx)\n",
> +                      offset);
> +        return;



