Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD89C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYPTH-0005vG-ET; Mon, 29 Jul 2024 08:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYPTD-0005hG-Az
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:27:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYPTB-0000XE-6k
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722256036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r405Z4NsKXRYcliLg8shaLqdXo0KrWhdO/lyCwJFe8o=;
 b=Sg2b4NJVs7bLjRscLT3h8OkZNya/JqA0MXLHr0tR/OsARs1SPSXjKKdrFBqBMWP7FxxnjE
 eh6Uq3z2A/xrutflJ4vgfE1/f9zCr9JTjGhVGegkJiC181ds/wDoVfwCX2oXvdGix8LhxT
 PhwtmeGcACJhqUp51avFkLQmoN8+fMM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-3CQOwrDQP9KGCgU6lRksrQ-1; Mon, 29 Jul 2024 08:27:11 -0400
X-MC-Unique: 3CQOwrDQP9KGCgU6lRksrQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42808efc688so17100825e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 05:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722256030; x=1722860830;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r405Z4NsKXRYcliLg8shaLqdXo0KrWhdO/lyCwJFe8o=;
 b=nRtQjdmE7cxCeJKEd5JdJQEckS3elAwmOPC8AT9+50RnjKIYSQN3X6K9xYFqS1lxoi
 cIneKyVYVMB1fabsV66fiYeTVoPav/qq/V7AlF+9gxVh2IrkY8qtsKaK5SUXek2WZdS8
 A+iShWl/SgwHVgalZCYFQxqNvRNo5ldKM62Qw4WBB+vTVBmKvH25Qa+XwYklhvP3zmad
 YqJ0m67d7/J+aKNkqoSyHSRAAAo/tz7JXHb9Nv9tEF97OYSdJ7+Ps4PwWkYMCLv6Gi0N
 Y1h+/g7u40WPUurMc8s1tOjDnhf5ezLHjF18Y/LmBlRUiCl1/zPeiUfP69TWdh1Ye77A
 9mIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW46kqtv2wWUuGDHLCswCJBd+ef1A3VkDcKHy23P+RTKa6IHR6xBN2Rpy4OT1/8D7pG20KPCAfgqcGFdWEFGDxuilCc18M=
X-Gm-Message-State: AOJu0YyD31FwCq9xePLneW7tv8rR5CnDdS64KUEfLY5T/Tw1LrnimHWG
 4nusnGVg/HPRkYmM1BPUGw1eZcDZD3nc4GCgaHQpZPzDEWWRo7f3MqkoArbTbCv7W/245/Uztgc
 ha6fEqUwyxdOpKIxkgpAUpVRrQbGqMBr75+m8zsBA3donyLaRoAKLuuBYMsoepZm1XSccbzaA5+
 W3vdQ4k/I/HqXDaBNpzViKwVbN5mc=
X-Received: by 2002:a05:600c:3b1f:b0:426:61e8:fb3b with SMTP id
 5b1f17b1804b1-42811dcd275mr54887845e9.27.1722256030515; 
 Mon, 29 Jul 2024 05:27:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8sPSP11yJYI5lpeDiTIVAvXlfd14kPOkkKTG5mSZdtnGBZIo7Z/0q7mPdD8uoJ1EcXNxtekd8hvRz3q8Yoa8=
X-Received: by 2002:a05:600c:3b1f:b0:426:61e8:fb3b with SMTP id
 5b1f17b1804b1-42811dcd275mr54887615e9.27.1722256029967; Mon, 29 Jul 2024
 05:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240729094702.50282-1-kwolf@redhat.com>
 <20240729094702.50282-5-kwolf@redhat.com>
 <CABgObfYbpZ3JV5i_TKjobd6DrzYiy567YAfQbX+x5X7mj1=GKw@mail.gmail.com>
 <ZqeI8TiHg8caawXr@redhat.com>
In-Reply-To: <ZqeI8TiHg8caawXr@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 29 Jul 2024 14:26:57 +0200
Message-ID: <CABgObfbecac_70Pt4DWKPRm96VCOOCjGOCSB3TkkK490FmvPsg@mail.gmail.com>
Subject: Re: [PATCH 4/4] scsi-disk: Always report RESERVATION_CONFLICT to guest
To: Kevin Wolf <kwolf@redhat.com>
Cc: "open list:Block layer core" <qemu-block@nongnu.org>,
 Fam Zheng <fam@euphon.net>, 
 "Hajnoczi, Stefan" <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000e0f61d061e61fa78"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000e0f61d061e61fa78
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 29 lug 2024, 14:20 Kevin Wolf <kwolf@redhat.com> ha scritto:

> Apparently both oVirt and Kubevirt unconditionally use the stop policy,
> so I'm afraid in this case we must acknowledge that our expectations
> don't match reality.
>

Yeah, of course.

If I understand correctly, not having a pr-manager could mean that QEMU
> itself is sufficiently privileged and then the same logic would apply.
>
> But even if it means that we can't change any persistent reservations
> from the VM, what use would stopping the VM be? You would run into the
> exact case I'm describing in the commit message: You try to resume the
> VM and it immediately stops again because the request still doesn't get
> through. Or do you expect the host admin to take some manual action
> then?
>

