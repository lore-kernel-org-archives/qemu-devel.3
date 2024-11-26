Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CA6D6555A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 21:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG2n6-0007F6-LU; Tue, 26 Nov 2024 16:08:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1tG2n4-0007Et-MF
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:08:10 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1tG2n2-0007Jg-Kh
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:08:10 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7fc2b80c845so1682593a12.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 13:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1732655286; x=1733260086; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FdEOvavNpSRAUjLhZ4H247i44KwvRZHjQ45z2kx+GhI=;
 b=fAInQj1wYR4mXpS7yQdsJedIzblLkVmMvPS8gwy+PiCqMu6HNe9HI0757EjYOwAWu5
 RsyMiRCBsvzAMHSKwUu8rjDTr/34nhmi/HzTzMFRW9M2WgQLhusYc3z6H463Depy5aD1
 lOajJSGJCDECs0f9n79fb0ydkbFQEOeJY2hj9EWTZy86MKq7X6Vs+3UW5qPSV7n6bENu
 6M4lY+fbCOd4ftIbl/aOtcfSHdN+N+XEs12wzTAJt595xtPkVXTHkgJ3G30miaAONpZU
 tgRF5/xllEPwXBomu06CatGujCXbgrF1a4KSWxTA48/AqFnCNOat4UmkRTqcWehTiAgu
 p/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732655286; x=1733260086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FdEOvavNpSRAUjLhZ4H247i44KwvRZHjQ45z2kx+GhI=;
 b=h8aSos1fPh/w+hBVseufc11bbQMLJsoN5Kn9Z4h5tvHOJqtaRGaPJNeNONenYC36+g
 jKKTj50/gtuFOuC/yUMHlsaE/JIr7YOSxji8JAZ1tVsS+bqlvchYoZog3vjuVFBDifX8
 PiLkKy1eU3qVj3IUdD1G68WYHaaYKTD018uBoMbcARTP2w9+PoYn1AjWWzxwhfL10Dje
 9oeZ6ObkKZ3D/fWY61PcyH4K5RSChEecSKBADJvPvLDMFsO12ecCvfKLKnsbpNYlWanP
 Gkzr7Tp0btM45vmBRP4IAmld7YLnLDi/rkFu7Fvw168oCmxTJxGSDKsUtDU2AUfwPL/H
 6lUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDvBFgTkUip2gZzicHB+UKXnxXfBmlZlJtZocmHlDNYdwqg3qBkhrTwsytn9LmFalV7gLTCnlZrfkX@nongnu.org
X-Gm-Message-State: AOJu0Yws+q76J1UB7Ym9D9oVhNNi789XXHucRI2677DWHrxU5MeUGzJ3
 e22pMTOGo0kh0/KQpEPhErN0F5nbJevvTYsJtgXPDsP42hA4Ck++1s77E79YlRQnTUVc7nvz78+
 OQ2LrIq23tgLBrE+mkvS9p9q26j98MzKhBUU=
X-Gm-Gg: ASbGnctyqinaFBa6MSe6EdZJqyoIt7JbVg8ZOLpgJhb6Z3VbijjBXq/bpdRcKDWEJuX
 TQoIGjdgpRqgCzHv0nIAOYjAP+YbLe1dBajAc2mvcUW8evtMp2SjJqVJZ2B8=
X-Google-Smtp-Source: AGHT+IH+E/RoRmRQGGr+LMjCrekFgioSwgQwdwcygnqlsj9cla2BO7ijSDr+JZPk55YQw+H1hRgeB8uFq5pgOWzebd0=
X-Received: by 2002:a05:6a20:e198:b0:1e0:c8c5:9b1c with SMTP id
 adf61e73a8af0-1e0e0ac3716mr1246052637.9.1732655286029; Tue, 26 Nov 2024
 13:08:06 -0800 (PST)
MIME-Version: 1.0
References: <20241017215304.3916866-1-roqueh@google.com>
 <20241017215304.3916866-3-roqueh@google.com>
 <Z0RnuVKPHO1T2BfV@redhat.com>
 <CAGZECHOTT1bs0frj-QDyRtudFNb+VzD4tZsnk4Fj=Q0OH+1v3Q@mail.gmail.com>
 <Z0XxYpvj49colIIy@redhat.com>
