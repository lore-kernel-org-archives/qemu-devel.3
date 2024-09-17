Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54F9C35FEA
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 06:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqS5Q-0000av-Qe; Tue, 17 Sep 2024 02:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sqS5M-0000aK-3s
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 02:53:16 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sqS5J-0002lv-CV
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 02:53:15 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-277c861d9f6so1596939fac.2
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 23:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1726555992; x=1727160792;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IX5U4CTx7dC3DChb74dZMrcaZ89yEDGSjSrub4gYLS4=;
 b=uR2o97CRq+UzcEpvfTX+3C2YNRsXH6eshnsxgNwYm8jIPsBC58f1U3ZxmsFJoox9OE
 5NvTowva0exMqMB0kzfuB5i2lAvTYBx2rJte01zCI/H6kg9wIZ0CdRm401trSQ0axJG5
 qaWqbCUaxj5gSXKwlYpuoSyROcFGeN9RShPC187FTzjlzs7eCR7ezSrrgzgpg5tyqzvZ
 Q/aC3moljnVeuNhFLpMHcsm3gMZgNlrSbezeb8b9+1BCtWUQP9ZfMkCCQR9H2aDTOXJ5
 zRjedrBPowSIk4aG0wO5il7wwDA9hCzeML3jjrX8V/LgToryT5VHzxSe69r1SEefJ75b
 hkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726555992; x=1727160792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IX5U4CTx7dC3DChb74dZMrcaZ89yEDGSjSrub4gYLS4=;
 b=X8XxPSYXjk3bWGiifZKmdIoINsWy2pDVUYO8plF11jFhUoq/d4aEwTrVH/zMRISGC1
 vcr8QMWptNDiOvRl8WQIlotH1nHTVcF1q9CNy+pw+45RGq2oPSL0gPh4DuCtttYeZpUf
 bnzB0+B3io6wU53YvEjZub0/l1oJMWk26Ypt7LFGX3SwQy5PNmZ9KNxyXk1+oi+sttEV
 BL16IQgey6JgGWeNrO9SFfjxesi4+ZjnHL5A0QzEVRcPxDq75QRzY85QYsZ+dNHpsA6E
 840FTZBEZHmXTGmFVO1DNAsG7aGYWZQQqoOES82E0LHC/HK8b7QMdb8Y4Tf16LaLgX7/
 Ciig==
X-Gm-Message-State: AOJu0YwdO+w7xBe4+G51Oba+AMyAiSyozPGmRFo9ph/5hlmq/p7jgltr
 BryFUsBjOxmhMvZGul8KeHOiSlISrUxVGbPI9m9wHDFVp+D2X0Jv2hwaqaELuusJRotMC1iJcbx
 384rE3nkQyRXeJztxmRtASnc10jPGuIOBW5HMZOphWcR+g7Je5NhcECai
X-Google-Smtp-Source: AGHT+IEyC1ztPFHFBGFRBWwRpWkhKRgOftYEyq3QvSY4zkC5dVJ2x2qflg3gJlcZloKLT53umHxh6yOpTqx2eL+WgEk=
X-Received: by 2002:a05:6871:ca16:b0:261:164e:d12a with SMTP id
 586e51a60fabf-27c689cb4femr8160532fac.22.1726555991334; Mon, 16 Sep 2024
 23:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1726390098.git.yong.huang@smartx.com>
 <654bfad294e2cc3394f744bd8536e0448c0bf550.1726390099.git.yong.huang@smartx.com>
 <87v7yvz697.fsf@suse.de>
In-Reply-To: <87v7yvz697.fsf@suse.de>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 17 Sep 2024 14:52:55 +0800
Message-ID: <CAK9dgmY86NP6Gu74ZCf1sOG=xp+sQXe40Y7ssv-50O0wmcS=cQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] qapi/migration: Introduce the iteration-count
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008c79c406224b24cc"
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--0000000000008c79c406224b24cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 4:35=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:

> Hyman Huang <yong.huang@smartx.com> writes:
>
> > The original migration information dirty-sync-count could
> > no longer reflect iteration count due to the introduction
> > of background synchronization in the next commit;
> > add the iteration count to compensate.
>
> I agree with the overall idea, but I feel we're lacking some information
> on what determines whether some of the lines below want to use the
> iteration count vs. the dirty sync count. Since this patch increments
> both variables at the same place, they can still be used interchangeably
> unless we add some words to explain the distinction.
>
> So to clarify:
>
> What do we call an iteration? A call to save_live_iterate(),
> migration_iteration_run() or something else?
>
> Why dirty-sync-count should ever have reflected "iteration count"? It
> might have been this way by coincidence, but did we ever used it in that
> sense (aside from info migrate maybe)?
>
> With the new counter, what kind of meaning can a user extract from that
> number aside from "some undescribed thing happened N times" (this might
> be included in the migration.json docs)?
>

