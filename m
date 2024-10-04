Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6083CFA774
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 12:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swhcr-0003kU-PG; Fri, 04 Oct 2024 08:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apatel@ventanamicro.com>)
 id 1swhcq-0003kE-G3
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 08:41:40 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apatel@ventanamicro.com>)
 id 1swhco-0004ue-Jn
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 08:41:40 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2fac6b3c220so30965741fa.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 05:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1728045696; x=1728650496; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MGUEYeddSdpH6YFBpnvIwd7V4Swka1w/w5wAy1YN9lk=;
 b=K9J5ggr2tbhlb/a6u+rrhnPXkbY7lp8IbpJYP8H+eROrV5uA+BkfuPrcK2Gwxpq887
 bLP8Igls6Db09VdW72JxgncXPODE2tKBYRuFc/odbLL6k2zKXc7uL+cv6HtqSd4TRyV9
 N8xw0cU6M/QoTIeM2tw9KwxR6qPI7T1BAhflc2dJqzgoWkP/8PzOGFXFEPujilGDD1kO
 /f/JwqAhjlAWGviF/yAYdr0vSmwzcr7kGBdqdhd7wgH0xVP7Reo9QBFn3GzKa3m/CqHd
 eYrAevElmsTNaMDPmv5x2fpH3z7mvjD1BYquMe4+XqYNy8qkw9sKOu6Y2YgQgMTPrik4
 tPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728045696; x=1728650496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MGUEYeddSdpH6YFBpnvIwd7V4Swka1w/w5wAy1YN9lk=;
 b=HSvAiathdOhOTtPIqKYJwBJu1iG9MBAfhYAfn8c6SYOtvvNseFlD0fumAzKvl8Jgnu
 //yUMl1q0+9l0PFjBlqIdSpUpuHpHYR72sv5SmTzqRc73YduNzbMCxFYMCJKFOsYQCPS
 8RuAD8bZ+UzTAwTxHtg2XX/OOxUHAvdgefmLrbTRX+axAwt5e7uhvGzzACqNI3PEcGgJ
 THcE1SEixZNxrI4VamojtUE1w/wmWpAW4N/CxPCY0O9r497du7/I8oGthU9pSTbZBLiK
 ePY1fK03rBFrTlt2pB8fdkDzBz2RvK9vfyeo4L1J5k9AHXRdlHBMBK3Rjpa5wBET5W9A
 BPDQ==
X-Gm-Message-State: AOJu0YxyzFdHqR70dZe0ta1xpiTYzKlUQ0cmSbknbGfvLTJ7heCLKR67
 pfVoTJwmfmtsSeWtohqxJux2K8/W7o5Q9u3lGUSGDGkgdXXci+lH6hA2U7S2KEKSM+IMEuVmk+/
 B+Fh/ArQS53vPcvbFGrQLNXATyMLjagOZ+1hLfw==
X-Google-Smtp-Source: AGHT+IHsWFCK+brHBl8zC4pMtSVH3LIGIU873RPpYJ904v9fmHhN4bT3dOyAfTQfLo8IkN9dG1cuR35BuEu9AKESjGk=
X-Received: by 2002:a05:651c:1545:b0:2f7:712d:d08 with SMTP id
 38308e7fff4ca-2faf3c2978amr21087871fa.23.1728045695619; Fri, 04 Oct 2024
 05:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240808082030.25940-1-yongxuan.wang@sifive.com>
In-Reply-To: <20240808082030.25940-1-yongxuan.wang@sifive.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Fri, 4 Oct 2024 18:11:23 +0530
Message-ID: <CAK9=C2UgXRZztQQhw_wS6jQ2wzwwFd8BAosxXRonGBQ0tU+xbQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/intc/riscv_aplic: Fix APLIC in clrip and clripnum
 write emulation
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=apatel@ventanamicro.com; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Aug 8, 2024 at 1:51=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifive=
.com> wrote:
>
> In the section "4.7 Precise effects on interrupt-pending bits"
> of the RISC-V AIA specification defines that:
>
> If the source mode is Level1 or Level0 and the interrupt domain
> is configured in MSI delivery mode (domaincfg.DM =3D 1):
> The pending bit is cleared whenever the rectified input value is
> low, when the interrupt is forwarded by MSI, or by a relevant
> write to an in clrip register or to clripnum.
>
> Update the riscv_aplic_set_pending() to match the spec.

Same comments at the kernel patch.
https://lore.kernel.org/kvm/CAAhSdy3NmwbHY9Qef9LUeXfr0iE7wC-u0d_fHzC47PXk-M=
zmRg@mail.gmail.com/

Regards,
Anup

>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  hw/intc/riscv_aplic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index c1748c2d17d1..45d8b4089229 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -247,7 +247,7 @@ static void riscv_aplic_set_pending(RISCVAPLICState *=
aplic,
>
>      if ((sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_HIGH) ||
>          (sm =3D=3D APLIC_SOURCECFG_SM_LEVEL_LOW)) {
> -        if (!aplic->msimode || (aplic->msimode && !pending)) {
> +        if (!aplic->msimode) {
>              return;
>          }
>          if ((aplic->state[irq] & APLIC_ISTATE_INPUT) &&
> --
> 2.17.1
>
>

