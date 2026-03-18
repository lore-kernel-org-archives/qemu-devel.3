Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8152910854DB
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nLk-0001AN-44; Wed, 18 Mar 2026 05:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nLi-00019j-Jr
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:37:58 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nLg-00013e-QI
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:37:58 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-59dcdf60427so6107483e87.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 02:37:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773826674; cv=none;
 d=google.com; s=arc-20240605;
 b=SBaa0+r+dbRz1SPxbqAQrV7+kIZ1LSFQPXJmXGgseoEzxjAC5xNjJdqaIuFPRdzmKr
 bQlcfnkdwwO8ExsHELpQLkDd8h3tAl4Z0PFq1vPj36YRv510SD2ouiDrLJ06Nfy2cdzG
 G3PZNEisBJ+z3Rdwo45s14+DtEMiNHBctsXPPwqDet/C6DEU4OkwJ/pedN6goJd2BOCK
 jOTXTfddeHVUtTrcs3iG7aH0rqVsS91SdSJupcx8HI5b8tbAc4GkLOTlfZLvfM9jHyD7
 bDA2mb2MgKkH00DYg3ecbBWVPqa90HslcVfkAgc+bJ4Irg80k4vVU2VMh2sosQKjub+4
 U/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/qKije3ocYh2LZlp8/zK94kNv1a/1syTAxZc/Irie4A=;
 fh=D9TiOsAcOSpRlHrkA38ELZyIVSvZmg48LLzTtJLYv+0=;
 b=GKRaR8Hx/DeLc5ySGn2V9s87Uu6f1ndeOSZZ6u0jbIxVDBxyM7cd/qzB66EY6enMKX
 FNAIG5/gG7lTsyyQxoWR0y0RZ5U2U3SuL1IIEslP8LNqJszn7KB06WsSpzEDEUuLQcs9
 5EBu33WLrNwG4GZ5x5t4gTwcE3gBK/8N6+J+18hyN3247lO1R4urFWObHDFzXOzzA0r1
 ZcbsbAX7AB6r+/5cFDo+92BZN8080TUAJoeC3mfnya975UV7SP/D3heIw3KAu5boa+gx
 NL37tK9pw7mJBgOkFFfmq9QM8tmKwq6NG9D73m/3a+sq1GmLrojNwikqdDcPj1kb5Ii5
 H26A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773826674; x=1774431474; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/qKije3ocYh2LZlp8/zK94kNv1a/1syTAxZc/Irie4A=;
 b=KmbJ1uc+KcMoU6M1w7kJ7UI0R7/MOA+xg4oHFxjZ8h9WxSH/af425eM/rHkmPDbogv
 Ts4sfP00BnY3a/1bjm9BMf0n0FH/u7797Y8UzUhLVLueu0vtrgZ2u3ZtTEcPnj4iwTqW
 eAvE9fCrr9oE8HAMvqZau1jOBPqv0m9RH/ydE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773826674; x=1774431474;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/qKije3ocYh2LZlp8/zK94kNv1a/1syTAxZc/Irie4A=;
 b=H8UirAhfC4lCFJ2E8qmoam8akC3NH0bKNcWW6mYbm3XvD8eWVhyQBCVZ+ypLgBz13K
 KbsHVeHuPGEG4tIp+D6b/s0pWkBvC0VY24ockE6xZVW4BbtGYMmRORsLtWvSUTYLGbtT
 55fzv+yYZAC5g1/ERjBdySxu0YcHM0v+IvU4W8s/z5bJllyZH0fjtMhPeZbvuNkNeVDJ
 9v4A1JiuQbMA/QigKSxKFzqywRZu4S9jFn4KmCD/Aqg5f7/PSBIY0YTnbUsqQC8jQWfB
 hbDWGv8mwiMguvhm/xyNKeejyXAls9yL6GxeZqvrTbORM0+S2xgWzuVgtYH2Wo/jqP3l
 kWiA==
X-Gm-Message-State: AOJu0YxD4uBkjoXNpcBPP0zlAdKFn/2OEs40usxAvDFmEdrhDvE2jO4D
 OMr7hloVWDhz+kOr2AU46Gc8H/T8rUvCK0q+suQ/66fVItQHYs/2qjJMb2y71Eta/zLwhtOhVME
 V1qTCh841HVWcGHXnrHRK/TcBYy/1oVbs4cDVf32zOA==
X-Gm-Gg: ATEYQzx2I83z4J2JYoPjO7zYPbRywaIoyCbol1AG4b5BwK9Y1bHBqpxPd3s3NUYx2YG
 MLTYt4GzabsNh1+EqorHm9izZjZUxuwq76PLlcHco+2Egvtnc0mPSJly0STQDVOP6fv4NwouLMX
 Fze1sNjyNO80C+MZGavcBYu5xAeqei5e47+pvnAhutXlN+H9Ovwzj08tc11BPahNDEWmpa6jiDB
 OtrNCtFfnuqIpShO6CfqNH1e/gNv8Ta6T1JMk6N+agrjZr/d87WQmtRR3HKsnKst+pgY5lJ1lx+
 OrrjeyWCRQfOriUrgd7mNx7XTtzqQ6knq4MzI9w=
X-Received: by 2002:a05:6512:1193:b0:5a2:7c1c:74c with SMTP id
 2adb3069b0e04-5a27c1c08a5mr338618e87.21.1773826674190; Wed, 18 Mar 2026
 02:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260317232332.15209-1-peterx@redhat.com>
 <20260317232332.15209-4-peterx@redhat.com>
