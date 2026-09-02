Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3760C61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1cOG-0002KC-LR; Wed, 02 Sep 2026 00:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rtvernam@gmail.com>)
 id 1x1cOE-0002Jo-QV
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:15:58 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rtvernam@gmail.com>)
 id 1x1cOC-0006CP-P8
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:15:58 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-865bdc6ed72so11592947b3.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:15:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788322555; cv=none;
 d=google.com; s=arc-20260327;
 b=rdwTIdDCbbf9PjpdO2LmDXwUjDO6WHI78d8v2FxcNHLpCAmBIq6+RUVRspXS3O8FSq
 tUNigMfqbPSzbBZB2eqdQb+1ZweCqBknIsZk7jh62BOfv0srwf6wplKT49csCQ7kmpf8
 I4odd+5qm22dXtGhwocMVWoTqqpryIW9dYZoArLTOWxfzVljw8gMG3UrQ+z845IZK/nQ
 hfDVKdOSyFtqXkZCc6RjOnA4pyEUYGo33Z4WLy/uaGzV3g0EsmPgOd42DMrQcdBJroas
 hq5nX7bSpT6RkxQnbhlD4KuSPI0AbkNjSyQwsrpVaWi+mKLU2mdl/BvJjyYmM0bVnTGr
 LwdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=scJNhhcI4FtQLzGV1UZgH85tOWcKAnaNA9yUAo5FBbc=;
 fh=K+1FFnVBEkxNx/42+WERro1ZDpUg3jkoX1u5kPtdbys=;
 b=sw0ta+ZrhgfecsljW2BfTpDqk+2avXVJeCiByjE8Q53zKNTpF0hvg41gg3JgFtBfvA
 92R4SuvD/sn/rmbzCoYVeS+DySejvNRRhBs/HJgdVYmzpqC7DnZHKNhWbBhA3KC7Pyg8
 gKb6wUfh/cJX0fG0HN4QGje+Qhd2bIh1XqZfqKkQUVGIgTrzKkJ9lyx19kwqMo5j9FJc
 tPH/8KKmpbpiLXwedBAmkcxUeEPvy/7pcA6E/9h2algy+re4kAWgTEYCHXH000bXZsFQ
 IOC2zAm0l3F5F7Onfr8iwRNlpuU2MkzW2cV+6gQjCkac0igElT7PwcRDrfwV/b7MotQN
 v1uQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788322555; x=1788927355; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=scJNhhcI4FtQLzGV1UZgH85tOWcKAnaNA9yUAo5FBbc=;
 b=gfyIeY4v35QJWu205F8cDhr0ekih6pf32ZnLVu6w0X7BmPKltpZDNyKcx67sJyaf2V
 sNcaQYUsgfQOsUcwKEG3ziWkHgNP8eHYzU0IZdOBZhg2ov/+9gGcfr+EjHHDqzCDiuum
 PHdc67O9hOte/jRbAi3SyQ9Z1tXu7Fvf3VexsMEw7qrl/OHH6wFLPllPOo+u95E0pxBt
 2XusNTXUJUBnENC0nn211y56DUi7tFNMtH/0jIzPv/A/vB0yG4ZFI/NB2CjmlcOjB+M4
 wPnzJgw0cabPIwqmV9+s4GjQmQ8O5FJjBhYtJ6n8UD4GVvLHVvjLVMmakzHJv9sFRxLq
 xFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788322555; x=1788927355;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=scJNhhcI4FtQLzGV1UZgH85tOWcKAnaNA9yUAo5FBbc=;
 b=q84WSifkTnQnMEtbE/QNE/KhOSBBqH05cHV/nm+QgTFqco/MzwBQhl3tPbvYTRKyCZ
 0NWx/kr4CcoOj1T8NmvxYPbdYyIi0k40RI+Q5mi702UDG5sB5UbsvfaktIVtMY5R+6F7
 DscEZ6ghPKACJ/W1nM8/U2uAWivxOCmi3xQyRYCXyf58Gmm7TKteSztxnA+ttQABEJyA
 9hrHudsxo7IRI3ElLWqonIAO0MMW47Q8H5GBw+kPGR+HUrRjh91B+naMj8+scQKQwRoM
 8WUKDrT7peBXsPdKfT6xFx2YnkgkiVMC/K1jnTTg1x/3fdAEU4B043ZI0ST88KujBIeu
 HwmQ==
X-Gm-Message-State: AFuF++nCAQaxbcWK+dQ9LNLBbbBTEUDnGpxyVHuNzD3DUptaFCZdgHeB
 qw0rWatWOrynjSE43qKwzdRhLnvDtv3jxpjguGppxaygGi9RtNV2iT0UJlpHYVPn4iKWmPBbfiy
 A5Isq6M4+qTaTy7MbRSE48/1Qiis7uS8=
