Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681BFD11192
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 18:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOKTG-0006FL-Rf; Wed, 26 Nov 2025 13:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vOKT8-0006Dx-NL
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:42:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vOKT5-0000Wt-AB
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764182538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wWUAKdr7TF9WqTXSGHGwVXPkgPjMQNHV3lJb06LGxJc=;
 b=AEHniC0UbkRbu84ar6Qkaie0cB+T6YS6ZuhkTXIri4QBE0Dr6IEVOGGJTOPbtny4QyZXbS
 Fb+6fSA6+A9mzUYf3Fgtkc/iETT/crcfFqQeal/DEciVYXKI4cAMJCWWTq3cJpp6DqJoZa
 nmAvxCfTF7mwE3q+arx12sdOreD1wlE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-oEggyM4iNe22KzzPDEvp0g-1; Wed, 26 Nov 2025 13:42:16 -0500
X-MC-Unique: oEggyM4iNe22KzzPDEvp0g-1
X-Mimecast-MFC-AGG-ID: oEggyM4iNe22KzzPDEvp0g_1764182536
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-787ee7b3ddfso1094977b3.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 10:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764182536; x=1764787336; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wWUAKdr7TF9WqTXSGHGwVXPkgPjMQNHV3lJb06LGxJc=;
 b=oeZoe5SwiBFYBQhpSEEAA+kEq5swfuTOtstSCXdVgTVNHw/x2BmB9CRyHQsLMHdUma
 yYcsa3MUZMXriO0dK+zp7JGFBw57JgxhXh0gb1OxPBqIgwIZrqtTsTLIdTtTHT37HF8l
 m6BgGTbzYcgMvQVQckHMmStCGrCWq/s9KY3IKQKVmtC6y878laVUQiPRSKECFJirQ3lo
 L0p+9fVmb5lPWon5856CIzT3uHoqlvUwvkWQgGiigrgmk6tDfYwhd1ejQuQKeIEXeZ5E
 GCn1/8zockqAA/1y52Y22osGxWhujPb+T4jlR3Ua9TpJq4wENfUcZcGPmZ7L56I32x0M
 1yzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764182536; x=1764787336;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWUAKdr7TF9WqTXSGHGwVXPkgPjMQNHV3lJb06LGxJc=;
 b=QWFlN4cf2N4dafuara0kemFjr4oXoFfWsMI/mC0Pn30+ySdvQETTNWG3LL/K5PeFJl
 kH1nZiYnPHiATtjWMRwUAkNRFcyo6mLFdh6ZhRxJkWbX/FsJvWmzvNSHiX1dHsBVX5WW
 ihrEy4ked0CeCQ/+HCFEI9zn6ZUmxnBM54B2wqQDhzz6qy74qomX/QcSWze+rVu1vbK9
 OxE5jJP0ejDcgywtSqd1omC+dUDGybFyqPkdZc7LqgcsYcu4LTIBabaQp9G3T1/FcGby
 FmC5U2tp73dJdagQpksbWOKQQAWlU2nDrPjJOgtTEqs0cz9ttppYzVq+0tb67EEpbOp6
 eP5w==
X-Gm-Message-State: AOJu0YywVoIU9Fqy+fMvSd0WXRTdIihsUR5CvYM1XHpIQgEmSVGKqRE3
 9upVB4gkIwkUlAZSA2PVC/l9Wsez+z5rrzUDDx7IPe2mVh/xSAxAiGFrWfWxtz0ZcSpoI626aGx
 Zw6b/hKfZ1sVc5snnggslcSaSArHCHl/S4flGGjKwUCDmTGlYutAl6iPVpkCslTlDqTjgmoe4Bv
 u/56fxC1iEPWITsp+aXIZ+Jcc9oG2RMqU=
