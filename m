Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C34F4181C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vze8y-0003f0-Ie; Mon, 09 Mar 2026 13:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vze8w-0003eH-RT
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:11:47 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vze8u-0004jv-Cr
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:11:46 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-829865a8471so4568014b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:11:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773076303; cv=none;
 d=google.com; s=arc-20240605;
 b=aWt4IShYCLv96Za6G8xjjQv3bqhbdwJpzHlaXTVOTfego7yGiCf/JI3iWkt053IBaX
 RsbHazEunK+B21vK9N7smyImkzHaZKhhCqGE+jDBUjur9OuoauSOPTsifbc3PQ3wJ5X1
 13KZ7wnsoLxJl3D7tC9ig6w/x5qPNE8YhrCwgE5kYhW6E29lszcgnyRxpjQrDHMMTHpl
 Dkm963138c587AUeq4myBBSOh9By14dH7BAghNndrzjLaXsQogZQZ8wRlMMZtkaPRwYN
 ag2CidM+sEMjJfSpjSO8dDxa1MU2VFrTsk3yFHcIFATEB2VYkApT6xGyNeg0YX8ynlqE
 hV8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0Z9hkZO+uCj/OzawKgOIoDxZvpUaRj7ek6MtGK8Yr8s=;
 fh=yiUwoBOEypY2fM3mHrz5u4mbHkIidyv/b4UPGcEpz+k=;
 b=dJEuy66DDiRIzgHVzhCNJJc9908u2D1r7Zem5R/5AAGcr9wT9gP7grecQWNqFam1Mf
 SfUYis0WDUWbccVqLb5TgRl3lM4LHYfbYq4aRmaczcxYhuG4Q6HfMpA2OdK2rujphOiK
 KOkjknevlTAwv1mfQmCrr5apk8GrfuKOKEZy/VBwe0W2x1Cz5mFb0RYatvypKEGJkw5Y
 7Gm6cUJm0TYtx2OCt471wn24XyC5A2ILjesqd3hB+G33iQ/KGBGTdH75JCwe5Rqxo1R4
 Qo6Hh2jiIrf9nL2R22xH6ySIRg24b2clZkVEu3uVQ8oWN4kjTnYK3erjgyZSbZrpqZsl
 ztaA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773076303; x=1773681103; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0Z9hkZO+uCj/OzawKgOIoDxZvpUaRj7ek6MtGK8Yr8s=;
 b=HRsvybORSZqNw5qCge0u6/rb5AHoWCF7iQvuBftoyLiPSqgsc2Q5V4vso75Ph006+E
 wVWpTdlIRpU0cJ0972wpD+rRBZvywojKNb/nOkZOgbbysU0nbrwx9DX4QgyDzeQ5A9zX
 7MZQk1XCz4Uyvlnbf2w7xrjm63mB/QdIBY9qZcpk30kPxcqP7LEQlm68ltxJaD8NGYh0
 9MhIc1vETojzunOSxAgblp9CKIBmR5+9Cu0dnnO9YuDL+kQVH9yBcG4HCMa7JNMxfOyD
 N0dZj8n+pUcyVa+uAhf43Ih86ypJGy4XjP+FdiIi93EkbcJaRl+Yagnu6UJ2s7pgAUuZ
 rOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773076303; x=1773681103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Z9hkZO+uCj/OzawKgOIoDxZvpUaRj7ek6MtGK8Yr8s=;
 b=IiE9rn8flhPVuVqpiamsZXv5qFUfGoyNeF80Qal+s3isRj5q+agQ5vN1xENUC8BNS3
 93RK9iQgZ5K0qOlva/oQAokzvBphcbkkOgOwwDCBRuMT7do2SEtvck3nxVbxkfhc4B8R
 uMoMIwg4CtCnDSRsv7SFOarvIrjHOSk0LtQ00+ow/UriHUXP1xL2t3z+3OxvoprMUqxi
 LMsjjZiXnxBrC1ckji+MP6zxM9OwRznhZhMUKR6zCZcsoWx4pjH4dYix2j26C3ig8ocz
 H0j4DFdx40yzWa7Dbmtt8kC5cy2B+WF9lWqpKZxEn8TwWWuONY5oMUHeimRmq2ICw97d
 M62w==
