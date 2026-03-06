Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9742BFCB61C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXZD-0005rN-Va; Fri, 06 Mar 2026 10:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vyXZ7-0005kb-Jn
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:58:13 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vyXZ4-0003fN-Hl
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:58:13 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5a133b686f7so2205412e87.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:58:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772812688; cv=none;
 d=google.com; s=arc-20240605;
 b=MNeBQb6MUlUhOK4s2K7+23hfNjURNDpKH+8TpsktsXePt92JM8TuMbXb+B8OPR9drR
 Y3+Ve6YlM/qOadaxMDygYQ2dSI+UhkCu/cETNB+HwL1p7qlsQAbyEEvYgcbkoK0ckIyd
 +QboeUzo/PsmBcUABJEoIVHsXs9dNMXnhq8GM9HkxV4l3x0qlmGaFe9/zWvzrjjlQQnj
 b8WE5f9CgXkwZoj/vVgx9MBkF6noEA57KGd51Ho/Pt9Nm/U9S14FC9BGENeVZRrmTa/Y
 IeuBW/XcYaJBnZNULugJaQMqill8oS3DzNEaFk8/g0bFT+H9Arm0+dYWq8sXP3jAcAkT
 Vymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XRpe0gu67pVPCQJ6cmtc0yK7R/iEcmXueRFHLjumP0A=;
 fh=HLSZl4wSHbARFK/QliXDFk7Jcs8wjDiYrsaiKvzt3ao=;
 b=koQ9SiCkrfcV3Hi2YK+7reUon9OZJks6xG2OF5jAXX9Zme8dcY9pBLpFghY6yve0t1
 w46JJfhNhQes9QjS0Pr4mevmuPwv2TUGpepyvUSVj5KCPRqWErqu7bcDQxEMA3Nt4Kiu
 /5KvhvkRkYVylnGqcRbDEs0V10ChLGfUeEaJ65Zybreg3J9lGI7mRXKaAWaFwMUfBORa
 HbfbD/hgjDnclK6CH+xTO9Qa70M7iaJGtuETQ7ckzDuN7kEmlHjQAS+c2Xl8KRo+Bk1b
 EwRmFwH38jyqYSKKEAUHIMOhev1uGT2ZPQSai02sOX0UyIcxWTQ/StokOzGl12dZbmG9
 u3Vw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1772812688; x=1773417488; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRpe0gu67pVPCQJ6cmtc0yK7R/iEcmXueRFHLjumP0A=;
 b=BikbdvgYMF/0AX1BVO1X3PEegl7J+ZgEPt6j1JkVmf2GVw/I5dvIbiNPS/pIW0jNR8
 ZmEk4vYZLy6/SXT515+JyEdIa2UBM7o9GclA5NJj1Y1pbCZ8P9oZwuOR2HOY7TYPv/B6
 pYUjd0PeZo/jGf+Vuk/2BWEfP4kaTeW8BxYX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772812688; x=1773417488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XRpe0gu67pVPCQJ6cmtc0yK7R/iEcmXueRFHLjumP0A=;
 b=CdjeohFyxnz30srOI6Mqt63fTQcO8Xy0iEPUS6d+lbEXCEW3yxDxCOx+ZkNawYeeUj
 5KnDl+g9s/3UKZf8wEevDAEI6wHDK8nMqxr0Ioqvx181AS+4jZow6qu9XpdN1FT3CROw
 xcZCRvz6oBLlDk3KLt+zjJSjBdTNtWh4vEPDa1UART5UjoChYqSaznnHFb33lFVuA9bu
 BQkXsRwU5GLmAYCWgcfX0xW+8zsAArQXS8kI3+LDHZv+Y8upYQ50W0VH2AOeVbViIP8v
 huTVaY11+lDIHF9H0lHvvm4+f13ApZ6pVKTVwZTFSs2OnBaUeWeZaKcUmw/whR2HKpmE
 Jv5g==
X-Gm-Message-State: AOJu0YzNgpyeRsRVa0j0MMN9g87QNTzvwotuU+NqGDszVW5guUt571C9
 EVF82muZo9CQ/LIkztZ4JzOy6ODvwZzCaTaQOaM4MYBBWg2HwKsIklxVsx3m0/NxZNWvpKzqYSF
 rOajGiFSF3yC8LUpdl+ZONfeTpMq3dbaZaA2BV9E2KoptzficLMEJLVcDZw==
