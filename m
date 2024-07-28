Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2910DC3DA64
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2024 22:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYCcJ-0001qQ-EX; Sun, 28 Jul 2024 18:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qeed.quan@gmail.com>)
 id 1sYCcH-0001pP-Ij
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 18:43:49 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <qeed.quan@gmail.com>)
 id 1sYCcF-0004D9-OU
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 18:43:49 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3685a564bafso1005830f8f.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2024 15:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722206626; x=1722811426; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YA7axCoJ5xqzlbMRn9q6AzUrj0g7EumCwEzIWypuaD0=;
 b=AIyvNQqA6JcmVQu15j5zHyatm41Koa/4qCO3cl0Tr+7Yx5tA9TU1eFJ3a1ez0OaPyE
 OqE6mJEg4MT6oAnsPPqWzYHaIY0K4D6FImGeirzI6VWnIlBcj1ppbvx21ZOlJtRBA5Br
 2iG3/zAuZKblYQWxHJW/wGOtlBb8KquTkPkErbKWzwk3annnCK9giuL8Y08CIikTrgrq
 nSGxICyufLyrFgrJQzEWjXxFxxTOwgpmZqC+UVFSgLTYD06xdnyVJwSuaWsKRIwXB9Ax
 TnCoOJOZPxRFTWvWQJ57iCO5LDrh5XjG1yUuusbPKHWAL0YQjhaxsZ+140AqjBJUuXDe
 TLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722206626; x=1722811426;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YA7axCoJ5xqzlbMRn9q6AzUrj0g7EumCwEzIWypuaD0=;
 b=O0lxfS9xRKfc73e4ZYTHdV3ssP+jlstsAETa5zOdfV0wO+dKIci0A+34ABU4GvwJ4/
 V89qdeMSA52VmxI8bmbvRLgh5J7AaJ0hC/zA1c5hj2KxgtPx3+nlk5y1Q2+gyIVk0CXN
 6u2HWV6vKKx5VY8sWCZF/jIPSTuNrDHBrKWbkzigirH/ZWRDDIz8hkIwzoOjrcnWsp67
 lsU463IuxFFthqPP1oCT1wfvYWv/7z4faqkSfCbPh79w6KyA/FEFaKBkwMJ4DCbRialF
 llLim11mQsfrYU8Sygu8yA12DIH/IMni7m57a5rquTlwj5o2clwnQpe/+TN6qISHuH2I
 druA==
X-Gm-Message-State: AOJu0YwOVHMK+OuizI+R8zSfwlMpNl4gZ+xT673e/AZPPZ/CPkjX820q
 ygVWQHNA4XrdSdXUpmctnlmPaCOdelwjt2UWk+ogu9DXX1lTMkkgfQq2RXm6CT/vR954XutalEp
 JPXOtswGY1iQQSxZqpuoPOVcpwcI=
X-Google-Smtp-Source: AGHT+IET0FrPm6BQ8anX6fwByFm08TC+n+2eY2AC32V9USF/7qENkU7UtxsryHb8iyA+OappRk1gVwaliVOzhv1gxTg=
X-Received: by 2002:adf:e6c5:0:b0:366:ef03:a8a2 with SMTP id
 ffacd0b85a97d-36b5d09d3famr3995094f8f.54.1722206626002; Sun, 28 Jul 2024
 15:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <CACUh7aGriKAtKtUW5c1X2ipy4RX0Mt_gwwfdQRC94EZNvE89jg@mail.gmail.com>
 <e8832eee-01fe-4cef-d6c4-31fb63677d5c@eik.bme.hu>
 <CACUh7aGb7pQUAyWSj8UuWaYJVA8ZYs1HAM0kUsQ736K-mLLHeQ@mail.gmail.com>
 <33da6a39-396e-7734-5f4c-7190855ddaae@eik.bme.hu>
In-Reply-To: <33da6a39-396e-7734-5f4c-7190855ddaae@eik.bme.hu>
From: quan <qeed.quan@gmail.com>
Date: Sun, 28 Jul 2024 17:43:35 -0500
Message-ID: <CACUh7aEEf5oP5LJjRJSc-A4x9W6E7pfM-WOnKre=pqDx0nTFcQ@mail.gmail.com>
Subject: Re: Using parallel port on the Pegasos 2
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 philmd@linaro.org
Content-Type: multipart/alternative; boundary="0000000000002c3f42061e567ac2"
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=qeed.quan@gmail.com; helo=mail-wr1-x432.google.com
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

--0000000000002c3f42061e567ac2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah I did not know about the relocation. Using 0x378 as the address works in
8.2.0. I do get the parallel_ioport_write messages now
parallel_ioport_write write [SW] addr 0x00 val 0x00

Quan


On Sun, Jul 28, 2024 at 5:33=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:

> On Sun, 28 Jul 2024, quan wrote:
> > I have tried this on qemu 8.2.0 (I downloaded it and compiled with
> > --enable-debug), this build does not seem to hit the breakpoint
> > portio_write function when writing to 0x3bc while it does on the latest
> > qemu git version.
> >
> > Using the  trace:memory_region_ops_write option for 8.2.0, the other
> > devices like serial and rtc does get hit, but it never prints a write f=
or
> > 'parallel', as if its disabled somehow.
>
> Before implementing relocation of these devices they were at default port
> numbers in QEMU v8.2.0 so parallel was at 0x378. Did you try with that
> address? You can use 'info mtree' command in QEMU monitor to check which
> regions are enabled and where they are.
>
> Regards,
> BALATON Zoltan
>
> > Quan
> >
> > On Sun, Jul 28, 2024 at 2:17=E2=80=AFPM BALATON Zoltan <balaton@eik.bme=
.hu>
> wrote:
> >
> >> On Sun, 28 Jul 2024, quan wrote:
> >>> I am playing around with the parallel port on the pegasos 2 and I
> noticed
> >>> the following issue:
> >>> The parallel port on startup is set to iobase 0x378, then later it ge=
ts
> >>> remapped to iobase 0x3bc.
> >>> When I tried writing to the 0x3bc location with
> >>> trace:memory_region_ops_write on, I get logs about writing to the
> >> location
> >>> 'parallel', so far so good, but the writes don't make it through (it
> >> never
> >>> calls parallel_ioport_write* functions)
> >>>
> >>> I traced it through where it calls portio_write, and inside the
> >>> portio_write code:
> >>> This line always fails for me:
> >>> const MemoryRegionPortio *mrp =3D find_portio(mrpio, addr, size, true=
);
> >>> This is due to the mrpio has the offset of 0x44 (0x3bc-0x378) in the
> >> list,
> >>> and the 'addr' in the code ranges from (0-15) (address relative to
> >> 0x3bc),
> >>> so it can never match the parallel io function to execute.
> >>>
> >>> This seems like a bug to me. I think there is some issue where the
> >>> portio_list is not getting updated properly after the remapping to
> 0x3bc.
> >>>
> >>> The other devices (Serial, RTC, PM, VGA) responds properly for me, so
> it
> >> is
> >>> only the parallel port that has this issue.
> >>
> >> Is this something that broke recently or can the same be reproduced wi=
th
> >> QEMU v8.2.0. The relocation of these devices was implemented around
> commit
> >> 35a6380b4ed27f (and the ones before that). Adding Bernhard to cc as
> well.
> >>
> >> Regards,
> >> BALATON Zoltan
> >>
> >

--0000000000002c3f42061e567ac2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ah I did not know about the relocation. Using 0x378 as the=
 address works in 8.2.0. I do get the parallel_ioport_write messages now<di=
