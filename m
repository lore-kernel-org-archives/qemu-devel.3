Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBC2606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fLU9TNwF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO577-0002Sh-3w; Mon, 02 Nov 2026 22:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO573-0002RC-NB; Mon, 02 Nov 2026 22:23:05 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO571-0005YZ-NM; Mon, 02 Nov 2026 22:23:05 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6F32F43666;
 Tue,  3 Nov 2026 03:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D931F000C1;
 Tue,  3 Nov 2026 03:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793676182;
 bh=ZdutKAgWsa5qbaAkj8EFd2sAkJEiLVjxSMPoDpunxwc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=fLU9TNwFAJ35xMuL1kkf8dgN49/eTEskvvW2Sf6ruIc/gN5cc8U0jFX8cnyG175d2
 L0ePEKcDt1xxPXuFX0dUrDj3P9WsoHAtua9p4bAG6bAe7oP7NaqC1/APdiNPC+v31a
 IpoJITwQT75MznPAq3jmr5czfvanMDC8mvrdPf1Gb6Q6eemTYApguyNA5XQ1mFAYK0
 x36NfP1m9wlz/EhQ6wW+xkYYOPegKOZ9nI3yBO6cdq8PlrrFqyFKvhXT9PHaG+88pt
 vSend5XGtGPhGgVem0gwL2DJWORXertiu6j/N94igu+vuDknnPkieJi7c4eu+I0f1G
 i6NDJ+XYIgMeQ==
Date: Tue, 3 Nov 2026 03:22:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 31/37] hw/arm/mpam: Add device reset and power-on state
 initialisation
Message-ID: <20261103032253.01faabaf@jic23-hlaptop>
In-Reply-To: <tencent_A847C7182BCA69DC138B882EB70852E13308@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
 <tencent_A847C7182BCA69DC138B882EB70852E13308@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=sea.source.kernel.org
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

On Fri, 16 Oct 2026 18:10:51 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Move the power-on initialisation out of realize into
> mpam_msc_state_init() (shared with the new legacy reset callback):
> selection state and ECR/ESR cleared, per-RIS partition and monitor
> storage zeroed, the PARTID narrowing map identity-wrapped so the
> indirection is always in range before the driver programs it, and
> MBW_MAX reset to 0xffff (full bandwidth) -- an unprogrammed PARTID
> must not read as zero bandwidth.
> 
> Also fix the realize error message for num-partid == 0, which
> repeated the num-ris text.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

I'd push the refactor back to the original introduction. Reduces churn
and then is trivial to use here in the reset.

> ---
>  hw/arm/mpam.c | 78 +++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 60 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
> index fe78adb..c4a7567 100644
> --- a/hw/arm/mpam.c
> +++ b/hw/arm/mpam.c
> @@ -1041,6 +1041,63 @@ static const MemoryRegionOps mpam_msc_ops = {
>      },
>  };
>  
> +
> +/*
> + * Power-on state of the MSC, shared between realize and reset: ID narrowing
> + * map identity-wrapped, partition config at reset values, monitors off.
> + */
> +static void mpam_msc_state_init(MPAMMSCState *s)
> +{
> +    int i;
> +
> +    s->ris = 0;
> +    s->part_sel = 0;
> +    s->internal_part_sel = false;
> +    s->mon_sel = 0;
> +    s->ecr = 0;
> +    s->esr = 0;
> +
> +    for (i = 0; i < s->num_ris; i++) {
> +        Mpamf *mpamf = &s->mpamf[i];
> +        int p;
> +
> +        mpamf->ecr = 0;
> +        mpamf->esr = 0;
> +        memset(mpamf->per_nrw_id, 0,
> +               sizeof(MpamfPerNrwId) * s->num_int_partid);
> +        memset(mpamf->cfg_intpartid, 0,
> +               sizeof(uint32_t) * s->num_partid);
> +        memset(mpamf->mbwu_mons, 0,
> +               sizeof(MpamMbwuMon) * s->num_mbwu_mon);
> +        memset(mpamf->csu_mons, 0, sizeof(MpamCsuMon) * s->num_csu_mon);
> +
> +        /*
> +         * Until resctrl programs the map, wrap each request PARTID onto an
> +         * internal PARTID so the narrowing indirection is always in range.
> +         */
> +        for (p = 0; p < s->num_partid; p++) {
> +            mpamf->cfg_intpartid[p] = p % s->num_int_partid;
> +        }
> +        /*
> +         * per_nrw_id is indexed by INTERNAL PARTID: it has
> +         * num_int_partid entries, not num_partid.  Writing it with the
> +         * request-PARTID count overflowed the allocation by 224 entries
> +         * (malloc(): corrupted top size once the struct grew).
> +         */
> +        for (p = 0; p < s->num_int_partid; p++) {
> +            /* MBW_MAX resets to full bandwidth on real hardware */
> +            mpamf->per_nrw_id[p].cfg_mbw_max = 0xffff;
> +        }
> +    }
> +}
> +
> +static void mpam_msc_reset(DeviceState *dev)
> +{
> +    MPAMMSCState *s = MPAM_MSC_DEVICE(dev);
> +
> +    mpam_msc_state_init(s);
> +}
> +
>  static void mpam_msc_realize(DeviceState *dev, Error **errp)
>  {
>      MPAMMSCState *s = MPAM_MSC_DEVICE(dev);
> @@ -1052,7 +1109,7 @@ static void mpam_msc_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>      if (s->num_partid == 0) {
> -        error_setg(errp, "num-ris must be <= 16");
> +        error_setg(errp, "num-partid must be nonzero");
>          return;
>      }
>      if (s->num_int_partid == 0) {
> @@ -1061,28 +1118,12 @@ static void mpam_msc_realize(DeviceState *dev, Error **errp)
>  
>      s->mpamf = g_new0(Mpamf, s->num_ris);
>      for (i = 0; i < s->num_ris; i++) {
> -        int p;
> -
>          s->mpamf[i].per_nrw_id = g_new0(MpamfPerNrwId, s->num_int_partid);
>          s->mpamf[i].cfg_intpartid = g_new0(uint32_t, s->num_partid);
>          s->mpamf[i].mbwu_mons = g_new0(MpamMbwuMon, s->num_mbwu_mon);
>          s->mpamf[i].csu_mons = g_new0(MpamCsuMon, s->num_csu_mon);
> -        /*
> -         * Until resctrl programs the map, wrap each request PARTID onto an
> -         * internal PARTID so the narrowing indirection is always in range.
> -         */
> -        for (p = 0; p < s->num_partid; p++) {
> -            s->mpamf[i].cfg_intpartid[p] = p % s->num_int_partid;
> -        }
> -        /*
> -         * per_nrw_id is indexed by INTERNAL PARTID: it has num_int_partid
> -         * entries, not num_partid.
> -         */
> -        for (p = 0; p < s->num_int_partid; p++) {
> -            /* MBW_MAX resets to full bandwidth on real hardware */
> -            s->mpamf[i].per_nrw_id[p].cfg_mbw_max = 0xffff;
> -        }
>      }
> +    mpam_msc_state_init(s);
>  
>      memory_region_init_io(&s->mr, OBJECT(s), &mpam_msc_ops, s, "mpam_msc",
>                            MPAM_SIZE);
> @@ -1301,6 +1342,7 @@ static void mpam_msc_init(ObjectClass *klass, const void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      device_class_set_props(dc, mpam_msc_props);
> +    device_class_set_legacy_reset(dc, mpam_msc_reset);
>  }
>  
>  static void mpam_msc_mem_init(ObjectClass *klass, const void *data)


