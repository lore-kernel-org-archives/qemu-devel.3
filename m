Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F9FC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 05:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfWbJ-0003Ii-3x; Fri, 03 Jul 2026 01:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wfWbE-0003IA-3c
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 01:38:05 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wfWbB-0001Q5-Fr
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 01:38:03 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-698aa7ba3e6so381769a12.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 22:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783057078; cv=none;
 d=google.com; s=arc-20260327;
 b=hXwMxNIF+rty4wck3TnIR2P0hzcYljSF57bS0etoCysjFutwvA3A4rEagmMSTo5BCM
 LbWR6UIld5PNnJf4yICXjyKywRoJGT7egpANwwIV1jWRnQPB8qxJUR/8ebls9tqdJlBH
 FQr5pwssF0xh29aJU1lW3K8Fw17EIFlT+OZONXJ7HF6XtAN20CIdzu9ZWp8a1xEPxQ/0
 1TZD0nIDM65+OMrCy2gBaQGiuyVihThdzyIpwGSSg1l1yo/AmUUTUUKYrmkmGa0h8ros
 fVF29POqLf0Qa6siDoyPUmnc3mKrgs7o8ZuKj7WuK66wjKaw7zqa6OjOK/XiKw5tp02m
 w6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GivYgMkXrvPeyJM6z4daeIyp29wkIg8ZlMKrnTpJvsQ=;
 fh=KLHGcCjDFE8JakAsekM1idRm6q0Xvx801j4ETmug+Fk=;
 b=bEJAzLcYaD4w5zjx6dPDyQIw3tbGiVKdD7FWVRpmdTMwe423VZpPLr8A91cXaqMYr3
 /JqxxnCyWyuPCr+kBe8NpXawsRsJprUVzXBg3moiFIo8UHQHQZMFsPIkMgnKq7ZmvVa0
 rikXZ1MW0dPp8zWr/NIGjxnKiaM7AW5AtlxzojWdSly/K+vc7G8qvIQTZILccRuCT99c
 +KBM8aLxumHkVZWEz6zdWeENIqTH6wBu9ujwdeyMd2XlMJSW3xan6jqV8pbG8o40+ysb
 ewGHmB3gUrU8icBpU3+DxeMAIHe8ogIMivSex3YQYpGL0hIguCCVgRDZr7mALw74VStx
 gczA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783057078; x=1783661878; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GivYgMkXrvPeyJM6z4daeIyp29wkIg8ZlMKrnTpJvsQ=;
 b=dx1ePKwuXSoWaLT0Oq0jEVvGwhXsDiHje5yQhCKUzL5/2Lx9s6ZqbGmOkl2HIpT4l+
 mVqQe/cchsKgExn1E08exbAC4dBH5mWA+s9eGlNGmjXAXt9ZC01s30fUS+QVG9a5M/N3
 puIjySYqeDAmP+519yYXwVmZ+9+UxzopeSqw/PzrjNzwb+vWYSQgCnop0A6AS6yzUnsH
 8YWo6SLMth8rF2L65z5XVctvNJ4lpPyNw7sH3wSsbcOxF5wX2YkHErCSfU7/fYNEtvOE
 BtpMVqpeFj4vBOraV4LqDoC3qQ29SvBTVRwM62KtnhJiVLTUhG9NhJVYTG6kJ11Dw3rQ
 5qxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783057078; x=1783661878;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GivYgMkXrvPeyJM6z4daeIyp29wkIg8ZlMKrnTpJvsQ=;
 b=VyTtK7qLraISxRBMbhgGszA5RU3baK81ghzwhJMaWYEzFwFHg8Gl84BvBK5yDpSHUv
 xxdBFmU29kidqrrff7eioxV+Da9fVzBKxf02oK9hIgbRuLaWIN9MTyCPMeJCnjCsasD1
 ageRUe+W/gnpFaWMxhghxZRd+zPkyKUA0i59K20wDF8yUAwnlhfMCx6pswTlnZuTJGbH
 WsFogF91L0Fa6Fv+R0K9i0ozUBKbjsH79/Udi1XOHoNsLxBr4gVEDEsKSfScOtSRDpm6
 PSeBbJPsMye8G9Je5W/6WyTdBMJVNQ7bJ90Ko8XWOvqBOh9bgjtsc8b0ySwhfyD+T93Z
 rmjg==
X-Gm-Message-State: AOJu0YzE2IZl2dDhyTDxT2SUPBCmL990dfXz6uRp0CETVlsW+mmtajwi
 g4M7W678TTMUysOTajZJNUBps+6PDqOExOd0aoNaTt8qVzyFNdXB9P+iB7RiSPLrbD5BZKmLwQa
 YYU8NeIZqQxTjOqrFsfgWiY+mHpNbP4o=
