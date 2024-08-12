Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794B0C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 18:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdZVT-0006Xe-Ca; Mon, 12 Aug 2024 14:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sdZVQ-0006X2-G9
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 14:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sdZVM-0003sb-5c
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 14:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723486249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7L29HM1lytZTK/ZwHlPJmWVbR66sc7E1ZRSCyb0T608=;
 b=JdjPnp9YSoRG5yM2mbVmY9Ii9n7JYqZV5sgnxpy/HjAXfnp9tReDVuP8SzKmVTFbcdI4zQ
 XoqShsFcnXB0H4XAEyeQYZker142pg9QN7gI4FvVFZeflHV26oFOA2ttGmRCkLb5ALWpA3
 +nlqLM5y1nqipxJemZzMjcALDwu9yoM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-8HFZ0nWXOLq99Gtn66MTXw-1; Mon, 12 Aug 2024 14:10:45 -0400
X-MC-Unique: 8HFZ0nWXOLq99Gtn66MTXw-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-200aa7dbc3bso28557905ad.3
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 11:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723486244; x=1724091044;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7L29HM1lytZTK/ZwHlPJmWVbR66sc7E1ZRSCyb0T608=;
 b=xKDk8zo/9H96zso/fFQ74Y7RIH+PBl0Q0midSuTiYADUN81PxqEiJs0Oj1FKSnr+VN
 Ke1DDnQBvCF6MHPjps7SMQV4s1t9AZukSMessmesJkPTWlGbqgd0rWl4LDvOz/GrXYhc
 YVvG/AqnUKLaC6MBOWfdWHtHvIMJrFSWwjVt2q/795IRUgtqzKkLPSqgTAyDDmK3vLRY
 ygPq23cQu+ZqqljArUxBV/9RcqX383xaiVVSL5/xxzb49js2HxqpGdXVSizhD+j40FVT
 Jo5eS1wQOZ1LRz2Z42av/+O1toGMBXpQO/X15LgZiVN28Xe0PNDi8bJJoMXnXwOUlUKK
 DDHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3Y107t+UBkAoWJpFICekdEWuVDQhqGFS2t6yF0dTC5Yp+Go/AZbNlz2uEd3O7eycKml0+Ubdu26qF@nongnu.org
X-Gm-Message-State: AOJu0Yz0xj5HLcCA+XKLnEmRIfi2HhyLKbCmKc91JaDEgn0XlnTKFcZY
 hgJ8X/JVYiqUkmZGMms/m6BXOMhWugiBNnB04Y+w/RPlCDfr9wpGyPmkiOE7qMbnGURbbxm1Wyx
 gyZWGSBIVUAAjtfi0RlfiveSqyh0w3Y304XNQJDhsSPF/ACW9FtaepfueHnaFdBnyorgAWgxcr1
 L9JRGnB/EI3Nlr1lYWFgDnjuujufo=
X-Received: by 2002:a17:902:ce83:b0:1fd:5ed7:19e4 with SMTP id
 d9443c01a7336-201ca1eafcamr13166315ad.60.1723486243827; 
 Mon, 12 Aug 2024 11:10:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeir2hMW0eeSBsERSw9z48k0jZjOHCPTpt5N1rcrBZmtxj/aVpwFXdd7+POsNLBYl/OM7M5Y9J67YDWnY/UxA=
X-Received: by 2002:a17:902:ce83:b0:1fd:5ed7:19e4 with SMTP id
 d9443c01a7336-201ca1eafcamr13166095ad.60.1723486243522; Mon, 12 Aug 2024
 11:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240808182636.3657537-1-armbru@redhat.com>
 <20240808182636.3657537-2-armbru@redhat.com>
 <ec33abcb-409f-4609-9007-3337f3f647ab@linaro.org>
 <875xsakqlc.fsf@pond.sub.org>
In-Reply-To: <875xsakqlc.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 12 Aug 2024 14:10:31 -0400
Message-ID: <CAFn=p-YORrVZNjJxGSW7M4rF4cbfMwQSB7edsJ5W757hZu=d4A@mail.gmail.com>
Subject: Re: [PATCH 1/6] qapi/char: Supply missing member documentation
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, eblake@redhat.com, marcandre.lureau@redhat.com, 
 pbonzini@redhat.com, berrange@redhat.com, mst@redhat.com, 
 marcel.apfelbaum@gmail.com, jiri@resnulli.us
