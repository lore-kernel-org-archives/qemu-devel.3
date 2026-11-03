Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5276F606A329
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+rT2VKW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO4yu-00061V-31; Mon, 02 Nov 2026 22:14:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO4ys-00060N-0F; Mon, 02 Nov 2026 22:14:38 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO4yq-0004T9-9s; Mon, 02 Nov 2026 22:14:37 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B195860008;
 Tue,  3 Nov 2026 03:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCB71F000C1;
 Tue,  3 Nov 2026 03:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793675674;
 bh=8S3RMp0R6Os//sEpid4PzmNY997AFGXd5fGBmKtttto=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=k+rT2VKWKB9HAozfbFMrMZCHrjHQlU1xJemMJLnFpS7odP5kUKyzpx2wAbzFR32b8
 ZJF+0RiY+Rdp6ItXNJ+iU4t7k8TlsyKDF++nDO2IltYReZu9Rns/mw1uBJRCh8ReU6
 /QbsSjP4PsZ4cBpbl2SGC7UPz5XtEvj4p1u8/4jo3A94GJqCXkz6aD49ijSvTEkhIK
 4m1ek5mMkRCZ8Nc/cdNl+Ge8RTpErQAMvudvCP3pMaXPNpT8E3ewdm0y+XMWYl4QxA
 HZzYdaduydqNhN758wUmsymCgmkqgjWjORSkPUjTSy8cAMelunPt9Eu8LT1FM6UtXd
 zg0wB38GfdnJQ==
Date: Tue, 3 Nov 2026 03:14:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 26/37] hw/arm/mpam: Implement CMIN/CASSOC storage
Message-ID: <20261103031424.4096a889@jic23-hlaptop>
In-Reply-To: <tencent_F831FACA6B5AD20402E2C3ED9594C28CD806@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
 <tencent_F831FACA6B5AD20402E2C3ED9594C28CD806@qq.com>
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

On Fri, 16 Oct 2026 18:10:46 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> MPAMF_CCAP_IDR advertised HAS_CMIN/HAS_CASSOC (since the CCAP
> patch) but the MPAMCFG_CMIN and MPAMCFG_CASSOC registers had no
> storage or read/write cases, so L2MIN/L3MIN schemata values were
> dropped and read back as 0.  Add the per-internal-PARTID storage
> and read/write handling, both guarded on CCAP support.

The reference to were and fix don't makes sense in this series.
Rewrite or indeed move the fix so that it was never broken.

> 
> Also fix the MBW_MIN write mask check, which referenced the CMIN
> mask (and logged it as "CMAX") since the device model was
> introduced.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  hw/arm/mpam.c | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
> index 610ae88..1bd76ba 100644
> --- a/hw/arm/mpam.c
> +++ b/hw/arm/mpam.c
> @@ -260,6 +260,8 @@ typedef struct MpamfPerNrwId {
>          uint32_t cfg_mbw_pbm[(MPAM_MBW_PART + 31) / 32];
>          uint32_t cfg_pri;
>          uint32_t cfg_cmax;
> +        uint32_t cfg_cmin;
> +        uint32_t cfg_cassoc;
>          uint32_t cfg_mbw_min;
>          uint32_t cfg_mbw_max;
>          uint32_t cfg_mbw_prop;
> @@ -635,6 +637,20 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
>              return 0;
>          }
>          return mpamf->per_nrw_id[nrw_part_sel].cfg_cmax;
> +    case A_MPAMF_MPAMCFG_CMIN:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                "MPAM: Unexpected read of CMIN with no CCAP support\n");
> +            return 0;
> +        }
> +        return mpamf->per_nrw_id[nrw_part_sel].cfg_cmin;
> +    case A_MPAMF_MPAMCFG_CASSOC:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CCAP_PART)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                "MPAM: Unexpected read of CASSOC with no CCAP support\n");
> +            return 0;
> +        }
> +        return mpamf->per_nrw_id[nrw_part_sel].cfg_cassoc;
>      case A_MPAMF_MPAMCFG_MBW_MIN:
>          return mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_min;
>      case A_MPAMF_MPAMCFG_MBW_MAX:
> @@ -746,12 +762,28 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
>          }
>          mpamf->per_nrw_id[nrw_part_sel].cfg_cmax = value;
>          return;
> -    case A_MPAMF_MPAMCFG_MBW_MIN:
> +    case A_MPAMF_MPAMCFG_CMIN:
>          if (value & ~MPAMF_MPAMCFG_CMIN_WRITE_MASK) {
>              qemu_log_mask(LOG_UNIMP,
> -                          "MPAM: Unexpected write to CMAX Mask=%x Value=%lx\n",
> +                          "MPAM: Unexpected write to CMIN Mask=%x Value=%lx\n",
Fix in original patch.
>                            MPAMF_MPAMCFG_CMIN_WRITE_MASK, value);
>          }
> +        mpamf->per_nrw_id[nrw_part_sel].cfg_cmin = value;
> +        return;
> +    case A_MPAMF_MPAMCFG_CASSOC:
> +        if (value & ~MPAMF_MPAMCFG_CASSOC_WRITE_MASK) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected write to CASSOC Mask=%x Value=%lx\n",
> +                          MPAMF_MPAMCFG_CASSOC_WRITE_MASK, value);
> +        }
> +        mpamf->per_nrw_id[nrw_part_sel].cfg_cassoc = value;
> +        return;
> +    case A_MPAMF_MPAMCFG_MBW_MIN:
> +        if (value & ~MPAMF_MPAMCFG_MBW_MIN_WRITE_MASK) {

Actually mask as well as log for all of these. The hardware
would do that unless I missed unusual behaviour in the spec.

> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected write to MBW_MIN Mask=%x Value=%lx\n",
> +                          MPAMF_MPAMCFG_MBW_MIN_WRITE_MASK, value);
> +        }
>          mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_min = value;
>          return;
>      case A_MPAMF_MPAMCFG_MBW_MAX:


