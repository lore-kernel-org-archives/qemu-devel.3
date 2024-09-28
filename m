Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447CBCF6493
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2024 05:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suPgU-0001ZH-7t; Sat, 28 Sep 2024 01:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1suPgQ-0001Y2-Pq
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 01:07:54 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1suPgM-0000o3-Mc
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 01:07:54 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5e77a1c5ec6so650044eaf.2
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 22:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1727500066; x=1728104866;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yp0/k05xsBF/LDecO+41WOD7fuZjkp64JeEbjnVDa+8=;
 b=JuM3FX6IFiUwHramHiSjNFQ6jyEBA0XMQ+F02JOp9XI0HGJV18mhjVFrXCvTgRL2JY
 O1RYkD1uIhq+f77vg24VNL/qv4HwvZ7sZEIlxFD307Zj0EP9d164KEeholckk8JTScVE
 aC1aoEG4nEKsjPM9PhOrKjOkW4e3Bh3Zj8hIZaO6q2boYauDU+isHXxZg+ivr5YCWTN/
 /29W1+mfu7s68wGOrACvqES/7o6hIQ4QgFhF5hJbPYMHuKwG+mr8MQ1OwEvaLngw6dGi
 5Y4ogDrxuy+hPfb8kGt8sMQsINVTKbkhFMFfkMYHPHTEb8SpddVQfHLH7s4ac+wiTUfN
 K4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727500066; x=1728104866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yp0/k05xsBF/LDecO+41WOD7fuZjkp64JeEbjnVDa+8=;
 b=YzW49O7l9UnfmfqxJENvdl7mjtb0dScyrHK2tPD0Eo17xOhmzi6jAjOQoklDmKmfVb
 WNw5TiS8Us0JSNbQvcDc9Wf1r/1lZ5Tw16P8wu4EJ257PtYuu0LlPiwt8b5cb2eEyGaZ
 7PqBcGpnZzOsOD9mgVCKtfFd4oa/xShQ4dhmABIMMbZL31Efwwye+HB/VO7rdJ6vDvPD
 M5dyDIX7Itwj3f2txkkwQPup2EhM3iv/bRnBR7COcB1YiBwCoVq41amrgoUkz7rR8MQF
 0bYtOpCFNGWg3IPZynVlWcwVXfIIodfs32qfpSf3iUodC5eF9tzkhxEIDa+WUd681Ofy
 H5EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1sBqs5xA+l0rudRL1LsBiO5l4VxVQ67OzxpXFOd5Ap2Kdk+nw09tL/U5VHQcbD3YrK9Cy3Z3r8gwS@nongnu.org
X-Gm-Message-State: AOJu0Ywz8Xb3KG0d8VQTxYA6fSq6SwKFcW+KDBHUQI9MGQZbU4oFr14d
 f5Y4qS18CXbdm5dSttBytzihiTyx6bc5e6XrQ5iPUtKbz85Gm9q0Yu6aWl4mf7qPjgGc1kJo+eu
 LGh5+z9MtC2PBb5n8B9hh1+52YIkAfVHZO8Kymw==
X-Google-Smtp-Source: AGHT+IF5wQGJaslKIOlKYZuHmgYCpwlsKOIngBmM98S3miqujun+vG+Tq96/BJL2b0tXf2+gafzWwYpOsGt86wClq90=
X-Received: by 2002:a05:6870:498d:b0:261:1339:1cb9 with SMTP id
 586e51a60fabf-28710bd1554mr3868971fac.35.1727500065369; Fri, 27 Sep 2024
 22:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1726390098.git.yong.huang@smartx.com>
 <531750c8d7b6c09f877b5f335a60fab402c168be.1726390098.git.yong.huang@smartx.com>
 <87msk7z4l3.fsf@suse.de>
 <CAK9dgmb_rK5HJOGTG=KXKgH=e2e8JV8aqoOWUHBEyjnc-+kiqg@mail.gmail.com>
 <ZuxxOObKqS_G0Ela@x1n>
 <CAK9dgmYaE=poiwLQqD6qbjJQdgPLMn8cW8VO47xYFTBkNiUVLA@mail.gmail.com>
 <ZvRh0RhkUC-eLbjo@x1n>
 <CAK9dgmbi1VSXvxFjziH5PjaoiaQwBJ3z4ff1BAojtm26VTThUQ@mail.gmail.com>
 <ZvW8LxJsv3pRWom_@x1n>
 <CAK9dgma-RFQ3akWDFHW5VhMPOdbT4nizSrixQK9x4W7W249raQ@mail.gmail.com>
 <ZvbQ0RQx-zxOeo4Y@x1n>
In-Reply-To: <ZvbQ0RQx-zxOeo4Y@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Sat, 28 Sep 2024 13:07:29 +0800
Message-ID: <CAK9dgma00TxZBYi50o0EBCUcrEp9_z_G6B23uhnCEMGkvp3=hA@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] migration: Introduce structs for background sync
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000bf05b4062326f3f8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--000000000000bf05b4062326f3f8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 11:35=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:

