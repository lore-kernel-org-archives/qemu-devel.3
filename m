Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC2F606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oK/MVFco
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO59r-0003lx-Jp; Mon, 02 Nov 2026 22:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO59V-0003dz-Ij; Mon, 02 Nov 2026 22:25:38 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO59T-0005sr-NT; Mon, 02 Nov 2026 22:25:37 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1754460098;
 Tue,  3 Nov 2026 03:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB981F000C1;
 Tue,  3 Nov 2026 03:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793676333;
 bh=FEFD3IAP6AuxrDxuccqjnVFOYTaJWk2GAuyoY0p1SM0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=oK/MVFcox7siRTWQFr8utaS75yzBdYfqHk6R9OZ1Vfhm5RzyCW+doVXEnUTg40NKl
 1DSB2JL9duE1dkpA7aSHGQrO6xk0YFLi4sHOL3t9njl60wV+15X6PTlOXrd8Nhukoi
 facIHGkYQgsz1OCiGE5JbBz5ltgToH7VXWAJRz5/8+j3lWUuZiOK3wagDaBM45mu0r
 +iaG8Nlx3RirGyy2ueg4Dg1wlFR8crisr8COzM5MLcLuHQHSJc3iociS4MI9cuhPaR
 DgX/YwclXfl+t4Ka+knOygi3ReaeLlyy1PXhjsPWd2JEr3vL/AXWlsizfKet6izD0A
 x5fF9I57WQ5EQ==
Date: Tue, 3 Nov 2026 03:25:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 32/37] hw/arm/mpam: Add error and overflow interrupt
 outputs
Message-ID: <20261103032528.41c52745@jic23-hlaptop>
In-Reply-To: <tencent_92ADA4D4FC4CE571D14A761AF4C425E2DA06@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
 <tencent_92ADA4D4FC4CE571D14A761AF4C425E2DA06@qq.com>
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

On Fri, 16 Oct 2026 18:10:52 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Add the two sysbus irq outputs ([0] error, [1] overflow) with the
> IHI 0099 level semantics: the error line is active while
> MPAMF_ESR.ERR_CODE is non-zero and MPAMF_ECR.INTEN is set (8.2),
> deasserted by writing ERRCODE zero; the overflow line is signalled
> while any MBWU monitor has latched OFLOW_STATUS with OFLOW_INTR
> set (8.3), deasserted by the write-one-to-clear of every overflowed
> monitor.  Counter overflow latches the status exactly once, and
> device reset deasserts both lines.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
This seems to only send interrupts if someone reads the register?
Thus no interrupts if no reading is going on. That seems odd
or is there a thread or timer making sure we still get those interrupts?

Jonathan

