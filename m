Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E75EDEBEB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxVwL-0004g4-HO; Tue, 03 Mar 2026 15:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxVwH-0004fg-Jn
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:01:53 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxVwF-0007EA-Kz
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:01:52 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c6dd5b01e14so2123196a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 12:01:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772568110; cv=none;
 d=google.com; s=arc-20240605;
 b=kXxrGU80BXxJ9e+/NwMz43R65Md/x0+haLiXhLpqf6zihAxYNA8W5pLg3ZtSnlM3WM
 WN5T5BQbBlipM+hwK6Gd9e7mxtXhVvoUt19Rw07ZwpHCXOG0hDBEtZKhjntpRKMO2ZBb
 gn/TuPQfLzeQatf6j5FCwjY045Y2ZTyZsL/tdUKx5VpvGo961Owut4NBGB4oBmg0tV1a
 p/uENr1oAWyvDQt8lpC9gWYaDqWmTiWstDxS2GOHgdYptKtTR/C6097V/Uuhkx/k9BqB
 WpmsxKYSsFlxUMSSNVaEBV1Qkkv4LlST10+Pz6JOk0i9bXnBtltpPIw1tLxilt4B+Mhb
 +vvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8fH8KcUdkOvwGvMaZBR+/w9jSYwvnhbluX8FMDKKVvs=;
 fh=3N4YTDWV9KQk1Zfz9qwlmnoEsAk4PdvYntvEBJFMlvI=;
 b=Thr+9w2G0hUcmdlBWo1qLT/2Pb/o0R/Z2CqbkQLZGqG/JllFK5TuklXw4Cma7K86yO
 VLosjDlDYFk/h2tOrIZ15oJP48LE3YS+uzWp8Bu2hvHRfefJM76U7gG7P76g/jUI1oZx
 0KdrWM5hZUC1rbcvLh6y4xSuZmly+nLbzOT9f4YQJ0mmHEyrz6BvILn6M0nQdc+uaW0E
 TNKSnxX7LbZOfIawMRb+FrBybgI74hgYLmr90yWNqqYEvVi+luCPy0dpy3WKQTuvTQjG
 j8qnbWH+zx3phTS6tkmJqP/tfou+GF0DZwp2Uq9j3uflLi813THXX6BYCCV9ipar2VPS
 SvUw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772568110; x=1773172910; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8fH8KcUdkOvwGvMaZBR+/w9jSYwvnhbluX8FMDKKVvs=;
 b=LCu9iiOGhh4gDnIyUib1f1gqNiY2w5JxxtHWhKJ4iKZvh1KJB0yPQl3hVtbTeuYU+O
 JOzotP9YlUj6DUPUiomBXePmPiz4UBNPkvstpCvcqpp445rU8CeUfE21d+f6b7jMl9xl
 r/673Z5sd4/15rwcXF5BjDvAIXwkAQEBZ5aOeFMvE6f32XVBan7QrHqPljWoJMhmphJz
 xtXvrIIKkxjWk8yP51s3T9drb6zbfe4a3bGFmZ9wcEkz5+NUgl4ltCAifCwCDjc93gei
 Gc+kS5c5di0BYKN0W4DGK7WXymVBnYLkUeEAhEBBTeukC1kpSfrdWsKq9X5eZAQl7jdv
 Hjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772568110; x=1773172910;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8fH8KcUdkOvwGvMaZBR+/w9jSYwvnhbluX8FMDKKVvs=;
 b=uaMCcHIQYmXiSbnoKiVTr3Y7a3aoewFCTu53vN++P6IbDzaBQMkvOEo8NOyHRJz8Zy
 9IVtoGqbttdPxKq/s60iizhmm1lYQ9ZgcTPsrEd/XVNOPMM2BQgypLsSPZpIQ6xRVGI+
 jjWDbBVYz+NayHbEYE4Gx47bAqIIE+2dMuyQBNGGOWUYBE5TIPapp12dizxladN8wRMZ
 5ZtGReIBCttE6JVyCeZ+XMeHUjWlGNi+yceMmu3g7sAL2Ppb3gtq9veh7twPW3KSo044
 vY/4o/vLhD6FWEodmHn6txTblzvrVB+C+h9i3TGNxck+ZBYH8KggZexp1/mrfZL15mWS
 JZ9Q==
X-Gm-Message-State: AOJu0Yz/jSq93clF8zf+ke0zgUaAGxGYUwQy+tiiZNvUQ0KUrr1zDXyO
 BEm4LQS/D7fc6fm+wNjIDebUOM2gw2RurZMMGdslO42I7IHUSwgo9qlEtgkGnyQdQ2lnT38CVOa
 gCWKaCoKgWbfyiH77tNki1+4B1MBrOOBiEn6C
X-Gm-Gg: ATEYQzxQa0gxgky0s0luHg4pcVXMBcgQfarjrJ2Qa0abt86gxv7g4XJf1R0pzk33jl3
 r90S9dxRMsEIFpSCOd73zEXKxBj7+cK3pyfuAMl/izwLa4UbTcUPOpcGoQO7FXTZonABIL6aDsd
 XSeL+OesX/vJV6b/FOPbrPEk3aUDuO0F+DXfnyB4vuxRe7WwmzGBvZEPh6VATuhaDUxf8F3AGj7
 IbWS2rX/cF4gkOVM6Rf069U11w4lJ/+8t22ASvNFQNQ05jgFLFXJMGO8tAG/I/RFGge1J4V5DKa
 Kecp/Y8bo3kyQyX+onJ4CaonIWKWY7/Zd4tIJs0=
X-Received: by 2002:a17:90a:e710:b0:359:8633:675e with SMTP id
 98e67ed59e1d1-35986336edcmr7183483a91.31.1772568109961; Tue, 03 Mar 2026
 12:01:49 -0800 (PST)
MIME-Version: 1.0
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-19-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260227203627.932864-19-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 3 Mar 2026 13:01:38 -0700
X-Gm-Features: AaiRm52Lr1pJI4MccnotrJzidaUMtoA6UBB7ZpYBmgm_Swq9C8yFlCYpglJxm10
Message-ID: <CAATN3NrvktjC004BA5-r0jGQ2DTPHrXpqMubiZEq29Y3QH-WJA@mail.gmail.com>
Subject: Re: [PATCH v3 18/37] target/hexagon: Add handlers for guest/sysreg r/w
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com, 
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng, 
 Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="00000000000088d4df064c242c9b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pg1-x534.google.com
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

--00000000000088d4df064c242c9b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 1:36=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> This commit provides handlers to generate TCG for guest and system
> register reads and writes.  They will be leveraged by a future commit.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/genptr.c | 147 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 147 insertions(+)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--00000000000088d4df064c242c9b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 27,=
 2026 at 1:36=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mail=
to:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
This commit provides handlers to generate TCG for guest and system<br>
register reads and writes.=C2=A0 They will be leveraged by a future commit.=
<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/genptr.c | 147 +++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 147 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com=
">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div></div></div>

--00000000000088d4df064c242c9b--

