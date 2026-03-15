Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9046610854B6
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 00:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1YwE-0007TH-Bm; Sat, 14 Mar 2026 20:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w1YwC-0007T2-OW
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 20:02:32 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w1YwB-0005KB-8d
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 20:02:32 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82735a41920so1295957b3a.2
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2026 17:02:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773532949; cv=none;
 d=google.com; s=arc-20240605;
 b=Ta3jKrb8MoHTovpwM7nWbBTVWWr/0okzy2fsanImzlEqhmsIeLdez8R0veTw+FhXeO
 1fI7L8z8UivyZi7XddRVw0FyjVFnS0ZmgfrbuBQL1+iWLRVP87gc9D9zdIp4z8nbZuzc
 mR6DkoRzYVtwEvREc+YUHcT0DbunsAG75aWgkzHroHW7ZfDgcEbCI64eimdil3wrJI13
 HgCiUbI8beVFcCe+fPEFqLS4GMXZ7B7qUpT9pTcaikXS87oH/rqU+CGpp9mHywDd7nA/
 DD+frK2U4imJ1NfvO9TuerSa8xzO/t6gbGxZWDpKVj7qOB/i4lnZ0d+IH9eS8LWwMVrJ
 fxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=110MZfbKQZmCSi6SzJ9d8wGapfSpf7uAnFkEcwQyJ/0=;
 fh=yiUwoBOEypY2fM3mHrz5u4mbHkIidyv/b4UPGcEpz+k=;
 b=Fl7EQuTV1UbyYe3skUK3Grl7REUOXPfbo3AyWfEAB3zqp0GkSGE2D5HKnwZ51nN4z0
 NpalmSodSiTEt8pVdi98WSB0cBgP5P2+Q6lmgJHoKUML0JQsYGtRXA2yUSTx+8SWeWfs
 bLU288TxlWPH04eRSBADkxRcFaopWQ4FCcTeZ7dm4mlnTTyc/J2YiwMBuZaTW8Nnq5vD
 fEE/BFrRvH+wHH5MpFDoF/3acpuxj5J3oWiVVFeltsc7V+wfMomXp9B93Ns/iVVN/WvY
 rZrsd16rWZJiPjRIxLMVX3W2A9MlYgJA/IlferpLWqmZvjx/30dwE/vdyTigGdcv+6Iy
 Z7Gw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773532949; x=1774137749; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=110MZfbKQZmCSi6SzJ9d8wGapfSpf7uAnFkEcwQyJ/0=;
 b=JSwfZ6zj/TxEZ27h2zc+d1CT6S77LT0iAFlMexlyp4L79I7C1534h1SAR6kvurbQzu
 3gG0AHKND+7keHyOtvqeXFV+ym3SkO61rXM6NarDOyAWW3Xc8VsHCOBNjKFsOwPFs673
 n+wXQGoBq+BTJy4HFzkShMg+hiVp76qXFdVxbMlkqvjiJMNGrq/29bDFyxsC+HlmTlg3
 tQ5wTaFsLKoQKCD1jLxt2VGlrERJmTfOUQlh1zepV+0KVM+B8AdnJBrK9iWcktrAolo2
 0ZGFZ6DkMwUVy65ZzrcKFcS85ylHs6DxtJRNbXZoo4Yxy+cns10Rfghma7/B11j8ghfF
 g6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773532949; x=1774137749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=110MZfbKQZmCSi6SzJ9d8wGapfSpf7uAnFkEcwQyJ/0=;
 b=mPQG+pbCEHAy7mpI0r1+V9SWptnMCbqAZLBhiwVsSfTsP2QJitqsmM76DrGaA+6b5R
 I/azz7Clfdfj7mnkncyLelaNXf+Q5XzffPPb8zftQv6i2Yh7brYEyvyFZzWXaAt2+3yG
 9wmgQHEFZ10A9PP8Zi3Afo8NksOkjKTB5NnHFXjmG0dDqHV/rZ0h6mvD6Ilbw1kEztEW
 JbikBDt1b40C0SQPN6/vRf/TK0MkWhVSCRs0rxS0LL9zJ9vre5FpKGJFR6mlLuNpbkJE
 pUhkZ80+iAGIn/tDmj9ZChhLsWHrZF44qZbikQb4P8fsh8FdpekC0JhTKZ8RNYZZ/m7N
 /6lg==
