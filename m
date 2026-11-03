Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3CE606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ic0B7uYT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO4w9-0004Lb-4f; Mon, 02 Nov 2026 22:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO4vW-0004E0-NM; Mon, 02 Nov 2026 22:11:14 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO4vU-0004Gu-7y; Mon, 02 Nov 2026 22:11:10 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 29EEA6022E;
 Tue,  3 Nov 2026 03:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB531F000C1;
 Tue,  3 Nov 2026 03:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793675465;
 bh=axFIZWLTpJeFenWtyTJyeY+MHdCKoD5p2On51ljHaps=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Ic0B7uYTaQHSnqknDWj/vQLGe7EcK0Y81Pe3ybzyeoSrlJcqt8iH+OekiQvWlzqhj
 Po6C/OlGZJ4U2AEJSGxfDbZgQeCDB/6HJV9QDYsWTvonrIzesR59W/ueZgvIfadwij
 SqbJ0UoqE648zCwmdwGmOLonbVZY/g1WmTFjxtJ3OrYYqq9MYllCjtVz48F+MD05cf
 /rt+UOfGAVrhl912NQ0SLUb7DZ4qHJcsfKnRAccF0QJHPw3iWJiMh8+zC7jXlojHFN
 pKIMgq4+Qhj36GjF54hz537BPSeeTk/iB3aV5ZMGOMc+lP4ybYySM89c4XCnp8rX17
 fwOGoqIZG0F6g==
Date: Tue, 3 Nov 2026 03:10:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 25/37] hw/arm/mpam: Emulate MBWU bandwidth monitoring
Message-ID: <20261103031057.18d57887@jic23-hlaptop>
In-Reply-To: <tencent_289D63BC15D4B4B4096744A65B7929B41907@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
 <tencent_289D63BC15D4B4B4096744A65B7929B41907@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=jic23@kernel.org;
 helo=tor.source.kernel.org
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
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 18:10:45 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Add the MBWU monitor: per monitor a lazily accumulated 64-bit
> counter (value = base + rate x elapsed), where the rate is the
> nominal bandwidth scaled by the bandwidth fraction of the filtered
> PARTID.  The fraction follows whichever control the guest drives:
> MBW_MAX, or the MBW_PBM bitmap (popcount over its width) that the
> openEuler MBA resource programs instead, so monitor readings track
> the configured bandwidth control.  The counter wraps at 48 bits,
> latching the overflow status, and writing any counter register
> resets it.
> 
> MSMON_IDR/MBWUMON_IDR now advertise the feature (num-mbwu-mon
> monitors, 64-bit counters with read/write bandwidth) and
> MPAMF_IDR reports HAS_MSMON on both subtypes, which lets resctrl
> mount the MBM counters.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
I like the way you do the scaling to give something that will change
in approx proportion as you control the allocation. Nice and easy
to tell if things are more or less working right.

A few small comments below.

