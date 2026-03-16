Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C46F53D67
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 15:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w29bQ-0006MY-C9; Mon, 16 Mar 2026 11:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w29bN-0006Lj-UC
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 11:11:29 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w29bK-0007m2-9F
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 11:11:29 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5a0ff30b240so5593314e87.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 08:11:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773673884; cv=none;
 d=google.com; s=arc-20240605;
 b=Qwmbda4RwiVI+V7njaEXZKMr0OBv1Ai0osGxpj245aLXQr9f4v1cGOMiaNLfB9Nc9C
 f84SwI7gIi1bDhmud1PJ6Jm4rnapmV5MYoLnMq/vRr46est1DeDY1wxM1i4uQ4gfKRAd
 cpXHoRejemLOOcgSxGPSoYW2s2A+f2pb56OvQliwyEADZASm00MOYz7dzkLwFg+C2vpQ
 u1llxaoYgkKEMCvAkfV4Xe3JXg8z+QYVf5lyvzT6MfJN5YQJeSMZHShu6Pe3iZWcuFSO
 9hnedID+4VbREZYdAnbQKn4uxZOcmStunQ8HtybjXl2I023ufXodTaBvJFrJwMjIzV5q
 VoqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MNCWw/6i3Lz2UMfosAkehpHNYpGeOrKriHCXaUSRNpg=;
 fh=qnINvxWyJTY+zq+h6cc1tTffV8Fapg/QxWeKsF+7/D8=;
 b=PJMbNUjCfXQlloE5VYkEONe4nRlyU86onbn4of2MwMJ7cehj3TFbJsH7ZAqPBGpRoD
 vKoCvrtx3GLdjhIYr4tpkNQj0Ls0xum+Vle3zsUgUD7tr+9dNWH0nHOCMtNFjrRbWOIh
 Q1aASjwrXH2C9jYaQOiZq4TVu2C9W/7rKK+NF5doBFcbSz5S3odFuHz5DSgCxP/3Eo2I
 JYK6UAnKDncMkQ45SWSpcB0333m0JLUltp9PFq2SK6qO0HVvtmFUZ8ufk9FzBBwdw0jr
 xVHTw/Wt1wmuW/Xjjojb8t+x1QlA3sv6ur9tH7zJgldb4mQ0dWIMPzraXo1MIJKztkne
 cD/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773673884; x=1774278684; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MNCWw/6i3Lz2UMfosAkehpHNYpGeOrKriHCXaUSRNpg=;
 b=dQQbK5HTvg/6P5Dmpn+QJKUfiU+3g6UkyP0ZObgQnd1gUFTYVPnznfecZ2RnPC/KfR
 wRfSE1viX4nW/pKHOLHaUTO1GlvXEwVvDB06VzZSK6TYDFMvHJiGYqbJd3kPWenQB3WJ
 Z/UxZD+RHH2jJtV0xCGIZF5QtSXgmQ0nfh9qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773673884; x=1774278684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MNCWw/6i3Lz2UMfosAkehpHNYpGeOrKriHCXaUSRNpg=;
 b=cgh588o2JM8n3P7OGZoMkVFEfwW/lx7xyalt7SXDAidEecxeR1iKqaM886Rgn2/Gz3
 T7geBjHw+XgwihHOVh6Ij5u9X0A566gE7kI+K6qG2i3IeckpOsSMGGf5Xx4PNCyk+7aI
 ONdZclxF5LCk9aV7c91nLxqPSI+WHsUMErz564LvyKgj1xILLAsEZXNq0QPiwiKM9f5f
 +46I5a2Frsw8+BGxRfENHC7owb6p+TMRY2sJCxLowYRn3jfzK5VyKM07/6gSmId4qXY5
 VG4kGL5UQ4pgzrFBemEYuOBpsh/tcJmKfzlqYmAPUVrQr8GHX8EWGoF2ukoOnyL5ky06
 MdJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Lr4E1vvZEGi3goR8aa2IeTb75Y8nsoL8XmY4dFarMeQAIyPgBNwqIcV/736AzKUTZeLk9pspFm4d@nongnu.org