X-Gm-Gg: AfdE7clxYKxv6qTrtGBNy912nj2Fv5Pj/B0yumjF5mBFO0PBnX4g/vIo1NdGdVUMW48
 UqbtHLUR6zpTobMTUe6LXF+ucJnOYWdShybp5CBN7ydizYtFPcutLSOD4FjjNdfpkA/1mpXQGr9
 n8kkiCYm9mymF/DITJ0QLoNnbaVgGFWylcSWciorKm/Rin5qlydKHCLPdddu7sFkK88TROY4RHC
 f+1AegjswDMDaCh41Hm7du4ZiYeMDIiSf56XCMBL/1S02nAycGDsQ/S9qNBoCFkPtrTW51QKTy5
 Q6NOknSS9jEo3V+Z4Lb5Lv4qSkc=
X-Received: by 2002:a05:6402:5409:b0:697:df42:2633 with SMTP id
 4fb4d7f45d1cf-6989f35319bmr3780592a12.24.1783057077863; Thu, 02 Jul 2026
 22:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260629165954.1018123-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260629165954.1018123-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 Jul 2026 15:37:31 +1000
X-Gm-Features: AVVi8Cfbd-3OZwnxzxdkhinTU_9CkJEKeW5OelNysCWLTS-1WjSaKO7Lf0I9jsw
Message-ID: <CAKmqyKOzznSG8wNjmCLyroArEXvp0FirteP03h-1DKZ9RFRPDg@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu-sys.c: record fault on
 IOMMU-generated MSI write
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 30, 2026 at 3:02=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> The riscv-iommu spec requires that the IOMMU records its own generated
> MSI write faults.
>
> Fixes: 01c1caa9d1 ("hw/riscv/virt.c, riscv-iommu-sys.c: add MSIx support"=
)
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3572
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/riscv-iommu-sys.c | 16 +++++++++++++++-
>  hw/riscv/riscv-iommu.c     |  3 +--
>  hw/riscv/riscv-iommu.h     |  1 +
>  3 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
> index bf87b0b4ea..3314adeed2 100644
> --- a/hw/riscv/riscv-iommu-sys.c
> +++ b/hw/riscv/riscv-iommu-sys.c
> @@ -26,6 +26,7 @@
>  #include "qemu/host-utils.h"
>  #include "qemu/module.h"
>  #include "qom/object.h"
> +#include "target/riscv/cpu_bits.h"
>  #include "trace.h"
>
>  #include "riscv-iommu.h"
> @@ -143,7 +144,20 @@ static void riscv_iommu_sysdev_send_MSI(RISCVIOMMUSt=
ateSys *s,
>
>      address_space_stl_le(&address_space_memory, msi_addr,
>                           msi_data, MEMTXATTRS_UNSPECIFIED, &result);
> -    trace_riscv_iommu_sys_msi_sent(vector, msi_addr, msi_data, result);
> +
> +    if (result =3D=3D MEMTX_OK) {
> +        trace_riscv_iommu_sys_msi_sent(vector, msi_addr, msi_data, resul=
t);
> +    } else {
> +        /* Record an access fault error in the fault queue */
> +        struct riscv_iommu_fq_record ev =3D { 0 };
> +        RISCVIOMMUState *iommu =3D &s->iommu;
> +
> +        ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_CAUSE,
> +                           RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT);
> +        ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_TTYPE,
> +                           RISCV_IOMMU_FQ_TTYPE_UADDR_WR);
> +        riscv_iommu_fault(iommu, &ev);
> +    }
>  }
>
>  static void riscv_iommu_sysdev_notify(RISCVIOMMUState *iommu,
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index c9687e01a8..a962926688 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -118,8 +118,7 @@ void riscv_iommu_notify(RISCVIOMMUState *s, int vec_t=
ype)
>      }
>  }
>
> -static void riscv_iommu_fault(RISCVIOMMUState *s,
> -                              struct riscv_iommu_fq_record *ev)
> +void riscv_iommu_fault(RISCVIOMMUState *s, struct riscv_iommu_fq_record =
*ev)
>  {
>      uint32_t ctrl =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQCSR);
>      uint32_t head =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQH) & s-=
>fq_mask;
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index a778e86fb7..da70e8bfa8 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -103,6 +103,7 @@ void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iom=
mu, PCIBus *bus,
>  void riscv_iommu_set_cap_igs(RISCVIOMMUState *s, riscv_iommu_igs_mode mo=
de);
>  void riscv_iommu_reset(RISCVIOMMUState *s);
>  void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type);
> +void riscv_iommu_fault(RISCVIOMMUState *s, struct riscv_iommu_fq_record =
*ev);
>
>  typedef struct RISCVIOMMUContext RISCVIOMMUContext;
>  /* Device translation context state. */
> --
> 2.43.0
>
>

