Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D55CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 15:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoOVO-0007ZJ-GI; Tue, 19 Aug 2025 11:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoOVN-0007Vb-2D
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:44:09 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoOVK-0002sc-F4
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:44:08 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e94d86cae3aso1655393276.3
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 08:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755618245; x=1756223045; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rSwH9TFUa1ySF0QKmDlMGXX9kVKy+ZxCiks3DHJtt/U=;
 b=OWoyXG1ynLC3UL0Qnk/iwsaZkNktfokb6wnIRatvl++zWfNvBI488+7bBXyHffLYOK
 1aCtEQgVD4AOOUGnO/8FZS4O4AE2oQbTnrDpbc+piJ8UYzLeYqD1jAp2bJan6HUVGnLj
 +clgzlERO+ApRa1hEHyzWyl02JefayQ2dsiTn6S163YeVom/fTr8AxcDQLn8bt9uV2+A
 b4lIjHG7aPNN5FABrJASqRDyE/puTmZDoUje/WfA9zFWixTgBS8mBScm/PLSjv8SnZHJ
 66SW7dy4Os832vTTEjN2ttn6u+hm1KghV1S647s3AVV5vjYj9hOuYVfCfnV6UN212KOZ
 69Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755618245; x=1756223045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rSwH9TFUa1ySF0QKmDlMGXX9kVKy+ZxCiks3DHJtt/U=;
 b=QtGb8bsVUtBqot+/piYkQoImm59v/Bv1qqZn4hLIF8265xu8XPgEWqhNezqY19MTqw
 ZVx8q/t33HCYsEQet1AbZa6reDhx0vw4xvaYMOzJg+NjSc0wQZutw5iNzxHc9f9gH4uR
 GUIrzV3k5COcblW1gSAHf+ql0tPgMfxkUgITTKZQAGdw396UltkCJpxJEdzg7I55QGDt
 R+I+EOcKsYmQVsRqC0q7qtp/87F/22OObQ31CFGwcqViQ8IEe9lgjJ+0VAUh0gZ1pJMz
 Fh0W/8LuTEBFOnaz9PduzEedGhX94yYosb2yxvYJq1KIMzkhspxkbC7Yu4P5UnS0Z1eo
 +ghw==
X-Gm-Message-State: AOJu0YyZW4z9alLfYI1o7D33QlZSCkRp+J2KC1tLP+EMSya8L5cHDsn7
 aiyZSZ7s8z5NzgAAqNOhi1hIPrLx4d/y0016FuojhnilxnrRIIj+JetHgsGb7ktFXfpUd6UW4a3
 z5X2/iknAsg7aa27UnExLUpG27ZqHL9CN94eiRpzIEw==
X-Gm-Gg: ASbGnctKCh/ImShHwBWKQ1EBQFp1yFh9UmGcrEgGJob1Jh7ER1VNLeJh4qVJQANgfvh
 VfB1YCUC0dhtMmQUUt/P53Qp1gY75XvllcJ+zaZ0TbkO589zEzZPVv+CqdHokXo417qxTbNd8ht
 4QOWXuOfjXPMWdB5zJzNjua+OzrwFUkQwnR+oHLVvkooAJPyenr3J/AnZq89NJqAi29bVU6qKlM
 nHkw38t
X-Google-Smtp-Source: AGHT+IEOzFm3e8ljQCWbVbH/3dQsdJS0F1jOYtJGOdPJmMkwBopzbtASQ6cMRfa+oslsbdAX6bniGil03D4SfCPYcMI=
X-Received: by 2002:a05:6902:1888:b0:e93:3d8b:4e5f with SMTP id
 3f1490d57ef6-e94e5f4a590mr3647487276.0.1755618245039; Tue, 19 Aug 2025
 08:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
 <20250815090113.141641-10-corvin.koehne@gmail.com>
In-Reply-To: <20250815090113.141641-10-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Aug 2025 16:43:52 +0100
X-Gm-Features: Ac12FXwKja-SnBY13NJ1bTLfweL6EDRt_uOQjtmsrDjBh7KP9_vPM7fp4eNmpNk
Message-ID: <CAFEAcA-mTTLEtE72W=-R9O=m7zSUiL5bGf7TMXoFP=Xqvmq2OA@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] hw/misc: Add dummy ZYNQ DDR controller
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 15 Aug 2025 at 10:01, Corvin K=C3=B6hne <corvin.koehne@gmail.com> w=
rote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> A dummy DDR controller for ZYNQ has been added. While all registers are p=
resent,
> not all are functional. Read and write access is validated, and the user =
mode
> can be set. This provides a basic DDR controller initialization, preventi=
ng
> system hangs due to endless polling or similar issues.
>
> Signed-off-by: Yannick Vo=C3=9Fen <y.vossen@beckhoff.com>
> ---
>  hw/misc/Kconfig                  |   3 +
>  hw/misc/meson.build              |   1 +
>  hw/misc/xlnx-zynq-ddrc.c         | 393 +++++++++++++++++++++++++++++++
>  include/hw/misc/xlnx-zynq-ddrc.h | 140 +++++++++++
>  4 files changed, 537 insertions(+)
>  create mode 100644 hw/misc/xlnx-zynq-ddrc.c
>  create mode 100644 include/hw/misc/xlnx-zynq-ddrc.h
>
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 8f9ce2f68c..99548e146f 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -220,4 +220,7 @@ config IOSB
>  config XLNX_VERSAL_TRNG
>      bool
>
> +config XLNX_ZYNQ_DDRC
> +    bool
> +
>  source macio/Kconfig
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 55f493521b..6ee7b6c71d 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -89,6 +89,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
>  ))
>  system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
>  system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
> +system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('xlnx-zynq-ddrc.c'))
>  system_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqm=
p-crf.c'))
>  system_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqm=
p-apu-ctrl.c'))
>  system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files(
> diff --git a/hw/misc/xlnx-zynq-ddrc.c b/hw/misc/xlnx-zynq-ddrc.c
> new file mode 100644
> index 0000000000..8151a0e3ee
> --- /dev/null
> +++ b/hw/misc/xlnx-zynq-ddrc.c

All new files must start with a comment which at least
(a) says what the file is for and (b) has the SPDX
license indicator. You can optionally also add an authorship
or copyright line here if you/your employer need that.

Same applies to the .h file.

> +static void zynq_ddrctrl_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    device_class_set_legacy_reset(dc, zynq_ddrctrl_reset);
> +}

This looks like it's missing registration of a vmstate
struct for state save/load.

thanks
-- PMM

