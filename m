Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C7F606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZGN9Yga
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO3NJ-00013G-Qu; Mon, 02 Nov 2026 20:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3NI-000131-MV; Mon, 02 Nov 2026 20:31:44 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3NH-0003lU-1m; Mon, 02 Nov 2026 20:31:44 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 996136020A;
 Tue,  3 Nov 2026 01:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00821F00919;
 Tue,  3 Nov 2026 01:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793669501;
 bh=fFm4qlBXoQSAAdbKKRgTC0K8Lo6y6UwgiTw0IQZcZj0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=hZGN9YgaRK06VHcjc47PnML3q9sU8fKvYaRozX6mN0cRMZ6VbkCF5EIlJWpOYxTm6
 IuHp9OLxPlnWx/x+fk1VppGtBN7QecCUi39QGilIC0TOkTtwejXhUTwhP4RqTB9H0+
 VZAljoCLfz6wnRoU3C/AwYjyttptXh9wXRJ0DyEQVhnH71cZB4K3JzQC7LV1H8gB4Y
 joPadZfgay1cQCGtYDTjkKGF1rapxGZMZAOg6FQGWIuPxU5cLLykyCsp0I3N1snsKa
 wpLSxmhvsnTg6MP+6hn7JFhj1Cac86dLv83tRfhZIKxmeln8XWmYKTPPLedRAc96of
 /0681ewOEhY9w==
Date: Tue, 3 Nov 2026 01:31:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 12/37] hw/arm/mpam: Implement MBW bandwidth partitioning
Message-ID: <20261103013131.25c03bf4@jic23-hlaptop>
In-Reply-To: <tencent_9549CC801F23AD64A5614E042356DD964B0A@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_9549CC801F23AD64A5614E042356DD964B0A@qq.com>
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

On Fri, 16 Oct 2026 17:47:06 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Add the memory-bandwidth controls: MPAMF_MBW_IDR (16-bit BWA_WD
> fraction, MIN/MAX/PBM/PROP support, BWPBM_WD = MPAM_MBW_PART)
> with HAS_MBW_PART on the memory subtype, and read/write handling
> for MBW_MIN, MBW_MAX, MBW_PROP and the MBW_PBM bitmap per
> selected internal PARTID.
> 
> Note the MBW_MIN write mask check references the CMIN mask --
> a leftover fixed later by the CMIN/CASSOC patch.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

I'm a bit amused that the Todo from my RFC is still here and
not fixed.  Needs doing.

> ---
>  hw/arm/mpam.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
> index 2b1401e..7c33ec4 100644
> --- a/hw/arm/mpam.c
> +++ b/hw/arm/mpam.c

>      case A_MPAMF_MPAMCFG_CPBM0...
>          (A_MPAMF_MPAMCFG_CPBM0 + ((MPAM_CACHE_PART + 31) / 32 - 1) * 4):
>      {
> @@ -445,6 +490,22 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
>          mpamf->per_nrw_id[nrw_part_sel].cfg_cpbm[array_offset] = value;
>          return;
>      }
> +    case A_MPAMF_MPAMCFG_MBW_PBM0...
> +        (A_MPAMF_MPAMCFG_MBW_PBM0 + ((MPAM_MBW_PART + 31) / 32 - 1) * 4):
> +    {
> +        uint32_t array_offset;
> +
> +        if (!FIELD_EX32(mpamf->idr, MPAMF_IDR, HAS_MBW_PART)) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "MPAM: Unexpected write to MBW_PBM when !HAS_MBW_PART\n");
> +            return;
> +        }
> +        /* TODO: Figure out write mask to check this stays in write bits */

Indeed that needs doing.  Wasn't I lazy in that RFC? :)



> +        array_offset = (offset - A_MPAMF_MPAMCFG_MBW_PBM0) / sizeof(uint32_t);
> +
> +        mpamf->per_nrw_id[nrw_part_sel].cfg_mbw_pbm[array_offset] = value;
> +        return;
> +    }



