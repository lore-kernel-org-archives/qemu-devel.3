Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1274FD5CCB5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 14:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t69vm-0004hn-BL; Wed, 30 Oct 2024 10:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhexu@redhat.com>) id 1t69vj-0004hR-Uo
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 10:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhexu@redhat.com>) id 1t69vh-000593-99
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 10:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730299450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SP5j+UKRUnmaTvWx33YEInKQAvxMUQ4Gic0v/ZRhCqg=;
 b=V0tpbV0FYfemguzWZBoYMoYIQMEbBPzFBcvED1MYHG3I6J57tkoyXt3B0w7gxnAlnw2w+w
 XCeRlJWcO8w5WxLD60fj1OS/EMd7apYiawC3jgRPtE4taAJSr3IZ7Z7KMYXBZuI4hzwRXx
 wNdwtWIfzdCRE7lOhFGxgnNpxiCuakI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-pb5Wm8FWMweEgw-iLeGWdw-1; Wed, 30 Oct 2024 10:44:09 -0400
X-MC-Unique: pb5Wm8FWMweEgw-iLeGWdw-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2e2bd9a523bso6801479a91.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 07:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730299448; x=1730904248;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SP5j+UKRUnmaTvWx33YEInKQAvxMUQ4Gic0v/ZRhCqg=;
 b=m7A1wr2vJbtUCLM5RS9nM7R/7SAGKFk+gKMWuDPJJc0cn8+KRcsU3FKL/qp4fFpb+M
 dP5aj79BV+0z/h/+rxB1H92pYxPmJft/xRGsqbljJ7RyISoTh/JKhJIRy1psJIu7OTaX
 DPblgs3OQlZGzzCB9lZXwGFEF3M+tDU6lcNc5sDpWr/sMtpnQGeUdejk7jbccDVFaYBj
 /Da/zY002/nV4K6Vg25vWjUXhxHN+O6kDLJaUiHfKWEDwLvsTtwmOgAhCy9EUl9Crfwa
 lSjXwgHQJDFW1ojeKQ/WuOaeTCS13A4hZ183vIbTUXDkz+ze69ZoiHFbhTbBnAxpEIlc
 OMBw==
X-Gm-Message-State: AOJu0Yy7I/KmGAjrPJXQDIRMBXJJ6JNMNLI4YUADGnZenGV6TyMqujaU
 LKpRPEWoLxnR83vO3I0VwVdcr5F65DI1b2RF+gQPIx9hj+8Mxm2jvMk+SHUtgGrdPHgn0YdL+s/
 7Agr/GKm7F65yEIokE1+o7j3TLJSWfWmYFqSUcIB2RwxilMK5E42Yxgf0vIzVtmaM+vQ6x1K9Oh
 gZyapkDADr1fIo8t8uUBpRyOBYwws=
X-Received: by 2002:a17:90a:6341:b0:2e2:8f4b:b4b2 with SMTP id
 98e67ed59e1d1-2e8f11b9f74mr17498211a91.27.1730299447704; 
 Wed, 30 Oct 2024 07:44:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcXx/BGu7teTIsCtOvOoU9CYboMFZuQsYWl+/JfgRTmKVuL2OGZBBCMoWL+WEeWf3uZAs1QqaZZ82H7i/XTGM=
X-Received: by 2002:a17:90a:6341:b0:2e2:8f4b:b4b2 with SMTP id
 98e67ed59e1d1-2e8f11b9f74mr17498177a91.27.1730299447038; Wed, 30 Oct 2024
 07:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20241024213056.1395400-1-peterx@redhat.com>
 <20241024213056.1395400-8-peterx@redhat.com>
 <78729b4b-3747-4408-8146-12d49e70fed1@nvidia.com> <Zx-xpZzYG_1KuCQu@x1n>
 <4c6bb701-dd6d-4cca-be80-156c19f2a088@nvidia.com> <Zx_C0hrRZK34qc7I@x1n>
 <a96a8f31-ef8d-48b5-999c-8ca8a917f3c1@nvidia.com> <Zx_gzdJ549ApAiBp@x1n>
 <58146556-d3fa-4d8b-a1db-9bdc68168c78@nvidia.com>
In-Reply-To: <58146556-d3fa-4d8b-a1db-9bdc68168c78@nvidia.com>
From: Peter Xu <peterx@redhat.com>
Date: Wed, 30 Oct 2024 10:43:55 -0400
Message-ID: <CADLect=D7ATdE+FWxMvh_n9bWM5VUyYAR6=4Jm3nw=z2H-h7mw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] migration: Unexport migration_is_active()
To: Avihai Horon <avihaih@nvidia.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex.williamson@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e58c130625b2bbbd"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=zhexu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000e58c130625b2bbbd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024, 10:39=E2=80=AFa.m. Avihai Horon <avihaih@nvidia.com> =
wrote:

