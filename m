Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97CEC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whmsh-0005RP-RP; Thu, 09 Jul 2026 07:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whmsg-0005QW-6W
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:25:26 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whmse-0002Yr-7r
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:25:25 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-667bae10ba3so376936d50.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 04:25:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783596322; cv=none;
 d=google.com; s=arc-20260327;
 b=RoFxQ8qkt2c8rFxVePhfsPba7IkeSj/GqKictQRkCnoajVNJJQZaMjbGnKqec/3kw3
 FWSU6a+TrGkba5bvQfBdg+3JmUlBmUqOK55CEzrIOAwlaiLtboFqQNiwyPBICMxlKBlN
 Qq94WuXpwxpYa30aFY3oQc0kL9F+mnvGIvv/PUA+go1ZtzEeid9k5/MsomPoBmStvmom
 JEPCukcm3qnpghtHiEmeQlLimmf2JnOvE7tDVu9fw9pIRWJPZqUcHt7L/+XxHs9V/8/r
 woI3nAHnHCvff2v4BCmIj0OZIXj51ju3XPzKlQR9CAH9yAX4Ht+mj6jw33LlnOX77v1k
 YX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PUTt8gEXC3evuZEI4FrKnGNtcaVB1W0fSDTAWKQlAes=;
 fh=8tgGIjUAmI3rvyBiGHVyENPGCLFgbIUAXh2qgr0fPvI=;
 b=oM8s8PkSQC6Nn0wCqqitaLne+NVPM6n4nnMLRIODR+T7/7Kf4u7jAh+z+XNGWCx3HC
 PVTFWQ9EnfEMCyJGrMmP55baqzwTNO8NI2w32b0Bei72EXX2dv5bpYZLt0yGkKi2lkI1
 mbTRNkeft8E2Jv3QKNjXtK86/LG6EpcB4zYDiPi2OnUsO4hSKrRSFudJ0yUIQ+5dQWAJ
 ZFKdq48u0MNixge8xpFSYI3ARjrptH8aGAVWbxrxzOPobKJM18Tn/iNMvf2U5RWEjhwr
 CQXXT5PcMyV04XdExCPnCmobTv4FxG25dMCTh81B94MpThojRJcAsYaN7wPfHb/gdOCy
 eXjA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783596322; x=1784201122; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PUTt8gEXC3evuZEI4FrKnGNtcaVB1W0fSDTAWKQlAes=;
 b=Bj81L+dInbXNf3tZOjlsiFAetK6uqe0sCRBO/tA7FCxcmIc7PhuS0LtYeu+s8l/QXW
 euHyEQoWgSsSwSsjm5uacCDXdup3c20WJB43/LaNfJQHl5u63iRB1lThRSD7GMQDgFtG
 G5UvlI0crNOz47nsyO2k6FfsSjBYpUkHz2Q9/d1P5fMrvMzA6YrixCYca11sg74J5DaD
 CBWk+YRvqLPynfovWWQyFojuqD/W1mnTvdR6Lr8tPtIrAPMhpHbd7dWVrmCGkDQ/LTx5
 KPJEsznKDSzWXEhGwLRPeqlgWwA9yzc30AgqobHGpuqYLD6RgdILkGvSQwLE3wrfm1sO
 NyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783596322; x=1784201122;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PUTt8gEXC3evuZEI4FrKnGNtcaVB1W0fSDTAWKQlAes=;
 b=lvoBtkEQNYM+aAtugQO/y5emhNvKd9LMxXbUIQ6SmK7f6BDVx1H1HqlTc4dBjR7LB4
 IPMkiUSRImCDpyXH9acfhcGPQSiU0FDEcQIBkAaf1wNGXQWgVRu+jOYZzTgxSAF++C6T
 hDdh4Tv0+tq4RZhDH3dEyNpZMhPHtHbU+w1FieRMia5YrSciNV3gORy9Rcqy7VwmqzQt
 BA3Nt7O3MKB/ZgCQWAZXLGehOiKa4JLLg7iXqSETjfnMstl9qAimHlgRJc5a3H2g06wA
 YghxXltKyzd6qvsxpfkz7qERs+1W1WPvVMn7WwW03f1JVh21d5PYTJwLxRasz9p5Hemb
 aXgA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNc3HqW2TBE7BUNhJnz/ZN+ThaUkXHCv99SPX9igv1evBSYaiMVC0sHTYkQ4GjU3Ybjk18XwoKo5+y@nongnu.org