In-Reply-To: <20260317232332.15209-4-peterx@redhat.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 18 Mar 2026 10:37:42 +0100
X-Gm-Features: AaiRm53p0XhW64hxH0sVFSuZu1u-aXXjTiWgLWY9SmgSwUQPHovIYoixLwLEKqg
Message-ID: <CAJqdLrrGrt=UGyR_NSsdEJW_93+CkM9XUHFjYC7qN-hw6rP0jw@mail.gmail.com>
Subject: Re: [PATCH RFC 03/10] vmstate: Do not set size for
 VMS_ARRAY_OF_POINTER
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x133.google.com
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

Am Mi., 18. M=C3=A4rz 2026 um 00:23 Uhr schrieb Peter Xu <peterx@redhat.com=
>:
>
> When VMS_ARRAY_OF_POINTER is specified, it means the vmstate field is an
> array of pointers.
>
> The size of the element is not relevant to whatever it is stored inside: =
it
> is always the host pointer size.
>
> Let's reserve the "size" field in this case for future use, update
> vmstate_size() so as to make it still work for array of pointers properly=
.
>
> When at this, provide rich documentation on how size / size_offset works =
in
> vmstate.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  include/migration/vmstate.h | 20 ++++++++++++++++----
>  migration/savevm.c          |  3 +++
>  migration/vmstate.c         | 10 +++++++++-
>  3 files changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 68fd954411..b4bc69486d 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -183,11 +183,26 @@ typedef enum {
>  struct VMStateField {
>      const char *name;
>      size_t offset;
> +
> +    /*
> +     * @size or @size_offset specifies the size of the element embeded i=
n
> +     * the field.  Only one of them should be present never both.  When
> +     * @size_offset is used together with VMS_VBUFFER, it means the size=
 is
> +     * dynamic calculated instead of a constant.
> +     *
> +     * When the field is an array of any type, this stores the size of o=
ne
> +     * element of the array.
> +     *
> +     * NOTE: even if VMS_POINTER or VMS_ARRAY_OF_POINTER may be specifie=
d,
> +     * this parameter always reflects the real size of the objects that =
a
> +     * pointer point to.
> +     */
>      size_t size;
> +    size_t size_offset;
> +
>      size_t start;
>      int num;
>      size_t num_offset;
> -    size_t size_offset;
>      const VMStateInfo *info;
>      enum VMStateFlags flags;
>      const VMStateDescription *vmsd;
> @@ -547,7 +562,6 @@ extern const VMStateInfo vmstate_info_qlist;
>      .version_id =3D (_version),                                        \
>      .num        =3D (_num),                                            \
>      .info       =3D &(_info),                                          \
> -    .size       =3D sizeof(_type *),                                   \
>      .flags      =3D VMS_ARRAY|VMS_ARRAY_OF_POINTER,                    \
>      .offset     =3D vmstate_offset_array(_state, _field, _type*, _num), =
\
>  }
> @@ -557,7 +571,6 @@ extern const VMStateInfo vmstate_info_qlist;
>      .version_id =3D (_v),                                              \
>      .num        =3D (_n),                                              \
>      .vmsd       =3D &(_vmsd),                                          \
> -    .size       =3D sizeof(_type *),                                    =
\
>      .flags      =3D VMS_ARRAY|VMS_STRUCT|VMS_ARRAY_OF_POINTER,         \
>      .offset     =3D vmstate_offset_array(_s, _f, _type*, _n),          \
>  }
> @@ -567,7 +580,6 @@ extern const VMStateInfo vmstate_info_qlist;
>      .version_id =3D (_version),                                         =
    \
>      .num_offset =3D vmstate_offset_value(_state, _field_num, uint32_t), =
    \
>      .info       =3D &(_info),                                           =
    \
> -    .size       =3D sizeof(_type *),                                    =
      \
>      .flags      =3D VMS_VARRAY_UINT32 | VMS_ARRAY_OF_POINTER | VMS_POINT=
ER, \
>      .offset     =3D vmstate_offset_pointer(_state, _field, _type *),    =
      \
>  }
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 8115203b51..f5a6fd0c66 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -868,6 +868,9 @@ static void vmstate_check(const VMStateDescription *v=
msd)
>
>      if (field) {
>          while (field->name) {
> +            if (field->flags & VMS_ARRAY_OF_POINTER) {
> +                assert(field->size =3D=3D 0);
> +            }
>              if (field->flags & (VMS_STRUCT | VMS_VSTRUCT)) {
>                  /* Recurse to sub structures */
>                  vmstate_check(field->vmsd);
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index e98b5f5346..e29a8c3f49 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -110,13 +110,21 @@ static int vmstate_n_elems(void *opaque, const VMSt=
ateField *field)
>
>  static int vmstate_size(void *opaque, const VMStateField *field)
>  {
> -    int size =3D field->size;
> +    int size;
>
>      if (field->flags & VMS_VBUFFER) {
>          size =3D *(int32_t *)(opaque + field->size_offset);
>          if (field->flags & VMS_MULTIPLY) {
>              size *=3D field->size;
>          }
> +    } else if (field->flags & VMS_ARRAY_OF_POINTER) {
> +        /*
> +         * For an array of pointer, the each element is always size of a
> +         * host pointer.
> +         */
> +        size =3D sizeof(void *);
> +    } else {
> +        size =3D field->size;
>      }
>
>      return size;
> --
> 2.50.1
>