>
> On 28/10/2024 21:06, Peter Xu wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Mon, Oct 28, 2024 at 07:20:27PM +0200, Avihai Horon wrote:
> >> On 28/10/2024 18:58, Peter Xu wrote:
> >>> External email: Use caution opening links or attachments
> >>>
> >>>
> >>> On Mon, Oct 28, 2024 at 06:41:42PM +0200, Avihai Horon wrote:
> >>>> On 28/10/2024 17:45, Peter Xu wrote:
> >>>>> External email: Use caution opening links or attachments
> >>>>>
> >>>>>
> >>>>> On Mon, Oct 28, 2024 at 09:43:16AM +0200, Avihai Horon wrote:
> >>>>>> On 25/10/2024 0:30, Peter Xu wrote:
> >>>>>>> External email: Use caution opening links or attachments
> >>>>>>>
> >>>>>>>
> >>>>>>> We have two outside users of this API, so it's exported.
> >>>>>>>
> >>>>>>> Is it really necessary?  Does it matter whether it must be
> >>>>>>> ACTIVE/POSTCOPY_ACTIVE/DEVICE?  I guess no.
> >>>>>> Actually for VFIO it does matter, because we don't want VFIO to do
> DPT
> >>>>>> log_sync in SETUP stage when DPT might not have been started yet.
> >>>>>> See commit ff180c6bd7a8 ("vfio/migration: Skip log_sync during
> migration
> >>>>>> SETUP state").
> >>>>> This seems to be a known issue for migration in general, rather tha=
n
> VFIO
> >>>>> specific.  Hyman has a patch for it, not yet reviewed..
> >>>>>
> >>>>> https://lore.kernel.org/r/cover.1729648695.git.yong.huang@smartx.co=
m
> >>>>>
> >>>>> That corresponds to your comment here:
> >>>>>
> >>>>>        Redundant -- all RAM is marked dirty in migration SETUP stat=
e
> and is
> >>>>>        transferred only after migration is set to ACTIVE state, so
> doing
> >>>>>        log_sync during migration SETUP is pointless.
> >>>>>
> >>>>> So I wonder whether it's only VFIO that should skip it, or log_sync=
()
> >>>>> simply shouldn't be called at all during SETUP, because of its
> redundancy.
> >>>> Not sure why this sync was there in the first place, but if its only
> purpose
> >>>> was to sync dirty pages then yes, I guess it be dropped.
> >>>>
> >>>>> The other thing you mentioned here:
> >>>>>
> >>>>>        Can fail -- there is a time window, between setting migratio=
n
> state to
> >>>>>        SETUP and starting dirty tracking by RAM save_live_setup
> handler, during
> >>>>>        which dirty tracking is still not started. Any VFIO log_sync
> call that
> >>>>>        is issued during this time window will fail. For example,
> this error can
> >>>>>        be triggered by migrating a VM when a GUI is active, which
> constantly
> >>>>>        calls log_sync.
> >>>>>
> >>>>> This is VFIO specific.  Why this can fail even if global tracking i=
s
> >>>>> started already?
> >>>> It can fail if global tracking is *not* started yet.
> >>>> As mentioned in the commit message, there is a time window where
> migration
> >>>> is in SETUP state but global tracking is not started yet.
> >>> Hmm, I'm totally confused now..
> >>>
> >>> The only thing that can kickoff the sync during SETUP, AFAICT, is:
> >>>
> >>>               ret =3D
> memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, errp);
> >>>               if (!ret) {
> >>>                   goto out_unlock;
> >>>               }
> >>>               migration_bitmap_sync_precopy(false);   <-------------
> here
> >>>
> >>> I need to confess this may not be the right place to invoke it in
> ram.c (I
> >>> think we probably should move it out at some point.. into generic
> migration
> >>> code).  However I don't yet see why log_start() is not called first i=
n
> your
> >>> case before log_sync().
> >>>
> >>> Could you elaborate?
> >> Indeed, in the above code log_start is called before log_sync.
> >>
> >> I was referring to the case where some other code path triggers
> log_sync.
> >> E.g., if you open a VNC to the guest then it constantly calls log_sync
> to
> >> refresh the graphics. In that case, one of these log_syncs can happen
> >> between "migration status is set to SETUP" and "global tracking is
> started".
> > I see.  That's unfortunate..
> >
> > Though this is also the case where it shouldn't be VFIO's problem alone=
.
> > See some other users of log_sync():
> >
> > vhost_sync_dirty_bitmap():
> >      if (!dev->log_enabled || !dev->started) {
> >          return 0;
> >      }
> >
> > kvm_slot_get_dirty_log():
> >      if (ret =3D=3D -ENOENT) {
> >          /* kernel does not have dirty bitmap in this slot */
> >          ret =3D 0;
> >      }
> >
> > And I didn't further look.
> >
> > In short, IMHO looks like VFIO still shouldn't be special on
> differeciating
> > and make migration export the SETUP phase just for this..  as VFIO has
> > log_start() like all the rest, so VFIO can also know whether tracking i=
s
> > enabled at all, then it can silently no-op the log_sync() like all the
> rest
> > of the users.
> >
> > If you agree, I'd prefer we keep this patch - it'll be nice we only eve=
r
> > expose migration_is_running() for migration status checks, without
> exposing
> > SETUP only for this VFIO use case even if it could have followed what
> other
> > modules are doing.
>
> Yes, I agree this could be a nice cleanup.
>
> >
> > If you would like to propose a patch for VFIO, I'd be happy to include
> your
> > patch before this patch (just in case this patch could land some day) t=
o
> > make sure VFIO works as before.  Since I don't have VFIO HW to test,
> it'll
> > be challenging for me to propose and test such patch otherwise.
>
> I can do that, though it may be a bit involved because VFIO has multiple
> dirty tracking mechanisms (legacy, device DPT and IOMMU DPT). Plus, I
> don't have HW that supports IOMMU DPT at hand for testing.
> I assume this is not an urgent cleanup, right?
>

