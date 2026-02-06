Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAE9EE20B8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 16:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voOcE-0000aH-QH; Fri, 06 Feb 2026 11:23:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1voOcD-0000WQ-PA
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 11:23:29 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1voOcB-0007iC-VJ
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 11:23:29 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-59de0b7c28aso2768019e87.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 08:23:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770395005; cv=none;
 d=google.com; s=arc-20240605;
 b=gZgIIjBKQfrpETfcwT/F0iCSAv95z86GTEgX+dEscEBQ26q8WKaE2qh42agZj+Ks/K
 ju+TMHkyjXhk1qOWUJyiJ6aRJa0vwLeCv+rkQaoA5EeLh/VDkFPy2j+61arF1TVl6Rml
 Ig2xVA4S4YsQIjBDI3Vaw2hstnvqNLhp/d/RoN6URimws/d3KUBtADbP1mZ6KyBJaO6W
 nM8+aiicg6ic/WAgv1Jt02I5EVe/DOGnkDNhR9KNJF6+wyQeP4TQ7zN0O0nmA4mGY11H
 8VfvNhchps6VYuuIc0RAUBj624IZiOA7XwfRFCWo8HvsTAsPbMxELhrxs4OnknwFI4pd
 hR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=p0QRGAi0x+NGTcKQJg9S+8p7z91wf4oWNkMOiVNuiSE=;
 fh=nj1zBrHSZd8UgQxkqkJlnb1zN+Qz5l54wBM5MKHM7vE=;
 b=RLZAvnJIypZt63UsCRZ8lBGUHlSMsX8uRV7+AqRD7a4RlbxDawSvqR4H3h39dCCxad
 sMiLORh/L0o14ytXPCdk4mcO1Wenj8RFOgma9PRf1q6VxG7HGcIdrAKboI6hjCA8f/r/
 y+e8WWuEUY4mWf6mioKRi6Cm67+lE8WjB67p0+rF+NIoDnSe1gpZ6WBstFN8xg05Wg9C
 vb3ugXHnufwxowc0cskh6l8JJF4bF/aQlE5cpxndZwT7DLUsKRmuOal45jw93KWack8q
 2ghe6CYWonVDY7i3V69nUXEkUIHCmZOJW/HhzUW8IPpqofhxXwhKtS3m2JlYxQE583qF
 3iLw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1770395005; x=1770999805; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p0QRGAi0x+NGTcKQJg9S+8p7z91wf4oWNkMOiVNuiSE=;
 b=wgBinKIQOE1Gbqz1hnwEKgvoJf3AQUsZ8zqfdPOfXJnHleEnC+9oltbFheGVlOoowr
 VL4gJ08gDa/wezYovKpiuHVPZ2odcb8/sY2YPa3nYmYesryOovSm5zAVJJN7gF6BrkDi
 SGpAq4hSSPUTbTnYwDN0uj2Uyz+vYoIqpaUSNXph/RnD//dBfGyYjymXZ/QQG2HtHOn4
 SESJnhhmrML6Cu1oA3UR+UOf4HJYwfWd1EP541tG9HWaO8lvLM4Vi1bJdqtTdsZWqNE0
 KQHtcaa8HtAx44MdBmuD68RBi5Y0dwyka0n4Onzk7Fxz/b4kOTIJuI7E4CXIrBQ+xp+o
 qOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770395005; x=1770999805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p0QRGAi0x+NGTcKQJg9S+8p7z91wf4oWNkMOiVNuiSE=;
 b=hlWmmrpricsFl34FnLMUncPjv19dyUw6mRzQzlxc/vGsC4uPyJJPKl/MMtmvIr7Icz
 GTdePGTj1LUAPZE0qN6bI/8dP9bVz6x9HLzzRcJpBriAoZXmmdaHOXIdhrvmuAmdt+u/
 F9dudZXiD8ygcwxGPlTnOcmXSv/ArYeorN6ASCPieRxl4ApVIEVqeml1E9fTPuSP+Q0U
 ayRN2PJSRDRwR92D1PUPTlQsZGlL+3PEMtPG7PCg5qyl0SP1U1mWpYpx3Uew4ibFkNmQ
 /oRJPFHP0x5wH/Z2Jkpu4Zd3XZ2L4+YrYWveB/oLofYd/CSjD9klbJWJyqOYfJJksJzO
 sn+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs8inTeh1KICu/Fh52KR4WlARoMizWaFKBTo5fydmya0ZoJR8nFo5CJI9VgwCy8HJIAnO/a7y4pm4a@nongnu.org
X-Gm-Message-State: AOJu0YxJxxWkyonzThGjbYXFSYIr1vAFo2Jswi8fd00RaE9L2qomwfT+
 a36xBMl8vY9GmtSwmig0qF4k2UIWzZbu9wjFzcA9Pteuka8csSawHlnkLGoJ4RwaA3v8hDpQ6bS
 5p6O70hv3Opfr23yrKdwxPnnQhSn2zdZBHQu22P4=