v>parallel_ioport_write write [SW] addr 0x00 val 0x00</div><div><br></div><=
div>Quan</div><div><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sun, Jul 28, 2024 at 5:33=E2=80=AFPM BALAT=
ON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Su=
n, 28 Jul 2024, quan wrote:<br>
&gt; I have tried this on qemu 8.2.0 (I downloaded it and compiled with<br>
&gt; --enable-debug), this build does not seem to hit the breakpoint<br>
&gt; portio_write function when writing to 0x3bc while it does on the lates=
t<br>
&gt; qemu git version.<br>
&gt;<br>
&gt; Using the=C2=A0 trace:memory_region_ops_write option for 8.2.0, the ot=
her<br>
&gt; devices like serial and rtc does get hit, but it never prints a write =
for<br>
&gt; &#39;parallel&#39;, as if its disabled somehow.<br>
<br>
Before implementing relocation of these devices they were at default port <=
br>
numbers in QEMU v8.2.0 so parallel was at 0x378. Did you try with that <br>
address? You can use &#39;info mtree&#39; command in QEMU monitor to check =
which <br>
regions are enabled and where they are.<br>
<br>
Regards,<br>
BALATON Zoltan<br>
<br>
&gt; Quan<br>
&gt;<br>
&gt; On Sun, Jul 28, 2024 at 2:17=E2=80=AFPM BALATON Zoltan &lt;<a href=3D"=
mailto:balaton@eik.bme.hu" target=3D"_blank">balaton@eik.bme.hu</a>&gt; wro=
te:<br>
&gt;<br>
&gt;&gt; On Sun, 28 Jul 2024, quan wrote:<br>
&gt;&gt;&gt; I am playing around with the parallel port on the pegasos 2 an=
d I noticed<br>
&gt;&gt;&gt; the following issue:<br>
&gt;&gt;&gt; The parallel port on startup is set to iobase 0x378, then late=
r it gets<br>
&gt;&gt;&gt; remapped to iobase 0x3bc.<br>
&gt;&gt;&gt; When I tried writing to the 0x3bc location with<br>
&gt;&gt;&gt; trace:memory_region_ops_write on, I get logs about writing to =
the<br>
&gt;&gt; location<br>
&gt;&gt;&gt; &#39;parallel&#39;, so far so good, but the writes don&#39;t m=
ake it through (it<br>
&gt;&gt; never<br>
&gt;&gt;&gt; calls parallel_ioport_write* functions)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I traced it through where it calls portio_write, and inside th=
e<br>
&gt;&gt;&gt; portio_write code:<br>
&gt;&gt;&gt; This line always fails for me:<br>
&gt;&gt;&gt; const MemoryRegionPortio *mrp =3D find_portio(mrpio, addr, siz=
e, true);<br>
&gt;&gt;&gt; This is due to the mrpio has the offset of 0x44 (0x3bc-0x378) =
in the<br>
&gt;&gt; list,<br>
&gt;&gt;&gt; and the &#39;addr&#39; in the code ranges from (0-15) (address=
 relative to<br>
&gt;&gt; 0x3bc),<br>
&gt;&gt;&gt; so it can never match the parallel io function to execute.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This seems like a bug to me. I think there is some issue where=
 the<br>
&gt;&gt;&gt; portio_list is not getting updated properly after the remappin=
g to 0x3bc.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The other devices (Serial, RTC, PM, VGA) responds properly for=
 me, so it<br>
&gt;&gt; is<br>
&gt;&gt;&gt; only the parallel port that has this issue.<br>
&gt;&gt;<br>
&gt;&gt; Is this something that broke recently or can the same be reproduce=
d with<br>
&gt;&gt; QEMU v8.2.0. The relocation of these devices was implemented aroun=
d commit<br>
&gt;&gt; 35a6380b4ed27f (and the ones before that). Adding Bernhard to cc a=
s well.<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; BALATON Zoltan<br>
&gt;&gt;<br>
&gt;</blockquote></div>

--0000000000002c3f42061e567ac2--

