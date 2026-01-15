Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A50D41174
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 11:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgLiW-0000gZ-Af; Thu, 15 Jan 2026 06:40:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgLiV-0000g1-DF
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:40:43 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgLiS-0006XP-96
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 06:40:42 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6481bd1763bso681167d50.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 03:40:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768477239; cv=none;
 d=google.com; s=arc-20240605;
 b=NPIoBm+67POC2VGyaV/TuIPYFm3ME0FA+/imic9TOjVbiCza6JKpDIrxCimqq/JSpo
 HUOEuh84YHtxSsciB1apFg0J+CeQrciqRn5i4vVWKgV1qZSbxlHFlTedomXFDIwvd/mf
 WImzfV7jDULQ+x607G3HSF5CWrYXGS8rAOGB8Gkx6R/u5STpP06Fz32vuKPhs1bjtUkl
 3OqI3rme8MZLEq3gBoZusoupLmwAFfUtxZvzBjp0aQORBqolN0K4XeA34oKAjYXY7rFl
 ZifWMzWuNSEmi+U6HbqNx/SIL7kjL37GGsLf4u0IXOa4158bKuIcBuEqxlRqnO6mbeE2
 OmKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fFFx7OzskZAfL50UvXSLyWt2Znq4Ui3kmVewWPOvWWk=;
 fh=/qGZ1hzH5xmJGWmsPnrLrZicMR615sp3k8X3IIPfDCg=;
 b=JA0QoMAQ5491vwzSj8gGJDrFdn1yn5HaFZggzK7Ya6B82Hs3+WBiX+shoi0AL6O60D
 cXqRRcnI33ScB81xvz8q22u5kX4trKMjc6FChFqy5mzcMj1iGYIiZ0BlYn2ZeYOpazMY
 mSvTU1f9gwmqJFdoJaYKHczihvSgS6Zp3N99jKsS+J62xO+UHySLS+00t5fV/bjSbIXW
 0F3sxQ1QqskN7A8jIb0fxsPU76uc+TlpP5kBFKSuKpHKod98zLOw7Xf8TMQLDXXOMi2k
 PnU7Q1/H28d7dqa9YOjg09Vfy0MUjTfAJ5cn2CwsbL6L7ujHAHZxPtY/AwymvqLWPN7F
 cScA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768477239; x=1769082039; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fFFx7OzskZAfL50UvXSLyWt2Znq4Ui3kmVewWPOvWWk=;
 b=Mmw9IcAZcgKoBh2Hw98mri7ea4Uo/nx00fSKdAEoJ5dnKJBKxOLkQrn3Wv1DDY4fwS
 lbTPKG+7M+n88eWW+EeDKRGSimHdprbgFiHFJhfbywkyiH7fWZe4Ar2vfXNJALxNmmDq
 5UwCw30VlC1osvbpWywOsAX80yqhpsK43KRp8TvZkjuCpl6RPofW3rpDeYfdyAJ9irOw
 85IzkP4A9h3xtTqL3upCBLup32fhoupD8czey9xRJpruD2pwMY6fcZFBgbXytq1VZ3my
 LadEYF1wnu0pxZKcABSEmlRkk4RFo3c0a3KdAeFW8ouArH9emJMMkzU/RvBUlh02CB2g
 jHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768477239; x=1769082039;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fFFx7OzskZAfL50UvXSLyWt2Znq4Ui3kmVewWPOvWWk=;
 b=mq/FCyESd9jZ29vCywrH312uXW2ObpGSQZNAnmLUaEokqKw6tJimpSfbyi5r6CLkF9
 Hhp9OBJKUFvHJFc7CFPfEBo3VYnQW2gAHT5VGEaUGY47O6cTfvbEP8eGDPdkPRh+JZvP
 h8fCMqBRkZta9CyNRzc7JOcxX+aOc6CA9+X9TBWJsvnpzHiw4zjWcfDFWtaJHT8EwSCd
 U08hA3TwDnsxZqvbigB81YDyezsAu3S5OLrV5RMxAxZy2k/t8qBqdS3x1tKyJc8gltq6
 J5GNK4sMSc+I8mem+F5H/XKQK6RDeROZdVmWk2tvRDY/EsaasEFG79bxX/7/Zzbmjd9o
 8r8g==
X-Gm-Message-State: AOJu0YydcRXslmeaZAcv0+GkyhWcN5nYSC9WJJgq3PQyPaQvWx0HK4pr
 q0VF76F9YKU3me1WsAXqwSybSh5veKl9UdhM7zHMP37LZx9Vn6kU/P8bjU8ojmjk1yj2sn3qskp
 gTTfkbZPCGt4GfpwNANSEKpmXgcg5qdKLyK0ESaUgYA==