X-Gm-Message-State: AOJu0YzXq6j234dL0cVm2YLryM6AWUR+7maqCA8e8evN6+yFiz5c6fkJ
 3sYBDgK6Q6CGX5Pt36tV8Wyq7ULsGbS5V1l8Pt7X2b3IkggTCnwL+XXy17vBjiV06/yx6gLuohL
 rQwb4glGIk6EuO0f7zegDWxZtDtaGohPHB5Lt0HBRFg==
X-Gm-Gg: ATEYQzxsMKLAqCWkNQ2ul212JGsPTOE6UrzAa01tUhnhrklEyp69I3amtBdWMfuUhIr
 vBdKAAwGvzuPjmd+woNZCN1RK3x/ORxqnjBOKRcBuE3sMhAzJ4mepQQWd0agcFrcEchG6PimA53
 ybIQl9JxWJI/LEGqSRoMB4BRpt32vDf4/LlBnlspuKwaM7wNFMq4uE4ol7KrlBIx5LR5crKP6qZ
 dr7GabJdOCCBE0WkMAqcWpkRSlrvHxWD3iOBqTu9vtc2sqZNE65T3ku8C9nTvJiWTmMJ1F52NFa
 zDdihAziH+3S9Nl7MNG1PzDwifqyzGG1+3IeM5Y=
X-Received: by 2002:a05:6512:2244:b0:5a1:8b9:6d12 with SMTP id
 2adb3069b0e04-5a162afb89emr5295343e87.24.1773673883523; Mon, 16 Mar 2026
 08:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260313141221.359503-1-alexander@mihalicyn.com>
 <20260313141221.359503-2-alexander@mihalicyn.com> <abQ7CLuJsWRLwoe5@x1.local>
 <CAJqdLroNDwNk4N4Kszyptu7vgOwQfERM8AtAxQhjqfRhCt_W3w@mail.gmail.com>
 <87y0jrrfeq.fsf@suse.de>
In-Reply-To: <87y0jrrfeq.fsf@suse.de>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 16 Mar 2026 16:11:12 +0100
X-Gm-Features: AaiRm51d_yZaAQchrBbwDEPuxuBzjMD6HepZpe09ptRjrBs2l1mEjINdVgEJq0A
Message-ID: <CAJqdLrqZoA4GGtfNJg5TJ554H70vGxM5+HtGMy0XpNGDJ7X7_A@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] migration/vmstate: introduce vmstate_{load,
 save}_field helpers
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Jesper Devantier <foss@defmacro.it>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fam Zheng <fam@euphon.net>, Klaus Jensen <its@irrelevant.dk>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x12e.google.com
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

Am Mo., 16. M=C3=A4rz 2026 um 15:57 Uhr schrieb Fabiano Rosas <farosas@suse=
.de>:
>
> Alexander Mikhalitsyn via qemu development <qemu-devel@nongnu.org>
> writes:
>
> > Am Fr., 13. M=C3=A4rz 2026 um 17:27 Uhr schrieb Peter Xu <peterx@redhat=
.com>:
> >>
> >> On Fri, Mar 13, 2026 at 03:12:14PM +0100, Alexander Mikhalitsyn wrote:
> >> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >> >
> >> > Let's introduce vmstate_{load,save}_field() helpers, they will
> >> > be used in next patches to support fully-dynamic arrays with NULLs.
> >> >
> >> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfus=
ion.io>
> >>
> >
> > Hi Peter,
> >
> >> Feel free to rebase to Vladimir's series here, Fabiano already queued =
it:
> >>
> >> https://lore.kernel.org/all/20260304212303.667141-11-vsementsov@yandex=
-team.ru/#t
> >
> > I've tried, but I can't see it anywhere
> > https://gitlab.com/farosas/qemu/-/commits/migration-next
> > doesn't contain it. As of now, last commit is
> > 472f455cfbb0c5f84a7d48228d5226eaf6c7a61b.
> >

Hi Fabiano,

>
> I think we usually just take the patches from the list and apply
> directly instead of taking any branch*. I don't keep migration-next
> stable.

ah, makes sense.

>
> I pushed migration-staging which you can use. It'll collect the patches
> that will be merged at the start of the next development cycle, after
> the release.

Thank you!

