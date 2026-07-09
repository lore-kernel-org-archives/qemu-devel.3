Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71364C44506
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whonR-0004SM-3h; Thu, 09 Jul 2026 09:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1whonO-0004RU-JK
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:28:06 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1whonN-0008KU-0y
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:28:06 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6647bc8f900so1543861d50.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 06:28:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783603683; cv=none;
 d=google.com; s=arc-20260327;
 b=GhtJUaQ6DvOikCKeESBowKgEXUDpKPEHx0LzuCofE+TgtfZvrzxXPhvzpClinhWAmT
 0GUKkUNgx3Geqn3nq6RxKAKAtQruMK9Xi6XEzSFUox3dY/YEA96wE/wS04RpB6hLVBzP
 IuxbdSK75EY5O+6/LvmrKOedlINH9CM5ntWy5uJiQ4jcIGv8jYazXTXpoZiwfysJqfTJ
 nEFwT5rmm5Vw7iLGkIZX+K8PovOHcQTOBdneFm++loEHmyxs3GrQU/2dzx3JZeAN4T/Y
 xrGI4GjcIp3WD+7+pY6UyLPb0FetFGwHwQHWNSmFFV5ooDy0pgVoBuZxuTU/pF4rJlIo
 xDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=whJVHBLU8XN1bu29etXrqHdM1+t3RsWUdRcRhBEktyA=;
 fh=KvH932XNE83evJR1wouIbPM5ckPEME3pU+C+gXCc2sc=;
 b=gddcaWalDmpONzKGyWR4pZsTRmI3+zspfxmSsq8DR9lnbf9GytDXnnBel2VihjyHlM
 UUQjMUGBI9cNX/avvcZTeVVm9ZY09w/cyAkqEXonLvm4FKOkzd4BRT0PH7v1EP7osau6
 gNu5NBHg9V90trQ4INp2Cj5cNduDNfnbr6vojjzc3/5N9VYH+6VyTUls6v8fOZzE+Pde
 c5jot5uMA7vlXiXPr6FBB/KTK3VRz/nJ1gK6Bs7X385HeMPAW1fU2IDry3VswzuMkR0G
 Gwjy0rtYfCI7KvgTrbW3LbdLQ+MrcgGsWWyGvCBJ9y60AydXWtmtTMThJRHj5zZxD1uy
 rR9w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783603683; x=1784208483; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=whJVHBLU8XN1bu29etXrqHdM1+t3RsWUdRcRhBEktyA=;
 b=ma/ko62fhBwcU98rRodsUYNydkYZONxAS/5VpmZWH+aKmlgsTva/ZSQS/Qc8ESqAYx
 tqJ9ouUhf8XWwc2uu3m/vhV7o0KLSX+d3UrwYQHa18NH/+65FSbZyqdHwhaipfI+xopH
 lqaUw/RNvjYYikpoYxrnRCOmJdpxG1DilP5M/A0HzPVwNcVG1HonSWIplIODgflmDpbh
 aqFbN3Y2QuCwjaokqAr73J0XomLl+nl0gzjJkQHauNuIJg5/mGWb6cjJ1KnkTKpDRwDC
 hBeQ3qwhD/XdsuNd22/elpuVRH8raQqJb9c+DLGGKNwIfiKmm7+Nd1cDz8NE1+4eD9By
 g7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783603683; x=1784208483;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=whJVHBLU8XN1bu29etXrqHdM1+t3RsWUdRcRhBEktyA=;
 b=sGFNRkI8uj754wKur5W2DWAuNWhTVV0VwB3pfEoKk1GFiy3wKb7OaKo/VrLiahCoV4
 hjpoMh4/869XsPGxp4XWfB2XQlMmN2mmykvbEQsAt1YU+itvCqNsTaSVQBwEBCODlenj
 e/HsI8YGTWqbmJITGmE36Gd5CoZWJNHrzHBOwVjj4fzN2N+pqiF0kx+qlBMHkp68UDmO
 MaAsC8KY2cefu/3LbY0JvmkgfHYYoPT7gI1BY1Iupho/z3lXTAGzZj5Wx4u6q0+m7d/N
 eaDJZ5yPQTR+BS8uCpy2zdhOVz8OvpBcWHSOYw9c2HOHxd20irpXXXJXYn1KuZCMtAqW
 nspQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2ya7H7vc7gSBemP/OP41BqlrCjlgSJfQx8tufylZKfOSPhoG6Glq0M0fF8LwqCu1Y6/vdEqAD6EGP@nongnu.org
X-Gm-Message-State: AOJu0YyQ2cqbEO+3Vw2F85Bgw5P8d8SWVs9QkydMONTDwjEKI2P3yH7U
 R9GvZbYiJIGDXO71tzowXuRe6HnqrjWI6x8wNkx70FbdG96dXdYx2O/z8mRe3Yia/ln+4Md/xdU
 EVFzhYjnisEnzLOvOym53Rg26MJiCbGM=
