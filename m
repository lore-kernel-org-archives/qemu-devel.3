Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DB4CF6489
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 23:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLrDJ-0006Od-FX; Wed, 19 Nov 2025 18:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vLrDH-0006OO-QJ
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 18:03:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vLrDF-00065T-Dk
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 18:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763593423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uaQN5vrD2V/uuFimblLdl9mjPqM/AA9UrSHNv0IuIto=;
 b=MkGoiH+V3QEO639Sz4xxlatJxL0sWZ6EJxUgnYxzRfXjQaHZxJ/plJd3iNWpTw/cRiQiDJ
 v3OLJ8nrmQ+Z6pF5Ip7kq2VfCx/84kVRVXRAS/l/vSl2PugS769jk2iveADQqisIlWSvWu
 fzlQesgHtjb6uOS1dTFlpm3f5YJiRUQ=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-Ax3wh9SMOKKsEENfrNciyw-1; Wed, 19 Nov 2025 18:03:39 -0500
X-MC-Unique: Ax3wh9SMOKKsEENfrNciyw-1
X-Mimecast-MFC-AGG-ID: Ax3wh9SMOKKsEENfrNciyw_1763593419
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-787cf398a53so3707797b3.3
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 15:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763593419; x=1764198219; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uaQN5vrD2V/uuFimblLdl9mjPqM/AA9UrSHNv0IuIto=;
 b=Km10fHnJJ2Eb+hFO1K3G1pEIRcAE3LN+UL+urDHY5ootBISlFqUEx+S275uME2mwR0
 eF4kTJTGiLSqIbOIlfg/iLzQ8lUu5v9k/En5tvJk4umhBlVnuzX37lhiW3SqbAf/56kR
 BWiJBPqkDDPcgoz4PHuHebAyhz4y6FuDRFfF8E5gcM9Wdq6NAdgvqhX1EMPkMQkgyagc
 9uEMemEpe/zW/cHGnIPhmdtaSMnzw3qtaRmFMGqvKQn7yotq+9VGLdFx4wPySv2pcxB7
 NZgXAl/IBWJuEFkWDPlT04XnxL+L+YbYgHm5HtXnS0uyaGhBTFYUslu5Xmz6Dm1CA34A
 7WzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763593419; x=1764198219;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uaQN5vrD2V/uuFimblLdl9mjPqM/AA9UrSHNv0IuIto=;
 b=pTxHu8z/uCvnfdgABxlPbSG3vONGU7m86GX4cLFYVQUhz3Tib0t9Flx9dweOaoVIe9
 bNJdOBxCPWXlY5sKVxGINMZ7T3Db9FTRir+m1tdOb3J/RswofU085GTpQomWqSjARNNF
 qdwbXAD4no1/CU4edFiTeVUBkTThV3d3gC6M2fAS09zUpNxSEkVjl1XpD6Uz7690N+Vk
 hiVFBoH9StknULMH9tbH0NuSwm7ceinT0TqVYMc1HHC4pTS6gUbcgSGX6AFzAMoh7OkB
 gZs0hAUSBphg1kIKE8G03XzTmWBGbXrpHw7DunZ4NTXA8rdbg7u/aha1OT65td2z4b6m
 8Vmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRXQBsc4rEueH37x7hDPC6tlT/3ZzGX4orxFpKL5y6Cgdf1OjSRKwinAFvwC56Lb7YjjfK2RLc+N6Q@nongnu.org
X-Gm-Message-State: AOJu0YyWDDHBgz6V4OdxxJXhFBdNQa2OHwNZTJi8c0fKrd4vUbuRlWaB
 2mw8hQBuHe+c48SBs8L8FPcCbYo3Y03k+zZX7fe7lXGpVdXTGaTPncoDYXnnXSHOMG+EKQhxGZX
 TLuzM2n8Z2kMBObwRvl/P2hiJne1ayHEO/Ki/c0Fow9o5vUbvE7kDhAuYa27acor+R1WuW7Gr4V
 mFzMIYWdIrzaVxQj3yNSiE2u2ACiE/uhg=
X-Gm-Gg: ASbGnctO1WZnsQqmU/SgBhmz11A+3VlxMuVbpeZp3HY9gx1zZ2RWBJRLMoJaZnfUR7m
 mWWi07oZ8CEZKX8iedhfYkrvmI2ynOgLKG3mS6D5mbBEZVOgPH8395oTofSZGKQwgKMDzPYQQP8
 IY3u3KuRrd+qhlXtD5DIXGmrHPtD06onAXEISXVAMLe83Qj3AGsaboOlNT8GorYlG2DnHo09wxl
 +XvcuXIK6JISMADjFJKD/ir6Q==
X-Received: by 2002:a05:690e:4105:b0:63f:a985:a02e with SMTP id
 956f58d0204a3-642f7d3401cmr688412d50.3.1763593418761; 
 Wed, 19 Nov 2025 15:03:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlkdFrk6V/5idmcA1O7iqQzsWeNs7lpZpUF0eaT8CCSyExYi4vEFJaoVMlLsY4Zc/sJYpXQHXHUiZtkj85d54=