X-Gm-Gg: ASbGncuCyVxUlqCJ9KvM4SWfShrBpvcd+htuIT0RybcNn7dU/8ITLWGgrtm5Scr1nmV
 P8Y1XoAkL3Qw2C4DqA9fm71n3hUljiOJA7zaDz6XrFBC6hI82muvUwitVsIDt0/xguzz8Q7T1r9
 cqzyYjmeKKzKFS/voMq1/jxtIcbmHyzU0pG87DP/64Up9NV/NH7yDgLgQPKWLas9A6RSyGQqoHj
 MiQD9YJ+Pam0NxqbiuYbSX/HQ==
X-Received: by 2002:a05:690c:4d48:b0:785:f54a:998e with SMTP id
 00721157ae682-78a8b580a95mr147715687b3.69.1764182536134; 
 Wed, 26 Nov 2025 10:42:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGASkZrS+AdAofMXdoIMJtNzLuCD2r1DmRe98DAfIaKo4MM1wn11ewt1uGOzEfqX7cjTqMgTfROPBRFVX8jB2w=
X-Received: by 2002:a05:690c:4d48:b0:785:f54a:998e with SMTP id
 00721157ae682-78a8b580a95mr147715517b3.69.1764182535823; Wed, 26 Nov 2025
 10:42:15 -0800 (PST)
MIME-Version: 1.0
References: <20251125040045.461148-1-jsnow@redhat.com>
 <20251125040045.461148-11-jsnow@redhat.com>
 <fada9d5d-a2f7-4ebb-92ed-3f3a8627316f@redhat.com>
In-Reply-To: <fada9d5d-a2f7-4ebb-92ed-3f3a8627316f@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 26 Nov 2025 13:42:04 -0500
X-Gm-Features: AWmQ_bmO09CE51Xkp-k3BurBwH_7RsriA7ZvqtkRnrD3xtw25OEmHXzckwBQFRk
Message-ID: <CAFn=p-acdSkTu+wHiZCSV81=QRNnAGuSTzMTH5TJ=JOAB=5VbA@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] tests: conditionally run "make check-venv"
 during build phase
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000005df1e2064483c180"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000005df1e2064483c180
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025, 3:16=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote:

> On 25/11/2025 05.00, John Snow wrote:
> > Some tests need test dependencies, some tests don't. Instead of running
> > "make check" manually, use a CI variable for the template that allows u=
s
> > to front-load the testing dependencies without needing to incur another
> > re-configure command.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >   .gitlab-ci.d/buildtest-template.yml | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/.gitlab-ci.d/buildtest-template.yml
> b/.gitlab-ci.d/buildtest-template.yml
> > index d866cb12bb1..cfa123d3a10 100644
> > --- a/.gitlab-ci.d/buildtest-template.yml
> > +++ b/.gitlab-ci.d/buildtest-template.yml
> > @@ -32,6 +32,10 @@
> >         then
> >           pyvenv/bin/meson configure . -Dbackend_max_links=3D"$LD_JOBS"=
 ;
> >         fi || exit 1;
> > +    - if test -n "$SETUP_CHECK_VENV";
> > +      then
> > +        make check-venv;
> > +      fi;
> I'm not sure, but I think this is likely not quite working as you intende=
d
> it. The above code hunk is added to native_build_job_template, i.e. it's
> executed for the build-* jobs, but in the next patch, you only set the
> environment variable on the crash-test-* jobs. I don't think that the
> environment variables propagate backward from a later job to an earlier
> one.
>
> Looking at the output of another build job, e.g. build-system-alpine:
>
>   https://gitlab.com/thuth/qemu/-/jobs/12211712932#L2156
>
> ... it looks like pygdbmi is now also always installed there, i.e.
> something
> else triggers "check-venv" on all build jobs now, and that's why you were
> able to drop the "check-venv" in the crash-test-* jobs in the next patch
> now. No clue what's causing this now, but IMHO it should be fine if we
> just
> unconditionally do "check-venv" in all build jobs anyway (we also need th=
e
> venv in a bunch of other test jobs anyway), so I'd rather do the "make
> check-venv" in this patch unconditionally here, and drop the next patch
> that
> sets SETUP_CHECK_VENV in the crash-test jobs. WDYT?
>
>   Thomas
>

