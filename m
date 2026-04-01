Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5D5D35145
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7vTl-0003bM-Mi; Wed, 01 Apr 2026 09:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w7vTk-0003Yu-0O
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:19:28 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w7vTh-0004m7-NI
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:19:27 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-59dcdf60427so7445011e87.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 06:19:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775049562; cv=none;
 d=google.com; s=arc-20240605;
 b=SXTX1qS8Rx2m5LYsUt9b99HUMSb8ycJh0LQGOBbJ+NURtNsJd1lJlqIb4G3Sz78hNX
 6aPY25DSz7xBFBr8MtVulu22vulYrux/YGisnd8GLQBpRDHwrDqY4ips9SCdBL2NjsnY
 pVje65wFgiashsGOXwunsO7VR4LPVE98p8Zh02Ft04tnmY1O54fShKXtCQxYALenYDsf
 USWbTDenwJWKmunG2y9ouhnAi1fnpzQYTAE+c1nmd7qrG1DdceIIC6/pcGwSQto/fDNg
 ho8R0q3DQX82yHPHNjIuMo3Skf89RwNPZCSRdQw9qFfc4kZk8zFICWwIO5Jg88gENt91
 xRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ddk91vzVrgxO/1U2N5z1inQzGc02XY7Eh+XSctaDDlw=;
 fh=8jLQ9BF8TzoH/ErGnlkH4vSIZ9SpUVgmQkqZ4x0ADis=;
 b=QMiB2jtcae12WOLVcLj6Ygg3rd+TyJxhKbHk+aM6LuYy3U5IPX7LHlTLFizX+TuLYn
 vPIQGpBUr7rsjFIg+BRW0u2FZnojWR+/uw9diwo29suH68q7B99PJat5X9egW9q4DIQQ
 IL0ynndyAZcV0Y9nNKjsAH/qlV0YGWV8TJDBnkaSaQCEResKCoHZdsqOIFKkZwHWnRS6
 Li+YRP3f2UbQGhEXPhi80/5oChqDbi6Sou1Kb2GMWyaedL0GhMiwBQFnyrSMWC2oN8DB
 pgeNIxTXIti6a6x5YYeYVpjoObD8xE/ZpcWj7qiDCZ2z2lP0lEhOObEzcS5j3HG1a79w
 OsHw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1775049562; x=1775654362; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ddk91vzVrgxO/1U2N5z1inQzGc02XY7Eh+XSctaDDlw=;
 b=fKVCIgDyRp/PvDyWUXJSFLRq2wBQfDMqp6Uc4Xt10YNtampYoHUXXmw+zQW1igIDgW
 tvi+4P2So8uYlXMzQwTxi+DzJnMhP9hZQx0VIWvlPbgiAbRGp39ldZ8CqGKcKIdYddKl
 5pB2GYOoiE3/1EIeZXsl/y75r2WxaKF3688lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775049562; x=1775654362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ddk91vzVrgxO/1U2N5z1inQzGc02XY7Eh+XSctaDDlw=;
 b=Wj+hB1wlz6NhPCFTnIdJYPOsONj8Xz3FZ/AM1uF69fFG5NYLII+HscKXHqIZow1WAQ
 c2CNWeIVjoGGu6Bm1yrvin3YcdVtAlRFQKw/tLwzn0Rz7vh0tkiZ0yY9uGqEyqEr/R2f
 MAuXD/RRSzG7HErzMvJ4XsHZcmjQocV/Pu6PW4zh8zUeJFAK92C5FB4tCTyqW+j+Q+s0
 omypmB39EmF6TO9yV0wF32n9t+lByKiKQlU2z/6jzcYN6O8UFKcYkHJeJQQqRZqvH1vB
 f6207MCf/BEuwCjxn2cRAdHKutVW1CiAvMdIrPctEqVfW0LExJ7Zf+yv19B9uQbhi1I7
 yU4Q==
X-Gm-Message-State: AOJu0YxzmQ7Fnr3pW1WCZXe6wiuOWaBg+gVowhyQRCn38y0BNAWT7rLk
 pIiExSMWlOUgc0a3L1ehc1sj8gcHd9tnnWeeHPnbShID+zT9kzVv1vDzVCYZnRE9fKU32ONYnvc
 pWGFt49cv0GoiuSftdXGsDaF1syfMsRasaLEnsqZblg==
X-Gm-Gg: ATEYQzwpKo1Pba9J4GD5luxIaghUCY87+7dquJK4xzX2/5oD4HkHoAy2AXq6R+PSZas
 edenCedjflEpwl8CMMAzfEMB6uPuMWCnH7bfV1ZBdcFqj8ua4+mUPe40xhMDkMHR9M4K6hOqCr7
 tunzpORByQv47m9wqzXHNdsF+vvVtMjJt/hrmdBYal9F+E4BgdnDX0RvnvI1iAAl6V0CJ3YjPIl
 HIx1t0zkf6O8v43g/vJmyoEt8vavzla0wd0q5XwvbYLKu5Z3zVsNq097rngopx124vA8xjyD4Iw
 HBLzLgzRVvm8LfG2z2cSOCyCbFNA771LENoshA==
X-Received: by 2002:a05:6512:1088:b0:5a2:a8ab:ab55 with SMTP id
 2adb3069b0e04-5a2c1eec1bdmr1598736e87.1.1775049561539; Wed, 01 Apr 2026
 06:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260326210532.379027-1-peterx@redhat.com>
 <20260326210532.379027-8-peterx@redhat.com>
