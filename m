Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E1EEEF331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 08:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy4UZ-0003FC-HV; Thu, 05 Mar 2026 03:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vy4UR-0003Cl-7F
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 03:55:29 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vy4UO-0006Fw-GY
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 03:55:26 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5a1330ac6c3so447346e87.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 00:55:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772700919; cv=none;
 d=google.com; s=arc-20240605;
 b=If5Y3e1Y6D6m5nX7jZM+Kt0YU3avgSEzBsLRCzPXOm/ouf8J/2RDKvlUY57sz/wO6n
 F2nRPmmAXK2B6TX4FyR8GmB59krYIai3+OUOdQCjoAjQTknG2wBBuHl0Iqa7BgQE2PQV
 X8+zSsqFx7ZXaDpjEx77DG7pJaZqlqhC8Np94o084Xc7e6JQGcupGlEJir8pfMrvpskc
 KeaUqmYFXfprr3jwJ4X12riED+gN+/XQEVd6wlvP9Kgb53FhVMo56Np5s+vKWTrTG4yk
 Sc4OVMfsiMfqeGyUsLSb+jSSxKY3im3P3MVEn2V7V1aMlXuDveCfEiK0XRn0sDf8iQyl
 to4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MWDiRBeLgfiuyR7YorpEiX5JIXos8K9BkhFfIzDIHVE=;
 fh=/sr5iJO/HVyIXQgA+DkOdUcKrP7sTctbjJN6vR+WNMo=;
 b=Ln0ry/mUmpBsckYsKb0tO5rcu6ExKa3bqZt0fxFJRLX4zxcJ+akM39kvANzPv8JpAI
 UHNHSn9DEKD3JWY//xIZdFIM7FDaruoic0CAnUs6Ui03KaKkU5U+9fSFOha5bnbppaid
 DOq9Va45mDiQHh9j4d0/UEeZIwPNYHL920ljWNVrQFQJAoQOi+cfoLmoG3PBCuJ0+4O+
 f5Qv1byvsrWkdUDPkbRQ+3/xh09cgucfJ7huLWIxrPsjRXl3LfpBY96WPtalB3TrF5NS
 9hq0LxAl5rVuRaGe8fFVnYH2BrTv3FX0JDwH2hEFfJGZIEBqgKbLJ4kuPLKKATa1a/sw
 cGxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1772700919; x=1773305719; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MWDiRBeLgfiuyR7YorpEiX5JIXos8K9BkhFfIzDIHVE=;
 b=NX3Y/WZUeM/bZazwifO5XpPa+g+A6Bs4kWYb0dgB/8/lk+jcEnVJwLDPciSwOGmARA
 1Fvh+RI0GPNxr6WZbsvRINI2icNBnkRAKWx4rr3+Poq/O6eiTYt+qeC8cDRJtBjkBqr7
 iZV09XBl5allnSBt6j2QcVw5wrd4Y49x1zngI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772700919; x=1773305719;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MWDiRBeLgfiuyR7YorpEiX5JIXos8K9BkhFfIzDIHVE=;
 b=uoLJuLXPnaiHzEorg+8zdExjpSrrdBkPyMpSZR78TU7fT68HkB6+vMhy1zUBkuNGDs
 x4TDs4mo9r7Ut+jZKwCs30WGZyESl0Ya1kwGPv2+cqVQJuQYMXjAwYlmAij1w3s2gtFV
 oteYmnVdAlxs48cdgFqZfwjlT7uiprJnwMuayHpp8Ze29alDISAsS5EnirY6J+OLVTLn
 uaZnWWaGLlw9psX4qUfiUD3tnQcmrC+AmaGD5BVfHbNoDqp/HLjkfaDuqjGgnDd+GjA5
 UKkxlnxlWkFZ53jhDVBitscVpWmkIfpLX54PhgxSuYPZ15lcoUO0CHbS6ronbJ2tnz5s
 Avrw==
X-Gm-Message-State: AOJu0YylrWeCSYR55VmIHERRPhOGAfqOGh43dILJrRMaeVOj1AyB6/bL
 cW9zwDtyPOPSGIbCsDPu/eqR/1PSIyb6N80AZNui1wa+wi5OO8l+HcGvbIuC7hZleKJ8lM+KOjF
 vsNpWAHNR3fnzrhhLN7PTocCzSaajuqOalJkc94OC1Q==