Yes there's no rush.

If you agree with the change, feel free to clean this helper up when you
post the vfio changes.  We can still have one more helper exported before
that.

Thanks a lot.


> Thanks.
>
>

--000000000000e58c130625b2bbbd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Wed, Oct 30, 2024, 10:39=E2=80=AFa.m. Avihai Horon &lt;<a h=
ref=3D"mailto:avihaih@nvidia.com">avihaih@nvidia.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><br>
On 28/10/2024 21:06, Peter Xu wrote:<br>
&gt; External email: Use caution opening links or attachments<br>
&gt;<br>
&gt;<br>
&gt; On Mon, Oct 28, 2024 at 07:20:27PM +0200, Avihai Horon wrote:<br>
&gt;&gt; On 28/10/2024 18:58, Peter Xu wrote:<br>
&gt;&gt;&gt; External email: Use caution opening links or attachments<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Mon, Oct 28, 2024 at 06:41:42PM +0200, Avihai Horon wrote:<=
br>
&gt;&gt;&gt;&gt; On 28/10/2024 17:45, Peter Xu wrote:<br>
&gt;&gt;&gt;&gt;&gt; External email: Use caution opening links or attachmen=
ts<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; On Mon, Oct 28, 2024 at 09:43:16AM +0200, Avihai Horon=
 wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt; On 25/10/2024 0:30, Peter Xu wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; External email: Use caution opening links or a=
ttachments<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; We have two outside users of this API, so it&#=
39;s exported.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Is it really necessary?=C2=A0 Does it matter w=
hether it must be<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; ACTIVE/POSTCOPY_ACTIVE/DEVICE?=C2=A0 I guess n=
o.<br>
&gt;&gt;&gt;&gt;&gt;&gt; Actually for VFIO it does matter, because we don&#=
39;t want VFIO to do DPT<br>
&gt;&gt;&gt;&gt;&gt;&gt; log_sync in SETUP stage when DPT might not have be=
en started yet.<br>
&gt;&gt;&gt;&gt;&gt;&gt; See commit ff180c6bd7a8 (&quot;vfio/migration: Ski=
p log_sync during migration<br>
&gt;&gt;&gt;&gt;&gt;&gt; SETUP state&quot;).<br>
&gt;&gt;&gt;&gt;&gt; This seems to be a known issue for migration in genera=
l, rather than VFIO<br>
&gt;&gt;&gt;&gt;&gt; specific.=C2=A0 Hyman has a patch for it, not yet revi=
ewed..<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; <a href=3D"https://lore.kernel.org/r/cover.1729648695.=
git.yong.huang@smartx.com" rel=3D"noreferrer noreferrer" target=3D"_blank">=
https://lore.kernel.org/r/cover.1729648695.git.yong.huang@smartx.com</a><br=
>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; That corresponds to your comment here:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Redundant -- all RAM is mar=
ked dirty in migration SETUP state and is<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 transferred only after migr=
ation is set to ACTIVE state, so doing<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 log_sync during migration S=
ETUP is pointless.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; So I wonder whether it&#39;s only VFIO that should ski=
p it, or log_sync()<br>
&gt;&gt;&gt;&gt;&gt; simply shouldn&#39;t be called at all during SETUP, be=
cause of its redundancy.<br>
&gt;&gt;&gt;&gt; Not sure why this sync was there in the first place, but i=
f its only purpose<br>
&gt;&gt;&gt;&gt; was to sync dirty pages then yes, I guess it be dropped.<b=
r>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; The other thing you mentioned here:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Can fail -- there is a time=
 window, between setting migration state to<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 SETUP and starting dirty tr=
