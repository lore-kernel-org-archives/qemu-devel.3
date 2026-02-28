Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E05FEE4EF
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 15:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwM3w-0007Sh-37; Sat, 28 Feb 2026 10:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vwM3t-0007J1-T3
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 10:16:57 -0500
Received: from mail-dl1-x1241.google.com ([2607:f8b0:4864:20::1241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vwM3r-0006gu-ON
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 10:16:57 -0500
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-124afd03fd1so4073163c88.0
 for <qemu-devel@nongnu.org>; Sat, 28 Feb 2026 07:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772291814; x=1772896614; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EoFbiYkNl0SznSRdfQwqBwahw6VZglacRvQJ0rmPOxI=;
 b=I7BRI+ttyIpvQdVyb/9GravIy7bt8I+FeOQGgzUP+PoPu/ioX+KGk/Ij5l1NazUNlZ
 UwXihK8jpo9pChpV8QJ8OrQG9MibOg1OROwndWq+I+7eIyby7f5bhc26nqusKPxEsOHw
 z4kb9yz9H365/JtTTZl1IisJuJnuVVJC2P/yZ5Lnt6SIxi58/nnyn2iRAnkeArBoMl7C
 VUKB6rcy9A/B1jjy3MfwcVTNDOI27kd5+BQNkQfnu80f0uPVFqU7DfGLOJ7rBuVDNEjs
 prNalz0ptHld4hgb5ldw+fMvLkDe+aYin1lh0ZlbBck/ufB8afLMGKOCnHjokZPicYLj
 c6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772291814; x=1772896614;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EoFbiYkNl0SznSRdfQwqBwahw6VZglacRvQJ0rmPOxI=;
 b=pkB1cyeRQbotFSUNUOq46mISaxDQYNPa3xsAyxFPAb7VIFlmYUPNEsMzjCS7VKWWWj
 wcu4uMCILgv2djGo8REtx1DzvtSYpbeOyROGI9obF9wP/k6LyaiKeCZTluzfTIFi1Vs+
 t3ksxdOOEmMxt1cWrvSHGxcTH5Kep5zo28dyrR5TEGatsBG/CHDEu/HWPXDa86vkay4G
 s+0/CFGrRyrm7ccLfO2q0tgFjeEkWqlID3SZ8LFsau7VgQkI9gJKW+GQePdXTmqjptXT
 vnwrp5TgcUD0/MB/FCj3moIrSnIrY3OJXZn9pnl/AL8dvLjcLrxOh9ewC2Rr+MVjevZB
 XACA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC5J/X1ukGoPoaY9eJSiUO0Uw2xghE2+Nt475kniupQPkdnhXI+EAr5+fp0DtRd1qomeDsKPFvwgDq@nongnu.org
X-Gm-Message-State: AOJu0YzFu00/fyGaT+vXCNC/uvHraGhWvnxyptwloiw7qrgfLuUqpyqg
 GyXKRzKhT3BPR/Od2qldyjUWzPWa8MaHbgVI5U0VaI+J0nY9wtI8kegK
X-Gm-Gg: ATEYQzxRJQoIPHkdtmqHnqIR6SieBjctqEzbFmWj+jIatOt01KfrE1Qquy60H7zFvYI
 8NwWwB1usVoIFqMxvzWSmCuBP8yfyM+ncaIOb+BMhVn0J8YXmOpMzH6ifdgDMfQnOQNdghEHQSm
 xWYSdQF3mTy34pOH+jyvBKZEoKTDj8GECLxTZB7/i0Rtm/fd8FoLSDEZqN3pyofdeCrgbRbT+SG
 p0r9hGu2Ehhx2hU2TdyuNJszzXslMUXYQLbKplc23oc7VmoUgh53oeFipCzKCBJmnQr4Pusb4SA
 IwHKsriAH6va1eCqGOvhl1Sv3zJFcSG0Ly6P+rzaYvlMpyf6YLrNTxHh7+G2D4ICPbcuYVscbaw
 7+cc0qg7ih3Yy0kO7Kh7UIXYzvSN16ojWaHq09h1PbP/NCpmM3ctleJokGkZsKo44Zt8WIJ99L1
 ivo2yyBmi8atiplJsziBNLkzV7x3sWVA29CjF/eqA2P1eJraWvnQARmU3TxfEIqntybZvDs4ktj
 eE0wdnMlsCcX5ZmUhnl4TeoDKhif3U=
X-Received: by 2002:a05:7022:1287:b0:11b:c1fb:89a with SMTP id
 a92af1059eb24-1278fc1bfedmr2622408c88.32.1772291813835; 
 Sat, 28 Feb 2026 07:16:53 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789a43c12sm7935466c88.14.2026.02.28.07.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 07:16:52 -0800 (PST)
Date: Sat, 28 Feb 2026 23:16:43 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: liu.xuemei1@zte.com.cn
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] hw/intc/riscv_aplic: Add in-kernel aplic save and
 restore?? function
Message-ID: <aaMGQQfNJKlWGT-t@ZEVORN-PC.localdomain>
References: <20260227180104794YvW9Rb2I_kAGzUruZL11Q@zte.com.cn>
 <20260227180537641ywDyRd1dHlebVETYjXAFI@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227180537641ywDyRd1dHlebVETYjXAFI@zte.com.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1241;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1241.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 27, 2026 at 06:05:37PM +0800, liu.xuemei1@zte.com.cn wrote:
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
> 
> Add save and restore function if riscv_use_emulated_aplic return
> false, it is to get and set APLIC irqchip state from KVM kernel.
> 
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> ---
>  hw/intc/riscv_aplic.c         | 200 ++++++++++++++++++++++++++++------
>  include/hw/intc/riscv_aplic.h |   4 +
>  2 files changed, 173 insertions(+), 31 deletions(-)
> 
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 8f70043111..3523e63fb0 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -922,14 +922,7 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
>          }
> 
>          aplic->bitfield_words = (aplic->num_irqs + 31) >> 5;
> -        aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
>          aplic->state = g_new0(uint32_t, aplic->num_irqs);
> -        aplic->target = g_new0(uint32_t, aplic->num_irqs);
> -        if (!aplic->msimode) {
> -            for (i = 0; i < aplic->num_irqs; i++) {
> -                aplic->target[i] = 1;
> -            }
> -        }
>          aplic->idelivery = g_new0(uint32_t, aplic->num_harts);
>          aplic->iforce = g_new0(uint32_t, aplic->num_harts);
>          aplic->ithreshold = g_new0(uint32_t, aplic->num_harts);
> @@ -941,6 +934,19 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
>          if (kvm_enabled()) {
>              aplic->kvm_splitmode = true;
>          }
> +    } else {
> +        aplic->nr_words = DIV_ROUND_UP(aplic->num_irqs, 32);
> +        aplic->setip = g_new0(uint32_t, aplic->nr_words);
> +        aplic->clrip = g_new0(uint32_t, aplic->nr_words);
> +        aplic->setie = g_new0(uint32_t, aplic->nr_words);
> +    }
> +
> +    aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
> +    aplic->target = g_new0(uint32_t, aplic->num_irqs);
> +    if (!aplic->msimode) {
> +        for (i = 0; i < aplic->num_irqs; i++) {
> +            aplic->target[i] = 1;
> +        }
>      }
> 
>      /*
> @@ -968,47 +974,179 @@ static const Property riscv_aplic_properties[] = {
>      DEFINE_PROP_BOOL("mmode", RISCVAPLICState, mmode, 0),
>  };
> 
> -static bool riscv_aplic_state_needed(void *opaque)
> +static bool riscv_aplic_emul_state_needed(void *opaque)
>  {
>      RISCVAPLICState *aplic = opaque;
> 
>      return riscv_use_emulated_aplic(aplic->msimode);
>  }
> 
> +static const VMStateDescription vmstate_riscv_aplic_emul = {
> +    .name = "riscv_aplic_emul",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = riscv_aplic_emul_state_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_VARRAY_UINT32(state, RISCVAPLICState,
> +                              num_irqs, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
> +        VMSTATE_UINT32(mmsicfgaddrH, RISCVAPLICState),
> +        VMSTATE_UINT32(smsicfgaddr, RISCVAPLICState),
> +        VMSTATE_UINT32(smsicfgaddrH, RISCVAPLICState),
> +        VMSTATE_UINT32(kvm_msicfgaddr, RISCVAPLICState),
> +        VMSTATE_UINT32(kvm_msicfgaddrH, RISCVAPLICState),
> +        VMSTATE_VARRAY_UINT32(idelivery, RISCVAPLICState,
> +                                num_harts, 0,
> +                                vmstate_info_uint32, uint32_t),
> +        VMSTATE_VARRAY_UINT32(iforce, RISCVAPLICState,
> +                                num_harts, 0,
> +                                vmstate_info_uint32, uint32_t),
> +        VMSTATE_VARRAY_UINT32(ithreshold, RISCVAPLICState,
> +                                num_harts, 0,
> +                                vmstate_info_uint32, uint32_t),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static bool riscv_aplic_in_kernel_state_needed(void *opaque)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    return !riscv_use_emulated_aplic(aplic->msimode);
> +}
> +
> +static int riscv_aplic_in_kernel_pre_save(void *opaque)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    if (!riscv_use_emulated_aplic(aplic->msimode)) {
> +        for (uint32_t i = 0; i < aplic->nr_words; i++) {
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SETIP_BASE + i * 4,
> +                                     aplic->setip + i, false);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_CLRIP_BASE + i * 4,
> +                                     aplic->clrip + i, false);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SETIE_BASE + i * 4,
> +                                     aplic->setie + i, false);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int riscv_aplic_in_kernel_post_load(void *opaque, int version_id)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    if (!riscv_use_emulated_aplic(aplic->msimode)) {
> +        for (uint32_t i = 0; i < aplic->nr_words; i++) {
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SETIP_BASE + i * 4,
> +                                     aplic->setip + i, true);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_CLRIP_BASE + i * 4,
> +                                     aplic->clrip + i, true);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SETIE_BASE + i * 4,
> +                                     aplic->setie + i, true);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_riscv_aplic_in_kernel = {
> +    .name = "riscv_aplic_in_kernel",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = riscv_aplic_in_kernel_state_needed,
> +    .pre_save = riscv_aplic_in_kernel_pre_save,
> +    .post_load = riscv_aplic_in_kernel_post_load,
> +    .fields = (const VMStateField[]) {
> +            VMSTATE_VARRAY_UINT32(setip, RISCVAPLICState,
> +                                  nr_words, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_VARRAY_UINT32(clrip, RISCVAPLICState,
> +                                  nr_words, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_VARRAY_UINT32(setie, RISCVAPLICState,
> +                                  nr_words, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static int riscv_aplic_pre_save(void *opaque)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    if (!riscv_use_emulated_aplic(aplic->msimode)) {
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_DOMAINCFG,
> +                                 &aplic->domaincfg, false);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_GENMSI,
> +                                 &aplic->genmsi, false);
> +
> +        for (uint32_t i = 1; i < aplic->num_irqs; i++) {
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SOURCECFG_BASE + (i - 1) * 4,
> +                                     aplic->sourcecfg + i, false);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_TARGET_BASE + (i - 1) * 4,
> +                                     aplic->target + i, false);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int riscv_aplic_post_load(void *opaque, int version_id)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    if (!riscv_use_emulated_aplic(aplic->msimode)) {
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_DOMAINCFG,
> +                                 &aplic->domaincfg, true);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_GENMSI,
> +                                 &aplic->genmsi, true);
> +
> +        for (uint32_t i = 1; i < aplic->num_irqs; i++) {
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SOURCECFG_BASE + (i - 1) * 4,
> +                                     aplic->sourcecfg + i, true);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_TARGET_BASE + (i - 1) * 4,
> +                                     aplic->target + i, true);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_riscv_aplic = {
>      .name = "riscv_aplic",
> -    .version_id = 3,
> -    .minimum_version_id = 3,
> -    .needed = riscv_aplic_state_needed,
> +    .version_id = 4,
> +    .minimum_version_id = 4,
> +    .pre_save = riscv_aplic_pre_save,
> +    .post_load = riscv_aplic_post_load,
>      .fields = (const VMStateField[]) {
>              VMSTATE_UINT32(domaincfg, RISCVAPLICState),
> -            VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
> -            VMSTATE_UINT32(mmsicfgaddrH, RISCVAPLICState),
> -            VMSTATE_UINT32(smsicfgaddr, RISCVAPLICState),
> -            VMSTATE_UINT32(smsicfgaddrH, RISCVAPLICState),
>              VMSTATE_UINT32(genmsi, RISCVAPLICState),
> -            VMSTATE_UINT32(kvm_msicfgaddr, RISCVAPLICState),
> -            VMSTATE_UINT32(kvm_msicfgaddrH, RISCVAPLICState),
> -            VMSTATE_VARRAY_UINT32(sourcecfg, RISCVAPLICState,
> -                                  num_irqs, 0,
> -                                  vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(state, RISCVAPLICState,
> +            VMSTATE_VARRAY_UINT32(sourcecfg , RISCVAPLICState,
Nit: trailing space before comma in "sourcecfg , RISCVAPLICState".
                                              ^

>                                    num_irqs, 0,
>                                    vmstate_info_uint32, uint32_t),
>              VMSTATE_VARRAY_UINT32(target, RISCVAPLICState,
>                                    num_irqs, 0,
>                                    vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(idelivery, RISCVAPLICState,
> -                                  num_harts, 0,
> -                                  vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(iforce, RISCVAPLICState,
> -                                  num_harts, 0,
> -                                  vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(ithreshold, RISCVAPLICState,
> -                                  num_harts, 0,
> -                                  vmstate_info_uint32, uint32_t),
>              VMSTATE_END_OF_LIST()
> -        }
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_riscv_aplic_emul,
> +        &vmstate_riscv_aplic_in_kernel,
> +        NULL
> +    }
The subsection approach for splitting emulated vs in-kernel state looks
good overall.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
>  };
> 
>  static void riscv_aplic_class_init(ObjectClass *klass, const void *data)
> diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.h
> index c7a4d4ad01..1976bea68c 100644
> --- a/include/hw/intc/riscv_aplic.h
> +++ b/include/hw/intc/riscv_aplic.h
> @@ -53,6 +53,9 @@ struct RISCVAPLICState {
>      uint32_t *idelivery;
>      uint32_t *iforce;
>      uint32_t *ithreshold;
> +    uint32_t *setip;
> +    uint32_t *clrip;
> +    uint32_t *setie;
> 
>      /* topology */
>  #define QEMU_APLIC_MAX_CHILDREN        16
> @@ -66,6 +69,7 @@ struct RISCVAPLICState {
>      uint32_t num_harts;
>      uint32_t iprio_mask;
>      uint32_t num_irqs;
> +    uint32_t nr_words;
>      bool msimode;
>      bool mmode;
> 
> -- 
> 2.27.0
> 