In-Reply-To: <Z0XxYpvj49colIIy@redhat.com>
From: Andrew Keesler <ankeesler@google.com>
Date: Tue, 26 Nov 2024 16:07:54 -0500
Message-ID: <CAGZECHMEYjL56AZebqOK4dTgQbLtwA=9=yZ0qi0ymSpMS2x7Gw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/display: Allow injection of virtio-gpu EDID name
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Roque Arcudia Hernandez <roqueh@google.com>, mst@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, venture@google.com
Content-Type: multipart/alternative; boundary="000000000000d807a90627d73e47"
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=ankeesler@google.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--000000000000d807a90627d73e47
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Daniel. We'll get this patch updated and send it out again.

> it makes sense to allow for a data structure

Whoops, I misread your original message - data structure SGTM.

On Tue, Nov 26, 2024 at 11:04=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
wrote:

> On Mon, Nov 25, 2024 at 03:54:40PM -0500, Andrew Keesler wrote:
> > I follow what you are saying. I misunderstood what a "display" was in t=
he
> > domain of QEMU. Yes, this makes more sense now.
> >
> > > the user should give names for every output at startup
> >
> > I see DEFINE_PROP_ARRAY exists. I can use that to define the new
> "outputs"
> > property. Any reason that each "output" would ever need to be an object
> > (rather than just a string)? Nothing comes to mind, I'm just taking a
> second
> > to think about API forwards compatibility.
>
> Currently we have 'xres' and 'yres' properties set against the device
> for virtio-gpu.
>
> If we're going to extend  it to allow the name of each "output" head
> to be configured, it makes sense to allow for a data structure that
> will let us also cnofigure xres & yres per output.
>
> Hence, I thought it would make more sense to have an array of structs,
> rather than the simpler array of strings, which will let us set any
> amount of per-output config data we might want in future.
>
> NB, I'm not asking you to wire up support for xres/yres per output,
> just that we anticipate it as a possibility.
>
> > > upto whatever they said for "max_outputs"
> >
> > Where is the best place to perform this validation? I would imagine we
> would
> > want to fast-fail if the user provided more "outputs" than
> "max_outputs". I
> > can
> > perform the validation in virtio_gpu_base_get_features but that seems
> late.
>
> I'd suggest putting it in virtio_gpu_base_device_realize, as we already
> have code there to validate 'max_outputs" is within limits.
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--000000000000d807a90627d73e47
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks, Daniel. We&#39;ll get this patch updated and =
send it out again.</div><div><br></div><div>&gt; it makes sense to allow fo=
r a data structure</div><div><br></div><div>Whoops, I misread your original=
 message - data structure SGTM.</div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 26, 2024 at 11:04=E2=80=AF=
AM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berra=
nge@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Mon, Nov 25, 2024 at 03:54:40PM -0500, Andrew Keesler wrot=
e:<br>
&gt; I follow what you are saying. I misunderstood what a &quot;display&quo=
t; was in the<br>
&gt; domain of QEMU. Yes, this makes more sense now.<br>
&gt; <br>
&gt; &gt; the user should give names for every output at startup<br>
&gt; <br>
&gt; I see DEFINE_PROP_ARRAY exists. I can use that to define the new &quot=
;outputs&quot;<br>
&gt; property. Any reason that each &quot;output&quot; would ever need to b=
e an object<br>
&gt; (rather than just a string)? Nothing comes to mind, I&#39;m just takin=
g a second<br>
&gt; to think about API forwards compatibility.<br>
<br>
Currently we have &#39;xres&#39; and &#39;yres&#39; properties set against =
the device<br>
for virtio-gpu.<br>
<br>
If we&#39;re going to extend=C2=A0 it to allow the name of each &quot;outpu=
t&quot; head<br>
to be configured, it makes sense to allow for a data structure that<br>
will let us also cnofigure xres &amp; yres per output.<br>
<br>
Hence, I thought it would make more sense to have an array of structs,<br>
rather than the simpler array of strings, which will let us set any<br>
amount of per-output config data we might want in future.<br>
<br>
NB, I&#39;m not asking you to wire up support for xres/yres per output,<br>
just that we anticipate it as a possibility.<br>
<br>
&gt; &gt; upto whatever they said for &quot;max_outputs&quot;<br>
&gt; <br>
&gt; Where is the best place to perform this validation? I would imagine we=
 would<br>
&gt; want to fast-fail if the user provided more &quot;outputs&quot; than &=
quot;max_outputs&quot;. I<br>
&gt; can<br>
&gt; perform the validation in virtio_gpu_base_get_features but that seems =
late.<br>
<br>
I&#39;d suggest putting it in virtio_gpu_base_device_realize, as we already=
<br>
have code there to validate &#39;max_outputs&quot; is within limits.<br>
<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div>

--000000000000d807a90627d73e47--

