Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2FAC61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyssE-0001LI-V8; Tue, 25 Aug 2026 11:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyssD-0001Hc-9M
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:15:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyssB-00074q-6x
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787670933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oU3LFcSoTDeD/NJDJlNkHIH2TPmw6Spu0GTQvonFYdw=;
 b=e4N1UMo1YkPnSgZb0Mf/EWzEpSprJRVPPxs7gAJRYZNWqaydEYFu1f48HJgP0nr3GI/Dbh
 Yu3vwh+LeUCiNA6rQg5sRXYpBgobwLTItSVIBUFJt27f9aolQSmfGKml/NzNQcLAS1SBkt
 beaDs0jtVwIU4Kc1oBAAC/uqS5J/fko=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-WSZbsAE3PjuGhE4-r5zw1w-1; Tue, 25 Aug 2026 11:15:30 -0400
X-MC-Unique: WSZbsAE3PjuGhE4-r5zw1w-1
X-Mimecast-MFC-AGG-ID: WSZbsAE3PjuGhE4-r5zw1w_1787670929
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-66c767e23f6so12581968d50.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 08:15:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787670929; cv=none;
 d=google.com; s=arc-20260327;
 b=MupqehjcKYJsLEC4D5xODunazC73Jn9Y6D4I/Ic68WrWbxoZSfz3u/WHzMOFw7FVdL
 obOocZlaWEmDlKyddh9x08erZvwT3t+weUnhlrOrsYV5Rhu6yAZe8Fr6c7kJdPNe8tmn
 ZnVAzdVCOCaIv+b9O8skNSHbQ5qSqpYvk7qjV8JEbTT62MRDxvhaOUDihR/fiqJu0wQt
 +ww8K8G+K3RJscaSfduPvEZ5oI1Jbv1kOKZZDCMjzsENzdf/uaqU/NPB/455gtB3n9Uw
 v/e8qoGdmeJq4QeLISYWNatMxsoZ8Q0SNzqIJH5L3Gqazxq9SnJAVAqrTzmxE8xog+v6
 S8Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oU3LFcSoTDeD/NJDJlNkHIH2TPmw6Spu0GTQvonFYdw=;
 fh=8ag+0XDzZ8LjH8guimS5vbVUfJCHy0d31qKJd/HIJ0g=;
 b=OGoUeJI6giBBR3FzdUpuR7u4EmQHMokG5o94PGgNrbp7OKsR0h4qBftKmr0l7Gv8sp
 6jwQ99HHHcp6WVpwBMZvSDYTouPhm7ai2xqgo8bohfUqVEt6Odw98C2ewZD1h/LopjkS
 uDuqAh3dcQ6Q47Pbd/7+jrq8sZZCtbEF7KMNGDzIHL45v3ykxNQiOn9XalLAX+NWMitA
 xT8M1lpyz6FzS4nKXc64yXnG2eUuoVLcyCDGUisPLJrJ0vAn8DxytwlLLHzmSAESiwGK
 UYVTEaTZFyWDiGh2ucdF5y44HB2X33ghD7EsgpP7ZOrE1iWg9nVtAzNS1Ock0/0BKDZM
 paEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787670929; x=1788275729; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oU3LFcSoTDeD/NJDJlNkHIH2TPmw6Spu0GTQvonFYdw=;
 b=pi1PgUKZepWotNGAlV4KSLbRMoAh3PdHiemiz92jwLXltWv/7G2M5EUoWma05gQXhO
 lMmhPOGB977sl8orlVd7VwbrC2DFpyWPjHCQUg46APW5jw2ALI6Lgpx7Y3p8ZaWpnwVH
 dmND+ikezOs2EB+m1cyrIyuN0RGIRYqvo64XH6C2SiSXu2KdPYpstErGmNMkHZr8ir/Z
 bcus+S39Q/TYl930fVKEqR7FC3L3zsMY9IJZL20oFflNBMSittIncyINNvsVya22xmxP
 QD3KwrnCKMlPcgrE43EVgDeigxkDh3hjiyRgVxB0WSln1KvSec6gsZ2ZOcUaI6MiZY/E
 sf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787670929; x=1788275729;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oU3LFcSoTDeD/NJDJlNkHIH2TPmw6Spu0GTQvonFYdw=;
 b=IDEdCl3PBP88OpXnjyzdMMlNAj92AQPkrRtrsk9kO3Z8q4RG2OLtodQ0STQxTiAYL3
 gg1xIjpwPbR1JD3CvRifkcjH+m8SYsHz1aPbKb8eQn6tAk/0FQyta72+GFnpn9dkodQw
 m1SrTfsyFLJUeNaC0wBd6Z2t3ZGRhgj5l1Oyho9eyoF078AzSkKKVVVCFDfSQoQ6mmmM
 HgzV3vOo8VTwI4jhB8E94CaRbZ32gpCUvb0z15voVTEASmPQZXcMc9h0gfxHTVJ4/sqd
 5ypH5bKs33SZBglpcpQyrwkpMOW28IKhlhScZrAErVhjcDm9V9Q8jQvVwwThTlZx1vV9
 HKYA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5WN/lcH31BeEeAPYsZbfNK9k6OkMLX8U+UTiF/zm0VbFRyb0dUmin9oxZvRzaZF0qeMvHgpb2XXxe@nongnu.org
