Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E965EE9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 16:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt6x5-0007MX-VA; Thu, 19 Feb 2026 11:32:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vt6x3-0007MC-9C
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 11:32:29 -0500
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vt6x1-0006Jr-Ju
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 11:32:29 -0500
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2ba9d13f10eso1705417eec.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 08:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771518746; x=1772123546; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oBlGCkOc3OvacQtM9egHlEJ/s2CBEtz7j+Gm0DO71/U=;
 b=cIqsjsKwyayQt8mgYxM8T4Zo+uidfttz2qUYt0ykLA3DfFwqcuT6DNVtbXdsIyKyDD
 s7FhSq9xKfORCyMGEO6xHWbkeO61Vqupt6d1t/crFuvgBBs/IjUPQeds4cb5SYJXg77D
 aXD1asKjuguy8g21KU6llhU8bhDnKXvAg+ST9Jf8dWQEQpsicAtduOXCXdv/MgjoU9Fx
 J5ViV6aFfSPBrPLjwn5sHnqbYd2eEAVTS2sM6dYVyP+GkHulTqR5xNCadCEhMwsUrnpG
 JtTCYzTNm/CP5SubiXis96P9UAw6A6yxTtgQQ7iIvM1ly6nnVM32SOJvvNqJMsbXoeLl
 ZYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771518746; x=1772123546;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oBlGCkOc3OvacQtM9egHlEJ/s2CBEtz7j+Gm0DO71/U=;
 b=R3sJzpxi0sInph2jQ9dfNIXOkMdqpQrfARXS+7QxgtX5N1KUYBVGKA2y0OfpQsdcR+
 6Hsx4AmTKRDES3YFNDVoGkyedJ8nBHrFxV4UJQCfaC7AdtcI6e2pEuuLmOjJ9PHmMaLd
 mDLz9Wkx6cxvlnRtdJqyYhhnkeoKyvCIaZhX5jbb+lZ3TQyphypWM/IkIyLguZxmLnay
 rK2OqdW2PWgwqIV9lBEhF82GZHdECKCy0cvwZ3q9jvsYkgz+3FQTJ7c+maRVRi2Yawpk
 Ub9s07uPaLvuNi9U/S2RTr795bCAhcQ2qKIG6KQWQtDeOHpYTrc7XsS9fUSUZhHAhQIZ
 OqbA==
X-Gm-Message-State: AOJu0YznaTg2dkUDueUc/30nfFMzbyKSqeEsKx9pksrebg6oGVoYxnAF
 aHtIwvUp9EhHaxTw1cEw3hlMawzIfJgIWSVIJc+GGk7/Ki3A2m2TnKXp
X-Gm-Gg: AZuq6aLy2MTP//Y8f9Lf5D1VLMJWe5QFgYz5T/jBAgCqB5xRZO62n2B8IZsDbdLorNy
 XzOnAUVwAOLK0Ftl70r4DDpuYiSGP8B567/tTf7mV6EjxZKjezcAR8Rmm8mrmwAeZtwkMx7MsgG
 AKKW+PA1YJ4gy5zyvURplonId9puyvnPG0B1s7o7m5W/p7DqAbVF1dKY/pT3ZAts1dLFoDrSb4i
 kgmjRIAaigIHXfDSrlLzZDbk+6rwVWO73WEXz1Cs90br4mboCf0A0R/zToy8FyN23zO1tQP7xps
 iOtK9ZFaOLDj0syVy393y50KMjZABlpjMPFB7HqyR6EXxzpNp8st/3zgU6Ukp+Mcafq17HW1+8s
 43ESVhLEELk7gjTLU7eA4bPxUKaaHXWY6iQVTAVtVul2TI4W7DFGciEN7gVn2WVPOY3N/77dRs7
 PCVQMBdmwKchlIHSJGe7yLUU9dGU1sXTEfzyc9l5axji6lZD50aN6X1HWbdMITVbNByc1UE4ugm
 aNK15urMwc+bNAFGGqOTIWX+0cNmbw=
X-Received: by 2002:a05:693c:6005:b0:2ba:931e:7021 with SMTP id
 5a478bee46e88-2bd5b3ee840mr1460686eec.34.1771518745452; 
 Thu, 19 Feb 2026 08:32:25 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bacb66c24esm20657848eec.27.2026.02.19.08.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 08:32:24 -0800 (PST)
Date: Fri, 20 Feb 2026 00:31:49 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: Re: [PATCH v6 6/7] hw/riscv: Set IOMMU PAS via property
Message-ID: <aZc6dDIjVwfe_zBz@ZEVORN-PC.localdomain>
References: <20260218-phys_addr-v6-0-a603bf363218@rev.ng>
 <20260218-phys_addr-v6-6-a603bf363218@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218-phys_addr-v6-6-a603bf363218@rev.ng>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
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

