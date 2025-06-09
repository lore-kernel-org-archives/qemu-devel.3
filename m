Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D87C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 03:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOTQA-0005Sg-E3; Sun, 08 Jun 2025 23:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOTQ8-0005RA-B3; Sun, 08 Jun 2025 23:43:36 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOTQ6-0005ph-KI; Sun, 08 Jun 2025 23:43:35 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-87ec5e1cd4aso717206241.0; 
 Sun, 08 Jun 2025 20:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749440613; x=1750045413; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HpJQqH+yrQPF0BrosfCzWPtxiMQ1CdZvUtFBXgxXCoQ=;
 b=aEpN6OwEhMjw7kSZSzNiw+/8JO4YixqZmu+4O5sov8dGXfdCjjTj1BgHscJUqk4D/m
 uSDIR1DXgDKnnggqAYFcD1AZ4nViBXM5vyoOnSSNUX9/lTOx6DsGLz2bdPyo0LBgZQx0
 kRabLeheRGFB4QK/A5PFGj4uUKgALh6pjW6i0kvMRNCqbs/1BqjMX0aykEWkv9ln7PMk
 qUo3yo3bL0wvJf+FIaYBEzky8ZBdR2PRyd2rLw2cLaqZswcc28lIsH9jUMxZKYNmCVa5
 LUnecjquWf4Z/Do2Dik5MOJmMYCmu671zKop8+GKqZI/8eUFKjaUc/WC5lDzVVdqkEKW
 Q3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749440613; x=1750045413;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HpJQqH+yrQPF0BrosfCzWPtxiMQ1CdZvUtFBXgxXCoQ=;
 b=BNJvrL+ppFGMuV3dWprwZgQj5PwuR+lHJBG2ZFgvwMyvMv6KkToLi7TBR37wArmvfi
 I8ekDk2y1wPJ+slzL+aNQD75ru0B9gXjQQ+cIaLQqvAQsv5BfHcnAQiapgEpFEFdphvg
 BNlTE/uUh25WsNY7yjVHCYxBxjtvI8R06epCc3T8aODFXtqz3c/8UI1oX7e2ljvkRluD
 BJ1YPIUI6Yos8pp+1OMmOYypc2QkJP1Yki8t4fF5Mi3FRpifLybUC3uR5Cdp1XPZlGJT
 eqZNAbb4AjsHd4+mSx22r9Tw8N/LmRTz4PAuD071wTLY/t6HBzuo8abUGVGkgf6Ac0Rs
 vK6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6rMkOrutQcUOr2l8Ve0cATaYvYF+ciwt1aa6R2cOslrubrlEVLMOlCBeOKYaGDOb/ddfHX58RxUF9@nongnu.org
X-Gm-Message-State: AOJu0YwvNSg/U84WVp2FfBJnD7taPBGV0V/4cLkI0ECrlvH5CEmsilG+
 5cadEkTdUDq3pUy6tskomj3/gJOlawSCTxLraYt/7x0ye1nOLN4kuvE5ybzccqbvMaY469M7ZtD
 qRB+8N202dsAFR8bC1uiloQCtk6gUGgM=
X-Gm-Gg: ASbGncvUeVHYZDd69ShkjZaP2onU8I0KUMNJLUMfbRrhKsI0Ea5Jn10n0IyTO8+i7qR
 5kNL6l1kVp9+6MA1CsIHUYRM4bnwxsRsrqJ2cLBp/JkK+ZOzrNkmeltM5TcWw/O2bXYAEr2KXV6
 HPL9Yb8bZFB+vBHa5b+nUvNc9sliyhSWhpq3YzU0+CKjW4BVYD2+l13AJTdYl6c7qIbq5OaltFN
 g==
X-Google-Smtp-Source: AGHT+IEH/h1c7Ez/wSpoLstq/nckWnjcGmNZh6uXlMEanW/kRXCWs/+e2KbfAsQNPdoI2liSKaI1eMPKPIjzgQjdXz4=
X-Received: by 2002:a05:6102:440b:b0:4c5:1c2e:79f5 with SMTP id
 ada2fe7eead31-4e772ab5f15mr8508912137.16.1749440613348; Sun, 08 Jun 2025
 20:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250606092406.229833-1-zhenzhong.duan@intel.com>
 <20250606092406.229833-6-zhenzhong.duan@intel.com>