Yes, if the PR operation is not allowed then the host admin would probably
get a notification and release the PR (or perhaps shutdown the VM with an
error) itself.

And what would you do about the Windows cluster validation case that
> intentionally sends a request which reservations don't and shouldn't
> allow? There is nothing on the host side to fix there. The guest is only
> happy when it gets an error back.
>

Yes, in that case (which is the most common one) there is nothing you can
do, so the patch is a good idea even if the case without a PR manager is a
bit murky.

Paolo

> > -        if (status =3D=3D CHECK_CONDITION) {
> > > +        switch (status) {
> > > +        case CHECK_CONDITION:
> > >              req_has_sense =3D true;
> > >              error =3D scsi_sense_buf_to_errno(r->req.sense,
> sizeof(r->req.sense));
> > > -        } else {
> > > +            break;
> > > +        case RESERVATION_CONFLICT:
> > > +            /* Don't apply the error policy, always report to the
> guest */
> >
> > This is the only case where you get error =3D=3D 0. Maybe remove it fro=
m
> > the initializer, and set it here?
>
> Not sure why the initialiser was added in the first place, but yes, I
> can do that.
>
> Kevin
>
> > On Mon, Jul 29, 2024 at 11:47=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> =
wrote:
> > >
> > > RESERVATION_CONFLICT is not a backend error, but indicates that the
> > > guest tried to make a request that it isn't allowed to execute. Pass
> the
> > > error to the guest so that it can decide what to do with it.
> > >
> > > Without this, if we stop the VM in response to a RESERVATION_CONFLICT=
,
> > > it can happen that the VM cannot be resumed any more because every
> > > attempt to resume it immediately runs into the same error and stops t=
he
> > > VM again.
> > >
> > > One case that expects RESERVATION_CONFLICT errors to be visible in th=
e
> > > guest is running the validation tests in Windows 2019's Failover
> Cluster
> > > Manager, which intentionally tries to execute invalid requests to see
> if
> > > they are properly rejected.
> > >
> > > Buglink: https://issues.redhat.com/browse/RHEL-50000
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  hw/scsi/scsi-disk.c | 15 +++++++++++----
> > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> > > index 69a195177e..e173b238de 100644
> > > --- a/hw/scsi/scsi-disk.c
> > > +++ b/hw/scsi/scsi-disk.c
> > > @@ -235,11 +235,17 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r=
,
> int ret, bool acct_failed)
> > >      } else {
> > >          /* A passthrough command has completed with nonzero status.
> */
> > >          status =3D ret;
> > > -        if (status =3D=3D CHECK_CONDITION) {
> > > +        switch (status) {
> > > +        case CHECK_CONDITION:
> > >              req_has_sense =3D true;
> > >              error =3D scsi_sense_buf_to_errno(r->req.sense,
> sizeof(r->req.sense));
> > > -        } else {
> > > +            break;
> > > +        case RESERVATION_CONFLICT:
> > > +            /* Don't apply the error policy, always report to the
> guest */
> > > +            break;
> > > +        default:
> > >              error =3D EINVAL;
> > > +            break;
> > >          }
> > >      }
> > >
> > > @@ -249,8 +255,9 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r,
> int ret, bool acct_failed)
> > >       * are usually retried immediately, so do not post them to QMP a=
nd
> > >       * do not account them as failed I/O.
> > >       */
> > > -    if (req_has_sense &&
> > > -        scsi_sense_buf_is_guest_recoverable(r->req.sense,
> sizeof(r->req.sense))) {
> > > +    if (!error || (req_has_sense &&
> > > +                   scsi_sense_buf_is_guest_recoverable(r->req.sense,
> > > +
>  sizeof(r->req.sense)))) {
> > >          action =3D BLOCK_ERROR_ACTION_REPORT;
> > >          acct_failed =3D false;
> > >      } else {
> > > --
> > > 2.45.2
> > >
> >
>
>

--000000000000e0f61d061e61fa78
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 29 lug 2024, 14:20 Kevin Wolf &lt;<a href=3D"ma=
ilto:kwolf@redhat.com">kwolf@redhat.com</a>&gt; ha scritto:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Apparently both oVirt and Kubev=
irt unconditionally use the stop policy,<br>
so I&#39;m afraid in this case we must acknowledge that our expectations<br=
>
don&#39;t match reality.<br></blockquote></div></div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">Yeah, of course.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">If I understand correctly, not having a pr-manager could=
 mean that QEMU<br>
itself is sufficiently privileged and then the same logic would apply.<br>
<br>
But even if it means that we can&#39;t change any persistent reservations<b=
r>
from the VM, what use would stopping the VM be? You would run into the<br>
exact case I&#39;m describing in the commit message: You try to resume the<=
br>
VM and it immediately stops again because the request still doesn&#39;t get=
<br>
through. Or do you expect the host admin to take some manual action<br>
then?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Yes, if the PR operation is not allowed then the host admin would prob=
ably get a notification and release the PR (or perhaps shutdown the VM with=
 an error) itself.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
And what would you do about the Windows cluster validation case that<br>
intentionally sends a request which reservations don&#39;t and shouldn&#39;=
t<br>
allow? There is nothing on the host side to fix there. The guest is only<br=
>
happy when it gets an error back.<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Yes, in that case (which is the most commo=
n one) there is nothing you can do, so the patch is a good idea even if the=
 case without a PR manager is a bit murky.</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status =3D=3D CHECK_CONDITION=
) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (status) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case CHECK_CONDITION:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 req_has_sense =3D=
 true;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D scsi_se=
nse_buf_to_errno(r-&gt;req.sense, sizeof(r-&gt;req.sense));<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case RESERVATION_CONFLICT:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Don&#39;t apply the=
 error policy, always report to the guest */<br>
&gt; <br>
&gt; This is the only case where you get error =3D=3D 0. Maybe remove it fr=
om<br>
&gt; the initializer, and set it here?<br>
<br>
Not sure why the initialiser was added in the first place, but yes, I<br>
can do that.<br>
<br>
Kevin<br>
<br>
&gt; On Mon, Jul 29, 2024 at 11:47=E2=80=AFAM Kevin Wolf &lt;<a href=3D"mai=
lto:kwolf@redhat.com" target=3D"_blank" rel=3D"noreferrer">kwolf@redhat.com=
</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; RESERVATION_CONFLICT is not a backend error, but indicates that t=
he<br>
&gt; &gt; guest tried to make a request that it isn&#39;t allowed to execut=
e. Pass the<br>
&gt; &gt; error to the guest so that it can decide what to do with it.<br>
&gt; &gt;<br>
&gt; &gt; Without this, if we stop the VM in response to a RESERVATION_CONF=
LICT,<br>
&gt; &gt; it can happen that the VM cannot be resumed any more because ever=
y<br>
&gt; &gt; attempt to resume it immediately runs into the same error and sto=
ps the<br>
&gt; &gt; VM again.<br>
&gt; &gt;<br>
&gt; &gt; One case that expects RESERVATION_CONFLICT errors to be visible i=
n the<br>
&gt; &gt; guest is running the validation tests in Windows 2019&#39;s Failo=
ver Cluster<br>
&gt; &gt; Manager, which intentionally tries to execute invalid requests to=
 see if<br>
&gt; &gt; they are properly rejected.<br>
&gt; &gt;<br>
&gt; &gt; Buglink: <a href=3D"https://issues.redhat.com/browse/RHEL-50000" =
rel=3D"noreferrer noreferrer" target=3D"_blank">https://issues.redhat.com/b=
rowse/RHEL-50000</a><br>
&gt; &gt; Signed-off-by: Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com"=
 target=3D"_blank" rel=3D"noreferrer">kwolf@redhat.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 hw/scsi/scsi-disk.c | 15 +++++++++++----<br>
&gt; &gt;=C2=A0 1 file changed, 11 insertions(+), 4 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c<br>
&gt; &gt; index 69a195177e..e173b238de 100644<br>
&gt; &gt; --- a/hw/scsi/scsi-disk.c<br>
&gt; &gt; +++ b/hw/scsi/scsi-disk.c<br>
&gt; &gt; @@ -235,11 +235,17 @@ static bool scsi_handle_rw_error(SCSIDiskRe=
q *r, int ret, bool acct_failed)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* A passthrough command has co=
mpleted with nonzero status.=C2=A0 */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D ret;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status =3D=3D CHECK_CONDITION) {=
<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (status) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case CHECK_CONDITION:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 req_has_sense =3D=
 true;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D scsi_se=
nse_buf_to_errno(r-&gt;req.sense, sizeof(r-&gt;req.sense));<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case RESERVATION_CONFLICT:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Don&#39;t apply the=
 error policy, always report to the guest */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D EINVAL;=
<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; @@ -249,8 +255,9 @@ static bool scsi_handle_rw_error(SCSIDiskReq =
*r, int ret, bool acct_failed)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* are usually retried immediately, so d=
o not post them to QMP and<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* do not account them as failed I/O.<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; -=C2=A0 =C2=A0 if (req_has_sense &amp;&amp;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 scsi_sense_buf_is_guest_recoverable(=
r-&gt;req.sense, sizeof(r-&gt;req.sense))) {<br>
&gt; &gt; +=C2=A0 =C2=A0 if (!error || (req_has_sense &amp;&amp;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0scsi_sense_buf_is_guest_recoverable(r-&gt;req.sense,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(r-&gt;req=
.sense)))) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 action =3D BLOCK_ERROR_ACTION_R=
EPORT;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 acct_failed =3D false;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt; --<br>
&gt; &gt; 2.45.2<br>
&gt; &gt;<br>
&gt; <br>
<br>
</blockquote></div></div></div>

--000000000000e0f61d061e61fa78--