On Wed, Feb 18, 2026 at 06:21:32PM +0100, Anton Johansson wrote:
> Replaces the only remaining use of TARGET_PHYS_ADDR_SPACE_BITS for RISCV
> with a property RISCVIOMMUState::pas_bits that gets written to the
> capabilities field upon device realization.  This write needs to happen
> at realize-time to ensure the property has been set.
> 
> For the virt machine and sysbus device, pas_bits is set by
> virt_machine_init() to either 34 or 56 bits, retaining previous behaviour.
> However, for the PCI device we do not have access to the CPU state, and
> instead use the maximum riscv64 value of 56 bits.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  hw/riscv/riscv-iommu.h     | 1 +
>  hw/riscv/riscv-iommu-pci.c | 3 +++
>  hw/riscv/riscv-iommu.c     | 8 ++++----
>  hw/riscv/virt.c            | 7 +++++++
>  4 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index 2dabd86941..2a9f6fccd5 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -34,6 +34,7 @@ struct RISCVIOMMUState {
>      /*< public >*/
>      uint32_t version;     /* Reported interface version number */
>      uint32_t pid_bits;    /* process identifier width */
> +    uint32_t pas_bits;    /* physical address bits */
>      uint32_t bus;         /* PCI bus mapping for non-root endpoints */
>  
>      uint64_t cap;         /* IOMMU supported capabilities */
> diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
> index 5f7d359204..14dd5f3857 100644
> --- a/hw/riscv/riscv-iommu-pci.c
> +++ b/hw/riscv/riscv-iommu-pci.c
> @@ -158,6 +158,9 @@ static void riscv_iommu_pci_init(Object *obj)
>  
>      iommu->icvec_avail_vectors = RISCV_IOMMU_PCI_ICVEC_VECTORS;
>      riscv_iommu_set_cap_igs(iommu, RISCV_IOMMU_CAP_IGS_MSI);
> +
> +    /* Report maximum physical address size of riscv64 */
> +    iommu->pas_bits = 56;
>  }
>  
>  static const Property riscv_iommu_pci_properties[] = {
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index b46b337375..98345b1280 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2453,10 +2453,6 @@ static void riscv_iommu_instance_init(Object *obj)
>      /* Enable translation debug interface */
>      s->cap = RISCV_IOMMU_CAP_DBG;
>  
> -    /* Report QEMU target physical address space limits */
> -    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
> -                       TARGET_PHYS_ADDR_SPACE_BITS);
> -
>      /* TODO: method to report supported PID bits */
>      s->pid_bits = 8; /* restricted to size of MemTxAttrs.pid */
>      s->cap |= RISCV_IOMMU_CAP_PD8;
> @@ -2487,6 +2483,9 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
>  {
>      RISCVIOMMUState *s = RISCV_IOMMU(dev);
>  
> +    /* Report QEMU target physical address space limits. */
> +    s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS, s->pas_bits);
> +
>      s->cap |= s->version & RISCV_IOMMU_CAP_VERSION;
>      if (s->enable_msi) {
>          s->cap |= RISCV_IOMMU_CAP_MSI_FLAT | RISCV_IOMMU_CAP_MSI_MRIF;
> @@ -2645,6 +2644,7 @@ void riscv_iommu_reset(RISCVIOMMUState *s)
>  static const Property riscv_iommu_properties[] = {
>      DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
>          RISCV_IOMMU_SPEC_DOT_VER),
> +    DEFINE_PROP_UINT32("pas-bits", RISCVIOMMUState, pas_bits, 0),
>      DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
>      DEFINE_PROP_UINT32("ioatc-limit", RISCVIOMMUState, iot_limit,
>          LIMIT_CACHE_IOT),
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 07e66b3936..bbce2fb667 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1739,6 +1739,13 @@ static void virt_machine_init(MachineState *machine)
>          object_property_set_link(OBJECT(iommu_sys), "irqchip",
>                                   OBJECT(mmio_irqchip),
>                                   &error_fatal);
> +        /*
> +         * For riscv64 use a physical address size of 56 bits (44 bit PPN),
> +         * and for riscv32 use 34 bits (22 bit PPN).
> +         */
> +        object_property_set_uint(OBJECT(iommu_sys), "pas-bits",
> +                                 riscv_is_32bit(&s->soc[0]) ? 34 : 56,
> +                                 &error_fatal);
>  
>          sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
>      }
> 
> -- 
> 2.52.0
> 
LGTM :)

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao

