Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253A0FCD0A6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nhZ-0002Fy-Bh; Wed, 18 Mar 2026 06:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nhV-0002Fh-7Z
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:00:30 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nhO-0002dt-Tn
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:00:26 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5a12cd0bd79so8361600e87.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773828016; cv=none;
 d=google.com; s=arc-20240605;
 b=MLzyP2Gb0E+uCRgZZtXKfMCU0VvJtcqJZhsyStkwiXWrDDDp/lhrFDvLL6SIB1kdbQ
 sGp+7OrE/LIIpsOJiGrGlJRvmT0PDWdS2aezwai/+0CDGILo8tWAeZ2dHijTwIfHwx+/
 6kGQ7THuE9Uh6cvqRZPuJaivDYc+KrpZBcdtWXMDk3wY8a30AA4XY97ZLYRxkCcC0MZ5
 kb0X5msvnJbLlFyLwpvajVP8+FWVW22R2ARPLCPKFEEEH2fTDLp4gXy27SAUlQqY4/oe
 5NDlFjd+3UVpG301Js6+YSNCiQ63920iX/ks4vUr900H6ekzfXdSX1Kc5BCiJJk2krDH
 TmBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mReYDUlDHVAJsaARflZvyE57nFHdP2bSUUdTljjxG6k=;
 fh=D9TiOsAcOSpRlHrkA38ELZyIVSvZmg48LLzTtJLYv+0=;
 b=beijw5QlACq2w0RlJ4ukwxppd7Ls78po9NjRHdo45rZKshZ9/Zhs4a+E2Blv60n+rn
 OEkTPzpjGuC7Yx+eEY0yqvy/J3AtiYrZkNaVC3FtvZ/PxQHWNcBjSREZ/ejXVYSC/oFh
 PnnM2yRwJAZQ9k/H4If1QvIC7DygFBW6rxI4+4zft+MgtJjOvT0taB9zUsCnYsQbpUxc
 95yuvSvD+Lmlz+oZLQhpWPndaXWYr17b753OLgFJ0YVd5B+ABeqpsDLYwF+8vYAoBqzG
 5j+I3SVjeNpITC3pCwTHZdsnvqD5B2vXPAPETXRl9IiAWNNgNMbARwY5aANkUMMWSSTz
 1I2A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773828016; x=1774432816; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mReYDUlDHVAJsaARflZvyE57nFHdP2bSUUdTljjxG6k=;
 b=cuj1lGbQ0jJcaiGo1v19AVd6FgBHuNhudI+Oi2KHTs7PUQv1WUm7jqK7RGAl+8C8yV
 LjUuh4GDVgmOEomabGW+nszd7mNNBxTpbSL3C3HCbfkCpcCcbocbrougpDasUaRPMDZC
 Lzwm1nD2Sry/KTCXftHC8ZOGXqzt5yTrLZR+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773828016; x=1774432816;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mReYDUlDHVAJsaARflZvyE57nFHdP2bSUUdTljjxG6k=;
 b=ZVLGTttnRvDQJPheOQvm/2pPPLYMpLnl7JWVy83bjTcKdmUvK5xtsHrlOKc1ZJ72Iq
 YIylwOnaLI5bH0l4EWTtH8tAX4fuxbPXgDKIQ8Y6BYmHvkh/3hkAzVFcqUuazKAiBAa/
 xOsf8uvFs5/kf1V895NISEKGN5tsOkqBxF1GADdBiTkDme+bPBRtBkbKj0pVjkz1gpE1
 b+WuPmFUnrHcZJLjtwjA9M6h6C9wOaZvTB2K2PaYQhyVbsp7jdq89KW9rU/mDnoV1b4o
 kjWmOq8fpv5Ed0uVps0xN/o3WNXnBnfRtxPhBH4SDSinPXHpPTnjYJs8frCmFzeDJdmC
 3Y8w==
X-Gm-Message-State: AOJu0Yz7JT/FTfSSRUEqf0Picf1jWxxabU0gwI0j2m3Y/WLsBuN+FD1l
 Q8Gq7bQtBLuhLjN010RzXV2SoL13cTkypRk/padgmWyGuI+CmPOH+58P/N5D+VfnNJn9R5y0I+/
 PQ7F2gyV/XkRWR4rHhWmgxUxgPgM/4OzHbR4eRctnsq5sD26soK1xFbDu1w==
X-Gm-Gg: ATEYQzxElgspHViUVRHDECTkAWTp+BwWDrPrHizg/Hg1m/jWPqIir8byRtunt16xFIw
 VEGtfGJLyHyTn/RBB9MJ6cy0Y+00FB3RK7cNyWbXY5XAB8+2jNIjpv51hQJ1sWaNWvj6XSEfcK6
 KacSUKXmfx3wTvNNfeOLVTMckjYiTFeAoMlcaVt6qqSNrQxmdQ/IM9oeLibf7UjfX19Oyjn4AIl
 EmV0iPz4C/Oy87gOI4KVuG5eBv8Ou+d+E4Sz3kWqv2XPOZXb/E5FKUXbobwij6sHJZzirvVCyfC
 QPqqPXCRvak1FIlpWW3rGTU1o2CsoXkYW0MeJ6MeJOp91tX4/A==