In-Reply-To: <20260326210532.379027-8-peterx@redhat.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 1 Apr 2026 15:19:10 +0200
X-Gm-Features: AQROBzAn6H_b2KwveAWy8o35SXNf9dMglSJgqGX921GXfMZ1vPZR1qjoGbxGXso
Message-ID: <CAJqdLrprRhCjMOusw2kGy6TWuFW25vUrDNLHQu_zXaUYeRq9uQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 07/11] vmstate: Allow vmstate_info_nullptr to emit
 non-NULL markers
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x134.google.com
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

Am Do., 26. M=C3=A4rz 2026 um 22:05 Uhr schrieb Peter Xu <peterx@redhat.com=
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
> Update analyze-migration.py to work with the new layout.
>
> No functional change intended yet.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

> ---
>  include/migration/vmstate.h  |  9 +++++++--
>  migration/vmstate-types.c    | 34 ++++++++++++++++------------------
>  migration/vmstate.c          | 25 +++++++++++++------------
>  scripts/analyze-migration.py | 22 ++++++++++++----------
>  4 files changed, 48 insertions(+), 42 deletions(-)
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
> index b274204e66..b333aa1744 100644
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
> @@ -71,12 +71,12 @@ vmsd_create_fake_nullptr_field(const VMStateField *fi=
eld)
>      fake->name =3D field->name;
>      fake->version_id =3D field->version_id;
>
> -    /* Do not need "field_exists" check as it always exists (which is nu=
ll) */
> +    /* Do not need "field_exists" check as it always exists */
>      fake->field_exists =3D NULL;
>
> -    /* See vmstate_info_nullptr - use 1 byte to represent nullptr */
> +    /* See vmstate_info_ptr_marker - use 1 byte to represent ptr status =
*/
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
> @@ -583,26 +583,27 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const =
VMStateDescription *vmsd,
>              for (i =3D 0; i < n_elems; i++) {
>                  void *curr_elem =3D first_elem + size * i;
>                  const VMStateField *inner_field;
> -                bool is_null;
>                  /* maximum number of elements to compress in the JSON bl=
ob */
>                  int max_elems =3D vmsd_can_compress(field) ? (n_elems - =
i) : 1;
> +                bool use_marker_field, is_null;
>
>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
>                      assert(curr_elem);
>                      curr_elem =3D *(void **)curr_elem;
>                  }
>
> -                if (!curr_elem && size) {
> +                is_null =3D !curr_elem && size;
> +                use_marker_field =3D is_null;
> +
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
> @@ -638,7 +639,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VM=
StateDescription *vmsd,
>                                                      i, max_elems, errp);
>
>                  /* If we used a fake temp field.. free it now */
> -                if (is_null) {
> +                if (use_marker_field) {
>                      g_clear_pointer((gpointer *)&inner_field, g_free);
>                  }
>
> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> index e81deab8f9..1771ff781b 100755
> --- a/scripts/analyze-migration.py
> +++ b/scripts/analyze-migration.py
> @@ -469,26 +469,26 @@ def __init__(self, desc, file):
>          super(VMSDFieldIntLE, self).__init__(desc, file)
>          self.dtype =3D '<i%d' % self.size
>
> -class VMSDFieldNull(VMSDFieldGeneric):
> +class VMSDFieldPtrMarker(VMSDFieldGeneric):
>      NULL_PTR_MARKER =3D b'0'
> +    VALID_PTR_MARKER =3D b'1'
>
>      def __init__(self, desc, file):
> -        super(VMSDFieldNull, self).__init__(desc, file)
> +        super(VMSDFieldPtrMarker, self).__init__(desc, file)
>
>      def __repr__(self):
> -        # A NULL pointer is encoded in the stream as a '0' to
> -        # disambiguate from a mere 0x0 value and avoid consumers
> -        # trying to follow the NULL pointer. Displaying '0', 0x30 or
> -        # 0x0 when analyzing the JSON debug stream could become
> +        # A NULL / non-NULL pointer may be encoded in the stream as a
> +        # '0'/'1' to represent the status of the pointer.  Displaying '0=
',
> +        # 0x30 or 0x0 when analyzing the JSON debug stream could become
>          # confusing, so use an explicit term instead.
> -        return "nullptr"
> +        return "null-ptr" if self.data =3D=3D self.NULL_PTR_MARKER else =
"valid-ptr"
>
>      def __str__(self):
>          return self.__repr__()
>
>      def read(self):
> -        super(VMSDFieldNull, self).read()
> -        assert(self.data =3D=3D self.NULL_PTR_MARKER)
> +        super(VMSDFieldPtrMarker, self).read()
> +        assert(self.data in [self.NULL_PTR_MARKER, self.VALID_PTR_MARKER=
])
>          return self.data
>
>  class VMSDFieldBool(VMSDFieldGeneric):
> @@ -642,7 +642,9 @@ def getDict(self):
>      "bitmap" : VMSDFieldGeneric,
>      "struct" : VMSDFieldStruct,
>      "capability": VMSDFieldCap,
> -    "nullptr": VMSDFieldNull,
> +    # Keep the old nullptr for old binaries
> +    "nullptr": VMSDFieldPtrMarker,
> +    "ptr-marker": VMSDFieldPtrMarker,
>      "unknown" : VMSDFieldGeneric,
>  }
>
> --
> 2.50.1
>