X-Gm-Gg: AYBFou1kGvQ7UUdOHiV0XCRubJxq+tzzqEVoc22UhnMfqi662CtSeYpxHJ2vgxUh+w4
 SyaLiQSgTnGQS5PG5uuOxSV0hipPMG8QeEBo6dm4BDCReRkh9gmN/14iEA3+fchq86Go6EmAbHC
 lhJtnB0zz9cw+pcnzQKZPErZD+ystH5bZI0zgRWLY2f5oViYB+u8vzEWk7OH2hJWV6AEm5iHbjl
 QMbq40UICH+raI+pdkw8x1hj8SsVW8nx4m5CzIv7xS5dRclBie5725EzAgjvCZQ94ch6IKRM5Ue
 sh9siILDHyFOjLtcwNaUlP5Fg6KdOe88EfDxVsX/P1uwYCtavyRjWRXJ
X-Received: by 2002:a05:690c:438c:b0:844:c27b:35dc with SMTP id
 00721157ae682-86c526fe88cmr8783387b3.18.1788322555201; Tue, 01 Sep 2026
 21:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAFH9MbUdL=HuSvqpwHF-1yo-MeCGREQoqKjdT7us=5CiKSxp3w@mail.gmail.com>
 <CAJ+F1CJHpTLPdacLa31J1m_oUkH-TZ0MOpQJNwMAt806sdZmNg@mail.gmail.com>
In-Reply-To: <CAJ+F1CJHpTLPdacLa31J1m_oUkH-TZ0MOpQJNwMAt806sdZmNg@mail.gmail.com>
From: rick vernam <rtvernam@gmail.com>
Date: Tue, 1 Sep 2026 22:57:24 -0500
X-Gm-Features: AcwNN1U1upyUp_mqQ9WLe1_t-o2oKsi2ADL-PSFAZ9-w-dN1ZAHu5jk-oGpAf4A
Message-ID: <CAFH9MbWQDp3BFpPK=0qPy5co+tNmaqoP9HkEmYAAddiDDcuOqg@mail.gmail.com>
Subject: Re: qemu-vdagent guest to host clipboard sync
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a58dfe065a784a0c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=rtvernam@gmail.com; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000a58dfe065a784a0c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026, 10:53 Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.c=
om>
wrote:

> Hi Rick
>
> On Tue, Sep 1, 2026 at 3:57=E2=80=AFPM rick vernam <rtvernam@gmail.com> w=
rote:
> >
> > Hello,
> >
> > With -display dbus, clipboard sync only works host to guest; guest to
> host fails without any failure messaging.
> >
> > The guest's 'clipboard-grab' message is received correctly by
> ui/vdagent.c, but ui/dbus-clipboard.c:dbus_clipboard_update_info() drops =
it
> before it ever reaches the D-Bus display client.
> > Checking info->has_serial in dbus_clipboard_update_info() always fails
> for guest to host as has_serial is never assinged:
> >
> > if (self_update || !info->has_serial) {
> >     return;
> > }
> >
> > Steps to reproduce:
> > 1. Start QEMU with:
> >    "-display dbus,gl=3Don -chardev
> qemu-vdagent,...,name=3Dvdagent,clipboard=3Don -device
> virtserialport,...,name=3Dcom.redhat.spice.0"
> > 2. Connect a D-Bus display client implementing
> "org.qemu.Display1.Clipboard"
> > 3. In the guest, copy text to the clipboard.
> > 4. Observe on the host side.
> >
> > Expected result:
> > Guest clipboard content is forwarded to the D-Bus client via
> "Clipboard.Grab".
> >
> > Actual result:
> > Nothing is forwarded. "dbus_clipboard_update_info()" returns early, a
> subsequent "Clipboard.Request" from the host fails with "Empty clipboard"=
.
> >
> > Fix tested locally:
> > Removing the check of info->has_serial resolves the issue with no
> observed regression on Windows or Linux guests:
> >
> > -    if (self_update || !info->has_serial) {
> > +    if (self_update) {
> >          return;
> >      }
> >
> > I didn't really consider an approach of setting info->has_serial as tha=
t
> looked like a larger patch, and it appears dbus_clipboard_grab() takes a
> similar approach to this fix by setting has_serial unconditionally for ho=
st
> to guest clipboard sync.
> >
> > I believe this if statement has been unchanged since the initial commit
> ff1a5810f61f78b47ddad995f49bcc70171d9e38 "ui/dbus: add clipboard interfac=
e".
>
> What's your guest agent? Can you send a patch with all the details and
> proprosed fix, rather than a regular mail?
>
> thanks!
>
> --
> Marc-Andr=C3=A9 Lureau
>

Clearly by top-posting I have shown my inexperience collaborating via mail
lists.  Appologising & re-posting here so you can ignore my previous faux
pas.

Guest is Windows 11, guest agent is qemu-vdagent in the fedora virtio-win
iso binary release (multiple versions, including recent v302).

As for sending a patch with all the details and proprosed fix, I won't be
able to get back to this for a few days, so I'll send something then.

Thanks,
- Rick

>

--000000000000a58dfe065a784a0c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Tue, Sep 1, 2026, 10:53 Marc-Andr=C3=A9 Lureau &lt;<a href=
=3D"mailto:marcandre.lureau@gmail.com" target=3D"_blank" rel=3D"noreferrer"=
>marcandre.lureau@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">Hi Rick<br>
<br>
On Tue, Sep 1, 2026 at 3:57=E2=80=AFPM rick vernam &lt;<a href=3D"mailto:rt=
vernam@gmail.com" rel=3D"noreferrer noreferrer" target=3D"_blank">rtvernam@=
gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hello,<br>
&gt;<br>
&gt; With -display dbus, clipboard sync only works host to guest; guest to =
host fails without any failure messaging.<br>
&gt;<br>
&gt; The guest&#39;s &#39;clipboard-grab&#39; message is received correctly=
 by ui/vdagent.c, but ui/dbus-clipboard.c:dbus_clipboard_update_info() drop=
s it before it ever reaches the D-Bus display client.<br>
&gt; Checking info-&gt;has_serial in dbus_clipboard_update_info() always fa=
ils for guest to host as has_serial is never assinged:<br>
&gt;<br>
&gt; if (self_update || !info-&gt;has_serial) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0return;<br>
&gt; }<br>
&gt;<br>
&gt; Steps to reproduce:<br>
&gt; 1. Start QEMU with:<br>
&gt;=C2=A0 =C2=A0 &quot;-display dbus,gl=3Don -chardev qemu-vdagent,...,nam=
e=3Dvdagent,clipboard=3Don -device virtserialport,...,name=3Dcom.redhat.spi=
ce.0&quot;<br>
&gt; 2. Connect a D-Bus display client implementing &quot;org.qemu.Display1=
.Clipboard&quot;<br>
&gt; 3. In the guest, copy text to the clipboard.<br>
&gt; 4. Observe on the host side.<br>
&gt;<br>
&gt; Expected result:<br>
&gt; Guest clipboard content is forwarded to the D-Bus client via &quot;Cli=
pboard.Grab&quot;.<br>
&gt;<br>
&gt; Actual result:<br>
&gt; Nothing is forwarded. &quot;dbus_clipboard_update_info()&quot; returns=
 early, a subsequent &quot;Clipboard.Request&quot; from the host fails with=
 &quot;Empty clipboard&quot;.<br>
&gt;<br>
&gt; Fix tested locally:<br>
&gt; Removing the check of info-&gt;has_serial resolves the issue with no o=
bserved regression on Windows or Linux guests:<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 if (self_update || !info-&gt;has_serial) {<br>
&gt; +=C2=A0 =C2=A0 if (self_update) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; I didn&#39;t really consider an approach of setting info-&gt;has_seria=
l as that looked like a larger patch, and it appears dbus_clipboard_grab() =
takes a similar approach to this fix by setting has_serial unconditionally =
for host to guest clipboard sync.<br>
&gt;<br>
&gt; I believe this if statement has been unchanged since the initial commi=
t ff1a5810f61f78b47ddad995f49bcc70171d9e38 &quot;ui/dbus: add clipboard int=
erface&quot;.<br>
<br>
What&#39;s your guest agent? Can you send a patch with all the details and<=
br>
proprosed fix, rather than a regular mail?<br>
<br>
thanks!<br>
<br>
-- <br>
Marc-Andr=C3=A9 Lureau<br></blockquote></div></div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Clearly by top-posting I have shown my inexperience c=
ollaborating via mail lists.=C2=A0 Appologising &amp; re-posting here so yo=
u can ignore my previous=C2=A0faux pas.</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Guest is Windows 11, guest agent is qemu-vdagent in the fed=
ora virtio-win iso binary release (multiple versions, including recent v302=
).</div><div dir=3D"auto"><br></div><div dir=3D"auto">As for sending a patc=
h with all the details and proprosed fix, I won&#39;t be able to get back t=
o this for a few days, so I&#39;ll send something then.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Thanks,</div><div dir=3D"auto">- Rick</div>=
<div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
</blockquote></div></div></div>

--000000000000a58dfe065a784a0c--

