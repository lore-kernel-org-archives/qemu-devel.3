Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D8BD2FEDC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 19:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoQe-0004pa-8I; Tue, 27 Jan 2026 14:08:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vkoQb-0004nR-V6
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 14:08:41 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vkoQW-0003pR-PI
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 14:08:41 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-34c27d14559so3640042a91.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 11:08:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769540915; cv=none;
 d=google.com; s=arc-20240605;
 b=ABdRtrf0AHsPaxHr8I/Pyd84ADv0XtAhP4l2WL01wSBdFLP4f4J/GiINj0NKhflobR
 KOV3yOLLwDIEEBaUGx/E9sPpindxgybQmOcyA/5FUBjo58gK165eYjbJq7+wUfNg/U6O
 DN00BbbXM9eUdrahIt7FNzukAYjj/187sK2CnZ75QBO1AUR1RDmAmFnX2WdJfm4sDJ/X
 UBXlFPuiymh08vfPrkxg0hbJF7SGyMxY7NCeWDKyg0F1vzgL7qu8ohlrcnL5CCv/RWbC
 mxpR4x9GBG0O+sGo2LZbJ3gfHTeUN1zRpHwmGbhdzwKcHlLHFO7SQPyqpyLCWI9tRMb/
 cjbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=c3nf8taFUs7gI3G0NvlsxRyzYIohsKqMY+o1mG1U9y8=;
 fh=hdAlyzp8UpdPSI5O9FlJmNzUHmpgbsMZHSul8BBn2VY=;
 b=jp7JHApZVdBC22UJzTCN5u+oY6pZhLhirtdloH7Dgp7sL6AnsNeuaVGbpMt++XVuln
 bmKY3WPzQqU67WXs1/otxHAX1hm5FkaGA9OgMgB03gJifKuxPRogfgTsbQIioStD3xXX
 RyfI7GohJ2rzOUeipye58yEjKpzW6z3bZsl0Hzt1W4SKoByl1v/agw9g9L3I2crv4gsk
 B/7w6fRq17QE11NPh7T8gKfe5tdhx7Ecp4RhW7RSj8xqUy5AdV1enYbCQXUeFrNtffBR
 H5A2W8YsO15TkmVKCmYwV5kk67TgbInPwqQudB79XyKSKKLe4fRdGzqEGpoxCTkSPBQX
 qDPA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769540915; x=1770145715; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c3nf8taFUs7gI3G0NvlsxRyzYIohsKqMY+o1mG1U9y8=;
 b=lZNJnMn9DAE8mQQv8fe9x0vF8+K0c9Rr5uj1Kx4f14Pjm1BfQfG5YmEX4rzYfT2/R5
 F2mPSM0lveNCFYg4u5LAggdoiqY58u+mkvq6+KZX8Rk5GOK/Rf/4jmTTwXW8MEPvOFv/
 iEMXaeFCBGyABVG6gCWndoccd7S79jcqlC0MI5Vvd+Q7Ly/ilUG6PFlAOHdEve0c2qRQ
 JAOthXWR/i5tOYpfYxarqy8/9Sz1cTmBRJeDda1EDJizBoaoAWVyuwEh+bpuUqiWT8fR
 7pS60sPuVktrhbd38VrqEe9YRwmU4GoME+ByVdH+/aooSI4lW1t1cE+pNc3tOBdxwHEm
 OXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769540915; x=1770145715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c3nf8taFUs7gI3G0NvlsxRyzYIohsKqMY+o1mG1U9y8=;
 b=PSjiE2kfItAWBCGnRN21ZHuzF2mIiDC7vAFAxws2FDHa/fLzCTCD4yBG6OVWWNAons
 H7jvlNuUj4o9xHfvFsRiTBwL0yfcO+rBMekAiTKWRxKgeKX9Cp+KsyXNI2UhekGOcFo1
 LXYTX2r33s0WL57e9j7Q9Y/jpbL41/ICeU4btWkmM9zZhxH8IJgeE1aICmKnN2Ldqo9I
 pLCX+f7zVcx0nevW9Jcos/H9UawSBRIs0W91DbiT5FdSNOkCJzFjRAqDCaUpUS0x62UW
 geVMXwzIH5T0kUzItkYeLTK9CB73XxPx+vQ4WddTzhF6YyXLXPK2eSakTA2deOW/QKXy
 jdOA==