X-Gm-Message-State: AOJu0Yx9d4fBDhwZRIJ6yyGTESjZbvFVfX2z4TUamrp3NZ8NqTgCCJ7s
 h2Pu8k+1fGOdPdpWYlOO10y7wjrWs5R5Kp+7Rw+cilLbxSbpmyTOAKy2lsjnsS1fF7FegixkZ9M
 2KIa99ULMWOfpAnRng+7yy62eP7tmmSBCDiDwjyDeLw==
X-Gm-Gg: AfdE7cngqOXdijHUYcMkcP4PqKvfhFK6V0VVUcSJEwJZru/kJ7jmd6JqVDHNVIBVV1V
 NMvteSRrkKPeXGJjABBWaSvq1YoROxoo1bPc/GgQiQKE/87/PPOJyki7kZB/jbw7mqwdSLXAf1M
 P0xiVZkRVMJT0TcGEt60rnW4skliIOk9HyDpCZRh97ZAHaypXR6mB8rk1scUH8SkgAbiVewSfcl
 u2T7IA0Yxg8jroIEgClUgpeuE+kWm1CwNIxAu/HgJq0E8RHqLu+3AyxKfUThoSz6M7yR/jdFrI0
 GkmdvDLWvKgZHbTTqlPY6j34hYO6brRcDYHArmaCie3m3YoSh6c/QGph
X-Received: by 2002:a05:690e:12c1:b0:667:a2e7:dd48 with SMTP id
 956f58d0204a3-667a2e7fb80mr3684954d50.32.1783596322185; Thu, 09 Jul 2026
 04:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260706230056.1888992-1-titusr@google.com>
 <20260706230056.1888992-5-titusr@google.com>
In-Reply-To: <20260706230056.1888992-5-titusr@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2026 12:25:10 +0100
X-Gm-Features: AVVi8Cf_Be_bnmnQbnlaVkotuW5EKAB1PTCmMyaCs_lGE0gdg-J6NeJ2ZHzZtGw
Message-ID: <CAFEAcA9vT6r_C9q9NKVTso1WCmHpozxa8thqC_v4R-Pj_hxU+A@mail.gmail.com>
Subject: Re: [PATCH 4/5] hw/i2c: smbus: increase MAX_DATA_LEN
To: Titus Rwantare <titusr@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Tue, 7 Jul 2026 at 00:01, Titus Rwantare <titusr@google.com> wrote:
>
> From: titusr <titusr@google.com>
>
> The 32 byte payload was raised to 255 for block reads in the SMBus 3.0
> specification. SMBus does not provide a way for devices to declare which
> version of the spec they are designed to so we must allow newer devices
> to return as much data as they allow.
>
> Specification: https://smbus.org/specs/SMBus_3_3_20240512.pdf
>
> > 6.5.7 Block Write/Read
> The Block Write begins with a slave address and a write condition. After =
the command code the host issues a byte count which describes how many more=
 bytes will follow in the message. If a slave has 20 bytes to send, the byt=
e count field will have the value 20 (14h), followed by the 20 bytes of dat=
a. The byte count does not include the PEC byte. The byte count may be 0. A=
 Block Read or Block Write is allowed to transfer a maximum of 255 data byt=
es.
>
> Signed-off-by: Titus Rwantare <titusr@google.com>
> ---
>  hw/i2c/smbus_slave.c         | 4 ++--
>  include/hw/i2c/smbus_slave.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
> index cfb61c879e..407a118d24 100644
> --- a/hw/i2c/smbus_slave.c
> +++ b/hw/i2c/smbus_slave.c
> @@ -217,8 +217,8 @@ bool smbus_vmstate_needed(SMBusDevice *dev)
>
>  const VMStateDescription vmstate_smbus_device =3D {
>      .name =3D TYPE_SMBUS_DEVICE,
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_I2C_SLAVE(i2c, SMBusDevice),
>          VMSTATE_INT32(mode, SMBusDevice),
> diff --git a/include/hw/i2c/smbus_slave.h b/include/hw/i2c/smbus_slave.h
> index 86bfe0a79e..59522ff1b1 100644
> --- a/include/hw/i2c/smbus_slave.h
> +++ b/include/hw/i2c/smbus_slave.h
> @@ -64,7 +64,7 @@ struct SMBusDeviceClass {
>      uint8_t (*receive_byte)(SMBusDevice *dev);
>  };
>
> -#define SMBUS_DATA_MAX_LEN 34  /* command + len + 32 bytes of data.  */
> +#define SMBUS_DATA_MAX_LEN 257  /* command + len + 255 bytes of data.  *=
/

This is a migration compatibility break, and you can use this with
machines like q35 where we care about migration compat (e.g. via
the smbus-impi device creatable on the command line), so we need
to do this in a way that maintains migration compat from older
versions of QEMU, I'm afraid.

thanks
-- PMM

