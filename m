Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84B1EDEBF6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 21:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWsx-0000e3-K8; Tue, 03 Mar 2026 16:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxWso-0000dR-F7
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 16:02:27 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vxWsm-0004a0-Ne
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 16:02:22 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35984cd0335so1274564a91.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 13:02:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772571739; cv=none;
 d=google.com; s=arc-20240605;
 b=g6P2BHSi9jHUNnMFdlUrEJdtvwWUp/3JmaWUnTPpMwkLHaRuAIlZILHaM4zq09+d6Y
 he5TSZ6zdFNm/Ly15WkR/7fM9Uj5P1wpHWdKzEnTV/Xxc0kKlUnGyiH0Hiqs5KkFqhnV
 Ey0ETE2/CIJij2mnRmD2vPoUByyZ/BZAaUQ9u4PVeox2MAs0pdNkvpO+1k8Yax07/REw
 UvGxMm4t/E6GlEPQgerQRlNSlJpbUJw01ti2+JDBRogWLNWu63AbU6AI9ourgpGO9+l1
 jkHJKPwuBYt8B7fIBcmSKw0sM68hdbXjJeGLNGM6DEytdcxlpyp1Gbvad6NiEQ0b71sI
 aGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RxpDWKPp2B6xGdVyFDOhwm2m4lh0uPPEJenVqDjPxfU=;
 fh=3N4YTDWV9KQk1Zfz9qwlmnoEsAk4PdvYntvEBJFMlvI=;
 b=EOMqOzsx3OkN5Y8uLvEtqOtrRZo8+NGiKCz4RxuU78dJrfwPqtR9PAs8UhCQ6oAbAp
 4Z/W4A79tKsCOMGMolENKSWuIkA/v7H21wzCCpgDxD7DER54QmrD2DEPYBHUU5Av9MQ4
 yG4W7/EAQSLlK18urwtvNfT4K2jIfzx1NUDL+D6JWnzKvdRLSXpoTEcp1dmfSlETIywA
 UpoZrQ7ejgwfR4r0bq4fOiw56aeWuAS6gAloav2ZAM7YxS/IS2/xwx77Q8aI82YYIgUh
 j5LzZiFHB0s8OetFYYL4RqSnj8oU32+pCOBhRqHckCEG7eYvf24LEgWwUECH54D96Qjo
 GNBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772571739; x=1773176539; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RxpDWKPp2B6xGdVyFDOhwm2m4lh0uPPEJenVqDjPxfU=;
 b=JJKH7TN1r0ooMm/h7hSgoohmKvh6WqVqpkbFc/aOeWP4VW/3kxFD9a1LU7arIkVF/Q
 VaU2AllR5LfcqWBYHWufeFvHrkDFfbKJOYzSgOOynytixt5jaPnMrNym3jDg1FWBrHxC
 ObRjqo7zEWmP4KgEpPVUUGtjqTpBypdWUT0pVAoqOJ2jLnJwrpRkGc4vdMjllpCwGHz8
 V9L25mf2IUrpywqsTQGLUlT406Lo6h5lPF3o5NS4SBZ/WwE1Qjm9Py4Jc95QAYllJMQN
 c0cT1Zusb1P8db9zIq91dDgESK90PHHofepn20UwfR6aHQDesDGALvCTtqmLL0UG69yX
 NjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772571739; x=1773176539;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RxpDWKPp2B6xGdVyFDOhwm2m4lh0uPPEJenVqDjPxfU=;
 b=udRWPjAstKii+K0UjnhoX8OGauguMGniqifD0ezMDjzvsXla28mxvPmsCkWGglNnl+
 xvmgNuH2LBOXMEsxpTmiahk9+VvFgCueeusReL+T0eHODh/tX3Qxz7EzuLQfRE6/QUYg
 uPu0Jq/cq8RWvlRGaTPRona87WkQKLjDy4Uu2IVuBYt7557I8IX0YmiR0mjNByQE/7qv
 UnJ3HkcmQqBHqJtSoVw/U/fahkdz3RzQ7MC8Esi+ejV0H2OuQ8aZURLnoiax45r2uI+m
 R+8S8t8y6m0Tdjqb9pQh6OFrP0FWUU3iddJS8Jo4GOg8oH3ngtDkr8ym5pD1egXaNe/3
 f/zg==
X-Gm-Message-State: AOJu0YybKff8mKoY29IpSYz9lH9rg4xgqyA1csHwGD+25ulVCo7VUHoJ
 DgSYiwIorVc/wbt11pFPv5y3YwIXe6R9b+Mfax8aDrWJiF9U+JluJbXX4N55yuwiBT6F1zAyHah
 VZxN73CgLbkMin9dVxyT2VhGM47id6Hs=
X-Gm-Gg: ATEYQzwnbKEDEJ0Lmckj86eZaUBeFmzVtu0T5SBwK0fwJIp+X+ytWy0UKa0fwyvXOG/
 MoUOthG7GrTb/5vpSj4CbkWFxFZZ/CRhriAuc/dPUqsr2NXg/c66wjfEF2ZRBaEXc1TK1A3xOU0
 5eUAGs6Jem/gGNQ1LVJGevA8FsWW4cBfxjP0aVSFMbtZj1JLImZ9DmZdr5h98JmvI28KBLQQ3/z
 0cTeVY8DH56w6hMof1MUgNfy6LRKdy3X2qBkyjnW0/WouhZojIA1UWO76gQOYtC8wNBNDVYnEw5
 Vb0WofJmp6ZHQpNpYBEMyoyp63MR0bNGiZyuhAgs6p0AblFDFA==
X-Received: by 2002:a17:90b:2d8c:b0:34a:be93:72ee with SMTP id
 98e67ed59e1d1-3599ce3e35amr3353756a91.8.1772571738785; Tue, 03 Mar 2026
 13:02:18 -0800 (PST)
MIME-Version: 1.0
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-25-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260227203627.932864-25-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 3 Mar 2026 14:02:07 -0700
X-Gm-Features: AaiRm50w8fWxk3PQpupN_d1njaW-DMZ_NvEPZpzeH7qv1ShA7eT7xE-wnyzfYgc
Message-ID: <CAATN3NruFujF---So0mT6rVk4A9ULAjkH8Sjr99URRS3WA94xQ@mail.gmail.com>
Subject: Re: [PATCH v3 24/37] target/hexagon: Add system reg insns
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com, 
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng, 
 Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000d449ac064c2504e6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x102e.google.com
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

--000000000000d449ac064c2504e6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 1:37=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/imported/encode_pp.def | 128 ++++++++++++--
>  target/hexagon/imported/system.idef   | 244 ++++++++++++++++++++++++--
>  2 files changed, 345 insertions(+), 27 deletions(-)
>

Acked-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000d449ac064c2504e6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 27,=
 2026 at 1:37=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mail=
to:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/imported/encode_pp.def | 128 ++++++++++++--<br>
=C2=A0target/hexagon/imported/system.idef=C2=A0 =C2=A0| 244 +++++++++++++++=
+++++++++--<br>
=C2=A02 files changed, 345 insertions(+), 27 deletions(-)<br></blockquote><=
div><br></div><div>Acked-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsi=
mpson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div></d=
iv></div>

--000000000000d449ac064c2504e6--

