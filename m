Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE25FF8860
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 15:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGeX5-0006iT-CL; Sat, 25 Apr 2026 11:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wGeX4-0006iL-8Q
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 11:02:58 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wGeX1-0006Iq-Ut
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 11:02:57 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c79662bbd2eso6049964a12.3
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 08:02:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777129374; cv=none;
 d=google.com; s=arc-20240605;
 b=WtYBrGMM2x1Yx+KDizl3gIwLrTszjjZtHqIyP7CdA4A8VC9lg0TQHXtS8SsYPKVgua
 R7TqU0cP13ZCJRTd0v2iif6D8AvhNhuOITRpJ3+R0t6MfJQbZmIdry2XbokFjTDm2uaU
 vMPGAmU2A13LB09dr+DTcLivVwsfUzi+pV5edx2lT2go9I9JshxN3BXm9u/ImFoJYBVY
 5sBUbx7t3CPwOJ+5Efjxqdl0XRZ9aex2PsbDP7MmB4KjEy8dlflXA6Ud/YWYjKcIlTIW
 DqSvCUgxLMShokwqBlc/4kP/gw0g5zAD0BPTp/hB9KwTjmPAEUtSY5BuNRlQuFIU67KU
 Nmzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jMMT1JI1Xukj9L4vlN5vBEtFT3jYMw20B6vz0Tms7C4=;
 fh=SXsYm+zwLdRpWG8a44dX4f5SlOqjDoYKOEXJLqRtgbs=;
 b=PI3W1EfO2N+wJAl8gGEqW5Qfx7+wIXwiP9PXZc/WxtkGNKhLMZXJyoLmAbOqn0FQdJ
 7iHFlbVusKT1ZYdfr7Ok0IraIxXyYqFOK1caKJF7+V5qaSkQfkuYqQkXhSryY5o8QmI8
 4zXCs+1PUInfuTfUo3J1RRaBevzcwZC/m0kECMlrPNHjlw5pTFsXZBI7GFzK/5Ljf4m2
 MCd65YlLc2ZyyoOrX7bQUHr0PbCfD3afTsEo08EWyxZ5rcgCkfFk2KREokUHLYDWnFBX
 TKKCnWcxV0zr0mUQ9crtPhPpXMBRnSUXLmV3J0iuK2hz7asfdiafc3ykfADoUJPgeB1h
 MBnA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777129374; x=1777734174;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jMMT1JI1Xukj9L4vlN5vBEtFT3jYMw20B6vz0Tms7C4=;
 b=hXvHsvLnlMurF/NQ6AROx7OoYSWaXC6dHVpQyxAOf8GzEwSQpdo8DrHv97JQHQ3SEo
 rlYqLv50HLvDuV+CA+Ugh8pmbtqk7p4nRe/9zSXygjcdjlW53d82UbIOI/2WJgHZQFoR
 p/k4ciucedxvYjaE+JWQngk5+8NJrNwn2IHzx9Wwyoc4i6cStepYUBWSO8ZqT1mi0QYr
 PP+9Slft/ooEOXa/6o29Z58JgnTX8+TmLDce4XbbHwhFuuXAaP7lytUCIGhRpSzicjSa
 mJgZyXjk9VBdBDdBP9OikoRLGwXB5cF/CaBOBu4JGcriaJqV28nGh4l3poIuckeDPK1O
 jpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777129374; x=1777734174;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jMMT1JI1Xukj9L4vlN5vBEtFT3jYMw20B6vz0Tms7C4=;
 b=RAC2Yt/LgeoHhgUAQGxVxS0ArjcXcwHzFcuB55CxXE3AP4Oo81gr3BN/Td6092FhB1
 dYjifVDqsQaMNHO6qGJDQy8MlTiEe1cSCYRtfoovUizPurFtOh5Ca0YnWV/vhvA6v8sg
 UrIMjdRRuFiAZOWNBObXtyMp/rQFic5qysl8wy7ZDnIW95yAdQ3ict/brBVfEYqPj2tS
 R0u6sPkgDU6JpXTYbs8iC2IGZVkTuRHgnwoOmSz5ejOHikrjOM71pWyMGUXQtH3KG84n
 ONAnHPsmnK2OmDMo0yjkRSO1oMGzXqcEBRGkRIAwSsEvORu772DDNd1Sx6K4oaofXY63
 EB2w==