> On Fri, Sep 27, 2024 at 10:50:01AM +0800, Yong Huang wrote:
> > On Fri, Sep 27, 2024 at 3:55=E2=80=AFAM Peter Xu <peterx@redhat.com> wr=
ote:
> >
> > > On Fri, Sep 27, 2024 at 02:13:47AM +0800, Yong Huang wrote:
> > > > On Thu, Sep 26, 2024 at 3:17=E2=80=AFAM Peter Xu <peterx@redhat.com=
> wrote:
> > > >
> > > > > On Fri, Sep 20, 2024 at 10:43:31AM +0800, Yong Huang wrote:
> > > > > > Yes, invoke migration_bitmap_sync_precopy more frequently is
> also my
> > > > > > first idea but it involves bitmap updating and interfere with t=
he
> > > > > behavior
> > > > > > of page sending, it also affects the migration information stat=
s
> and
> > > > > > interfere other migration logic such as migration_update_rates(=
).
> > > > >
> > > > > Could you elaborate?
> > > > >
> > > > > For example, what happens if we start to sync in
> ram_save_iterate() for
> > > > > some time intervals (e.g. 5 seconds)?
> > > > >
> > > >
> > > > I didn't try to sync in ram_save_iterate but in the
> > > > migration_bitmap_sync_precopy.
> > > >
> > > > If we use the migration_bitmap_sync_precopy in the ram_save_iterate
> > > > function,
> > > > This approach seems to be correct. However, the bitmap will be
> updated as
> > > > the
> > > > migration thread iterates through each dirty page in the RAMBlock
> list.
> > > > Compared
> > > > to the existing implementation, this is different but still
> > > straightforward;
> > > > I'll give it a shot soon to see if it works.
> > >
> > > It's still serialized in the migration thread, so I'd expect it is
> similar
> > >
> >
> > What does "serialized" mean?
>
> I meant sync() never happens before concurrently with RAM pages being
> iterated, simply because sync() previously only happens in the migration
> thread, which is still the same thread that initiate the movement of page=
s.
>
> >
> > How about we:
> > 1. invoke the migration_bitmap_sync_precopy in a timer(bg_sync_timer)
> hook,
> >    every 5 seconds.
> > 2. register the bg_sync_timer in the main loop when the machine starts
> like
> >     throttle_timer
> > 3. activate the timer when ram_save_iterate gets called and deactivate
> it in
> >     the ram_save_cleanup gracefully during migration.
> >
> > I think it is simple enough and also isn't "serialized"?
>
> If you want to do that with timer that's ok, but then IIUC it doesn't nee=
d
> to involve ram.c code at all.
>

The timer hook will call the migration_bitmap_sync_precopy()
which is implemented in ram.c, maybe we can define the hook
function in ram.c and expose it in ram.h?


>
> You can rely on cpu_throttle_get_percentage() too just like the throttle
> timer, and it'll work naturally with migration because outside migration
> the throttle will be cleared (cpu_throttle_stop() at finish/fail/cancel..=
).
>

Relying on cpu_throttle_get_percentage() may miss the sync time window
during the second iteration when it last a long time while the throtlle
hasn't  started yet. I'll think through your idea and apply it as possible.


>
> Then it also gracefully align the async thread sync() that it only happen=
s
> with auto-converge is enabled.  Yeh that may look better.. and stick the
> code together with cpu-throttle.c seems nice.
>
> Side note: one thing regarind to sync() is ram_init_bitmaps() sync once,
> while I don't see why it's necessary.  I remember I tried to remove it bu=
t
> maybe I hit some issues and I didn't dig further.  If you're working on
> sync() anyway not sure whether you'd like to have a look.
>
> --
> Peter Xu
>
>
Thanks,
Yong

--=20
Best regards