> ---
>  hw/arm/mpam.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 127 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
> index 77e0277..610ae88 100644
> --- a/hw/arm/mpam.c
> +++ b/hw/arm/mpam.c
> @@ -8,6 +8,9 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu/log.h"
> +#include "qemu/timer.h"
> +#include "qemu/host-utils.h"
> +#include "qemu/bitops.h"
>  #include "hw/core/irq.h"
>  #include "hw/core/qdev-properties.h"
>  #include "hw/core/registerfields.h"
> @@ -404,6 +407,65 @@ static MpamMbwuMon *mpam_mbwu_mon(MPAMMSCState *s, Mpamf *mf)
>      return &mf->mbwu_mons[mon];
>  }
>  
> +/*
> + * Lazily advance the monitor's counter.  While enabled it accumulates
> + * the nominal bandwidth scaled by the MBW_MAX fraction of the PARTID
> + * the filter selects, so monitor readings track the configured
> + * bandwidth control.
> + */
> +static uint64_t mpam_mbwu_value(MPAMMSCState *s, Mpamf *mf, MpamMbwuMon *m)
> +{
> +    uint64_t v = m->base;
> +    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_HOST);
> +    int64_t delta;
> +
> +    if (m->t0 == 0) {
> +        m->t0 = now;
> +    }
> +    delta = now - m->t0;
> +
> +    if (FIELD_EX32(m->ctl, MSMON_CFG_MBWU_CTL, EN) && delta > 0) {
> +        /* bw_nominal_bps is bytes/s; MBWU is modelled in bytes. */

> +        uint64_t rate_mbs = s->bw_nominal_bps / 1000000;
Not following this. The comment says one is in bytes and the other
also in bytes, so why 1e6 division?
> +
> +        if (FIELD_EX32(m->ctl, MSMON_CFG_MBWU_CTL, MATCH_PARTID)) {
> +            uint32_t partid = FIELD_EX32(m->flt, MSMON_CFG_MBWU_FLT,
> +                                         PARTID);
> +            uint32_t nrw = mpam_nrw_id_for(s, mf, partid);
> +            MpamfPerNrwId *cfg = &mf->per_nrw_id[nrw];
> +            uint64_t frac_num, frac_den;
> +
> +            /*
> +             * The kernel drives bandwidth through either MBW_MAX or,
> +             * on classes that advertise MBW_PBM, the PBM bitmap
> +             * (popcount of the programmed bits over its width).
> +             */
> +            if (cfg->cfg_mbw_pbm[0]) {
> +                frac_num = __builtin_popcount(cfg->cfg_mbw_pbm[0] &
> +                                     ((1u << MPAM_MBW_PART) - 1));
> +                frac_den = MPAM_MBW_PART;
> +            } else {
> +                /* MBW_MAX is a 16-bit fraction; 0xffff = full bandwidth. */
> +                frac_num = cfg->cfg_mbw_max & 0xffff;
> +                frac_den = 0xffff;
> +            }
> +            rate_mbs = muldiv64(rate_mbs, frac_num, frac_den);
> +        }
> +
> +        /* rate_mbs is MB/s; delta is ns, so /1000 yields bytes. */
> +        v += muldiv64(delta, rate_mbs, 1000);
> +        /* 48-bit counter wraps (MSMON_MBWU_L is 48 bits of value). */
> +        if (v > (1ULL << 48)) {
> +            m->oflow = true;
> +            v &= (1ULL << 48) - 1;
> +        }
> +    }
> +    m->base = v;
> +    m->t0 = now;
> +
> +    return v;
> +}
> +
>  typedef struct MPAMMSCMemState {
>      MPAMMSCState parent;
>  } MPAMMSCMemState;
> @@ -511,6 +573,34 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
>          }
>          return ctl;
>      }
> +    case A_MSMON_MBWU ... (A_MSMON_MBWU + 3):
> +    {
> +        uint64_t v = mpam_mbwu_value(s, mpam_mon_ris(s),
> +                                     mpam_mbwu_mon(s, mpam_mon_ris(s)));
> +
> +        return extract64(v, (offset - A_MSMON_MBWU) * 8, 32);
> +    }
> +    case A_MSMON_MBWU_L ... (A_MSMON_MBWU_L + 7):
> +    {
> +        uint64_t v = mpam_mbwu_value(s, mpam_mon_ris(s),
> +                                     mpam_mbwu_mon(s, mpam_mon_ris(s)));
> +
> +        return extract64(v, (offset - A_MSMON_MBWU_L) * 8, 32);
> +    }
> +    case A_MSMON_MBWU_CAPTURE ... (A_MSMON_MBWU_CAPTURE + 3):
> +    {
> +        uint64_t v = mpam_mbwu_value(s, mpam_mon_ris(s),
> +                                     mpam_mbwu_mon(s, mpam_mon_ris(s)));
> +
> +        return (uint32_t)v;
> +    }
> +    case A_MSMON_MBWU_CAPTURE_L ... (A_MSMON_MBWU_CAPTURE_L + 7):
> +    {

Probably want to check the width for these accesses.

> +        uint64_t v = mpam_mbwu_value(s, mpam_mon_ris(s),
> +                                     mpam_mbwu_mon(s, mpam_mon_ris(s)));
> +
> +        return extract64(v, (offset - A_MSMON_MBWU_CAPTURE_L) * 8, 32);
> +    }

