Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12409C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdZfj-0007b9-88; Fri, 23 Feb 2024 12:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@daveparsons.net>)
 id 1rdZIP-0008Jn-KD; Fri, 23 Feb 2024 12:25:13 -0500
Received: from poodle.tulip.relay.mailchannels.net ([23.83.218.249])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@daveparsons.net>)
 id 1rdZIM-0001dS-4q; Fri, 23 Feb 2024 12:25:13 -0500
X-Sender-Id: thundermail|x-authsender|dave@daveparsons.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 5D1887A3ACE;
 Fri, 23 Feb 2024 17:25:05 +0000 (UTC)
Received: from mailclean11.thundermail.uk (unknown [127.0.0.6])
 (Authenticated sender: thundermail)
 by relay.mailchannels.net (Postfix) with ESMTPA id DF7277A1EA8;
 Fri, 23 Feb 2024 17:25:00 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1708709102; a=rsa-sha256;
 cv=none;
 b=vjIQ+4wcBqdCVcp4d5QVQs0deNZAWV49NKzq3gHz3Dx/Kzp+vKiL1CRo7uCZdp5Eb0GhKh
 FriMEHG0F49l0w2AjZVQDsNyaUD6pd/k9rOi7JKrGvTTA1jiI9pTjur3fQ6nrueUlBuqdX
 kGwC6EwxhOQyVN3yAQ8jN0cu9+sfhWSg7ZkA/pwURjpeHipQ4RYNNM+Z8z5sBzc8XCE122
 FQUxJvrpexK7acta9w6v+r/v/MIsvueLuHA6Ip4WbBUCF1/uFrqfEN5Ox/4ccYLy3kxvWh
 BxFydI0zRkQ7yGATfcCTlWmb143PkiC9ZOmlPmZfNKPDYHmwXL4CNH95xDIpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1708709102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=2bLLvW0pgeAv2h4alZP6r32PqExhDqhhFweFI/Sic9I=;
 b=SlK2pNFtFlu7RG0dX1AcJ1Fg7mfxZCBQ8e2/KbJdFMjzNGw1Mb+80VrUmmSZyhjPMJmVgG
 4VH12RCBYzafq+5ad8Bc8o6e2LG+VfwmsTVwfzCyqF+AcvppTu4eAcB2hOSesHEm/CYZwQ
 /Ah/PbBZB+f9Vu2D0BM7BXcYr6Tgagd1gK58kjXN7qjm0KbSy0E+vH1OqbPQBcc/c4sqQn
 LeBjZHFMuU60zxKVMYqFc9VkqSAVXeSGer/S34dG8ysseJzs9lJouWiUF5hlcvskf6iq9G
 H0GVuRyVbrWko3hMhW5JHeE1Ct1VuYe1WxGcIBNsDK/rGaWGQAeuLhzAlO7Vgw==
ARC-Authentication-Results: i=1; rspamd-55b4bfd7cb-jlpd4;
 auth=pass smtp.auth=thundermail smtp.mailfrom=dave@daveparsons.net
X-Sender-Id: thundermail|x-authsender|dave@daveparsons.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: thundermail|x-authsender|dave@daveparsons.net
X-MailChannels-Auth-Id: thundermail
X-Trail-Daffy: 39b82e3510a82b1d_1708709104877_2285289143
X-MC-Loop-Signature: 1708709104877:328267790
X-MC-Ingress-Time: 1708709104877
Received: from mailclean11.thundermail.uk (mailclean11.thundermail.uk
 [149.255.60.66]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.123.27.52 (trex/6.9.2); Fri, 23 Feb 2024 17:25:04 +0000
Received: from cloud227.thundercloud.uk (cloud227.thundercloud.uk
 [149.255.62.108])
 by mailclean11.thundermail.uk (Postfix) with ESMTPS id 4B1E2401EF;
 Fri, 23 Feb 2024 17:24:54 +0000 (GMT)
Received: from smtpclient.apple
 (host109-149-93-149.range109-149.btcentralplus.com [109.149.93.149])
 (Authenticated sender: dave@daveparsons.net)
 by cloud227.thundercloud.uk (Postfix) with ESMTPSA id 3960C104091;
 Fri, 23 Feb 2024 17:25:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=daveparsons.net;
 s=default; t=1708709141;
 bh=2bLLvW0pgeAv2h4alZP6r32PqExhDqhhFweFI/Sic9I=; h=From:Subject:To;
 b=WMAP35MoFkGDabuMYhKUQUM/i9t/hCQKxX6kklK1vh7wx9JLP9xe9Ln+cjAdTwDMc
 lzmDtU5UGPyAwyE+CC+IK0pJVWJdGxCiCdgNnqVh9U2D/g0FcA0InXOLfLv08qJC7N
 oK96Ei9iffQ3aRoP6Tp5q5ODJKhmnSrPtiCFTpno=
Authentication-Results: cloud227.thundercloud.uk;
 spf=pass (sender IP is 109.149.93.149) smtp.mailfrom=dave@daveparsons.net
 smtp.helo=smtpclient.apple
Received-SPF: pass (cloud227.thundercloud.uk: connection is authenticated)
From: David Parsons <dave@daveparsons.net>
Message-Id: <E5C37F0E-3B73-45FA-8FC7-5E39CBF765BF@daveparsons.net>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_CEA9760D-D135-477D-B79C-1CA6A4813852"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH] ui/cocoa: Fix incorrect window clipping on macOS Sonoma
Date: Fri, 23 Feb 2024 17:24:43 +0000
In-Reply-To: <c018e266-0092-4d9e-ba2f-397cb0a1518e@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
References: <DDADA9A9-DED4-4510-A532-7600C0233467@daveparsons.net>
 <fdda385d-2e18-4554-88d0-e43cb5b90e39@tls.msk.ru>
 <CAFEAcA9psJuvPz+mWYzWz0NLTcQTCNhknFrGZ2bx7Frtb3=B4A@mail.gmail.com>
 <c018e266-0092-4d9e-ba2f-397cb0a1518e@daynix.com>
X-Mailer: Apple Mail (2.3774.400.31)
X-PPP-Message-ID: <170870914157.2304363.12839080879405550545@cloud227.thundercloud.uk>
X-PPP-Vhost: daveparsons.net
X-Rspamd-Queue-Id: 4B1E2401EF
X-Rspamd-Server: mailclean11
X-Spamd-Result: default: False [-0.01 / 999.00]; ONCE_RECEIVED(0.10)[];
 MIME_GOOD(-0.10)[multipart/alternative,text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DMARC_NA(0.00)[daveparsons.net]; NEURAL_HAM(-0.00)[-0.990];
 RCVD_TLS_ALL(0.00)[];
 ASN(0.00)[asn:34931, ipnet:149.255.60.0/22, country:GB];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+,1:+,2:~];
 RCVD_COUNT_ONE(0.00)[1]; APPLE_MAILER_COMMON(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[8];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_SPF_SOFTFAIL(0.00)[~all];
 R_DKIM_ALLOW(0.00)[daveparsons.net:s=default];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_TRACE(0.00)[daveparsons.net:+]
X-Rspamd-Action: no action
Received-SPF: pass client-ip=23.83.218.249; envelope-from=dave@daveparsons.net;
 helo=poodle.tulip.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--Apple-Mail=_CEA9760D-D135-477D-B79C-1CA6A4813852
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Akihiko

I=E2=80=99ve re-worked the patch to match your suggestion. I have =
compiled
and tested it on Sonoma and Monterey and both builds worked correctly.

New patch is below. I=E2=80=99m new to sending patches to QEMU so please =
let=20
me know if I need to do anything else to get it incorporated into the
repo.

Dave=20

diff --git a/ui/cocoa.m b/ui/cocoa.m
index eb99064bee..bbf9704b8c 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -54,6 +54,10 @@
 #define MAC_OS_X_VERSION_10_13 101300
 #endif
=20
+#ifndef MAC_OS_VERSION_14_0
+#define MAC_OS_VERSION_14_0 140000
+#endif
+
 /* 10.14 deprecates NSOnState and NSOffState in favor of
  * NSControlStateValueOn/Off, which were introduced in 10.13.
  * Define for older versions
@@ -365,6 +369,9 @@ - (id)initWithFrame:(NSRect)frameRect
         screen.width =3D frameRect.size.width;
         screen.height =3D frameRect.size.height;
         kbd =3D qkbd_state_init(dcl.con);
+#if MAC_OS_X_VERSION_MAX_ALLOWED >=3D MAC_OS_VERSION_14_0
+        [self setClipsToBounds:YES];
+#endif
=20
     }
     return self;


> On 23 Feb 2024, at 11:28, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>=20
> On 2024/02/23 2:10, Peter Maydell wrote:
>> On Thu, 22 Feb 2024 at 06:08, Michael Tokarev <mjt@tls.msk.ru> wrote:
>>>=20
>>> [Adding a few more Ccs]
>>>=20
>>> 17.02.2024 18:58, David Parsons :
>>>> macOS Sonoma changes the NSView.clipsToBounds to false by default =
where it was true in
>>>> earlier version of macOS. This causes the window contents to be =
obscured by the window
>>>> frame. This fixes the issue by conditionally setting the clipping =
on Sonoma to true.
>=20
> Thanks for posting a patch for this critical problem.
>=20
>>>>=20
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1994
>>>> Signed-off-by: David Parsons <dave@daveparsons.net>
>>>>=20
>>>> diff --git a/ui/cocoa.m b/ui/cocoa.m
>>>> index eb99064bee..c9e3b96004 100644
>>>> --- a/ui/cocoa.m
>>>> +++ b/ui/cocoa.m
>>>> @@ -365,6 +365,9 @@ - (id)initWithFrame:(NSRect)frameRect
>>>>           screen.width =3D frameRect.size.width;
>>>>           screen.height =3D frameRect.size.height;
>>>>           kbd =3D qkbd_state_init(dcl.con);
>>>> +        if (@available(macOS 14, *)) {
>>>> +            [self setClipsToBounds:YES];
>>>> +        }
>>>>=20
>>>>       }
>>>>       return self;
>>>>=20
>>>=20
>>> Hi David!
>>>=20
>>> While the code change is tiny, I for one know nothing about MacOS =
and
>>> its cocoa thing, so to me (with my trivial-patches hat on) this is a
>>> no-go.  I'd love to have a review from someone more knowlegeable in
>>> this area.
>> Mmm. Akihiko is the expert here, but I do notice that we don't
>> seem to be handling the "macos-version-specific" stuff in a
>> way we've done it before (we don't use @available elsewhere).
>> I did wonder if we could call the setClipsToBounds method =
unconditionally;
>> The release notes say
>> =
https://developer.apple.com/documentation/macos-release-notes/appkit-relea=
se-notes-for-macos-14#NSView
>> "This property is available back to macOS 10.9. This availability is
>> intended to allow code targeting older OSes to set this property to
>> true without guarding the setter in an availability check."
>> but I think that might only mean "you can do this building on a new
>> SDK that's targeting an old version", not "you can do this
>> when building on an older SDK" (at least judging from the
>> comments in the gitlab issue).
>=20
> Apparently it is that case.
>=20
> Please check if MAC_OS_X_VERSION_MAX_ALLOWED >=3D MAC_OS_VERSION_14_0
> instead of using @available. See commit 5e24600a7c1c ("ui/cocoa.m: Fix =
macOS 10.14 deprecation warnings") for example.
>=20
>> The other option would be to fix whatever it is that we're
>> presumably not getting right that means this default change
>> caused the bug. My guess is that we are in the case
>> "Confusing a view=E2=80=99s bounds and its dirty rect. The dirty rect
>>  passed to .drawRect() should be used to determine what to draw,
>>  not where to draw it. Use NSView.bounds when determining the
>>  layout of what your view draws."
>> But unless the fix for that is really obvious and easy I guess
>> that flipping the default back to its old value is the better
>> approach.
>=20
> It is a chore to convert the coordinates using NSView.bounds. Let's =
keep using clipsToBounds.
>=20
>> -- PMM
>=20
>=20


--Apple-Mail=_CEA9760D-D135-477D-B79C-1CA6A4813852
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;"><font =
face=3D"Courier New">Hi Akihiko</font><div><font face=3D"Courier =
New"><br></font></div><div><font face=3D"Courier New">I=E2=80=99ve =
re-worked the patch to match your suggestion. I have =
compiled</font></div><div><font face=3D"Courier New">and tested it on =
Sonoma and Monterey and both builds worked =
correctly.</font></div><div><font face=3D"Courier =
New"><br></font></div><div><font face=3D"Courier New">New patch =
is&nbsp;below. I=E2=80=99m new to sending patches to QEMU so please =
let&nbsp;</font></div><div><font face=3D"Courier New">me know if I need =
to do anything else to get it incorporated into =
the</font></div><div><font face=3D"Courier =
New">repo.</font></div><div><font face=3D"Courier =
New"><br></font></div><div><font face=3D"Courier =
New">Dave&nbsp;</font></div><div><font face=3D"Courier =
New"><br></font></div><div><div><font face=3D"Courier New">diff --git =
a/ui/cocoa.m b/ui/cocoa.m</font></div><div><font face=3D"Courier =
New">index eb99064bee..bbf9704b8c 100644</font></div><div><font =
face=3D"Courier New">--- a/ui/cocoa.m</font></div><div><font =
face=3D"Courier New">+++ b/ui/cocoa.m</font></div><div><font =
face=3D"Courier New">@@ -54,6 +54,10 @@</font></div><div><font =
face=3D"Courier New">&nbsp;#define MAC_OS_X_VERSION_10_13 =
101300</font></div><div><font face=3D"Courier =
New">&nbsp;#endif</font></div><div><font face=3D"Courier =
New">&nbsp;</font></div><div><font face=3D"Courier New">+#ifndef =
MAC_OS_VERSION_14_0</font></div><div><font face=3D"Courier New">+#define =
MAC_OS_VERSION_14_0 140000</font></div><div><font face=3D"Courier =
New">+#endif</font></div><div><font face=3D"Courier =
New">+</font></div><div><font face=3D"Courier New">&nbsp;/* 10.14 =
deprecates NSOnState and NSOffState in favor of</font></div><div><font =
face=3D"Courier New">&nbsp; * NSControlStateValueOn/Off, which were =
introduced in 10.13.</font></div><div><font face=3D"Courier New">&nbsp; =
* Define for older versions</font></div><div><font face=3D"Courier =
New">@@ -365,6 +369,9 @@ - =
(id)initWithFrame:(NSRect)frameRect</font></div><div><font face=3D"Courier=
 New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;screen.width =3D =
frameRect.size.width;</font></div><div><font face=3D"Courier New">&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp;screen.height =3D =
frameRect.size.height;</font></div><div><font face=3D"Courier =
New">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;kbd =3D =
qkbd_state_init(dcl.con);</font></div><div><font face=3D"Courier =
New">+#if MAC_OS_X_VERSION_MAX_ALLOWED &gt;=3D =
MAC_OS_VERSION_14_0</font></div><div><font face=3D"Courier New">+ &nbsp; =
&nbsp; &nbsp; &nbsp;[self setClipsToBounds:YES];</font></div><div><font =
face=3D"Courier New">+#endif</font></div><div><font face=3D"Courier =
New">&nbsp;</font></div><div><font face=3D"Courier New">&nbsp; &nbsp; =
&nbsp;}</font></div><div><font face=3D"Courier New">&nbsp; &nbsp; =
&nbsp;return self;</font></div><div><br></div><div><br><blockquote =
type=3D"cite"><div>On 23 Feb 2024, at 11:28, Akihiko Odaki =
&lt;akihiko.odaki@daynix.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>On 2024/02/23 2:10, Peter =
Maydell wrote:<br><blockquote type=3D"cite">On Thu, 22 Feb 2024 at =
06:08, Michael Tokarev &lt;mjt@tls.msk.ru&gt; wrote:<br><blockquote =
type=3D"cite"><br>[Adding a few more Ccs]<br><br>17.02.2024 18:58, David =
Parsons :<br><blockquote type=3D"cite">macOS Sonoma changes the =
NSView.clipsToBounds to false by default where it was true in<br>earlier =
version of macOS. This causes the window contents to be obscured by the =
window<br>frame. This fixes the issue by conditionally setting the =
clipping on Sonoma to =
true.<br></blockquote></blockquote></blockquote><br>Thanks for posting a =
patch for this critical problem.<br><br><blockquote =
type=3D"cite"><blockquote type=3D"cite"><blockquote =
type=3D"cite"><br>Resolves: =
https://gitlab.com/qemu-project/qemu/-/issues/1994<br>Signed-off-by: =
David Parsons &lt;dave@daveparsons.net&gt;<br><br>diff --git =
a/ui/cocoa.m b/ui/cocoa.m<br>index eb99064bee..c9e3b96004 100644<br>--- =
a/ui/cocoa.m<br>+++ b/ui/cocoa.m<br>@@ -365,6 +365,9 @@ - =
(id)initWithFrame:(NSRect)frameRect<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;screen.width =
=3D frameRect.size.width;<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;screen.height =
=3D frameRect.size.height;<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kbd =3D =
qkbd_state_init(dcl.con);<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (@available(macOS 14, *)) =
{<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[self =
setClipsToBounds:YES];<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
self;<br><br></blockquote><br>Hi David!<br><br>While the code change is =
tiny, I for one know nothing about MacOS and<br>its cocoa thing, so to =
me (with my trivial-patches hat on) this is a<br>no-go. &nbsp;I'd love =
to have a review from someone more knowlegeable in<br>this =
area.<br></blockquote>Mmm. Akihiko is the expert here, but I do notice =
that we don't<br>seem to be handling the "macos-version-specific" stuff =
in a<br>way we've done it before (we don't use @available =
elsewhere).<br>I did wonder if we could call the setClipsToBounds method =
unconditionally;<br>The release notes =
say<br>https://developer.apple.com/documentation/macos-release-notes/appki=
t-release-notes-for-macos-14#NSView<br>"This property is available back =
to macOS 10.9. This availability is<br>intended to allow code targeting =
older OSes to set this property to<br>true without guarding the setter =
in an availability check."<br>but I think that might only mean "you can =
do this building on a new<br>SDK that's targeting an old version", not =
"you can do this<br>when building on an older SDK" (at least judging =
from the<br>comments in the gitlab =
issue).<br></blockquote><br>Apparently it is that case.<br><br>Please =
check if MAC_OS_X_VERSION_MAX_ALLOWED &gt;=3D =
MAC_OS_VERSION_14_0<br>instead of using @available. See commit =
5e24600a7c1c ("ui/cocoa.m: Fix macOS 10.14 deprecation warnings") for =
example.<br><br><blockquote type=3D"cite">The other option would be to =
fix whatever it is that we're<br>presumably not getting right that means =
this default change<br>caused the bug. My guess is that we are in the =
case<br>"Confusing a view=E2=80=99s bounds and its dirty rect. The dirty =
rect<br> &nbsp;passed to .drawRect() should be used to determine what to =
draw,<br> &nbsp;not where to draw it. Use NSView.bounds when determining =
the<br> &nbsp;layout of what your view draws."<br>But unless the fix for =
that is really obvious and easy I guess<br>that flipping the default =
back to its old value is the better<br>approach.<br></blockquote><br>It =
is a chore to convert the coordinates using NSView.bounds. Let's keep =
using clipsToBounds.<br><br><blockquote type=3D"cite">-- =
PMM<br></blockquote><br><br></div></div></blockquote></div><br></div></bod=
y></html>=

--Apple-Mail=_CEA9760D-D135-477D-B79C-1CA6A4813852--

