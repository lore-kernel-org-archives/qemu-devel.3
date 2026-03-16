Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CEEF53D7E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 17:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Bx9-0008Rg-0v; Mon, 16 Mar 2026 13:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2Bx5-0008RD-8M
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 13:42:03 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2Bx2-0006wx-R7
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 13:42:02 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-35b98def50bso1088663a91.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 10:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773682919; cv=none;
 d=google.com; s=arc-20240605;
 b=EeOogKpLLUxdAInNLIGntNf7ZUPBnYdgCZkFmkRiRHYtmcooxqZ7Y+F1UkNp293gQq
 QCp455++DbhAaHrSfr5A90st+4zx7+KHAdGws+9Hv0eqFYeJCrKsfBkKpfsFZEOoq13h
 JCQOHzGPnolN49A27XHpmglnO7fKCSIS1p7kQIqn08jAsXRzj6TMVRxVvjOOrZiv8qjd
 wja1OqkRDk6X7sXANgB+ZRSEy11MgaYP/p7qFVVAh1PCkxdN5HX5mEAJ2X6lQ0di4Zx8
 kLcJFWVGU5c7KzTTYDMNu5+eOhsrIdmUZQJSkE1SGQOhlvC1c4FxTLt6KyXmAO0b1jCA
 NOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CG5ZKClebSX2NVAiNNXqEpuL33uPLBFSeH/5d6AXJjc=;
 fh=KRCCjFQNjYXxmVm5lhBeSL8Cxa/V2Ufkjle/+cdDqO0=;
 b=MUOlkJ66Hw1dtgc//xlMzlT0okfyK3dC4a1DAvtRzI7E8DuDiZNeBDdi7Anq92dza+
 nqvmzG4/9laYDEYjk//2oClUm/GsceUsXCGVh91U6dOh2zLDu4xu0BZh9ApSjYcqlm9y
 OW1yKevV//dcRLFRqCyLt6Oo3+BdA4Fmc8CKR69Z6yH1zhBn98yMK92pWQYZVsZ0IciW
 I3JHtf0P7/uetgCP0FAMTxP5mYrME5OMlajDB13FdlrHU008oO3NQh6dcveW8a/XIZ9u
 loK4hf/hs3U/e4gyhoaUnWzUSbHRKqZAvnOxXHeAKlLzkFj9D8ZGWaWgNV9R4hQgHN9S
 wc4A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773682919; x=1774287719; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CG5ZKClebSX2NVAiNNXqEpuL33uPLBFSeH/5d6AXJjc=;
 b=Ujt3/XvtbcjVp4O7MCbfNOBXAq81AlpBEAjehyQXDVQthvBCQ5qp7flQwnnEZvpJK6
 iSxPFSEHL1Edjyylj6Oe4Mnq4EbztveIerIGVQOnbBKLK9KnjAET8Fj3MPlAc3Rvw60j
 JsO4im53A8LgIZ+qoCbaYuK1hrTV2Xpd3ZJSZUatxn7aADE0hsLu1wIy20TtCK68mFWe
 wPa1cG3EVzDZs0QDSapYZ1DuAX1flXahbMC0fugews94u6kiTW0jot/AfER4p3yvk2DP
 H8xTTZ2DrWoHtFzNxeSjC1vvoUTiX8WDuqf08yFPWwsKZLi4PPEbjUEETQcYswT70GZt
 aNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773682919; x=1774287719;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CG5ZKClebSX2NVAiNNXqEpuL33uPLBFSeH/5d6AXJjc=;
 b=XtstMsbYTB1KBE3M5gjgOiF/V8HBHpH0DsvO78NF1uoCV3RW0lLZ6O7eR3ahPte2GP
 6J75qukLibDmYXEmAF7XudQ/15R5RzCaGGJGrVdN6qDh/MSeS6iuUcBraCSmWh5/3RI6
 /WNiy8Fjpn1t0xXztiixvzBJRefS9FN/exFuc2SapNblUPn738wRF9xi7/yn4y1jufog
 r5g9M64sK2CgRyN7LPLP0dTvUgcvYQyvLzPNbh89KAX8hFu8bb4sGHhLI3vhip30Rnqk
 KcY/bpNMFgvkeNpZ/7pYbFNa+XQHY95jcUwDgOFHywburI4c2Tby7ZLKFiJVRtTw4M1/
 zp2w==
X-Gm-Message-State: AOJu0Yydqj4ymwFF8gC47FQSUtRH51ZjVo4QXODnOLZD7+0dmRedFzWV
 U0TbZ1jzygmZRwwO9rOKZ8bIszFmR5SY7bbyaLAXEqTu5jcslOwyeAF2UEYy6zGUPrX4gCVsJzI
 4ghrKuXajnj8DyJppgfYHbRQfV0H6zag=
X-Gm-Gg: ATEYQzzC9SURIaw1lczvQ1kuyMCvK7cXAyVp1rW6ztS5KSGYWOnyqB05puZBuQBh0pz
 QYi0T7YEfc4bX7I5l/0fr4mc3BMkStCDv8Ej/WAUCHcCOpWJxl3LY3D3GhDKMf8OuZUvJlyaCqY
 9MKohIwn+Pp95+8t8F1Qzwscf5EOTMk1S1vwQdypbYJpqv3X/Eutfy1/rHb4jMSQlMo/RZ0/igM
 xJKhl3xZ484l8cyaB9N7dk7UbdQnJrU42EHhjjT/EZ0iMC6yLV8OC5PwARChmpfN1IDo5rNU9QW
 ur7nM3pz5pOltizcvfq2BKS3x1LUj0V/ZnOd3Q==
X-Received: by 2002:a17:90b:2784:b0:352:ba0f:fb28 with SMTP id
 98e67ed59e1d1-35a21e4ee53mr13302851a91.1.1773682918822; Mon, 16 Mar 2026
 10:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
 <20260311040758.1068731-27-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260311040758.1068731-27-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 16 Mar 2026 11:41:47 -0600
X-Gm-Features: AaiRm53URhuZYnAXB6l8qZMOjx-WZHLOimfhguYSC_wtZOzLNscsvO4LP4Ss9Mc
Message-ID: <CAATN3Nq2iuXaHeNJQmK2U5ZeJ6U0Y+Sjh+m_9+24hHwQ0Wat5Q@mail.gmail.com>
Subject: Re: [PATCH v3 26/32] target/hexagon: Define system, guest reg names
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000521480064d27bc4c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x102c.google.com
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

--000000000000521480064d27bc4c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/internal.h |  4 ++++
>  target/hexagon/cpu.c      | 29 +++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000521480064d27bc4c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 10,=
 2026 at 10:08=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.q=
ualcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mai=
lto:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/internal.h |=C2=A0 4 ++++<br>
=C2=A0target/hexagon/cpu.c=C2=A0 =C2=A0 =C2=A0 | 29 +++++++++++++++++++++++=
++++++<br>
=C2=A02 files changed, 33 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com=
">ltaylorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div></div></div>

--000000000000521480064d27bc4c--

