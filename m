Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81153CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 00:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIz9X-0008Rx-TD; Tue, 11 Nov 2025 19:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vIz9V-0008Qr-EJ
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 19:56:01 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vIz9T-0006lb-PM
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 19:56:01 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b6d402422c2so60582466b.2
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 16:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762908958; x=1763513758; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nehsPj1Njbpw8eH6b7Hue3QIQrwja1lDXPbzCJGEejY=;
 b=cjNpDbsMk2wuTfAK3IZCOcxuzgcMc/cDZ5s8xB5yWAjC35kDMhvtPIjVPp614x1KPQ
 Z8qxOSRnXO5F1zlqVAwm9y5lMR4P5W6sXgz69bhoVY39oZxPftPdeNaAoVnlwZdFrXnB
 vDb9YUhxUwfDcq+hDI3FF2wYwHO+JYd+GDwGfzCYDmTO2ljIrEq9DtMlSajswDV7HBBw
 2mchNmEV0S7ucwPc9w504oz9Xk1gwfcYcGGjinaNpTIL1lIfO/86ASbn06pmfB+j8n2a
 R2HP3oSKZFSeOx7vbGT9eP/KqAsaiz1PPCCGCRgTIf+S1c//R9DLoI/5gOK953sEcOSU
 UDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762908958; x=1763513758;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nehsPj1Njbpw8eH6b7Hue3QIQrwja1lDXPbzCJGEejY=;
 b=fvBgD6selmtwkJj+6U8MrbATgcos3c629xuO0o1EQvzeZ2VArptDlZNmr4ynLvLhgC
 GcdhTRWEg/KK9tXFpOLXCyzZ1bbCSSbEXgPYQHoKLDjz6LkYi6rn43DzovQ25/kZOXa/
 /VJpFIQcvhntc6VcrnHA8V8hOj5Qt5x29jaW+50FKpzVaVbnDO92yxxdVfyxIp51/nhu
 dP8wyw+mvgVO5Fhte2Y02cYWK361AXEouC0NaD5cCRO7G23i6SygOjM9O7Mc+gdpKYU5
 JGfetUcVEwxl9LlaJVQBA3a5Nn54NzT5PLLip/JksdyNBECm+4D2+F0FR5Dy487hXN3H
 JjkQ==
X-Gm-Message-State: AOJu0YzNrm+dNDhTtWm3Hj3l+ivUBbj/keArVbig0pA1ipXWAvlg1Uhh
 vfafiwOLEX6RYGGlGGIvayyNLJuTtgJxPLqu51+DyVargBmL3xJtzaQI4FMN8XRXgJ8tnXonWuc
 +ssjdcBYBLWSQeF2b5zVp9RClvgEicSg=
X-Gm-Gg: ASbGnctao0adhTPvqQM6siiCjqZhoI+NVkASfiChL2Qd76tsxTQhAoqcysKGvXQzQpC
 fytHBaM12M9jaFnBEptwN+5xCfwy2MRI83GPSrLuueIpdqvqYPC5ohCu0mcHp9A8sMdEXcCLecM
 1AIkoijSqVmCUDs1eWtGje9EZVVOY+URfLhelc5QTCss1ePqCDD1fKyfeySEM1EqPNHvB6yfla5
 c16f2ynosWSMA9Oj7Zi+h6AMFa54OSrUPVrLU19oGf5eFt3uHSMRsqvhnX7Ef1YMUt7B/GdK+2k
 0L0x3R2g+7N7uvk=
X-Google-Smtp-Source: AGHT+IEIxxKYkF495ywXanBzbf9Wuhz2V7w+3NNfAH8svum6wnRlvGHunvjMCTQ0DVmtiOYxO7i6xB8i7Xsmo1ELBJM=
X-Received: by 2002:a17:907:1c9f:b0:b6d:c44a:b69b with SMTP id
 a640c23a62f3a-b7331a6f6ffmr104447566b.35.1762908957725; Tue, 11 Nov 2025
 16:55:57 -0800 (PST)
MIME-Version: 1.0
References: <20251029-n-novikov-aplic_aia_ro-v1-0-39fec74c918a@syntacore.com>
 <20251029-n-novikov-aplic_aia_ro-v1-1-39fec74c918a@syntacore.com>
