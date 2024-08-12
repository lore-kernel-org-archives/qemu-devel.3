Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F8CC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 17:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdZHP-0003qm-Qv; Mon, 12 Aug 2024 13:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1sdZHN-0003l2-Qg
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 13:56:25 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1sdZHL-0000nm-T4
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 13:56:25 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3687f8fcab5so2409112f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 10:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723485381; x=1724090181; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ucpR89SN6ep8advprvDEEg8bvmnOO1GXRGaE0X67Mo=;
 b=nfj7ktvX2r1nhi9U2qpPvJNy680cuaPKhUTZdUyAOFk5SDZt1rY2rUYLMoN5b6atC9
 6B268v9SHrUyMH7TTv34qcVHfZx+eLk4RvrgZ9f3mLyXQ/qgxsmLVswiqZ9gT1BLsdpA
 2pMS6Lgbp4eetGSwaq2S3F8jKND/i1Uw2hZkOlOZTV4LFBJ15Bi5FywaDmFMkbHT8qrH
 sQ7cr56OIG9Aby05aEiyq+luIPM6FQeyI/3qC0Vj0GOKSOasNGoGuthjRVuG1NCRfZ4Z
 mmFUTK8roUqs44fR+babdPWBxpYshgbTAFFNEWGnfiX4UT+7FYBr597Q94geUuTBYC7k
 bSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723485381; x=1724090181;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ucpR89SN6ep8advprvDEEg8bvmnOO1GXRGaE0X67Mo=;
 b=FQH59j7eW8kp336egc5v+4potBMKBi9B5Qc2/7mVFJCj2bZnFh66+7URMJaRz25zil
 H+YsHbZvwUlBuz9fb18+F5GMCwxXZWl05ULICg3kkAMrxKDFXu8GOzjouXBnS6IfBmyy
 fnaIeFX3zwEEPmz5F1vdrngvZvtXkzWcp2hMg+gc0uwg46/QMJ0mT/EF1EOy69V60laf
 k1v29nZPlckBj0PrpkGnNNmbzToMSPvgm6ZjQHI8EJVPAmjemeyRkTi/Ad+ZXt6i/vhL
 9ZrKu0ujKVmJb665+b1T4j4jdY/Zp2tx6BiSPf03vZ6TBRUgTLGlQEoR6ECSaz8DSp/q
 3yog==
X-Gm-Message-State: AOJu0Ywq0gYBAJtsDFGFGMyBBcQaOsdqYAQj8FTKmBNuVRRZ2vEESFkX
 oUroQOHvqEPYTMeL+E5+b0EFEPwgcOHYnmr6pNGfZ99kK1GiUNqbk3WOjvP//Kmts6oomzb7hoU
 xuBPNcq7jIrKdZKpgwoDnZMge/FML99yHUVGo
X-Google-Smtp-Source: AGHT+IGy5gO53UM0oJAlohh+4At+0i0l/Vi8pIR52RUwf7WZ6I/jyEACa11eGpb3JDTApRUeJH2/9xzeV7TAt+hsG4U=
X-Received: by 2002:a05:6000:1bc1:b0:367:926a:7413 with SMTP id
 ffacd0b85a97d-3716cd2c07bmr713273f8f.63.1723485381094; Mon, 12 Aug 2024
 10:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-4-tavip@google.com>
 <CAFEAcA82c_RZ6512dB1OxpAtinRctkZK7ZyjpxX16Wk7DYZDPg@mail.gmail.com>
In-Reply-To: <CAFEAcA82c_RZ6512dB1OxpAtinRctkZK7ZyjpxX16Wk7DYZDPg@mail.gmail.com>
From: Octavian Purdila <tavip@google.com>
Date: Mon, 12 Aug 2024 10:56:09 -0700
Message-ID: <CAGWr4cSiNOm1mL6ZC+Dr8bFHz9Dx2R78_we9wL=W6f3FExb-kQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/23] scripts: add script to generate C header files
 from SVD XML files
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com, 
 pbonzini@redhat.com, alex.bennee@linaro.org, thuth@redhat.com, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=tavip@google.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Mon, Aug 12, 2024 at 8:27=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>

