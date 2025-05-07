Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7DFC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 18:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCjQg-0006rT-GC; Wed, 07 May 2025 14:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uCjQf-0006rC-5J
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uCjQd-00029N-5k
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746642214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VOS4Py+5byH1ZINPqlue8nt6brSoEFYbR5RQEk2xzOk=;
 b=ggAWjbOExmpNN1vwlgNwhkSYd4I8xDJrF6HfoOdBPl36Eu0FrZmZ/M6CfDLNJN+tMvjSUB
 pfHlmVRKbOSlxYgZk/egdCtJxsmzqLXiVhvhiCgqMeflhkemjbLFRyNKRUozmVjyeK9HPd
 MYS3boABzgpQUpiN1xUw7Bic9JIURlw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-cDD1m3QlOSOVmxBAJxFbxw-1; Wed, 07 May 2025 14:23:32 -0400
X-MC-Unique: cDD1m3QlOSOVmxBAJxFbxw-1
X-Mimecast-MFC-AGG-ID: cDD1m3QlOSOVmxBAJxFbxw_1746642211
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-22e816139b8so1256185ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 11:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746642211; x=1747247011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VOS4Py+5byH1ZINPqlue8nt6brSoEFYbR5RQEk2xzOk=;
 b=SbvtcL6Ssnsiq3j/ZjCKYhOOefGoZF8MOqiQdOiXW2hExfPt41rTS5uk+89X8QuJf1
 80rSiefWE1n9iBB94OghjZXXDpYE5Ur0UOgNFsyA98pxyfKv3a6XulDJfVQ/VAvHQMc4
 /ZB7YnQQxHkglcEoS/tHYifPuudSHXl3jahXiVo0fwim713B2veoLCw2hO4B4EKChYVT
 D9S2R/eEVDoQUE+yP9Gcaa+JBLwbi/2QX7e8K4kzsWW1xLY3YOugg3Emds+msZlw+9ko
 gSwMeKyNRSBzlQCa/M1T2JrcQ9+vVxqNw+Ylq15nWV0roFHSicu1piOA/XhrGoy6FZwj
 YUqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBpLr8I5RNiLGP5J1qab4d6akopNiHZz6lQfHO88/kNz45GCS19iFI/GVRgTAGKNJX/J5gd421kiC/@nongnu.org
X-Gm-Message-State: AOJu0YxB2IjS75DX/BVXOGVFTy+teY0AUXMEVe7kDQ/IKo17XcXwaxYv
 dMiiA6p51R+oGpeacrSy66NJelUPWN/tRVaOMNjE23XGzHH1ZV9HYawqWJYrgJ9UpmdqaqquiYT
 +8W06ZEdI3cVizAi98+nMM0ZNJzB2A8VfZz6W2oJhYmSrxLU++2C/bTmBfI1uZziXJV6wA1ACyo
 pU6dez7gE12bzSgLlxe2kc149P9nU=
X-Gm-Gg: ASbGncthDaSVTPouZffvQEp/mjdDt8/YkhlJETUk/IC7swIEg0MHwefBo1xIlfEv2ph
 iPZKbJMu88CWSdXBmSRD5JkZ/x52nLvsOH363bDpiH2S3frH92yQ2Gz0bFwdK6UCch+QH+VA51K
 7PtRTFH2/cv0I/lFTABoJLrnWE
X-Received: by 2002:a17:902:ecca:b0:224:fa0:36d2 with SMTP id
 d9443c01a7336-22e5ea9545bmr54259385ad.26.1746642211585; 
 Wed, 07 May 2025 11:23:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1BzNZqPQJ5q6z60w/j2YgpU6hpwmcj+v+V8f1syxyBnW6RAAqfcmqgwq8oWQ4qy8AWS8WHUHOjuECrs7bvI8=
X-Received: by 2002:a17:902:ecca:b0:224:fa0:36d2 with SMTP id
 d9443c01a7336-22e5ea9545bmr54259125ad.26.1746642211309; Wed, 07 May 2025
 11:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250505-sphinx82-v1-0-85f2418b33b1@daynix.com>
 <20250505-sphinx82-v1-1-85f2418b33b1@daynix.com>
 <CAFn=p-bSMFVScSNewv_92-3u2FyyN5CYpUkABppazW53CUF-jw@mail.gmail.com>
 <871pt1ngeu.fsf@pond.sub.org>
In-Reply-To: <871pt1ngeu.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 7 May 2025 14:23:19 -0400
X-Gm-Features: ATxdqUEfCBAwIex4vDfs7-aYKyY9wrbMxzrFumIpg44Rb42o8x3-Ij_RxitLbwo
Message-ID: <CAFn=p-YmggufG8c7no68sSBca0_cZNO=fqZbLR0hcf2Lm40n_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs: Bump sphinx to 8.2.3
To: Markus Armbruster <armbru@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org, devel@daynix.com
Content-Type: multipart/alternative; boundary="0000000000008e302306348fd44c"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

--0000000000008e302306348fd44c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 1:22=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Mon, May 5, 2025 at 8:19=E2=80=AFAM Akihiko Odaki <akihiko.odaki@day=
nix.com>
> > wrote:
> >
> >> sphinx 5.3.0 fails with Python 3.13.1:
> >>
> >> ../docs/meson.build:37: WARNING:
> >> /home/me/qemu/build/pyvenv/bin/sphinx-build:
> >> Extension error:
> >> Could not import extension sphinx.builders.epub3 (exception: No module
> >> named 'imghdr')
> >>
> >> ../docs/meson.build:39:6: ERROR: Problem encountered: Install a Python=
 3