X-Received: by 2002:a05:690e:4105:b0:63f:a985:a02e with SMTP id
 956f58d0204a3-642f7d3401cmr688393d50.3.1763593418327; Wed, 19 Nov 2025
 15:03:38 -0800 (PST)
MIME-Version: 1.0
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-18-jsnow@redhat.com>
 <aRtyTkIcuoNazF7L@redhat.com>
 <CABgObfZW5i4nYchoCTKeh7b3cxYSctpxFp=UV2a2V5t=zmDgNw@mail.gmail.com>
 <CAFn=p-a4_EX7FvobF2f8fH2=ZKemcZvobi0EKV4MpCiQM+TQ+g@mail.gmail.com>
 <CABgObfY6QPzH0xM+VOeP16Lsi+y9DEeim0tsx+yKXEW2skVPHQ@mail.gmail.com>
 <6111c59f-42c3-4c6f-8e75-209874d75363@redhat.com>
In-Reply-To: <6111c59f-42c3-4c6f-8e75-209874d75363@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 19 Nov 2025 18:03:26 -0500
X-Gm-Features: AWmQ_bkojoGzo8ZlMMpqhRqRZFK3i_HyGoCN-cAKv02yJJ7q1GK8nBocXHqd8x0
Message-ID: <CAFn=p-Zv0BgUAjh=w8i-R2+73h=KxgPwvEXDLtmPPOU3aAp9uA@mail.gmail.com>
Subject: Re: [PATCH 17/22] tests: forcibly run 'make check-venv' for crash
 tests
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Michael Roth <michael.roth@amd.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003ad16e0643fa971e"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000003ad16e0643fa971e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025, 9:15=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote:

> On 19/11/2025 09.05, Paolo Bonzini wrote:
> >
> >
> > Il mar 18 nov 2025, 22:50 John Snow <jsnow@redhat.com
> > <mailto:jsnow@redhat.com>> ha scritto:
> >
> >
> >
> >     On Mon, Nov 17, 2025, 3:47=E2=80=AFPM Paolo Bonzini <pbonzini@redha=
t.com
> >     <mailto:pbonzini@redhat.com>> wrote:
> >
> >
> >
> >         Il lun 17 nov 2025, 20:07 Daniel P. Berrang=C3=A9 <
> berrange@redhat.com
> >         <mailto:berrange@redhat.com>> ha scritto:
> >
> >             On Mon, Nov 17, 2025 at 01:51:25PM -0500, John Snow wrote:
> >              > In order to convert the existing Makefile target from a
> manual
> >              > invocation of mkvenv to one that uses the meson dependen=
cy
> >             system, we
> >              > need to not suppress ninja here.
> >              >
> >              > I'm not sure if this creates problems I am not aware of;
> but
> >             invoking
> >              > ninja here is no longer spurious but will become
> necessary.
> >
> >             Yes, this will likely create problems. From the commit
> message that
> >             introduced NINJA=3D":"...
> >
> >               Avoid it with the same
> >                  trick that we are using in buildtest-template.yml
> already
> >             by disabling
> >                  the up-to-date check via NINJA=3D":".
> >
> >
> >         Move the check-venv call to buildtest-template.yml, right after
> >         configure? It's cheap enough.
> >
> >         Paolo
> >
> >
> >     What's the root issue here? That there's enough of a time delay
> between
> >     the actual configure and the test running that it re-runs configure=
?
> >
> >
> > That the git repo is cloned again and is therefore newer than the
> artifacts.
> > That triggers a full rebuild.
>
> Right. At least for the other "functional" and "check-system" jobs in our
> CI, this was a big issue, calling "make check-functional/qtest/iotest"
> there
> triggered a rebuild of all binaries, increasing our CI runtime
> significantly.
>
> For the "crash test" jobs, it was mainly about avoiding to rerun the
> "configure" step for cosmetical reasons each time the job runs. The
> rebuild
> of the qemu binaries is triggered by "make check-iotests/qtests/function"
> in
> the other jobs, and not by "make check-venv" alone, so it's not as bad as
> in
> the other jobs here:
> Without your patch, the jobs take about 16 minutes (crash-test-debian) an=
d
> 10 minutes (crash-test-fedora):
>
>   https://gitlab.com/thuth/qemu/-/jobs/12138792667
>   https://gitlab.com/thuth/qemu/-/jobs/12138792674
>
> With your patch applied:
>
>   https://gitlab.com/thuth/qemu/-/jobs/12139438583
>   https://gitlab.com/thuth/qemu/-/jobs/12139438599
>
> the jobs take approx. the same amount of time, so I think it's OK here to
> drop the NINJA=3D":" again.
>
> But I think we should give Paolo's idea a try and move the "make
> check-venv"
> to buildtest-template.yml instead. In fact, that might even help to
> slightly
> decrease the total runtime of the jobs since all the other "check" jobs
> don't have to do this again (for example the check-functional jobs are
> running it, too, see:
> https://gitlab.com/qemu-project/qemu/-/jobs/12139584312#L1051).
>
>   Thomas
>

