Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0FACD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 03:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZKis-00005r-Ef; Mon, 15 Jun 2026 23:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZKiq-00005W-OV
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:44:20 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZKip-0000jN-5I
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:44:20 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-68d232ed3f9so6291206a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781581457; cv=none;
 d=google.com; s=arc-20240605;
 b=Erxq9rW3EwyTRV7JGwwA/hmSPONLJIKgCQoC01mwzQo/DB8h1ASWTjlFahOQ3b+RqX
 nwn9RhNSAS1AHgHyMT3ctNaK+9/6xHqw51pdQ1j/fgk2rSvXewGAFRYGH84WLKlbd2DL
 UYXiPegDksSB4mjtvyN2DL7n2bnhUaOGFi0D3V2QlLjQXhwedXDVn5RSXNapazCgGG7x
 coj3IkjRSSAyXmvrazjase51epktgWkNmp8HBlpudi5GcDx6UtKbDXTaVq4TrSgxO6Me
 jzIbFHJVp9lFxXDHJY6hdRehC8pIcREcDxf4DPRZrsTgwgehWVdpM6HYSAuJd1NCOsBy
 qF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hJDm1EoT0f1HlKtP6PspAMHEHdYnq5dfOmfvoJsPUYc=;
 fh=ss/HGO4RwpwHFtzwgPsbC23QsemYg8f9BjqPHLpkgZI=;
 b=YLC8N1zlhqiuvstK7aLR97TScwntRr8vbA9XcD4qHj0vQw/ERXFsnLsWalIIpM7hSy
 FS3RFuJOxgnl0R70zkBtr6EhLG7MXTBGYS1J/KYb7/mljJPHced/nhWpLKlEwHUKlwxR
 QJntFW99p+GsELwxtGEZSFiwSdW4GgrmQvUZ+5L1tGe3nd0H7kRP9hbU8NF53hSE8NNK
 9t2ObBvHqgWWwiEFyH1ApUkksGFGM6JXEwPbR3PC5uU4mOT2JsYIHjcyNZmhaI2mmY2p
 /fzYtajTL8DWny4BAJygAIUqThi24t7K5N8xbJQLFaB5m1M5Z+DnCB68kPhA3gBLGTiA
 KSQA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781581457; x=1782186257; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJDm1EoT0f1HlKtP6PspAMHEHdYnq5dfOmfvoJsPUYc=;
 b=askRqcfwnE13lfnPi2HAipofBhqD/hWj8sB82GW5Gg308W+TmOynYO7hBN+lwxtb0U
 zejZjyaaes2c4MrRUoi0mdVeXCTvJtD9bdG83YAyzpr6zbM7hHDIN3hTDktU8G34G93e
 MG4zelQRmOewdbGom+yAdIsQSEN+COyGwgMBo8LOFTDYALP4B5c2hJQtnlkWmzq9yBMq
 t3DnhAOBcHIIdOhKS5s4udq3xWcJnN6/mxzBpQq/v40sI50m7SAgqZ3iXxCtZb8Z+C+6
 RVenBS5i+9DqKAH3Kev/vMUib8lMOBksSR+VO27Mnj6K6JrWpPKg8Kw4xLNZWRMGKS/l
 ffTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781581457; x=1782186257;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hJDm1EoT0f1HlKtP6PspAMHEHdYnq5dfOmfvoJsPUYc=;
 b=G3EzZwVgmnYcWqwOrY6ggpajDtHVO33cFQ0LYQo47zSshfLn8KrbpasMRZIzsXtsfP
 BnJc/eh4HLKltcQ81doW3i/Va5GS37GeatAfk51bt/fCmcuH0cagTJtGEO2pvv9k0Wmb
 Ej+Y5ym4/0ETdR2X2FcEAT7b7VHiB2H/l9SwJjbvEEtX2WP9HIMCR8fph6gvtkOtLE9X
 njYkDPl5s6/0XpRH5tMHl2cR8MPwrpSIGaKiinas/WO/zWSavSVg5+ibq+j+pwMV3Qp6
 Jbu/Gf/3nu5l78Np0f/Tep4D9OH1uaL/Ehce1AR+YMo1e6mBgBBkTf1ifY7JNDANjv54
 iKtA==