... Huh. Well, I think it's probably fine to do it unconditionally for now,
but in the future we might have even more deps that might cause more
delays, so it'd be nice to have this mechanism working.

Shame on me for not noticing. The CI runs just take so long that I'm
delighted when they pass =F0=9F=AB=A0

Lemme look into it, but you might be right that the unconditional approach
might be best...

>

--0000000000005df1e2064483c180
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 26, 2025, 3:16=E2=80=
=AFAM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 25/11/2025 05.00,=
 John Snow wrote:<br>
&gt; Some tests need test dependencies, some tests don&#39;t. Instead of ru=
nning<br>
&gt; &quot;make check&quot; manually, use a CI variable for the template th=
at allows us<br>
&gt; to front-load the testing dependencies without needing to incur anothe=
r<br>
&gt; re-configure command.<br>
&gt; <br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0.gitlab-ci.d/buildtest-template.yml | 4 ++++<br>
&gt;=C2=A0 =C2=A01 file changed, 4 insertions(+)<br>
&gt; <br>
&gt; diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildt=
est-template.yml<br>
&gt; index d866cb12bb1..cfa123d3a10 100644<br>
&gt; --- a/.gitlab-ci.d/buildtest-template.yml<br>
&gt; +++ b/.gitlab-ci.d/buildtest-template.yml<br>
&gt; @@ -32,6 +32,10 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pyvenv/bin/meson configure . -=
Dbackend_max_links=3D&quot;$LD_JOBS&quot; ;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi || exit 1;<br>
&gt; +=C2=A0 =C2=A0 - if test -n &quot;$SETUP_CHECK_VENV&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 make check-venv;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 fi;<br>
I&#39;m not sure, but I think this is likely not quite working as you inten=
ded <br>
it. The above code hunk is added to native_build_job_template, i.e. it&#39;=
s <br>
executed for the build-* jobs, but in the next patch, you only set the <br>
environment variable on the crash-test-* jobs. I don&#39;t think that the <=
br>
environment variables propagate backward from a later job to an earlier one=
.<br>
<br>
Looking at the output of another build job, e.g. build-system-alpine:<br>
<br>
=C2=A0 <a href=3D"https://gitlab.com/thuth/qemu/-/jobs/12211712932#L2156" r=
el=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/thuth/qem=
u/-/jobs/12211712932#L2156</a><br>
<br>
... it looks like pygdbmi is now also always installed there, i.e. somethin=
g <br>
else triggers &quot;check-venv&quot; on all build jobs now, and that&#39;s =
why you were <br>
able to drop the &quot;check-venv&quot; in the crash-test-* jobs in the nex=
t patch <br>
now. No clue what&#39;s causing this now, but IMHO it should be fine if we =
just <br>
unconditionally do &quot;check-venv&quot; in all build jobs anyway (we also=
 need the <br>
venv in a bunch of other test jobs anyway), so I&#39;d rather do the &quot;=
make <br>
check-venv&quot; in this patch unconditionally here, and drop the next patc=
h that <br>
sets SETUP_CHECK_VENV in the crash-test jobs. WDYT?<br>
<br>
=C2=A0 Thomas<br></blockquote></div></div><div dir=3D"auto"><br></div><div =
dir=3D"auto">... Huh. Well, I think it&#39;s probably fine to do it uncondi=
tionally for now, but in the future we might have even more deps that might=
 cause more delays, so it&#39;d be nice to have this mechanism working.</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Shame on me for not noticin=
g. The CI runs just take so long that I&#39;m delighted when they pass =F0=
=9F=AB=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">Lemme look int=
o it, but you might be right that the unconditional approach might be best.=
..</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container">=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000005df1e2064483c180--


