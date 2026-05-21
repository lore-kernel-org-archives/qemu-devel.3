Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F05CD5BAB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 20:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQADe-0002j7-Ty; Thu, 21 May 2026 16:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gumenezes2019@gmail.com>)
 id 1wQADd-0002ik-JT
 for qemu-devel@nongnu.org; Thu, 21 May 2026 16:42:13 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gumenezes2019@gmail.com>)
 id 1wQADb-0008KM-2Z
 for qemu-devel@nongnu.org; Thu, 21 May 2026 16:42:13 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-7c5d8f45465so63938517b3.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 13:42:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779396129; cv=none;
 d=google.com; s=arc-20240605;
 b=S83ddfNbKoF8XgGNjM6ig/Hq8VeefS9pFWUeaqEQ1sN1Wa/2N/IOWYJ5OpjoWIOyxb
 3f2XHNwgxQkpXRvgxcGgrldXWQCiC4jXbnvZaqjKLAMtKCcdZkjDFoicN+o6ZrGKqt76
 6cXv6Ytuz2jZh8XozR7ub4xEJgXJCLhNOPJFifs65rCNFJyvHZIyEA/sSXOV/87DOjvH
 ww/X8CaUNYaNGftuUcExmhbnskfhOOI5linnx3C61K5WRaASJaFdJnJAXodnTE+xB2gs
 p5tNbz5Xry3wqByfMd+R6fYNgLFbraJpsNFkmCaUOkfIAOX7j2RQq1nsH1bUVfivjAft
 G8Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QyjkVTKzGJB2GNNwgNxOx9r7himWWzlX77n2CY0LrBE=;
 fh=axbB2bjiSokmisYx3H7DI5yUO3Z+Sykod4F4JR7lPwk=;
 b=b0JzUtLQHJgJtRtQZJHyLMM6DznWfFLg55I7iebq++wfQHxO/MFutRdyMO/E131co6
 qJHy+aMNKVvwAix3lYjqIktXi0sHWB6PUmqZyNlgYXFpdgoVVbiWfI7fyzzXJw0bh8sX
 Wif5/MyR0FrQHG69u18jZghJw1y+n1h7E4QRfEf+Ljs367GyWLM2ADzGfFO0FsJL8VSb
 engOdKqIDTw0Of2kl0Dbt/u9+uhlKNT9EzzrIqBM1iA86u3wEfB6iQsy0Lq9PiSSKeZc
 y0UFYLpxbph6baz7MqD/lHrSAEvlDGhpck2ktHO6+OswfHjUoRKarLXGrHGsruaZSJt+
 U2xA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779396129; x=1780000929; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QyjkVTKzGJB2GNNwgNxOx9r7himWWzlX77n2CY0LrBE=;
 b=nDRWGLBPPsMvq8TXzctJNVwRJu28eOO8QoGila25vnb/Cjcy2vspBXgDv9ovCf0tuJ
 vzy11A55aVnH1L2GGjZLM36J2D9BKDO6xxfDv78QA5nP4b82vhg3ES6WHIbiZY5Nd99l
 Aln8j/CiQBpudj8zNCPonUBJQTqgUxujRJhPXiJleliopHkrUPRa51f/whfToEK/t0sZ
 VIYEN/AlRfr20/6hiAApV+wM1vGej7bSt7yO0svQU1edYljtMNp0kk5B6H4hqiXNBa5c
 kM8KFMNmAm51xcPX9wHXJc4rGJeUWq1/IOS+6QWqa+V6fM27Re6vi800eZXAwVEtUMGS
 QUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779396129; x=1780000929;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QyjkVTKzGJB2GNNwgNxOx9r7himWWzlX77n2CY0LrBE=;
 b=H7GTgVRUbMRdS714KvrtndsdMiXgot2YmCrvHR/4EXiQ6Roa+ZBu/wTlUJ+ulecHWX
 ZHtTOLVeApVNGUvT+1Drca1mnMTJWE87YJk9Q62jg2TZZqzSNt3IIBK57oz+5GHc3Gaz
 ChpHli5V/pZitIaNgktfkIq1i4cty76cNv4dT3UTRzcii+fRG0Kq7VK8dJerh+clgTFp
 tq/5cQY6EhtqO64vLMaKJk15V0grDLXSnWe6hNeZ94XntW6hMjkHbYVnUcw4D9cSHAnw
 HHuR1U708R2VD/WckmdVViY584NlW1YoI2TJo/IDDOPLcbmT0mibBDt288gR/AzRv3cw
 3+Vg==
