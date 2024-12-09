Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940D6E77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 02:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKTr2-0000l5-Fo; Sun, 08 Dec 2024 21:50:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tKTqy-0000kc-Q6
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 21:50:33 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tKTqw-0008B4-Py
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 21:50:32 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-29e585968a8so2404455fac.3
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 18:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1733712628; x=1734317428;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NbOwr4T/r4RaD/5fp3RT7Qsls6yRTrWFVNGRgwBkmIU=;
 b=i9R57LhCUYfU7rGZ8+ewMq1owJ/gjYIhYs2BHelVkwRUV9DA/XMGQ4FCD/yDEa60l1
 rLuDtv0EApPPwaSbBjvX+KS1n2qzbpHIybIBcx4djWNSHyod2kEhOdXNA7WXaoCkXkQY
 OUP0sFJMtSZH/Dchda5UUMFdItk4Yq1q6f00xAQUN845Ip/kjfSvPy+MJGEPEOgih3oU
 gozyWKNj4JYvsJIkEjcx7xjupqjKBKPbJMQGC2EUA3fL2b7mMhgbVHl8ajK+qrSoxqc+
 UnmaQZibtOrUVTvKXJBljnw2BLjPh9v5/x5mdxdNv5yfKJ1rqwt1Di7UpzEAvWJamXPG
 WlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733712628; x=1734317428;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NbOwr4T/r4RaD/5fp3RT7Qsls6yRTrWFVNGRgwBkmIU=;
 b=OoTIrLuRJj+oUfhY+lKujFMRiN8X+mpnVBhpO1kY4MfP5ynuKZ4oC2WQOmRnd9cU23
 mkGOAIkFaR3uLyEr9r3Zx8CB8Bq+IumC5rEseKRAMCLAbjgM4V3L37qRUxOO7Peck/M0
 Qg69t3eJspO6odeyWFHrNCnzN9lka8ysbR+7Tj9P66dCK3ptrmcL9kaMmlz5LSK4WXtT
 DQh7HWV8AX/lbI3cLRgxzI2PUmkhfoeHcgEc+UyYlh/tT3RxcgxtcpW+zWSMB590LNB1
 AVBI2wxXbnc3PG/37U7Uf7cLaVAi9fWUx54hgHzVUoFIUKMiioMAcOsJZD83q+775zZ5
 PGCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTZdBf/Bo8NJ2IHJJXZO/zqbSgTDur6aTjd88bwDKDCLhQvRAh9X90xRxtjcopuQ+kpp8cA17m4Tsb@nongnu.org
X-Gm-Message-State: AOJu0Yw1gUn8l8ftY5FStf6MDtmO7Rudlj//SX5dMNBrtlKqWIDAaThT
 a7fqVL3xsDoqgbl9iJi2LWTNkidYEOiJo3Dt/CgbR0fJ/IjHu1JWppOOtbN0KVdOr13oVIPV1ss
 Ml84edv+p0KVDzoK+Auu1l4F6GQjG9k96IngoMQ==
X-Gm-Gg: ASbGncvSqtGRSpIQMVExwJ4g2/ANWYQMVwdNxPbkvRSWfTRf50dzpyR2UuVfx+s+VjB
 JMOeA+4pfDXW4XLSIm53ojGxel/t1FVDz
X-Google-Smtp-Source: AGHT+IGPFnkLzFtSdTVD2A3WNMRp3FfRECqFSAkXH0XTX6aI+PZIdcs27oY7cT4yPDjGS+wpj989JOHoyPFbNoF0vaE=
X-Received: by 2002:a05:6870:5d8e:b0:29e:67cd:1a89 with SMTP id
 586e51a60fabf-29f739251bbmr9215425fac.36.1733712627508; Sun, 08 Dec 2024
 18:50:27 -0800 (PST)
