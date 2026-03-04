Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348AEEB7EAC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 09:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxim4-0001nq-QT; Wed, 04 Mar 2026 04:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vxim1-0001kn-8p
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:44:10 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vxily-00004s-VJ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:44:08 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-38a2544b52bso23890071fa.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 01:44:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772617445; cv=none;
 d=google.com; s=arc-20240605;
 b=cywX5e3ytP5wgH+Zexhnfc8nOFkJoOJGQ9f6Vz9FQW0Njm2qROUGR5pRMa2If6u3BM
 913F/Eyu4svcs4fW3tqCr7sndlRxo4fdKpbPpTe8B/FpjEDMRS2FABqV8SAmfaEa+KnB
 fYiuaN2S4OaLDvOMqAV55Mt64zehCS3iD8brGpYGTPxJ8ls08M1ZQlx/Ny/EAlUorHwG
 6Z/9y+hiANMG/7It5xxlXpv0PICxDrY9MOOBLheylipVJQZS7SIVZAYXehABZpi+nt+9
 Ev98IT8sF96IcF0t3j0afjVwNZpNb873ugOJt4LvTuLlvqwl1hJyENvej5vg+OFntQVv
 dytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7Ne5NgbMDf+M3J7+4FxHxF/NrMNCqB8HtZSDmJ0RYS8=;
 fh=/sr5iJO/HVyIXQgA+DkOdUcKrP7sTctbjJN6vR+WNMo=;
 b=OxrbX8BJ0O7oPI/XPG/C0T90mDR2rZzJXJGL4CR4QCBXEuKVhuWniK9EZ+PyW2GqUC
 mt2qnWBidB9ByU2t2xO4MfKLa0O1cu6Ay2sUZlNBl25Ma3VJYIwyQDrXZz+2MGvANDIK
 kzA6++3xxl4R4+zJ1UmDxbT+4QRPnFIR93sTa8dWud4BSoHNpOmx9pA+R5Wxc9HODdP8
 iBj14Lza0N/7crg8ALuhgyrOWVPh8mKU9mI7W7brr/Q80S+4rox1mMLYOtGZawozUVVr
 /dtDFfwn9EheyBPFAi0oqkhBVFud+HWSvIPDPafjZitL08VJstcuh809ytit806I1Km0
 85ZA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1772617445; x=1773222245; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Ne5NgbMDf+M3J7+4FxHxF/NrMNCqB8HtZSDmJ0RYS8=;
 b=YHn0mu141de8Sba0DwY9ymVIajqR7EFYUiruEng4c8y9EJuGAXmcxmkH44vsf/ktZa
 pqXxaNxuQ+CmSoM28EDxKmklmqdSMINg08qNXKwvS1VXHKle+OBABmZ396htWdRlgULP
 /Vd03avv68sn6Nqty+bJp+phc/kNIqQGMCm08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772617445; x=1773222245;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7Ne5NgbMDf+M3J7+4FxHxF/NrMNCqB8HtZSDmJ0RYS8=;
 b=mIXqQt8T+Vfahd51bs4MHNyTqLKKVWt0Ky/bQa7tE0yBMLXiwFtT6kfQcpxvgGLY0U
 kP0tJdTsZM9wMJkYtBo0MWd5yRqQSSlRUYB8BDTmz2T/+ogrr5H0JZWDVbICmOcMp5zL
 qWIQb1aS1TCzXRTA6/lYPeNscssFvcoKWeOc4iMmJIxkHqzF9egfBCtcHIfmVfX8ZiBj
 fD3y3FdfVW9guGT1Xl3WSm0lgPtaebhfDHrOEerGJXw0bPv8zz8B/nkVr/y2xZVi6jki
 4GblGwPO4yBXOM6GUegH9ePI/hi/09CRPwbiBnCWyzfuoKnvkx1jwjdbNF5JXF5rEK6Q
 WmYQ==