> ---
>  hw/arm/mpam.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
> index c4a7567..0389dad 100644
> --- a/hw/arm/mpam.c
> +++ b/hw/arm/mpam.c
> @@ -361,6 +361,10 @@ typedef struct MPAMMSCState {
>      uint32_t ecr;
>      uint64_t esr;
>  
> +    /* Wired interrupt outputs: [0] error, [1] overflow (level) */
> +    qemu_irq err_irq;
> +    qemu_irq oflow_irq;
> +
>      /*
>       * Wired-interrupt GSIVs the board assigned (INTID = SPI + 32).  Zero
>       * means "no wired interrupt"; the ACPI MPAM table reports them as-is.
> @@ -431,6 +435,43 @@ static void mpam_msc_sync_esr_ecr(MPAMMSCState *s)
>      }
>  }
>  
> +/*
> + * IHI 0099 8.2: the MPAM error interrupt is level-sensitive; it is active
> + * while MPAMF_ESR.ERR_CODE is non-zero and MPAMF_ECR.INTEN is set, and is
> + * deactivated by software writing ERRCODE to zero.
> + */
> +static void mpam_msc_update_err_irq(MPAMMSCState *s)
> +{
> +    bool int_en = FIELD_EX32(s->ecr, MPAMF_ECR, INTEN);
> +    bool active = FIELD_EX64(s->esr, MPAMF_ESR, ERR_CODE) != 0;
> +
> +    qemu_set_irq(s->err_irq, int_en && active);
> +}
> +
> +/*
> + * IHI 0099 8.3: the overflow interrupt is signalled while any monitor has
> + * latched OFLOW_STATUS with OFLOW_INTR set; clearing OFLOW_STATUS of all
> + * overflowed monitors (W1C) deasserts it.
> + */
> +static void mpam_msc_update_oflow_irq(MPAMMSCState *s)
> +{
> +    bool active = false;
> +    int i, m;
> +
> +    for (i = 0; i < s->num_ris && !active; i++) {
> +        for (m = 0; m < s->num_mbwu_mon; m++) {
> +            MpamMbwuMon *mon = &s->mpamf[i].mbwu_mons[m];
> +
> +            if (mon->oflow &&
> +                FIELD_EX32(mon->ctl, MSMON_CFG_MBWU_CTL, OFLOW_INTR)) {
> +                active = true;
> +                break;
> +            }
> +        }
> +    }
> +    qemu_set_irq(s->oflow_irq, active);
> +}
> +
>  static Mpamf *mpam_mon_ris(MPAMMSCState *s)
>  {
>      unsigned ris = FIELD_EX32(s->mon_sel, MSMON_CFG_MON_SEL, RIS);
> @@ -506,7 +547,10 @@ static uint64_t mpam_mbwu_value(MPAMMSCState *s, Mpamf *mf, MpamMbwuMon *m)
>          v += muldiv64(delta, rate_mbs, 1000);
>          /* 48-bit counter wraps (MSMON_MBWU_L is 48 bits of value). */
>          if (v > (1ULL << 48)) {
> -            m->oflow = true;
> +            if (!m->oflow) {
> +                m->oflow = true;
> +                mpam_msc_update_oflow_irq(s);
> +            }
>              v &= (1ULL << 48) - 1;
>          }
>      }
> @@ -966,6 +1010,7 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
>          if (value & R_MSMON_CFG_MBWU_CTL_OFLOW_STATUS_MASK) {
>              m->oflow = false;               /* write-one-to-clear */
>          }
> +        mpam_msc_update_oflow_irq(s);
>          return;
>      }
>      case A_MSMON_MBWU:
> @@ -1006,6 +1051,7 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
>          }
>          s->ecr = value & MPAMF_ECR_WRITE_MASK;
>          mpam_msc_sync_esr_ecr(s);
> +        mpam_msc_update_err_irq(s);
>          return;
>      case A_MPAMF_ESR:
>          /*
> @@ -1014,10 +1060,12 @@ static void mpam_msc_write_reg(void *opaque, hwaddr offset, uint64_t value,
>           */
>          s->esr = deposit64(s->esr, 0, 32, value);
>          mpam_msc_sync_esr_ecr(s);
> +        mpam_msc_update_err_irq(s);
>          return;
>      case A_MPAMF_ESR + 0x4:
>          s->esr = deposit64(s->esr, 32, 32, value);
>          mpam_msc_sync_esr_ecr(s);
> +        mpam_msc_update_err_irq(s);
>          return;
>      default:
>          qemu_log_mask(LOG_UNIMP,
> @@ -1096,6 +1144,9 @@ static void mpam_msc_reset(DeviceState *dev)
>      MPAMMSCState *s = MPAM_MSC_DEVICE(dev);
>  
>      mpam_msc_state_init(s);
> +    /* Deassert the wired interrupt lines */
> +    mpam_msc_update_err_irq(s);
> +    mpam_msc_update_oflow_irq(s);
>  }
>  
>  static void mpam_msc_realize(DeviceState *dev, Error **errp)
> @@ -1128,6 +1179,9 @@ static void mpam_msc_realize(DeviceState *dev, Error **errp)
>      memory_region_init_io(&s->mr, OBJECT(s), &mpam_msc_ops, s, "mpam_msc",
>                            MPAM_SIZE);
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
> +    /* Wired interrupt outputs: index 0 = error, index 1 = overflow */
> +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->err_irq);
> +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->oflow_irq);
>  }
>  
>  static void mpam_msc_mem_realize(DeviceState *dev, Error **errp)


