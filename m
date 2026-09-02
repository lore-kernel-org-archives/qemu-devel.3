Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C37DC624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 03:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1bqa-0004y7-23; Tue, 01 Sep 2026 23:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rtvernam@gmail.com>)
 id 1x1bqY-0004xf-AZ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 23:41:10 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rtvernam@gmail.com>)
 id 1x1bqW-0000z3-KP
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 23:41:10 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-81ed2a06b9eso9880277b3.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 20:41:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788320467; cv=none;
 d=google.com; s=arc-20260327;
 b=lgS/ikd/5MPJ9pyKmKQrEYm3LtN9aieasDC54QkjH/OROvIMWGQzYFkthGh8dZaMK1
 ihWElT5RWxjaAv0093a79rlUM6lvsJYCJjPuoMOtGNXikXpHieyf7S+MdAtvHjHbWJZL
 1m+IAGrKl2HCzj1opidupwzOjwgNTA+yMi0dhNYX8lk6S7HGvHJX5n6Chgkjo55JVDl8
 NsF4sqJ0Zk148HHYuSel7RCSXZwxxklbDGBQg5Ajy8vtwrF873liqYcQfgdLCgKdEzUL
 1KRA0L+2eMDgNvp5X3nyrXTejXh2ts6UXr6xOeqZx8IOUxkD/VTMhqMPeR5D6nn3/niY
 YzkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NUyEM8rvBT9MI5baiqKWDxuRq3BiwSP6mn2cGxuP2Rw=;
 fh=K+1FFnVBEkxNx/42+WERro1ZDpUg3jkoX1u5kPtdbys=;
 b=FFBuKnXpyvebugNsqTcH3oh8nh/vuXrsrITfw3EJ5ehO67mb95rsD0XDBHCEwNEuU6
 e2D9433dzTBEY5r76G+lL7pO1LDnV3h8hJ9wrcsCvxN30RUmRvXwxWyTD9ufhG1sD1jA
 WG5yWwLgkyw6vpo+OPnW8IZ0MR0q/UnDUur1OiZTtSJbtt3KaEBE7r2cRW/2LX7wJVge
 fvfmeOBzJ07g5F8uu9JM3aNCvNzzs6IacHJz5h2LXV6yFvYSNJRUEZxTMCw3g2bbPal1
 fiWOwaMshhGbMHSATfgrsUiHpAszH1J3OUyuoh5K0cmwNZ8CXH/xHGt72xEblJxZgUky
 n3Tg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788320467; x=1788925267; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NUyEM8rvBT9MI5baiqKWDxuRq3BiwSP6mn2cGxuP2Rw=;
 b=Mw8UEKESvey5UHdRZacLLNVcU0Ge8zNniM/75ppPMVUKqooUcNtxqmD8ZImsPcP/rA
 JCxEMDzjF+Q0CdUjEfnxDCVqGOrF5BRv+8b4pAcLmk4R5gCi1SLJSoONAamGzSTmUih6
 12Uq3kY0IWPdf0f1bQcqnFtDIBTjphHbH4uUibw8s3pmgLpyyLGiKs4aSwLCsVHU8x2D
 AYnJ8Kw/rbujB8xAu7/01hKVN5d0WAz/in3VglXkROshPu7llH29oy9Ke72/Gw1ztoT2
 sVrnusvxY2j/jkgcEpsAf6CODzjC5kJAF2P/k/IGSaks7DBLa351SIumLa4CmaaBynuW
 zD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788320467; x=1788925267;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NUyEM8rvBT9MI5baiqKWDxuRq3BiwSP6mn2cGxuP2Rw=;
 b=pgU3TIZ9pFvw/eiIe9Mosju66rRQ+2mtOkI2n9MowkBQG0a5T4fOZolbNY/ECbmU3z
 bO+vATh5vIIKxGsBajfQ01hYkh8a0vY0JriQfftJwWrcbEo8l9YNBUWOugEJFwjDM6uZ
 QwUu1naHbWRKRy0Z58hOxHxARPejjD4dxY9XZ1nowVKcAKaNABHTMb2Y5qGZ3nSnKuKh
 uJE7ZeD4GbrYpgFDMTgvdopneZrXg3T2/MpTu3mkO0q8ySp8L4UNHW3//IGwkEUrCMus
 G5Y+qCAyqNszO1qZREAyjSvCTCRt79fx0zk6iH2VYeNAJ4jiV+nQSbTchYSjMD2b3QrW
 EZiw==
X-Gm-Message-State: AFuF++maFrqK2KZHS+LSHmQnY5neAbADI2q2YcnyWZKZ90Z8f87z4juv
 Mp66uWmVlnujawB/S46tUNxDtLQEeEPSSpfQHFXdb/q9sGCUdp/l7pAe521SRfen1O9yKy+GIwj
 n5YOJw+osD+eeC6eofu25lgGQwKqC9hc=
X-Gm-Gg: AYBFou09OfuTahjqUC+0feOzein7X/Xs2qxbYGktb2OawEhpFbE9H0vj3Z0iAqn08RZ
 87iS4pl2NHGPOAka+g1RcTZ3P2I9+1tglM7giNnqnkSdT8P/tuLHSjMgoQqPG4QB4C69WEpHJWe
 Ndn2Bk0zt924hHWB8YVVjbN1k6fXn0Px6K7SEVbTpHyX6/5untSbwwkBIrqQ13yCjCcgMh7Jq5H
 fG/obuAN1q2o7NVDKXsuA4u4JtvnCdR3+QuySdccNA0lb8qXiE+82L0yNavsaYAlv5rCKwvi7we
 FUdEZ1trvfBhTMFYUzOoMobPtugbVxRji+IoXkK/+7ZwVA==
X-Received: by 2002:a05:690c:1a:b0:862:2e2b:8639 with SMTP id
 00721157ae682-86c558be269mr10171267b3.33.1788320467165; Tue, 01 Sep 2026
 20:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAFH9MbUdL=HuSvqpwHF-1yo-MeCGREQoqKjdT7us=5CiKSxp3w@mail.gmail.com>
 <CAJ+F1CJHpTLPdacLa31J1m_oUkH-TZ0MOpQJNwMAt806sdZmNg@mail.gmail.com>
In-Reply-To: <CAJ+F1CJHpTLPdacLa31J1m_oUkH-TZ0MOpQJNwMAt806sdZmNg@mail.gmail.com>
From: rick vernam <rtvernam@gmail.com>
Date: Tue, 1 Sep 2026 22:40:53 -0500
X-Gm-Features: AcwNN1VPJECWulz1cNbP6-0oNUy3lD49wTve6PTkaUj8mcbnEAKPRxW7d4DGct0
Message-ID: <CAFH9MbVSBw6Wv7W+erhtsdpHaBAqOJ=9poxeGbuEhjO2FQHFfg@mail.gmail.com>
Subject: Re: qemu-vdagent guest to host clipboard sync
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000030a62c065a77ceb7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=rtvernam@gmail.com; helo=mail-yw1-x1130.google.com
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

--00000000000030a62c065a77ceb7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Guest agent is one I am working to develop presently; not a public repo
yet.  Intended to be strictly local dbus only.  Narrow use case, but
something I would like to have.

I can try to send what you've requested, though it will be another day or
two before I can get back to it.

Thanks!
- Rick

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

--00000000000030a62c065a77ceb7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Guest agent is one I am working to develop presently=
; not a public repo yet.=C2=A0 Intended to be strictly local dbus only.=C2=
=A0 Narrow use case, but something I would like to have.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">I can try to send what you&#39;ve requeste=
d, though it will be another day or two before I can get back to it.</div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Thanks!</div><div dir=3D"auto"=
>- Rick<br><br><div class=3D"gmail_quote gmail_quote_container" dir=3D"auto=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 1, 2026, 10:53 Marc-And=
r=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.com">marcandre.=
lureau@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi =
Rick<br>
<br>
On Tue, Sep 1, 2026 at 3:57=E2=80=AFPM rick vernam &lt;<a href=3D"mailto:rt=
vernam@gmail.com" target=3D"_blank" rel=3D"noreferrer">rtvernam@gmail.com</=
a>&gt; wrote:<br>
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
Marc-Andr=C3=A9 Lureau<br>
</blockquote></div></div></div>

--00000000000030a62c065a77ceb7--