X-Gm-Message-State: AOJu0Yx3zZMHJmdOAY9MNlfRZ3wm1LJnFfrwA/8CTjxm2kBVY1xYa2t7
 aXkQV+J6rWzTpZwBPPxzOCVp7Qt41YdBVxTqvxsNpF1+KjP3XSfd6Tq2DnncUtkkwmLdUyb3JO+
 2YUSe9rUpCLnZcvaIjHejv5IHs8S9eBXsl9ppJqyl7A==
X-Gm-Gg: ATEYQzysJVk2E0XAEYGUEmqeU0xznZyqpRlrG7ILap2z+Pl2T5TxgH+plRzrVG2nAvh
 k1ZPF47bLEHIstjIbhZrn6GS0Zh7z/jLZLS44S3rxrHeh371UU0aO+sIYcKfJ02WmRYRtmXvIby
 +uCRpot+JIMJ4YF1JC8rB9sV8pZCrjhfdFBH1cGxs1P7PKVCKp0ufdyd4R3XLsWiMkylyxRufXa
 gI/A/2i/F82gBh46FgLrxbgROl4n5by3zkrtnLard4WdI4XojBKuw8XkPEd4WpzQsz1MHpRrw8S
 Q/gUM8zEx6Ike8+eiVA+/b/UerJCuxdF7hy6W1c=
X-Received: by 2002:a05:651c:995:b0:389:f5b4:46cc with SMTP id
 38308e7fff4ca-38a2c564858mr12025861fa.4.1772617444541; Wed, 04 Mar 2026
 01:44:04 -0800 (PST)
MIME-Version: 1.0
References: <20260217152517.271422-1-alexander@mihalicyn.com>
 <20260217152517.271422-4-alexander@mihalicyn.com> <aaYFbKP8o6A2QY8D@x1.local>
In-Reply-To: <aaYFbKP8o6A2QY8D@x1.local>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 4 Mar 2026 10:43:53 +0100
X-Gm-Features: AaiRm525YEjsjzOsOpvWGY2VsetTuL4KVfNB6iryJcz6vdoDlFI1E6kudtuP-dU
Message-ID: <CAJqdLrqucwgVJA3bFu5ApayGkKiheCxO_tWJnbvpVPpRmrVAfQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] migration: add
 VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_ALLOC
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Jesper Devantier <foss@defmacro.it>, 
 Klaus Jensen <its@irrelevant.dk>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=alexander@mihalicyn.com; helo=mail-lj1-x231.google.com
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

Am Mo., 2. M=C3=A4rz 2026 um 22:47 Uhr schrieb Peter Xu <peterx@redhat.com>=
:
>
> On Tue, Feb 17, 2026 at 04:25:16PM +0100, Alexander Mikhalitsyn wrote:
> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >
> > Add VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_ALLOC, which
> > helps to save/restore a dynamic array of pointers to
> > structures.

Dear Peter,

>
> Sorry for the late response.

No problem at all, thanks for reviewing ;)