> >> version of python-sphinx and the readthedoc theme
> >>
> >> Bump sphinx to 8.2.3 and also sphinx_rtd_theme as required for the new
> >> sphinx version.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>
> [...]
>
> > Can we set our suggested version to 6.2.0 instead? This version removed
> > reliance on 'imghdr' but merely requires Python 3.8+ which is our curre=
nt
> > stated minimum.
> >
> > If Thomas upgrades our minimum Python to 3.9, then we could use somethi=
ng
> > as new as 7.2.0 which requires 3.9+.
>
> Thomas did: commit d64db833d6.
>

OK, that being said, let's try setting both the preferred and minimum
versions to *7.2.0*. We could theoretically aim higher, but let's start
conservatively for now and see what, if anything, breaks before we get more
adventurous.

I think 7.2 is new enough that I can remove the vast majority of the
compatibility crud in docs/sphinx/compat.py and it will make my life a lot
easier, without being so new as to require a bleeding edge version of
Python that may not be available on older platforms we still support for
package building.

I think it's not a huge deal to support Sphinx 7.x and 8.x for now. I am
just reluctant to suggest that we should have a pinned (very modern) Sphinx
version for doc building, because I do not know what the impact of that
would be on downstream builds that offer documentation from SRPM (Red Hat,
etc) which may not be able to procure a bleeding-edge Sphinx from PyPI from
an isolated build environment.


> > I'd say 8.0.0 is too new (requires 3.10+) and conflicts with our stated
> > minimums.
>
> Requiring more recent versions of dependencies for optional parts of the
> build can be okay, but the degradation must be graceful.
>
> This makes sense only when the more recent dependencies save us enough
> trouble to justify inconveniencing users stuck on older dependencies as
> well as the additional build system complexity.
>
> I have no opinion on whether that's the case here.  If you think it is,
> make your argument :)
>
> "Graceful" means that if we require Sphinx 8, which requires Python
> 3.10, the build must still succeed when we have only Python 3.9 (our
> stated minimum), but we don't build documentation then.  If the user
> demands documentation with configure --enable-docs, the build fails.
>
> [...]
>
>

--0000000000008e302306348fd44c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 7, =
2025 at 1:22=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Mon, May 5, 2025 at 8:19=E2=80=AFAM Akihiko Odaki &lt;<a href=3D"ma=
ilto:akihiko.odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</=
a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt;&gt; sphinx 5.3.0 fails with Python 3.13.1:<br>
&gt;&gt;<br>
&gt;&gt; ../docs/meson.build:37: WARNING:<br>
&gt;&gt; /home/me/qemu/build/pyvenv/bin/sphinx-build:<br>
&gt;&gt; Extension error:<br>
&gt;&gt; Could not import extension sphinx.builders.epub3 (exception: No mo=
dule<br>
&gt;&gt; named &#39;imghdr&#39;)<br>
&gt;&gt;<br>
&gt;&gt; ../docs/meson.build:39:6: ERROR: Problem encountered: Install a Py=
thon 3<br>
&gt;&gt; version of python-sphinx and the readthedoc theme<br>
&gt;&gt;<br>
&gt;&gt; Bump sphinx to 8.2.3 and also sphinx_rtd_theme as required for the=
 new<br>
&gt;&gt; sphinx version.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@d=
aynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
<br>
[...]<br>
<br>
&gt; Can we set our suggested version to 6.2.0 instead? This version remove=
d<br>
&gt; reliance on &#39;imghdr&#39; but merely requires Python 3.8+ which is =
our current<br>
&gt; stated minimum.<br>
&gt;<br>
&gt; If Thomas upgrades our minimum Python to 3.9, then we could use someth=
ing<br>
&gt; as new as 7.2.0 which requires 3.9+.<br>
<br>
Thomas did: commit d64db833d6.<br></blockquote><div><br></div><div>OK, that=
 being said, let&#39;s try setting both the preferred and minimum versions =
to *7.2.0*. We could theoretically aim higher, but let&#39;s start conserva=
tively for now and see what, if anything, breaks before we get more adventu=
rous.</div><div><br></div><div>I think 7.2 is new enough that I can remove =
the vast majority of the compatibility crud in docs/sphinx/compat.py and it=
 will make my life a lot easier, without being so new as to require a bleed=
ing edge version of Python that may not be available on older platforms we =
still support for package building.</div><div><br></div><div>I think it&#39=
;s not a huge deal to support Sphinx 7.x and 8.x for now. I am just relucta=
nt to suggest that we should have a pinned (very modern) Sphinx version for=
 doc building, because I do not know what the impact of that would be on do=
wnstream builds that offer documentation from SRPM (Red Hat, etc) which may=
 not be able to procure a bleeding-edge Sphinx from PyPI from an isolated b=
uild environment.</div><div><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
&gt; I&#39;d say 8.0.0 is too new (requires 3.10+) and conflicts with our s=
tated<br>
&gt; minimums.<br>
<br>
Requiring more recent versions of dependencies for optional parts of the<br=
>
build can be okay, but the degradation must be graceful.<br>
<br>
This makes sense only when the more recent dependencies save us enough<br>
trouble to justify inconveniencing users stuck on older dependencies as<br>
well as the additional build system complexity.<br>
<br>
I have no opinion on whether that&#39;s the case here.=C2=A0 If you think i=
t is,<br>
make your argument :)<br>
<br>
&quot;Graceful&quot; means that if we require Sphinx 8, which requires Pyth=
on<br>
3.10, the build must still succeed when we have only Python 3.9 (our<br>
stated minimum), but we don&#39;t build documentation then.=C2=A0 If the us=
er<br>
demands documentation with configure --enable-docs, the build fails.<br>
<br>
[...]<br>
<br>
</blockquote></div></div>

--0000000000008e302306348fd44c--


