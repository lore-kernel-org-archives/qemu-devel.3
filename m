Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0EC10854DC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nP5-0002WA-0k; Wed, 18 Mar 2026 05:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nOu-0002Vf-Jc
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:41:17 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nOr-0001iy-GS
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 05:41:16 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-59e4989dacdso7581126e87.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 02:41:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773826871; cv=none;
 d=google.com; s=arc-20240605;
 b=B/DTLmfW9rhTgPE5TI0e4ZvOUzLqTABG67mvlmjH+9EoHmFa97fqZ8YPpwA2asxOn5
 JXx7q4IZzNwAFM9xtzeCnIlQNwga1cf73v+nntJSYBmGxLE9ltNgBkS7l764dfWmDlhm
 SmvSQVXj8xI7YRada/HFju5tm6Z1e4cHMp/Np7W5bZp7CrIg9XpHI66P0of7+wtseP/P
 a3QyulB8zRFt91y1G7gii93+VZX0+FTdA8/x8rCX8wKLHQ7b+94o8fD/7egECB8Gl7Mo
 FhEZP0lpVXXYOzZJdS77GSS1urhAKCzUKVu6UFGI7WdBVEnqa7QBllb2qwVa/mew+Qye
 3VSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qWcopO76bDUGIzoo4IkhrSBOYvYcGRQuSp4apCHsULg=;
 fh=D9TiOsAcOSpRlHrkA38ELZyIVSvZmg48LLzTtJLYv+0=;
 b=JXl6g1fVaAQ/9GfiGqOrpnwJdvyVU7Wj31MrU2AR5qfwR980LVIJHl71M9+Ixb4Z1Q
 yI+obvB6IGqohfxWylHq48Y0j0ajLIZTaVJpLBZlwo6gAm86fxC0Gp6VKuo7xqg2/JFt
 r2wiPwkrVCo4CwvbtEcjEZW+TZv+equPzOZX3+wejWhOwd/mbFnXsdnNnAMQajUuXNXV
 NRgXzYmOc5uX2huRjX/rz2/Eiy8TWe1BKOhd/mcBMPHlmrXaVmFTVJFTmCX1yh0RAw/P
 btMmGnqB46pmI9zx8JS6QVGctP/vrXIMEqR3WeO9OnUsFfPrgl4LynNqmsSekFmskN7v
 bLzg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773826871; x=1774431671; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qWcopO76bDUGIzoo4IkhrSBOYvYcGRQuSp4apCHsULg=;
 b=j0bZ+z02z0+opAYz4LhTKubH2Jf/hi+8KjZrUAvMCBMZsSGUOh50XlDe0HGMgTRwOB
 euy08Nu7LNykvtBbOWoOfTiTbwuQWP8LxAUxXr4ljL+Ic2P+rRcTFNsKJVCbJcthJuKb
 4tRPN9+FmoF3HxftiCBqqa6ToXhdGyWjm2joU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773826871; x=1774431671;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qWcopO76bDUGIzoo4IkhrSBOYvYcGRQuSp4apCHsULg=;
 b=nZ7wtO+bAqpxnIfWLPi+HbMiHR1YjJ4a4Ykv4Ldw/kyYhf8Vt7Ws4Ia6nrqWWCm3I4
 RvrRoTLm7yytPz0r5YJBoaV6Aept05XKCFfKOYARv5lQwzq80f4axqXBmaaDJ0ySAcrT
 iF4HjcEih9G/O+Rxq6ofFKOqa4XnTeyxNpsvel1mMlkFi2g5MfzWkyFrvU4MnztUGY3o
 siFS9MYCn2PfbX6RCAlY2hlwXnA2lFNIU2XjYq3Y5zR7TxXX90FG+VaJ45dEjBPSlXi8
 iqs4oeiuwor4l0TERNg2HnN3G8zt8k1F9PQqFC9zT0D3zpevgKAIydNSKHK8TVWVm2Yg
 oA/g==
X-Gm-Message-State: AOJu0Yw9Jkrjnop/D/7VBf/5Z6RoTxUiD23la/8C7HYNsMjmTk7LnWBx
 L+beg/uyJcPEcmkJaFvgeIKyPLfvjt2Gjrm7MXMpqE0GXaeghI5J039SzwPthZuKUrvC1gaQ+bK
 wqg1IMBq/l7bk6mvFJrnEP4fI5oDl5h9YW63WiZqYySxemfS2TgSEuz1gQQ==
X-Gm-Gg: ATEYQzx4OGQ+NDDiLRxn0o3cKIaB+6TabpBvgJ5fqLV7qIJx3UH/QwjKWJ5S+c1hBsp
 JAqkiKPY516E33dGicz6oF8fuvxZ+j+UKKG65fsWFdOiGjxw7TC+wNYvmG1MimzXeWA3o0QupNJ
 HkOm+k8D8oRJ1tDDIoRm0E3uS4HYm/VYs3Em7O+1z+viuix0N4/z/cC6Ac3VzkZ9pjhvPlwmyjS
 3LYHTqBRCub+KVN5Ev01F1rdNQ8JTH19Fjj4snWen2C9w/FpHLSd+s+mITz/O1MmE4CNrjKMO4V
 zlak46DCpbcIVzQpGJmg/AQw1u5FbUP/h91fjmc=
