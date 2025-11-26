Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C747D11191
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 18:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOKR1-0004ey-3Q; Wed, 26 Nov 2025 13:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vOKQz-0004ep-IO
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:40:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vOKQx-0006TQ-Nk
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 13:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764182398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VgJIgZGjX1/Nnj1GlBbUGt0e1rb+9C4doZcOlxTCEl0=;
 b=C5bFP2qeV1i9sagMS9rWHE3J8IbzsIaFwN/dyQn/eu10GiGQLjM48GusSHElQbAcsZCVGY
 VF9LtNgK8dB4vWXNBaiXt/v0MT7cA64edRC01yDYtMOKDRnU6u6LrDyuTOoH9KpTdmqb92
 cxzwRpS9yboCROIwAtUO9lNolWUbzWY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-8bQlbAvOP_6odBkFHkfvzw-1; Wed, 26 Nov 2025 13:39:56 -0500
X-MC-Unique: 8bQlbAvOP_6odBkFHkfvzw-1
X-Mimecast-MFC-AGG-ID: 8bQlbAvOP_6odBkFHkfvzw_1764182396
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-7880e7c048cso816547b3.3
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 10:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764182396; x=1764787196; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VgJIgZGjX1/Nnj1GlBbUGt0e1rb+9C4doZcOlxTCEl0=;
 b=EW6+2r5L64MSMOBVzcgQVHAfaTSJV2TkPd/q4cW0kcWTFL9SndJYgF2Mu+K+ZWTW0f
 ENEBnAlClYlKRx/S18mCHzohjLkD3MM9CyttNGQQvnskKUwfqdRV2YqQCjIzfviqFqsf
 YzLjAEsTtX+IrpSw67tuGAv3l+ADF1Qacl1YLSm5GsaHxEtByx2XhFhkebK6qjvKTfuH
 4vsSpiUoajejL7p+Gg84cwRSKawjQL8oML6MYzO9GJ5VLFT0cHWc6p1SheY/2cNhCbZr
 wSz791eG3jyIEtNo9zRAkyjfT6Fp4KB9dRmnyMFYUGmpClMz9u5GTFsnWD18+dxwfTAs
 W+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764182396; x=1764787196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VgJIgZGjX1/Nnj1GlBbUGt0e1rb+9C4doZcOlxTCEl0=;
 b=nBoIJRh4H2BQ4dRhV0mm8rpifKqXy5x02uOVTfx37snw/WvjQAMWQvlGQuUZ29C5a1
 eTANE7CIZDhHqB5cljhhdnxsLfnmcrK5hvMU9xkGyR2Jr83FTCfuvUALwRJeYhGQc+jh
 4x0o67GwhRt8yMmXsQHEEnsY6p5+tsWwUCwxYzAI30FuHBesG4CD+OunhIPceydEPWvw
 1lfousFYS1kaqaczBNUWGWLUsEfxIgBpwFUQdIysffsnkDTg6slj/HR36qhuKVaJbbH6
 JEdh5FUC5kyuVs7F1SVd1fcFE4f7jCTnk+QNd19Hu4+WzjM0aFuAsdOwcA5iyimXeCJi
 C5uw==
X-Gm-Message-State: AOJu0YzsCEZNkBEgnNQh24FYsDa/M0ft9vg0zNKKiyImNEyqRFGJOHvH
 NaJAMoz3jsvS7d6Z05It+v3z2z3mLcLsyB+FDPnYX+F5OxSvaQBQnN2rooWTHpXFVKjw/u0wl7a
 NlQKEL7qLGTdU7N/gicewqF4yWuMmN95YurSbJvXEwkux5UnzK4Lm4J5tSPIdnXyjXSWRDEzfYI
 23RWvtrqEmJvemK6l1ugeEMvvfrOdgSY4=
X-Gm-Gg: ASbGnctnMdRI7MJlZujJSutj/fE3kw0POeJix3CxxyyedPYm+/H/MwgJq0yKpKkT894
 AwLNL/1fAJXVMM/gy3qyUuwBgsRv+/si0XFEHNRo5od1Rzn9YJRULsSIQ3COZluzy4cDzmNDvoF
 yefJmkOhhOoECsQeBNaUmi80Wfj/u7j5AG/vKjaEgkCxWAhGKoO+ieZtqZA/AOIoUczFEQhT6Nu
 apmg6r/P19zs6636bZDxSBXvQ==
X-Received: by 2002:a05:690c:3511:b0:789:29ba:562c with SMTP id
 00721157ae682-78a8b56aa72mr177944227b3.64.1764182396171; 
 Wed, 26 Nov 2025 10:39:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+9GTG7sLfU48FJ2T8bU9ufEPPyFQe/1yHRm5amI04eQXMhqvv0MR8wCOwndz35v3Z6YKRQFEfbMeUDr6z1AE=
