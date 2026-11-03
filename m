Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10C4606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FOefcLpo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO3df-0005XK-4w; Mon, 02 Nov 2026 20:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3db-0005Wb-VN; Mon, 02 Nov 2026 20:48:36 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3da-00058G-2S; Mon, 02 Nov 2026 20:48:35 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 98F1C6021A;
 Tue,  3 Nov 2026 01:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DB41F000C1;
 Tue,  3 Nov 2026 01:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793670512;
 bh=i1wpdI11byszP7zsB0Gi9STnh3WvEWFU7hImhheLu9Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=FOefcLpoltoc+IJSOcq0eo4Rz3/Hv11DiKMpRvmHvdveiyfzTsi9WdIp3U+nMFcXN
 3Jo+TdIYnSfaDbJSIUx1uxjY45yJ0qky7hT6yuMUDdirmgOWX8qhMcKKBQ9MWcKeML
 Zec4VxEB6sRcHeJJfnjCLhQAdBf2V+1Ms8dEHgJtUUC+8eoxGolHrH6C2wIpdJ1X3L
 RtDiUjFpc1jd22cRnSNnL4IhNaj5CjdzfFWD+LxwesdhHUl7/FYPf8VY4TE62cRJjN
 HPGnCpPLQerOlU99o8VHPpK2PUJZ30J379AUfVLB0unJiCcJqe+D21LTxlbk7a4AV1
 2C2vqMbNY2OrA==
Date: Tue, 3 Nov 2026 01:48:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 16/37] hw/arm/mpam: Implement PARTID narrowing
Message-ID: <20261103014824.1174340e@jic23-hlaptop>
In-Reply-To: <tencent_5414CB4CE9B1F60A7E9AC6041DE2F22D9B06@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_5414CB4CE9B1F60A7E9AC6041DE2F22D9B06@qq.com>
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

On Fri, 16 Oct 2026 17:47:10 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> The MPAMCFG_INTPARTID register (0x600) was defined but never handled,

Never handled in original set?  I can't remember but it seems an odd
comment to have in this series.   Or is intent to say it's there earlier
in the series.  If so I'd say "has been define but not yet handled"

I'm guessing it was buggy in the RFC. Not sure I tested it so I'm
certainly not surprised it was!

> so a guest could not program the request PARTID to internal PARTID
> mapping that PARTID narrowing is based on. Add read/write support:
> 
> - Writing MPAMCFG_INTPARTID stores the mapping for the request PARTID
>   selected by MPAMCFG_PART_SEL; reads return the stored mapping.
> - At realize, initialise the map to partid % num_int_partid so the
>   indirection is always in range before a driver programs it,
>   mirroring the Linux driver's fallback mapping. MBW_MAX also resets
>   to 0xffff (full bandwidth) for every internal PARTID, matching
>   hardware: an unprogrammed PARTID must not read as zero bandwidth.
> - Clamp the narrowing indirection lookup to num_int_partid, and wrap
>   MPAMCFG_PART_SEL writes into the supported PARTID space (the
>   narrowed space for INTERNAL selectors) so a guest cannot trigger
>   out-of-bounds accesses on the emulated arrays.
> 
> A guest driver can now exercise PARTID narrowing: several request
> PARTIDs share one internal PARTID's configuration, and the guest can
> re-map them at runtime.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Just trivial stuff. Looks good to me and having looked again,
the RFC clearly failed to do half of what was needed :(

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


> @@ -482,12 +497,38 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
>                            s->num_ris);
>              return;
>          }
> +        {
> +            /*
> +             * IHI 0099 7.2.1: the MSC does not check PARTID_SEL on write
> +             * (the first IMPLEMENTATION DEFINED behaviour); the selector
> +             * wraps into the supported PARTID space instead.
> +             */
> +            uint32_t limit = FIELD_EX32(value, MPAMF_CFG_PART_SEL, INTERNAL) ?
> +                             s->num_int_partid : s->num_partid;
> +
> +            s->part_sel = FIELD_EX32(value, MPAMF_CFG_PART_SEL,
> +                                     PARTID_SEL) % limit;

I'd rewrap that.  I think slightly over 80 chars is fine here.

> +        }

>      case A_MPAMF_MPAMCFG_CMAX:
>          if (value & ~MPAMF_MPAMCFG_CMAX_WRITE_MASK) {
>              qemu_log_mask(LOG_UNIMP,
> @@ -619,8 +660,25 @@ static void mpam_msc_realize(DeviceState *dev, Error **errp)
>  
>      s->mpamf = g_new0(Mpamf, s->num_ris);
>      for (i = 0; i < s->num_ris; i++) {
> +        int p;
> +
>          s->mpamf[i].per_nrw_id = g_new0(MpamfPerNrwId, s->num_int_partid);
>          s->mpamf[i].cfg_intpartid = g_new0(uint32_t, s->num_partid);
> +        /*
> +         * Until resctrl programs the map, wrap each request PARTID onto an
> +         * internal PARTID so the narrowing indirection is always in range.
> +         */
> +        for (p = 0; p < s->num_partid; p++) {
        for (int p = 0;
> +            s->mpamf[i].cfg_intpartid[p] = p % s->num_int_partid;
> +        }
> +        /*
> +         * per_nrw_id is indexed by INTERNAL PARTID: it has num_int_partid
> +         * entries, not num_partid.
> +         */
> +        for (p = 0; p < s->num_int_partid; p++) {
        for (int p = 0;

particularly given it has a different use to previous p!

> +            /* MBW_MAX resets to full bandwidth on real hardware */
> +            s->mpamf[i].per_nrw_id[p].cfg_mbw_max = 0xffff;
> +        }
>      }
>  
>      memory_region_init_io(&s->mr, OBJECT(s), &mpam_msc_ops, s, "mpam_msc",