Content-Type: multipart/alternative; boundary="000000000000522c1b061f8069c2"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000522c1b061f8069c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 5:12=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>
> > Hi Markus,
> >
> > On 8/8/24 20:26, Markus Armbruster wrote:
> >> Since we neglect to document several members of ChardevBackendKind,
> >> their description in the QEMU QMP Reference manual is "Not
> >> documented".  Fix that, and improve the existing member documentation.
> >>
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>   qapi/char.json   | 44 ++++++++++++++++++++++++++++----------------
> >>   qapi/pragma.json |  1 -
> >>   2 files changed, 28 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/qapi/char.json b/qapi/char.json
> >> index ef58445cee..8a4a87c95c 100644
> >> --- a/qapi/char.json
> >> +++ b/qapi/char.json
> >> @@ -434,37 +434,49 @@
> >>  ##
> >>  # @ChardevBackendKind:
> >>  #
> >> -# @pipe: Since 1.5
> >> +# @file: regular files
> >>  #
> >> -# @udp: Since 1.5
> >> +# @serial: serial host device
> >>  #
> >> -# @mux: Since 1.5
> >> +# @parallel: parallel host device
> >>  #
> >> -# @msmouse: Since 1.5
> >> +# @pipe: pipes (since 1.5)
> >>  #
> >> -# @wctablet: Since 2.9
> >> +# @socket: stream socket
> >>  #
> >> -# @braille: Since 1.5
> >> +# @udp: datagram socket (since 1.5)
> >>  #
> >> -# @testdev: Since 2.2
> >> +# @pty: pseudo-terminal
> >>  #
> >> -# @stdio: Since 1.5
> >> +# @null: provides no input, throws away output
> >>  #
> >> -# @console: Since 1.5
> >> +# @mux: (since 1.5)
> >>  #
> >> -# @spicevmc: Since 1.5
> >> +# @msmouse: emulated Microsoft serial mouse (since 1.5)
> >>  #
> >> -# @spiceport: Since 1.5
> >> +# @wctablet: emulated Wacom Penpartner serial tablet (since 2.9)
> >>  #
> >> -# @qemu-vdagent: Since 6.1
> >> +# @braille: Baum Braille device (since 1.5)
> >>  #
> >> -# @dbus: Since 7.0
> >> +# @testdev: device for test-suite control (since 2.2)
> >>  #
> >> -# @vc: v1.5
> >> +# @stdio: standard I/O (since 1.5)
> >>  #
> >> -# @ringbuf: Since 1.6
> >> +# @console: Windows console (since 1.5)
> >>  #
> >> -# @memory: Since 1.5
> >> +# @spicevmc: spice vm channel (since 1.5)
> >> +#
> >> +# @spiceport: Spice port channel (since 1.5)
> >> +#
> >> +# @qemu-vdagent: Spice vdagent (since 6.1)
> >> +#
> >> +# @dbus: D-Bus channel (since 7.0)
> >> +#
> >> +# @vc: virtual console (since v1.5)
> >> +#
> >> +# @ringbuf: memory ring buffer (since 1.6)
> >> +#
> >> +# @memory: synonym for @ringbuf (since 1.5)
> >
> > What is the rule to sort the members?
>
> I like to keep the member descriptions in the same order as their
> definitions in 'data'.
>
> As to the order in 'data': sometimes there's a "natural" order or
> grouping, and sometimes alphabetical is best.  However, we too often add
> members without giving order a thought, commonly at the end.
>
> Hope this helps!
>

What Markus says is correct. Some additional clarification:

The order is not part of the API (for QAPI/QMP), so there's no rule.
Matching the doc and definition orders is often the "nicest" but it is not
enforced.

The definition orders usually tend to "grow downwards" like a struct, but
that's only a tendency and not a rule.

Future developments may or may not impose an order; it's often contested.
At times, Marc-Andre and I have desired to establish a canon order for the
purposes of third party APIs, but QAPI as it stands is militant about order
being unimportant and there are no immediate plans to change that, only
rumblings and desires that stand at odds with Markus's desire to keep order
be unimportant.

(Which, to be clear, is not me belly-aching about Markus's excellent
maintainership of QAPI; just pointing out that there is some tension on
that requirement that remains more or less unsettled.)

--js

