Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24599C021B2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 03:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmPCn-0006w0-SU; Sun, 23 Feb 2025 22:32:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmPCT-0006qs-PL; Sun, 23 Feb 2025 22:32:11 -0500
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmPCR-00051k-Qp; Sun, 23 Feb 2025 22:32:09 -0500
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-4be6599024cso2710694137.3; 
 Sun, 23 Feb 2025 19:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740367926; x=1740972726; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FihoRJ8zWjfageT1YOLPjaqPYFJe10bztzCqEI88XFo=;
 b=APF/hMMPIGrWnKMFLQNXVWnDq4VYc6rmC+zZRZ78b5xFHzAcoF/vbEiLrcAQbEr2k3
 SDOeLBawcePRSMDxNe5T8t9qDegUdYemwERli++ERy55xOt7EfktnbyLY9JGsR+VIuho
 RIp/QLe8Soqb/z5OCyQ/VTXwD1MqAdC0lmwDGurZ5J61ex3wbX4wig54oBk7FotnVLAi
 oOzvBnZl2LAK2WsbOpeXd0pY/JCZlZ/me8ZFrKEiPW7QgPrPpiGxl+3o3/f7ndJRopku
 1CIrdkyExlu0AlBpKkxCycYXxiSNbzSxlP8erAJI5Iy5/5z5Tcrydn4W4WTIB+TKjmu8
 eovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740367926; x=1740972726;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FihoRJ8zWjfageT1YOLPjaqPYFJe10bztzCqEI88XFo=;
 b=KDOWM4+LcyYuhj/2DGE2/OBzO5cMeXEmaqOpllNW0kf5O4Fiu0/2BkRbvVlu0DprKh
 Wr8gyrzTkO98pI5BPC09wuujSnCawKzSwFFVOJIVS53b3mxVYjrLsC+5yHmk+H0X7jEK
 UNy4gIkhWYIO/GL/HMhDjDBEoZBz+eHz7oqr1WADQHfRFv7ZufM/d1Mwiny2cqjNKvwM
 yxvSa3pboUaoP6ldu2ABaFDox4K58Zgo3p3jQBPOccmYBCTJnO2YB0L9HEuwrpTTQsSM
 w1sEMpmbD2ufqWQfxdz7ZyjLzqfH9zHLD1J9DgfcbiV6JIK7PjPM0Wf60C07iN4/9ITF
 2Lag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkUuhgTDU38z0QQEMH2uq1T56XtJoDu0eOT2M3PSmkNYxk2vARGuCYE82Ax/dkFSPju5PzQNs/hL7X@nongnu.org
X-Gm-Message-State: AOJu0YwUJV3HPm+7J0PRF5WRi1UgiUtqAv5wgaTXW8ZeCw/XsHTArjwL
 EcWH0q2i+1nh3HvCZ4sk4pfK9wAOtWeLe5B++AnlsbPmtU0dkzshfYH3RpT5zX5cmJiDptetRkU
 JojFsuzyg8XaQdDARUcFLgkG04/g=
X-Gm-Gg: ASbGncvKKhiCZv4C0lbOjFzJl0ARaW5kJhrhBMaRZq0LnM+IXzApl8hxP01angQw4zC
 YrtoGlZuZNQoScQArTed1pP0NPiAvvw4c17hzbBrjqm6Njufeqlry4TxlDU3YsfcPtRod3JTViF
 DfH7Z34FzGu9EB1Jk2/UEclvsVU/BJbkGMy95Q
X-Google-Smtp-Source: AGHT+IERsvxdQvgQc3Lo3i+hywKtxb5hvDBOaqI+CJlmfOjMjVJh/rl+MggHKorQSPTgbWgBmL1ZSF0+ZPyyz2TvdLc=
X-Received: by 2002:a05:6102:8024:b0:4bb:eb4a:f9f0 with SMTP id
 ada2fe7eead31-4bfc028ddf2mr6959257137.24.1740367926228; Sun, 23 Feb 2025
 19:32:06 -0800 (PST)
MIME-Version: 1.0
References: <20241205133003.184581-1-dbarboza@ventanamicro.com>
 <20241205133003.184581-9-dbarboza@ventanamicro.com>
