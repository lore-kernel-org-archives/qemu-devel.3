Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04A610FC454
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 22:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAazL-0006a8-3q; Wed, 08 Apr 2026 18:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAazC-0006Sz-NM
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 18:02:59 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAazB-0002OT-1u
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 18:02:58 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so1685555ad.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 15:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775685775; cv=none;
 d=google.com; s=arc-20240605;
 b=N3pX12lwljhXJFMrT3/vKXpRlttEcfkVt84D6ssA/VFSH0asOz6Hekf1jUHdA5Kx0h
 vEplHumwDhygrau/xz13RlN31QrshjSN86DajT8yi3kISKFo/xDik3Xeo8zcnd7PcBxz
 SPuk31ebFN/6iawl8VUPMV6yQl9uQZ6Ep3u1vQcb63OfrAobWcYsFX1aOvgAaYGbsKQ0
 i8BaXB5AbJLWeutOLKhWkJ5IuOjy40Hib6L8Dmdvupj8cT9BCLacvyLtRgkBoOPookG6
 hUfrJWi7+lX4g8V2EVTAtJwnsI1HHNnwaAzYdAUhgS6WsDojMTX9kjkbfI4OD7rRTfzf
 XG7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3hwJCPuCgH3rgUAvT1nsRxG43o8YBWsmn2yr1n2d//s=;
 fh=seHpsuERei6GoCJPMtZiXpXOw/2EVnvuQ7nSTREwIqg=;
 b=V4wC53cmMH+Rw75jqQtG6iey/KjolnkduOh2EreS4ioD8lYSpdpFiUvEnp65Yf64Wp
 R/iRKP8O/wCER0nVzq1ek3st1kh9k8pICh9WXSzAlBCvxBXRRhHgJrdweV9z7Lh0VhFe
 NHu6HdXAYSe5lYA8UqMzsKZueWjcQ0frJ+I2PhsRxILy/D7QIs1rMj90JFVKGx6X8HSp
 VB8A7zQDLicw4DjsK/4Sy0WgRSuzU9UGbiZaYYjuWa4Upo9WdL9ge8Fb9VwkCI6FcvLc
 hBWg9ULY/CINvCfuPpme3202+PP6KzW8X4VLaXML4bTkWZy/Xo/aWvgQ9Jg9LZDBh0fm
 jtHg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775685775; x=1776290575; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3hwJCPuCgH3rgUAvT1nsRxG43o8YBWsmn2yr1n2d//s=;
 b=JxUTIsw53ihp5s7HwOwNQQIVBQvh2crXSUUmgGPjQvb4llDsFWn4RDDwVQAtCDnxWO
 dRjsI//qsDjoZtA8S1HJWi2b+PwND019XCzbtak5+VH4NHAoihoMoYLN+tR1bcKVA2UY
 TMJ1+OsD0MCmbsT1CF2wT0+TYld4aggDzifa8xbmEOCJ4qYxObs78KOt3JFChfg28ILR
 vkRSaFtw6A9W+mijs1oLWqFZZaMUnXVBnLUT9FjRsp1FeJkXF97mhz1UKh2s/0JxxPqA
 MU2fZEuTqtbMND1sES3Gn3RAtEtP6250gte0Ws3y2qZrRnEOOSg6fwxOH/VxMzRFDlv4
 IKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775685775; x=1776290575;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3hwJCPuCgH3rgUAvT1nsRxG43o8YBWsmn2yr1n2d//s=;
 b=nQBrexnwpWFs8NpC8EtFjFYPGFJ+QOsJjFgPggXK6CmjZQtusDTcmJjium3z0x9Sn9
 J+FxygLwtEvKGVhUjioud6Fdnz5ES0moDSEfTjfH1d8Jk12ag96oMXcBlB3v4aPJyiW6
 D8gHLr/uIuArk3o3slL5PWmhr3VaE17xNuVBUGOEQjb+HATNBa5/hWCRRIlN1jLnIdR/
 nI8H20cB5eo7nRbQEgE4EtlP2FrYD++fCQmKkskXBuHOkwIDJKp+zNB+pApn44gNfJuM
 AFgOnzLk9oJOUg38AhzExDZbA4+S1XQAtE2FgLwL7rqPyaoBc2Fiqu/agXHUIVuAJpL3
 IvtQ==