--000000000000522c1b061f8069c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 9, 2024 at 5:12=E2=80=AFA=
M Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org" tar=
get=3D"_blank">philmd@linaro.org</a>&gt; writes:<br>
<br>
&gt; Hi Markus,<br>
&gt;<br>
&gt; On 8/8/24 20:26, Markus Armbruster wrote:<br>
&gt;&gt; Since we neglect to document several members of ChardevBackendKind=
,<br>
&gt;&gt; their description in the QEMU QMP Reference manual is &quot;Not<br=
>
&gt;&gt; documented&quot;.=C2=A0 Fix that, and improve the existing member =
documentation.<br>
&gt;&gt; <br>
&gt;&gt; Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com" target=3D"_blank">armbru@redhat.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0qapi/char.json=C2=A0 =C2=A0| 44 ++++++++++++++++++++++=
++++++----------------<br>
&gt;&gt;=C2=A0 =C2=A0qapi/pragma.json |=C2=A0 1 -<br>
&gt;&gt;=C2=A0 =C2=A02 files changed, 28 insertions(+), 17 deletions(-)<br>
&gt;&gt; <br>
&gt;&gt; diff --git a/qapi/char.json b/qapi/char.json<br>
&gt;&gt; index ef58445cee..8a4a87c95c 100644<br>
&gt;&gt; --- a/qapi/char.json<br>
&gt;&gt; +++ b/qapi/char.json<br>
&gt;&gt; @@ -434,37 +434,49 @@<br>
&gt;&gt;=C2=A0 ##<br>
&gt;&gt;=C2=A0 # @ChardevBackendKind:<br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -# @pipe: Since 1.5<br>
&gt;&gt; +# @file: regular files<br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -# @udp: Since 1.5<br>
&gt;&gt; +# @serial: serial host device<br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -# @mux: Since 1.5<br>
&gt;&gt; +# @parallel: parallel host device<br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -# @msmouse: Since 1.5<br>
&gt;&gt; +# @pipe: pipes (since 1.5)<br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -# @wctablet: Since 2.9<br>
&gt;&gt; +# @socket: stream socket<br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -# @braille: Since 1.5<br>
&gt;&gt; +# @udp: datagram socket (since 1.5)<br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -# @testdev: Since 2.2<br>
&gt;&gt; +# @pty: pseudo-terminal<br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -# @stdio: Since 1.5<br>
&gt;&gt; +# @null: provides no input, throws away output<br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -# @console: Since 1.5<br>
&gt;&gt; +# @mux: (since 1.5)<br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -# @spicevmc: Since 1.5<br>
&gt;&gt; +# @msmouse: emulated Microsoft serial mouse (since 1.5)<br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -# @spiceport: Since 1.5<br>
&gt;&gt; +# @wctablet: emulated Wacom Penpartner serial tablet (since 2.9)<=
br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -# @qemu-vdagent: Since 6.1<br>
&gt;&gt; +# @braille: Baum Braille device (since 1.5)<br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -# @dbus: Since 7.0<br>
&gt;&gt; +# @testdev: device for test-suite control (since 2.2)<br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -# @vc: v1.5<br>
&gt;&gt; +# @stdio: standard I/O (since 1.5)<br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -# @ringbuf: Since 1.6<br>
&gt;&gt; +# @console: Windows console (since 1.5)<br>
&gt;&gt;=C2=A0 #<br>
&gt;&gt; -# @memory: Since 1.5<br>
&gt;&gt; +# @spicevmc: spice vm channel (since 1.5)<br>
&gt;&gt; +#<br>
&gt;&gt; +# @spiceport: Spice port channel (since 1.5)<br>
&gt;&gt; +#<br>
&gt;&gt; +# @qemu-vdagent: Spice vdagent (since 6.1)<br>
&gt;&gt; +#<br>
&gt;&gt; +# @dbus: D-Bus channel (since 7.0)<br>
&gt;&gt; +#<br>
&gt;&gt; +# @vc: virtual console (since v1.5)<br>
&gt;&gt; +#<br>
&gt;&gt; +# @ringbuf: memory ring buffer (since 1.6)<br>
&gt;&gt; +#<br>
&gt;&gt; +# @memory: synonym for @ringbuf (since 1.5)<br>
&gt;<br>
&gt; What is the rule to sort the members?<br>
<br>
I like to keep the member descriptions in the same order as their<br>
definitions in &#39;data&#39;.<br>
<br>
As to the order in &#39;data&#39;: sometimes there&#39;s a &quot;natural&qu=
ot; order or<br>
grouping, and sometimes alphabetical is best.=C2=A0 However, we too often a=
dd<br>
members without giving order a thought, commonly at the end.<br>
<br>
Hope this helps!<br></blockquote><div><br></div><div>What Markus says is co=
rrect. Some additional clarification:</div><div><br></div><div>The order is=
 not part of the API (for QAPI/QMP), so there&#39;s no rule. Matching the d=
oc and definition orders is often the &quot;nicest&quot; but it is not enfo=
rced.<br></div><div><br></div><div>The definition orders usually tend to &q=
uot;grow downwards&quot; like a struct, but that&#39;s only a tendency and =
not a rule.</div><div><br></div><div>Future developments may or may not imp=
ose an order; it&#39;s often contested. At times, Marc-Andre and I have des=
ired to establish a canon order for the purposes of third party APIs, but Q=
API as it stands is militant about order being unimportant and there are no=
 immediate plans to change that, only rumblings and desires that stand at o=
dds with Markus&#39;s desire to keep order be unimportant.</div><div><br></=
div><div>(Which, to be clear, is not me belly-aching about Markus&#39;s exc=
ellent maintainership of QAPI; just pointing out that there is some tension=
 on that requirement that remains more or less unsettled.)<br></div><div><b=
r></div><div>--js<br></div></div></div>

--000000000000522c1b061f8069c2--


