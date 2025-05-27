Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEE1C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 15:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJvop-0005Nu-F8; Tue, 27 May 2025 11:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uJvom-0005NZ-4u
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:02:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uJvof-0006Al-Iz
 for qemu-devel@nongnu.org; Tue, 27 May 2025 11:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748358122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JC0odE6qVln2tSU/zVV919W5R6mFRzSh7NwSc0WiKoQ=;
 b=fkrRhWAjGZU2FKtFkPWjC8GgODgtMoFl7dPHhTOVeVM03/RhKVjZ4tYX2y8lsewpnb/org
 Ry4zJecfNR8UTk42EFypplQRLpese36qyBtHLxbrcW7mK7lZVE4OampZMYcy+G6pg1LjGz
 hEQsQo0HUex0E2PoNQADGgi6Wkv2TnM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-dXSp74LFOny0UY7tvLlRPA-1; Tue, 27 May 2025 11:02:01 -0400
X-MC-Unique: dXSp74LFOny0UY7tvLlRPA-1
X-Mimecast-MFC-AGG-ID: dXSp74LFOny0UY7tvLlRPA_1748358120
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b1fa2cad5c9so2024316a12.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 08:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748358120; x=1748962920;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JC0odE6qVln2tSU/zVV919W5R6mFRzSh7NwSc0WiKoQ=;
 b=hwoq3VU8PMUUe4svrl+jHUFoiHUVhUz0PAnHRZyF5F5DVkKlVZG3IoK0USpw/ZdkXB
 VHERL+tNxluZ6yZYIY/Gcy7gl85CtDtnEo64dqWMMzDfzREVmxeWG3Gj8R7yh6l4GblI
 Mx8vLHVuGRYlaRx81imX7YJRdLwuzZPmMfwmhwczAI9AClDPvFPxKRrvFNBpHUjEUoab
 v4CpU+FRITfJXOTqca2pTmoi+txTMo1XcAf0QA5GtyeT4FiODN9tVokoEq+IJFP37B4B
 PJKaDWAvO3oWQfY2FZQOH7KPtvDJF93NKB7YP7QpCM1cF4XcT4XEgGoUyjyrFUASkor+
 jkfg==
X-Gm-Message-State: AOJu0YyFqA3k5mAFsRVcxmfKLYhHJwDoM/fW5YtcZxjFJyDingUH05xT
 Bg6TkFHa6/2Db6ptD6F+1JBsEBHuxXOatG9MOwT6HDpVYAJfPPvA5EbQcJjh9QDLLgWZ6yuuYOm
 efHotQx99SA+D4Z8N1cx5KpQoMNogVHa5/F103N9Dm3ZZkmD8+E5By93sd1AL4XzUpUcoIo0ViR
 NtpsiqVa2OeJp9vzMV3iXuQFrt2stPQRA=
X-Gm-Gg: ASbGncvOtltJB81POJ68ZD3bzHeyfkv6No4iN5E8BqBSWCFr1+/9fXguiGFCi5RYOPm
 PTL7EvRkvO6sYDSaYSpweP1ASF4kgHcjoAb237I8OQzrVhSScfV1dZmGUXpyAX3MZEpngT2cH5n
 w+cT+ggQHaPVYJCgc5y7J0QdBJ
X-Received: by 2002:a17:90b:2d81:b0:311:af76:35b2 with SMTP id
 98e67ed59e1d1-311af7638ddmr3604446a91.30.1748358113158; 
 Tue, 27 May 2025 08:01:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9/c+EmNApuFv63HFJ/5bVQ23ICeoNcNXsrbYr1Kq+5i/pKkYzenN1vB3lZRydmNOreNMk42BahUgpUn0OrNA=
X-Received: by 2002:a17:90b:2d81:b0:311:af76:35b2 with SMTP id
 98e67ed59e1d1-311af7638ddmr3603873a91.30.1748358106704; Tue, 27 May 2025
 08:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250519170055.3693275-1-jsnow@redhat.com>
 <CAJSP0QUT+rtmBKXa6Ve7oV_rWB4aGwTU3=xBmQTDWv0GT4zRDA@mail.gmail.com>
