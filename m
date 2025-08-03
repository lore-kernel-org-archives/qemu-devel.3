Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20B3C87FCB
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 13:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiYkb-0001aK-I3; Sun, 03 Aug 2025 09:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1uiYfL-00031S-MF
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 09:22:21 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1uiYfJ-0008B8-HT
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 09:22:19 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-3323afe4804so20878371fa.0
 for <qemu-devel@nongnu.org>; Sun, 03 Aug 2025 06:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1754227335; x=1754832135;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=huPZDqHXHPROPj1E+wMfINtuUOGYDjcNKWpY2tOuEdg=;
 b=xjHhvZGmaBKiG+jHOvHj5GSQDs+9ZFGvqHFZHi8g9FdWgAPqYE2pLGoSZclqJSmOdS
 TrzO3IPzJlDcf1OTFp6FWDP4bLupXnEFxm0yCRlhTD5REn0oAvLijNyqnJG75ZZZ4dlO
 SwOC3jEnCVBIr1kpJ3AdG0mTwb+MTcCYwmuAAXLVHd2pTIEfwdGdkLIrUx2HjPhs7YLM
 q/vJtiCTbU+yDAM2OFQUcBy+Is4xvW18Oy22fZB4iUo51M3T9OW8NoMc0R6JgVSN8qHs
 v/BCArZxIt6seCTE+S+HxXtQtCHUan01r+KOccl5xJDgXDYeu4qRzkc46Je10H25qQ8R
 PggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754227335; x=1754832135;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=huPZDqHXHPROPj1E+wMfINtuUOGYDjcNKWpY2tOuEdg=;
 b=vO4Zd3aQanTjAr1bnxXHe0lna+1yXVXMuHx/3tVXZCBug91zcMbHf9ydWX1Nbfurui
 7FGmQDRszk6WtEcaM5QvGpNKIQvzn2GhkPqnGA1JzDoiPtQHrbZF8TNKMHAEmKxvxcEG
 1lsUO1YkOWQd0RlN+QMcnOrO6GdA3Vaz8b8PLa9LZaYPbyuUmK+C8amxp9AFHdFuUufb
 tqXC8MfEQCMLRn2eo3JmfAXPQnzHiBpNdSHnO8COkb41tWFalXHLPjqzY7V3e0LHworf
 APLsgAneXW8bCuWywbf8t+5vRyRiLboM9UpIiPsx35YIsayQz9axZaqQZ9o3wnZxzO7o
 GTTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVJdBTj3daDvkoLoDFClSrUfkllYT9akxPYaa5dJcgAEgfOXd+757ouW3sbFET6qKvguuNNxH76s6m@nongnu.org
X-Gm-Message-State: AOJu0YyGP84YjzcdMDPzpP5jZa4SbH8/oqy4dOTPMs7cPtGKJdEZNqBQ
 njD4eOApAlPt25XIFpv96Yx7EKBrd7Ns4N0D4uwhi3IaDufeHi761bCQMjA5kU8+85Q0A/qJCnW
 RLDKh8VjAndutwDVdpRBoHYuu14vSQw6j/Q+HCAbfWA==
X-Gm-Gg: ASbGnct1rCIQZ/KQOa4xLTWmZkQLmx/QxltZXcg2D/baxsgg0G0IUg0We/fzKYiaEvY
 ZQVRAyhdzY3og9FQUdmTXARgaj4kpkIyc4pDLG7L2OZCedx2959ld4kqMAfzXwa6GKXrTAhuCQY
 m5UCZ7np0XfBzDZBJobVAVglDNbhvY7p5CJ7jbCsb6er+0BRvIB5F/wBeJCbMrVlHfXupmZOLXz
 fcvm1SDGv+KUM1CES9RlNV87Udol6GkjzHKmw==
X-Google-Smtp-Source: AGHT+IGwrRlRbR/17gDiLydR6vMKdUDHVFYW3/Rr4xBrrIfeBNaqRkdARqwKMt/ydbkRvKxH6UryQCmB0J4A4HZdPfc=
X-Received: by 2002:a2e:b4a4:0:b0:32c:a771:9899 with SMTP id
 38308e7fff4ca-33256700ddfmr13017641fa.9.1754227334774; Sun, 03 Aug 2025
 06:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR02MB502953334AA7CE0A695C373C8545A@BYAPR02MB5029.namprd02.prod.outlook.com>
 <BYAPR02MB5029F83A450ED347FF69345F8520A@BYAPR02MB5029.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB5029F83A450ED347FF69345F8520A@BYAPR02MB5029.namprd02.prod.outlook.com>
From: Corey Minyard <corey@minyard.net>
Date: Sun, 3 Aug 2025 08:22:02 -0500
X-Gm-Features: Ac12FXyfoLpNQHRd5_tNUmdbizytSMkk6Xn3fYhVhl9PGl4qPXEOkUIAa3ro0K0
Message-ID: <CAB9gMfoVgdoWV1Y=-hkTcVJoKHe8SPBH4z1UqqrXavTE-9T+TA@mail.gmail.com>
Subject: Re: Add support for retrieving fake LAN config from `ipmi-bmc-sim`
 device
