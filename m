Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6272CD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmcu-0000Om-BZ; Sun, 17 May 2026 21:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmcs-0000OV-Mi
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:18:34 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmcq-00023a-Nd
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:18:34 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-67be871ed3fso4259521a12.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:18:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779067111; cv=none;
 d=google.com; s=arc-20240605;
 b=CGhXXarEVTX/VIsBQHOvYJf0yH9LZjkZgAJG7PW1kHuWdNNZnmmp06SYHYk+KQf3g9
 ULiHtptvBne15xC/2qnkSGNG/7SYtrYvgZ06KBOuWLE1g4Gvbx85RRHFKCCuyMSAkX1z
 DyBkFpGDd/q/cGEc5pWANj6v3EjvcXKAPJrpQpSF+HIQYyUvFJBVQRRKlO/fbAr+uiQP
 qbJoEq4AV/ZJhqRxY0UaC7qdfTEgQ9KXSi08a1QPZZC2smnXd9cG38ldzBQex0jETacO
 FVJfc+ANnIgq79vHnFb4C6cTugaxEpaQ+WSijpF71ycFejqDBBy1hLQ9iiz/edh1pndN
 JRag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Wcb6etAKn2qbEKAalBs5Du8lhzyZfWnYepcNYjzsu7E=;
 fh=lCjjL/xBgBtHfVSEqUt1w3G6eotEmH20BGb3/upji1Q=;
 b=hNm4qo/GxfFyJYqDxCiBYx7aADhypJGXTKgvdVmS2o029zaiJOZqwjTlsyFFoESHOB
 vr0pU4CbRCTNUD8a49pUwoRihraKt2dtSEVyvc/SDQZjEaMW8cAFG2y1DsJppD0mYd7w
 YnjneoOCQC/p5NG9bcwDWT6MxVMtFJg38NxVxI9Shw6zbZlcCv4quwUWwuPa/g6PCTdL
 wNvbmWTVhou9DN3iVAcnd0LQ89hq6Xbp3gF0OTkYmxNjJlG7pWsMcnDxJr9HNw7cE7NS
 km5lvlRTSIRv2wO54heTazGisIHq1tHFGv+k76VEVdhFtMILU/jipGLOc5H4ZX91tjMw
 Gjbw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779067111; x=1779671911; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wcb6etAKn2qbEKAalBs5Du8lhzyZfWnYepcNYjzsu7E=;
 b=kHyoomZ9QqTQ3c4Bs05Srf7WeSSJ5RUO/qLPmplOzWtOyVqidL70cfyEV3gqG29Ocd
 1fKtN/NZAZhUmnstThpDpFkp9vZupfw38w0Ra9aVM7/XjZ5Hrj3XWFEcqi2n8fXZr35w
 v84hmU5lv8acSwwdfeaFF0v5mzV8D2ZjL3fHCHL0sWrxreeqteqCeR7q2DY5HU3wMQQu
 dicy/rGms2T4gFdn9CzfPT/PbDru1WYAkufxlkgk4sdVHVi4IIXjqvkurij+W2FOQ2d0
 u43QdycKLdo+TmWyGBMWh9FWARLjuJzxL+1GUn4fxBIVI4rpXbJKvqJIgVdaeolyRsKv
 rRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779067111; x=1779671911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wcb6etAKn2qbEKAalBs5Du8lhzyZfWnYepcNYjzsu7E=;
 b=AA64oAufqfF4YKaEf5Q5AAvc+ADtda858tNxM2IvbyT7qmNZBeKqlHTaKeU050GmL1
 AUEVTBilVlM+5cQ+6wcVwHdOKrueneiqRdNcJ1gKXYNFORSC8Di5DSBViwPgyKxLuc9i
 aW1kFYTL24O/vNXCnXP+AKGAs8O8uvinHq0h2sXK3sLNjTOb1ruHW+72YZTUcLAeCy8J
 V9HnLY65Whufg+x6Jfj6e3nMgoXkdhl/yhstSSZkePTmI1/CsVsTQh4+mZnXEYmDd7ya
 IfxuQt2ZBoeIS9pwpYXsrxGoz5oHxK0fKT2VuHJrL8EbZ3PVBCN/LD0rAogLWPljq2by
 Ivuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8CcQaO+ZocOWYGbAUnGWEDeCcFXRO5qXq/RXZ4UdADLDT2Y4CRGw8ytqehje0b6s2Cy+rnIU25lIEQ@nongnu.org