X-Gm-Message-State: AOJu0YxA1CDCkFZliJ2wZJdJOuvHinwMhET12u6wDgS8WPBbib7niBzG
 kwe4CEx9eg9ewTyJGmDZ49jqXz9E2yuw8KkjRIc17wYJO/FgdipBHvchUGEs5IRC3ybwKVg7ned
 khV4ZAi96++GOB7ed7BprCtlSvI9PHI5UDfSL+EwkYA==
X-Gm-Gg: AeBDietpZ2jUxT0L7PJ7yb0BQhAxCtI/jO5IXaFBITvHv6aNp8C1ZPtHuz5mnGCDwny
 lWyOvt3rQDq6q/L6TvaIROe5Lp/zq6WBJRhq8yYPR6006wzKMrwkLKb6cLSbKBbb9CK5pSKeolo
 NmxFPEcLdx9tgdTF9wixBGHSzd/nQ73Na8q5z4/JdVYRq0bJRdOGPnfCEy3naegN6CnSmjZusrz
 3zZMeRQuHz/EHA0AH5R2wOVo9MRRHfg2aWulJeOKXTooEGCzSnyxfgF+GVERafI1SvxV+5vEWFX
 Us3j+QEsh+DNuz2cHIPombcSm7T3mzBswwi3Zc+Cvedu8RI=
X-Received: by 2002:a05:6a20:3d06:b0:3a2:d79c:416d with SMTP id
 adf61e73a8af0-3a2d79c4427mr29517185637.43.1777129373472; Sat, 25 Apr 2026
 08:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260425144852.46590-1-deller@kernel.org>
In-Reply-To: <20260425144852.46590-1-deller@kernel.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 25 Apr 2026 09:02:41 -0600
X-Gm-Features: AQROBzAPRVzx2Hf9F8aoLv0r1rTR7WCU-Ebk_O1W6xVxxwQ11RyxFyD4dB6iZL4
Message-ID: <CANCZdfoOPvn0JJiF5Nar_UNEWMzmQCvEiTKV1vbuVFy2qiMpfQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Flush errors by using exit() instead of
 _exit() in error path
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000006a7f506504a2d79"
Received-SPF: none client-ip=2607:f8b0:4864:20::534;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x534.google.com
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

--00000000000006a7f506504a2d79
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 8:50=E2=80=AFAM Helge Deller <deller@kernel.org> wr=
ote:

> From: Helge Deller <deller@gmx.de>
>
> Qemu user mode does not properly flushes error messages related to bad
> arguments when exiting (at least when the output is piped to a file
> instead of running on a terminal).
> Ensure that we always flush by using exit() instead of _exit().
>
> Reported by: Tobias Bergkvist
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2544
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  linux-user/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

Note: I've added the linux-user maintainers to the CC list for visibility.
bsd-user has the same problem.

Warner

--00000000000006a7f506504a2d79
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Apr 25,=
 2026 at 8:50=E2=80=AFAM Helge Deller &lt;<a href=3D"mailto:deller@kernel.o=
rg">deller@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">From: Helge Deller &lt;<a href=3D"mailto:deller@gmx.de=
" target=3D"_blank">deller@gmx.de</a>&gt;<br>
<br>
Qemu user mode does not properly flushes error messages related to bad<br>
arguments when exiting (at least when the output is piped to a file<br>
instead of running on a terminal).<br>
Ensure that we always flush by using exit() instead of _exit().<br>
<br>
Reported by: Tobias Bergkvist<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items/2544=
" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu=
/-/work_items/2544</a><br>
Signed-off-by: Helge Deller &lt;<a href=3D"mailto:deller@gmx.de" target=3D"=
_blank">deller@gmx.de</a>&gt;<br>
---<br>
=C2=A0linux-user/main.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br></blockquote><div><b=
r></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com"=
>imp@bsdimp.com</a>&gt;</div><div><br></div><div>Note: I&#39;ve added the l=
inux-user maintainers to the CC list for visibility. bsd-user has the same =
problem.</div><div><br></div><div>Warner</div><div>=C2=A0</div></div></div>

--00000000000006a7f506504a2d79--