X-Received: by 2002:a05:6512:224e:b0:5a1:36fe:6b4e with SMTP id
 2adb3069b0e04-5a279592f83mr1246185e87.12.1773826871049; Wed, 18 Mar 2026
 02:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260317232332.15209-1-peterx@redhat.com>
 <20260317232332.15209-8-peterx@redhat.com>
In-Reply-To: <20260317232332.15209-8-peterx@redhat.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 18 Mar 2026 10:40:59 +0100
X-Gm-Features: AaiRm52DTjLASe6iyjZka6wDInrpZqRSr5DnZzli8Tnor_uzc3A_2BM-UVEIQlk
Message-ID: <CAJqdLrphvH16YZee=VUXiV5xzNg1OWXVMdUGypTEL2rZDxC4FA@mail.gmail.com>
Subject: Re: [PATCH RFC 07/10] vmstate: Allow vmstate_info_nullptr to emit
 non-NULL markers
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
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
> We used to have one vmstate called "nullptr" which is only used to genera=
te
> one-byte hint to say one pointer is NULL.
>
> Let's extend its use so that it will generate another byte to say the
> pointer is non-NULL.
>
> With that, the name of the info struct (or functions) do not apply anymor=
e.
> Update correspondingly.
>
> No functional change intended yet.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  include/migration/vmstate.h |  9 +++++++--
>  migration/vmstate-types.c   | 34 ++++++++++++++++------------------
>  migration/vmstate.c         | 29 ++++++++++++++---------------
>  3 files changed, 37 insertions(+), 35 deletions(-)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 092e8f7e9a..2e51b5ea04 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -282,9 +282,14 @@ extern const VMStateInfo vmstate_info_uint32;
>  extern const VMStateInfo vmstate_info_uint64;
>  extern const VMStateInfo vmstate_info_fd;
>
> -/** Put this in the stream when migrating a null pointer.*/
> +/*
> + * Put this in the stream when migrating a pointer to reflect either a N=
ULL
> + * or valid pointer.
> + */
>  #define VMS_MARKER_PTR_NULL          (0x30U)   /* '0' */
> -extern const VMStateInfo vmstate_info_nullptr;
> +#define VMS_MARKER_PTR_VALID         (0x31U)   /* '1' */
> +
> +extern const VMStateInfo vmstate_info_ptr_marker;
>
>  extern const VMStateInfo vmstate_info_cpudouble;
>
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index 7622cf8f01..b31689fc3c 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -359,36 +359,34 @@ const VMStateInfo vmstate_info_fd =3D {
>      .save =3D save_fd,
>  };
>
> -static bool load_nullptr(QEMUFile *f, void *pv, size_t size,
> -                         const VMStateField *field, Error **errp)
> +static bool load_ptr_marker(QEMUFile *f, void *pv, size_t size,
> +                            const VMStateField *field, Error **errp)
>
>  {
> -    if (qemu_get_byte(f) =3D=3D VMS_MARKER_PTR_NULL) {
> +    int byte =3D qemu_get_byte(f);
> +
> +    if (byte =3D=3D VMS_MARKER_PTR_NULL || byte =3D=3D VMS_MARKER_PTR_VA=
LID) {
> +        /* TODO: process PTR_VALID case */
>          return true;
>      }
>
> -    error_setg(errp, "vmstate: load_nullptr expected VMS_NULLPTR_MARKER"=
);
> +    error_setg(errp, "%s: unexpected ptr marker: %d", __func__, byte);
>      return false;
>  }
>
> -static bool save_nullptr(QEMUFile *f, void *pv, size_t size,
> -                         const VMStateField *field, JSONWriter *vmdesc,
> -                         Error **errp)
> +static bool save_ptr_marker(QEMUFile *f, void *pv, size_t size,
> +                            const VMStateField *field, JSONWriter *vmdes=
c,
> +                            Error **errp)
>
>  {
> -    if (pv =3D=3D NULL) {
> -        qemu_put_byte(f, VMS_MARKER_PTR_NULL);
> -        return true;
> -    }
> -
> -    error_setg(errp, "vmstate: save_nullptr must be called with pv =3D=
=3D NULL");
> -    return false;
> +    qemu_put_byte(f, pv ? VMS_MARKER_PTR_VALID : VMS_MARKER_PTR_NULL);
> +    return true;
>  }
>
> -const VMStateInfo vmstate_info_nullptr =3D {
> -    .name =3D "nullptr",
> -    .load =3D load_nullptr,
> -    .save =3D save_nullptr,
> +const VMStateInfo vmstate_info_ptr_marker =3D {
> +    .name =3D "ptr-marker",
> +    .load =3D load_ptr_marker,
> +    .save =3D save_ptr_marker,
>  };
>
>  /* 64 bit unsigned int. See that the received value is the same than the=
 one
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 5a6b352764..a3a5f25946 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -55,12 +55,12 @@ vmstate_field_exists(const VMStateDescription *vmsd, =
const VMStateField *field,
>  }
>
>  /*
> - * Create a fake nullptr field when there's a NULL pointer detected in t=
he
> + * Create a ptr marker field when there's a NULL pointer detected in the
>   * array of a VMS_ARRAY_OF_POINTER VMSD field.  It's needed because we
>   * can't dereference the NULL pointer.
>   */
>  static const VMStateField *
> -vmsd_create_fake_nullptr_field(const VMStateField *field)
> +vmsd_create_ptr_marker_field(const VMStateField *field)
>  {
>      VMStateField *fake =3D g_new0(VMStateField, 1);
>
> @@ -76,7 +76,7 @@ vmsd_create_fake_nullptr_field(const VMStateField *fiel=
d)
>
>      /* See vmstate_info_nullptr - use 1 byte to represent nullptr */
>      fake->size =3D 1;
> -    fake->info =3D &vmstate_info_nullptr;
> +    fake->info =3D &vmstate_info_ptr_marker;
>      fake->flags =3D VMS_SINGLE;
>
>      /* All the rest fields shouldn't matter.. */
> @@ -278,7 +278,7 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDesc=
ription *vmsd,
>                       * an array of pointers), use null placeholder and d=
o
>                       * not follow.
>                       */
> -                    inner_field =3D vmsd_create_fake_nullptr_field(field=
);
> +                    inner_field =3D vmsd_create_ptr_marker_field(field);
>                  } else {
>                      inner_field =3D field;
>                  }
> @@ -567,7 +567,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VM=
StateDescription *vmsd,
>              int i, n_elems =3D vmstate_n_elems(opaque, field);
>              int size =3D vmstate_size(opaque, field);
>              JSONWriter *vmdesc_loop =3D vmdesc;
> -            bool is_prev_null =3D false;
> +            bool use_marker_field_prev =3D false;
>
>              trace_vmstate_save_state_loop(vmsd->name, field->name, n_ele=
ms);
>              if (field->flags & VMS_POINTER) {
> @@ -578,7 +578,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VM=
StateDescription *vmsd,
>              for (i =3D 0; i < n_elems; i++) {
>                  void *curr_elem =3D first_elem + size * i;
>                  const VMStateField *inner_field;
> -                bool is_null;
> +                bool use_marker_field;
>                  int max_elems =3D n_elems - i;
>
>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
> @@ -586,17 +586,16 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const =
VMStateDescription *vmsd,
>                      curr_elem =3D *(void **)curr_elem;
>                  }
>
> -                if (!curr_elem && size) {
> +                use_marker_field =3D !curr_elem && size;
> +                if (use_marker_field) {
>                      /*
>                       * If null pointer found (which should only happen i=
n
>                       * an array of pointers), use null placeholder and d=
o
>                       * not follow.
>                       */
> -                    inner_field =3D vmsd_create_fake_nullptr_field(field=
);
> -                    is_null =3D true;
> +                    inner_field =3D vmsd_create_ptr_marker_field(field);
>                  } else {
>                      inner_field =3D field;
> -                    is_null =3D false;
>                  }
>
>                  /*
> @@ -612,16 +611,16 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const =
VMStateDescription *vmsd,
>                   */
>                  if (vmdesc && vmsd_can_compress(field) &&
>                      (field->flags & VMS_ARRAY_OF_POINTER) &&
> -                    is_null !=3D is_prev_null) {
> +                    use_marker_field !=3D use_marker_field_prev) {
>
> -                    is_prev_null =3D is_null;
> +                    use_marker_field_prev =3D use_marker_field;
>                      vmdesc_loop =3D vmdesc;
>
>                      for (int j =3D i + 1; j < n_elems; j++) {
>                          void *elem =3D *(void **)(first_elem + size * j)=
;
> -                        bool elem_is_null =3D !elem && size;
> +                        bool elem_use_marker_field =3D !elem && size;
>
> -                        if (is_null !=3D elem_is_null) {
> +                        if (use_marker_field !=3D elem_use_marker_field)=
 {
>                              max_elems =3D j - i;
>                              break;
>                          }
> @@ -633,7 +632,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VM=
StateDescription *vmsd,
>                                                      i, max_elems, errp);
>
>                  /* If we used a fake temp field.. free it now */
> -                if (is_null) {
> +                if (use_marker_field) {
>                      g_clear_pointer((gpointer *)&inner_field, g_free);
>                  }
>
> --
> 2.50.1
>