Ah, I see now, thanks! I can think of some remedies for this. No problem.

--0000000000003ad16e0643fa971e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 19, 2025, 9:15=E2=80=
=AFAM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 19/11/2025 09.05,=
 Paolo Bonzini wrote:<br>
&gt; <br>
&gt; <br>
&gt; Il mar 18 nov 2025, 22:50 John Snow &lt;<a href=3D"mailto:jsnow@redhat=
.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=
=3D"noreferrer">jsnow@redhat.com</a>&gt;&gt; ha scritto:<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Mon, Nov 17, 2025, 3:47=E2=80=AFPM Paolo Bonzini=
 &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" rel=3D"norefe=
rrer">pbonzini@redhat.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:pbonzini@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;&gt; wrote:<=
br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Il lun 17 nov 2025, 20:07 Daniel P. B=
errang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" target=3D"_blank" r=
el=3D"noreferrer">berrange@redhat.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:berrange=
@redhat.com" target=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&g=
t;&gt; ha scritto:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0On Mon, Nov 17, 2025 at=
 01:51:25PM -0500, John Snow wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; In order to conve=
rt the existing Makefile target from a manual<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; invocation of mkv=
env to one that uses the meson dependency<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0system, we<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; need to not suppr=
ess ninja here.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; I&#39;m not sure =
if this creates problems I am not aware of; but<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0invoking<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; ninja here is no =
longer spurious but will become necessary.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Yes, this will likely c=
reate problems. From the commit message that<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0introduced NINJA=3D&quo=
t;:&quot;...<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Avoid it with th=
e same<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trick th=
at we are using in buildtest-template.yml already<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0by disabling<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the up-t=
o-date check via NINJA=3D&quot;:&quot;.<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Move the check-venv call to buildtest=
-template.yml, right after<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0configure? It&#39;s cheap enough.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Paolo<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0What&#39;s the root issue here? That there&#39;s en=
ough of a time delay between<br>
&gt;=C2=A0 =C2=A0 =C2=A0the actual configure and the test running that it r=
e-runs configure?<br>
&gt; <br>
&gt; <br>
&gt; That the git repo is cloned again and is therefore newer than the arti=
facts. <br>
&gt; That triggers a full rebuild.<br>
<br>
Right. At least for the other &quot;functional&quot; and &quot;check-system=
&quot; jobs in our <br>
CI, this was a big issue, calling &quot;make check-functional/qtest/iotest&=
quot; there <br>
triggered a rebuild of all binaries, increasing our CI runtime significantl=
y.<br>
<br>
For the &quot;crash test&quot; jobs, it was mainly about avoiding to rerun =
the <br>
&quot;configure&quot; step for cosmetical reasons each time the job runs. T=
he rebuild <br>
of the qemu binaries is triggered by &quot;make check-iotests/qtests/functi=
on&quot; in <br>
the other jobs, and not by &quot;make check-venv&quot; alone, so it&#39;s n=
ot as bad as in <br>
the other jobs here:<br>
Without your patch, the jobs take about 16 minutes (crash-test-debian) and =
<br>
10 minutes (crash-test-fedora):<br>
<br>
=C2=A0 <a href=3D"https://gitlab.com/thuth/qemu/-/jobs/12138792667" rel=3D"=
noreferrer noreferrer" target=3D"_blank">https://gitlab.com/thuth/qemu/-/jo=
bs/12138792667</a><br>
=C2=A0 <a href=3D"https://gitlab.com/thuth/qemu/-/jobs/12138792674" rel=3D"=
noreferrer noreferrer" target=3D"_blank">https://gitlab.com/thuth/qemu/-/jo=
bs/12138792674</a><br>
<br>
With your patch applied:<br>
<br>
=C2=A0 <a href=3D"https://gitlab.com/thuth/qemu/-/jobs/12139438583" rel=3D"=
noreferrer noreferrer" target=3D"_blank">https://gitlab.com/thuth/qemu/-/jo=
bs/12139438583</a><br>
=C2=A0 <a href=3D"https://gitlab.com/thuth/qemu/-/jobs/12139438599" rel=3D"=
noreferrer noreferrer" target=3D"_blank">https://gitlab.com/thuth/qemu/-/jo=
bs/12139438599</a><br>
<br>
the jobs take approx. the same amount of time, so I think it&#39;s OK here =
to <br>
drop the NINJA=3D&quot;:&quot; again.<br>
<br>
But I think we should give Paolo&#39;s idea a try and move the &quot;make c=
heck-venv&quot; <br>
to buildtest-template.yml instead. In fact, that might even help to slightl=
y <br>
decrease the total runtime of the jobs since all the other &quot;check&quot=
; jobs <br>
don&#39;t have to do this again (for example the check-functional jobs are =
<br>
running it, too, see: <br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/12139584312#L1051" r=
el=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-proj=
ect/qemu/-/jobs/12139584312#L1051</a>).<br>
<br>
=C2=A0 Thomas<br></blockquote></div></div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Ah, I see now, thanks! I can think of some remedies for this. =
No problem.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div c=
lass=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000003ad16e0643fa971e--


