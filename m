Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FDBCEACDD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 15:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sveWG-00042i-0o; Tue, 01 Oct 2024 11:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sveWD-00041h-UE
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:10:30 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sveWB-0002D8-Ug
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 11:10:29 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53992157528so2909083e87.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 08:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727795426; x=1728400226; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QRgCiS1LJNxyhUxBrF5A8/PY0hT8ntX+Q5VtzEfIt2E=;
 b=zEB10au2L/DJzT6lR8Mz+tjrSQ2q0slttigxnBotn9SJXoGfiWdnrbP8WKe277wZUs
 R6lbBjOzm3PbO/iw4SKJHrpIIPaSoovbfsgJvHcROFQYP31CPMWyGedUEnaYJ5rMOz+m
 eNkPCoMUCCwFK85doKSJ3HWHyQLj6mcXvN8svjlMWj0RvIHYwe6TjPweLsYgRTzFAiUQ
 NBvvCdMrGQIjz/d59xQbwY83SkLI+8vbCbtOSXno1J08JqOcNPVijj8tollufPThOsYa
 tMYyYcfD4qexZHRJGqf9Q5dBgqkbS8oUIWawsEcSpRoYGRGHBoe2Xxo1SOaJrpx4ZL1/
 Umtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727795426; x=1728400226;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QRgCiS1LJNxyhUxBrF5A8/PY0hT8ntX+Q5VtzEfIt2E=;
 b=DB+w5aYJzcfDSKMfEcDIjcP92c8FAhbBnjrpptVOTH/Vc57m1lQzuLGMdCbCsGBJTT
 4Hs9EAi0fUb2M1C2SqQBWzxHd86ruoLF6tXtFi9cCVdkcNwey3hwIwGXYrNCTn+wpvYW
 537kzW2iU7+umaBDYepOKLeeaT7l2LHjYoPC2J67YS/+7+iw/MaPHHA0sKRMTkfr4TDS
 E08VjO8laln62xzEmYLQQSIQZq5W9AXijPtBkPjt6YC5h+UgOVaPIsibQSIxGwfU5D7b
 7Yv13AVZgusMnUf7cCDDA49s2BDansswb/3llhGT+t6fLpDiszf3+wPuw7Z5l2THu++M
 Qcbw==
X-Gm-Message-State: AOJu0YzwM+xOpQo09ZVE2FCVba7AUl8eFQcJIUQva9jKukSmKLBtcih1
 TEQzKFecFUdF7aF2ccy0O17Ld+irkZifrL1afRgl1d58odCXeUVfcpR3RwL0ZSsx8S5iy0CRpiB
 lzkkKUbjDdrjgRBMPJQCr+gvxofOfw1y1zZuq24TWRamGzJx8
X-Google-Smtp-Source: AGHT+IEihA4O+tvFH/eCC+T3SWFod80kzYE6ooWP24Q561c8zPz4WybE6riL57anc31/2UVfaRk12K98RoB/kgp1nLg=
X-Received: by 2002:a17:907:2dac:b0:a8d:6921:e181 with SMTP id
 a640c23a62f3a-a93c4921892mr1478132366b.16.1727784582030; Tue, 01 Oct 2024
 05:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240930171834.51701-1-thuth@redhat.com>
 <ko5yn.bgayz532vi6@linaro.org>
 <23f7bf52-af7d-4186-b773-28b15e872064@redhat.com>
In-Reply-To: <23f7bf52-af7d-4186-b773-28b15e872064@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 1 Oct 2024 15:09:29 +0300
Message-ID: <CAAjaMXZ0ixQoWroJeoVVo+fmC-hVhG9Dx_+F8PrPEMTid07hyg@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: Switch back to the gitlab URLs for the
 advent calendar tests
To: Thomas Huth <thuth@redhat.com>
Cc: "open list:ARM SMMU <qemu-arm@nongnu.org>, " <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud_=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000042c6780623693266"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--00000000000042c6780623693266
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 1, 2024, 12:14 PM Thomas Huth <thuth@redhat.com> wrote:

