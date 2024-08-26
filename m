Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C82C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 00:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siNHB-0007Bq-6S; Sun, 25 Aug 2024 20:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNHA-00074U-3g; Sun, 25 Aug 2024 20:08:04 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNH8-00017m-BO; Sun, 25 Aug 2024 20:08:03 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f4f2868710so32979191fa.1; 
 Sun, 25 Aug 2024 17:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724630880; x=1725235680; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MrP6tyhATJxJI+dLSoke9PWxcj6mI1Q0z44eLJUubI8=;
 b=a50zHioS2aFB6Ynda9K+WlZQVX+9V+9/qEbT1uI+LuZb0uoTNmUVU8fe9RikXTc169
 aRY0N7grldmMIDxhGSP9rAKp1d1wA3tQIyplqPtW8/WJLPPF++1FPObwPpTLNYZ+vRh0
 GXm8tv1mHhzUWAe/EMJaGDQOdu+Mz0/YUnDka2hqxI2rbZiruaQPg+8rcZiT1/L3rcmA
 Xx/MV1f5yH+GzSIxcRVxQk/YJLKIwPKmwnP2ZZ5OZbO1/xwhHVQbUl4JsIBy0KfTe0j7
 dM3IrJBuiGPwU6mBvQ+cV2mmMeL2ZvwKApKxIGme47Hmp2JG7oCCapNYRBxXIF1i8Xe1
 k06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724630880; x=1725235680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MrP6tyhATJxJI+dLSoke9PWxcj6mI1Q0z44eLJUubI8=;
 b=G1o/EsY4fBPkIVyurQTG6DQn4A3wbw8mBaY0GZoclsLOr4OEkYJTSZSwoyvEwPCKBD
 9Dx0yjSTrppNsP3oX8vbeSdEvfBW08LyzACGRBcxH8dI9N77ncJ5LmVygfe8beQ7Ugl1
 o9yp2MW2FpdhyGar4IGu2FUxTF78KAxaRQKTVtW5oXiE6HF3AUJ1RFre3P/hV5k5nXQR
 YPH8iUqzhdvwHOJqQST8+bgq+mciD/Zo4GUpyJI8iBcSW44gpv5eKaxHCivtBtVmx+6X
 WjljYbAVZGs+FK4hU3WLcjg9Uoc3WrgWiED7dJHgM+hz75P8ZirUO8sJkvGJVtYXJuKx
 grdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC2j366ARE9VTIZ2x530FutiynpBPKsaYVucyWdhQculZ7E/WJ7FqpSCRCeWqBvoRanOj9TD9wRCBl@nongnu.org
X-Gm-Message-State: AOJu0YweucEud9c5wSrRm5Rghd8XLMIIdTP90sSC2dLNXJrLXdhL0+gU
 xiHtzfrGT1pSmjh1pE0OAf8U97+rI1q98Wo6dvhMGJ3BWZRFN4BOBa+lwAcPDCHm9gGjPupGrPE
 TTY66edbgbo/aUT7KfyBaPC5ltsw=
X-Google-Smtp-Source: AGHT+IEsFfWHQ7pXKmmiyd+STMIAdAxYBLtKKrdJO25xbluXRSaCcrxt0BDDco8xncOvcTTljnaRY50RJuS0XnR7GMA=
X-Received: by 2002:a2e:99da:0:b0:2ef:2d4d:af76 with SMTP id
 38308e7fff4ca-2f4f4949eebmr56028971fa.43.1724630879485; Sun, 25 Aug 2024
 17:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240822162127.705879-1-peter.maydell@linaro.org>
 <20240822162127.705879-7-peter.maydell@linaro.org>