X-Gm-Gg: ATEYQzwOaJ7+Eqt7DSACoCL2QonmZiVWVPDdWG+PEtBNWL2Wr7bxyKHEkocxhWtOz+j
 sD3vfkO9bwb4e2gl7LGyWPOD4GxBMZWAyMitvKOZm8W10hUon6aNBuEQpck4jvL7pgKuwwWF6+c
 60pl2aReRPonBa63LZHzizAk4uv+HYp4BbXfCxPYuT5btHYEYK77WfdFN34wtQu/yCCvFhNEu3P
 jjP9T7Oqq03QjXZlmFLq/p2Yx5UNYzS4vi7z9oH8EniuDDuQXl/UtkXs+hT1ln3avTZGwq3vS9Q
 xOzvL75KA3tuSPkbquKHLeY7mVF6Grx2dTffz0g=
X-Received: by 2002:a05:6512:1253:b0:5a1:3539:1181 with SMTP id
 2adb3069b0e04-5a1353912bbmr256733e87.20.1772700918320; Thu, 05 Mar 2026
 00:55:18 -0800 (PST)
MIME-Version: 1.0
References: <20260217152517.271422-1-alexander@mihalicyn.com>
 <20260217152517.271422-4-alexander@mihalicyn.com> <aaYFbKP8o6A2QY8D@x1.local>
 <CAJqdLrqucwgVJA3bFu5ApayGkKiheCxO_tWJnbvpVPpRmrVAfQ@mail.gmail.com>
 <aahgfLaybfjOpsX1@x1.local>
In-Reply-To: <aahgfLaybfjOpsX1@x1.local>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 5 Mar 2026 09:55:05 +0100
X-Gm-Features: AaiRm51kNDU24MXDzWMhi-39lz19iL4GavqHMBVrIqDndgHlSoxrOWIgCKNmaxo
Message-ID: <CAJqdLrrKK-pTzk+Qm_45p9A6DRgj4VbFzSb6vFtJTkpN3UaFpg@mail.gmail.com>
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