X-Gm-Message-State: AOJu0YxgygsQcAH+yHI/rrxWgnQxOwtM5G3/QHPc5ZOhF5DbphNbGm3w
 AEQqTb75XjMccJ2IW85iKevke2fBAzvYVfCTk28oERpXC43vQ/i5pV+mEJIV5OMdmMJVTRO5tar
 9xGug7BkaVpEsbtzqqKXiD8x/wlDTESY=
X-Gm-Gg: Acq92OHg4yr4B2JyZgObjJhWit4DtAwRJmTC6AlS6JCWZ1dyvuEyf/Ku1R2lfjxeml7
 hCOMd5YYZG1gXMG90Crz/REHHPM4myg51sE2v1KEcu+qiMbEcrMfFrMC0Y5GPhK8wUac6thKMWb
 x92KR612A2OmkgPcJySzYKq8wMVM6K/i334hyrDFqig092mZQVLSEsLLgE4lnBQTNGXYbdvUdcI
 IrLqPewckIdeIocJhHox7NZwLR5cfrsEsN4stoj8dmyChzcaD1mFw2i4/Fz4bZ/lbg5HWUe/zs5
 aj/PKLxfqIyeHTRuFZJJDJtzzd9EkcTUj9tnyP/cGYczqyt8
X-Received: by 2002:a17:906:eec4:b0:bd5:17f9:e987 with SMTP id
 a640c23a62f3a-bd517f9eb24mr523537066b.46.1779067110798; Sun, 17 May 2026
 18:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260514020637.2819308-1-gaochengbo@bosc.ac.cn>
In-Reply-To: <20260514020637.2819308-1-gaochengbo@bosc.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 11:18:03 +1000
X-Gm-Features: AVHnY4KGYWmJVOZdTF8DRQGymBEuqJyRnpw0XCstbcZDJh1HZMCshCLqWS5oVzo
Message-ID: <CAKmqyKPuu7ueGy6EhdsK6BMkJF2GOQdUeBH2n9smTWBp8Hn79Q@mail.gmail.com>
Subject: Re: [PATCH v1] hw/riscv/riscv-iommu: Avoid caching PCI device IDs
To: Chengbo Gao <gaochengbo@bosc.ac.cn>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
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

On Thu, May 14, 2026 at 12:09=E2=80=AFPM Chengbo Gao <gaochengbo@bosc.ac.cn=
> wrote:
>
> PCI bus numbers may still be unassigned when QEMU initializes a PCI
> device's bus-master address space.  For devices behind bridges,
> pci_bus_num() can return 0 at that point because the guest has not yet
> programmed the bridge Secondary Bus Number register.
>
> The RISC-V IOMMU currently stores a fixed device_id in RISCVIOMMUSpace
> when the address space is created.  If the guest later enumerates the
> device on a non-zero bus, DMA translation still uses the stale device_id
> and may look up the wrong device context in the DDT.
>
> Store the stable PCIBus pointer and devfn in RISCVIOMMUSpace instead,
> and compute the device_id from the current bus number when it is needed.
> This keeps DMA translation and ATS invalidation in sync with guest PCI
> bus enumeration.
>
> Signed-off-by: Chengbo Gao <gaochengbo@bosc.ac.cn>

Thanks!

Applied to riscv-to-apply.next

Alistair