In-Reply-To: <20241205133003.184581-9-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 13:31:40 +1000
X-Gm-Features: AWEUYZmCsQHZC3Bh6uMzdkbI1YfT-TgGIvzDVxjJgU0UHZOTmSH8LaHMnx_rYGs
Message-ID: <CAKmqyKO+3rjiPoSmXONA66q3c621Cn7CHj=LC8T9acB9gVfqbA@mail.gmail.com>
Subject: Re: [PATCH for-10.0 08/11] hw/riscv/riscv-iommu: add hpm events mmio
 write
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, Tomasz Jeznach <tjeznach@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe35.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Dec 5, 2024 at 11:34=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> To support hpm events mmio writes, done via
> riscv_iommu_process_hpmevt_write(), we're also adding the 'hpm-counters'
> IOMMU property that are used to determine the amount of counters
> available in the IOMMU.
>
> Note that everything we did so far didn't change any IOMMU behavior
> because we're still not advertising HPM capability to software. This
> will be done in the next patch.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu-hpm.c | 88 ++++++++++++++++++++++++++++++++++++++
>  hw/riscv/riscv-iommu-hpm.h |  1 +
>  hw/riscv/riscv-iommu.c     |  4 +-
>  hw/riscv/riscv-iommu.h     |  1 +
>  4 files changed, 93 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
> index 1cea6b1df1..5518c287a5 100644
> --- a/hw/riscv/riscv-iommu-hpm.c
> +++ b/hw/riscv/riscv-iommu-hpm.c
> @@ -281,3 +281,91 @@ void riscv_iommu_process_hpmcycle_write(RISCVIOMMUSt=
ate *s)
>      s->hpmcycle_prev =3D get_cycles();
>      hpm_setup_timer(s, s->hpmcycle_val);
>  }
> +
> +static inline bool check_valid_event_id(unsigned event_id)
> +{
> +    return event_id > RISCV_IOMMU_HPMEVENT_INVALID &&
> +           event_id < RISCV_IOMMU_HPMEVENT_MAX;
> +}
> +
> +static gboolean hpm_event_equal(gpointer key, gpointer value, gpointer u=
data)
> +{
> +    uint32_t *pair =3D udata;
> +
> +    if (GPOINTER_TO_UINT(value) & (1 << pair[0])) {
> +        pair[1] =3D GPOINTER_TO_UINT(key);
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +/* Caller must check ctr_idx against hpm_ctrs to see if its supported or=
 not. */
> +static void update_event_map(RISCVIOMMUState *s, uint64_t value,
> +                             uint32_t ctr_idx)
> +{
> +    unsigned event_id =3D get_field(value, RISCV_IOMMU_IOHPMEVT_EVENT_ID=
);
> +    uint32_t pair[2] =3D { ctr_idx, RISCV_IOMMU_HPMEVENT_INVALID };
> +    uint32_t new_value =3D 1 << ctr_idx;
> +    gpointer data;
> +
> +    /*
> +     * If EventID field is RISCV_IOMMU_HPMEVENT_INVALID
> +     * remove the current mapping.
> +     */
> +    if (event_id =3D=3D RISCV_IOMMU_HPMEVENT_INVALID) {
> +        data =3D g_hash_table_find(s->hpm_event_ctr_map, hpm_event_equal=
, pair);
> +
> +        new_value =3D GPOINTER_TO_UINT(data) & ~(new_value);
> +        if (new_value !=3D 0) {
> +            g_hash_table_replace(s->hpm_event_ctr_map,
> +                                 GUINT_TO_POINTER(pair[1]),
> +                                 GUINT_TO_POINTER(new_value));
> +        } else {
> +            g_hash_table_remove(s->hpm_event_ctr_map,
> +                                GUINT_TO_POINTER(pair[1]));
> +        }
> +
> +        return;
> +    }
> +
> +    /* Update the counter mask if the event is already enabled. */
> +    if (g_hash_table_lookup_extended(s->hpm_event_ctr_map,
> +                                     GUINT_TO_POINTER(event_id),
> +                                     NULL,
> +                                     &data)) {
> +        new_value |=3D GPOINTER_TO_UINT(data);
> +    }
> +
> +    g_hash_table_insert(s->hpm_event_ctr_map,
> +                        GUINT_TO_POINTER(event_id),
> +                        GUINT_TO_POINTER(new_value));
> +}
> +
> +void riscv_iommu_process_hpmevt_write(RISCVIOMMUState *s, uint32_t evt_r=
eg)
> +{
> +    const uint32_t ctr_idx =3D (evt_reg - RISCV_IOMMU_REG_IOHPMEVT_BASE)=
 >> 3;
> +    const uint32_t ovf =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_IOCO=
UNTOVF);
> +    uint64_t val =3D riscv_iommu_reg_get64(s, evt_reg);
> +
> +    if (ctr_idx >=3D s->hpm_cntrs) {
> +        return;
> +    }
> +
> +    /* Clear OF bit in IOCNTOVF if it's being cleared in IOHPMEVT regist=
er. */
> +    if (get_field(ovf, BIT(ctr_idx + 1)) &&
> +        !get_field(val, RISCV_IOMMU_IOHPMEVT_OF)) {
> +        /* +1 to offset CYCLE register OF bit. */
> +        riscv_iommu_reg_mod32(
> +            s, RISCV_IOMMU_REG_IOCOUNTOVF, 0, BIT(ctr_idx + 1));
> +    }
> +
> +    if (!check_valid_event_id(get_field(val, RISCV_IOMMU_IOHPMEVT_EVENT_=
ID))) {
> +        /* Reset EventID (WARL) field to invalid. */
> +        val =3D set_field(val, RISCV_IOMMU_IOHPMEVT_EVENT_ID,
> +            RISCV_IOMMU_HPMEVENT_INVALID);
> +        riscv_iommu_reg_set64(s, evt_reg, val);
> +    }
> +
> +    update_event_map(s, val, ctr_idx);
> +}
> diff --git a/hw/riscv/riscv-iommu-hpm.h b/hw/riscv/riscv-iommu-hpm.h
> index 0cd550975d..5fc4ef2e8b 100644
> --- a/hw/riscv/riscv-iommu-hpm.h
> +++ b/hw/riscv/riscv-iommu-hpm.h
> @@ -28,5 +28,6 @@ void riscv_iommu_hpm_incr_ctr(RISCVIOMMUState *s, RISCV=
IOMMUContext *ctx,
>  void riscv_iommu_hpm_timer_cb(void *priv);
>  void riscv_iommu_process_iocntinh_cy(RISCVIOMMUState *s, bool prev_cy_in=
h);
>  void riscv_iommu_process_hpmcycle_write(RISCVIOMMUState *s);
> +void riscv_iommu_process_hpmevt_write(RISCVIOMMUState *s, uint32_t evt_r=
eg);
>
>  #endif
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 3bdd88df4a..83cd529844 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1939,7 +1939,7 @@ static void riscv_iommu_process_hpm_writes(RISCVIOM=
MUState *s,
>
>      case RISCV_IOMMU_REG_IOHPMEVT_BASE ...
>          RISCV_IOMMU_REG_IOHPMEVT(RISCV_IOMMU_IOCOUNT_NUM) + 4:
> -        /* not yet implemented */
> +        riscv_iommu_process_hpmevt_write(s, regb & ~7);
>          break;
>      }
>  }
> @@ -2386,6 +2386,8 @@ static Property riscv_iommu_properties[] =3D {
>      DEFINE_PROP_BOOL("g-stage", RISCVIOMMUState, enable_g_stage, TRUE),
>      DEFINE_PROP_LINK("downstream-mr", RISCVIOMMUState, target_mr,
>          TYPE_MEMORY_REGION, MemoryRegion *),
> +    DEFINE_PROP_UINT8("hpm-counters", RISCVIOMMUState, hpm_cntrs,
> +                      RISCV_IOMMU_IOCOUNT_NUM),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index 6ddc59f474..5aaa66fae5 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -95,6 +95,7 @@ struct RISCVIOMMUState {
>
>      /* HPM event counters */
>      GHashTable *hpm_event_ctr_map; /* Mapping of events to counters */
> +    uint8_t hpm_cntrs;
>  };
>
>  void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
> --
> 2.47.1
>
>