To: Yunpeng Yang <yunpeng.yang@nutanix.com>
Cc: "minyard@acm.org" <minyard@acm.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jonathan Davies <jond@nutanix.com>
Content-Type: multipart/alternative; boundary="0000000000002511ec063b75e124"
Received-SPF: none client-ip=2a00:1450:4864:20::22f;
 envelope-from=corey@minyard.net; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000002511ec063b75e124
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 6:16=E2=80=AFAM Yunpeng Yang <yunpeng.yang@nutanix.c=
om>
wrote:

> Hello Corey Minyard,
>
> I hope you are all well.
>
> Could I ask for your opinion on whether it is worthing implementing a fak=
e
> LAN config for device ipmi-bmc-sim ? (Details are in my last email, which
> is also included below).
>
> During my work over last month, I found that QEMU already has
> ipmi-bmc-extern which supports comprehensive BMC simulation, including
> LAN config faking. But ipmi-bmc-sim is more light-weight and easier to
> set up. So I think it still has some value in implementing LAN config for
> ipmi-bmc-sim . Could you please share your views?
>
>
Well, there is no LAN interface, so I didn't see any need to add that.  The
values would not be permanent.  But it would be harmless to add, so I'd be
ok with a patch to do this.

The external interface with ipmisim from the OpenIPMI library provides a
pretty comprehensive solution.

-corey


> Best regards,
> Yunpeng Yang
>
>
> ------------------------------
> *From:* Yunpeng Yang <yunpeng.yang@nutanix.com>
> *Sent:* Friday, June 27, 2025 18:13
> *To:* minyard@acm.org <minyard@acm.org>
> *Cc:* qemu-devel@nongnu.org <qemu-devel@nongnu.org>; Mark Cave-Ayland <
> mark.caveayland@nutanix.com>; Jonathan Davies <jond@nutanix.com>
> *Subject:* Add support for retrieving fake LAN config from `ipmi-bmc-sim`
> device
>
> Hello Corey Minyard,
>
> I hope this email finds you well.
>
> I'm currently adding LAN-configs-retrieval support to the QEMU
> ipmi-bmc-sim device. And I hope to merge the modifications upstream after
> it's finished. Could you please check the attached patch file of the draf=
t
> code and share your opinions and advice?
>
> In my work, we need to run tools like "ipmitool lan print" on a VM for
> testing purposes. However, QEMU internal BMC simulator device
> (`ipmi-bmc-sim`) does not support retrieving LAN configs from it. I have =
to
> implement two IPMI commands so that the device can now work with ipmitool=
.
> The LAN config values are faked, but for testing purposes this is not a
> problem. I believe other people may also have the same need, so it's wort=
h
> getting merged upstream.
>
> The fake BMC LAN config values are currently hard coded into the code. My
> plan is to add a parameter to the device, which is a file containing user
> designated values. The device then reads the file and returns those value=
s
> as LAN configs. This is similar to sdrfile for sensor data and frudatafil=
e for
> FRU data.
>
> Looking forward to hearing your thoughts.
> Have a nice weekend.
>
> Kind regards,
> Yunpeng Yang
>

--0000000000002511ec063b75e124
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sun, Aug 3, 2025 at 6:16=E2=80=AFAM Yunpen=
g Yang &lt;<a href=3D"mailto:yunpeng.yang@nutanix.com">yunpeng.yang@nutanix=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><div class=3D"msg-6149444309649698547">




<div dir=3D"ltr">
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
Hello Corey Minyard,</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
I hope you are all well.</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
Could I ask for your opinion on whether it is worthing implementing a fake =
LAN config for device
<code>ipmi-bmc-sim</code>=C2=A0? (Details are in my last email, which is al=
so included below).</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
During my work over last month, I found that QEMU already has <code>ipmi-bm=
c-extern</code>=C2=A0which supports comprehensive BMC simulation, including=
 LAN config=C2=A0faking. But