>
> * I use:
> b4 am -3 -c -o <patches/dir> <lore.kernel.org link>
> (you'd need to solve any conflicts with the base branch yourself)

thanks for this, Fabiano! I'll try this out.

Kind regards,
Alex

>
> > Also, patchew tells that that series has conflicts with master:
> > https://patchew.org/QEMU/20260304212303.667141-1-vsementsov@yandex-team=
.ru/
> >
> > Should I manually download mbox, apply/resolve conflicts with master,
> > then rebase my stuff and resend?
> >
> > Kind regards,
> > Alex
> >
> >>
> >> These codes weren't touched that frequent, it's interesting to see suc=
h
> >> coinsidence happens. :)
> >>
> >> > ---
> >> >  include/migration/vmstate.h |  4 ++
> >> >  migration/vmstate.c         | 84 +++++++++++++++++++++++-----------=
---
> >> >  2 files changed, 56 insertions(+), 32 deletions(-)
> >> >
> >> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate=
.h
> >> > index 62c2abd0c49..5d7dfe70643 100644
> >> > --- a/include/migration/vmstate.h
> >> > +++ b/include/migration/vmstate.h
> >> > @@ -1240,8 +1240,12 @@ extern const VMStateInfo vmstate_info_qlist;
> >> >          .flags =3D VMS_END, \
> >> >      }
> >> >
> >> > +int vmstate_load_field(QEMUFile *f, void *pv, size_t size,
> >> > +                       const VMStateField *field, Error **errp);
> >> >  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >> >                         void *opaque, int version_id, Error **errp);
> >> > +int vmstate_save_field(QEMUFile *f, void *pv, size_t size,
> >> > +                       const VMStateField *field, JSONWriter *vmdes=
c, Error **errp);
> >> >  int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
> >> >                         void *opaque, JSONWriter *vmdesc, Error **er=
rp);
> >> >  int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vms=
d,
> >> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> >> > index 4d28364f7ba..8d192bcaa27 100644
> >> > --- a/migration/vmstate.c
> >> > +++ b/migration/vmstate.c
> >> > @@ -131,6 +131,32 @@ static void vmstate_handle_alloc(void *ptr, con=
st VMStateField *field,
> >> >      }
> >> >  }
> >> >
> >> > +int vmstate_load_field(QEMUFile *f, void *pv, size_t size,
> >> > +                       const VMStateField *field, Error **errp)
> >> > +{
> >> > +    int ret =3D 0;
> >> > +
> >> > +    if (field->flags & VMS_STRUCT) {
> >> > +        ret =3D vmstate_load_state(f, field->vmsd, pv,
> >> > +                                 field->vmsd->version_id,
> >> > +                                 errp);
> >> > +    } else if (field->flags & VMS_VSTRUCT) {
> >> > +        ret =3D vmstate_load_state(f, field->vmsd, pv,
> >> > +                                 field->struct_version_id,
> >> > +                                 errp);
> >> > +    } else {
> >> > +        ret =3D field->info->get(f, pv, size, field);
> >> > +        if (ret < 0) {
> >> > +            error_setg(errp,
> >> > +                       "Failed to load element of type %s for %s: "
> >> > +                       "%d", field->info->name,
> >> > +                       field->name, ret);
> >> > +        }
> >> > +    }
> >> > +
> >> > +    return ret;
> >> > +}
> >> > +
> >> >  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >> >                         void *opaque, int version_id, Error **errp)
> >> >  {
> >> > @@ -203,24 +229,7 @@ int vmstate_load_state(QEMUFile *f, const VMSta=
teDescription *vmsd,
> >> >                      inner_field =3D field;
> >> >                  }
> >> >
> >> > -                if (inner_field->flags & VMS_STRUCT) {
> >> > -                    ret =3D vmstate_load_state(f, inner_field->vmsd=
, curr_elem,
> >> > -                                             inner_field->vmsd->ver=
sion_id,
> >> > -                                             errp);
> >> > -                } else if (inner_field->flags & VMS_VSTRUCT) {
> >> > -                    ret =3D vmstate_load_state(f, inner_field->vmsd=
, curr_elem,
> >> > -                                             inner_field->struct_ve=
rsion_id,
> >> > -                                             errp);
> >> > -                } else {
> >> > -                    ret =3D inner_field->info->get(f, curr_elem, si=
ze,
> >> > -                                                 inner_field);
> >> > -                    if (ret < 0) {
> >> > -                        error_setg(errp,
> >> > -                                   "Failed to load element of type =
%s for %s: "
> >> > -                                   "%d", inner_field->info->name,
> >> > -                                   inner_field->name, ret);
> >> > -                    }
> >> > -                }
> >> > +                ret =3D vmstate_load_field(f, curr_elem, size, inne=
r_field, errp);
> >> >
> >> >                  /* If we used a fake temp field.. free it now */
> >> >                  if (inner_field !=3D field) {
> >> > @@ -427,6 +436,29 @@ int vmstate_save_state(QEMUFile *f, const VMSta=
teDescription *vmsd,
> >> >      return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->v=
ersion_id, errp);
> >> >  }
> >> >
> >> > +int vmstate_save_field(QEMUFile *f, void *pv, size_t size,
> >> > +                       const VMStateField *field, JSONWriter *vmdes=
c, Error **errp)
> >> > +{
> >> > +    int ret =3D 0;
> >> > +
> >> > +    if (field->flags & VMS_STRUCT) {
> >> > +        ret =3D vmstate_save_state(f, field->vmsd, pv, vmdesc, errp=
);
> >> > +    } else if (field->flags & VMS_VSTRUCT) {
> >> > +        ret =3D vmstate_save_state_v(f, field->vmsd, pv, vmdesc,
> >> > +                                   field->struct_version_id, errp);
> >> > +    } else {
> >> > +        ret =3D field->info->put(f, pv, size, field, vmdesc);
> >> > +        if (ret < 0) {
> >> > +            error_setg(errp,
> >> > +                       "Failed to save element of type %s for %s: "
> >> > +                       "%d", field->info->name,
> >> > +                       field->name, ret);
> >> > +        }
> >> > +    }
> >> > +
> >> > +    return ret;
> >> > +}
> >> > +
> >> >  int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vms=
d,
> >> >                           void *opaque, JSONWriter *vmdesc, int vers=
ion_id, Error **errp)
> >> >  {
> >> > @@ -528,19 +560,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMS=
tateDescription *vmsd,
> >> >                  vmsd_desc_field_start(vmsd, vmdesc_loop, inner_fiel=
d,
> >> >                                        i, max_elems);
> >> >
> >> > -                if (inner_field->flags & VMS_STRUCT) {
> >> > -                    ret =3D vmstate_save_state(f, inner_field->vmsd=
,
> >> > -                                             curr_elem, vmdesc_loop=
, errp);
> >> > -                } else if (inner_field->flags & VMS_VSTRUCT) {
> >> > -                    ret =3D vmstate_save_state_v(f, inner_field->vm=
sd,
> >> > -                                               curr_elem, vmdesc_lo=
op,
> >> > -                                               inner_field->struct_=
version_id,
> >> > -                                               errp);
> >> > -                } else {
> >> > -                    ret =3D inner_field->info->put(f, curr_elem, si=
ze,
> >> > -                                                 inner_field, vmdes=
c_loop);
> >> > -                }
> >> > -
> >> > +                ret =3D vmstate_save_field(f, curr_elem, size, inne=
r_field, vmdesc_loop, errp);
> >> >                  written_bytes =3D qemu_file_transferred(f) - old_of=
fset;
> >> >                  vmsd_desc_field_end(vmsd, vmdesc_loop, inner_field,
> >> >                                      written_bytes);
> >> > @@ -551,7 +571,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMSt=
ateDescription *vmsd,
> >> >                  }
> >> >
> >> >                  if (ret) {
> >> > -                    error_setg(errp, "Save of field %s/%s failed",
> >> > +                    error_prepend(errp, "Save of field %s/%s failed=
: ",
> >> >                                  vmsd->name, field->name);
> >> >                      if (vmsd->post_save) {
> >> >                          vmsd->post_save(opaque);
> >> > --
> >> > 2.47.3
> >> >
> >>
> >> --
> >> Peter Xu
> >>