> On 01/10/2024 10.50, Manos Pitsidianakis wrote:
> > Hello Thomas,
> >
> > On Mon, 30 Sep 2024 20:18, Thomas Huth <thuth@redhat.com> wrote:
> >> Shortly after we switched to the original URLs on
> qemu-advent-calendar.org,
> >> the server went offline - looks like we are better off using the gitlab
> >> URLs again instead.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> > [snip]
> >> diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/
> >> functional/test_microblazeel_s3adsp1800.py
> >> index faa3927f2e..47c941d487 100755
> >> --- a/tests/functional/test_microblazeel_s3adsp1800.py
> >> +++ b/tests/functional/test_microblazeel_s3adsp1800.py
> >> @@ -18,8 +18,8 @@ class MicroblazeelMachine(QemuSystemTest):
> >>     timeout = 90
> >>
> >>     ASSET_IMAGE = Asset(
> >> -        ('
> http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
> >> -
> 'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
> >> +        ('
> https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/
> >> day13.tar.xz'),
> >> +
> '67e4c502651f8801e724ecc26403f1d0cdbc00549b033166e2e8cd14e9d49fef')
> >>
> >>     def test_microblazeel_s3adsp1800(self):
> >>         self.require_netdev('user')
> >
> > I downloaded both day13.tar.gz and day13.tar.xz and these archives have
> > different file contents, is that on purpose?
>
> Oh, drat! That's a different package, indeed - it's the one from 2018, not
> the one from 2023! I didn't really notice since I did not remove my
> tests/functional/ folder before re-running the tests, so this test was
> silently re-using the old binary from the previous test runs :-/
> (note to myself: we should maybe remove the binaries after each test run).
>
> Thanks for spotting it!
>
> Meanwhile, the www.qemu-advent-calendar.org website seems to be back, so
> maybe we don't need this patch here anymore... let's wait and see whether
> it
> remains stable now...


Suggestion: Add a list of source URLs in Asset() so that it has a fallback
if the first host cannot be reached, maybe you can respin the patch to do
this?

--00000000000042c6780623693266
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Oct 1, 2024, 12:14 PM Thomas Huth &lt;<a href=
=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">On 01/10/2024 10.50, Manos Pit=
sidianakis wrote:<br>
&gt; Hello Thomas,<br>
&gt; <br>
&gt; On Mon, 30 Sep 2024 20:18, Thomas Huth &lt;<a href=3D"mailto:thuth@red=
hat.com" target=3D"_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt; wrot=
e:<br>
&gt;&gt; Shortly after we switched to the original URLs on <a href=3D"http:=
//qemu-advent-calendar.org" rel=3D"noreferrer noreferrer" target=3D"_blank"=
>qemu-advent-calendar.org</a>,<br>
&gt;&gt; the server went offline - looks like we are better off using the g=
itlab<br>
&gt;&gt; URLs again instead.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com"=
 target=3D"_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt; [snip]<br>
&gt;&gt; diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/te=
sts/ <br>
&gt;&gt; functional/test_microblazeel_s3adsp1800.py<br>
&gt;&gt; index faa3927f2e..47c941d487 100755<br>
&gt;&gt; --- a/tests/functional/test_microblazeel_s3adsp1800.py<br>
&gt;&gt; +++ b/tests/functional/test_microblazeel_s3adsp1800.py<br>
&gt;&gt; @@ -18,8 +18,8 @@ class MicroblazeelMachine(QemuSystemTest):<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 timeout =3D 90<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 ASSET_IMAGE =3D Asset(<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (&#39;<a href=3D"http:=
//www.qemu-advent-calendar.org/2023/download/day13.tar.gz&#39;" rel=3D"nore=
ferrer noreferrer" target=3D"_blank">http://www.qemu-advent-calendar.org/20=
23/download/day13.tar.gz&#39;</a>),<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &#39;b9b3d43c5dd79db88=
ada495cc6e0d1f591153fe41355e925d791fbf44de50c22&#39;)<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (&#39;<a href=3D"https=
://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">https://qemu-advcal.gitlab.io/qac-best-of-mu=
ltiarch/download/</a> <br>
&gt;&gt; day13.tar.xz&#39;),<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &#39;67e4c502651f8801e=
724ecc26403f1d0cdbc00549b033166e2e8cd14e9d49fef&#39;)<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 def test_microblazeel_s3adsp1800(self):<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.require_netdev(&#3=
9;user&#39;)<br>
&gt; <br>
&gt; I downloaded both day13.tar.gz and day13.tar.xz and these archives hav=
e <br>
&gt; different file contents, is that on purpose?<br>
<br>
Oh, drat! That&#39;s a different package, indeed - it&#39;s the one from 20=
18, not <br>
the one from 2023! I didn&#39;t really notice since I did not remove my <br=
>
tests/functional/ folder before re-running the tests, so this test was <br>
silently re-using the old binary from the previous test runs :-/<br>
(note to myself: we should maybe remove the binaries after each test run).<=
br>
<br>
Thanks for spotting it!<br>
<br>
Meanwhile, the <a href=3D"http://www.qemu-advent-calendar.org" rel=3D"noref=
errer noreferrer" target=3D"_blank">www.qemu-advent-calendar.org</a> websit=
e seems to be back, so <br>
maybe we don&#39;t need this patch here anymore... let&#39;s wait and see w=
hether it <br>
remains stable now...</blockquote></div></div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Suggestion: Add a list of source URLs in Asset() so that i=
t has a fallback if the first host cannot be reached, maybe you can respin =
the patch to do this?</div><div dir=3D"auto"></div></div>

--00000000000042c6780623693266--

