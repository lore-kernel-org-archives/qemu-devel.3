Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DA5EDEBEB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 19:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxViv-0001bo-Q8; Tue, 03 Mar 2026 14:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxVip-0001ao-Bx
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:47:59 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxVin-0001GX-0g
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:47:58 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ae527552acso9280155ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 11:47:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772567274; cv=none;
 d=google.com; s=arc-20240605;
 b=ZFmQx+jJb0+4+31YNvqmUPze5y3sux/JZe7C5Be91l15vApnuHZIKgm4tR2HR42utG
 XM9bYXYp3hJWdS1qF+CN3OM+glqANhOpWrXrSOnBd7xOzTWL7kqU7oiIya7XjddR7oVV
 jMhuf/h1YEESxVOGR28i4jaXIQtTx7IYkdIQQAVTAmuMfV7eiC3lMQbTS65Odud9diSQ
 hAFRFfeIbqi7F2qav7knqwVPJTa4SXNVezfFEHB2gI+xWa44B8LmJsoiKpeuHgQMCMjc
 RHpH1lihszljC7NQK4fvqFLea9RDInSSdv5g+Sv46L4L85Cz1C6VTDbv135JE77bCPYW
 evtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hCRV98dmlPZCJ5uqrJwXen8JHKMQIPo4v3CKsL6xXw0=;
 fh=3N4YTDWV9KQk1Zfz9qwlmnoEsAk4PdvYntvEBJFMlvI=;
 b=Bwzu+OD9NgR3/F0EtwfDmSOkD5PkH8tTtmkyW25C7kCkZZOzRtOQkUShpZeZSwa/Vj
 zb7kzr1/S0gOY8EfCYRzVeJvzKY8gvv10cg2ggs4sFzKDX+agKRRm91DNZK7IZ5fQTfc
 VUTh54AZg/nVwY6PwZ5qAQOPp7GnggmHraASQxiV5lR+yVCxJJ+X8mIF//PiA1JX6KW1
 tEJeQm39hPb21UQbhswncNUIfpqQJX8XUb+xeg8v3ZA9CTJoerPGBOhBbJqpMl0ey7IW
 ttKYce31oyUinPrtyzswLHbJX56cV25+W9GL4Iq6reLkTaKCWZlc2WbPc1xP5T1iFOZ/
 ZqmQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772567274; x=1773172074; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hCRV98dmlPZCJ5uqrJwXen8JHKMQIPo4v3CKsL6xXw0=;
 b=EDJdo3Jvo8TDDfkOKIGIDAJsA+lNHUTz4NrMpuNAcrzcsz2cELmMXecPDtEwXwCqcp
 MV5EwNRbJH9mSQVjSMj13f1tP6PueZ1tG4UuC14pWHOic6fs6dHSusD2G5Pf5o5hWEb+
 qH6c7Ck79Q1StkUKl2QmLyaGDfZwvrommfAJ/K99U/dYatgGKrI9o0nq5Mqn/bIrcGVR
 J3Nljy42iVVyWzeU5FvRYxP2ctATIIP1O2x4c/APHjn5phIFvxb1HxjL6ocK8rmGozSa
 mI4zdVMKH2eZPNY7IfWWJwOPqOS/Qir49weEN7O8HO04L6+o5nJ5ilVMZjoGr3i+rkeH
 SjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772567274; x=1773172074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hCRV98dmlPZCJ5uqrJwXen8JHKMQIPo4v3CKsL6xXw0=;
 b=KDe3tv8RuoYepvalpadLpgSDwiWkUakwqk9A6enEyZU9TblPToR66KO6ZWBfbAvKYf
 8XPMdz9/tc3gpagdgw7gBdW0OyQ/YPdR7Wv/5rbCxzR5k11m4HiZCZw/a0xkEqSQeRMq
 dwNJF6nZMe/6CaoqcyaU9CqEjlpz8Pd1jvAKYCD07p0de0afnb9JHZ9oszXSJs6d4eaE
 FocATo6yzq+eCpUCAu++5gjbMbsJiLG+BhvzwtUvGHosuZLJrYB2Hfve9M7JSl3fxMAi
 JsWUIFkd6cRLSGs1+qVDhqUaA7Z5ldkWI1KphkuBCUWZlgx/vmdSALMQfLDK6xDB/yJO
 fApw==
X-Gm-Message-State: AOJu0Yyk+2N9NjskHzw1SuFECQqszTgA7YViR2CpYmfQ5q9o2CKx6LXX
 FDp72w70Vm3j9eoH/N0JeUrSmIVcQbsoT7rhW69oehJgzSFwIUSbHAiQuV6fEubhY6zb+cq8g9x
 EMTs37XfrRSllnyxIe6FzXfAMYX1xGDg=
X-Gm-Gg: ATEYQzy6BRAcBfS+UwzNJSG6excVvnZaETTicNjxGGPFGkQMfxUdsM0OTEb/4DtugDV
 WlQxYJqVmGezU+KQrWi3qhyxbZ9P7qHTGkcq1cM4SPyAOMZeOzEdPBA/lFQX2m/pu+85f5ryrvQ
 eNf3+vwlwdV1HTkqBJUtAc0hB7M5oAyMcsmV9naOmILuamU8JvZtNpTr6+uivt4/NBdnInWMZ+i
 HvjGSB/NN70sKTH9ks2+kqT0Jz/HsZCbPzxlG18d1D5REjmxP/d7OS747JAKxOJvi7ysFCTjxgN
 IQ23gE2UrZn3eB02S8iHJHlx6iWMjYJjOZq9Yow=
X-Received: by 2002:a17:90b:578e:b0:356:2eff:df05 with SMTP id
 98e67ed59e1d1-35965c9d15dmr15619743a91.16.1772567274291; Tue, 03 Mar 2026
 11:47:54 -0800 (PST)
MIME-Version: 1.0
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-15-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260227203627.932864-15-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 3 Mar 2026 12:47:42 -0700
X-Gm-Features: AaiRm51FjIieZm3HPTFO2fwXwqvM4SG3NxwMok9WjxG0dh2LVs8p3Zw3WlsTLLM
Message-ID: <CAATN3Nrs4hYPQGHx3sTt_0g-fmgeQJK7GcCPFbP72kOCWFvVgA@mail.gmail.com>
Subject: Re: [PATCH v3 14/37] target/hexagon: Add TCG values for sreg, greg
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com, 
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng, 
 Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000b98769064c23faab"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pl1-x62d.google.com
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

--000000000000b98769064c23faab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 1:36=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/translate.h |  5 +++++
>  target/hexagon/translate.c | 16 ++++++++++++++++
>  2 files changed, 21 insertions(+)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000b98769064c23faab
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
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/translate.h |=C2=A0 5 +++++<br>
=C2=A0target/hexagon/translate.c | 16 ++++++++++++++++<br>
=C2=A02 files changed, 21 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com=
">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div></div></div>

--000000000000b98769064c23faab--