X-Gm-Message-State: AOJu0YzI+BOiUuIQMo9fLTq10RMQ2PuzTaddso/IXCcOvSAgun4Rtd0Y
 1EgKv06i/x6S3kfXSPyFjeq7Z9a/iAlv3Cfe8vnkJCOGLDufFzL0x6MIEHgJCsk0vbGanBTi4Lt
 j9iJUgUqtPDuN1LC5+kTpPeJRJ/eCMd0=
X-Gm-Gg: Acq92OGVg+gzxJg2Wp11B7hda+S0nRvRkitGfPxeBHThqLlqNnJqV9/CIqwkGC8uoXv
 Bl/+/KzokIwq1kxuvC8A+7eUcfuM8NCNtwGHdj96fUMggo+OrcVPxiWvb5R3vbFcKmsyaLr/+TH
 zOwt3ArWESem/PXOihppUawfUO1R4Ms03CrPZax259ZLPqDvVwQ5sclxY/xAu3kFx3ZiXBqUG2J
 mtg2lWfejr60IP3WOGYO6hn9RRdlUPDjBMq1SFhxtCkYoJH+27CVEhSS33LjHQaJYdrvz6AFZxP
 cunNaA2E9wdpa7AjyFJU9LOPe6ErgQF82bpBGw==
X-Received: by 2002:a05:6402:2350:b0:691:b158:b40c with SMTP id
 4fb4d7f45d1cf-6950877be80mr935871a12.7.1781581457438; Mon, 15 Jun 2026
 20:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260611123412.2135600-1-daniel.barboza@oss.qualcomm.com>
 <20260611123412.2135600-2-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260611123412.2135600-2-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2026 13:43:51 +1000
X-Gm-Features: AVVi8CeUMVwxFseqyxQK8Po8xmrXAraJKUG5D4BoOhVixR3EJCH91g6KR8wW0wc
Message-ID: <CAKmqyKPHYPqwPPt3T6M9CstuMMFWXmvD8Etjkfdnw8Af_RhQHg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] target/riscv/cpu: add CPU unrealize callback
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 philmd@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52b.google.com
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

On Thu, Jun 11, 2026 at 10:34=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Next patch is going to dynamically allocate debug trigger arrays during
> realize() time.  We need a way of freeing them during unrealize(), which
> doesn't exist at this moment.
>
> There's a lot going on in that patch already so we're adding the
> callback infrastructure beforehand.
>
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 9 +++++++++
>  target/riscv/cpu.h | 2 ++
>  2 files changed, 11 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index c1b10cc7ef..5b2133d811 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1012,6 +1012,13 @@ static void riscv_cpu_realize(DeviceState *dev, Er=
ror **errp)
>      mcc->parent_realize(dev, errp);
>  }
>
> +static void riscv_cpu_unrealize(DeviceState *dev)
> +{
> +    RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(dev);
> +
> +    mcc->parent_unrealize(dev);
> +}
> +
>  bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu)
>  {
>      if (tcg_enabled()) {
> @@ -2667,6 +2674,8 @@ static void riscv_cpu_common_class_init(ObjectClass=
 *c, const void *data)
>
>      device_class_set_parent_realize(dc, riscv_cpu_realize,
>                                      &mcc->parent_realize);
> +    device_class_set_parent_unrealize(dc, riscv_cpu_unrealize,
> +                                      &mcc->parent_unrealize);
>
>      resettable_class_set_parent_phases(rc, NULL, riscv_cpu_reset_hold, N=
ULL,
>                                         &mcc->parent_phases);
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c98652cd62..11cd710990 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -575,6 +575,7 @@ typedef struct RISCVCPUDef {
>  /**
>   * RISCVCPUClass:
>   * @parent_realize: The parent class' realize handler.
> + * @parent_unrealize: The parent class' unrealize handler.
>   * @parent_phases: The parent class' reset phase handlers.
>   *
>   * A RISCV CPU model.
> @@ -583,6 +584,7 @@ struct RISCVCPUClass {
>      CPUClass parent_class;
>
>      DeviceRealize parent_realize;
> +    DeviceUnrealize parent_unrealize;
>      ResettablePhases parent_phases;
>      RISCVCPUDef *def;
>  };
> --
> 2.43.0
>
>

