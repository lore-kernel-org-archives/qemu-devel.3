Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC0FECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 05:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sntis-0008OX-7L; Tue, 10 Sep 2024 01:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sntip-0008Na-Nn
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 01:47:27 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sntil-0008Uj-VL
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 01:47:27 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-277fdd7d509so2462588fac.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 22:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1725947241; x=1726552041;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aKfANppbUf2hD+aKFDUyOB6XLlLjzRg59cozzJh7hYk=;
 b=I0nuWvZc0CI9gK/+A/flXrVDOqizmY7M7UQ+gTaJCZufmXyja2CstBTNzRXpmcx73w
 eUMbsSo+iaBmokShd6zCN5okzbiFFa2so3aQbXUCm8M9VdIJzGFLnzIZu+PZztKYW/B+
 LsSzq1ULY4dKo2qPoBCGPPM65pamYznKlBWn4ffjzaXup8diWnUTOCzM2JmMtMYTAD5G
 oQAMw9LvtH8AJCP/v/etAYDapmsNKCw8QCppTF4CrDZ90HJiK5MVQUsqmNJjB5Ru17lH
 hTaawvzyTTXWGOZvEeep9wfiZgR7pt8+vF1quHUeG+q1nfZPfoO2hbPdMIQjFH8pCMvl
 2YJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725947241; x=1726552041;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aKfANppbUf2hD+aKFDUyOB6XLlLjzRg59cozzJh7hYk=;
 b=o93+YNKIQ6A2P9cMqwWm03TftwRgqjUGsnV52xQADh/jYgYCHBFrc394lYyY0ZiIyY
 +LUEVCJMIDBwE2jZA3W7QJR2S1BkchXdMOua7gEFUjA0cQYgdg5OnmyBBogFHfBPpi3g
 IpyKj7OXZRhzkmoCeOuKy1ji2hzs8iO/lXw/Gyrpr4ehcw5oVW/UnBDYS34JVX6Vh9FM
 tKqeWHZR5vhj0Wp+KaBct6QDskIy69bhB2j72YYNvguwGKWxyCjajGflkaiBBNKt9+h7
 P6aAR0QOKbPCylMWOXxmPvWdFEdrL9BQuSfrKu859odv1GG0Vraw5R7z/vO/C4kDH/dJ
 2aKA==
X-Gm-Message-State: AOJu0Yx8LervR1EGbPF/3PWwZ79kPtKroeSHm2f7mQQwrLMuYs0asVvc
 MEoAVahI3FtpShdPJoHJHVhONFGxIYRUWZWRVuwRazAx4NE5hr2e7Q5fkkSve/YP1NriOfsNzUD
 xZh/FmOJelTjLviHUvCfQHQD90LpubOY7Y4/huA==
X-Google-Smtp-Source: AGHT+IFEF1jQ6NDoGnbpn+lNRvyCrSmOh+gQUdowZhwINUyL7CzuMyDt2ezDaCV6K21nDPqgOgT634v7vOyHQtIJeN0=
X-Received: by 2002:a05:6870:3309:b0:277:d790:6e99 with SMTP id
 586e51a60fabf-27be6d8ce33mr853991fac.18.1725947240045; Mon, 09 Sep 2024
 22:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1725891841.git.yong.huang@smartx.com>
 <0bbcdfd86f35830e0a398220663aac5afd8b7e1e.1725891841.git.yong.huang@smartx.com>
 <Zt9o5r1ZWOxnjctC@x1n>
In-Reply-To: <Zt9o5r1ZWOxnjctC@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 10 Sep 2024 13:47:04 +0800
Message-ID: <CAK9dgma+kmV=sXPu-RUnT8mkQmRUJXRRkiDXfFDoT+6JBu-nHw@mail.gmail.com>
Subject: Re: [PATCH RESEND RFC 03/10] qapi/migration: Introduce periodic CPU
 throttling parameters
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000024f70e0621bd686b"
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x2d.google.com
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

--00000000000024f70e0621bd686b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 5:30=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:

> On Mon, Sep 09, 2024 at 10:25:36PM +0800, Hyman Huang wrote:
> > To activate the periodic CPU throttleing feature, introduce
> > the cpu-periodic-throttle.
> >
> > To control the frequency of throttling, introduce the
> > cpu-periodic-throttle-interval.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
>
> Considering that I would still suggest postcopy over auto-converge, IMO w=
e
>

We are considering the hybrid of precopy and postcopy in fact, and i
entirely agree with what you are saying: postcopy migration is an
alternative
solution to deal with migrations that refuse to converge, or take too long
to converge. But enabling this feature may not be easy in production since
the
recovery requires upper apps to interface, the hugepages and spdk/dpdk
scenarios also need to be considered and re-test.
Considering auto-converge is the main policy in the industry, the
optimization
may still make sense. We would like to try to optimize the auto-converge in
huge
VM case and, IMHO, it doesn't conflict with postcopy.


> should be cautious on adding more QMP interfaces on top of auto-converge,
> because that means more maintenance burden everywhere.. and it's against
> our goal to provide, hopefully, one solution for the long term for
> convergence issues.
>
> Postcopy has a major issue with VFIO, but auto converge isn't anything
> better from that regard.. as we can't yet throttle a device so far anyway=
.
> Throttling of DMA probably means DMA faults, then postcopy might be doabl=
e
> too.  Meanwhile we're looking at working out 1G postcopy at some point.
>
> So I wonder whether we can make any further optmization for auto-converge
> (if we still really want that..) to be at least transparent, so that they
>

Thanks for the advice and of course yes.
So, at first, We'll try to avoid adding the new periodic throttle parameter
and make it be transparent ?


> get auto enabled on new machine types.  If we really want some knobs to
> control, we can still expose via -global migration.x-* parameters, but th=
en
> they'll be all debug tunables only, perhaps that can at least reduce
> burdens to QMP maintainers and Libvirt side.
>
> Thanks,
>
> --
> Peter Xu
>
>
Yong

--=20
Best regards

--00000000000024f70e0621bd686b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 10, 20=
24 at 5:30=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com" tar=
get=3D"_blank">peterx@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
On Mon, Sep 09, 2024 at 10:25:36PM +0800, Hyman Huang wrote:<br>
&gt; To activate the periodic CPU throttleing feature, introduce<br>
&gt; the cpu-periodic-throttle.<br>
&gt; <br>
&gt; To control the frequency of throttling, introduce the<br>
&gt; cpu-periodic-throttle-interval.<br>
&gt; <br>
&gt; Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com=
" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
<br>
Considering that I would still suggest postcopy over auto-converge, IMO we<=
br></blockquote><div><br></div><div><div style=3D"font-family:&quot;comic s=
ans ms&quot;,sans-serif" class=3D"gmail_default">We are considering the hyb=
rid of precopy and postcopy in fact, and i</div><div class=3D"gmail_default=
"><font face=3D"comic sans ms, sans-serif">entirely agree with what you are=
 saying:=C2=A0p<span style=3D"color:rgb(0,0,0);background-color:rgb(252,252=
,252)">ostcopy migration is an alternative</span></font></div><div class=3D=
"gmail_default"><font face=3D"comic sans ms, sans-serif"><span style=3D"col=
or:rgb(0,0,0);background-color:rgb(252,252,252)">solution to deal with migr=
ations that refuse to converge,=C2=A0</span></font><span style=3D"font-fami=
ly:&quot;comic sans ms&quot;,sans-serif;color:rgb(0,0,0);background-color:r=
gb(252,252,252)">or take too long</span></div><div class=3D"gmail_default">=
<span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif;color:rgb(0=
,0,0);background-color:rgb(252,252,252)">to converge. But enabling this fea=
ture may not be easy in production since the</span></div><div class=3D"gmai=
l_default"><span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif;=
color:rgb(0,0,0);background-color:rgb(252,252,252)">recovery requires upper=
 apps to interface, the hugepages and spdk/dpdk</span></div></div><div clas=