X-Gm-Gg: ATEYQzxvwahO/RZyOWY9KEtIkmJ3H21LuMdHg8K8hXkyGanP6I2+wbZFTXnOedsga25
 jPqFiOVWUNPTw3dsGAfqYXs1extASpEwJrLMfywECx0I9uzwJCqJv5ixexp+5I+/n0BTY3cskWR
 O9hVfNR3B/th3JYE0SNgRwzRNN+X8lUogrrHf2KHJH1c6vnbLq54jqXZUqK2lG0Xyh4sQG1pFu2
 slk6sFJg/BOtUB+VfoAXVVW6gtRPLd0zS3Ze33Dn8vGUESSwU6xDHKrtDgxQxNBKcipGQ18ScXk
 qOwJsP/buhYnpJc9AFaIAUVhs3uJ2ZjEz8twY3A=
X-Received: by 2002:a05:6512:10d5:b0:5a1:18a0:8552 with SMTP id
 2adb3069b0e04-5a13caadcbfmr1171586e87.9.1772812687616; Fri, 06 Mar 2026
 07:58:07 -0800 (PST)
MIME-Version: 1.0
References: <20260306150342.395923-1-alexander@mihalicyn.com>
 <20260306150342.395923-2-alexander@mihalicyn.com> <aar4-DgXbartZY4y@x1.local>
In-Reply-To: <aar4-DgXbartZY4y@x1.local>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 6 Mar 2026 16:57:56 +0100
X-Gm-Features: AaiRm53zXz0SXeJYg-HSqA_OKp--E-h-W2godPwDlCPUdT9gyaZjz7AVjJkkods
Message-ID: <CAJqdLroT8j77_0OrE+qOoj1rRsmm0rQ4EgnjtWBush9CL1MFog@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] migration: add
 VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 Jesper Devantier <foss@defmacro.it>, Klaus Jensen <its@irrelevant.dk>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 Keith Busch <kbusch@kernel.org>, Fabiano Rosas <farosas@suse.de>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x12d.google.com
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

Am Fr., 6. M=C3=A4rz 2026 um 16:55 Uhr schrieb Peter Xu <peterx@redhat.com>=
:
>
> On Fri, Mar 06, 2026 at 04:03:37PM +0100, Alexander Mikhalitsyn wrote:
> > +#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT8_ALLOC(_field, _state=
, _field_num, _version, _vmsd, _type) { \
> > +    .name       =3D (stringify(_field)),                              =
  \
> > +    .version_id =3D (_version),                                       =
  \
> > +    .num_offset =3D vmstate_offset_value(_state, _field_num, uint8_t),=
 \
> > +    .info       =3D &vmstate_info_ptrs_array_entry,                   =
  \
> > +    .vmsd       =3D &(_vmsd),                                         =
  \
> > +    .start      =3D sizeof(_type),                                    =
  \
> > +    .size       =3D sizeof(_type *),                                  =
  \
> > +    .flags      =3D VMS_VARRAY_UINT8|VMS_POINTER,                     =
 \
> > +    .offset     =3D vmstate_offset_pointer(_state, _field, _type *),  =
  \
> > +}
> > +
> > +#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT32_ALLOC(_field, _stat=
e, _field_num, _version, _vmsd, _type) { \
> > +    .name       =3D (stringify(_field)),                              =
  \
> > +    .version_id =3D (_version),                                       =
  \
> > +    .num_offset =3D vmstate_offset_value(_state, _field_num, uint32_t)=
, \
> > +    .info       =3D &vmstate_info_ptrs_array_entry,                   =
  \
> > +    .vmsd       =3D &(_vmsd),                                         =
  \
> > +    .start      =3D sizeof(_type),                                    =
  \
> > +    .size       =3D sizeof(_type *),                                  =
  \
> > +    .flags      =3D VMS_VARRAY_UINT32|VMS_POINTER,                    =
  \
> > +    .offset     =3D vmstate_offset_pointer(_state, _field, _type *),  =
  \
> > +}
>
> Hi, Alex,

Hi Peter,

>
> Per previous discussion, I thought we plan to add a new VMS_* flag, am I
> right?

yes, yes, I'll do this in -v4, sorry for this. I was busy adding a
test for NVMe migration
and decided to send -v3 with this new test.

Sorry about confusing you.

Kind regards,
Alex

>
> https://lore.kernel.org/r/CAJqdLrrKK-pTzk+Qm_45p9A6DRgj4VbFzSb6vFtJTkpN3U=
aFpg@mail.gmail.com
>
> --
> Peter Xu
>