X-Gm-Gg: AfdE7claAdfzaGEiQJrVDj/q33GUlU1Bq8r9GITtsmqfQR7WwRatVeNnVCTEOynqVEl
 1qyAqqfweTUQ6PpYb9zLfonovaWl8JCOXENWAsy/hh6J7zbYSXw8XpkYcjF1jH6O30HT8SYt3yq
 N85gKsl88Zo/ZlUQNIbBTFwYaUwlUfPFUTUKaCtzLJKYVS6KdXxGAUGkxdBZwqfX9Xk0z+GeaxP
 gWhgPn9iU3Q72QEBXj9BvUmK8YYHh/gywNagRaCCDlcPXfCm0pG0S3qHBysfweeIZu4CPY=
X-Received: by 2002:a05:690e:1289:b0:667:ae6e:1a18 with SMTP id
 956f58d0204a3-667ae6e3271mr4116184d50.36.1783603683395; Thu, 09 Jul 2026
 06:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260709104802.1989086-1-peter.maydell@linaro.org>
 <2726eb5e-61ae-4600-9c47-2ce9d764afc1@oss.qualcomm.com>
In-Reply-To: <2726eb5e-61ae-4600-9c47-2ce9d764afc1@oss.qualcomm.com>
From: Strahinja Jankovic <strahinjapjankovic@gmail.com>
Date: Thu, 9 Jul 2026 15:27:52 +0200
X-Gm-Features: AVVi8Cc87T0UdhhurfCiVvN78WGsblq8ECfazO0Q34AhTx3QtKsEqKs9ArrzesM
Message-ID: <CABtshVQdNbKF6ebTmu32h7L-zuLT-W2wzTXCWbop5PJ9qCvXyA@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/allwinner-r40-ccu.c: Correct handling of out of
 range accesses
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f80b5706562d977c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-yx1-xb12c.google.com
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

--000000000000f80b5706562d977c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 1:03=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <
philmd@oss.qualcomm.com> wrote:

> On 9/7/26 12:48, Peter Maydell wrote:
> > In allwinner_r40_ccu_write() we handle writes to a MemoryRegion of
> > size AW_R40_CCU_IOSIZE, and the register array is sized accordingly
> > at (AW_R40_CCU_IOSIZE / sizeof(uint32_t)).  However, one of the cases
> > in the switch is a range up to AW_R40_CCU_IOSIZE, which makes
> > Coverity think we might index off the end of the array. We also
> > have a similar case in the read function, but since that returns
> > early it doesn't have the same issue.
> >
> > Adjust the handling of out of range accesses:
> >   - use AW_R40_CCU_IOSIZE - 4 as the upper bound, as this is the
> >     largest value we will actually see
> >   - return early in the write case, as we do in the read case
> >
> > Coverity CID: 1663687
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/misc/allwinner-r40-ccu.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
>

Reviewed-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>

--000000000000f80b5706562d977c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 9, =
2026 at 1:03=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:p=
hilmd@oss.qualcomm.com">philmd@oss.qualcomm.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 9/7/26 12:48, Peter Mayde=
ll wrote:<br>
&gt; In allwinner_r40_ccu_write() we handle writes to a MemoryRegion of<br>
&gt; size AW_R40_CCU_IOSIZE, and the register array is sized accordingly<br=
>
&gt; at (AW_R40_CCU_IOSIZE / sizeof(uint32_t)).=C2=A0 However, one of the c=
ases<br>
&gt; in the switch is a range up to AW_R40_CCU_IOSIZE, which makes<br>
&gt; Coverity think we might index off the end of the array. We also<br>
&gt; have a similar case in the read function, but since that returns<br>
&gt; early it doesn&#39;t have the same issue.<br>
&gt; <br>
&gt; Adjust the handling of out of range accesses:<br>
&gt;=C2=A0 =C2=A0- use AW_R40_CCU_IOSIZE - 4 as the upper bound, as this is=
 the<br>
&gt;=C2=A0 =C2=A0 =C2=A0largest value we will actually see<br>
&gt;=C2=A0 =C2=A0- return early in the write case, as we do in the read cas=
e<br>
&gt; <br>
&gt; Coverity CID: 1663687<br>
&gt; Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linar=
o.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/misc/allwinner-r40-ccu.c | 6 +++---<br>
&gt;=C2=A0 =C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@oss.q=
ualcomm.com" target=3D"_blank">philmd@oss.qualcomm.com</a>&gt;<br></blockqu=
ote><div><br></div><div>Reviewed-by: Strahinja Jankovic &lt;<a href=3D"mail=
to:strahinja.p.jankovic@gmail.com">strahinja.p.jankovic@gmail.com</a>&gt;=
=C2=A0</div></div></div>

--000000000000f80b5706562d977c--

