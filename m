Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C59CF4181C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vze3d-000869-AT; Mon, 09 Mar 2026 13:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vze3c-00085s-Ip
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:06:16 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vze3b-0003u7-2N
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:06:16 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8299f1ca86fso1500576b3a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:06:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773075973; cv=none;
 d=google.com; s=arc-20240605;
 b=ZzlJhic4RP/I32JtlAjL8+46tbYvxs1TDhwiaZHIktEshSqTzyv5QXYEBEnGEZcKpS
 8i1wYbhQ81ryVvNOhWdZJBR0Or+caZZEeJyqWbzLFHA4gcLFwRHXr4C1pkswCfP781Gw
 9H1sfrAsDx8QPAprOVlBsWWr05AtQrCW5Np7OTHGDEnfFhzIFYW84vGUZnn0W7q4UvZw
 3V2q53bUt680WfK5DtC9E9J3W2OTtKoNK4OZ+MNYaRSzIjR86K+xMgcBR+DFfhZZe9GS
 ibuMquE66SxVlN/qrZIuaQ8IXF7VodanO62dHUmXBW7IGCfnO+dPhB0sNSk7ViZU8hLv
 QJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IQ8s8sksamNTxVllpkO+WAwazdsgypX9bKhdnDfC4p0=;
 fh=KRCCjFQNjYXxmVm5lhBeSL8Cxa/V2Ufkjle/+cdDqO0=;
 b=YsSMbVtBDd0537K6BFDxLnJefRSoh8XZys/dn/lAxdyOreeudjCYjkdRpj4zvho8LB
 dc6mI3CexcghTAFCBniU6lkGmuqVnVk0nhA33IHyUwsSAkg8rNfM/8pL6jhSoyyeUx8o
 /SDmXieob48ii9JYbxLUwuXEJ+gdgyv7xkmnVJk+mpD5+v8X41K/xjICOCuSB7liEB3r
 LJCJlc5NVMvl7LdD9KYIJ2LwQvzTJr2gcLuuMtXgJplqLLU8pbgut39oOlDp0fJ+/0uU
 7jPYYEF3NSX7UVMkoie+IJaPjK4NFEQK/YhfYBVzkNl6aG+2j+A3NeqCjTNHaY37HKZ9
 ntTA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773075973; x=1773680773; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IQ8s8sksamNTxVllpkO+WAwazdsgypX9bKhdnDfC4p0=;
 b=X++l9BPO+Vs6LMsC1xoynUHKXWoax+SczT8vyQr0qE5Jed8NLlkJfD5ZO+vb/8nIH9
 y90aF0tH3QbMRV9slIXWCknWTiiV3Rycf19ryZ2h5MJg1q/8fYZqLtfNDlRwRKVGlghE
 P6vBKFqBBv/BeIavjAk98HvFOex65OqeRzhpu0R/vrQ76du+JzUx5gyVdmZByR+aansX
 ngOONMK6U3b3Z5bQqetDA++ffR5+1V6kFPfogY8BTcR76x7X3EHBmSSdPDuBV/unjbhQ
 bQat55LGpV4XccYI5k21b23eweFbVMbVkF9VdM4vC2rQfCYckQNRLmKK3FserwAnik7w
 jBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773075973; x=1773680773;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQ8s8sksamNTxVllpkO+WAwazdsgypX9bKhdnDfC4p0=;
 b=A14VQE3W39FcagU9vIrV7bqLOLbWrnfIvKNIiX6li4utwBfHDDg1h7TK5P1O5HJb+Y
 WRrS4VcFODzJ/6pXZHc/Mv6BY9WN51gelBiv3uNeD/h4mPI9n+N0bCHQ0voZ8XPcIh+F
 QssrNyluQN7d/cYQ8JOeJf3p3SxAjRejgb32O62VZ/yRbqvsfAB7pRzhdmQPT0EbhDjF
 wXpIaomlm+lcppJWkmJDo+KYrNpbZilrUObzMsFyYFR9vjI/xiJ6sQg0OT1XuJAeHdgu
 oN6k3hw6oy5pNwaasFwcM+KiyAYM6uRIpKGPlViXZ9uF4HcJQVVs3c0IVoWGUxptRWnz
 8onw==
X-Gm-Message-State: AOJu0YyYAvgAqKIUmWgbDJZFy1/iaGDKFWq5OyPsho2ZuQNjZhAh2gCu
 SZe65dUP5UuXaktFtiFDucdEe8WEhWbi4+rcLGiOR9J1GDNRk5IrJlaBe+piDXShzf8FWDHQmOj
 W1tm0fl6HE9Tj5Ib3ptT8mAYCxGEfwEE=
X-Gm-Gg: ATEYQzx6I9+Y3k0GCA6cGoTB8kWvtEbmAnsqawrp20qXNY/65kVdVpVsCGgtKSjTp7A
 C37qD6g4ZfHtSlCXkCHqrFd36hH57dBe6QvX5u6JlkClsRl+3HQWq7x+0a2g6mntnDmEm7x4Co1
 FCCDX3epDYqXB8/IhDw9MytFytBShf3yviAzpVWOVDbcqErcw8R7pe9sdSBlh8wunpBaOvAYQvx
 gi9xhvqpokb9/cv5A1AWtwe9a2CvaXmH+ANviSPNLq/LMUNxpbynP8fhld9tWo7q+Tvoois7MaL
 q83eaduX2hthylct80b2eeBGt+Nop06GKuHjrQ==
X-Received: by 2002:a05:6a00:9510:b0:824:98c5:ce77 with SMTP id
 d2e1a72fcca58-829a2d87124mr11612422b3a.7.1773075973039; Mon, 09 Mar 2026
 10:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
 <20260309144822.877695-4-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260309144822.877695-4-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 9 Mar 2026 11:06:02 -0600
X-Gm-Features: AaiRm52QZhsEoFmYc1STdpl8iTugjRGR4VzJFgi_mFcUwBB2Bh23IWDSEDeeRKs
Message-ID: <CAATN3NokiO=nEGWL_6EK4bY5wsKp=12FqXeLjt_2zOq+CRU6QA@mail.gmail.com>
Subject: Re: [PATCH v4 03/35] target/hexagon: Fix badva reference, delete CAUSE
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000886a84064c9a6b45"
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pf1-x432.google.com
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

--000000000000886a84064c9a6b45
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:48=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm.=
com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> The BADVA reg is referred to with the wrong identifier.  The
> CAUSE reg field of SSR is not yet modeled, we will dump
> the SSR in a subsequent commit.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/hexagon/cpu.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000886a84064c9a6b45
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 9, =
2026 at 8:48=E2=80=AFAM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qua=
lcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mailt=
o:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
The BADVA reg is referred to with the wrong identifier.=C2=A0 The<br>
CAUSE reg field of SSR is not yet modeled, we will dump<br>
the SSR in a subsequent commit.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu.c | 11 +++++++++--<br>
=C2=A01 file changed, 9 insertions(+), 2 deletions(-)<br></blockquote><div>=
<br></div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsim=
pson@gmail.com">ltaylorsimpson@gmail.com</a>&gt;=C2=A0</div></div></div>

--000000000000886a84064c9a6b45--