In-Reply-To: <20251029-n-novikov-aplic_aia_ro-v1-1-39fec74c918a@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Nov 2025 10:55:31 +1000
X-Gm-Features: AWmQ_bnL0PCh2AxaOy2JgJ0M8rfuVRy4FjL3jg8AgmehDERDXzMbLGTYhSfxTQc
Message-ID: <CAKmqyKPDBx-xe4HHgySVM+4hRxXUUibOFeb1qBck2O28q8JGwg@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/intc/riscv_aplic: Expand inactive source handling
 for AIA target[i]
To: Nikita Novikov <n.novikov@syntacore.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x630.google.com
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

On Wed, Oct 29, 2025 at 5:19=E2=80=AFPM Nikita Novikov <n.novikov@syntacore=
.com> wrote:
>
> According to the RISC-V AIA v1.0, section 4.5.2 ("Source configurations")=
,
> register target[i] shall be read-only zero when interrupt source i is ina=
ctive
> in this domain. A source is inactive if it is delegated to a child domain=
 or
> its source mode is INACTIVE.
>
> The previous implementation only checked SM =3D=3D INACTIVE. This patch a=
dds
> full compliance:
> - Return zero on read if D =3D=3D 1 or SM =3D=3D INACTIVE
> - Ignore writes in both cases
>
> Fixes: b6f1244678 ("intc/riscv_aplic: Fix target register read when sourc=
e is inactive")
> Signed-off-by: Nikita Novikov <n.novikov@syntacore.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/riscv_aplic.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index a2041e702245211ba3bcf4334301d7c86272e36f..8c3b16074cd3ca1bc3004cfaa=
a13f34b8860bd48 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -193,6 +193,26 @@ void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState =
*aplic, hwaddr addr)
>  #endif
>  }
>
> +/*
> + * APLIC target[i] must be read-only zero if the source i is inactive
> + * in this domain (delegated or SM =3D=3D INACTIVE)
> + */
> +static inline bool riscv_aplic_source_active(RISCVAPLICState *aplic,
> +                                             uint32_t irq)
> +{
> +    uint32_t sc, sm;
> +
> +    if ((irq =3D=3D 0) || (aplic->num_irqs <=3D irq)) {
> +        return false;
> +    }
> +    sc =3D aplic->sourcecfg[irq];
> +    if (sc & APLIC_SOURCECFG_D) {
> +        return false;
> +    }
> +    sm =3D sc & APLIC_SOURCECFG_SM_MASK;
> +    return sm !=3D APLIC_SOURCECFG_SM_INACTIVE;
> +}
> +
>  static bool riscv_aplic_irq_rectified_val(RISCVAPLICState *aplic,
>                                            uint32_t irq)
>  {
> @@ -635,7 +655,7 @@ static void riscv_aplic_request(void *opaque, int irq=
, int level)
>
>  static uint64_t riscv_aplic_read(void *opaque, hwaddr addr, unsigned siz=
e)
>  {
> -    uint32_t irq, word, idc, sm;
> +    uint32_t irq, word, idc;
>      RISCVAPLICState *aplic =3D opaque;
>
>      /* Reads must be 4 byte words */
> @@ -703,8 +723,7 @@ static uint64_t riscv_aplic_read(void *opaque, hwaddr=
 addr, unsigned size)
>      } else if ((APLIC_TARGET_BASE <=3D addr) &&
>              (addr < (APLIC_TARGET_BASE + (aplic->num_irqs - 1) * 4))) {
>          irq =3D ((addr - APLIC_TARGET_BASE) >> 2) + 1;
> -        sm =3D aplic->sourcecfg[irq] & APLIC_SOURCECFG_SM_MASK;
> -        if (sm =3D=3D APLIC_SOURCECFG_SM_INACTIVE) {
> +        if (!riscv_aplic_source_active(aplic, irq)) {
>              return 0;
>          }
>          return aplic->target[irq];
> @@ -841,6 +860,9 @@ static void riscv_aplic_write(void *opaque, hwaddr ad=
dr, uint64_t value,
>      } else if ((APLIC_TARGET_BASE <=3D addr) &&
>              (addr < (APLIC_TARGET_BASE + (aplic->num_irqs - 1) * 4))) {
>          irq =3D ((addr - APLIC_TARGET_BASE) >> 2) + 1;
> +        if (!riscv_aplic_source_active(aplic, irq)) {
> +            return;
> +        }
>          if (aplic->msimode) {
>              aplic->target[irq] =3D value;
>          } else {
>
> --
> 2.51.0
>
>