<code>ipmi-bmc-sim</code>=C2=A0is more light-weight and easier to set up. S=
o I think it still has some value in implementing LAN config for
<code>ipmi-bmc-sim</code>=C2=A0. Could you please share your views?</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
<br></div></div></div></blockquote><div><br></div><div>Well, there is no LA=
N interface, so I didn&#39;t see any need to add that.=C2=A0 The values wou=
ld not be permanent.=C2=A0 But it would be harmless to add, so I&#39;d be o=
k with a patch to do this.</div><div><br></div><div>The external interface =
with ipmisim from the OpenIPMI library provides a pretty comprehensive solu=
tion.</div><div><br></div><div>-corey</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div class=3D"msg-6149444309649698547"><=
div dir=3D"ltr"><div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MS=
FontService,Calibri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
Best regards,</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
Yunpeng Yang</div>
<div id=3D"m_-6149444309649698547appendonsend"></div>
<div><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<hr style=3D"display:inline-block;width:98%">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<b>From:</b>=C2=A0Yunpeng Yang &lt;<a href=3D"mailto:yunpeng.yang@nutanix.c=
om" target=3D"_blank">yunpeng.yang@nutanix.com</a>&gt;<br>
<b>Sent:</b>=C2=A0Friday, June 27, 2025 18:13<br>
<b>To:</b>=C2=A0<a href=3D"mailto:minyard@acm.org" target=3D"_blank">minyar=
d@acm.org</a> &lt;<a href=3D"mailto:minyard@acm.org" target=3D"_blank">miny=
ard@acm.org</a>&gt;<br>
<b>Cc:</b>=C2=A0<a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">=
qemu-devel@nongnu.org</a> &lt;<a href=3D"mailto:qemu-devel@nongnu.org" targ=
et=3D"_blank">qemu-devel@nongnu.org</a>&gt;; Mark Cave-Ayland &lt;<a href=
=3D"mailto:mark.caveayland@nutanix.com" target=3D"_blank">mark.caveayland@n=
utanix.com</a>&gt;; Jonathan Davies &lt;<a href=3D"mailto:jond@nutanix.com"=
 target=3D"_blank">jond@nutanix.com</a>&gt;<br>
<b>Subject:</b>=C2=A0Add support for retrieving fake LAN config from `ipmi-=
bmc-sim` device
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"direction:ltr;font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFo=
ntService,Calibri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
Hello Corey Minyard,</div>
<div style=3D"direction:ltr;font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFo=
ntService,Calibri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"direction:ltr;font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFo=
ntService,Calibri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
I hope this email=C2=A0finds you well.</div>
<div style=3D"direction:ltr;font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFo=
ntService,Calibri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"direction:ltr;font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFo=
ntService,Calibri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
I&#39;m currently adding LAN-configs-retrieval support=C2=A0to the QEMU <co=
de>ipmi-bmc-sim</code>=C2=A0device. And I hope to merge the modifications u=
pstream after it&#39;s finished. Could you please check the attached patch =
file of the draft code and share your opinions and
 advice?</div>
<div style=3D"direction:ltr;font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFo=
ntService,Calibri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"direction:ltr;font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFo=
ntService,Calibri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
In my work, we need to run tools like &quot;ipmitool lan print&quot; on a V=
M for testing purposes. However, QEMU internal BMC simulator device (`ipmi-=
bmc-sim`) does not support retrieving LAN configs from it. I have to implem=
ent two IPMI commands so that the device can
 now work with <code>ipmitool</code>. The LAN config values are faked, but =
for testing purposes this is not a problem. I believe other people may also=
 have the same need, so it&#39;s worth getting merged upstream.</div>
<div style=3D"direction:ltr;font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFo=
ntService,Calibri,Helvetica,sans-serif;font-size:11pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"direction:ltr;font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFo=
ntService,Calibri,Helvetica,sans-serif;color:rgb(0,0,0)">
<span style=3D"font-size:11pt">The fake BMC LAN config values are currently=
 hard coded into the code. My plan is to add a parameter to the device, whi=
ch is a file containing user designated values. The device then reads the f=
ile and returns those values as
 LAN configs. This is similar to <code>sdrfile</code>=C2=A0for sensor data =
and <code>frudatafile</code></span><span style=3D"font-size:14.6667px;backg=
round-color:rgb(255,255,255)">=C2=A0for FRU data.</span></div>
<div style=3D"direction:ltr;font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFo=
ntService,Calibri,Helvetica,sans-serif;font-size:14.6667px;color:rgb(0,0,0)=
">
<span style=3D"background-color:rgb(255,255,255)"><br>
</span></div>
<div style=3D"direction:ltr;font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFo=
ntService,Calibri,Helvetica,sans-serif;font-size:14.6667px;color:rgb(0,0,0)=
">
<span style=3D"background-color:rgb(255,255,255)">Looking forward to hearin=
g your thoughts.</span></div>
<div style=3D"direction:ltr;font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFo=
ntService,Calibri,Helvetica,sans-serif;font-size:14.6667px;color:rgb(0,0,0)=
">
<span style=3D"background-color:rgb(255,255,255)">Have a nice weekend.</spa=
n></div>
<div style=3D"direction:ltr;font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFo=
ntService,Calibri,Helvetica,sans-serif;font-size:14.6667px;color:rgb(0,0,0)=
">
<span style=3D"background-color:rgb(255,255,255)"><br>
</span></div>
<div style=3D"direction:ltr;font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFo=
ntService,Calibri,Helvetica,sans-serif;font-size:14.6667px;color:rgb(0,0,0)=
">
<span style=3D"background-color:rgb(255,255,255)">Kind regards,</span></div=
>
<div style=3D"direction:ltr;font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFo=
ntService,Calibri,Helvetica,sans-serif;font-size:14.6667px;color:rgb(0,0,0)=
">
<span style=3D"background-color:rgb(255,255,255)">Yunpeng Yang</span></div>
</div>

</div></blockquote></div></div>

--0000000000002511ec063b75e124--