In-Reply-To: <20240822162127.705879-7-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Aug 2024 10:07:32 +1000
Message-ID: <CAKmqyKPDsU=g5NZeW_So28=NAjkvagwy5a3M5BKO6nR=RHPhNg@mail.gmail.com>
Subject: Re: [PATCH for-9.2 6/6] hm/nvram/xlnx-versal-efuse-ctrl: Call
 register_finalize_block
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Francisco Iglesias <francisco.iglesias@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=alistair23@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Aug 23, 2024 at 2:22=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> The TYPE_XLNX_VERSAL_EFUSE_CTRL device creates a register block with
> register_init_block32() in its instance_init method; we must
> therefore destroy it in our instance_finalize method to avoid a leak
> in the QOM introspection "init-inspect-finalize" lifecycle:
>
> Direct leak of 304 byte(s) in 1 object(s) allocated from:
>     #0 0x55f222b5b9d8 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-=
from-laptop/qemu/build/asan/qemu-system-aarch64+0x294e9d8) (BuildId: 420
> 43d49e1139e3f3071b1f22fac1e3e7249c9a6)
>     #1 0x7fbb10669c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:=
161:13
>     #2 0x55f222f90c5d in register_init_block hw/core/register.c:248:34
>     #3 0x55f222f916be in register_init_block32 hw/core/register.c:299:12
>     #4 0x55f223bbdd15 in efuse_ctrl_init hw/nvram/xlnx-versal-efuse-ctrl.=
c:718:9
>     #5 0x55f225b23391 in object_init_with_type qom/object.c:420:9
>     #6 0x55f225b0a66b in object_initialize_with_type qom/object.c:562:5
>     #7 0x55f225b0bf0d in object_new_with_type qom/object.c:782:5
>     #8 0x55f225b0bfe1 in object_new qom/object.c:797:12
>     #9 0x55f226309e0d in qmp_device_list_properties qom/qom-qmp-cmds.c:14=
4:11
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/nvram/xlnx-versal-efuse.h | 1 +
>  hw/nvram/xlnx-versal-efuse-ctrl.c    | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/nvram/xlnx-versal-efuse.h b/include/hw/nvram/xlnx=
-versal-efuse.h
> index 86e2261b9a3..afa4f4f9960 100644
> --- a/include/hw/nvram/xlnx-versal-efuse.h
> +++ b/include/hw/nvram/xlnx-versal-efuse.h
> @@ -44,6 +44,7 @@ struct XlnxVersalEFuseCtrl {
>      void *extra_pg0_lock_spec;      /* Opaque property */
>      uint32_t extra_pg0_lock_n16;
>
> +    RegisterInfoArray *reg_array;
>      uint32_t regs[XLNX_VERSAL_EFUSE_CTRL_R_MAX];
>      RegisterInfo regs_info[XLNX_VERSAL_EFUSE_CTRL_R_MAX];
>  };
> diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efu=
se-ctrl.c
> index def6fe3302b..8252a5cabe0 100644
> --- a/hw/nvram/xlnx-versal-efuse-ctrl.c
> +++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
> @@ -712,9 +712,8 @@ static void efuse_ctrl_init(Object *obj)
>  {
>      XlnxVersalEFuseCtrl *s =3D XLNX_VERSAL_EFUSE_CTRL(obj);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> -    RegisterInfoArray *reg_array;
>
> -    reg_array =3D
> +    s->reg_array =3D
>          register_init_block32(DEVICE(obj), efuse_ctrl_regs_info,
>                                ARRAY_SIZE(efuse_ctrl_regs_info),
>                                s->regs_info, s->regs,
> @@ -722,7 +721,7 @@ static void efuse_ctrl_init(Object *obj)
>                                XLNX_VERSAL_EFUSE_CTRL_ERR_DEBUG,
>                                R_MAX * 4);
>
> -    sysbus_init_mmio(sbd, &reg_array->mem);
> +    sysbus_init_mmio(sbd, &s->reg_array->mem);
>      sysbus_init_irq(sbd, &s->irq_efuse_imr);
>  }
>
> @@ -730,6 +729,7 @@ static void efuse_ctrl_finalize(Object *obj)
>  {
>      XlnxVersalEFuseCtrl *s =3D XLNX_VERSAL_EFUSE_CTRL(obj);
>
> +    register_finalize_block(s->reg_array);
>      g_free(s->extra_pg0_lock_spec);
>  }
>
> --
> 2.34.1
>
>