In-Reply-To: <CAJSP0QUT+rtmBKXa6Ve7oV_rWB4aGwTU3=xBmQTDWv0GT4zRDA@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 27 May 2025 11:01:35 -0400
X-Gm-Features: AX0GCFtKxn2kG1aa8wMJCicY6vz8WPJyKHfgM4gYgFYeEHaFKy5S5Hk8KMl5RUI
Message-ID: <CAFn=p-bwkEXC1xqGVyYZhk2gXBo6rMDqNviivioPGFD0mwiz8w@mail.gmail.com>
Subject: Re: [PULL 0/6] Python patches
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000e4f30a06361f5706"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

--000000000000e4f30a06361f5706
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 3:45=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:

> On Mon, May 19, 2025 at 1:03=E2=80=AFPM John Snow <jsnow@redhat.com> wrot=
e:
> >
> > The following changes since commit
> 757a34115e7491744a63dfc3d291fd1de5297ee2:
> >
> >   Merge tag 'pull-nvme-20250515' of https://gitlab.com/birkelund/qemu
> into staging (2025-05-15 13:42:27 -0400)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/jsnow/qemu.git tags/python-pull-request
> >
> > for you to fetch changes up to 818060c02a53df4b27bc86cbac3a26009996b6a4=
:
> >
> >   qapi: delete un-needed python static analysis configs (2025-05-19
> 12:44:01 -0400)
> >
> > ----------------------------------------------------------------
> > Python PR
> >
> > Add scripts/qapi and docs/sphinx/*qapi* to the Python static analysis
> checks
> >
> > ----------------------------------------------------------------
>
> Please take a look at this CI failure:
> https://gitlab.com/qemu-project/qemu/-/jobs/10135225231#L448


Well, that's interesting. Maybe something changed in the interim ...
investigating now, thank you - I will send a v2 PR if appropriate when I
identify the cause.

Thanks!
~js


>
>
> Thanks,
> Stefan
>
> >
> > John Snow (5):
> >   qapi: Add some pylint ignores
> >   docs/qapidoc: linting fixes
> >   python: update missing dependencies from minreqs
> >   python: add qapi static analysis tests
> >   qapi: delete un-needed python static analysis configs
> >
> > Markus Armbruster (1):
> >   python: Drop redundant warn_unused_configs =3D True
> >
> >  docs/sphinx/qapi_domain.py  | 25 ++++++++++++++-----------
> >  docs/sphinx/qapidoc.py      |  5 +++--
> >  python/setup.cfg            |  2 +-
> >  python/tests/minreqs.txt    | 25 +++++++++++++++++++++++++
> >  python/tests/qapi-flake8.sh |  4 ++++
> >  python/tests/qapi-isort.sh  |  6 ++++++
> >  python/tests/qapi-mypy.sh   |  2 ++
> >  python/tests/qapi-pylint.sh |  6 ++++++
> >  scripts/qapi/.flake8        |  3 ---
> >  scripts/qapi/.isort.cfg     |  7 -------
> >  scripts/qapi/backend.py     |  2 ++
> >  scripts/qapi/mypy.ini       |  4 ----
> >  scripts/qapi/pylintrc       |  1 +
> >  13 files changed, 64 insertions(+), 28 deletions(-)
> >  create mode 100755 python/tests/qapi-flake8.sh
> >  create mode 100755 python/tests/qapi-isort.sh
> >  create mode 100755 python/tests/qapi-mypy.sh
> >  create mode 100755 python/tests/qapi-pylint.sh
> >  delete mode 100644 scripts/qapi/.flake8
> >  delete mode 100644 scripts/qapi/.isort.cfg
> >  delete mode 100644 scripts/qapi/mypy.ini
> >
> > --
> > 2.48.1
> >
> >
> >
>
>

--000000000000e4f30a06361f5706
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 23,=
 2025 at 3:45=E2=80=AFPM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gma=
il.com">stefanha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On Mon, May 19, 2025 at 1:03=E2=80=AFPM John Snow=
 &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">jsnow@redhat.com=
</a>&gt; wrote:<br>
&gt;<br>
&gt; The following changes since commit 757a34115e7491744a63dfc3d291fd1de52=
97ee2:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0Merge tag &#39;pull-nvme-20250515&#39; of <a href=3D"https=
://gitlab.com/birkelund/qemu" rel=3D"noreferrer" target=3D"_blank">https://=
gitlab.com/birkelund/qemu</a> into staging (2025-05-15 13:42:27 -0400)<br>
&gt;<br>
&gt; are available in the Git repository at:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0<a href=3D"https://gitlab.com/jsnow/qemu.git" rel=3D"noref=
errer" target=3D"_blank">https://gitlab.com/jsnow/qemu.git</a> tags/python-=
pull-request<br>
&gt;<br>
&gt; for you to fetch changes up to 818060c02a53df4b27bc86cbac3a26009996b6a=
4:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0qapi: delete un-needed python static analysis configs (202=
5-05-19 12:44:01 -0400)<br>
&gt;<br>
&gt; ----------------------------------------------------------------<br>
&gt; Python PR<br>
&gt;<br>
&gt; Add scripts/qapi and docs/sphinx/*qapi* to the Python static analysis =
checks<br>
&gt;<br>
&gt; ----------------------------------------------------------------<br>
<br>
Please take a look at this CI failure:<br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/10135225231#L448" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/j=
obs/10135225231#L448</a></blockquote><div><br></div><div>Well, that&#39;s i=
nteresting. Maybe something changed in the interim ... investigating now, t=
hank you - I will send a v2 PR if appropriate when I identify the cause.</d=
iv><div><br></div><div>Thanks!</div><div>~js</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><br>
<br>
Thanks,<br>
Stefan<br>
<br>
&gt;<br>
&gt; John Snow (5):<br>
&gt;=C2=A0 =C2=A0qapi: Add some pylint ignores<br>
&gt;=C2=A0 =C2=A0docs/qapidoc: linting fixes<br>
&gt;=C2=A0 =C2=A0python: update missing dependencies from minreqs<br>
&gt;=C2=A0 =C2=A0python: add qapi static analysis tests<br>
&gt;=C2=A0 =C2=A0qapi: delete un-needed python static analysis configs<br>
&gt;<br>
&gt; Markus Armbruster (1):<br>
&gt;=C2=A0 =C2=A0python: Drop redundant warn_unused_configs =3D True<br>
&gt;<br>
&gt;=C2=A0 docs/sphinx/qapi_domain.py=C2=A0 | 25 ++++++++++++++-----------<=
br>
&gt;=C2=A0 docs/sphinx/qapidoc.py=C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 +++--<br>
&gt;=C2=A0 python/setup.cfg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 2 +-<br>
&gt;=C2=A0 python/tests/minreqs.txt=C2=A0 =C2=A0 | 25 +++++++++++++++++++++=
++++<br>
&gt;=C2=A0 python/tests/qapi-flake8.sh |=C2=A0 4 ++++<br>
&gt;=C2=A0 python/tests/qapi-isort.sh=C2=A0 |=C2=A0 6 ++++++<br>
&gt;=C2=A0 python/tests/qapi-mypy.sh=C2=A0 =C2=A0|=C2=A0 2 ++<br>
&gt;=C2=A0 python/tests/qapi-pylint.sh |=C2=A0 6 ++++++<br>
&gt;=C2=A0 scripts/qapi/.flake8=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ---<br=
>
&gt;=C2=A0 scripts/qapi/.isort.cfg=C2=A0 =C2=A0 =C2=A0|=C2=A0 7 -------<br>
&gt;=C2=A0 scripts/qapi/backend.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 ++<br>
&gt;=C2=A0 scripts/qapi/mypy.ini=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ----<b=
r>
&gt;=C2=A0 scripts/qapi/pylintrc=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 13 files changed, 64 insertions(+), 28 deletions(-)<br>
&gt;=C2=A0 create mode 100755 python/tests/qapi-flake8.sh<br>
&gt;=C2=A0 create mode 100755 python/tests/qapi-isort.sh<br>
&gt;=C2=A0 create mode 100755 python/tests/qapi-mypy.sh<br>
&gt;=C2=A0 create mode 100755 python/tests/qapi-pylint.sh<br>
&gt;=C2=A0 delete mode 100644 scripts/qapi/.flake8<br>
&gt;=C2=A0 delete mode 100644 scripts/qapi/.isort.cfg<br>
&gt;=C2=A0 delete mode 100644 scripts/qapi/mypy.ini<br>
&gt;<br>
&gt; --<br>
&gt; 2.48.1<br>
&gt;<br>
&gt;<br>
&gt;<br>
<br>
</blockquote></div></div>

--000000000000e4f30a06361f5706--