X-Gm-Message-State: AOJu0YyXmUpIVbRnVNHWp8kXCJy5uwIKzXz9+QuzeGUXCMEBgflESQM1
 ihgdbdn+AHFsfAwiROVQu+li/y0gCegBiRghv3Wljr/5nxcB7E5GxAe9CUkkKJHi8wuwQWJQvJe
 68JnclDge3+LikOeXIHQ/w8+F1YF6Bks=
X-Gm-Gg: AZuq6aJJXVsHibAJK2zKha12X7AAd81J444Ykyl7BW/kPmCrCLjktLnIoe42W61OO2f
 q2zvGqoB4G0DUVdHYe5vAAMEjTQ/camFYPLa8Va1AGtLmpchejIZEgSu+sbnNRF8nnsUDxIh6/M
 YBFEw51NvQQdvM5m/2mUPVq59RQQ8WnzyPn23j0PFwTGJdk83DgXn1Tt/HYbEtKM6QEXHm1d2C2
 dhNJm+RMkcTPtKvqeTV6ojZJyiMdI6mdfS1FEqQ3vYyLb8CcP1ESmsJDjbQIimfk2H1Oz76IuV6
 rgYcduH7kjCOQzMvMqSLdArQkPM=
X-Received: by 2002:a17:90b:2688:b0:32e:3829:a71c with SMTP id
 98e67ed59e1d1-353fecedb8cmr2452879a91.16.1769540915242; Tue, 27 Jan 2026
 11:08:35 -0800 (PST)
MIME-Version: 1.0
References: <20260126223439.46974-1-marco.liebel@oss.qualcomm.com>
In-Reply-To: <20260126223439.46974-1-marco.liebel@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 27 Jan 2026 12:08:24 -0700
X-Gm-Features: AZwV_Qgnonnp4bNA6KrRgKTIFwNByqw8VSVWv7Q_VCGWLBaCn96mMylyS4yppdM
Message-ID: <CAATN3NoaG4T2iNy2twsHi=7LJDa9=kqkj=Z8fQ6BxJawJ_QUTg@mail.gmail.com>
Subject: Re: [PATCH] target/hexagon: Remove unused EXT_IDX enum
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 sid.manning@oss.qualcomm.com, brian.cain@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="000000000000ab2b57064963598b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x1031.google.com
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

--000000000000ab2b57064963598b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 3:34=E2=80=AFPM Marco Liebel <marco.liebel@oss.qual=
comm.com>
wrote:

> The EXT_IDX_noext, EXT_IDX_mmvec, and XX_LAST_EXT_IDX enum
> constants are defined but never referenced anywhere in the
> codebase.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>  target/hexagon/decode.c | 8 --------
>  1 file changed, 8 deletions(-)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000ab2b57064963598b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 26,=
 2026 at 3:34=E2=80=AFPM Marco Liebel &lt;<a href=3D"mailto:marco.liebel@os=
s.qualcomm.com">marco.liebel@oss.qualcomm.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">The EXT_IDX_noext, EXT_IDX_mmv=
ec, and XX_LAST_EXT_IDX enum<br>
constants are defined but never referenced anywhere in the<br>
codebase.<br>
<br>
Signed-off-by: Marco Liebel &lt;<a href=3D"mailto:marco.liebel@oss.qualcomm=
.com" target=3D"_blank">marco.liebel@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/decode.c | 8 --------<br>
=C2=A01 file changed, 8 deletions(-)<br></blockquote><div><br></div><div>Re=
viewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com">l=
taylorsimpson@gmail.com</a>&gt;=C2=A0</div></div></div>

--000000000000ab2b57064963598b--

