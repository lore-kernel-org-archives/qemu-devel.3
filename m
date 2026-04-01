Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179B1D3517E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7vcz-0001eA-OM; Wed, 01 Apr 2026 09:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w7vcw-0001df-US
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:28:58 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w7vcp-00060X-Vi
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:28:55 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5a0fc5e2c59so7761141e87.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 06:28:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775050129; cv=none;
 d=google.com; s=arc-20240605;
 b=eqoVwrvXvZj3EXfwdLjEivA5RchXrHZ0ygLHOmTMClCWo3og0mjL13QZSa1r83A+OD
 wemvlCctYyhqGj/zjYnVG2XIjmcnFIdYPlWCWmxYvB13mMQ2zGvbVhy3XbN1odZJlHW0
 El7o2dzFW6AM+LCB+IeBSO1VDCcRNbQIFtVpNQ55gPwVha6ufn3312kv+gWN7xh1jqEG
 kUU7hw1TmQPhhuZm+Vc8w+OAyOc4Yps2/+VgG6978d4XeLJwHChLD0guCU3ZIC3sWzE5
 Idal8f6iIMptxTSpnIpGIIpCdEjsAnmhWhtTarawDprHfh2SRWlE8vgn/SPmFkKekXUl
 h+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=poZpfdSaz+QkWET6ELtupFiZpGnBbmLHuimCnTK1nG8=;
 fh=8jLQ9BF8TzoH/ErGnlkH4vSIZ9SpUVgmQkqZ4x0ADis=;
 b=cpC4ZBRo8ucXVgzW+OFLboox9gdSXrshjOcEIbW//IYkWEJtpokZOJJRs6InPDTSTf
 JCGVQii/iNjAB89D/N3lcbEpokv2oDFuKOFiAUw41CpGm60mKUGCo7ezID3J8a5EGcwk
 c5Q2BYc/kEGWORhmfRza71KHgcyoDHRi+SAiqDq322hA+cz8B3DETUaWqb4CY4MW1ogt
 iE9nCh8x3JDUCJV//4bYjjg8bzjOSe16BnC1zDgrw4NjO3DcaNkzJ6Jd59ubFwcFuSIO
 48achf2Oz+Ax7aD+4mLT1MbyO/fzD9yeXN2vOHMWBgamWw4UZ+7OdbrHdhX746AmAeor
 YE9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1775050129; x=1775654929; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=poZpfdSaz+QkWET6ELtupFiZpGnBbmLHuimCnTK1nG8=;
 b=HcwJXU12kqLUUkkbdsJ5Jg1cs1yHl9XGeo9XnEiovdp2sy7gzN+RCjOjyNOuTL2VW+
 j4hnSw1hlO29i6jdpOvyyE/cZhChkw972E/0T2XiAgzK62h+U2yyGJBOfGYTILWsfyHH
 I71SgjbIXpLu177XMbjECmpoqbbK/fYLf/k3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775050129; x=1775654929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=poZpfdSaz+QkWET6ELtupFiZpGnBbmLHuimCnTK1nG8=;
 b=kifuTcwnWtCFQqegFr/EqsejAp2bDxzQ7HW8sgO/ELLuemK6JPsyUcYM8O0x0aqqQZ
 kiaCKWv4KHrOoPQKG8EWFd2/i7DBhThSrp7fQvr+E69lve38KcqOjvA5HjjqjxkQ5qrs
 Y2sPKUV40kVYM4sne5nEjVCcD6Z3LUKKXIofjILYTajBeFQ95Rpo/5514SVYAPZnUlkq
 tDLXYbQpT9TwnqBbhlwrKBTlr8xhRp6RbTSeZJpKPTeKSmKklG5k3zWXmHPiO/YcqhQk
 2lxXdY6dykAsWPiYQPbGFRYyuQWq1qRRKYZk3Qi63Yrd2WNzLytKUz4O6CwwDsdKoi1W
 ONVQ==
