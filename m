Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEA4F4644E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 11:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25p4-0007VK-OU; Mon, 16 Mar 2026 07:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w25p2-0007V5-QQ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 07:09:20 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w25p0-0001tr-Im
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 07:09:20 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-59e4a04f059so4564311e87.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 04:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773659355; cv=none;
 d=google.com; s=arc-20240605;
 b=Jd41OseLmdlv85zF47eUnyLWKrFfD3TAmefAiu8kzOCcC8kYmjAux5DDoAICSFf7C7
 6YpG7f1bIQnm3UwB8o7wx1fHD6HVOwE+hqY5VRun5jNCEgc2+RtQGMJh3npBdT/vNNOm
 rEZ6HVZpwzYvwZO6sY4dRkTt7Z5Nk6YSlnQdO0WxVLmGUCvQxzg/k4TPSBqcSMdUVzyj
 B6hVFogiqOU4iFMx0ES/fjFZZ5mcXrIda4lLRxK8ozwmZaRQVK4LvtdONyhVv53YjZKA
 KMXCgUUogWShuwVtC8GLehnDt1tGQ0bM5wUnWQzHvtSTidVO8jLdH4pKCQKJdnaxgm+l
 rMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LdUKL2hVaK4TRo4kHF/N/TfBIcC3I4w845SArJX+L0w=;
 fh=NgU5lpwVD1237EuNqEC+9p/BIw/311s+sXyIBxL4FcY=;
 b=it5iiOo/rEbmJ8xHoUt/kLkUFUsnvN5gSv/QQeNKFRZs1Fgl1DgLuQks0Z6xrbVw7l
 DngEC0UrXdeOji6TTjOjyVFPbyTkCNFGkeAK0fHBUuHY0U8ues3UKm0T5cX3uFH7ZLuB
 LaHMwx54twjjndxb5uSXgkV+bdCe12RJvC4LP5o3qaOYegH0DcL9j7L/Z/iZWLb4EtEd
 Fj+k6flRytSP30V1dYXp/4FXhi/pFRUZTho/yTHE+fKnQ2W4kwU96Z4F70DgVBb97+9y
 NE9cEsQvZPPj8GmwhXtxg1FBshR71l+R5um42HQRGmxzEGABK9P2znMWlZ8IA6H+tzXL
 F4FQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773659355; x=1774264155; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LdUKL2hVaK4TRo4kHF/N/TfBIcC3I4w845SArJX+L0w=;
 b=jd3jrhu/UELXbGLz8BjNlu3NZemjfOp7JlXech8I077tKv45x8VWxGfaEa9azj6/Sw
 mnf/ro7n1Qjqx1JsXLkowPvTB/5JUad03iaqVJfKoosBcQlWn5ednrF4Y3VC2qO78INB
 r6qTSEbybJNLOLwIigXpv/MdCIpEFeDtVvySY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773659355; x=1774264155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LdUKL2hVaK4TRo4kHF/N/TfBIcC3I4w845SArJX+L0w=;
 b=bJpGC5LTqhVdVoQq2ja5XdGZDobQjf8aSDC55p0qLxChVNmzcgwjeTRqmgJn1bLkUc
 AHpIjuNsWxxxLLjgLJcZVrlND+BpriQhbDzirezzECo9h3QqH1LY9SydneYnF9KCQuYS
 h/QE4nKY/df5CAfybhTvvUNRx3ejmFbrZXSLN9E+DnkoxQaHIAn/FrarCi0wgrAMWRK4
 qE6fQt/rHiiEuJ42TmFxccDyJgzMgo0s5QPQ0qEl2CsT6oxylbQukByTYdv0HJ1S+F81
 wUDGGulMR7rEX4620iYEefOYB2RXfZd61XYiWIgT+E0qbLIK2Yh/XRE+Uv68YzP6Y2HC
 Q96A==
X-Gm-Message-State: AOJu0YzAEMby5t8XLOwrpBn/GPLo4GNgNUj/t23vQM795eK50/rw+clA
 0tYVI59NOEn5DE6hqKQP1ufoVer9/eb4398zcsnHjDvu2tD4uc/eq0VZt6QhHDHtJ4phd949JHj
 XCd6LZ6bRt91z2GU+LdBh5Ng/rIdyWnVr1l2/q9AJeA==