--000000000000bf05b4062326f3f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 27, 20=
24 at 11:35=E2=80=AFPM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com">pe=
terx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:so=
lid;border-left-color:rgb(204,204,204);padding-left:1ex">On Fri, Sep 27, 20=
24 at 10:50:01AM +0800, Yong Huang wrote:<br>
&gt; On Fri, Sep 27, 2024 at 3:55=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto=
:peterx@redhat.com" target=3D"_blank">peterx@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Fri, Sep 27, 2024 at 02:13:47AM +0800, Yong Huang wrote:<br>
&gt; &gt; &gt; On Thu, Sep 26, 2024 at 3:17=E2=80=AFAM Peter Xu &lt;<a href=
=3D"mailto:peterx@redhat.com" target=3D"_blank">peterx@redhat.com</a>&gt; w=
rote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Fri, Sep 20, 2024 at 10:43:31AM +0800, Yong Huang wr=
ote:<br>
&gt; &gt; &gt; &gt; &gt; Yes, invoke migration_bitmap_sync_precopy more fre=
quently is also my<br>
&gt; &gt; &gt; &gt; &gt; first idea but it involves bitmap updating and int=
erfere with the<br>
&gt; &gt; &gt; &gt; behavior<br>
&gt; &gt; &gt; &gt; &gt; of page sending, it also affects the migration inf=
ormation stats and<br>
&gt; &gt; &gt; &gt; &gt; interfere other migration logic such as migration_=
update_rates().<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Could you elaborate?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; For example, what happens if we start to sync in ram_sa=
ve_iterate() for<br>
&gt; &gt; &gt; &gt; some time intervals (e.g. 5 seconds)?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I didn&#39;t try to sync in ram_save_iterate but in the<br>
&gt; &gt; &gt; migration_bitmap_sync_precopy.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; If we use the migration_bitmap_sync_precopy in the ram_save_=
iterate<br>
&gt; &gt; &gt; function,<br>
&gt; &gt; &gt; This approach seems to be correct. However, the bitmap will =
be updated as<br>
&gt; &gt; &gt; the<br>
&gt; &gt; &gt; migration thread iterates through each dirty page in the RAM=
Block list.<br>
&gt; &gt; &gt; Compared<br>
&gt; &gt; &gt; to the existing implementation, this is different but still<=
br>
&gt; &gt; straightforward;<br>
&gt; &gt; &gt; I&#39;ll give it a shot soon to see if it works.<br>
&gt; &gt;<br>
&gt; &gt; It&#39;s still serialized in the migration thread, so I&#39;d exp=
ect it is similar<br>
&gt; &gt;<br>
&gt; <br>
&gt; What does &quot;serialized&quot; mean?<br>
<br>
I meant sync() never happens before concurrently with RAM pages being<br>
iterated, simply because sync() previously only happens in the migration<br=
>
thread, which is still the same thread that initiate the movement of pages.=
<br>
<br>
&gt; <br>
&gt; How about we:<br>
&gt; 1. invoke the migration_bitmap_sync_precopy in a timer(bg_sync_timer) =
hook,<br>
&gt;=C2=A0 =C2=A0 every 5 seconds.<br>
&gt; 2. register the bg_sync_timer in the main loop when the machine starts=
 like<br>
&gt;=C2=A0 =C2=A0 =C2=A0throttle_timer<br>
&gt; 3. activate the timer when ram_save_iterate gets called and deactivate=
 it in<br>
&gt;=C2=A0 =C2=A0 =C2=A0the ram_save_cleanup gracefully during migration.<b=
r>
&gt; <br>
&gt; I think it is simple enough and also isn&#39;t &quot;serialized&quot;?=
<br>
<br>
If you want to do that with timer that&#39;s ok, but then IIUC it doesn&#39=
;t need<br>
to involve ram.c code at all.<br></blockquote><div><br></div><div><div styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_defau=
lt">The timer hook will call the migration_bitmap_sync_precopy()=C2=A0</div=
><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"g=
mail_default">which is implemented in ram.c, maybe we can define the hook</=
div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=
=3D"gmail_default">function in ram.c and expose it in ram.h?</div></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(=
204,204,204);padding-left:1ex">
<br>
You can rely on cpu_throttle_get_percentage() too just like the throttle<br=
>
timer, and it&#39;ll work naturally with migration because outside migratio=
n<br>
the throttle will be cleared (cpu_throttle_stop() at finish/fail/cancel..).=
<br></blockquote><div><br></div><div><div class=3D"gmail_default"><font fac=
e=3D"comic sans ms, sans-serif">Relying on=C2=A0cpu_throttle_get_percentage=
() may miss the sync time window</font></div><div class=3D"gmail_default"><=
font face=3D"comic sans ms, sans-serif">during the second iteration when it=
 last a long time while the throtlle=C2=A0</font></div><div class=3D"gmail_=
default"><font face=3D"comic sans ms, sans-serif">hasn&#39;t =C2=A0started =
yet. I&#39;ll think through your idea and apply it as possible.</font></div=
></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-=
color:rgb(204,204,204);padding-left:1ex">
<br>
Then it also gracefully align the async thread sync() that it only happens<=
br>
with auto-converge is enabled.=C2=A0 Yeh that may look better.. and stick t=
he<br>
code together with cpu-throttle.c seems nice.<br>
<br>
Side note: one thing regarind to sync() is ram_init_bitmaps() sync once,<br=
>
while I don&#39;t see why it&#39;s necessary.=C2=A0 I remember I tried to r=
emove it but<br>
maybe I hit some issues and I didn&#39;t dig further.=C2=A0 If you&#39;re w=
orking on<br>
sync() anyway not sure whether you&#39;d like to have a look.<br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><br clear=3D"all"><div><div style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif" class=3D"gmail_default">Thanks,</div><div st=
yle=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_def=
ault">Yong</div><br></div><span class=3D"gmail_signature_prefix">-- </span>=
<br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=
=3D"comic sans ms, sans-serif">Best regards</font></div></div></div>

--000000000000bf05b4062326f3f8--