X-Gm-Message-State: AOJu0Yx87lWTHl4+ln5rXKAKu1nT25++vWPoPCNxDgden6KgH+gGXTLB
 X6SbnppSUhClXJvbwx9sH3M4AquDKWTOcyJ7A8V494NLr50gwB37X5ecoe6vsP7vQd4ptgtpS3B
 KFBigeDRCL80R+VaPQ02YvAwnCRdT2aA=
X-Gm-Gg: ATEYQzyw+LLqmVh3glL7bn+1tnBE60xKFVhemYzlIuCAaQA/wlkVXj9jBoePDtjuXLx
 iENbU97J129x/XeaSaa7q58UW2aaTNM9dolRCWHmsG5lpr0zpB/y4QCaCxsQhqPsH0HyqAV4cV+
 SyyQTM4sHNAbXQeQ1dRPhbfVhotjZfYPjYGkGeL6HuJ4gKVUAMZ82rH2fzAo0p3i2bnSVQhzIve
 drmd5hvbIW6V63Kohd2/TORqqAvxxJ+bVNcOlQPd5tyI/v31eJo9orontsTWMos9/vo79OWLjD8
 VUERo3QygUFnJn5AubsDz/yQdJGZRLshJAcbLyWhNER2HxgC
X-Received: by 2002:a05:6a00:1827:b0:829:7dfd:1c15 with SMTP id
 d2e1a72fcca58-829a30a633cmr10767203b3a.63.1773076302674; Mon, 09 Mar 2026
 10:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
 <20260309144822.877695-7-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260309144822.877695-7-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 9 Mar 2026 11:11:29 -0600
X-Gm-Features: AaiRm53QnjMWYI-rpBWs0KekFLozS7m31z4XVd-upBKRvjdSV3jgEa8uXEsopqg
Message-ID: <CAATN3NqyDZN_YJMf96O7cR8wQZXVwiYD9EOM4r4L0xuXmy_VPw@mail.gmail.com>
Subject: Re: [PATCH v4 06/35] target/hexagon: Suppress unused-variable
 warnings for sysemu source regs
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng
Content-Type: multipart/alternative; boundary="0000000000002e4167064c9a7f0a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pf1-x430.google.com
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

--0000000000002e4167064c9a7f0a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:48=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm.=
com>
wrote:

> The analyze_read() methods on GuestSource, GuestPairSource,
> SystemSource, and SystemPairSource were no-ops because these
> source registers do not need read-tracking in the analyze phase.
> However, gen_analyze_funcs.py unconditionally declares the
> register-number variable (e.g. GsN) via decl_reg_num() for all
> registers that are read or written.  When building with
> hexagon-softmmu, the generated analyze function bodies are
> compiled (outside the #ifndef CONFIG_USER_ONLY guard), and the
> declared-but-unreferenced register-number variable triggers
> -Werror=3Dunused-variable under both gcc and clang.
>
> Emit a (void) cast on the register number from analyze_read() to
> suppress the warning.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hex_common.py | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>

Better to declare GsN with G_GNUC_UNUSED.

--0000000000002e4167064c9a7f0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 9, =
2026 at 8:48=E2=80=AFAM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qua=
lcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">The analyze_read() methods on GuestSo=
urce, GuestPairSource,<br>
SystemSource, and SystemPairSource were no-ops because these<br>
source registers do not need read-tracking in the analyze phase.<br>
However, gen_analyze_funcs.py unconditionally declares the<br>
register-number variable (e.g. GsN) via decl_reg_num() for all<br>
registers that are read or written.=C2=A0 When building with<br>
hexagon-softmmu, the generated analyze function bodies are<br>
compiled (outside the #ifndef CONFIG_USER_ONLY guard), and the<br>
declared-but-unreferenced register-number variable triggers<br>
-Werror=3Dunused-variable under both gcc and clang.<br>
<br>
Emit a (void) cast on the register number from analyze_read() to<br>
suppress the warning.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/hex_common.py | 16 ++++++++++++----<br>
=C2=A01 file changed, 12 insertions(+), 4 deletions(-)<br></blockquote><div=
><br></div><div>Better to declare GsN with G_GNUC_UNUSED.</div><div>=C2=A0<=
/div></div></div>

--0000000000002e4167064c9a7f0a--