X-Gm-Message-State: AOJu0YwtiWxfLHEdSfRStCDh0teoVAQIi5ZvDc9Tmmku+pws/J1+lJGw
 8FLbv1CS5xwXdwEHJU/8xb0Wdrtl0nIgXiLONo1wgsuwaXHtXXc7sFaemosFy1uRzfdG/2LOIfM
 wXC9OG/RwhMGICtEQY0ot+wGZBLRu1MM=
X-Gm-Gg: AeBDiesxjkwvNF6qFSXnyLYIPCF/ZDlWZ0TcF+t/zKiaP5b+tTKFcXwy5a5I27vEXbh
 j2JmIYEDwyXC9F7dPSN8BlMfISnTGDpSwSxcXceuURgERPDnHtNceIiGYSvk/DOIwDYf6CCWKA6
 gb6zhfdXl478ir6p0PYM16SbZCFYp5LDH5D3FgsKbWZhbGajWVoBIEyOiocoNlpg2mqxondk4sN
 vR0GngYlYKvETaKn+mddp2HCZPscN8f5/E21V+ovPSEZx3BcwDSsV9puoQe/2osMMXSaQ08/wWP
 P715dUL9/4zNvn+TDSKhjFtP+gELtm10jLDwqU4=
X-Received: by 2002:a17:902:e741:b0:2b2:4b4e:e4d2 with SMTP id
 d9443c01a7336-2b2817558bfmr238967155ad.15.1775685775385; Wed, 08 Apr 2026
 15:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
 <192fd1ca5cefcac271f5efb4cb0b5b15e671f833.1775665981.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <192fd1ca5cefcac271f5efb4cb0b5b15e671f833.1775665981.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Wed, 8 Apr 2026 16:02:43 -0600
X-Gm-Features: AQROBzAwWd_FAemFonWntM2TzZVj4fUk-OFPJCNgqPBHSRZz8RwM0BUFmZ30EYQ
Message-ID: <CAATN3Nr_3OtsdOMwEA=Bu2=a5jK3fJe7M8HX-tXmSKWoqLPKww@mail.gmail.com>
Subject: Re: [PATCH v3 05/16] hexagon: print info on "-d in_asm" for disabled
 IEEE FP instructions
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, ale@rev.ng, 
 anjo@rev.ng, brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="000000000000dfe6f4064efa0f13"
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pl1-x636.google.com
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

--000000000000dfe6f4064efa0f13
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> When cpu->cfg.ieee_fp_extension is off, IEEE FP instructions don't get
> executed. Let's print that info on the "-d in_asm" output to help users.
> This will generate an output like the following:
>
> 0x00020e30:  0x1f82e1c0 {       V0.sf =3D vadd(V1.sf,V2.sf) (disabled: no
> ieee_fp) }
>
> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_bits.h  | 3 ++-
>  target/hexagon/printinsn.h | 2 +-
>  disas/hexagon.c            | 3 ++-
>  target/hexagon/cpu.c       | 2 ++
>  target/hexagon/decode.c    | 4 ++--
>  target/hexagon/printinsn.c | 7 ++++++-
>  6 files changed, 15 insertions(+), 6 deletions(-)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000dfe6f4064efa0f13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 8, =
2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">When=
 cpu-&gt;cfg.ieee_fp_extension is off, IEEE FP instructions don&#39;t get<b=
r>
executed. Let&#39;s print that info on the &quot;-d in_asm&quot; output to =
help users.<br>
This will generate an output like the following:<br>
<br>
0x00020e30:=C2=A0 0x1f82e1c0 {=C2=A0 =C2=A0 =C2=A0 =C2=A0V0.sf =3D vadd(V1.=
sf,V2.sf) (disabled: no ieee_fp) }<br>
<br>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.ber=
nardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm=
.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu_bits.h=C2=A0 | 3 ++-<br>
=C2=A0target/hexagon/printinsn.h | 2 +-<br>
=C2=A0disas/hexagon.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 3 ++-<br>
=C2=A0target/hexagon/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
=C2=A0target/hexagon/decode.c=C2=A0 =C2=A0 | 4 ++--<br>
=C2=A0target/hexagon/printinsn.c | 7 ++++++-<br>
=C2=A06 files changed, 15 insertions(+), 6 deletions(-)<br></blockquote><di=
v><br></div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylors=
impson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div></=
div></div>

--000000000000dfe6f4064efa0f13--