In-Reply-To: <20250606092406.229833-6-zhenzhong.duan@intel.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Jun 2025 13:43:07 +1000
X-Gm-Features: AX0GCFv9Kyyf9jolxFk-MMeiioF35pdBcGaRKc8IYjeDliFYE4w6BJivizl-GKc
Message-ID: <CAKmqyKNao8r1TDzKMyA7R5aBnijNndF8xozeYteEVnXrWMzKcw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] hw/riscv/riscv-iommu: Remove definition of
 RISCVIOMMU[Pci|Sys]Class
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, chao.p.peng@intel.com, david@redhat.com, 
 armbru@redhat.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
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

On Fri, Jun 6, 2025 at 7:29=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@intel=
.com> wrote:
>
> RISCVIOMMUPciClass and RISCVIOMMUSysClass are defined with missed
> parent class, class_init on them may corrupt their parent class
> fields.
>
> It's lucky that parent_realize and parent_phases are not initialized
> or used until now, so just remove the definitions. They can be added
> back when really necessary.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/riscv/iommu.h   | 6 ++----
>  hw/riscv/riscv-iommu-pci.c | 6 ------
>  hw/riscv/riscv-iommu-sys.c | 6 ------
>  3 files changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/include/hw/riscv/iommu.h b/include/hw/riscv/iommu.h
> index b03339d75c..8a8acfc3f0 100644
> --- a/include/hw/riscv/iommu.h
> +++ b/include/hw/riscv/iommu.h
> @@ -30,14 +30,12 @@ typedef struct RISCVIOMMUState RISCVIOMMUState;
>  typedef struct RISCVIOMMUSpace RISCVIOMMUSpace;
>
>  #define TYPE_RISCV_IOMMU_PCI "riscv-iommu-pci"
> -OBJECT_DECLARE_TYPE(RISCVIOMMUStatePci, RISCVIOMMUPciClass, RISCV_IOMMU_=
PCI)
> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStatePci, RISCV_IOMMU_PCI)
>  typedef struct RISCVIOMMUStatePci RISCVIOMMUStatePci;
> -typedef struct RISCVIOMMUPciClass RISCVIOMMUPciClass;
>
>  #define TYPE_RISCV_IOMMU_SYS "riscv-iommu-device"
> -OBJECT_DECLARE_TYPE(RISCVIOMMUStateSys, RISCVIOMMUSysClass, RISCV_IOMMU_=
SYS)
> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOMMUStateSys, RISCV_IOMMU_SYS)
>  typedef struct RISCVIOMMUStateSys RISCVIOMMUStateSys;
> -typedef struct RISCVIOMMUSysClass RISCVIOMMUSysClass;
>
>  #define FDT_IRQ_TYPE_EDGE_LOW 1
>
> diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
> index 1f44eef74e..cdb4a7a8f0 100644
> --- a/hw/riscv/riscv-iommu-pci.c
> +++ b/hw/riscv/riscv-iommu-pci.c
> @@ -68,12 +68,6 @@ typedef struct RISCVIOMMUStatePci {
>      RISCVIOMMUState  iommu;   /* common IOMMU state */
>  } RISCVIOMMUStatePci;
>
> -struct RISCVIOMMUPciClass {
> -    /*< public >*/
> -    DeviceRealize parent_realize;
> -    ResettablePhases parent_phases;
> -};
> -
>  /* interrupt delivery callback */
>  static void riscv_iommu_pci_notify(RISCVIOMMUState *iommu, unsigned vect=
or)
>  {
> diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
> index 74e76b94a5..e34d00aef6 100644
> --- a/hw/riscv/riscv-iommu-sys.c
> +++ b/hw/riscv/riscv-iommu-sys.c
> @@ -53,12 +53,6 @@ struct RISCVIOMMUStateSys {
>      uint8_t *msix_pba;
>  };
>
> -struct RISCVIOMMUSysClass {
> -    /*< public >*/
> -    DeviceRealize parent_realize;
> -    ResettablePhases parent_phases;
> -};
> -
>  static uint64_t msix_table_mmio_read(void *opaque, hwaddr addr,
>                                       unsigned size)
>  {
> --
> 2.34.1
>
>