X-Gm-Gg: ATEYQzyhcXuI/G0qlQ95/p78/nkctP61crCYoGQ+fEHa5VjYn9vvNr/9m2Qs9OJJpix
 mBYgloYdMwyIfHr8HjFznnZQzcobaHoZmtPbH492Irtd68T6nY5lKdT2+Szq7wNr9KpI5x9oyi2
 +8je/6IORGoWX+ryKOg7kxhbd4zMyHWAz/ac+ZUSOaZnOVYe4Br+3KIk5bhS6IE6KJJxY5jkakK
 rNEYQqgu+c9EromG4nYSjLHUjxTy5YmbLxSp5zuTGzwjrSD0gEztxs353fKFGEeqrNkP0OyXCEC
 IRIkxXn4NqJWlGFNPorNKQUgN5NlrhSQe4/LZ5g=
X-Received: by 2002:a05:6512:208e:b0:5a1:34d2:b6da with SMTP id
 2adb3069b0e04-5a162b0a440mr2542944e87.31.1773659355179; Mon, 16 Mar 2026
 04:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260313141221.359503-1-alexander@mihalicyn.com>
 <20260313141221.359503-2-alexander@mihalicyn.com> <abQ7CLuJsWRLwoe5@x1.local>
In-Reply-To: <abQ7CLuJsWRLwoe5@x1.local>
Date: Mon, 16 Mar 2026 12:09:04 +0100
X-Gm-Features: AaiRm519tjU2KrMNHeD_S92xszcGAoQ9XEzsdsQhxdO9vpAjkeGmcG0V87Fn8AQ
Message-ID: <CAJqdLroNDwNk4N4Kszyptu7vgOwQfERM8AtAxQhjqfRhCt_W3w@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] migration/vmstate: introduce vmstate_{load,
 save}_field helpers
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 Kevin Wolf <kwolf@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fam Zheng <fam@euphon.net>, Klaus Jensen <its@irrelevant.dk>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x12c.google.com
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
Reply-to:  Alexander Mikhalitsyn <alexander@mihalicyn.com>
From:  Alexander Mikhalitsyn via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am Fr., 13. M=C3=A4rz 2026 um 17:27 Uhr schrieb Peter Xu <peterx@redhat.com=
>:
>
> On Fri, Mar 13, 2026 at 03:12:14PM +0100, Alexander Mikhalitsyn wrote:
> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >
> > Let's introduce vmstate_{load,save}_field() helpers, they will
> > be used in next patches to support fully-dynamic arrays with NULLs.
> >
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion=
.io>
>

Hi Peter,

> Feel free to rebase to Vladimir's series here, Fabiano already queued it:
>
> https://lore.kernel.org/all/20260304212303.667141-11-vsementsov@yandex-te=
am.ru/#t

I've tried, but I can't see it anywhere
https://gitlab.com/farosas/qemu/-/commits/migration-next
doesn't contain it. As of now, last commit is
472f455cfbb0c5f84a7d48228d5226eaf6c7a61b.

Also, patchew tells that that series has conflicts with master:
https://patchew.org/QEMU/20260304212303.667141-1-vsementsov@yandex-team.ru/

Should I manually download mbox, apply/resolve conflicts with master,
then rebase my stuff and resend?

Kind regards,
Alex

