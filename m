Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA0FF506E1
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 14:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w29NY-0003Bv-70; Mon, 16 Mar 2026 10:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w29NW-00036P-3t
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 10:57:10 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w29NT-0005Hb-Uq
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 10:57:09 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 33F2F5BD41;
 Mon, 16 Mar 2026 14:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773673024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05FfWVYmBEKycZMGgL5RCuJ5zDDyFBJbMZC88y6bEzw=;
 b=d95gtq10MdM6k2nGOQeMuvRcALvyq0G8p/OJZbn5JHRDhOTcZvM/AzFBPhjH4m7dQEI9IR
 2mWR/yzKUzOhvEHyRZnNUCTuhHeHlwOqAq+3lEomR0J1JwpN4mbGyxGF9oav4+ScS50OCU
 udapDHKeuXjBHGEp2teUMt5ht4xezVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773673024;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05FfWVYmBEKycZMGgL5RCuJ5zDDyFBJbMZC88y6bEzw=;
 b=xVYlQ0ZhVC8Jqs2rAhPUtZheva4RNUGc5SvXbwdpOtxxoe0YFJs60cbIzA29t7NSyHbK2t
 jAgIvhWkUegSQHAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773673024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05FfWVYmBEKycZMGgL5RCuJ5zDDyFBJbMZC88y6bEzw=;
 b=d95gtq10MdM6k2nGOQeMuvRcALvyq0G8p/OJZbn5JHRDhOTcZvM/AzFBPhjH4m7dQEI9IR
 2mWR/yzKUzOhvEHyRZnNUCTuhHeHlwOqAq+3lEomR0J1JwpN4mbGyxGF9oav4+ScS50OCU
 udapDHKeuXjBHGEp2teUMt5ht4xezVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773673024;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05FfWVYmBEKycZMGgL5RCuJ5zDDyFBJbMZC88y6bEzw=;
 b=xVYlQ0ZhVC8Jqs2rAhPUtZheva4RNUGc5SvXbwdpOtxxoe0YFJs60cbIzA29t7NSyHbK2t
 jAgIvhWkUegSQHAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A98694273B;
 Mon, 16 Mar 2026 14:57:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7l4GHD8auGlJOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 16 Mar 2026 14:57:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>, Peter Xu
 <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Jesper Devantier <foss@defmacro.it>, Kevin Wolf
 <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, qemu-block@nongnu.org, =?utf-8?Q?St=C3=A9phane?=
 Graber
 <stgraber@stgraber.org>, Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Fam
 Zheng <fam@euphon.net>, Klaus Jensen <its@irrelevant.dk>, Zhao Liu
 <zhao1.liu@intel.com>, Alexander Mikhalitsyn
 <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v4 1/8] migration/vmstate: introduce vmstate_{load,
 save}_field helpers
In-Reply-To: <CAJqdLroNDwNk4N4Kszyptu7vgOwQfERM8AtAxQhjqfRhCt_W3w@mail.gmail.com>
References: <20260313141221.359503-1-alexander@mihalicyn.com>
 <20260313141221.359503-2-alexander@mihalicyn.com>
 <abQ7CLuJsWRLwoe5@x1.local>
 <CAJqdLroNDwNk4N4Kszyptu7vgOwQfERM8AtAxQhjqfRhCt_W3w@mail.gmail.com>
Date: Mon, 16 Mar 2026 11:57:01 -0300
Message-ID: <87y0jrrfeq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[16];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Alexander Mikhalitsyn via qemu development <qemu-devel@nongnu.org>
writes:

> Am Fr., 13. M=C3=A4rz 2026 um 17:27 Uhr schrieb Peter Xu <peterx@redhat.c=
om>:
>>
>> On Fri, Mar 13, 2026 at 03:12:14PM +0100, Alexander Mikhalitsyn wrote:
>> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>> >
>> > Let's introduce vmstate_{load,save}_field() helpers, they will
>> > be used in next patches to support fully-dynamic arrays with NULLs.
>> >
>> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusio=
n.io>
>>
>
> Hi Peter,
>
>> Feel free to rebase to Vladimir's series here, Fabiano already queued it:
>>
>> https://lore.kernel.org/all/20260304212303.667141-11-vsementsov@yandex-t=
eam.ru/#t
>
> I've tried, but I can't see it anywhere
> https://gitlab.com/farosas/qemu/-/commits/migration-next
> doesn't contain it. As of now, last commit is
> 472f455cfbb0c5f84a7d48228d5226eaf6c7a61b.
>

I think we usually just take the patches from the list and apply
directly instead of taking any branch*. I don't keep migration-next
stable.

I pushed migration-staging which you can use. It'll collect the patches
that will be merged at the start of the next development cycle, after
the release.

* I use:
b4 am -3 -c -o <patches/dir> <lore.kernel.org link>
(you'd need to solve any conflicts with the base branch yourself)

> Also, patchew tells that that series has conflicts with master:
> https://patchew.org/QEMU/20260304212303.667141-1-vsementsov@yandex-team.r=
u/
>
> Should I manually download mbox, apply/resolve conflicts with master,
> then rebase my stuff and resend?
>
> Kind regards,
> Alex
>
>>
>> These codes weren't touched that frequent, it's interesting to see such
>> coinsidence happens. :)
>>
>> > ---
>> >  include/migration/vmstate.h |  4 ++
>> >  migration/vmstate.c         | 84 +++++++++++++++++++++++--------------
>> >  2 files changed, 56 insertions(+), 32 deletions(-)
>> >
>> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> > index 62c2abd0c49..5d7dfe70643 100644
>> > --- a/include/migration/vmstate.h
>> > +++ b/include/migration/vmstate.h
>> > @@ -1240,8 +1240,12 @@ extern const VMStateInfo vmstate_info_qlist;
>> >          .flags =3D VMS_END, \
>> >      }
>> >
>> > +int vmstate_load_field(QEMUFile *f, void *pv, size_t size,
>> > +                       const VMStateField *field, Error **errp);
>> >  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>> >                         void *opaque, int version_id, Error **errp);
>> > +int vmstate_save_field(QEMUFile *f, void *pv, size_t size,
>> > +                       const VMStateField *field, JSONWriter *vmdesc,=
 Error **errp);