>      case A_MSMON_CAPT_EVNT:
>      case A_MSMON_CFG_CSU_FLT:
>      case A_MSMON_CFG_CSU_CTL:
> @@ -855,10 +956,22 @@ static void mpam_msc_mem_realize(DeviceState *dev, Error **errp)
>  
>          /* We won't implement any implementation specific stuff */
>          mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_PART, 1);
> -        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_MSMON, 1);
Why?  I thought that only needed to change for non standard Implementation defined
monitors.

> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_MSMON, 1);
>          /* Memory specific bit */
>          mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_MBW_PART, 1);
>  
> +        mpamf->msmon_idr = FIELD_DP32(mpamf->msmon_idr,
> +                                      MPAMF_MSMON_IDR, MSMON_MBWU, 1);
> +        mpamf->msmon_idr = FIELD_DP32(mpamf->msmon_idr,
> +                                      MPAMF_MSMON_IDR, HAS_OFLOW_SR, 1);
> +        mpamf->mbwumon_idr = FIELD_DP32(mpamf->mbwumon_idr,
> +                                        MPAMF_MBWUMON_IDR, NUM_MON,
> +                                        s->num_mbwu_mon);
> +        mpamf->mbwumon_idr = FIELD_DP32(mpamf->mbwumon_idr,
> +                                        MPAMF_MBWUMON_IDR, HAS_LONG, 1);
> +        mpamf->mbwumon_idr = FIELD_DP32(mpamf->mbwumon_idr,
> +                                        MPAMF_MBWUMON_IDR, HAS_RWBW, 1);
> +
>          mpamf->iidr = FIELD_DP64(mpamf->iidr, MPAMF_IIDR, IMPLEMENTER,
>                                   MPAM_IIDR_IMPLEMENTER);
>          mpamf->iidr = FIELD_DP64(mpamf->iidr, MPAMF_IIDR, REVISION, 0);
> @@ -914,11 +1027,23 @@ static void mpam_msc_cache_realize(DeviceState *dev, Error **errp)
>  
>          /* We won't implement any implementation specific stuff */
>          mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_PART, 1);
> -        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, NO_IMPL_MSMON, 1);
> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_MSMON, 1);
>  
>          /* Need to implement for RME */
>          mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, SP4, 0);
>  
> +        mpamf->msmon_idr = FIELD_DP32(mpamf->msmon_idr,
> +                                      MPAMF_MSMON_IDR, MSMON_MBWU, 1);
> +        mpamf->msmon_idr = FIELD_DP32(mpamf->msmon_idr,
> +                                      MPAMF_MSMON_IDR, HAS_OFLOW_SR, 1);
> +        mpamf->mbwumon_idr = FIELD_DP32(mpamf->mbwumon_idr,
> +                                        MPAMF_MBWUMON_IDR, NUM_MON,
> +                                        s->num_mbwu_mon);
> +        mpamf->mbwumon_idr = FIELD_DP32(mpamf->mbwumon_idr,
> +                                        MPAMF_MBWUMON_IDR, HAS_LONG, 1);
> +        mpamf->mbwumon_idr = FIELD_DP32(mpamf->mbwumon_idr,
> +                                        MPAMF_MBWUMON_IDR, HAS_RWBW, 1);
> +
>          /* Cache specific bit */
>          mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_CPOR_PART, 1);
>          mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART, 1);