X-Gm-Gg: AY/fxX7J4vHCs0nK6ZaK8Sm0Do8KtgVlcTGuYjqTBr1Pz7KoACxd+LSxglmTC3I7GM4
 jHEbARwfG/jemzshHKp0zRaci7PtLzrUXTtsOA2Ox2EEfBDR/RUReSFeB8S/iRP7/Ct/yNEuC9b
 Bg35a2V/s0PmHOHlVZglFBZ2FoyFU/hchAoXsSPmpV2EKPAiaoTby33le5yOWCWSn6LHenjsdxz
 QdbLv3WBeYi0l3+L6D2Dx2SPFa9FNVYnIW4Bbf7/ZG6D+4scsLWIEW85BQbFm/UK3lCo2b8tpZQ
 1NO5EG16gGJWlpEcDDVxL08=
X-Received: by 2002:a05:690e:150f:b0:640:cc09:b7c8 with SMTP id
 956f58d0204a3-64901aba07dmr4671181d50.23.1768477239127; Thu, 15 Jan 2026
 03:40:39 -0800 (PST)
MIME-Version: 1.0
References: <20251204093502.50582-1-corvin.koehne@gmail.com>
 <20251204093502.50582-9-corvin.koehne@gmail.com>
In-Reply-To: <20251204093502.50582-9-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Jan 2026 11:40:27 +0000
X-Gm-Features: AZwV_QgKu58r0LIKquRSRuVzdnh7PRKVH1bqCbwMKbGE_GSVVGK8QxK32e_jsCA
Message-ID: <CAFEAcA_qY3pPREJ5bW7dLN17bTC2b_6ydLD3PLOkpPUFViOXbA@mail.gmail.com>
Subject: Re: [PATCH v5 08/15] hw/misc: Add dummy ZYNQ DDR controller
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, 
 =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Thu, 4 Dec 2025 at 09:35, Corvin K=C3=B6hne <corvin.koehne@gmail.com> wr=
ote:
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
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>

I have a few minor review comments below, but this otherwise
looks good to me.

> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index fccd735c24..3de37c9e1d 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -240,4 +240,7 @@ config IOSB
>  config XLNX_VERSAL_TRNG
>      bool
>
> +config XLNX_ZYNQ_DDRC
> +    bool
> +
>  source macio/Kconfig

You also need to have the "config ZYNQ" section in hw/arm/Kconfig
have a line "select XLNX_ZYNQ_DDRC", to tell kconfig that the
Zynq SoC needs this device.

> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index b1d8d8e5d2..ffbcca9796 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -95,6 +95,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
>  ))
>  system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
>  system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
> +system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('xlnx-zynq-ddrc.c'))

This should be "when: 'CONFIG_XLNX_ZYNQ_DDRC'", so we build the
source file exactly when some board or SoC says it needs the device.
(This mistake is what is hiding the effects of missing the
"select XLNX_ZYNQ_DDRC".)

>  system_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqm=
p-crf.c'))
>  system_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqm=
p-apu-ctrl.c'))
>  system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files(

> +static const MemoryRegionOps ddrctrl_ops =3D {
> +    .read =3D register_read_memory,
> +    .write =3D register_write_memory,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +};

It's better to explicitly set the access size controls
 .valid.min_access_size
 .valid.max_access_size
 .impl.min_access_size
 .impl.max_access_size

explicitly, even if they happen to match the defaults. This tells
the reader you've thought about what the device actually permits
and what your implementation code can deal with.
(The default is "accept anything, never generate external abort"
and "assume the read and write functions handle all widths".
This is usually not what actual devices do or what the code
people write is intended to accept. Devices on Arm systems are
often "only 32-bit accesses are permitted".)


> +#define TYPE_DDRCTRL "zynq.ddr-ctlr"
> +#define DDRCTRL(obj) \
> +    OBJECT_CHECK(DDRCTRLState, (obj), TYPE_DDRCTRL)

Current QEMU style prefers using one of the helper
macros to generate the cast macros etc. For this kind of
"simple leaf class" OBJECT_DECLARE_SIMPLE_TYPE is probably
what you want. See for some more info:
https://www.qemu.org/docs/master/devel/qom.html#standard-type-declaration-a=
nd-definition-macros

There is also OBJECT_DEFINE_SIMPLE_TYPE which provides
the boilerplate TypeInfo and type registration in the .c
file for you, but that one is more "optional if you
prefer it".

thanks
-- PMM