>
> >
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion=
.io>
> > ---
> >  include/migration/vmstate.h | 21 +++++++++
> >  migration/vmstate-types.c   | 88 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 109 insertions(+)
> >
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index 89f9f49d20a..bc6495a7f67 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -265,6 +265,7 @@ extern const VMStateInfo vmstate_info_bitmap;
> >  extern const VMStateInfo vmstate_info_qtailq;
> >  extern const VMStateInfo vmstate_info_gtree;
> >  extern const VMStateInfo vmstate_info_qlist;
> > +extern const VMStateInfo vmstate_info_ptrs_array_entry;
> >
> >  #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
> >  /*
> > @@ -537,6 +538,26 @@ extern const VMStateInfo vmstate_info_qlist;
> >      .offset     =3D vmstate_offset_array(_s, _f, _type*, _n),         =
 \
> >  }
> >
> > +/*
> > + * For migrating a dynamically allocated uint32-indexed array
> > + * of pointers to structures (with NULL entries and with auto memory a=
llocation).
> > + *
> > + * _type: type of structure pointed to
> > + * _vmsd: VMSD for structure
> > + * start: size of structure pointed to (for auto memory allocation)
> > + */
> > +#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_ALLOC(_field, _state, _fie=
ld_num, _version, _vmsd, _type) { \
> > +    .name       =3D (stringify(_field)),                              =
  \
> > +    .version_id =3D (_version),                                       =
  \
> > +    .num_offset =3D vmstate_offset_value(_state, _field_num, uint32_t)=
, \
> > +    .info       =3D &vmstate_info_ptrs_array_entry,                   =
  \
>
> I wonder if we need this hard-coded new info structure for this, more
> below.
>
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
> > +
> >  #define VMSTATE_VARRAY_OF_POINTER_UINT32(_field, _state, _field_num, _=
version, _info, _type) { \
> >      .name       =3D (stringify(_field)),                              =
      \
> >      .version_id =3D (_version),                                       =
      \
> > diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> > index 89cb2114721..3335377cd07 100644
> > --- a/migration/vmstate-types.c
> > +++ b/migration/vmstate-types.c
> > @@ -942,3 +942,91 @@ const VMStateInfo vmstate_info_qlist =3D {
> >      .get  =3D get_qlist,
> >      .put  =3D put_qlist,
> >  };
> > +
> > +static int put_ptrs_array_entry(QEMUFile *f, void *ppv, size_t unused_=
size,
> > +                                const VMStateField *field, JSONWriter =
*vmdesc)
> > +{
> > +    const VMStateDescription *vmsd =3D field->vmsd;
> > +    int ret;
> > +    Error *local_err =3D NULL;
> > +    void *pv;
> > +
> > +    /*
> > +     * (ppv) is an address of an i-th element of a dynamic array.
> > +     *
> > +     * (ppv) can not be NULL unless we have some regression/bug in
> > +     * vmstate_save_state_v(), because it is result of pointer arithem=
ic like:
> > +     * first_elem + size * i.
> > +     */
> > +    if (ppv =3D=3D NULL) {
> > +        error_report("vmstate: put_ptrs_array_entry must be called wit=
h ppv !=3D NULL");
> > +        return -EINVAL;
> > +    }
> > +
> > +    /* get a pointer to a structure */
> > +    pv =3D *(void **)ppv;
>
> Here IIUC it's almost what VMS_ARRAY_OF_POINTER should do.  Could we
> declare the vmsd with VMS_ARRAY_OF_POINTER so as to save this open-coded
> dereference of pointer?

Yes, this is something I tried to do in the first place, but this
didn't work for my use-case.

Let me explain what I'm doing in detail. I have the following structure:

typedef struct NvmeCtrl {
     ...
     uint32_t num_queues; // < MAX number of elements in sq
     NvmeSQueue **sq;
     ...
} NvmeCtrl;

Suppose we have variable n with type NvmeCtrl *.

// somewhere early during initialization of QEMU device:
n->sq =3D g_new0(NvmeSQueue *, n->num_queues);

// then in runtime (depending on what *guest* wants) we might create
some sq[i], e.g:
NvmeSQueue *sq;
sq =3D g_malloc0(sizeof(*sq));
n->sq[3] =3D sq;

please, note that n->sq[0], n->sq[1], n->sq[2] can still be NULL. So,
we allow holes in that array.

What I found is that if I raise VMS_ARRAY_OF_POINTER flag on VMStateField, =
then
migration code in vmstate_load_state() will expect to see so-called
"fake nullptr field" (vmsd_create_fake_nullptr_field() function call).

But this is a problem, because our array at the time of
vmstate_load_state() looks like (N =3D=3D NULL):
0     1     2     3     4     5
N    N    N     N     N    N

while after vmstate_load_state() I expect it to be:
0     1     2     3     4     5
N    N     N   SQ   N    N

so, somebody should allocate memory for sq[3] and load data from image
into that memory.

Probably, it makes sense to somehow implement a combination of
VMS_ARRAY_OF_POINTER and  VMS_ALLOC,
but I tried to be as less invasive as I can and decided to introduce a
new kind of VMStateField instead.

>
> > +
> > +    if (pv =3D=3D NULL) {
> > +        /* write a mark telling that there was a NULL pointer */
> > +        qemu_put_byte(f, false);
> > +        return 0;
> > +    }
> > +
> > +    /* if pointer is not NULL, dump the structure contents with help o=
f vmsd */
> > +    qemu_put_byte(f, true);
> > +    ret =3D vmstate_save_state(f, vmsd, pv, vmdesc, &local_err);
>
> This looks really like VMS_STRUCT, except that it also tries to detect if
> the pointer is NULL, then save some dumps.

Precisely, I'm mimicking behavior of VMS_STRUCT | VMS_ALLOC and
VMS_ARRAY_OF_POINTER here.

>
> Is it feasible to make both queues to always be available so as to reuse
> VMS_STRUCT?  Or is it intentional here to avoid dumping queues where the
> pointer is NULL?

By "available" you mean to always allocate memory for all n->sq[i] elements=
?

>
> Even if for the latter, I wonder if we can have better way to do it.  For
> example, if we can integrate this directly into vmstate_save/load_state()
> to support some new flag, VMS_ARRAY_OF_POINTER_DYNAMIC, then we can decla=
re
> some more "official" way to say some pointer of an dynamic array is NULL.
>

Yeah, I thought about this too, I believe this is a great idea. But
taking into account that
this is my first contribution to QEMU and I'm learning code around I tried =
to be
very conservative and don't change any generic code ;-)

I'm happy to do this work in -v3 if you would like me to do it and
guide me a bit (I have just send a v2 series,
but there was no changes in migration API part, only NVMe specifics).

Kind regards,
Alex

> Thanks,
>
> > +    if (ret) {
> > +        error_report_err(local_err);
> > +        return ret;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int get_ptrs_array_entry(QEMUFile *f, void *ppv, size_t unused_=
size,
> > +                                const VMStateField *field)
> > +{
> > +    int ret =3D 0;
> > +    Error *local_err =3D NULL;
> > +    const VMStateDescription *vmsd =3D field->vmsd;
> > +    /* size of structure pointed to by elements of array */
> > +    size_t size =3D field->start;
> > +
> > +    if (ppv =3D=3D NULL) {
> > +        error_report("vmstate: get_ptrs_array_entry must be called wit=
h ppv !=3D NULL");
> > +        return -EINVAL;
> > +    }
> > +
> > +    /*
> > +     * We start from a clean array, all elements must be NULL, unless
> > +     * something we haven't prepared for has changed in vmstate_save_s=
tate_v().
> > +     * Let's check for this just in case.
> > +     */
> > +    if (*(void **)ppv !=3D NULL) {
> > +        error_report("vmstate: get_ptrs_array_entry must be called wit=
h *ppv =3D=3D NULL");
> > +        return -EINVAL;
> > +    }
> > +
> > +    if (qemu_get_byte(f)) {
> > +        void *pv;
> > +
> > +        /* allocate memory for structure */
> > +        pv =3D g_malloc0(size);
> > +        ret =3D vmstate_load_state(f, vmsd, pv, vmsd->version_id, &loc=
al_err);
> > +        if (ret) {
> > +            error_report_err(local_err);
> > +            g_free(pv);
> > +            return ret;
> > +        }
> > +
> > +        *(void **)ppv =3D pv;
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> > +const VMStateInfo vmstate_info_ptrs_array_entry =3D {
> > +    .name =3D "ptrs_array_entry",
> > +    .get  =3D get_ptrs_array_entry,
> > +    .put  =3D put_ptrs_array_entry,
> > +};
> > --
> > 2.47.3
> >
>
> --
> Peter Xu
>

