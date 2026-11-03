Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAA3606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FammQy+W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO37t-000584-IO; Mon, 02 Nov 2026 20:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO37R-00052v-T0; Mon, 02 Nov 2026 20:15:27 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO37N-0002PJ-Tp; Mon, 02 Nov 2026 20:15:19 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7E4B66022B;
 Tue,  3 Nov 2026 01:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FA41F0093A;
 Tue,  3 Nov 2026 01:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793668516;
 bh=Rt5Vn9mhnmgEGyds96p5KIuPElqptg49wZC7tJw+FOM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=FammQy+WykRkoqEu9+WjE5VtT/7cpdD4itO7c8QPKEL9Ht4EzT8ae35+Ymcb2e+bR
 H6WPDXgxyb9nkpPDK38GQmWx1Opw5dA5AsZdJP/CN3y6q1rWUdmG0u17HxZaGP6Dwq
 j0XKlnE/kBfV7X8kiGvBT44dTWo4VOQi6F+y8e6j3dJsZ7n7oFQ6xY0lnwYR+hnCfY
 DEOqZ4Gt5Cl8ENCwUo4z95Hz7grYafaBhoo41aJ4TvUoP4yNUPSa1Rv77PzUCPIZXB
 GgTnEwTT7xGBJIc5AEBITMndtYdDkE40/3d0RpuPGj1FLN5L9/zY/7pTM8+PsG4DMA
 yfiG/9F1wiYRQ==
Date: Tue, 3 Nov 2026 01:15:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 09/37] hw/arm/mpam: Handle MPAMCFG_PART_SEL selection
Message-ID: <20261103011449.4ea8d138@jic23-hlaptop>
In-Reply-To: <tencent_841229DA998C63C495D7B4DB092844DA5B07@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_841229DA998C63C495D7B4DB092844DA5B07@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=tor.source.kernel.org
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

On Fri, 16 Oct 2026 17:47:03 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Add read/write handling for the MPAMCFG_PART_SEL selector: the
> RIS field switches the per-RIS register bank (rejecting RIS
> values beyond num-ris, and nonzero RIS on an MSC without RIS
> support), and PARTID_SEL/INTERNAL record the selected partition
> for the configuration registers.  Writes are stored per RIS so
> the selector reads back as written.

For all these patches, the commit message wrap seems a touch short.
Probably wrap at 75ish.

Otherwise a suggestion inline.

With that
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  hw/arm/mpam.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
> index 17ca286..c21a737 100644
> --- a/hw/arm/mpam.c
> +++ b/hw/arm/mpam.c
> @@ -329,6 +329,8 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
>          return mpamf->csumon_idr;
>      case A_MPAMF_MBWUMON_IDR:
>          return mpamf->mbwumon_idr;
> +    case A_MPAMF_CFG_PART_SEL:
> +        return mpamf->cfg_part_sel;
>      default:
>          qemu_log_mask(LOG_UNIMP,
>                        "MPAM: Unexpected read of %lx\n", offset);
> @@ -339,7 +341,37 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
>  static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
>                                 unsigned size)
>  {
> +    MPAMMSCState *s = MPAM_MSC_DEVICE(opaque);
> +    /* Update in the ris setting path */
> +    Mpamf *mpamf = &s->mpamf[s->ris];
> +
>      switch (offset) {
> +    case A_MPAMF_CFG_PART_SEL:
> +        if (value & ~MPAMF_CFG_PART_SEL_WRITE_MASK) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected write to CFG_PART_SEL Mask=%x Value=%lx\n",
> +                          MPAMF_CFG_PART_SEL_WRITE_MASK, value);
> +        }
> +        /* Field matches for all RIS */
> +        if (!FIELD_EX64(mpamf->idr, MPAMF_IDR, HAS_RIS) &&
> +            FIELD_EX32(value, MPAMF_CFG_PART_SEL, RIS) != 0) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected write of non 0 RIS on MSC with !HAS_RIS\n");
> +            return;
> +        }
> +        if (FIELD_EX32(value, MPAMF_CFG_PART_SEL, RIS) >= s->num_ris) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "MPAM: RIS %d out of range (num-ris %d)\n",
> +                          FIELD_EX32(value, MPAMF_CFG_PART_SEL, RIS),
> +                          s->num_ris);
> +            return;
> +        }
> +        s->ris = FIELD_EX32(value, MPAMF_CFG_PART_SEL, RIS);
It seems like this is reused a fair bit above.  Perhaps put it in a
local variable.
      ris = FIELD_EX32(value, MPAMF_CFG_PART_SEL, RIS);
and then here
      s->ris = ris;

> +        s->part_sel = FIELD_EX32(value, MPAMF_CFG_PART_SEL, PARTID_SEL);
> +        s->internal_part_sel = FIELD_EX32(value, MPAMF_CFG_PART_SEL, INTERNAL);
> +        mpamf = &s->mpamf[s->ris];
> +        mpamf->cfg_part_sel = value;
> +        return;
>      default:
>          qemu_log_mask(LOG_UNIMP,
>                        "MPAM: Write to unexpected register Addr %lx Value=%lx\n",


