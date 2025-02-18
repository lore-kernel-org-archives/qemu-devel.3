Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFB9C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 22:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkVzh-0001uT-DU; Tue, 18 Feb 2025 17:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tkVzg-0001uE-Bp
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 17:23:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tkVzd-0001la-N4
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 17:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739917383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1K5ya19qpNs/VaXwLBZybqQPeSJ4K3XHrwQciIj1bwg=;
 b=Do56M+51q21i6EZkhPJ44CuDAVigRtcHyJyVp76FOe1aRd+y/EWQGf6AmS33I3Ao08NaYR
 aWTe8CjEGXEaXGpvlZvevibdn0cUKP6bEudOAGldxoMQBNcOB39TyLuVyGamBpmlXApU7R
 qK1i9iLNxdNobsGNFpSBJSUxFQntWVc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-wR7byp-wNn2G03ENUIvLkw-1; Tue, 18 Feb 2025 17:23:02 -0500
X-MC-Unique: wR7byp-wNn2G03ENUIvLkw-1
X-Mimecast-MFC-AGG-ID: wR7byp-wNn2G03ENUIvLkw_1739917381
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-220d9d98ea6so154758645ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 14:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739917381; x=1740522181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1K5ya19qpNs/VaXwLBZybqQPeSJ4K3XHrwQciIj1bwg=;
 b=AHq4L6XAnDn8pkJ82zqLumZ7wT5p7o2xmsS2843GYdUmuei7dtxYQGlVcOB3AIg+ib
 tkMaqvXgoBeZCKwgrPaSOiDIi+4XloVw5E28xOhfb6zxJ3roAN02xxHHGE156+AVANWN
 BDufHMTg8sFdjExdqI114BtLNO/U00F5+wNQaj7lcEJ1k8M6XegchXY+if6BVSynOj5o
 xCNRi7mmIW0j7WS+vLPqJRnkZjMmi7nDZ9SiltUJhcBV2+pvbMCSORU9QksKrwwgHsZl
 IHzSVeuybalKuxLjUMBLTWF73SxUA3DroCc6saRjWCLzxa/PCZpYTX31Ntisdg/71hwB
 bQjw==
X-Gm-Message-State: AOJu0YzOt3eQXiYM/wlBeqZD0ETNp/ZMVM/lTDve2OVhNw7faSMLsviV
 K1j2U2oCMVZvKmhSVDvB8w4lmpIDEg5y0ruu5KdA0px3yV7w5ix/FTOZYWPt/xuldGT4Wy5MHPf
 CHIN4LGXw9r5VI8f+fVWDQeUDze6PqS2jM3/4mvJ+UgA4/SpAB3Yg2pNufBnuc8jCBCvzD4b5l9
 aO93th+a8PhTtlg7+MgIK8tw8Pc4k=
X-Gm-Gg: ASbGncthen6RB99LuOqKuiIQM2KDTvTO/G2wIC6B4RVbIV5ZAkMZq39jP6JTHOAzSBc
 Z3jZk/pDluZBpQypX5ZLeEOECfui4bHR32VhZKGgw8GUwcHbLnVSdwMG2Mqi3tNhbYBNDs+SIWp
 otYvA9+OninB/N3EfG6w==
X-Received: by 2002:a17:902:fc4e:b0:21f:f3d:d533 with SMTP id
 d9443c01a7336-22103efec2cmr247989995ad.2.1739917380876; 
 Tue, 18 Feb 2025 14:23:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFg4tBhU4B+dYZBm4n/VVl0LcXw3rRyhyk9TbmcdxV73ZWIT7fByNORz8Y8VWoI5pIeR4zYBn++PEVPpB8MriQ=
X-Received: by 2002:a17:902:fc4e:b0:21f:f3d:d533 with SMTP id
 d9443c01a7336-22103efec2cmr247989725ad.2.1739917380549; Tue, 18 Feb 2025
 14:23:00 -0800 (PST)
MIME-Version: 1.0
References: <20250205231208.1480762-1-jsnow@redhat.com>
 <20250205231208.1480762-30-jsnow@redhat.com>
 <871pw3qzal.fsf@pond.sub.org>
In-Reply-To: <871pw3qzal.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 18 Feb 2025 17:22:48 -0500
X-Gm-Features: AWEUYZkzb7J1wHIn0CtAlJnzjPvnusbo5BLttuGpuwWtURq1ITRuGb6t9cl6yZ4
Message-ID: <CAFn=p-aCAVeF_kHM3C9_i8ZENmS1OksYp-NywtF7LhT3+tEBfg@mail.gmail.com>
Subject: Re: [PATCH 29/42] qapi: Add "Details:" disambiguation marker
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>, 
 Lukas Straub <lukasstraub2@web.de>, Eduardo Habkost <eduardo@habkost.net>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000681ffc062e7215ab"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000681ffc062e7215ab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 4:37=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This clarifies sections that are mistaken by the parser as "intro"
> > sections to be "details" sections instead.
>
> Impact on output?  See notes inline.
>