X-Received: by 2002:a05:6512:63c3:20b0:5a1:44e5:6ec with SMTP id
 2adb3069b0e04-5a2796b2e47mr753543e87.35.1773828014151; Wed, 18 Mar 2026
 03:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260317232332.15209-1-peterx@redhat.com>
 <20260317232332.15209-10-peterx@redhat.com>
In-Reply-To: <20260317232332.15209-10-peterx@redhat.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 18 Mar 2026 11:00:02 +0100
X-Gm-Features: AaiRm536RxOA_r6b4HHoIl2diyMzezIPAWMUcurlLepYeA3ip_RkLNNcyfAF2bs
Message-ID: <CAJqdLrpXBDJ4SxCBjiO6wtQebK+4N8Z-2Yj2_A7J8PjGtha34Q@mail.gmail.com>
Subject: Re: [PATCH RFC 09/10] vmstate: Implement
 VMS_ARRAY_OF_POINTER_AUTO_ALLOC
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x12b.google.com
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

Amazing, thank you, Peter!

Except small nitpicks I've left as inline comment in this patch, it is LGTM=
.

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Tested-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Also, I've rebased my NVMe series on top and tested everything
locally. No regressions were found.

Kind regards,
Alex

> ---
>  include/migration/vmstate.h |  49 ++++++++++++++++-
>  migration/savevm.c          |  31 ++++++++++-
>  migration/vmstate.c         | 101 ++++++++++++++++++++++++++++++++----
>  3 files changed, 169 insertions(+), 12 deletions(-)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 2e51b5ea04..70bebc60ed 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -161,8 +161,19 @@ enum VMStateFlags {
>       * structure we are referencing to use. */
>      VMS_VSTRUCT           =3D 0x8000,
>
> +    /*
> +     * This is a sub-flag for VMS_ARRAY_OF_POINTER, so VMS_ARRAY_OF_POIN=
TER
> +     * must be set altogether.  When set, it means array elements can
> +     * contain either valid or NULL pointers, vmstate core will sync it
> +     * between the two QEMU instances via the stream protocol.  When it'=
s a
> +     * valid pointer, the vmstate core will be responsible to do the pro=
per
> +     * memory allocations.  It also means user of this flag must prepare
> +     * the array to be all NULLs otherwise memory may leak.
> +     */
> +    VMS_ARRAY_OF_POINTER_AUTO_ALLOC =3D 0x10000,
> +
>      /* Marker for end of list */
> -    VMS_END =3D 0x10000
> +    VMS_END                         =3D 0x20000,
>  };
>
>  typedef enum {
> @@ -580,6 +591,42 @@ extern const VMStateInfo vmstate_info_qlist;
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

nit: probably these are outdated now

> + * start: size of (_type) pointed to (for auto memory allocation)

nit: I guess we need to drop this line about "start" field.

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
> index f5a6fd0c66..34223de818 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -869,8 +869,37 @@ static void vmstate_check(const VMStateDescription *=
vmsd)
>      if (field) {
>          while (field->name) {
>              if (field->flags & VMS_ARRAY_OF_POINTER) {
> -                assert(field->size =3D=3D 0);
> +                if (VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
> +                    /*
> +                     * Size must be provided because dest QEMU needs tha=
t
> +                     * info to know what to allocate
> +                     */
> +                    assert(field->size || field->size_offset);
> +                } else {
> +                    /*
> +                     * Otherwise size info isn't useful (because it's
> +                     * always the size of host pointer), enforce acciden=
tal
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
> +            /*
> +             * When VMS_ARRAY_OF_POINTER_ALLOW_NULL is used, we must hav=
e
> +             * VMS_ARRAY_OF_POINTER set too.
> +             */
> +            if (field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
> +                assert(field->flags & VMS_ARRAY_OF_POINTER);
> +            }
> +
>              if (field->flags & (VMS_STRUCT | VMS_VSTRUCT)) {
>                  /* Recurse to sub structures */
>                  vmstate_check(field->vmsd);
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index d65fc84dfa..7d7d9c7e18 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -153,6 +153,12 @@ static bool vmstate_ptr_marker_load(QEMUFile *f, boo=
l *load_field,
>          return true;
>      }
>
> +    if (byte =3D=3D VMS_MARKER_PTR_VALID) {
> +        /* We need to load this field right after the marker */
> +        *load_field =3D true;
> +        return true;
> +    }
> +
>      error_setg(errp, "Unexpected ptr marker: %d", byte);
>      return false;
>  }
> @@ -234,6 +240,22 @@ static bool vmstate_post_load(const VMStateDescripti=
on *vmsd,
>      return true;
>  }
>
> +
> +/*
> + * If we will use a ptr marker in the stream for a field?  Two use cases=
:
> + *
> + * (1) When used with VMS_ARRAY_OF_POINTER_ALLOW_NULL, it must always be
> + *     present to imply the population status of the pointer.
> + *
> + * (2) When used with normal VMSD array fields, only emit a null ptr mar=
ker
> + *     if the pointer is NULL.
> + */
> +static inline bool
> +vmstate_use_marker_field(void *ptr, int size, bool dynamic_array)
> +{
> +    return (!ptr && size) || dynamic_array;
> +}
> +
>  bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
>                         void *opaque, int version_id, Error **errp)
>  {
> @@ -271,6 +293,12 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDes=
cription *vmsd,
>              void *first_elem =3D opaque + field->offset;
>              int i, n_elems =3D vmstate_n_elems(opaque, field);
>              int size =3D vmstate_size(opaque, field);
> +            /*
> +             * When this is enabled, it means we will always push a ptr
> +             * marker first for each element saying if it's populated.
> +             */
> +            bool use_dynamic_array =3D
> +                field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
>
>              vmstate_handle_alloc(first_elem, field, opaque);
>              if (field->flags & VMS_POINTER) {
> @@ -282,18 +310,37 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDe=
scription *vmsd,
>                  /* If we will process the load of field? */
>                  bool load_field =3D true;
>                  bool ok =3D true;
> -                void *curr_elem =3D first_elem + size * i;
> +                bool use_marker_field;
> +                void *curr_elem_p =3D first_elem + size * i;
> +                void *curr_elem =3D curr_elem_p;
>
>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
> -                    curr_elem =3D *(void **)curr_elem;
> +                    curr_elem =3D *(void **)curr_elem_p;
>                  }
>
> -                if (!curr_elem && size) {
> -                    /* Read the marker instead of VMSD itself */
> +                use_marker_field =3D vmstate_use_marker_field(curr_elem,=
 size,
> +                                                            use_dynamic_=
array);
> +                if (use_marker_field) {
> +                    /* Read the marker instead of VMSD first */
>                      if (!vmstate_ptr_marker_load(f, &load_field, errp)) =
{
>                          trace_vmstate_load_field_error(field->name, -EIN=
VAL);
>                          return false;
>                      }
> +
> +                    if (load_field) {
> +                        /*
> +                         * When reaching here, it means we received a
> +                         * non-NULL ptr marker, so we need to populate t=
he
> +                         * field before loading it.
> +                         *
> +                         * NOTE: do not use vmstate_size() here, because=
 we
> +                         * need the object size, not entry size of the
> +                         * array.
> +                         */
> +                        curr_elem =3D g_malloc0(field->size);
> +                        /* Remember to update the root pointer! */
> +                        *(void **)curr_elem_p =3D curr_elem;
> +                    }
>                  }
>
>                  if (load_field) {
> @@ -397,6 +444,16 @@ static bool vmsd_can_compress(const VMStateField *fi=
eld)
>          return false;
>      }
>
> +    if (field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC) {
> +        /*
> +         * This may involve two VMSD fields to be dumped, one for the
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
> @@ -578,6 +635,12 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const V=
MStateDescription *vmsd,
>              int size =3D vmstate_size(opaque, field);
>              JSONWriter *vmdesc_loop =3D vmdesc;
>              bool use_marker_field_prev =3D false;
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
> @@ -596,13 +659,10 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const =
VMStateDescription *vmsd,
>                      curr_elem =3D *(void **)curr_elem;
>                  }
>
> -                use_marker_field =3D !curr_elem && size;
> +                use_marker_field =3D vmstate_use_marker_field(curr_elem,=
 size,
> +                                                            use_dynamic_=
array);
> +
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
> @@ -652,6 +712,27 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const V=
MStateDescription *vmsd,
>                      goto out;
>                  }
>
> +                /*
> +                 * If we're using dynamic array and the element is
> +                 * populated, dump the real object right after the marke=
r.
> +                 */
> +                if (use_dynamic_array && curr_elem) {
> +                    /*
> +                     * NOTE: do not use vmstate_size() here because we w=
ant
> +                     * to dump the real VMSD object now.
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
> +                        error_prepend(errp, "Save of field %s/%s failed:=
 ",
> +                                      vmsd->name, field->name);
> +                        goto out;
> +                    }
> +                }
> +
>                  /* Compressed arrays only care about the first element *=
/
>                  if (vmdesc_loop && vmsd_can_compress(field)) {
>                      vmdesc_loop =3D NULL;
> --
> 2.50.1
>