X-Gm-Gg: AZuq6aJC6KQVvR6qGFZ/B7NZzEHEYaTzMLvKtkNNKsPWhaaaT7qa/Qx+yb0VB8spC5Q
 s7qd542F3DxwHQY0s1HOCF4xis1gvBexXpYYzUttwRmQpgLICXOlsSFUNEEjIynklHkg95g7onR
 T1/eEG4t81NqEWCoNZkO7clVNx9flWgYaX7rotV40OqelYw9QHtxF4QjrTK7rZupmD59TfVNN1K
 61mXUVqh6KvcCtgFwwQYZdViIQv45b8aw4rfhnLr8xPswO1l0c/6sYoK6XLWONlm8UwLlBedt/q
 3E2hJnp9vxPRRkeBDJQne0hcZ9glv9TRnTWUNVU=
X-Received: by 2002:a05:6512:1324:b0:59e:408d:3a45 with SMTP id
 2adb3069b0e04-59e45152c9amr1055881e87.26.1770395004481; Fri, 06 Feb 2026
 08:23:24 -0800 (PST)
MIME-Version: 1.0
References: <20260109202740.362506-1-ankeesler@google.com>
 <20260109202740.362506-2-ankeesler@google.com>
 <CAGZECHP9i9zeZP4wLtDtx44OsPesOC3hG=bmpjsGrYUVAG-mXg@mail.gmail.com>
 <87ikccy8sm.fsf@pond.sub.org>
In-Reply-To: <87ikccy8sm.fsf@pond.sub.org>
From: Andrew Keesler <ankeesler@google.com>
Date: Fri, 6 Feb 2026 11:23:13 -0500
X-Gm-Features: AZwV_Qis5YxwuRz4wMpm99PWSAeCPbxRlow89VEsGY0UL5W3SalS94UQKcdSYIY
Message-ID: <CAGZECHOuMEhotdv7YB7GL71cKF4dzbYhbLE4DN39f-ype=Gc3A@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] Support per-head resolutions with virtio-gpu
To: Markus Armbruster <armbru@redhat.com>
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000005b5d77064a2a35e7"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=ankeesler@google.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--0000000000005b5d77064a2a35e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> So when exactly one of @xres or @yes is present, it's silently ignored?

That is the currently proposed behavior, yes.

Here is the related review comment.

  https://mail.gnu.org/archive/html/qemu-devel/2025-08/msg04584.html

WDYT?

> (since 11.0)

ACK, fixed in next patch.

> Mentioning this in the commit message wouldn't hurt.

ACK, fixed in next patch.

> Recovering from the coughing plague.

Hope you feel better.


On Wed, Feb 4, 2026 at 7:47=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> Andrew Keesler <ankeesler@google.com> writes:
>
> > Note - we use "xres" and "yres" (instead of, say, "width" and "height")
> > to match analogous virtio_gpu_base_conf.xres/yres.
>
> Mentioning this in the commit message wouldn't hurt.
>
>

--0000000000005b5d77064a2a35e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt; So when exactly one of @xres or @yes is present, it&#=
39;s silently ignored?<br><div><br></div><div>That is the currently propose=
d behavior, yes.</div><div><br></div><div>Here is the related review commen=
t.</div><div><br></div><div>=C2=A0=C2=A0<a href=3D"https://mail.gnu.org/arc=
hive/html/qemu-devel/2025-08/msg04584.html">https://mail.gnu.org/archive/ht=
ml/qemu-devel/2025-08/msg04584.html</a></div><div><br></div><div>WDYT?</div=
><div><br></div><div>&gt; (since 11.0)<br><br>ACK, fixed in next patch.</di=
v><div><br></div><div>&gt; Mentioning this in the commit message wouldn&#39=
;t hurt.</div><div class=3D"gmail-yj6qo"></div><br>ACK, fixed in next patch=
.<div><br></div><div>&gt; Recovering from the coughing plague.<br><br>Hope =
you feel better.<br class=3D"gmail-Apple-interchange-newline"><div><br></di=
v></div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Feb 4, 2026 at 7:47=E2=80=AFAM Markus=
 Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Andre=
w Keesler &lt;<a href=3D"mailto:ankeesler@google.com" target=3D"_blank">ank=
eesler@google.com</a>&gt; writes:<br>
<br>
&gt; Note - we use &quot;xres&quot; and &quot;yres&quot; (instead of, say, =
&quot;width&quot; and &quot;height&quot;)<br>
&gt; to match analogous virtio_gpu_base_conf.xres/yres.<br>
<br>
Mentioning this in the commit message wouldn&#39;t hurt.<br>
<br>
</blockquote></div>

--0000000000005b5d77064a2a35e7--