Am Mi., 4. M=C3=A4rz 2026 um 17:40 Uhr schrieb Peter Xu <peterx@redhat.com>=
:
>
> On Wed, Mar 04, 2026 at 10:43:53AM +0100, Alexander Mikhalitsyn wrote:
> > Am Mo., 2. M=C3=A4rz 2026 um 22:47 Uhr schrieb Peter Xu <peterx@redhat.=
com>:
> > >
> > > On Tue, Feb 17, 2026 at 04:25:16PM +0100, Alexander Mikhalitsyn wrote=
:
> > > > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > > >
> > > > Add VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_ALLOC, which
> > > > helps to save/restore a dynamic array of pointers to
> > > > structures.
> >
> > Dear Peter,
> >
> > >
> > > Sorry for the late response.
> >
> > No problem at all, thanks for reviewing ;)
> >
> > >
> > > >
> > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfu=
sion.io>
> > > > ---
> > > >  include/migration/vmstate.h | 21 +++++++++
> > > >  migration/vmstate-types.c   | 88 +++++++++++++++++++++++++++++++++=
++++
> > > >  2 files changed, 109 insertions(+)
> > > >
> > > > diff --git a/include/migration/vmstate.h b/include/migration/vmstat=
e.h
> > > > index 89f9f49d20a..bc6495a7f67 100644
> > > > --- a/include/migration/vmstate.h
> > > > +++ b/include/migration/vmstate.h
> > > > @@ -265,6 +265,7 @@ extern const VMStateInfo vmstate_info_bitmap;
> > > >  extern const VMStateInfo vmstate_info_qtailq;
> > > >  extern const VMStateInfo vmstate_info_gtree;
> > > >  extern const VMStateInfo vmstate_info_qlist;
> > > > +extern const VMStateInfo vmstate_info_ptrs_array_entry;
> > > >
> > > >  #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
> > > >  /*
> > > > @@ -537,6 +538,26 @@ extern const VMStateInfo vmstate_info_qlist;
> > > >      .offset     =3D vmstate_offset_array(_s, _f, _type*, _n),     =
     \
> > > >  }
> > > >
> > > > +/*
> > > > + * For migrating a dynamically allocated uint32-indexed array
> > > > + * of pointers to structures (with NULL entries and with auto memo=
ry allocation).
> > > > + *
> > > > + * _type: type of structure pointed to
> > > > + * _vmsd: VMSD for structure
> > > > + * start: size of structure pointed to (for auto memory allocation=
)
> > > > + */
> > > > +#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_ALLOC(_field, _state, =
_field_num, _version, _vmsd, _type) { \
> > > > +    .name       =3D (stringify(_field)),                          =
      \
> > > > +    .version_id =3D (_version),                                   =
      \
> > > > +    .num_offset =3D vmstate_offset_value(_state, _field_num, uint3=
2_t), \
> > > > +    .info       =3D &vmstate_info_ptrs_array_entry,               =
      \
> > >
> > > I wonder if we need this hard-coded new info structure for this, more
> > > below.
> > >
> > > > +    .vmsd       =3D &(_vmsd),                                     =
      \
> > > > +    .start      =3D sizeof(_type),                                =
      \
> > > > +    .size       =3D sizeof(_type *),                              =
      \
> > > > +    .flags      =3D VMS_VARRAY_UINT32|VMS_POINTER,                =
      \
> > > > +    .offset     =3D vmstate_offset_pointer(_state, _field, _type *=
),    \
> > > > +}
> > > > +
> > > >  #define VMSTATE_VARRAY_OF_POINTER_UINT32(_field, _state, _field_nu=
m, _version, _info, _type) { \
> > > >      .name       =3D (stringify(_field)),                          =
          \
> > > >      .version_id =3D (_version),                                   =
          \
> > > > diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> > > > index 89cb2114721..3335377cd07 100644
> > > > --- a/migration/vmstate-types.c
> > > > +++ b/migration/vmstate-types.c
> > > > @@ -942,3 +942,91 @@ const VMStateInfo vmstate_info_qlist =3D {
> > > >      .get  =3D get_qlist,
> > > >      .put  =3D put_qlist,
> > > >  };
> > > > +
> > > > +static int put_ptrs_array_entry(QEMUFile *f, void *ppv, size_t unu=
sed_size,
> > > > +                                const VMStateField *field, JSONWri=
ter *vmdesc)
> > > > +{
> > > > +    const VMStateDescription *vmsd =3D field->vmsd;
> > > > +    int ret;
> > > > +    Error *local_err =3D NULL;
> > > > +    void *pv;
> > > > +
> > > > +    /*
> > > > +     * (ppv) is an address of an i-th element of a dynamic array.
> > > > +     *
> > > > +     * (ppv) can not be NULL unless we have some regression/bug in
> > > > +     * vmstate_save_state_v(), because it is result of pointer ari=
themic like:
> > > > +     * first_elem + size * i.
> > > > +     */
> > > > +    if (ppv =3D=3D NULL) {
> > > > +        error_report("vmstate: put_ptrs_array_entry must be called=
 with ppv !=3D NULL");
> > > > +        return -EINVAL;
> > > > +    }
> > > > +
> > > > +    /* get a pointer to a structure */
> > > > +    pv =3D *(void **)ppv;
> > >
> > > Here IIUC it's almost what VMS_ARRAY_OF_POINTER should do.  Could we
> > > declare the vmsd with VMS_ARRAY_OF_POINTER so as to save this open-co=
ded
> > > dereference of pointer?
> >
> > Yes, this is something I tried to do in the first place, but this
> > didn't work for my use-case.
> >
> > Let me explain what I'm doing in detail. I have the following structure=
:
> >
> > typedef struct NvmeCtrl {
> >      ...
> >      uint32_t num_queues; // < MAX number of elements in sq
> >      NvmeSQueue **sq;
> >      ...
> > } NvmeCtrl;
> >
> > Suppose we have variable n with type NvmeCtrl *.
> >
> > // somewhere early during initialization of QEMU device:
> > n->sq =3D g_new0(NvmeSQueue *, n->num_queues);
> >
> > // then in runtime (depending on what *guest* wants) we might create
> > some sq[i], e.g:
> > NvmeSQueue *sq;
> > sq =3D g_malloc0(sizeof(*sq));
> > n->sq[3] =3D sq;
> >
> > please, note that n->sq[0], n->sq[1], n->sq[2] can still be NULL. So,
> > we allow holes in that array.
> >
> > What I found is that if I raise VMS_ARRAY_OF_POINTER flag on VMStateFie=
ld, then
> > migration code in vmstate_load_state() will expect to see so-called
> > "fake nullptr field" (vmsd_create_fake_nullptr_field() function call).
> >
> > But this is a problem, because our array at the time of
> > vmstate_load_state() looks like (N =3D=3D NULL):
> > 0     1     2     3     4     5
> > N    N    N     N     N    N

Hi Peter,

>
> Yes, I actually just notice that the old nullptr trick only works if the
> dest QEMU will know if the pointer is NULL... that makes that interface
> pretty much, useless in most cases.. :(
>
> So it's not source telling dest that "there's a null pointer in the array=
",
> it's just that both sides know that.  Checking the original patch of that=
,
> indeed it mentioned it's used in ChannelSubSys.css in hw/s390x/css.c:

Precisely.

>
> https://lore.kernel.org/all/20170222160119.52771-4-pasic@linux.vnet.ibm.c=
om/
>
> So I guess the qemu cmdline for that s390 guest will make sure the pointe=
rs
> will be pre-initialized already..  So yes, it won't work for you.  You're
> looking for a full dynamic array of pointers.
>
> >
> > while after vmstate_load_state() I expect it to be:
> > 0     1     2     3     4     5
> > N    N     N   SQ   N    N
> >
> > so, somebody should allocate memory for sq[3] and load data from image
> > into that memory.
> >
> > Probably, it makes sense to somehow implement a combination of
> > VMS_ARRAY_OF_POINTER and  VMS_ALLOC,
> > but I tried to be as less invasive as I can and decided to introduce a
> > new kind of VMStateField instead.
>
> Yes.  We already used VMS_ALLOC for top level allocation.  We may need
> another flag for per-array allocation.
>

Yep.

> >
> > >
> > > > +
> > > > +    if (pv =3D=3D NULL) {
> > > > +        /* write a mark telling that there was a NULL pointer */
> > > > +        qemu_put_byte(f, false);
> > > > +        return 0;
> > > > +    }
> > > > +
> > > > +    /* if pointer is not NULL, dump the structure contents with he=
lp of vmsd */
> > > > +    qemu_put_byte(f, true);
> > > > +    ret =3D vmstate_save_state(f, vmsd, pv, vmdesc, &local_err);
> > >
> > > This looks really like VMS_STRUCT, except that it also tries to detec=
t if
> > > the pointer is NULL, then save some dumps.
> >
> > Precisely, I'm mimicking behavior of VMS_STRUCT | VMS_ALLOC and
> > VMS_ARRAY_OF_POINTER here.
> >
> > >
> > > Is it feasible to make both queues to always be available so as to re=
use
> > > VMS_STRUCT?  Or is it intentional here to avoid dumping queues where =
the
> > > pointer is NULL?
> >
> > By "available" you mean to always allocate memory for all n->sq[i] elem=
ents?
> >
> > >
> > > Even if for the latter, I wonder if we can have better way to do it. =
 For
> > > example, if we can integrate this directly into vmstate_save/load_sta=
te()
> > > to support some new flag, VMS_ARRAY_OF_POINTER_DYNAMIC, then we can d=
eclare
> > > some more "official" way to say some pointer of an dynamic array is N=
ULL.
> > >
> >
> > Yeah, I thought about this too, I believe this is a great idea. But
> > taking into account that
> > this is my first contribution to QEMU and I'm learning code around I tr=
ied to be
> > very conservative and don't change any generic code ;-)
> >
> > I'm happy to do this work in -v3 if you would like me to do it and
> > guide me a bit (I have just send a v2 series,
> > but there was no changes in migration API part, only NVMe specifics).
>
> Yes, it would be nice if we can use a good base on this part of work.  Th=
e
> problem with your proposal is even if it doesn't touch vmstate core, we
> will then need to maintain that special .info struct, that's also a burde=
n.
> So maybe it's better we do it the best we can come up with.

yes, I agree.

>
> I changed slightly on the name of the new flag, DYNAMIC might be fine but=
 I
> wonder if we can choose something clearer on what it does.
>
> Maybe VMS_ARRAY_OF_POINTER_ALLOW_NULL? It should at least imply two thing=
s:
>
> (1) The array being migrated can contain NULL pointers anywhere in the
>     elements.  We will need to change the nullptr trick a bit for this: w=
e
>     must send a byte (even if it's non-NULL) beforehand saying if this
>     element is NULL.  We could reuse 0x30 for NULL, but we need e.g. 0x31
>     to say it's non-NULL.  Then this will work even if dest QEMU doesn't
>     know which pointer is NULL (unlike s390's css).
>
> (2) If it's non-NULL, dest QEMU allocates the array element memory during
>     loading the vmsd.  It plays similarly a role of VMS_ALLOC but for the
>     array elements.  We could use a separate flag but I don't see a case
>     where this flag can be used without being able to migrate NULL
>     elements, so maybe we can stick with one flag so far until we see
>     another use case.
>
> The new flag must only be used with VMS_ARRAY_OF_POINTER for sure.  It
> should likely verify that each pointer on dest is NULL before hand before
> allocating that array element too in case we leak things.

Yes, this is precisely what I'm currently doing in get_ptrs_array_entry()

>
> We will also need some coverage in test-vmstate.c for this.

Sure!

>
> It would be great if you will volunteer on this piece of work, I will try
> to help whatever way I can on reviews.  You can also consider doing it
> separately then migration can collect it in advance when ready on its own
> (proven that it'll be 100% useful here for nvme very soon).

I'm in.

>
> But I know it might be too much to ask, so if you want I can also take a
> look at this problem.  Let me know.

No problem at all. I'm happy to pick this up and try to implement.
And huge thanks for your guidance and advice ;-)

Kind regards,
Alex

>
> Thanks,
>
> --
> Peter Xu
>