X-Gm-Message-State: AOJu0Yy0TT6SH5Gu/8KgSJhoowuHeVXI9kHpehSmA6EPCguSV8yaXGv/
 KjHOg2lUJJitf/g+iG05qXQBzXZ5/LLLO9AM60R1OAhs1fo9K2UdCLVYDRzE66YP9NT4hNcO6Nz
 j7odBm5z1AyOT4XZSIDIyFgvgElmeRyJk3Td/
X-Gm-Gg: Acq92OHuBQaXgTxGI70embIee+vjzxcT98gOUOEPr/n6cL44YOW1HNl9QcMHLh/lvBD
 gpFcI4vvPwWpxgQyR4KCAf5V4u5I3k5Yv6fixE6Q4ECpj1AmfMPrqTv8OKV7+GNjRBdDhta5nM2
 sSDqm4Z33ml3v2T2W4tLLTdaq2qzw/kaIwLLwPnRvHyOHM307cZ2ouLHF7Y8KiWOKTTxWNNXF7M
 m/ALT3BIukUVX3rqLsqgssk5dubv3JqR+fKUJv5jt8u3LIz/XDDNxS7UK5m7mwwZXT0ivDjvyaH
 MATU+GdCuSGkKvmUzxzzSyEVpUM56vATKLuNRy3/UgcMoZ42Nf+czBvICDPXm3DaTMPDoaA=
X-Received: by 2002:a05:690c:650d:b0:7b2:dad2:5dfc with SMTP id
 00721157ae682-7d3337e7ef9mr13095337b3.6.1779396128819; Thu, 21 May 2026
 13:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <CA+YAEjo9BdN6RuRbg=bfVqke4kf24my21Jk3P4aJDzR8A5yqyw@mail.gmail.com>
 <87h5o0mrr2.fsf@draig.linaro.org>
In-Reply-To: <87h5o0mrr2.fsf@draig.linaro.org>
From: gustavo menezes <gumenezes2019@gmail.com>
Date: Thu, 21 May 2026 17:41:57 -0300
X-Gm-Features: AVHnY4KX5lZEYZ_xfYmDEqFE194dU3ZBTypVRyoAFY9uXeedHDhynRyOJWGhF5I
Message-ID: <CA+YAEjqkqLxL-+JzScdv35xn57eXF7XVXGrCXUs7=CkZ75t2zw@mail.gmail.com>
Subject: Re: [RFC] Add initial Qualcomm MSM7201A platform emulation
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002c4cf3065259f2fc"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=gumenezes2019@gmail.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000002c4cf3065259f2fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alex Benn=C3=A9e writes:

> gustavo menezes <gumenezes2019@gmail.com> writes:
>
> > Hello,
> >
> > I am interested in developing initial support for the Qualcomm MSM7201A
> > SoC family in QEMU.
> >
> > The goal is to emulate early Qualcomm MSM7K-based smartphones such as
> > the HTC Dream / T-Mobile G1 and related Windows Mobile devices.
>
> That sounds like quite a lot of work for one person. Have you done much
> device modelling or reverse engineering before?
>
> >
> > Initial targets would include:
> > - ARM1136 core support integration
>
> We already have at least one board that uses this so that is done.
>
> > - UART
> > - Interrupt controller
> > - Timers
>
> Are these all Arm IP blocks or something QC specific?
>
> > - NAND flash controller
> > - Minimal Linux/Android boot capability
>
> While Android can boot on QEMU (specifically the Cuttlefish Android
> target) you may need to model/stub a lot of devices to get through the
> boot of an unmodified image.
>
> > Longer term goals may include:
> > - LCD/framebuffer support
> > - Audio
> > - Modem/DSP stubs
> > - Power management
> > - Windows Mobile compatibility
> >
> > Potential use cases:
> > - Preservation of early smartphone platforms
> > - Android historical research
> > - Embedded Linux development
> > - Reverse engineering research
>
> For reverse engineering you should ensure any devices you model work
> appropriately with record/replay.
>
> >
> > I would appreciate feedback regarding:
> > - Existing related efforts
>
> There are a number of downstream forks of QEMU that model various things
> including at least one that claims to emulate a full iPhone so such
> things are possible. However most of the upstream models are either
> aimed at virtualisation, model various developer/reference boards and a
> large number of system controller boards.
>
> > - Preferred machine model structure
>
> I'll leave that for others - however the general advice is to be wary of
> copying and pasting for older models which often use old/legacy APIs and
> haven't bee converted.
>
> > - Maintainership expectations
>
> No one is expecting full security support for random board models (see
> security.rst) however neither are drive-by code dumps particularly
> useful to the project. Orphaned sections of code are liable to
> eventually get removed especially if there is little evidence of it
> being useful to people. You should be prepared to at least field bug
> reports and review incoming patches even if the patches are eventually
> merged through some higher level maintainer tree.
>
> > - Upstream acceptance concerns
>
> All code added to QEMU adds some degree to the maintenance burden. As
> code is likely to be re-factored by many people the most useful thing to
> address are:
>
>   - Good comments and references to source documents of what behaviour
>     should be
>   - Testing, having some way to ensure functionality doesn't bit rot
>   - Try and keep changes localised - QEMU is pretty modular but if you
>     need to make changes to wider code expect to justify it.
>
> Plus all the usual things about project coding and commit style and what
> developer focused documentation we have:
>
>   https://qemu.readthedocs.io/en/master/devel/index.html
>
>
>
> >
> > Thanks
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