X-Gm-Message-State: AFuF++mqazT8Ftjrd2M6PbbPRm4Z+ZqfwBqOCxugXduk6Vkt6AUifRtu
 XcbCHlMnoaIrxzYtcRgzZ439kkPEK2Q9FQl7dpk+XlrYE7jblAdBL+1d6p5g8oFlVLeDLXGHXJB
 fh+EVQ+07YP7YVJpWXUZdT8LqltMfg1wMaMkLkzYGVPIxUrViFXRQv6Kj+EU4G5hOyAZv/8lfLp
 1NmLq23BQlp9JBfdNJn0GvtsH2rhYInBU=
X-Gm-Gg: AR+sD10IkNeBp2+utbUsdzwAvdqQtYUCvqOMCU16lYpQewAUEnnWK9aUi2BVBrrCfhq
 rHVwZ9KAGn3gt8oPNftB+R82BG43X8v13Pqe5gRNZ7X4dUQlyPUZMAw2DRy6YQxLNy/mzNNlcPX
 FaKfQQ2eiVT/VRodlJE1YIJQS1Mfkp49hfnywTeLMxixRYeXsTsxkzpc2jjIgpqquVsTU85a0LQ
 WnKjhTDnqaqO6QL
X-Received: by 2002:a05:690e:1687:b0:66d:1851:1bc0 with SMTP id
 956f58d0204a3-66d18511c66mr1963052d50.36.1787670929250; 
 Tue, 25 Aug 2026 08:15:29 -0700 (PDT)
X-Received: by 2002:a05:690e:1687:b0:66d:1851:1bc0 with SMTP id
 956f58d0204a3-66d18511c66mr1963024d50.36.1787670928775; Tue, 25 Aug 2026
 08:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260825051441.1562454-1-jsnow@redhat.com>
 <20260825051441.1562454-2-jsnow@redhat.com>
 <87v78ypuq6.fsf@pond.sub.org> <ao1SrKepKx9b4o0D@redhat.com>
In-Reply-To: <ao1SrKepKx9b4o0D@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 25 Aug 2026 11:15:17 -0400
X-Gm-Features: AcwNN1V0-hcqmdcFSkB9hW5-LKOnxOWY5sVZIwYOyHuAe0oTMri5ksZUFks9lHA
Message-ID: <CAFn=p-Zs=85qVFA6aWuA7vpi_fY5SRM09T707_Tk4FxQEYqb6g@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] tests: update vm tests to prefer locally-built
 QEMU
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Warner Losh <imp@bsdimp.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cleber Rosa <crosa@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Reinoud Zandijk <reinoud@netbsd.org>, 
 Kyle Evans <kevans@freebsd.org>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: multipart/alternative; boundary="000000000000af87b60659e0921c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000af87b60659e0921c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026, 4:30=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@red=
hat.com>
wrote:

> On Tue, Aug 25, 2026 at 08:41:53AM +0200, Markus Armbruster wrote:
> > John Snow <jsnow@redhat.com> writes:
> >
> > > In 05e4982, we updated our QMP tests to prefer `-object monitor-qmp`,
> > > but this requires a sufficiently recent and modern version of QEMU to
> > > run correctly.
> >
> > So, some tests run incorrectly, and this patch fixes them.  Which ones
> > and how?  What broke them?  Commit 05e4982?  Is it worth a Fixes: tag?
>
> tests/vm/*  because they don't use QEMU from the build tree and so
> can't be assumed to have 'monitor-qmp' available, unlike the iotests /
> functional tests. Yes commit 05e4982, and yes add a Fixes.
>

Will do.


> >
> > > Update the "make vm-run-xxx"


* make vm-build-xxx. Thinko.

targets to use the runscript that will
> > > naturally prefer the locally built version of QEMU so that these test=
s
> > > launch successfully once more.
> > >
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > ---
> > >  tests/vm/Makefile.include | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> > > index 0a53dc9fdd6..0ec1b47e63e 100644
> > > --- a/tests/vm/Makefile.include
> > > +++ b/tests/vm/Makefile.include
> > > @@ -5,7 +5,7 @@ ifeq ($(realpath $(SRC_PATH)),$(realpath .))
> > >  VM_PYTHON =3D $(SRC_PATH)/vm-venv/bin/python3
> > >  VM_VENV =3D vm-venv
> > >  else
> > > -VM_PYTHON =3D $(PYTHON)
> > > +VM_PYTHON =3D $(BUILD_DIR)/run $(PYTHON)
> > >  VM_VENV =3D
> > >  endif
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--000000000000af87b60659e0921c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 25, 2026, 4:30=E2=80=
=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">be=
rrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On=
 Tue, Aug 25, 2026 at 08:41:53AM +0200, Markus Armbruster wrote:<br>
&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" re=
l=3D"noreferrer">jsnow@redhat.com</a>&gt; writes:<br>
&gt; <br>
&gt; &gt; In 05e4982, we updated our QMP tests to prefer `-object monitor-q=
mp`,<br>
&gt; &gt; but this requires a sufficiently recent and modern version of QEM=
U to<br>
&gt; &gt; run correctly.<br>
&gt; <br>
&gt; So, some tests run incorrectly, and this patch fixes them.=C2=A0 Which=
 ones<br>
&gt; and how?=C2=A0 What broke them?=C2=A0 Commit 05e4982?=C2=A0 Is it wort=
h a Fixes: tag?<br>
<br>
tests/vm/*=C2=A0 because they don&#39;t use QEMU from the build tree and so=
<br>
can&#39;t be assumed to have &#39;monitor-qmp&#39; available, unlike the io=
tests /<br>
functional tests. Yes commit 05e4982, and yes add a Fixes.<br></blockquote>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Will do.</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_=
quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; <br>
&gt; &gt; Update the &quot;make vm-run-xxx&quot;</blockquote></div></div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">* make vm-build-xxx. Thinko.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote =
gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"> targets to use the r=
unscript that will<br>
&gt; &gt; naturally prefer the locally built version of QEMU so that these =
tests<br>
&gt; &gt; launch successfully once more.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 tests/vm/Makefile.include | 2 +-<br>
&gt; &gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.includ=
e<br>
&gt; &gt; index 0a53dc9fdd6..0ec1b47e63e 100644<br>
&gt; &gt; --- a/tests/vm/Makefile.include<br>
&gt; &gt; +++ b/tests/vm/Makefile.include<br>
&gt; &gt; @@ -5,7 +5,7 @@ ifeq ($(realpath $(SRC_PATH)),$(realpath .))<br>
&gt; &gt;=C2=A0 VM_PYTHON =3D $(SRC_PATH)/vm-venv/bin/python3<br>
&gt; &gt;=C2=A0 VM_VENV =3D vm-venv<br>
&gt; &gt;=C2=A0 else<br>
&gt; &gt; -VM_PYTHON =3D $(PYTHON)<br>
&gt; &gt; +VM_PYTHON =3D $(BUILD_DIR)/run $(PYTHON)<br>
&gt; &gt;=C2=A0 VM_VENV =3D<br>
&gt; &gt;=C2=A0 endif<br>
&gt; <br>
&gt; <br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://entangle-photo.org</a> :|<b=
r>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer noreferrer" =
target=3D"_blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =
=C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div></div></div>

--000000000000af87b60659e0921c--


