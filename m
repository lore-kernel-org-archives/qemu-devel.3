Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1828CC79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4NR5-0004wD-Af; Wed, 09 Sep 2026 14:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1x4NR2-0004vt-Vo
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:54:17 -0400
Received: from mail-oo2-x0f.google.com ([2607:f8b0:4864:31::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1x4NR1-0001Xr-4H
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 14:54:16 -0400
Received: by mail-oo2-x0f.google.com with SMTP id
 006d021491bc7-6b1ae716867so813824eaf.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 11:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788980053; cv=none;
 d=google.com; s=arc-20260327;
 b=BICUphfu0I4f4JJtrrp0XfdEkfOid7v9PrizGqy7O8yIhcL0RaUFo5QMiniGfFkjmX
 RP1rog5lymxXcvLnCwbtB9EuzWfrG83jibdSDLtJ0FID/N9N8EZJjf/65U+0uKDYHCFv
 hciHuDAonoEQnm8FrxxpEx84UAjay949xT6xx7n6k7bDLhpYBJnkUxNw7r6p5P6d5DDj
 t1nprIaiAIDJXmQnOdOdVddFQOPvsE43jjdDxW7Mb8sRDZ9C4gzXHMTQHccFSLL95ha4
 Zts0F9tqDCrxCKmYiBAtmrztHWTLpbr61PMdCLdhrbHOqitPl6QEV8tX+ej6yO0H9ycV
 GMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AoI3LYAEjiE/qWVMpEsx2FsnXZEgpransVQ7bhFKpLU=;
 fh=JaXjRzdvfa+jBMrqqbz+g4xEPDSDEOH8tvIjEuTq1PI=;
 b=Ydr1htC1hErQuxqavHepUHDgcEgzpUSH6JozVnv1QlUpQeW95hBmSHh8wQu/URcvw8
 TOdbo6Clh9QZXL3I47Rz2xo3+pZz20aLJBIXiMovOd6pLQ91By8aFqqbF92sue5iG4kS
 0J6JPPuyESd8D3NhGU2Vm/p+gvBsnfiwkf4RpQJqHXYyHoIe04A20FNIhZMFRPpiSmzi
 B3PRz5QvoST/51mNQkVim1hUXci4Wae4oKHncWylQzsuYvLqdWS7hlyEzrnF6Voqr1Xb
 9USjjkil2VamowwE7j/M1XqOxScEzmCsiwp5AD7xUgwQcd7Hpa6mfuIQ/3JMy9YcAxw1
 E5xw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788980053; x=1789584853; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AoI3LYAEjiE/qWVMpEsx2FsnXZEgpransVQ7bhFKpLU=;
 b=W9JltohJh34kSZnWRFOwLPFSImKG9fin3sYK8HdOaZ3vc1cuDG/JVgF3TwhTeyUXO3
 M1+ae3ER8KoXPxsCG6CV51MXU4ESTvg/4y6kC08PVaV96tDfFFf44eTTuzWez84fH2TC
 wDBFUl2wGplveFwKQddlOR+9f7DH//K5X/qthnQ2DujeSVVWWZRpmzeyjvaJAItCug1a
 8K8c9FN5zxFVr3Gm+DnoUFesiOC4JLl5jTvgkPGXcI8BlE4G1BFMpeD+ZsDD3HXV6GXI
 1oGVluNdFkRPnCeM4/ZpL9D++gNMhjLgqI+bGpJfyMyGSUqbyuqal9LR7c2gflYSy0ug
 aFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788980053; x=1789584853;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AoI3LYAEjiE/qWVMpEsx2FsnXZEgpransVQ7bhFKpLU=;
 b=Fov0uHMulIFIBJrAc2iz8Cw9ajZqs5/as/poTK1BwzwiJvuwYnecP8zYteQBZmc+Lt
 uxQRM2Lh2U0aDNEHXhmw3u1IA8QYr3ime9d0xwnLfdicw662vGruBu1KCYKOegoBj0cw
 VLmOz9lj+gi4wbC4MZaiuYd+4qe8lbxyPxY7lAJOOZ7WCB0IwhDlE5hNecewmsyiX+3f
 2R1f7le8gPNNmBcrszYGQS/hBzVw5JFZPWnf3FXid7cRVfy73J/gPnWGyT8u8FVoIJu+
 lAccZ0iWDKjf9pdEP2jle1Xdsdlxq5VHvHzIPAWLneV79F/uCSbZ5NJDHTBIDoktYOWU
 NY0w==
X-Gm-Message-State: AFuF++lysTKLywbr3jZ68Y7mRu3Pr0IdPGHIZ5q4ZKxbcRHdKGeIaEod
 O7ROluVYfUqwMZ1iaVCI2tVKkHe27GH/IJZ21Yu7Rbn1c8+Camg1hLVUttzs/gDyD1GLyw/VtHg
 kMlgdiMXr5pWk3GV7gxZUBZq1HaKeLU6N0w==
X-Gm-Gg: AYBFou3vnyEkdCIvcXa01lomtFRgfuK4EptTtK1gbvpMHZMjecRHjmmWx5iYnhh6fjn
 e7JvHMs661z+64f0q/oHLnOnQYMd2D5WfsjA9qptvFbTaZwv6fitBQ97XONTqHnIDQK02720UGb
 o7iT2+vgj1aabjnSVJwBQNxU5bCgj1YSeNY3U3cORhJxpxj9eoZejHORFM9TxZKF88XRI1yS9UO
 wr5ZAk22R+ZJXxB0wtIFg+4sAP5ZMfMYOZzOs3TRAeco/XmcI3apnoK5o4CkbnIl8PvfIZTkoyp
 KcRUa9/4MK7VQhbFwxCWbWgdhczIq1vxkHdtbJW2AeTNXARflQWbqg==
X-Received: by 2002:a05:6820:1c8c:b0:6aa:cce3:ab61 with SMTP id
 006d021491bc7-6bdc9e718f7mr7826453eaf.9.1788980053366; Wed, 09 Sep 2026
 11:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260903044626.24453-1-54weasels@gmail.com>
In-Reply-To: <20260903044626.24453-1-54weasels@gmail.com>
From: Purr Box <54weasels@gmail.com>
Date: Wed, 9 Sep 2026 11:54:03 -0700
X-Gm-Features: AcwNN1VRQRN-qAC1Cuke5EKU3x8LLl1PWM94a11U5yo-d6fUQjtTkBC4TXoZpvg
Message-ID: <CAFWf6u8rjCECp+cdP21kfB7QUYff3crQiE1v5DnHXcMVzWan9w@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Implement missing functionality and hooks in m68k
 to support upcoming Sun-3 implementation
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: multipart/alternative; boundary="000000000000975b46065b1160b5"
Received-SPF: pass client-ip=2607:f8b0:4864:31::f;
 envelope-from=54weasels@gmail.com; helo=mail-oo2-x0f.google.com
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

--000000000000975b46065b1160b5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping on this series. v5 addresses Zoltan's review feedback from v4
(fsave simplification, NMI edge-trigger rationale, added Signed-off-by).
Would appreciate any review when you have a chance.

Dan.

On Wed, Sep 2, 2026 at 9:46=E2=80=AFPM 54weasels <54weasels@gmail.com> wrot=
e:

> This series adds M68020/030-specific features to the m68k target that
> are required by the Sun-3 machine (series C) and its PROM/SunOS guests:
>
>   1/6: CAAR register stub for 68020/030 cache control
>   2/6: fsave/frestore fix for 68881 (non-68040) FPU frames
>   3/6: Edge-triggered NMI semantics for Level 7 interrupts
>   4/6: Function code extraction during TLB fills
>   5/6: Custom MMU intercept hook for Sun-3 transparent translation
>   6/6: Physical Bus Error and M68020 Format 0xB stack frames
>
> Changes since v4:
>   - Added Signed-off-by to all patches.
>   - Patch 2/6 (fsave): Addressed Zoltan's review =E2=80=94 replaced redun=
dant
>     M68040||FPU check with just M68K_FEATURE_FPU, removed unnecessary
>     if/else in frestore, moved Context: below --- separator.
>   - Patch 3/6 (NMI): Addressed Zoltan's review =E2=80=94 nmi_pending cann=
ot be
>     replaced by testing pending_level =3D=3D 7. The flag captures the edg=
e
>     transition (level < 7 =E2=86=92 7) required by Motorola's NMI specifi=
cation,
>     while pending_level only reflects the current interrupt level.
>     Testing pending_level alone would produce level-triggered behavior,
>     firing on every interrupt check rather than once per edge.
>   - Rebased on current master.
>
> 54weasels (6):
>   target/m68k: Add dummy CAAR register
>   target/m68k: Fix fsave/frestore for 68881 FPU
>   target/m68k: Fix NMI pending for Level 7 interrupts
>   target/m68k: Extract Function Codes during TLB fills
>   target/m68k: Implement custom MMU intercept hook
>   target/m68k: Implement Physical Bus Error and Stack
>
>  target/m68k/cpu.c       |   4 +-
>  target/m68k/cpu.h       |  21 ++++-
>  target/m68k/helper.c    | 130 ++++++++++++++++++++++++++++-
>  target/m68k/op_helper.c | 175 ++++++++++++++++++++++++++--------------
>  target/m68k/translate.c |  30 ++++---
>  5 files changed, 280 insertions(+), 80 deletions(-)
>
> --
> 2.50.1 (Apple Git-155)
>
>

--000000000000975b46065b1160b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"ltr">Gentle ping on this series. v5 addresses=
 Zoltan&#39;s review feedback from v4 (fsave simplification, NMI edge-trigg=
er rationale, added Signed-off-by). Would appreciate any review when you ha=
ve a chance.<div><br></div><div>Dan.</div></div></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 2, 2026 at 9:46=
=E2=80=AFPM 54weasels &lt;<a href=3D"mailto:54weasels@gmail.com" target=3D"=
_blank" rel=3D"noreferrer">54weasels@gmail.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">This series adds M68020/030-s=
pecific features to the m68k target that<br>
are required by the Sun-3 machine (series C) and its PROM/SunOS guests:<br>
<br>
=C2=A0 1/6: CAAR register stub for 68020/030 cache control<br>
=C2=A0 2/6: fsave/frestore fix for 68881 (non-68040) FPU frames<br>
=C2=A0 3/6: Edge-triggered NMI semantics for Level 7 interrupts<br>
=C2=A0 4/6: Function code extraction during TLB fills<br>
=C2=A0 5/6: Custom MMU intercept hook for Sun-3 transparent translation<br>
=C2=A0 6/6: Physical Bus Error and M68020 Format 0xB stack frames<br>
<br>
Changes since v4:<br>
=C2=A0 - Added Signed-off-by to all patches.<br>
=C2=A0 - Patch 2/6 (fsave): Addressed Zoltan&#39;s review =E2=80=94 replace=
d redundant<br>
=C2=A0 =C2=A0 M68040||FPU check with just M68K_FEATURE_FPU, removed unneces=
sary<br>
=C2=A0 =C2=A0 if/else in frestore, moved Context: below --- separator.<br>
=C2=A0 - Patch 3/6 (NMI): Addressed Zoltan&#39;s review =E2=80=94 nmi_pendi=
ng cannot be<br>
=C2=A0 =C2=A0 replaced by testing pending_level =3D=3D 7. The flag captures=
 the edge<br>
=C2=A0 =C2=A0 transition (level &lt; 7 =E2=86=92 7) required by Motorola&#3=
9;s NMI specification,<br>
=C2=A0 =C2=A0 while pending_level only reflects the current interrupt level=
.<br>
=C2=A0 =C2=A0 Testing pending_level alone would produce level-triggered beh=
avior,<br>
=C2=A0 =C2=A0 firing on every interrupt check rather than once per edge.<br=
>
=C2=A0 - Rebased on current master.<br>
<br>
54weasels (6):<br>
=C2=A0 target/m68k: Add dummy CAAR register<br>
=C2=A0 target/m68k: Fix fsave/frestore for 68881 FPU<br>
=C2=A0 target/m68k: Fix NMI pending for Level 7 interrupts<br>
=C2=A0 target/m68k: Extract Function Codes during TLB fills<br>
=C2=A0 target/m68k: Implement custom MMU intercept hook<br>
=C2=A0 target/m68k: Implement Physical Bus Error and Stack<br>
<br>
=C2=A0target/m68k/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
=C2=A0target/m68k/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 21 ++++-<br>
=C2=A0target/m68k/helper.c=C2=A0 =C2=A0 | 130 ++++++++++++++++++++++++++++-=
<br>
=C2=A0target/m68k/op_helper.c | 175 ++++++++++++++++++++++++++-------------=
-<br>
=C2=A0target/m68k/translate.c |=C2=A0 30 ++++---<br>
=C2=A05 files changed, 280 insertions(+), 80 deletions(-)<br>
<br>
-- <br>
2.50.1 (Apple Git-155)<br>
<br>
</blockquote></div>

--000000000000975b46065b1160b5--