X-Received: by 2002:a05:690c:3511:b0:789:29ba:562c with SMTP id
 00721157ae682-78a8b56aa72mr177943967b3.64.1764182395743; Wed, 26 Nov 2025
 10:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20251125040045.461148-1-jsnow@redhat.com>
 <20a0d8d1-d617-4a2d-93f7-c8f84d7b334f@redhat.com>
In-Reply-To: <20a0d8d1-d617-4a2d-93f7-c8f84d7b334f@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 26 Nov 2025 13:39:44 -0500
X-Gm-Features: AWmQ_bl-tSNSZAdZI_QCwVekUqq2tPDDaLa9QsoyrjrmXY0lOK1J-W_Pm4qJyto
Message-ID: <CAFn=p-ZnD5dVxaa16aMUpbPJTZpsc1HEh-exXW-HQKyaj53Gxw@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] python: drop qemu.qmp from qemu.git tree
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
Content-Type: multipart/alternative; boundary="00000000000004e597064483b950"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000004e597064483b950
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025, 12:34=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote=
:

> On 25/11/2025 05.00, John Snow wrote:
> > Hi, this series does a few things, but it's ultimately in service of
> > dropping the python qemu.qmp package from the qemu.git tree in favor of
> > using the standalone package instead, to prevent any further issues fro=
m
> > the two codebases diverging.
> >
> > v2:
> >
> >   - move "make check-venv" earlier in GitLab CI/CD pipeline, to avoid
> >     re-running configure
> >   - Fix functional tests not using PyPI to fetch pygdbmi package
> >   - Remove pre-requisites which are now merged
> >
> > I think this series is probably close, but with some attention needed o=
n
> > the mkvenv packages to allow installing the local python
> > packages. Everything else feels good-to-go, as far as I can tell.
>
>   Hi John,
>
> I gave the series a try in the CI, but the macOS and FreeBSD jobs are
> failing now:
>
>   https://gitlab.com/thuth/qemu/-/jobs/12211713065
>   https://gitlab.com/thuth/qemu/-/jobs/12211713061
>
> Have a look at .gitlab-ci.d/cirrus/README.rst if you want to enable these
> jobs in your gitlab CI, too.
>
>   HTH,
>    Thomas
>

Ah, nuts. OK, let me get those and then I'll apply any of your RBs that
still apply.

Thanks for the check.

>

--00000000000004e597064483b950
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 26, 2025, 12:34=E2=
=80=AFAM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 25/11/2025 05.=
00, John Snow wrote:<br>
&gt; Hi, this series does a few things, but it&#39;s ultimately in service =
of<br>
&gt; dropping the python qemu.qmp package from the qemu.git tree in favor o=
f<br>
&gt; using the standalone package instead, to prevent any further issues fr=
om<br>
&gt; the two codebases diverging.<br>
&gt; <br>
&gt; v2:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0- move &quot;make check-venv&quot; earlier in GitLab CI/CD=
 pipeline, to avoid<br>
&gt;=C2=A0 =C2=A0 =C2=A0re-running configure<br>
&gt;=C2=A0 =C2=A0- Fix functional tests not using PyPI to fetch pygdbmi pac=
kage<br>
&gt;=C2=A0 =C2=A0- Remove pre-requisites which are now merged<br>
&gt; <br>
&gt; I think this series is probably close, but with some attention needed =
on<br>
&gt; the mkvenv packages to allow installing the local python<br>
&gt; packages. Everything else feels good-to-go, as far as I can tell.<br>
<br>
=C2=A0 Hi John,<br>
<br>
I gave the series a try in the CI, but the macOS and FreeBSD jobs are <br>
failing now:<br>
<br>
=C2=A0 <a href=3D"https://gitlab.com/thuth/qemu/-/jobs/12211713065" rel=3D"=
noreferrer noreferrer" target=3D"_blank">https://gitlab.com/thuth/qemu/-/jo=
bs/12211713065</a><br>
=C2=A0 <a href=3D"https://gitlab.com/thuth/qemu/-/jobs/12211713061" rel=3D"=
noreferrer noreferrer" target=3D"_blank">https://gitlab.com/thuth/qemu/-/jo=
bs/12211713061</a><br>
<br>
Have a look at .gitlab-ci.d/cirrus/README.rst if you want to enable these <=
br>
jobs in your gitlab CI, too.<br>
<br>
=C2=A0 HTH,<br>
=C2=A0 =C2=A0Thomas<br></blockquote></div></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Ah, nuts. OK, let me get those and then I&#39;ll apply a=
ny of your RBs that still apply.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Thanks for the check.</div><div dir=3D"auto"><div class=3D"gmail_=
quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--00000000000004e597064483b950--