Alright, I'll make some revisions to the docs in the upcoming version
and see if it clarifies the meaning of these two pieces of information.


> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > ---
> >  migration/migration-stats.h  |  4 ++++
> >  migration/migration.c        |  1 +
> >  migration/ram.c              | 12 ++++++++----
> >  qapi/migration.json          |  6 +++++-
> >  tests/qtest/migration-test.c |  2 +-
> >  5 files changed, 19 insertions(+), 6 deletions(-)
> >
> > diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> > index 05290ade76..43ee0f4f05 100644
> > --- a/migration/migration-stats.h
> > +++ b/migration/migration-stats.h
> > @@ -50,6 +50,10 @@ typedef struct {
> >       * Number of times we have synchronized guest bitmaps.
> >       */
> >      Stat64 dirty_sync_count;
> > +    /*
> > +     * Number of migration iteration processed.
> > +     */
> > +    Stat64 iteration_count;
> >      /*
> >       * Number of times zero copy failed to send any page using zero
> >       * copy.
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 3dea06d577..055d527ff6 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1197,6 +1197,7 @@ static void populate_ram_info(MigrationInfo *info=
,
> MigrationState *s)
> >      info->ram->mbps =3D s->mbps;
> >      info->ram->dirty_sync_count =3D
> >          stat64_get(&mig_stats.dirty_sync_count);
> > +    info->ram->iteration_count =3D stat64_get(&mig_stats.iteration_cou=
nt);
> >      info->ram->dirty_sync_missed_zero_copy =3D
> >          stat64_get(&mig_stats.dirty_sync_missed_zero_copy);
> >      info->ram->postcopy_requests =3D
> > diff --git a/migration/ram.c b/migration/ram.c
> > index e205806a5f..ca5a1b5f16 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -594,7 +594,7 @@ static void xbzrle_cache_zero_page(ram_addr_t
> current_addr)
> >      /* We don't care if this fails to allocate a new cache page
> >       * as long as it updated an old one */
> >      cache_insert(XBZRLE.cache, current_addr, XBZRLE.zero_target_page,
> > -                 stat64_get(&mig_stats.dirty_sync_count));
> > +                 stat64_get(&mig_stats.iteration_count));
> >  }
> >
> >  #define ENCODING_FLAG_XBZRLE 0x1
> > @@ -620,7 +620,7 @@ static int save_xbzrle_page(RAMState *rs,
> PageSearchStatus *pss,
> >      int encoded_len =3D 0, bytes_xbzrle;
> >      uint8_t *prev_cached_page;
> >      QEMUFile *file =3D pss->pss_channel;
> > -    uint64_t generation =3D stat64_get(&mig_stats.dirty_sync_count);
> > +    uint64_t generation =3D stat64_get(&mig_stats.iteration_count);
> >
> >      if (!cache_is_cached(XBZRLE.cache, current_addr, generation)) {
> >          xbzrle_counters.cache_miss++;
> > @@ -1079,6 +1079,10 @@ static void migration_bitmap_sync(RAMState *rs,
> >      RAMBlock *block;
> >      int64_t end_time;
> >
> > +    if (!background) {
> > +        stat64_add(&mig_stats.iteration_count, 1);
> > +    }
> > +
> >      stat64_add(&mig_stats.dirty_sync_count, 1);
> >
> >      if (!rs->time_last_bitmap_sync) {
> > @@ -1115,8 +1119,8 @@ static void migration_bitmap_sync(RAMState *rs,
> >          rs->num_dirty_pages_period =3D 0;
> >          rs->bytes_xfer_prev =3D migration_transferred_bytes();
> >      }
> > -    if (migrate_events()) {
> > -        uint64_t generation =3D stat64_get(&mig_stats.dirty_sync_count=
);
> > +    if (!background && migrate_events()) {
> > +        uint64_t generation =3D stat64_get(&mig_stats.iteration_count)=
;
> >          qapi_event_send_migration_pass(generation);
> >      }
> >  }
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index b66cccf107..95b490706c 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -60,6 +60,9 @@
> >  #     between 0 and @dirty-sync-count * @multifd-channels.  (since
> >  #     7.1)
> >  #
> > +# @iteration-count: The number of iterations since migration started.
> > +#     (since 9.2)
> > +#
> >  # Since: 0.14
> >  ##
> >  { 'struct': 'MigrationStats',
> > @@ -72,7 +75,8 @@
> >             'multifd-bytes': 'uint64', 'pages-per-second': 'uint64',
> >             'precopy-bytes': 'uint64', 'downtime-bytes': 'uint64',
> >             'postcopy-bytes': 'uint64',
> > -           'dirty-sync-missed-zero-copy': 'uint64' } }
> > +           'dirty-sync-missed-zero-copy': 'uint64',
> > +           'iteration-count' : 'int' } }
> >
> >  ##
> >  # @XBZRLECacheStats:
> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.=
c
> > index d6768d5d71..b796a90cad 100644
> > --- a/tests/qtest/migration-test.c
> > +++ b/tests/qtest/migration-test.c
> > @@ -278,7 +278,7 @@ static int64_t read_migrate_property_int(QTestState
> *who, const char *property)
> >
> >  static uint64_t get_migration_pass(QTestState *who)
> >  {
> > -    return read_ram_property_int(who, "dirty-sync-count");
> > +    return read_ram_property_int(who, "iteration-count");
> >  }
> >
> >  static void read_blocktime(QTestState *who)
>


--=20
Best regards

--0000000000008c79c406224b24cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 17, 20=
24 at 4:35=E2=80=AFAM Fabiano Rosas &lt;<a href=3D"mailto:farosas@suse.de">=
farosas@suse.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:so=
lid;border-left-color:rgb(204,204,204);padding-left:1ex">Hyman Huang &lt;<a=
 href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@smartx.=
com</a>&gt; writes:<br>
<br>
&gt; The original migration information dirty-sync-count could<br>
&gt; no longer reflect iteration count due to the introduction<br>
&gt; of background synchronization in the next commit;<br>
&gt; add the iteration count to compensate.<br>
<br>
I agree with the overall idea, but I feel we&#39;re lacking some informatio=
n<br>
on what determines whether some of the lines below want to use the<br>
iteration count vs. the dirty sync count. Since this patch increments<br>
both variables at the same place, they can still be used interchangeably<br=
>
unless we add some words to explain the distinction.<br>
<br>
So to clarify: <br>
<br>
What do we call an iteration? A call to save_live_iterate(),<br>
migration_iteration_run() or something else?<br>
<br>
Why dirty-sync-count should ever have reflected &quot;iteration count&quot;=
? It<br>
might have been this way by coincidence, but did we ever used it in that<br=
>
sense (aside from info migrate maybe)?<br>
<br>
With the new counter, what kind of meaning can a user extract from that<br>
number aside from &quot;some undescribed thing happened N times&quot; (this=
 might<br>
be included in the migration.json docs)?<br></blockquote><div><br></div><di=
v><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"=
gmail_default">Alright, I&#39;ll make some revisions to the docs in the upc=
oming version</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans=
-serif" class=3D"gmail_default">and see if it clarifies the meaning of thes=
e two pieces of information.</div></div><div><br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;borde=
r-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 migration/migration-stats.h=C2=A0 |=C2=A0 4 ++++<br>
&gt;=C2=A0 migration/migration.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| 12 ++++++++----<br>
&gt;=C2=A0 qapi/migration.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 =
+++++-<br>
&gt;=C2=A0 tests/qtest/migration-test.c |=C2=A0 2 +-<br>
&gt;=C2=A0 5 files changed, 19 insertions(+), 6 deletions(-)<br>
&gt;<br>
&gt; diff --git a/migration/migration-stats.h b/migration/migration-stats.h=
<br>
&gt; index 05290ade76..43ee0f4f05 100644<br>
&gt; --- a/migration/migration-stats.h<br>
&gt; +++ b/migration/migration-stats.h<br>
&gt; @@ -50,6 +50,10 @@ typedef struct {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* Number of times we have synchronized guest=
 bitmaps.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Stat64 dirty_sync_count;<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Number of migration iteration processed.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 Stat64 iteration_count;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* Number of times zero copy failed to send a=
ny page using zero<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* copy.<br>
&gt; diff --git a/migration/migration.c b/migration/migration.c<br>
&gt; index 3dea06d577..055d527ff6 100644<br>
&gt; --- a/migration/migration.c<br>
&gt; +++ b/migration/migration.c<br>
&gt; @@ -1197,6 +1197,7 @@ static void populate_ram_info(MigrationInfo *inf=
o, MigrationState *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 info-&gt;ram-&gt;mbps =3D s-&gt;mbps;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 info-&gt;ram-&gt;dirty_sync_count =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stat64_get(&amp;mig_stats.dirty_sync=
_count);<br>
&gt; +=C2=A0 =C2=A0 info-&gt;ram-&gt;iteration_count =3D stat64_get(&amp;mi=
g_stats.iteration_count);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 info-&gt;ram-&gt;dirty_sync_missed_zero_copy =3D<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stat64_get(&amp;mig_stats.dirty_sync=
_missed_zero_copy);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 info-&gt;ram-&gt;postcopy_requests =3D<br>
&gt; diff --git a/migration/ram.c b/migration/ram.c<br>
&gt; index e205806a5f..ca5a1b5f16 100644<br>
&gt; --- a/migration/ram.c<br>
&gt; +++ b/migration/ram.c<br>
&gt; @@ -594,7 +594,7 @@ static void xbzrle_cache_zero_page(ram_addr_t curr=
ent_addr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* We don&#39;t care if this fails to allocate a n=
ew cache page<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* as long as it updated an old one */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cache_insert(XBZRLE.cache, current_addr, XBZRLE.ze=
ro_target_page,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stat64_=
get(&amp;mig_stats.dirty_sync_count));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stat64_=
get(&amp;mig_stats.iteration_count));<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define ENCODING_FLAG_XBZRLE 0x1<br>
&gt; @@ -620,7 +620,7 @@ static int save_xbzrle_page(RAMState *rs, PageSear=
chStatus *pss,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int encoded_len =3D 0, bytes_xbzrle;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint8_t *prev_cached_page;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QEMUFile *file =3D pss-&gt;pss_channel;<br>
&gt; -=C2=A0 =C2=A0 uint64_t generation =3D stat64_get(&amp;mig_stats.dirty=
_sync_count);<br>
&gt; +=C2=A0 =C2=A0 uint64_t generation =3D stat64_get(&amp;mig_stats.itera=
tion_count);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!cache_is_cached(XBZRLE.cache, current_addr, g=
eneration)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xbzrle_counters.cache_miss++;<br>
&gt; @@ -1079,6 +1079,10 @@ static void migration_bitmap_sync(RAMState *rs,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 RAMBlock *block;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int64_t end_time;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 if (!background) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 stat64_add(&amp;mig_stats.iteration_count=
, 1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 stat64_add(&amp;mig_stats.dirty_sync_count, 1);<br=
>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!rs-&gt;time_last_bitmap_sync) {<br>
&gt; @@ -1115,8 +1119,8 @@ static void migration_bitmap_sync(RAMState *rs,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rs-&gt;num_dirty_pages_period =3D 0;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rs-&gt;bytes_xfer_prev =3D migration=
_transferred_bytes();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 if (migrate_events()) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t generation =3D stat64_get(&amp;m=
ig_stats.dirty_sync_count);<br>
&gt; +=C2=A0 =C2=A0 if (!background &amp;&amp; migrate_events()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t generation =3D stat64_get(&amp;m=
ig_stats.iteration_count);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qapi_event_send_migration_pass(gener=
ation);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/qapi/migration.json b/qapi/migration.json<br>
&gt; index b66cccf107..95b490706c 100644<br>
&gt; --- a/qapi/migration.json<br>
&gt; +++ b/qapi/migration.json<br>
&gt; @@ -60,6 +60,9 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0between 0 and @dirty-sync-count * @multifd-=
channels.=C2=A0 (since<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A07.1)<br>
&gt;=C2=A0 #<br>
&gt; +# @iteration-count: The number of iterations since migration started.=
<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0(since 9.2)<br>
&gt; +#<br>
&gt;=C2=A0 # Since: 0.14<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 { &#39;struct&#39;: &#39;MigrationStats&#39;,<br>
&gt; @@ -72,7 +75,8 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;multifd-bytes&#39;=
: &#39;uint64&#39;, &#39;pages-per-second&#39;: &#39;uint64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;precopy-bytes&#39;=
: &#39;uint64&#39;, &#39;downtime-bytes&#39;: &#39;uint64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;postcopy-bytes&#39=
;: &#39;uint64&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;dirty-sync-missed-zero-=
copy&#39;: &#39;uint64&#39; } }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;dirty-sync-missed-zero-=
copy&#39;: &#39;uint64&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;iteration-count&#39; : =
&#39;int&#39; } }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @XBZRLECacheStats:<br>
&gt; diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test=
.c<br>
&gt; index d6768d5d71..b796a90cad 100644<br>
&gt; --- a/tests/qtest/migration-test.c<br>
&gt; +++ b/tests/qtest/migration-test.c<br>
&gt; @@ -278,7 +278,7 @@ static int64_t read_migrate_property_int(QTestStat=
e *who, const char *property)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static uint64_t get_migration_pass(QTestState *who)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 return read_ram_property_int(who, &quot;dirty-sync-coun=
t&quot;);<br>
&gt; +=C2=A0 =C2=A0 return read_ram_property_int(who, &quot;iteration-count=
&quot;);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void read_blocktime(QTestState *who)<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--0000000000008c79c406224b24cc--