>
> These codes weren't touched that frequent, it's interesting to see such
> coinsidence happens. :)
>
> > ---
> >  include/migration/vmstate.h |  4 ++
> >  migration/vmstate.c         | 84 +++++++++++++++++++++++--------------
> >  2 files changed, 56 insertions(+), 32 deletions(-)
> >
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index 62c2abd0c49..5d7dfe70643 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -1240,8 +1240,12 @@ extern const VMStateInfo vmstate_info_qlist;
> >          .flags =3D VMS_END, \
> >      }
> >
> > +int vmstate_load_field(QEMUFile *f, void *pv, size_t size,
> > +                       const VMStateField *field, Error **errp);
> >  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >                         void *opaque, int version_id, Error **errp);
> > +int vmstate_save_field(QEMUFile *f, void *pv, size_t size,
> > +                       const VMStateField *field, JSONWriter *vmdesc, =
Error **errp);
> >  int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
> >                         void *opaque, JSONWriter *vmdesc, Error **errp)=
;
> >  int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > index 4d28364f7ba..8d192bcaa27 100644
> > --- a/migration/vmstate.c
> > +++ b/migration/vmstate.c
> > @@ -131,6 +131,32 @@ static void vmstate_handle_alloc(void *ptr, const =
VMStateField *field,
> >      }
> >  }
> >
> > +int vmstate_load_field(QEMUFile *f, void *pv, size_t size,
> > +                       const VMStateField *field, Error **errp)
> > +{
> > +    int ret =3D 0;
> > +
> > +    if (field->flags & VMS_STRUCT) {
> > +        ret =3D vmstate_load_state(f, field->vmsd, pv,
> > +                                 field->vmsd->version_id,
> > +                                 errp);
> > +    } else if (field->flags & VMS_VSTRUCT) {
> > +        ret =3D vmstate_load_state(f, field->vmsd, pv,
> > +                                 field->struct_version_id,
> > +                                 errp);
> > +    } else {
> > +        ret =3D field->info->get(f, pv, size, field);
> > +        if (ret < 0) {
> > +            error_setg(errp,
> > +                       "Failed to load element of type %s for %s: "
> > +                       "%d", field->info->name,
> > +                       field->name, ret);
> > +        }
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> >  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >                         void *opaque, int version_id, Error **errp)
> >  {
> > @@ -203,24 +229,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateD=
escription *vmsd,
> >                      inner_field =3D field;
> >                  }
> >
> > -                if (inner_field->flags & VMS_STRUCT) {
> > -                    ret =3D vmstate_load_state(f, inner_field->vmsd, c=
urr_elem,
> > -                                             inner_field->vmsd->versio=
n_id,
> > -                                             errp);
> > -                } else if (inner_field->flags & VMS_VSTRUCT) {
> > -                    ret =3D vmstate_load_state(f, inner_field->vmsd, c=
urr_elem,
> > -                                             inner_field->struct_versi=
on_id,
> > -                                             errp);
> > -                } else {
> > -                    ret =3D inner_field->info->get(f, curr_elem, size,
> > -                                                 inner_field);
> > -                    if (ret < 0) {
> > -                        error_setg(errp,
> > -                                   "Failed to load element of type %s =
for %s: "
> > -                                   "%d", inner_field->info->name,
> > -                                   inner_field->name, ret);
> > -                    }
> > -                }
> > +                ret =3D vmstate_load_field(f, curr_elem, size, inner_f=
ield, errp);
> >
> >                  /* If we used a fake temp field.. free it now */
> >                  if (inner_field !=3D field) {
> > @@ -427,6 +436,29 @@ int vmstate_save_state(QEMUFile *f, const VMStateD=
escription *vmsd,
> >      return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->vers=
ion_id, errp);
> >  }
> >
> > +int vmstate_save_field(QEMUFile *f, void *pv, size_t size,
> > +                       const VMStateField *field, JSONWriter *vmdesc, =
Error **errp)
> > +{
> > +    int ret =3D 0;
> > +
> > +    if (field->flags & VMS_STRUCT) {
> > +        ret =3D vmstate_save_state(f, field->vmsd, pv, vmdesc, errp);
> > +    } else if (field->flags & VMS_VSTRUCT) {
> > +        ret =3D vmstate_save_state_v(f, field->vmsd, pv, vmdesc,
> > +                                   field->struct_version_id, errp);
> > +    } else {
> > +        ret =3D field->info->put(f, pv, size, field, vmdesc);
> > +        if (ret < 0) {
> > +            error_setg(errp,
> > +                       "Failed to save element of type %s for %s: "
> > +                       "%d", field->info->name,
> > +                       field->name, ret);
> > +        }
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> >  int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> >                           void *opaque, JSONWriter *vmdesc, int version=
_id, Error **errp)
> >  {
> > @@ -528,19 +560,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStat=
eDescription *vmsd,
> >                  vmsd_desc_field_start(vmsd, vmdesc_loop, inner_field,
> >                                        i, max_elems);
> >
> > -                if (inner_field->flags & VMS_STRUCT) {
> > -                    ret =3D vmstate_save_state(f, inner_field->vmsd,
> > -                                             curr_elem, vmdesc_loop, e=
rrp);
> > -                } else if (inner_field->flags & VMS_VSTRUCT) {
> > -                    ret =3D vmstate_save_state_v(f, inner_field->vmsd,
> > -                                               curr_elem, vmdesc_loop,
> > -                                               inner_field->struct_ver=
sion_id,
> > -                                               errp);
> > -                } else {
> > -                    ret =3D inner_field->info->put(f, curr_elem, size,
> > -                                                 inner_field, vmdesc_l=
oop);
> > -                }
> > -
> > +                ret =3D vmstate_save_field(f, curr_elem, size, inner_f=
ield, vmdesc_loop, errp);
> >                  written_bytes =3D qemu_file_transferred(f) - old_offse=
t;
> >                  vmsd_desc_field_end(vmsd, vmdesc_loop, inner_field,
> >                                      written_bytes);
> > @@ -551,7 +571,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMState=
Description *vmsd,
> >                  }
> >
> >                  if (ret) {
> > -                    error_setg(errp, "Save of field %s/%s failed",
> > +                    error_prepend(errp, "Save of field %s/%s failed: "=
,
> >                                  vmsd->name, field->name);
> >                      if (vmsd->post_save) {
> >                          vmsd->post_save(opaque);
> > --
> > 2.47.3
> >
>
> --
> Peter Xu
>