>> >  int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
>> >                         void *opaque, JSONWriter *vmdesc, Error **errp=
);
>> >  int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>> > diff --git a/migration/vmstate.c b/migration/vmstate.c
>> > index 4d28364f7ba..8d192bcaa27 100644
>> > --- a/migration/vmstate.c
>> > +++ b/migration/vmstate.c
>> > @@ -131,6 +131,32 @@ static void vmstate_handle_alloc(void *ptr, const=
 VMStateField *field,
>> >      }
>> >  }
>> >
>> > +int vmstate_load_field(QEMUFile *f, void *pv, size_t size,
>> > +                       const VMStateField *field, Error **errp)
>> > +{
>> > +    int ret =3D 0;
>> > +
>> > +    if (field->flags & VMS_STRUCT) {
>> > +        ret =3D vmstate_load_state(f, field->vmsd, pv,
>> > +                                 field->vmsd->version_id,
>> > +                                 errp);
>> > +    } else if (field->flags & VMS_VSTRUCT) {
>> > +        ret =3D vmstate_load_state(f, field->vmsd, pv,
>> > +                                 field->struct_version_id,
>> > +                                 errp);
>> > +    } else {
>> > +        ret =3D field->info->get(f, pv, size, field);
>> > +        if (ret < 0) {
>> > +            error_setg(errp,
>> > +                       "Failed to load element of type %s for %s: "
>> > +                       "%d", field->info->name,
>> > +                       field->name, ret);
>> > +        }
>> > +    }
>> > +
>> > +    return ret;
>> > +}
>> > +
>> >  int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>> >                         void *opaque, int version_id, Error **errp)
>> >  {
>> > @@ -203,24 +229,7 @@ int vmstate_load_state(QEMUFile *f, const VMState=
Description *vmsd,
>> >                      inner_field =3D field;
>> >                  }
>> >
>> > -                if (inner_field->flags & VMS_STRUCT) {
>> > -                    ret =3D vmstate_load_state(f, inner_field->vmsd, =
curr_elem,
>> > -                                             inner_field->vmsd->versi=
on_id,
>> > -                                             errp);
>> > -                } else if (inner_field->flags & VMS_VSTRUCT) {
>> > -                    ret =3D vmstate_load_state(f, inner_field->vmsd, =
curr_elem,
>> > -                                             inner_field->struct_vers=
ion_id,
>> > -                                             errp);
>> > -                } else {
>> > -                    ret =3D inner_field->info->get(f, curr_elem, size,
>> > -                                                 inner_field);
>> > -                    if (ret < 0) {
>> > -                        error_setg(errp,
>> > -                                   "Failed to load element of type %s=
 for %s: "
>> > -                                   "%d", inner_field->info->name,
>> > -                                   inner_field->name, ret);
>> > -                    }
>> > -                }
>> > +                ret =3D vmstate_load_field(f, curr_elem, size, inner_=
field, errp);
>> >
>> >                  /* If we used a fake temp field.. free it now */
>> >                  if (inner_field !=3D field) {
>> > @@ -427,6 +436,29 @@ int vmstate_save_state(QEMUFile *f, const VMState=
Description *vmsd,
>> >      return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->ver=
sion_id, errp);
>> >  }
>> >
>> > +int vmstate_save_field(QEMUFile *f, void *pv, size_t size,
>> > +                       const VMStateField *field, JSONWriter *vmdesc,=
 Error **errp)
>> > +{
>> > +    int ret =3D 0;
>> > +
>> > +    if (field->flags & VMS_STRUCT) {
>> > +        ret =3D vmstate_save_state(f, field->vmsd, pv, vmdesc, errp);
>> > +    } else if (field->flags & VMS_VSTRUCT) {
>> > +        ret =3D vmstate_save_state_v(f, field->vmsd, pv, vmdesc,
>> > +                                   field->struct_version_id, errp);
>> > +    } else {
>> > +        ret =3D field->info->put(f, pv, size, field, vmdesc);
>> > +        if (ret < 0) {
>> > +            error_setg(errp,
>> > +                       "Failed to save element of type %s for %s: "
>> > +                       "%d", field->info->name,
>> > +                       field->name, ret);
>> > +        }
>> > +    }
>> > +
>> > +    return ret;
>> > +}
>> > +
>> >  int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>> >                           void *opaque, JSONWriter *vmdesc, int versio=
n_id, Error **errp)
>> >  {
>> > @@ -528,19 +560,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMSta=
teDescription *vmsd,
>> >                  vmsd_desc_field_start(vmsd, vmdesc_loop, inner_field,
>> >                                        i, max_elems);
>> >
>> > -                if (inner_field->flags & VMS_STRUCT) {
>> > -                    ret =3D vmstate_save_state(f, inner_field->vmsd,
>> > -                                             curr_elem, vmdesc_loop, =
errp);
>> > -                } else if (inner_field->flags & VMS_VSTRUCT) {
>> > -                    ret =3D vmstate_save_state_v(f, inner_field->vmsd,
>> > -                                               curr_elem, vmdesc_loop,
>> > -                                               inner_field->struct_ve=
rsion_id,
>> > -                                               errp);
>> > -                } else {
>> > -                    ret =3D inner_field->info->put(f, curr_elem, size,
>> > -                                                 inner_field, vmdesc_=
loop);
>> > -                }
>> > -
>> > +                ret =3D vmstate_save_field(f, curr_elem, size, inner_=
field, vmdesc_loop, errp);
>> >                  written_bytes =3D qemu_file_transferred(f) - old_offs=
et;
>> >                  vmsd_desc_field_end(vmsd, vmdesc_loop, inner_field,
>> >                                      written_bytes);
>> > @@ -551,7 +571,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStat=
eDescription *vmsd,
>> >                  }
>> >
>> >                  if (ret) {
>> > -                    error_setg(errp, "Save of field %s/%s failed",
>> > +                    error_prepend(errp, "Save of field %s/%s failed: =
",
>> >                                  vmsd->name, field->name);
>> >                      if (vmsd->post_save) {
>> >                          vmsd->post_save(opaque);
>> > --
>> > 2.47.3
>> >
>>
>> --
>> Peter Xu
>>