It's very possible that there is none; in cases where the text is not
inlined, it won't make any visual difference. The occurrences in this patch
were identified with a warning from the generator that I didn't actually
submit as part of this patch series.

I was obeying an unseen master.


>
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/machine.json      | 2 ++
> >  qapi/migration.json    | 4 ++++
> >  qapi/qom.json          | 4 ++++
> >  qapi/yank.json         | 2 ++
> >  scripts/qapi/parser.py | 8 ++++++++
> >  5 files changed, 20 insertions(+)
> >
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index a6b8795b09e..3c1b397f6cc 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -1301,6 +1301,8 @@
> >  # Return the amount of initially allocated and present hotpluggable
> >  # (if enabled) memory in bytes.
> >  #
> > +# Details:
> > +#
> >  # .. qmp-example::
> >  #
> >  #     -> { "execute": "query-memory-size-summary" }
>
> Output unchanged in my testing.  Same for the other hunks unless
> otherwise noted.
>
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 43babd1df41..9070a91e655 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -1920,6 +1920,8 @@
> >  #
> >  # Xen uses this command to notify replication to trigger a checkpoint.
> >  #
> > +# Details:
> > +#
> >  # .. qmp-example::
> >  #
> >  #     -> { "execute": "xen-colo-do-checkpoint" }
> > @@ -1993,6 +1995,8 @@
> >  #
> >  # Pause a migration.  Currently it only supports postcopy.
> >  #
> > +# Details:
> > +#
> >  # .. qmp-example::
> >  #
> >  #     -> { "execute": "migrate-pause" }
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 11277d1f84c..5d285ef9239 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -729,6 +729,8 @@
> >  #
> >  # Properties for memory-backend-shm objects.
> >  #
> > +# Details:
> > +#
> >  # This memory backend supports only shared memory, which is the
> >  # default.
> >  #
>
> The paragraphs moves from above to below the auto-generated member
> documentation, like this:
>
>     @@ -25908,13 +25908,13 @@ If
>
>      Properties for memory-backend-shm objects.
>
>     -This memory backend supports only shared memory, which is the defaul=
t.
>     -
>
>      Members
>      ~~~~~~~
>
>      The members of "MemoryBackendProperties"
>     +This memory backend supports only shared memory, which is the defaul=
t.
>     +
>
>      Since
>      ~~~~~
>
> This is sphinx-build -b text.  I don't understand why there is no blank
> line between "The members of ... " and the moved paragraph.
>

... Me either! I'll investigate.


>
> > @@ -744,6 +746,8 @@
> >  #
> >  # Properties for memory-backend-epc objects.
> >  #
> > +# Details:
> > +#
> >  # The @merge boolean option is false by default with epc
> >  #
> >  # The @dump boolean option is false by default with epc
>
> Likewise.
>
> > diff --git a/qapi/yank.json b/qapi/yank.json
> > index 30f46c97c98..4d36d21e76a 100644
> > --- a/qapi/yank.json
> > +++ b/qapi/yank.json
> > @@ -104,6 +104,8 @@
> >  #
> >  # Returns: list of @YankInstance
> >  #
> > +# Details:
> > +#
> >  # .. qmp-example::
> >  #
> >  #     -> { "execute": "query-yank" }
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index c5d2b950a82..5890a13b5ba 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -544,6 +544,14 @@ def _tag_check(what: str) -> None:
> >                          raise QAPIParseError(
> >                              self, 'feature descriptions expected')
> >                      have_tagged =3D True
> > +                elif line =3D=3D 'Details:':
> > +                    _tag_check("Details")
> > +                    self.accept(False)
> > +                    line =3D self.get_doc_line()
> > +                    while line =3D=3D '':
> > +                        self.accept(False)
> > +                        line =3D self.get_doc_line()
> > +                    have_tagged =3D True
> >                  elif match :=3D self._match_at_name_colon(line):
> >                      # description
> >                      if have_tagged:
>
>

--000000000000681ffc062e7215ab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 12,=
 2025 at 4:37=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This clarifies sections that are mistaken by the parser as &quot;intro=
&quot;<br>
&gt; sections to be &quot;details&quot; sections instead.<br>
<br>
Impact on output?=C2=A0 See notes inline.<br></blockquote><div><br></div><d=
iv>It&#39;s very possible that there is none; in cases where the text is no=
t inlined, it won&#39;t make any visual difference. The occurrences in this=
 patch were identified with a warning from the generator that I didn&#39;t =