Hi Peter,

Thanks for the review!


> On Mon, 5 Aug 2024 at 21:17, Octavian Purdila <tavip@google.com> wrote:
> >
> > From: Stefan Stanacar <stefanst@google.com>
> >
> > From: Stefan Stanacar <stefanst@google.com>
> >
> > The CMSIS System View Description format(CMSIS-SVD) is an XML based
> > description of Arm Cortex-M microcontrollers provided and maintained
> > by sillicon vendors. It includes details such as peripherals registers
> > (down to bitfields), peripheral register block addresses, reset
> > values, etc.
> >
> > This script uses this information to create header files that makes it
> > easier to emulate peripherals.
> >
> > The script can be used to create either peripheral specific headers or
> > board / system specific information. The script generated headers are
> > similar to the SVDConv utility.
> >
> > Peripheral specific headers contains information such as register
> > layout, register names and reset values for registers:
> >
> >   typedef struct {
> >     ...
> >     union {
> >       uint32_t PSELID;              /* 0x00000FF8 Peripheral Select and
> >                                      * Flexcomm module ID */
> >       struct {
> >         uint32_t PERSEL : 3;        /* [2..0] Peripheral Select */
> >         uint32_t LOCK : 1;          /* [3..3] Lock the peripheral selec=
t */
> >         uint32_t USARTPRESENT : 1;  /* [4..4] USART present indicator *=
/
> >         uint32_t SPIPRESENT : 1;    /* [5..5] SPI present indicator */
> >         uint32_t I2CPRESENT : 1;    /* [6..6] I2C present indicator */
> >         uint32_t I2SPRESENT : 1;    /* [7..7] I2S Present */
> >         uint32_t : 4;
> >         uint32_t ID : 20;           /* [31..12] Flexcomm ID */
> >       } PSELID_b;
> >     };
>
> Bitfield layout in C isn't portable, so don't generate this kind
> of union-of-a-integer-and-some-bitfields, please. You can
> generate FIELD() macro invocations (see include/hw/registerfields.h)
> which define shift/mask/length macros that can be used with
> FIELD_EX*/FIELD_DP* to do extract/deposit operations.
>

I see that C bitfields are already used in a few places in qemu. Could
you please elaborate on the portability issue?

> >     ...
> >   } FLEXCOMM_Type;                  /* Size =3D 4096 (0x1000) */
> >
> >   #define FLEXCOMM_PSELID_PERSEL_Pos (0UL)
> >   #define FLEXCOMM_PSELID_PERSEL_Msk (0x7UL)
> >   #define FLEXCOMM_PSELID_LOCK_Pos (3UL)
> >   #define FLEXCOMM_PSELID_LOCK_Msk (0x8UL)
> >   ...
> >
> >   typedef enum {                /* FLEXCOMM_PSELID_LOCK */
> >     /* Peripheral select can be changed by software. */
> >     FLEXCOMM_PSELID_LOCK_UNLOCKED =3D 0,
> >     /* Peripheral select is locked and cannot be changed until this
> >      * Flexcomm module or the entire device is reset. */
> >     FLEXCOMM_PSELID_LOCK_LOCKED =3D 1,
> >   } FLEXCOMM_PSELID_LOCK_Enum;
> >   ...
> >
> >   #define FLEXCOMM_REGISTER_NAMES_ARRAY(_name) \
> >     const char *_name[sizeof(FLEXCOMM_Type)] =3D { \
> >         [4088 ... 4091] =3D "PSELID", \
> >         [4092 ... 4095] =3D "PID", \
> >     }
> >
> > Board specific headers contains information about peripheral base
> > register addresses.
>
> thanks
> -- PMM