X-Gm-Message-State: AOJu0YwCZ0attbDvB7b4XrQ6aWd/MXS0kbqlTMowJv3T9ZxSDPEczQfr
 5jsOIET1WhqHm2ncPsM3NiLAt2GrMxBsDTCY6EaGGoab61jQfCqUxG1gDWTodkdCFAP1m3Rtho7
 u/l2kwYVE4Em3OMf5pBE6S/uRpszYNCk=
X-Gm-Gg: ATEYQzzcWoxa8kOfsedvhiET0jExtDVdLOXu4+rmQDnxMtWVMKmyU417QrLZ5QIzXSv
 2CPItx140dY8Ws3qewnzzxEa3eh0At+YzuWXjkKXDVNyeZPZDM1UqqppF1exiIVpy1fkedmdHja
 xn/d4/Hd5yt75qXuBLszB75LHJ3+PyPDfy0LQpES5ojFZuCfsIBGfZiqimw6LuBL1P0F6/j995n
 VwQw6LR+Aw5GIMaVPa/7VL0qf/RWbQ/Hyy73kcCjG08nG0WWgLLJmNTgKcB/Gc8Ppzum1hOEt3a
 62ZRjERcAwS24hwrrADTxJNJ/J79zNtLAKHlFkE=
X-Received: by 2002:a05:6a21:138e:b0:398:7b7a:3731 with SMTP id
 adf61e73a8af0-398ecd9fea3mr6903714637.62.1773532949299; Sat, 14 Mar 2026
 17:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
 <20260311040758.1068731-13-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260311040758.1068731-13-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Sat, 14 Mar 2026 18:02:18 -0600
X-Gm-Features: AaiRm523-Mi8LU5wGjugvgk2q8CNbBPk6RQGynKOjJNpx2KMPrqYY5rZACWP71w
Message-ID: <CAATN3NoaPgo6gKHfnFgs71QgZgZK7j+fsPKRWd4a=dSesZJmbw@mail.gmail.com>
Subject: Re: [PATCH v3 12/32] target/hexagon: Implement stack overflow
 exception
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng
Content-Type: multipart/alternative; boundary="00000000000070c6e4064d04d14a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pf1-x42c.google.com
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

--00000000000070c6e4064d04d14a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> Implement the frame limit check for system emulation mode.  When
> allocframe computes a new stack pointer below FRAMELIMIT, raise a
> precise exception (HEX_CAUSE_STACK_LIMIT).  The check is skipped in
> monitor mode.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/helper.h     |  1 +
>  target/hexagon/macros.h     |  3 ---
>  target/hexagon/sys_macros.h |  4 ++++
>  target/hexagon/translate.h  |  2 ++
>  target/hexagon/genptr.c     | 18 +++++++++++-------
>  target/hexagon/op_helper.c  | 34 ++++++++++++++++++++++++++++++++++
>  6 files changed, 52 insertions(+), 10 deletions(-)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--00000000000070c6e4064d04d14a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 10,=
 2026 at 10:08=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.q=
ualcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">Implement the frame limit check for=
 system emulation mode.=C2=A0 When<br>
allocframe computes a new stack pointer below FRAMELIMIT, raise a<br>
precise exception (HEX_CAUSE_STACK_LIMIT).=C2=A0 The check is skipped in<br=
>
monitor mode.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/helper.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0target/hexagon/macros.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ---<br>
=C2=A0target/hexagon/sys_macros.h |=C2=A0 4 ++++<br>
=C2=A0target/hexagon/translate.h=C2=A0 |=C2=A0 2 ++<br>
=C2=A0target/hexagon/genptr.c=C2=A0 =C2=A0 =C2=A0| 18 +++++++++++-------<br=
>
=C2=A0target/hexagon/op_helper.c=C2=A0 | 34 +++++++++++++++++++++++++++++++=
+++<br>
=C2=A06 files changed, 52 insertions(+), 10 deletions(-)<br></blockquote><d=
iv><br></div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylor=
simpson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div><=
/div></div>

--00000000000070c6e4064d04d14a--