acking by RAM save_live_setup handler, during<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 which dirty tracking is sti=
ll not started. Any VFIO log_sync call that<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 is issued during this time =
window will fail. For example, this error can<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 be triggered by migrating a=
 VM when a GUI is active, which constantly<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 calls log_sync.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; This is VFIO specific.=C2=A0 Why this can fail even if=
 global tracking is<br>
&gt;&gt;&gt;&gt;&gt; started already?<br>
&gt;&gt;&gt;&gt; It can fail if global tracking is *not* started yet.<br>
&gt;&gt;&gt;&gt; As mentioned in the commit message, there is a time window=
 where migration<br>
&gt;&gt;&gt;&gt; is in SETUP state but global tracking is not started yet.<=
br>
&gt;&gt;&gt; Hmm, I&#39;m totally confused now..<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The only thing that can kickoff the sync during SETUP, AFAICT,=
 is:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D =
memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, errp);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ret=
) {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0goto out_unlock;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0migratio=
n_bitmap_sync_precopy(false);=C2=A0 =C2=A0&lt;------------- here<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I need to confess this may not be the right place to invoke it=
 in ram.c (I<br>
&gt;&gt;&gt; think we probably should move it out at some point.. into gene=
ric migration<br>
&gt;&gt;&gt; code).=C2=A0 However I don&#39;t yet see why log_start() is no=
t called first in your<br>
&gt;&gt;&gt; case before log_sync().<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Could you elaborate?<br>
&gt;&gt; Indeed, in the above code log_start is called before log_sync.<br>
&gt;&gt;<br>
&gt;&gt; I was referring to the case where some other code path triggers lo=
g_sync.<br>
&gt;&gt; E.g., if you open a VNC to the guest then it constantly calls log_=
sync to<br>
&gt;&gt; refresh the graphics. In that case, one of these log_syncs can hap=
pen<br>
&gt;&gt; between &quot;migration status is set to SETUP&quot; and &quot;glo=
bal tracking is started&quot;.<br>
&gt; I see.=C2=A0 That&#39;s unfortunate..<br>
&gt;<br>
&gt; Though this is also the case where it shouldn&#39;t be VFIO&#39;s prob=
lem alone.<br>
&gt; See some other users of log_sync():<br>
&gt;<br>
&gt; vhost_sync_dirty_bitmap():<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!dev-&gt;log_enabled || !dev-&gt;started) {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; kvm_slot_get_dirty_log():<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D -ENOENT) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* kernel does not have dirty bitmap=
 in this slot */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; And I didn&#39;t further look.<br>
&gt;<br>
&gt; In short, IMHO looks like VFIO still shouldn&#39;t be special on diffe=
reciating<br>
&gt; and make migration export the SETUP phase just for this..=C2=A0 as VFI=
O has<br>
&gt; log_start() like all the rest, so VFIO can also know whether tracking =
is<br>
&gt; enabled at all, then it can silently no-op the log_sync() like all the=
 rest<br>
&gt; of the users.<br>
&gt;<br>
&gt; If you agree, I&#39;d prefer we keep this patch - it&#39;ll be nice we=
 only ever<br>
&gt; expose migration_is_running() for migration status checks, without exp=
osing<br>
&gt; SETUP only for this VFIO use case even if it could have followed what =
other<br>
&gt; modules are doing.<br>
<br>
Yes, I agree this could be a nice cleanup.<br>
<br>
&gt;<br>
&gt; If you would like to propose a patch for VFIO, I&#39;d be happy to inc=
lude your<br>
&gt; patch before this patch (just in case this patch could land some day) =
to<br>
&gt; make sure VFIO works as before.=C2=A0 Since I don&#39;t have VFIO HW t=
o test, it&#39;ll<br>
&gt; be challenging for me to propose and test such patch otherwise.<br>
<br>
I can do that, though it may be a bit involved because VFIO has multiple <b=
r>
dirty tracking mechanisms (legacy, device DPT and IOMMU DPT). Plus, I <br>
don&#39;t have HW that supports IOMMU DPT at hand for testing.<br>
I assume this is not an urgent cleanup, right?<br></blockquote></div></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Yes there&#39;s no rush.=C2=
=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">If you agree with th=
e change, feel free to clean this helper up when you post the vfio changes.=
=C2=A0 We can still have one more helper exported before that.=C2=A0</div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Thanks a lot.</div><div dir=3D=
"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
<br>
Thanks.<br>
<br>
</blockquote></div></div></div>

--000000000000e58c130625b2bbbd--


