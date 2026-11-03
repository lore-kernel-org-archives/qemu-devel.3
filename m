Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D649606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PTNNhM3u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO3TE-0002a2-St; Mon, 02 Nov 2026 20:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3TD-0002ZK-C1; Mon, 02 Nov 2026 20:37:51 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3TB-0004DQ-Fh; Mon, 02 Nov 2026 20:37:51 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 03E3E601F0;
 Tue,  3 Nov 2026 01:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D001F000C1;
 Tue,  3 Nov 2026 01:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793669867;
 bh=FSCCfhUREHKhFqWwF80Iq0/VwOjPXaxVVV1sVve08Wk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=PTNNhM3uCusBnpl4tWwKAdhM6hA8XvngLfRNCZFTN0AUu67wSIuXv6xGdaUi1gbAH
 fvkJ8UI/hmd2E/a7shRbaKx17nc/z9jSAuyIT6lGkZMYOS89er+r0wvHDH9KluVWyv
 LmYLQS1P1bPQMMZMjf0xk2ngkRQobTC9NPEZEWRSbyDf7A1XICe9fEF31naUveeTo4
 hpxiFwSYQQA8TVuCPFv0TTTNTMuy/UJ6psJqiSPkjcOAHS8R1W+BYSZ5SVrHiWCjbf
 B3R10E+eGTE6tIYeXJnPEGP3PWLo/jJftpd1L9j0cS7TiH06JGl7CoheIZPd8twXxx
 JFWlcj2aCBIHA==
Date: Tue, 3 Nov 2026 01:37:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 13/37] hw/arm/mpam: Implement PRI priority partitioning
Message-ID: <20261103013739.47f3ef39@jic23-hlaptop>
In-Reply-To: <tencent_22716EE5A5A467448FFD5664D320278E1109@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_22716EE5A5A467448FFD5664D320278E1109@qq.com>
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
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 17:47:07 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Add the priority controls: MPAMF_PRI_IDR advertises a 2-bit
> INTPRI (0 = low) with no DSPRI, HAS_PRI_PART is set on the cache
> subtype, and MPAMCFG_PRI is readable and writable per selected
> internal PARTID, logging writes of DSPRI/INTPRI fields the IDR
> does not implement.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
I wonder if it is worth maintaining the flexibility of all the
rest of the code not assuming HAS_PRI when it is hard coded to 1?

Maybe it is worth piping through the ability to turn each feature off?
Or simplifying the code by removing the checks.

When I wrote that original I was mostly tweaking options and rebuilding
to see what bugs I could find in James' kernel code.  I think it
would be useful to keep the ability to do that, but I have no idea if
anyone wants the rich set of control parameters that needs. Maybe
x-has_no_pri or something like that to indicate debug only?

BTW not sure how you decided which patches to keep my original SoB and
which not. I don't really care given this was ancient code I was
probably never getting back to, but maybe do another pass for what
was more or less straight out of the RFC vs needing a bigger rewrite.

Thanks,

Jonathan


> ---
>  hw/arm/mpam.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
> index 7c33ec4..94e517b 100644
> --- a/hw/arm/mpam.c
> +++ b/hw/arm/mpam.c
> @@ -365,6 +365,13 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
>          return mpamf->cpor_idr;
>      case A_MPAMF_MBW_IDR:
>          return mpamf->mbw_idr;
> +    case A_MPAMF_PRI_IDR:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_PRI_PART)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                "MPAM: Unexpected read of PRI_IDR with no PRI PART support\n");
> +            return 0;
> +        }
> +        return mpamf->pri_idr;
>      case A_MPAMF_PARTID_NRW_IDR: {
>          return mpamf->partid_nrw_idr;
>      }
> @@ -380,6 +387,8 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
>          return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_min;
>      case A_MPAMF_MPAMCFG_MBW_MAX:
>          return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_max;
> +    case A_MPAMF_MPAMCFG_PRI:
> +        return mpamf->per_nrw_id[nrw_part_sel].cfg_pri;
>      case A_MPAMF_MPAMCFG_MBW_PROP:
>          return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_prop;
>      case A_MPAMF_MPAMCFG_CPBM0...
> @@ -467,6 +476,24 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
>          }
>          mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_max = value;
>          return;
> +    case A_MPAMF_MPAMCFG_PRI:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_PRI_PART)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected write to CFG_PRI when !HAS_PRI_PART\n");
> +        } else {
> +            if (!FIELD_EX32(mpamf->pri_idr, MPAMF_PRI_IDR, HAS_DSPRI) &&
> +                FIELD_EX32(value, MPAMF_MPAMCFG_PRI, DSPRI)) {
> +                qemu_log_mask(LOG_UNIMP,
> +                              "MPAM: Unexpected write to CFGP_PRI DSPRI when !HAS_DSPRI\n");
> +            }
> +            if (!FIELD_EX32(mpamf->pri_idr, MPAMF_PRI_IDR, HAS_INTPRI) &&
> +                FIELD_EX32(value, MPAMF_MPAMCFG_PRI, INTPRI)) {
> +                qemu_log_mask(LOG_UNIMP,
> +                              "MPAM: Unexpected write to CFGP_PRI INTPRI when !HAS_INTPRI\n");
> +            }
> +        }
> +        mpamf->per_nrw_id[nrw_part_sel].cfg_pri = value;
> +        return;
>      case A_MPAMF_MPAMCFG_MBW_PROP:
>          if (value & ~MPAMF_MPAMCFG_MBW_PROP_WRITE_MASK) {
>              qemu_log_mask(LOG_UNIMP,
> @@ -648,6 +675,7 @@ static void mpam_msc_cache_realize(DeviceState *dev, Error **errp)
>  
>          /* Cache specific bit */
>          mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_CPOR_PART, 1);
> +        mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_PRI_PART, 1);
>          mpamf->idr = FIELD_DP64(mpamf->idr, MPAMF_IDR, HAS_PARTID_NRW,
>                                  s->num_int_partid < s->num_partid);
>  
> @@ -665,6 +693,14 @@ static void mpam_msc_cache_realize(DeviceState *dev, Error **errp)
>          mpamf->cpor_idr = FIELD_DP32(mpamf->cpor_idr, MPAMF_CPOR_IDR, CPBM_WD,
>                                       MPAM_CACHE_PART);
>  
> +        /* Priority */
> +        mpamf->pri_idr = FIELD_DP32(mpamf->pri_idr, MPAMF_PRI_IDR,
> +                                    HAS_INTPRI, 1);
> +        mpamf->pri_idr = FIELD_DP32(mpamf->pri_idr, MPAMF_PRI_IDR,
> +                                    INTPRI_0_IS_LOW, 1);
> +        mpamf->pri_idr = FIELD_DP32(mpamf->pri_idr, MPAMF_PRI_IDR,
> +                                    INTPRI_WD, 2);
> +
>          if (s->num_int_partid < s->num_partid) {
>              mpamf->partid_nrw_idr = FIELD_DP32(mpamf->partid_nrw_idr,
>                                                 MPAMF_PARTID_NRW_IDR,