s=3D"gmail_default"><span style=3D"font-family:&quot;comic sans ms&quot;,sa=
ns-serif;color:rgb(0,0,0);background-color:rgb(252,252,252)">scenarios also=
 need to be considered and re-test.=C2=A0</span></div><div class=3D"gmail_d=
efault"><span style=3D"color:rgb(0,0,0);font-family:&quot;comic sans ms&quo=
t;,sans-serif;background-color:rgb(252,252,252)">Considering auto-converge =
is=C2=A0</span><span style=3D"color:rgb(0,0,0);font-family:&quot;comic sans=
 ms&quot;,sans-serif;background-color:rgb(252,252,252)">the main policy in =
the industry, the optimization</span></div><div class=3D"gmail_default"><sp=
an style=3D"color:rgb(0,0,0);font-family:&quot;comic sans ms&quot;,sans-ser=
if;background-color:rgb(252,252,252)">may still make sense.=C2=A0</span><sp=
an style=3D"font-family:&quot;comic sans ms&quot;,sans-serif;color:rgb(0,0,=
0);background-color:rgb(252,252,252)">We would like to try to optimize=C2=
=A0</span><font face=3D"comic sans ms, sans-serif"><span style=3D"color:rgb=
(0,0,0);background-color:rgb(252,252,252)">t</span><span style=3D"color:rgb=
(0,0,0);background-color:rgb(252,252,252)">he=C2=A0</span>auto-converge<spa=
n style=3D"color:rgb(0,0,0);background-color:rgb(252,252,252)"> </span>in h=
uge</font></div><div class=3D"gmail_default"><font face=3D"comic sans ms, s=
ans-serif"><span style=3D"color:rgb(0,0,0);background-color:rgb(252,252,252=
)">VM case and, </span></font><span style=3D"color:rgb(0,0,0);font-family:&=
quot;comic sans ms&quot;,sans-serif;background-color:rgb(252,252,252)">IMHO=
, it doesn&#39;t </span>conflict<span style=3D"color:rgb(0,0,0);font-family=
:&quot;comic sans ms&quot;,sans-serif;background-color:rgb(252,252,252)">=
=C2=A0with postcopy.=C2=A0</span></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
should be cautious on adding more QMP interfaces on top of auto-converge,<b=
r>
because that means more maintenance burden everywhere.. and it&#39;s agains=
t<br>
our goal to provide, hopefully, one solution for the long term for<br>
convergence issues.<br>
<br>
Postcopy has a major issue with VFIO, but auto converge isn&#39;t anything<=
br>
better from that regard.. as we can&#39;t yet throttle a device so far anyw=
ay.<br>
Throttling of DMA probably means DMA faults, then postcopy might be doable<=
br>
too.=C2=A0 Meanwhile we&#39;re looking at working out 1G postcopy at some p=
oint.<br>
<br>
So I wonder whether we can make any further optmization for auto-converge<b=
r>
(if we still really want that..) to be at least transparent, so that they<b=
r></blockquote><div><br></div><div><div style=3D"font-family:&quot;comic sa=
ns ms&quot;,sans-serif" class=3D"gmail_default">Thanks for the advice and o=
f course yes.<span class=3D"gmail-Apple-converted-space">=C2=A0</span></div=
><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"g=
mail_default"><span class=3D"gmail-Apple-converted-space">So, at first, We&=
#39;ll try to avoid adding=C2=A0</span><span class=3D"gmail-Apple-converted=
-space">the new periodic=C2=A0</span>throttle parameter</div><div style=3D"=
font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">a=
nd make it be transparent ?</div></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
get auto enabled on new machine types.=C2=A0 If we really want some knobs t=
o<br>
control, we can still expose via -global migration.x-* parameters, but then=
<br>
they&#39;ll be all debug tunables only, perhaps that can at least reduce<br=
>
burdens to QMP maintainers and Libvirt side.<br>
<br>
Thanks,<br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><br clear=3D"all"><div><div style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif" class=3D"gmail_default">Yong</div><br></div>=
<span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-ser=
if">Best regards</font></div></div></div>

--00000000000024f70e0621bd686b--