X-Gm-Message-State: AOJu0Yw8maubNSxB9OfPpIXUZ1tDZ8Jp26scZxmGY2hfLnyFJclr2GXj
 hxAn67wP1C9rwMNGh373YWkyIrFUzu2XNtrHOlZ6X6qxhqQwLhoDy3SO8WWH0bY3KD2gh3Oz8UA
 JZKO2U2mlEc3wD8H/RtUO2K1xfaFFHXcKNJNGf39SXg==
X-Gm-Gg: ATEYQzw7uxLtlJFIuukDLlrc5afWyuoHnLlxCaiHmAYS8DGWtU2jbGgGfRFYELxdCpM
 U06s0daikzdFu/HkYgmnFfKM+QhvFMjq6XVbmdIdbV9LqbIW/p4+RPMT909qqGN38/n/Xw7xgpt
 grBAEux83ckJTNbxECu4kICOdBe7YeNB9YyBm5lz7O+XhhyqUAbGffi1J1c8P2eCgjHXL+FSlNN
 giOBTlPzj1quXz7HxCUrZy+ZLTBW5usDQvaoRdkbG5EcF0dxYUpLBTqdgif7f+ib2iAMX0H46iU
 fdGFX/QzEkfPvRMawZaz/GMgrLSkrGOZ56JH54bCwGhwMesb
X-Received: by 2002:a05:6512:400d:b0:5a2:a16f:9fce with SMTP id
 2adb3069b0e04-5a2c1f3cad9mr1671835e87.45.1775050128462; Wed, 01 Apr 2026
 06:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260326210532.379027-1-peterx@redhat.com>
 <20260326210532.379027-10-peterx@redhat.com>
In-Reply-To: <20260326210532.379027-10-peterx@redhat.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 1 Apr 2026 15:28:37 +0200
X-Gm-Features: AQROBzAH3d1LHnhriimeVTtS9sJe9D-84bS9hVEQNqdCcxWaiSxfgjDcevt21iw
Message-ID: <CAJqdLrrH_JhFamzJhObNPrHUMqxfJ1adE0UkJJgxv4jzvM0+dA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 09/11] vmstate: Implement
 VMS_ARRAY_OF_POINTER_AUTO_ALLOC
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x132.google.com
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
> Introduce a new flag, VMS_ARRAY_OF_POINTER_AUTO_ALLOC, for VMSD field.  I=
t
> must be used together with VMS_ARRAY_OF_POINTER.
>
> It can be used to allow migration of an array of pointers where the
> pointers may point to NULLs.
>
> Note that we used to allow migration of a NULL pointer within an array th=
at
> is being migrated. That corresponds to the code around vmstate_info_nullp=
tr
> where we may get/put one byte showing that the element of an array is NUL=
L.
>
> That usage is fine but very limited, it's because even if it will migrate=
 a
> NULL pointer with a marker, it still works in a way that both src and des=
t
> QEMUs must know exactly which elements of the array are non-NULL, so
> instead of dynamically loading an array (which can have NULL pointers), i=
t
> actually only verifies the known NULL pointers are still NULL pointers
> after migration.
>
> Also, in that case since dest QEMU knows exactly which element is NULL,
> which is not NULL, dest QEMU's device code will manage all allocations fo=
r
> the elements before invoking vmstate_load_vmsd().
>
> That's not enough per evolving needs of new device states that may want t=
o
> provide real dynamic array of pointers, like what Alexander proposed here
> with the NVMe device migration:
>
> https://lore.kernel.org/r/20260317102708.126725-1-alexander@mihalicyn.com
>
> This patch is an alternative approach to address the problem.
>
> Along with the flag, introduce two new macros:
>
>   VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8|32}_ALLOC()
>
> Which will be used very soon in the NVMe series.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Thanks, Peter!

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