Thank you for the detailed feedback.

My initial goal is intentionally much smaller than full smartphone
emulation. I mainly want to establish a minimal MSM7K machine model
capable of early Linux/Android boot and serial console output.

I agree that a complete emulation of commercial devices would require
significant long-term work, especially for multimedia and modem-related
hardware.

Regarding experience:

   -

   I have been studying QEMU internals and ARM board models
   -

   I have experience with low-level firmware/kernel analysis
   -

   I have also been working with vendor kernel sources and older Android
   boot chains

For the initial devices:

   -

   ARM1136 support already existing in QEMU simplifies the CPU side
   -

   Some peripherals appear to be Qualcomm-specific rather than standard
   ARM PrimeCell IP blocks, although I am still verifying this through
   downstream kernel sources and available documentation

My current plan is roughly:

   1.

   Minimal machine definition
   2.

   UART support
   3.

   Interrupt/timer implementation
   4.

   NAND boot path
   5.

   Linux kernel boot to serial console

I also appreciate the comments regarding:

   -

   record/replay compatibility
   -

   maintainability expectations
   -

   testing and documentation
   -

   avoiding legacy API patterns

I intend to keep the implementation incremental and localized as much
as possible.
Thanks again for the guidance and references.

--0000000000002c4cf3065259f2fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Alex Benn=C3=A9=
e writes:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">gustav=
o menezes &lt;<a href=3D"mailto:gumenezes2019@gmail.com" target=3D"_blank">=
gumenezes2019@gmail.com</a>&gt; writes:<br>
<br>
&gt; Hello,<br>
&gt;<br>
&gt; I am interested in developing initial support for the Qualcomm MSM7201=
A<br>
&gt; SoC family in QEMU.<br>
&gt;<br>
&gt; The goal is to emulate early Qualcomm MSM7K-based smartphones such as<=
br>
&gt; the HTC Dream / T-Mobile G1 and related Windows Mobile devices.<br>
<br>
That sounds like quite a lot of work for one person. Have you done much<br>
device modelling or reverse engineering before?<br>
<br>
&gt;<br>
&gt; Initial targets would include:<br>
&gt; - ARM1136 core support integration<br>
<br>
We already have at least one board that uses this so that is done.<br>
<br>
&gt; - UART<br>
&gt; - Interrupt controller<br>
&gt; - Timers<br>
<br>
Are these all Arm IP blocks or something QC specific?<br>
<br>
&gt; - NAND flash controller<br>
&gt; - Minimal Linux/Android boot capability<br>
<br>
While Android can boot on QEMU (specifically the Cuttlefish Android<br>
target) you may need to model/stub a lot of devices to get through the<br>
boot of an unmodified image.<br>
<br>
&gt; Longer term goals may include:<br>
&gt; - LCD/framebuffer support<br>
&gt; - Audio<br>
&gt; - Modem/DSP stubs<br>
&gt; - Power management<br>
&gt; - Windows Mobile compatibility<br>
&gt;<br>
&gt; Potential use cases:<br>
&gt; - Preservation of early smartphone platforms<br>
&gt; - Android historical research<br>
&gt; - Embedded Linux development<br>
&gt; - Reverse engineering research<br>
<br>
For reverse engineering you should ensure any devices you model work<br>
appropriately with record/replay. <br>
<br>
&gt;<br>
&gt; I would appreciate feedback regarding:<br>
&gt; - Existing related efforts<br>
<br>
There are a number of downstream forks of QEMU that model various things<br=
>
including at least one that claims to emulate a full iPhone so such<br>
things are possible. However most of the upstream models are either<br>
aimed at virtualisation, model various developer/reference boards and a<br>
large number of system controller boards.<br>
<br>
&gt; - Preferred machine model structure<br>
<br>
I&#39;ll leave that for others - however the general advice is to be wary o=
f<br>
copying and pasting for older models which often use old/legacy APIs and<br=
>
haven&#39;t bee converted.<br>
<br>
&gt; - Maintainership expectations<br>
<br>
No one is expecting full security support for random board models (see<br>
security.rst) however neither are drive-by code dumps particularly<br>
useful to the project. Orphaned sections of code are liable to<br>
eventually get removed especially if there is little evidence of it<br>
being useful to people. You should be prepared to at least field bug<br>
reports and review incoming patches even if the patches are eventually<br>
merged through some higher level maintainer tree.<br>
<br>
&gt; - Upstream acceptance concerns<br>
<br>
All code added to QEMU adds some degree to the maintenance burden. As<br>
code is likely to be re-factored by many people the most useful thing to<br=
>
address are:<br>
<br>
=C2=A0 - Good comments and references to source documents of what behaviour=
<br>
=C2=A0 =C2=A0 should be<br>
=C2=A0 - Testing, having some way to ensure functionality doesn&#39;t bit r=
ot<br>
=C2=A0 - Try and keep changes localised - QEMU is pretty modular but if you=
<br>
=C2=A0 =C2=A0 need to make changes to wider code expect to justify it.<br>
<br>
Plus all the usual things about project coding and commit style and what<br=
>
developer focused documentation we have:<br>
<br>
=C2=A0 <a href=3D"https://qemu.readthedocs.io/en/master/devel/index.html" r=
el=3D"noreferrer" target=3D"_blank">https://qemu.readthedocs.io/en/master/d=
evel/index.html</a><br>
<br>
<br>
<br>
&gt;<br>
&gt; Thanks<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br></blockquote><div><br></div><p>Thank y=
ou for the detailed feedback.</p><p>My initial goal is intentionally much s=
maller than full smartphone<br>emulation. I mainly want to establish a mini=
mal MSM7K machine model<br>capable of early Linux/Android boot and serial c=
onsole output.</p><p>I agree that a complete emulation of commercial device=
s would require<br>significant long-term work, especially for multimedia an=
d modem-related<br>hardware.</p><p>Regarding experience:</p><ul><li><p>I ha=
ve been studying QEMU internals and ARM board models</p></li><li><p>I have =
experience with low-level firmware/kernel analysis</p></li><li><p>I have al=
so been working with vendor kernel sources and older Android<br>boot chains=
</p></li></ul><p>For the initial devices:</p><ul><li><p>ARM1136 support alr=
eady existing in QEMU simplifies the CPU side</p></li><li><p>Some periphera=
ls appear to be Qualcomm-specific rather than standard<br>ARM PrimeCell IP =
blocks, although I am still verifying this through<br>downstream kernel sou=
rces and available documentation</p></li></ul><p>My current plan is roughly=
:</p><ol><li><p>Minimal machine definition</p></li><li><p>UART support</p><=
/li><li><p>Interrupt/timer implementation</p></li><li><p>NAND boot path</p>=
</li><li><p>Linux kernel boot to serial console</p></li></ol><p>I also appr=
eciate the comments regarding:</p><ul><li><p>record/replay compatibility</p=
></li><li><p>maintainability expectations</p></li><li><p>testing and docume=
ntation</p></li><li><p>avoiding legacy API patterns</p></li></ul><p>I inten=
d to keep the implementation incremental and localized as much<br>as possib=
le.</p><div>Thanks again for the guidance and references.=C2=A0</div></div>=
</div>

--0000000000002c4cf3065259f2fc--

