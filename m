Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D70606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fAoUon5Q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO3In-0007mV-GY; Mon, 02 Nov 2026 20:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3Ij-0007lZ-RR; Mon, 02 Nov 2026 20:27:01 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3Ih-0003Lh-OL; Mon, 02 Nov 2026 20:27:01 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DA35943CA8;
 Tue,  3 Nov 2026 01:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB091F00A18;
 Tue,  3 Nov 2026 01:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793669217;
 bh=0+Ebyk+Mq6vmTdeJe4ZfS7NKe46hIWOP8todQ6qIcHs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=fAoUon5QEJAAeouoXC8koFKgOhWVblbQKSbl7fzNXBlPi46JY+2fmDGeikfCfbsDv
 Q+cMDpNl274qvpH0qKBSYvkzSiEk2tR46WQ9uasurtSnJ2a8KTfN6Wlvh1AjAEzyG9
 +KkaBmXUOMDHQMhPH0vB5MUMRWZWM9OsArlEcQ2wvC8/PeIrsqZNtj0O+dOU0k3ntD
 MrBJ0civd/7bbZwUVAW7/ZXvMlxE5GyQaMNXmoAXBelTZgKOT2oGeHJAWR9vd5SaFP
 Jh4LYVoG3/UJq7A/gS3JdbJ0l6l+qD5g9KKn3XRaJDi02C0SgFb4If7SeLdMlXq0xI
 D6CRD2d0ITvcw==
Date: Tue, 3 Nov 2026 01:26:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 11/37] hw/arm/mpam: Implement CPOR cache portion
 partitioning
Message-ID: <20261103012649.3c68031d@jic23-hlaptop>
In-Reply-To: <tencent_6C7ED336265811796EE3A442668C8E275709@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_6C7ED336265811796EE3A442668C8E275709@qq.com>
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
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 17:47:05 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Add the cache-portion controls: MPAMF_CPOR_IDR advertises the
> CPBM bitmap width (MPAM_CACHE_PART portions) and the cache
> subtype sets HAS_CPOR_PART, and the CPBM array registers become
> readable and writable per selected internal PARTID.  Reads and
> writes of CPOR_IDR/CPBM on an MSC without CPOR support are
> logged and ignored.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Comment in here is fix the fixme ;)

Otherwise looks fine to me and I think it is a wise
decision to always allocate backing for the max sized bitmap
rather than trying to do it dependent on what the width is
for a particular instance.

> ---
>  hw/arm/mpam.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
> index cce9355..2b1401e 100644
> --- a/hw/arm/mpam.c
> +++ b/hw/arm/mpam.c
> @@ -356,6 +356,13 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
>              return 0;
>          }
>          return mpamf->impl_idr;
> +    case A_MPAMF_CPOR_IDR:
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CPOR_PART)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                "MPAM: Unexpected read of CPOR_IDR with no CPOR support\n");
> +            return 0;
> +        }
> +        return mpamf->cpor_idr;
>      case A_MPAMF_PARTID_NRW_IDR: {
>          return mpamf->partid_nrw_idr;
>      }
> @@ -367,6 +374,19 @@ static uint64_t mpam_msc_read_reg(void *opaque, hwaddr offset,
>          return mpamf->mbwumon_idr;
>      case A_MPAMF_CFG_PART_SEL:
>          return mpamf->cfg_part_sel;
> +    case A_MPAMF_MPAMCFG_CPBM0...
> +        (A_MPAMF_MPAMCFG_CPBM0 + ((MPAM_CACHE_PART + 31) / 32 - 1) * 4):
> +    {
> +        uint32_t array_offset;
> +
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CPOR_PART)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                "MPAM: Unexpected read of CPBM with no CPOR support\n");
> +            return 0;

Sanity check for whether the width is large enough would just be informational
here but it would I think be nice to have.

> +        }
> +        array_offset = (offset - A_MPAMF_MPAMCFG_CPBM0) / sizeof(uint32_t);
> +        return mpamf->per_nrw_id[nrw_part_sel].cfg_cpbm[array_offset];
> +    }
>      default:
>          qemu_log_mask(LOG_UNIMP,
>                        "MPAM: Unexpected read of %lx\n", offset);
> @@ -410,6 +430,21 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
>          mpamf = &s->mpamf[s->ris];
>          mpamf->cfg_part_sel = value;
>          return;
> +    case A_MPAMF_MPAMCFG_CPBM0...
> +        (A_MPAMF_MPAMCFG_CPBM0 + ((MPAM_CACHE_PART + 31) / 32 - 1) * 4):
> +    {
> +        uint32_t array_offset;
> +
> +        /* TODO: Figure out write mask to check this stays in write bits */

Ah. Indeed, this is the thing the LLM was complaining about earlier. The
width depends on how many partitions there are.
Definitely need that enforced (and a log on going over it). 

Roughly speaking n such that (from the spec)
When ((n * 32) + x) >= UInt(MPAMF_CPOR_IDR().CPBM_WD)
is bad so either register out of range where n is the
register offset and x is the bit in it.  So shouldn't be too tricky to
fix this.


> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_CPOR_PART)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected write to CPMB when !HAS_CPORT_PART\n");
> +            return;
> +        }
> +        array_offset = (offset - A_MPAMF_MPAMCFG_CPBM0) / sizeof(uint32_t);
> +        mpamf->per_nrw_id[nrw_part_sel].cfg_cpbm[array_offset] = value;
> +        return;
> +    }



