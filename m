Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6455CC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 05:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwvRS-0001XD-Ei; Thu, 20 Aug 2026 01:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <77239050qq@gmail.com>)
 id 1wwt5q-00020p-UP
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:05:26 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <77239050qq@gmail.com>)
 id 1wwt5p-0004vq-Cw
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:05:26 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cbedda4c154so808184a12.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787195123; x=1787799923; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:subject:mime-version:content-type:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ghxySRuNEwME97ZhSqGP3DACdmgq8OdxuvKRYGOW7qs=;
 b=fjJfO6i2Ir+hCgu+CAEsiaFFHXsbHToPLQCJv0twrXSMI3wHb9VmPMKdKVoHH3pVSh
 grxWKmoHA5Kf/pW0NBO3TcAx/melnzzdX0CYC4UGTiOtnm9AY98fZbegHHp8GLWfwYVC
 FXZYonor4lkyyN4CLlF/1XpOFmzPL/nbhGdD3qzKiX9+VSVNMn7vxpt8OYWbElzlan7c
 A9LKgxTFIbZX4Qc8DM1T/Tm/hwFEdavNvJqrdkbeqQB+mNIqDalSqwOJba4+DtZPYUw9
 PgN/OfDap5kxVi3y6GIr+t3aguF/YugVJdi1hT9v0JSCteDJPhqKwFfsla72RZa6ALci
 IKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787195123; x=1787799923;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:subject:mime-version:content-type:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ghxySRuNEwME97ZhSqGP3DACdmgq8OdxuvKRYGOW7qs=;
 b=lesTbPuo0pRLildeP8XX59ZxUv+1mk02U5e/yBOZElJb2N2TWFdJTvArDCsZnuvcJ0
 tDe8PbclRoEiA+XWrmIBAgR+24UbnZPxFoWsfDRBWKkEoHgpX1xygZDwW+UNn1NsPiiI
 5AAZ9Ww8kO8YrdVCB5qBzAlBcSbXTRwd2ob2hoW09QvDaYEyPILIoMWpQmpatxCknw2Y
 DDka6MTt/Cc3pj9kypFsoGbXptJ1b58vc/x1qSfJsSeIRbVsXkVkvBq1ZsxwsD8nyxU1
 9qLtXAWdJSahej3lmq8Tmj0nou2ZfhrYFZFXeCg8i/hhk0gCmpuPfNHC8dlJy6inBYNT
 hIZw==
X-Gm-Message-State: AFuF++nhdciKjmPHQSC7mPqnG7ag8W1XWuZjsO//l6Srt5PBRZkarilP
 nRgWJ4Ox3k1TqeikYLEluDgVXD/s6iLV5GvktBUHvSeVo+Q66kATkiPK
X-Gm-Gg: AR+sD1161CCCGZVC9rDXmh8d93gdqq8YNSEw61oKFDYmwUTZqAFDomO4NuAjV2JagXX
 e1LYjkrPl5mFVPKGbWHNantq0u+6zPO/MAjTUfy1FnDwTdXCbr4jtmXcVG0SOOQeWBRcSU+Z6os
 ozZNZwcsmEXu/7dOFieb1IVWdtL4AydchQM1dI2t0mBEz4l+wQAv9TrpXYBrrmH60m6AIQKVaL1
 ujgqHGp0pYyKrsXFhT64PnlIrTVgkJf5pciA/oVLYobtJ94ky0wHTrN2a2JbOISuqv1G9TY5BMt
 aiuByojkAClqcHqIIC5swqSo8YpZ9v40/aqbisdMXdEGnZ3xEKm8uqgRSOV4CIuANbGZNdJLN03
 OY0BqJnpDbic5Rua9ZRvJezGEvwVe4NEyZMWERAAn/G2/3pifJun7TQQ80tQfnnJ4ZO1KZDZT4G
 rw2qxhFUGDLVpZ6IVEr2kSPoaTAGgAmBJ/uZiTEum6ohCjSiXCSofp50vxiwh107BtceUN
X-Received: by 2002:a17:90b:4fd0:b0:38e:5b59:c2ff with SMTP id
 98e67ed59e1d1-39580a4d031mr17666946a91.3.1787195123371; 
 Wed, 19 Aug 2026 20:05:23 -0700 (PDT)
Received: from smtpclient.apple ([117.55.237.216])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ae89189sm11636156c88.14.2026.08.19.20.05.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Aug 2026 20:05:22 -0700 (PDT)
From: Jack Wang <77239050qq@gmail.com>
X-Google-Original-From: Jack Wang <163wangjack@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH 1/3] hw/gpio: Allwinner A10 GPIO emulation
In-Reply-To: <20260819-allwinner-gpio-v1-1-2a64866dff11@gmail.com>
Date: Thu, 20 Aug 2026 11:05:07 +0800
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, pierrick.bouvier@oss.qualcomm.com, farosas@suse.de,
 lvivier@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F3E16C1D-C4C9-46AC-9762-FB0081B6A27A@gmail.com>
References: <20260819-allwinner-gpio-v1-1-2a64866dff11@gmail.com>
To: strahinja.p.jankovic@gmail.com
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=77239050qq@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 20 Aug 2026 01:35:53 -0400
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

Hi,jankovic,I read datasheet of Allwinner and confirm basic address and =
most function do well. But there are still some place needing =
improvement.

> +static inline bool gpio_is_output(AWPortMap *port, uint32_t pin)
> +{
> +    uint32_t cfg_n =3D pin / CFG_PINS_PER_REG;
> +    uint32_t pin_shift =3D (pin % CFG_PINS_PER_REG) * CFG_PIN_STRIDE;
> +    return (extract32(port->cfg[cfg_n], pin_shift, CFG_PIN_STRIDE - =
1) =3D=3D
> +        CFG_OUTPUT_MASK);
> +}
> +
> +static inline bool gpio_is_input(AWPortMap *port, uint32_t pin)
> +{
> +    uint32_t cfg_n =3D pin / CFG_PINS_PER_REG;
> +    uint32_t pin_shift =3D (pin % CFG_PINS_PER_REG) * CFG_PIN_STRIDE;
> +    return (extract32(port->cfg[cfg_n], pin_shift, CFG_PIN_STRIDE - =
1) =3D=3D
> +        CFG_INPUT_MASK);
> +}
> +
> +static inline int int_ctl_cfg(AWGPIOState *s, int irq_line)
> +{
> +    unsigned int_cfg_n =3D s->regs[REG_INDEX(GPIO_INT_CFG0) + =
irq_line / 8];
> +    return extract32(int_cfg_n,
> +                     (irq_line % INT_CFG_IRQ_PER_REG) * =
INT_CFG_IRQ_STRIDE,
> +                     INT_CFG_IRQ_STRIDE - 1);
> +}
> +
there you use 'INT_CFG_IRQ_STRIDE - 1=E2=80=99 as stride for both two =
function=E3=80=82For int_ctl_cfg the stride is supposed to be 4 =
https://linux-sunxi.org/images/1/1e/Allwinner_A10_User_manual_V1.5.pdf =
in page 333 you can find it, now all qtest pass because double edge do =
not be designed in qtest=EF=BC=88better add this test=EF=BC=89. But for =
input and output function it is right due to byte 3 is reserved.

Jack Wang