> ---
>  hw/riscv/riscv-iommu.c | 40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 7ba3240552..9a75639549 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -49,7 +49,8 @@ struct RISCVIOMMUSpace {
>      IOMMUMemoryRegion iova_mr;  /* IOVA memory region for attached devic=
e */
>      AddressSpace iova_as;       /* IOVA address space for attached devic=
e */
>      RISCVIOMMUState *iommu;     /* Managing IOMMU device state */
> -    uint32_t devid;             /* Requester identifier, AKA device_id *=
/
> +    PCIBus *bus;                /* PCI bus of the requester */
> +    uint8_t devfn;              /* Requester identifier, AKA device_id *=
/
>      bool notifier;              /* IOMMU unmap notifier enabled */
>      QLIST_ENTRY(RISCVIOMMUSpace) list;
>  };
> @@ -74,6 +75,15 @@ struct RISCVIOMMUEntry {
>  /* IOMMU index for transactions without process_id specified. */
>  #define RISCV_IOMMU_NOPROCID 0
>
> +static uint32_t riscv_iommu_space_devid(RISCVIOMMUSpace *as)
> +{
> +    uint32_t devid =3D PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
> +
> +    /* FIXME: PCIe bus remapping for attached endpoints. */
> +    devid |=3D as->iommu->bus << 8;
> +    return devid;
> +}
> +
>  static uint8_t riscv_iommu_get_icvec_vector(uint32_t icvec, uint32_t vec=
_type)
>  {
>      switch (vec_type) {
> @@ -1343,15 +1353,13 @@ static void riscv_iommu_ctx_put(RISCVIOMMUState *=
s, void *ref)
>  }
>
>  /* Find or allocate address space for a given device */
> -static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devi=
d)
> +static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, PCIBus *bus,
> +                                            int devfn)
>  {
>      RISCVIOMMUSpace *as;
>
> -    /* FIXME: PCIe bus remapping for attached endpoints. */
> -    devid |=3D s->bus << 8;
> -
>      QLIST_FOREACH(as, &s->spaces, list) {
> -        if (as->devid =3D=3D devid) {
> +        if (as->bus =3D=3D bus && as->devfn =3D=3D devfn) {
>              break;
>          }
>      }
> @@ -1361,10 +1369,11 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMU=
State *s, uint32_t devid)
>          as =3D g_new0(RISCVIOMMUSpace, 1);
>
>          as->iommu =3D s;
> -        as->devid =3D devid;
> +        as->bus =3D bus;
> +        as->devfn =3D devfn;
>
>          snprintf(name, sizeof(name), "riscv-iommu-%04x:%02x.%d-iova",
> -            PCI_BUS_NUM(as->devid), PCI_SLOT(as->devid), PCI_FUNC(as->de=
vid));
> +            pci_bus_num(bus), PCI_SLOT(devfn), PCI_FUNC(devfn));
>
>          /* IOVA address space, untranslated addresses */
>          memory_region_init_iommu(&as->iova_mr, sizeof(as->iova_mr),
> @@ -1374,8 +1383,8 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUSt=
ate *s, uint32_t devid)
>
>          QLIST_INSERT_HEAD(&s->spaces, as, list);
>
> -        trace_riscv_iommu_new(s->parent_obj.id, PCI_BUS_NUM(as->devid),
> -                PCI_SLOT(as->devid), PCI_FUNC(as->devid));
> +        trace_riscv_iommu_new(s->parent_obj.id, pci_bus_num(bus),
> +                PCI_SLOT(devfn), PCI_FUNC(devfn));
>      }
>      return &as->iova_as;
>  }
> @@ -1696,7 +1705,7 @@ static void riscv_iommu_ats(RISCVIOMMUState *s,
>      pid =3D get_field(cmd->dword0, RISCV_IOMMU_CMD_ATS_PID);
>
>      QLIST_FOREACH(as, &s->spaces, list) {
> -        if (as->devid =3D=3D devid) {
> +        if (riscv_iommu_space_devid(as) =3D=3D devid) {
>              break;
>          }
>      }
> @@ -2710,8 +2719,9 @@ static IOMMUTLBEntry riscv_iommu_memory_region_tran=
slate(
>          .addr_mask =3D ~0ULL,
>          .perm =3D flag,
>      };
> +    uint32_t devid =3D riscv_iommu_space_devid(as);
>
> -    ctx =3D riscv_iommu_ctx(as->iommu, as->devid, iommu_idx, &ref);
> +    ctx =3D riscv_iommu_ctx(as->iommu, devid, iommu_idx, &ref);
>      if (ctx =3D=3D NULL) {
>          /* Translation disabled or invalid. */
>          iotlb.addr_mask =3D 0;
> @@ -2723,8 +2733,8 @@ static IOMMUTLBEntry riscv_iommu_memory_region_tran=
slate(
>      }
>
>      /* Trace all dma translations with original access flags. */
> -    trace_riscv_iommu_dma(as->iommu->parent_obj.id, PCI_BUS_NUM(as->devi=
d),
> -                          PCI_SLOT(as->devid), PCI_FUNC(as->devid), iomm=
u_idx,
> +    trace_riscv_iommu_dma(as->iommu->parent_obj.id, PCI_BUS_NUM(devid),
> +                          PCI_SLOT(devid), PCI_FUNC(devid), iommu_idx,
>                            IOMMU_FLAG_STR[flag & IOMMU_RW], iotlb.iova,
>                            iotlb.translated_addr);
>
> @@ -2772,7 +2782,7 @@ static AddressSpace *riscv_iommu_find_as(PCIBus *bu=
s, void *opaque, int devfn)
>
>      /* Find first matching IOMMU */
>      while (s !=3D NULL && as =3D=3D NULL) {
> -        as =3D riscv_iommu_space(s, PCI_BUILD_BDF(pci_bus_num(bus), devf=
n));
> +        as =3D riscv_iommu_space(s, bus, devfn);
>          s =3D s->iommus.le_next;
>      }
>
> --
> 2.34.1
>
>