also, I have rebased my patches
(https://github.com/mihalicyn/qemu/commits/nvme-live-migration/)
and retested everything, so:

Tested-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Kind regards,
Alex

> ---
>  include/migration/vmstate.h |  51 +++++++++++++-
>  migration/savevm.c          |  27 ++++++-
>  migration/vmstate.c         | 136 ++++++++++++++++++++++++++++++------
>  3 files changed, 190 insertions(+), 24 deletions(-)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 2e51b5ea04..d844b46e63 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -161,8 +161,21 @@ enum VMStateFlags {
>       * structure we are referencing to use. */
>      VMS_VSTRUCT           =3D 0x8000,
>
> +    /*
> +     * This is a sub-flag for VMS_ARRAY_OF_POINTER.  When this flag is s=
et,
> +     * VMS_ARRAY_OF_POINTER must also be set.  When set, it means array
> +     * elements can contain either valid or NULL pointers, vmstate core
> +     * will be responsible for synchronizing the pointer status, providi=
ng
> +     * proper memory allocations on the pointer when it is populated on =
the
> +     * source QEMU.  It also means the user of the field must make sure =
all
> +     * the elements in the array are NULL pointers before loading.  This
> +     * should also work with VMS_ALLOC when the array itself also needs =
to
> +     * be allocated.
> +     */
> +    VMS_ARRAY_OF_POINTER_AUTO_ALLOC =3D 0x10000,
> +
>      /* Marker for end of list */
> -    VMS_END =3D 0x10000
> +    VMS_END                         =3D 0x20000,
>  };
>
>  typedef enum {
> @@ -580,6 +593,42 @@ extern const VMStateInfo vmstate_info_qlist;
>      .offset     =3D vmstate_offset_array(_s, _f, _type*, _n),          \
>  }
>
> +/*
> + * For migrating a dynamically allocated uint{8,32}-indexed array of
> + * pointers to structures (with NULL entries and with auto memory
> + * allocation).
> + *
> + * _type: type of structure pointed to
> + * _vmsd: VMSD for structure _type (when VMS_STRUCT is set)
> + * _info: VMStateInfo for _type (when VMS_STRUCT is not set)
> + * start: size of (_type) pointed to (for auto memory allocation)
> + */
> +#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT8_ALLOC(\
> +    _field, _state, _field_num, _version, _vmsd, _type) {            \
> +    .name       =3D (stringify(_field)),                               \
> +    .version_id =3D (_version),                                        \
> +    .num_offset =3D vmstate_offset_value(_state, _field_num, uint8_t), \
> +    .vmsd       =3D &(_vmsd),                                          \
> +    .size       =3D sizeof(_type),                                     \
> +    .flags      =3D VMS_POINTER | VMS_VARRAY_UINT8 |                   \
> +                  VMS_ARRAY_OF_POINTER | VMS_STRUCT |                \
> +                  VMS_ARRAY_OF_POINTER_AUTO_ALLOC,                   \
> +    .offset     =3D vmstate_offset_pointer(_state, _field, _type *),   \
> +}
> +
> +#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT32_ALLOC(\
> +    _field, _state, _field_num, _version, _vmsd, _type) {             \
> +    .name       =3D (stringify(_field)),                                =
\
> +    .version_id =3D (_version),                                         =
\
> +    .num_offset =3D vmstate_offset_value(_state, _field_num, uint32_t), =
\
> +    .vmsd       =3D &(_vmsd),                                           =
\
> +    .size       =3D sizeof(_type),                                      =
\
> +    .flags      =3D VMS_POINTER | VMS_VARRAY_UINT32 |                   =
\
> +                  VMS_ARRAY_OF_POINTER | VMS_STRUCT |                 \
> +                  VMS_ARRAY_OF_POINTER_AUTO_ALLOC,                    \
> +    .offset     =3D vmstate_offset_pointer(_state, _field, _type *),    =
\
> +}
> +
>  #define VMSTATE_VARRAY_OF_POINTER_UINT32(_field, _state, _field_num, _ve=
rsion, _info, _type) { \
>      .name       =3D (stringify(_field)),                                =
    \
>      .version_id =3D (_version),                                         =
    \
> diff --git a/migration/savevm.c b/migration/savevm.c
> index f5a6fd0c66..765df8ce2d 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -869,8 +869,33 @@ static void vmstate_check(const VMStateDescription *=
vmsd)
>      if (field) {
>          while (field->name) {
>              if (field->flags & VMS_ARRAY_OF_POINTER) {
> -                assert(field->size =3D=3D 0);
> +                if (field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
> +                    /*
> +                     * Size must be provided because dest QEMU needs tha=
t
> +                     * info to know what to allocate
> +                     */
> +                    assert(field->size || field->size_offset);
> +                } else {
> +                    /*
> +                     * Otherwise size info isn't useful (because it's
> +                     * always the size of host pointer), detect accident=
al
> +                     * setup of sizes in this case.
> +                     */
> +                    assert(field->size =3D=3D 0 && field->size_offset =
=3D=3D 0);
> +                }
> +                /*
> +                 * VMS_ARRAY_OF_POINTER must be used only together with =
one
> +                 * of VMS_(V)ARRAY* flags.
> +                 */
> +                assert(field->flags & (VMS_ARRAY | VMS_VARRAY_INT32 |
> +                                       VMS_VARRAY_UINT16 | VMS_VARRAY_UI=
NT8 |
> +                                       VMS_VARRAY_UINT32));
>              }
> +
> +            if (field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
> +                assert(field->flags & VMS_ARRAY_OF_POINTER);
> +            }
> +
>              if (field->flags & (VMS_STRUCT | VMS_VSTRUCT)) {
>                  /* Recurse to sub structures */
>                  vmstate_check(field->vmsd);
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 47812eb882..9cd0a88ce9 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -153,6 +153,12 @@ static bool vmstate_ptr_marker_load(QEMUFile *f, boo=
l *load_field,
>          return true;
>      }
>
> +    if (byte =3D=3D VMS_MARKER_PTR_VALID) {
> +        /* We need to load the field right after the marker */
> +        *load_field =3D true;
> +        return true;
> +    }
> +
>      error_setg(errp, "Unexpected ptr marker: %d", byte);
>      return false;
>  }
> @@ -234,6 +240,67 @@ static bool vmstate_post_load(const VMStateDescripti=
on *vmsd,
>      return true;
>  }
>
> +/*
> + * Try to prepare loading the next element, the object pointer to be put
> + * into @next_elem.  When @next_elem is NULL, it means we should skip
> + * loading this element.
> + *
> + * Returns false for errors, in which case *errp will be set, migration
> + * must be aborted.
> + */
> +static bool vmstate_load_next(QEMUFile *f, const VMStateField *field,
> +                              void *first_elem, void **next_elem,
> +                              int size, int i, Error **errp)
> +{
> +    bool auto_alloc =3D field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
> +    void *ptr =3D first_elem + size * i, **pptr;
> +    bool load_field;
> +
> +    if (!(field->flags & VMS_ARRAY_OF_POINTER)) {
> +        /* Simplest case, no pointer involved */
> +        *next_elem =3D ptr;
> +        return true;
> +    }
> +
> +    /*
> +     * We're loading an array of pointers, switch to use pptr to make it
> +     * easier to read later
> +     */
> +    pptr =3D (void **)ptr;
> +
> +    /*
> +     * Some special cases use pointer markers: (1) _AUTO_ALLOC implies a
> +     * ptr marker will always exist, or (2) the element on destination i=
s
> +     * NULL, which expects the src to send a NULL-only marker.
> +     */
> +    if (auto_alloc || !*pptr) {
> +        if (!vmstate_ptr_marker_load(f, &load_field, errp)) {
> +            trace_vmstate_load_field_error(field->name, -EINVAL);
> +            return false;
> +        }
> +
> +        if (load_field) {
> +            /*
> +             * When reaching here, it means we received a non-NULL ptr
> +             * marker, so we need to populate the field before loading i=
t.
> +             *
> +             * NOTE: do not use vmstate_size() here, because we need the
> +             * object size, not entry size of the array.
> +             */
> +            assert(auto_alloc);
> +            *pptr =3D g_malloc0(field->size);
> +        } else {
> +            /* Clear the pointer to imply a skip */
> +            *next_elem =3D NULL;
> +            return true;
> +        }
> +    }
> +
> +    /* Move the cursor to the next element for loading */
> +    *next_elem =3D *pptr;
> +    return true;
> +}
> +
>  bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
>                         void *opaque, int version_id, Error **errp)
>  {
> @@ -279,27 +346,22 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDe=
scription *vmsd,
>              }
>
>              for (i =3D 0; i < n_elems; i++) {
> -                /* If we will process the load of field? */
> -                bool load_field =3D true;
> -                bool ok =3D true;
> -                void *curr_elem =3D first_elem + size * i;
> +                void *curr_elem;
> +                bool ok;
>
> -                if (field->flags & VMS_ARRAY_OF_POINTER) {
> -                    curr_elem =3D *(void **)curr_elem;
> -                    if (!curr_elem) {
> -                        /* Read the marker instead of VMSD itself */
> -                        if (!vmstate_ptr_marker_load(f, &load_field, err=
p)) {
> -                            trace_vmstate_load_field_error(field->name,
> -                                                           -EINVAL);
> -                            return false;
> -                        }
> -                    }
> +                ok =3D vmstate_load_next(f, field, first_elem, &curr_ele=
m,
> +                                       size, i, errp);
> +                if (!ok) {
> +                    return false;
>                  }
>
> -                if (load_field) {
> -                    ok =3D vmstate_load_field(f, curr_elem, size, field,=
 errp);
> +                if (!curr_elem) {
> +                    /* Implies a skip */
> +                    continue;
>                  }
>
> +                ok =3D vmstate_load_field(f, curr_elem, size, field, err=
p);
> +
>                  if (ok) {
>                      int ret =3D qemu_file_get_error(f);
>                      if (ret < 0) {
> @@ -397,6 +459,16 @@ static bool vmsd_can_compress(const VMStateField *fi=
eld)
>          return false;
>      }
>
> +    if (field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
> +        /*
> +         * This may involve two VMSD fields to be saved, one for the
> +         * marker to show if the pointer is NULL, followed by the real
> +         * vmstate object.  To make it simple at least for now, skip
> +         * compression for this one.
> +         */
> +        return false;
> +    }
> +
>      if (field->flags & VMS_STRUCT) {
>          const VMStateField *sfield =3D field->vmsd->fields;
>          while (sfield->name) {
> @@ -583,6 +655,12 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const V=
MStateDescription *vmsd,
>              int size =3D vmstate_size(opaque, field);
>              JSONWriter *vmdesc_loop =3D vmdesc;
>              bool is_prev_null =3D false;
> +            /*
> +             * When this is enabled, it means we will always push a ptr
> +             * marker first for each element saying if it's populated.
> +             */
> +            bool use_dynamic_array =3D
> +                field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
>
>              trace_vmstate_save_state_loop(vmsd->name, field->name, n_ele=
ms);
>              if (field->flags & VMS_POINTER) {
> @@ -603,14 +681,9 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const V=
MStateDescription *vmsd,
>                  }
>
>                  is_null =3D !curr_elem && size;
> -                use_marker_field =3D is_null;
> +                use_marker_field =3D use_dynamic_array || is_null;
>
>                  if (use_marker_field) {
> -                    /*
> -                     * If null pointer found (which should only happen i=
n
> -                     * an array of pointers), use null placeholder and d=
o
> -                     * not follow.
> -                     */
>                      inner_field =3D vmsd_create_ptr_marker_field(field);
>                  } else {
>                      inner_field =3D field;
> @@ -657,6 +730,25 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const V=
MStateDescription *vmsd,
>                      goto out;
>                  }
>
> +                /*
> +                 * If we're using dynamic array and the element is
> +                 * populated, save the real object right after the marke=
r.
> +                 */
> +                if (use_dynamic_array && curr_elem) {
> +                    /*
> +                     * NOTE: do not use vmstate_size() here because we w=
ant
> +                     * to save the real VMSD object now.
> +                     */
> +                    ok =3D vmstate_save_field_with_vmdesc(f, curr_elem,
> +                                                        field->size, vms=
d,
> +                                                        field, vmdesc_lo=
op,
> +                                                        i, max_elems, er=
rp);
> +
> +                    if (!ok) {
> +                        goto out;
> +                    }
> +                }
> +
>                  /* Compressed arrays only care about the first element *=
/
>                  if (vmdesc_loop && max_elems > 1) {
>                      vmdesc_loop =3D NULL;
> --
> 2.50.1
>