MIME-Version: 1.0
References: <87sesmdfl4.fsf@suse.de>
 <CAK9dgmZvj4W2EBxp1_TcdYs3q2aqaRZGZCAk=FRJk-PaB9y_fw@mail.gmail.com>
 <87v7w6jkc9.fsf@suse.de> <87plmejgtb.fsf@suse.de>
 <CAK9dgmbHL+O34+E3ykDdAunap+Ruubm7ysisrMags6TN25BiNQ@mail.gmail.com>
 <Z04PTe4kCVWEQbPL@x1n> <Z06866qR0z9n2BgP@redhat.com> <875xo1j6ub.fsf@suse.de>
 <Z075-ZPW9dzzCKJn@redhat.com> <8734j4kiuq.fsf@suse.de> <Z09CdpY4C5Eq6OxI@x1n>
In-Reply-To: <Z09CdpY4C5Eq6OxI@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 9 Dec 2024 10:50:11 +0800
Message-ID: <CAK9dgmZzuaOsT_EQorHqaduTXSYdJ0xuNn602HcMgmFrNM=8yg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Guestperf: miscellaneous refinement and enrichment
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000004e39430628cd6d66"
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--0000000000004e39430628cd6d66
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:40=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:

> On Tue, Dec 03, 2024 at 10:15:57AM -0300, Fabiano Rosas wrote:
> > We shouldn't be adding warnings to the build like that. When building
> > static binaries, I'd assume the person at least knows there's a -static
> > in there somewhere. If you're just building the system binaries and
> > warnings start to show up, that's not good. Since this is just a side
> > script that's very infrequently used, I don't think it justifies the
> > extra warning.
>
> Yeah this could be a valid point.
>
> The main issue is I believe 99.999999% of people building qemu will not u=
se
> stress.c and the initrd at all.  It means we could start burning some tin=
y
> little more cpus all over the worlds for nothing.. the added warning is a
> bad extra side effect of that.
>
> So I wonder if it would make more sense to only build stress.c manually
>

Ok, get it.


> like before, until some of the stress test would be put into either 'make
> check' or CI flows.  Then we decide whether to fix the warning or not.
>

Yes, I think that adding the essential guestperf test to "make check"
(like migration via a Unix socket) may make sense, at least from the
perspective of guestperf's usability.


> --
> Peter Xu
>
>

--=20
Best regards

--0000000000004e39430628cd6d66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Wed, Dec 4, 2024 at 1:40=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto:p=
eterx@redhat.com">peterx@redhat.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;=
border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex=
">On Tue, Dec 03, 2024 at 10:15:57AM -0300, Fabiano Rosas wrote:<br>
&gt; We shouldn&#39;t be adding warnings to the build like that. When build=
ing<br>
&gt; static binaries, I&#39;d assume the person at least knows there&#39;s =
a -static<br>
&gt; in there somewhere. If you&#39;re just building the system binaries an=
d<br>
&gt; warnings start to show up, that&#39;s not good. Since this is just a s=
ide<br>
&gt; script that&#39;s very infrequently used, I don&#39;t think it justifi=
es the<br>
&gt; extra warning.<br>
<br>
Yeah this could be a valid point.<br>
<br>
The main issue is I believe 99.999999% of people building qemu will not use=
<br>
stress.c and the initrd at all.=C2=A0 It means we could start burning some =
tiny<br>
little more cpus all over the worlds for nothing.. the added warning is a<b=
r>
bad extra side effect of that.<br>
<br>
So I wonder if it would make more sense to only build stress.c manually<br>=
</blockquote><div><br></div><div><div style=3D"font-family:&quot;comic sans=
 ms&quot;,sans-serif" class=3D"gmail_default">Ok, get it.</div></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(20=
4,204,204);padding-left:1ex">
like before, until some of the stress test would be put into either &#39;ma=
ke<br>
check&#39; or CI flows.=C2=A0 Then we decide whether to fix the warning or =
not.<br></blockquote><div><br></div><div><div style=3D"font-family:&quot;co=
mic sans ms&quot;,sans-serif" class=3D"gmail_default">Yes, I think that add=
ing the essential guestperf test to &quot;make check&quot;</div><div style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_defaul=
t">(like migration via a Unix socket) may make sense, at least from the</di=
v><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"=
gmail_default">perspective of guestperf&#39;s usability.</div></div><div><b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,20=
4,204);padding-left:1ex">
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best re=
gards</font></div></div></div>

--0000000000004e39430628cd6d66--