actually submit as part of this patch series.<br></div><div><br></div><div>=
I was obeying an unseen master.</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/machine.json=C2=A0 =C2=A0 =C2=A0 | 2 ++<br>
&gt;=C2=A0 qapi/migration.json=C2=A0 =C2=A0 | 4 ++++<br>
&gt;=C2=A0 qapi/qom.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 ++++<br>
&gt;=C2=A0 qapi/yank.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
&gt;=C2=A0 scripts/qapi/parser.py | 8 ++++++++<br>
&gt;=C2=A0 5 files changed, 20 insertions(+)<br>
&gt;<br>
&gt; diff --git a/qapi/machine.json b/qapi/machine.json<br>
&gt; index a6b8795b09e..3c1b397f6cc 100644<br>
&gt; --- a/qapi/machine.json<br>
&gt; +++ b/qapi/machine.json<br>
&gt; @@ -1301,6 +1301,8 @@<br>
&gt;=C2=A0 # Return the amount of initially allocated and present hotplugga=
ble<br>
&gt;=C2=A0 # (if enabled) memory in bytes.<br>
&gt;=C2=A0 #<br>
&gt; +# Details:<br>
&gt; +#<br>
&gt;=C2=A0 # .. qmp-example::<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;query-me=
mory-size-summary&quot; }<br>
<br>
Output unchanged in my testing.=C2=A0 Same for the other hunks unless<br>
otherwise noted.<br>
<br>
&gt; diff --git a/qapi/migration.json b/qapi/migration.json<br>
&gt; index 43babd1df41..9070a91e655 100644<br>
&gt; --- a/qapi/migration.json<br>
&gt; +++ b/qapi/migration.json<br>
&gt; @@ -1920,6 +1920,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Xen uses this command to notify replication to trigger a check=
point.<br>
&gt;=C2=A0 #<br>
&gt; +# Details:<br>
&gt; +#<br>
&gt;=C2=A0 # .. qmp-example::<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;xen-colo=
-do-checkpoint&quot; }<br>
&gt; @@ -1993,6 +1995,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Pause a migration.=C2=A0 Currently it only supports postcopy.<=
br>
&gt;=C2=A0 #<br>
&gt; +# Details:<br>
&gt; +#<br>
&gt;=C2=A0 # .. qmp-example::<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;migrate-=
pause&quot; }<br>
&gt; diff --git a/qapi/qom.json b/qapi/qom.json<br>
&gt; index 11277d1f84c..5d285ef9239 100644<br>
&gt; --- a/qapi/qom.json<br>
&gt; +++ b/qapi/qom.json<br>
&gt; @@ -729,6 +729,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Properties for memory-backend-shm objects.<br>
&gt;=C2=A0 #<br>
&gt; +# Details:<br>
&gt; +#<br>
&gt;=C2=A0 # This memory backend supports only shared memory, which is the<=
br>
&gt;=C2=A0 # default.<br>
&gt;=C2=A0 #<br>
<br>
The paragraphs moves from above to below the auto-generated member<br>
documentation, like this:<br>
<br>
=C2=A0 =C2=A0 @@ -25908,13 +25908,13 @@ If<br>
<br>
=C2=A0 =C2=A0 =C2=A0Properties for memory-backend-shm objects.<br>
<br>
=C2=A0 =C2=A0 -This memory backend supports only shared memory, which is th=
e default.<br>
=C2=A0 =C2=A0 -<br>
<br>
=C2=A0 =C2=A0 =C2=A0Members<br>
=C2=A0 =C2=A0 =C2=A0~~~~~~~<br>
<br>
=C2=A0 =C2=A0 =C2=A0The members of &quot;MemoryBackendProperties&quot;<br>
=C2=A0 =C2=A0 +This memory backend supports only shared memory, which is th=
e default.<br>
=C2=A0 =C2=A0 +<br>
<br>
=C2=A0 =C2=A0 =C2=A0Since<br>
=C2=A0 =C2=A0 =C2=A0~~~~~<br>
<br>
This is sphinx-build -b text.=C2=A0 I don&#39;t understand why there is no =
blank<br>
line between &quot;The members of ... &quot; and the moved paragraph.<br></=
blockquote><div><br></div><div>... Me either! I&#39;ll investigate.</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; @@ -744,6 +746,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Properties for memory-backend-epc objects.<br>
&gt;=C2=A0 #<br>
&gt; +# Details:<br>
&gt; +#<br>
&gt;=C2=A0 # The @merge boolean option is false by default with epc<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # The @dump boolean option is false by default with epc<br>
<br>
Likewise.<br>
<br>
&gt; diff --git a/qapi/yank.json b/qapi/yank.json<br>
&gt; index 30f46c97c98..4d36d21e76a 100644<br>
&gt; --- a/qapi/yank.json<br>
&gt; +++ b/qapi/yank.json<br>
&gt; @@ -104,6 +104,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Returns: list of @YankInstance<br>
&gt;=C2=A0 #<br>
&gt; +# Details:<br>
&gt; +#<br>
&gt;=C2=A0 # .. qmp-example::<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;query-ya=
nk&quot; }<br>
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index c5d2b950a82..5890a13b5ba 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -544,6 +544,14 @@ def _tag_check(what: str) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 raise QAPIParseError(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self, &#39;feature descriptions expected=
&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 have_tagged =3D True<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif line =3D=
=3D &#39;Details:&#39;:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 _tag_check(&quot;Details&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 self.accept(False)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 line =3D self.get_doc_line()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 while line =3D=3D &#39;&#39;:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 self.accept(False)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 line =3D self.get_doc_line()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 have_tagged =3D True<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif mat=
ch :=3D self._match_at_name_colon(line):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # description<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if have_tagged:<br>
<br>
</blockquote></div></div>

--000000000000681ffc062e7215ab--


