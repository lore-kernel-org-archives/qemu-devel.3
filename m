Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE99C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 06:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHeO6-0002OW-J6; Thu, 13 Jun 2024 02:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sHeNz-0002LH-MF
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 02:56:40 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sHeNx-00045J-Fv
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 02:56:39 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-797a7f9b52eso41387585a.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 23:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718261796; x=1718866596; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GTD52IR0wubc3Sdt6b1ZbOCffpjz6fWRvZ8uBXbwUEY=;
 b=K1f/2OHN1vMA8gLk7tB7pKmpUpG2zywmDWXp0rjxYZMnTWJ/pHFeyKCpaLyQqXHD0P
 ocVZ6x9uwRMXsUC2G6ECh9WlmJWi2CDsJ3I6hiPbwaNGh6qtYJRPq9MsYYol1o0vnpk0
 qeelJ2I7P8N46UUZM5wJ2MwquTQYN8niQLtFBIeF/T9E/sgNe3E9vusJShuTNdQqQD9/
 Q3ATr/U4GYi3ZtOeBwKOuDji40I/z69HXdIFEKVh2AHbFf/8lX9FIeiYeYzLC9+mTBtC
 q94MjZulTd6BQKjE+b4iTANOHY5+C30pj8Thee/ALzPjxOvcY48Dt0O4rpx7iJtcoXPC
 RdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718261796; x=1718866596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GTD52IR0wubc3Sdt6b1ZbOCffpjz6fWRvZ8uBXbwUEY=;
 b=XkkIUpRDM1VqoSuz0zxObEbqwO1PMg4c1zQ0HM52cqv37S6tvZMzFLqEBcecQF5qef
 QsQZDSO2DF8hUn6rx7xkG8hSQ7dZlO2RhyCLr0BL65iXE8HJUIJV3pA1UtLSN0n3xaoW
 fnkMilhHld2e9AsiiQS6P4S5lLe9ihRnY2NUbeVnALapcBxe9fxXLRTahPkkLyy/ptsn
 BhL0ACUsDOmzBGzVp4q7ZTncGckNjXgikdZ5GDfT8EOMmI6fMyQ8ec6zvZDXn2MAbufD
 NBb2nmxvlvYZAcOaEz7EVrfZDgGor6xzRlUwfFTTwzrA1r/QJb9IHsfQFpJQ3rbhrpsZ
 I2cw==
X-Gm-Message-State: AOJu0Yx+7CRCruydbMB9XnYQyojjkQHrJ3kDN65ZDAjr4DDhuV+zDLj8
 4xx20I+QikynXaBBVFY9xDPPgBi87J6yoGY47fWgojvUlLBk6iZ9NNABmRtv6BPieJdxYaY1TxY
 wM115LxckPl9OhNmQ36LDlx7k5+A=
X-Google-Smtp-Source: AGHT+IHL4JsMlklrMUvQyzl+U/f3fLvwEeCMKt8yTpF+2NJkh0MMuphxhjDar4Py22+z13ySuhh5qmbMe9dyOVEFvyM=
X-Received: by 2002:a05:620a:4042:b0:792:9482:a9a7 with SMTP id
 af79cd13be357-797f605d90amr371695385a.44.1718261795799; Wed, 12 Jun 2024
 23:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240531185804.119557-1-dongwon.kim@intel.com>
 <CAJ+F1C+PG-Tf-ADFTgBGq5nvJSCEVhFW0Pk6a2Pf7gVurbJeuw@mail.gmail.com>
 <a89b283a-24e3-4117-b465-ab8d79252625@intel.com>
 <CAJ+F1CJ-4cWV81_YTit5jTEoY6FPTeu7u177pZzb61FhXw_j0Q@mail.gmail.com>
 <fa43009f-1292-49f5-bab0-618028c16045@intel.com>
 <CAJ+F1CLAJTZLHKa9_zVo=-GLRw8JHnzJT=G4fdLLsaS1sK2HUg@mail.gmail.com>
 <0fe76150-c347-40df-8d69-18a5d132d8bc@intel.com>
In-Reply-To: <0fe76150-c347-40df-8d69-18a5d132d8bc@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 13 Jun 2024 10:56:24 +0400
Message-ID: <CAJ+F1CKsboFZ-fWUXrf5BSMKCY6boRAoTMVRLaHgGja2Eppx8g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] ui/gtk: Introduce new param - Connectors
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f84d44061abfff83"
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000f84d44061abfff83
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jun 13, 2024 at 3:34=E2=80=AFAM Kim, Dongwon <dongwon.kim@intel.com=
> wrote:

> On 6/11/2024 11:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Jun 11, 2024 at 10:28=E2=80=AFPM Kim, Dongwon <dongwon.kim@inte=
l.com
> > <mailto:dongwon.kim@intel.com>> wrote:
> >
> >     Hi Marc-Andr=C3=A9,
> >
> >     On 6/5/2024 12:26 AM, Marc-Andr=C3=A9 Lureau wrote:
> >      > Hi
> >      >
> >      > On Tue, Jun 4, 2024 at 9:59=E2=80=AFPM Kim, Dongwon
> >     <dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>
> >      > <mailto:dongwon.kim@intel.com <mailto:dongwon.kim@intel.com>>>
> wrote:
> >
> >      > Xorg may not be going away soon, but it's used less and less. As
> >     one of
> >      > the developers, I am no longer running/testing it for a long
> time. I
> >      > wish we would just drop its support tbh.
> >
> >     There are features offered by Xorg that are not offered by Wayland
> >     compositors and again, we have customers that rely on these feature=
s.
> >     One of them is the ability to position the window via
> >     gtk_window_set_position(). There are strong arguments
> >     made on either side when it comes to window positioning:
> >
> https://gitlab.freedesktop.org/wayland/wayland-protocols/-/merge_requests=
/247
> <
> https://gitlab.freedesktop.org/wayland/wayland-protocols/-/merge_requests=
/247
> >
> >
> >     Until there is a way to do this with Wayland compositors, we have t=
o
> >     unfortunately rely on Gnome + Xorg.
> >
> >
> > It's a smaller and smaller number of users. The potential/future users
> > are greater if we focus on Wayland.
>
> Right, but until Gtk + Wayland offers the same feature parity and
> customization as that of Gtk + Xorg, there will be distros/users that
> will keep it alive.
> >
> > Fwiw, GNOME (and RHEL) is set to drop Xorg support
> > (https://gitlab.gnome.org/GNOME/gnome-session/-/merge_requests/98
> > <https://gitlab.gnome.org/GNOME/gnome-session/-/merge_requests/98>)
>
> Doesn't look like it is going to happen anytime soon given the massive
> pushback.
>

The plan is there, GNOME has made bold moves in the past. There is not much
left in the TODO. But yes, it takes a bit longer than expected.


>
> >
> > Btw, there is a similar monitor-mapping functionality implemented in
> > virt-viewer/remote-viewer:
> > https://www.mankier.com/1/virt-viewer#Configuration
> > <https://www.mankier.com/1/virt-viewer#Configuration>. Is this
> something
> > that those users could use instead?
>
> It looks a bit similar and interesting but one difference is that our
> feature uses monitor labels such as DP-1, HDMI-2 which is a bit more
> intuitive. And, the other key difference is that our feature includes
>

Intuitive, perhaps. Discoverable and portable?

"hotplug" functionality where a Guest display/window is deeply tied to a
> physical monitor to make it appear to the guest that it is dealing with
> a real physical monitor.
>
In other words, when the physical monitor is unplugged, the associated
> guest display/window gets destroyed/hidden and gets recreated/shown when
> the monitor is hotplugged again.
>
>
Interesting case that could be added to virt-viewer if it's necessary.

>
The subject is sufficiently complex that there is already additional
documentation/specification in:
https://gitlab.com/virt-viewer/virt-viewer/-/tree/master/docs?ref_type=3Dhe=
ads

Honestly, I don't support the idea of duplicating this effort in QEMU.

--=20
Marc-Andr=C3=A9 Lureau

--000000000000f84d44061abfff83
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 3:34=E2=80=
=AFAM Kim, Dongwon &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim=
@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On 6/11/2024 11:42 PM, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; Hi<br>
&gt; <br>
&gt; On Tue, Jun 11, 2024 at 10:28=E2=80=AFPM Kim, Dongwon &lt;<a href=3D"m=
ailto:dongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a> <b=
r>
&gt; &lt;mailto:<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_blank">=
dongwon.kim@intel.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Marc-Andr=C3=A9,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 6/5/2024 12:26 AM, Marc-Andr=C3=A9 Lureau wrote:=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hi<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Tue, Jun 4, 2024 at 9:59=E2=80=AFPM Kim, D=
ongwon<br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"mailto:dongwon.kim@intel.com" target=
=3D"_blank">dongwon.kim@intel.com</a> &lt;mailto:<a href=3D"mailto:dongwon.=
kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; &lt;mailto:<a href=3D"mailto:dongwon.kim@inte=
l.com" target=3D"_blank">dongwon.kim@intel.com</a> &lt;mailto:<a href=3D"ma=
ilto:dongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a>&gt;=
&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Xorg may not be going away soon, but it&#39;s=
 used less and less. As<br>
&gt;=C2=A0 =C2=A0 =C2=A0one of<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; the developers, I am no longer running/testin=
g it for a long time. I<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; wish we would just drop its support tbh.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0There are features offered by Xorg that are not off=
ered by Wayland<br>
&gt;=C2=A0 =C2=A0 =C2=A0compositors and again, we have customers that rely =
on these features.<br>
&gt;=C2=A0 =C2=A0 =C2=A0One of them is the ability to position the window v=
ia<br>
&gt;=C2=A0 =C2=A0 =C2=A0gtk_window_set_position(). There are strong argumen=
ts<br>
&gt;=C2=A0 =C2=A0 =C2=A0made on either side when it comes to window positio=
ning:<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://gitlab.freedesktop.org/wayland/w=
ayland-protocols/-/merge_requests/247" rel=3D"noreferrer" target=3D"_blank"=
>https://gitlab.freedesktop.org/wayland/wayland-protocols/-/merge_requests/=
247</a> &lt;<a href=3D"https://gitlab.freedesktop.org/wayland/wayland-proto=
cols/-/merge_requests/247" rel=3D"noreferrer" target=3D"_blank">https://git=
lab.freedesktop.org/wayland/wayland-protocols/-/merge_requests/247</a>&gt;<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Until there is a way to do this with Wayland compos=
itors, we have to<br>
&gt;=C2=A0 =C2=A0 =C2=A0unfortunately rely on Gnome + Xorg.<br>
&gt; <br>
&gt; <br>
&gt; It&#39;s a smaller and smaller number of users. The potential/future u=
sers <br>
&gt; are greater if we focus on Wayland.<br>
<br>
Right, but until Gtk + Wayland offers the same feature parity and <br>
customization as that of Gtk + Xorg, there will be distros/users that <br>
will keep it alive.<br>
&gt; <br>
&gt; Fwiw, GNOME (and RHEL) is set to drop Xorg support <br>
&gt; (<a href=3D"https://gitlab.gnome.org/GNOME/gnome-session/-/merge_reque=
sts/98" rel=3D"noreferrer" target=3D"_blank">https://gitlab.gnome.org/GNOME=
/gnome-session/-/merge_requests/98</a> <br>
&gt; &lt;<a href=3D"https://gitlab.gnome.org/GNOME/gnome-session/-/merge_re=
quests/98" rel=3D"noreferrer" target=3D"_blank">https://gitlab.gnome.org/GN=
OME/gnome-session/-/merge_requests/98</a>&gt;)<br>
<br>
Doesn&#39;t look like it is going to happen anytime soon given the massive =
<br>
pushback.<br></blockquote><div><br></div><div>The plan is there, GNOME has =
made bold moves in the past. There is not much left in the TODO. But yes, i=
t takes a bit longer than expected.<br></div><div>=C2=A0<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; Btw, there is a similar monitor-mapping functionality implemented in <=
br>
&gt; virt-viewer/remote-viewer: <br>
&gt; <a href=3D"https://www.mankier.com/1/virt-viewer#Configuration" rel=3D=
"noreferrer" target=3D"_blank">https://www.mankier.com/1/virt-viewer#Config=
uration</a> <br>
&gt; &lt;<a href=3D"https://www.mankier.com/1/virt-viewer#Configuration" re=
l=3D"noreferrer" target=3D"_blank">https://www.mankier.com/1/virt-viewer#Co=
nfiguration</a>&gt;. Is this something <br>
&gt; that those users could use instead?<br>
<br>
It looks a bit similar and interesting but one difference is that our <br>
feature uses monitor labels such as DP-1, HDMI-2 which is a bit more <br>
intuitive. And, the other key difference is that our feature includes <br><=
/blockquote><div><br></div><div>Intuitive, perhaps. Discoverable and portab=
le? <br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
&quot;hotplug&quot; functionality where a Guest display/window is deeply ti=
ed to a<br>
physical monitor to make it appear to the guest that it is dealing with <br=
>
a real physical monitor.<br></blockquote><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
In other words, when the physical monitor is unplugged, the associated <br>
guest display/window gets destroyed/hidden and gets recreated/shown when <b=
r>
the monitor is hotplugged again.<br>
<br></blockquote><div><br></div><div><div>Interesting case that could be ad=
ded to virt-viewer if it&#39;s necessary. <br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
</blockquote>=C2=A0</div><div>The subject is sufficiently complex that ther=
e is already additional documentation/specification in:</div><div><a href=
=3D"https://gitlab.com/virt-viewer/virt-viewer/-/tree/master/docs?ref_type=
=3Dheads">https://gitlab.com/virt-viewer/virt-viewer/-/tree/master/docs?ref=
_type=3Dheads</a></div><div><br></div><div>Honestly, I don&#39;t support th=
e idea of duplicating this effort in QEMU.<br></div><div><br></div></div><s=
pan class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=
=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000f84d44061abfff83--

