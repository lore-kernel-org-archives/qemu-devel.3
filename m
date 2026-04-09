Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A70F364A2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 16:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAsdN-00078z-R0; Thu, 09 Apr 2026 12:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAsdM-00078i-8N
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 12:53:36 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAsdK-00071T-2v
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 12:53:36 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3567e2b4159so825651a91.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 09:53:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775753613; cv=none;
 d=google.com; s=arc-20240605;
 b=LbiRxX3bfdq+lV8p/g5aNlrcmT63fzG7wcTwL98fWbpUThX4It1Hyj83s9BsheZ8So
 XqLW32GMF43xshVhTA/Yr+dbR1ERMz8XUZFx56BLoMeplICOGGkf8v28fsWKJNGCmuwL
 fNffkiQX1330yUV+8x4zfG31V9nZzH4J8i3NIg8ljggephtm3VdFHLigrrEHgjuWtMY+
 l9hCzFuZcRqQKPWQ6Tqr4l3Gh7ztyp4sBzP7crbkPHHJhS5xM9vCQlNpS5FJvkV7rMKp
 nUJ2WjMelqKJD1hvPFra4CtrlzD1//HHraKlLWY0yFn+Pv/2N8Ix8+AUZ1VjdMOxNmCm
 cNBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EGO5KxonVaV4PL6gq5NoKgqZNBOmQYHWR2NyFyaYlRg=;
 fh=seHpsuERei6GoCJPMtZiXpXOw/2EVnvuQ7nSTREwIqg=;
 b=RT3W/byPjaVV8NsALF53xDssj7HbnXQzVi093zVpo3pnK4ql25bnu4K5XalW5kllyV
 v0M8G35SgJTqfZdp3AKNFZddQ74AxqP89SjUuQ0UDLwB7mo4+6E3Za3m13QBE38wizD9
 hEuzjaIMIAHH/9vmOAMS/oIpsIDCiIsTNy3BRhYlHq5Rwxuxub95RvP1HKQj4KzDx0Mp
 lYicqKuIv6yRbpGxQ4HwNv8pwOvF7MGe60u65cDvwv3Fyd+SnxlRIHUl1j3Ngil9lGQ8
 w1samDJVbNvLNNMTzkkrg/4I7vz97LitvAq1JjacKC4J0EAGVsgGYS7kCqCHpaRHTFaS
 dnXw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775753613; x=1776358413; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EGO5KxonVaV4PL6gq5NoKgqZNBOmQYHWR2NyFyaYlRg=;
 b=cMbGTXmORyYRoyv0fcj0ciB+hH5tn91uO/5wX/rOUiqOzvjEuvmiOnFYuSoJyJ1pC1
 2wKopWREeB9nokqBeGPiWlmUaYUEELr9Fklo0jmGXwVsRlvFW8DcO5z6ccRcPEaVONa6
 1nl3Jp1Xmt612LSwTggATqnGhjdP3fL9PnT33VKRaFnzyLWP4NDYBxuSxDxb/CKjM24Q
 q//1+t4XH0R+8QIu/OQE/o5y10b/+MFSNPN5lfkEUPeK4LhRumrwW1qAgzHO48EFWV9c
 6jmrJ0bzxDA/2MafU6rHMWyA+PStkNjdo9W4QBu5umneBaNqN/pdTV/rUqDEG6LSnE3x
 PGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775753613; x=1776358413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EGO5KxonVaV4PL6gq5NoKgqZNBOmQYHWR2NyFyaYlRg=;
 b=kh8cO8s9GW8vn0TQIzR15cP2fWY1B47rzILE++AoSrpZY0QjkqyIexLtp2X7cENKj7
 41h5iW+KEOeZXgAXZSHx/e5ONawchHl9pqqXnLJc5EuRHODlanOpSdws1m6AruSxCIAP
 AcYM4dyc0emdpBUg3HLr+8dbind5M1Iz2SJHOi9Aq1NNruVWJspcYJSmfDBSCnYDo2kp
 mVuoLLArfKdbzSuQpJJw+TVV1EZos2zgmnMVf+/QRoQS0wlVAY+6ZVAp5d0JEBZMIWqW
 8Cs0wTcmX6qI1sAK0hswTdzNzdMYcbEpF9kmZutf4NL1BhoUGTAhYzq09zWpP0TRGDLC
 Ukag==
X-Gm-Message-State: AOJu0Yz7KDWhbrCvT4Au9p3ykbIUvZdmMfRtmND5uny+dGSwjN9SZ89K
 HpzkY1kK6dkHNUBZ0GXQ7o7f8GjgF8vMJEkAPOyu9y48sx0DElY/t/hvCbSjprDlCf1XwaiGklr
 iOG8LnskAm/3xXUcp1UAU3BclrMRwlDM=
X-Gm-Gg: AeBDieuvm3T/0xDsmubelXd1n+V7D14rvJjXks5bInGUrehc3LkMep8otJm07wh808i
 4ifCwzCsDu13P1FVBLYgmZJte0n60diAMIeL8g5K/IfsAFNpXnPNe5JKygg1KeBkR4sCkMPxksk
 JiuxQR6O6oCr8G7PV+s4EbEh+uqjP2f3LrPzbWhFTCYxLo2wLOz/froiHTazIJiRTUUmK56YEc5
 SwGn5KWoE/Ks10t4jQZHv0hMYn5MU4TGIKelqq8S+effOQv0ZnCOnVD1l0bnjSdTggKBIJFDNba
 jmDQEEBsSR9m8vyCzAP/0cIqMDNzL1ugYlHPxdk=
X-Received: by 2002:a17:90b:37cc:b0:359:d54:846f with SMTP id
 98e67ed59e1d1-35de680bc4amr26018582a91.7.1775753612525; Thu, 09 Apr 2026
 09:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
 <e66f33dc979f03215ab0c0738a14b96e8f8a30cd.1775665981.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <e66f33dc979f03215ab0c0738a14b96e8f8a30cd.1775665981.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Thu, 9 Apr 2026 10:53:21 -0600
X-Gm-Features: AQROBzCxrz-y58lfoD6_nYcvCXE6dltt6bxQir_mcjdzxu_KpMYpkG-WWYyY1q8
Message-ID: <CAATN3Nr5wCYcW2dnkPZgqJ+utJpeBbksQ9rXwSKm3xt1ENR7wg@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] tests/hexagon: add tests for v68 HVX IEEE float
 arithmetics
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, ale@rev.ng, 
 anjo@rev.ng, brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="000000000000488230064f09db0a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x1031.google.com
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

--000000000000488230064f09db0a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/hex_test.h        |   4 +
>  tests/tcg/hexagon/hvx_misc.h        |  41 ++++++++
>  tests/tcg/hexagon/fp_hvx.c          | 155 ++++++++++++++++++++++++++++
>  tests/tcg/hexagon/fp_hvx_disabled.c |  57 ++++++++++
>  tests/tcg/hexagon/Makefile.target   |   8 ++
>  5 files changed, 265 insertions(+)
>  create mode 100644 tests/tcg/hexagon/fp_hvx.c
>  create mode 100644 tests/tcg/hexagon/fp_hvx_disabled.c
>
> diff --git a/tests/tcg/hexagon/fp_hvx.c b/tests/tcg/hexagon/fp_hvx.c
> new file mode 100644
> index 0000000000..0365833753
> --- /dev/null
>
> +static void test_new(void)
> +{
> +    asm volatile("r0 =3D #0x2\n"
>

Use SF_two


> +                 "v0 =3D vsplat(r0)\n"
> +                 "vmem(%1 + #0) =3D v0\n"
> +                 "r1 =3D #0x1\n"
>

Use SF_one


> +                 "v1 =3D vsplat(r1)\n"
> +                 "v2 =3D vsplat(r1)\n"
> +                 "{\n"
> +                 "  v0.sf =3D vadd(v1.sf, v2.sf)\n"
> +                 "  vmem(%0 + #0) =3D v0.new\n"
> +                 "}\n"
> +                 :
> +                 : "r"(output), "r"(expect)
> +                 : "r0", "r1", "v0", "v1", "v2", "memory");
> +    check_output_w(__LINE__, 1);
> +}
>


> diff --git a/tests/tcg/hexagon/fp_hvx_disabled.c
> b/tests/tcg/hexagon/fp_hvx_disabled.c
> new file mode 100644
> index 0000000000..388a42e2b7
> --- /dev/null
> +++ b/tests/tcg/hexagon/fp_hvx_disabled.c
> @@ -0,0 +1,57 @@
> +/*
> + *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + *  SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <hexagon_types.h>
> +#include <hvx_hexagon_protos.h>
> +
> +int err;
> +#include "hvx_misc.h"
> +
> +static void test_disabled(void)
> +{
> +    memset(output, 0xAA, sizeof(output));
> +    memset(expect, 0, sizeof(expect));
> +    asm volatile("r0 =3D #0xff\n"
> +                 "v0 =3D vsplat(r0)\n"
> +                 "r1 =3D #0x1\n"
>

Minor nit - consider known floating point values (e.g., SF_one) (but since
the vadd is going to write zeros, it really doesn't matter).


> +                 "v1 =3D vsplat(r1)\n"
> +                 "v2 =3D vsplat(r1)\n"
> +                 "v0.sf =3D vadd(v1.sf, v2.sf)\n"
> +                 "vmem(%0 + #0) =3D v0\n"
> +                 :
> +                 : "r"(output)
> +                 : "r0", "r1", "v0", "v1", "v2", "memory");
> +    check_output_w(__LINE__, 1);
> +}
> +
> +static void test_disabled_with_new(void)
> +{
> +    memset(output, 0xAA, sizeof(output));
> +    memset(expect, 0, sizeof(expect));
> +    asm volatile("r0 =3D #0xff\n"
> +                 "v0 =3D vsplat(r0)\n"
> +                 "r1 =3D #0x1\n"
>

Ditto


> +                 "v1 =3D vsplat(r1)\n"
> +                 "v2 =3D vsplat(r1)\n"
> +                 "{\n"
> +                 "    v0.sf =3D vadd(v1.sf, v2.sf)\n"
> +                 "    vmem(%0 + #0) =3D v0.new\n"
> +                 "}\n"
> +                 :
> +                 : "r"(output)
> +                 : "r0", "r1", "v0", "v1", "v2", "memory");
> +    check_output_w(__LINE__, 1);
> +}
> +
> +int main(void)
> +{
> +    test_disabled();
> +    test_disabled_with_new();
> +    puts(err ? "FAIL" : "PASS");
> +    return err ? 1 : 0;
> +}
> diff --git a/tests/tcg/hexagon/Makefile.target
> b/tests/tcg/hexagon/Makefile.target
> index 549c95082f..789721bdac 100644
> --- a/tests/tcg/hexagon/Makefile.target
> +++ b/tests/tcg/hexagon/Makefile.target
> @@ -50,6 +50,8 @@ HEX_TESTS +=3D vector_add_int
>  HEX_TESTS +=3D scatter_gather
>  HEX_TESTS +=3D hvx_misc
>  HEX_TESTS +=3D hvx_histogram
> +HEX_TESTS +=3D fp_hvx
> +HEX_TESTS +=3D fp_hvx_disabled
>  HEX_TESTS +=3D invalid-slots
>  HEX_TESTS +=3D invalid-encoding
>  HEX_TESTS +=3D multiple-writes
> @@ -126,6 +128,12 @@ v68_hvx: CFLAGS +=3D -mhvx -Wno-unused-function
>  v69_hvx: v69_hvx.c hvx_misc.h
>  v69_hvx: CFLAGS +=3D -mhvx -Wno-unused-function
>  v73_scalar: CFLAGS +=3D -Wno-unused-function
> +fp_hvx: fp_hvx.c hvx_misc.h
>

Also hex_test.h


> +fp_hvx: CFLAGS +=3D -mhvx -mhvx-ieee-fp
> +fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h
>

Also hex_test.h


> +fp_hvx_disabled: CFLAGS +=3D -mhvx -mhvx-ieee-fp
> +
> +run-fp_hvx_disabled: QEMU_OPTS +=3D -cpu v73,ieee-fp=3Dfalse
>
>  hvx_histogram: hvx_histogram.c hvx_histogram_row.S
>         $(CC) $(CFLAGS) $(CROSS_CC_GUEST_CFLAGS) $^ -o $@ $(LDFLAGS)
>

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000488230064f09db0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 8, =
2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Sign=
ed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.bernard=
ino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm.com=
</a>&gt;<br>
---<br>
=C2=A0tests/tcg/hexagon/hex_test.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A04 +<br>
=C2=A0tests/tcg/hexagon/hvx_misc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 41 ++=
++++++<br>
=C2=A0tests/tcg/hexagon/fp_hvx.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 155 ++=
++++++++++++++++++++++++++<br>
=C2=A0tests/tcg/hexagon/fp_hvx_disabled.c |=C2=A0 57 ++++++++++<br>
=C2=A0tests/tcg/hexagon/Makefile.target=C2=A0 =C2=A0|=C2=A0 =C2=A08 ++<br>
=C2=A05 files changed, 265 insertions(+)<br>
=C2=A0create mode 100644 tests/tcg/hexagon/fp_hvx.c<br>
=C2=A0create mode 100644 tests/tcg/hexagon/fp_hvx_disabled.c<br>
<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/tests/tcg/hexagon/fp_hvx.c b/tests/tcg/hexagon/fp_hvx.c<br>
new file mode 100644<br>
index 0000000000..0365833753<br>
--- /dev/null<br><br>
+static void test_new(void)<br>
+{<br>
+=C2=A0 =C2=A0 asm volatile(&quot;r0 =3D #0x2\n&quot;<br></blockquote><div>=
<br></div><div>Use SF_two</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;v0 =3D=
 vsplat(r0)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;vmem(%=
1 + #0) =3D v0\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;r1 =3D=
 #0x1\n&quot;<br></blockquote><div><br></div><div>Use SF_one</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;v1 =3D=
 vsplat(r1)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;v2 =3D=
 vsplat(r1)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;{\n&qu=
ot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0=
 v0.sf =3D vadd(v1.sf, v2.sf)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0=
 vmem(%0 + #0) =3D <a href=3D"http://v0.new" rel=3D"noreferrer" target=3D"_=
blank">v0.new</a>\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;}\n&qu=
ot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: &quot;r&qu=
ot;(output), &quot;r&quot;(expect)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: &quot;r0&q=
uot;, &quot;r1&quot;, &quot;v0&quot;, &quot;v1&quot;, &quot;v2&quot;, &quot=
;memory&quot;);<br>
+=C2=A0 =C2=A0 check_output_w(__LINE__, 1);<br>
+}<br></blockquote><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">diff --git a/tests/tcg/hexagon/fp_hvx_disabled.c b/tests/tcg/hex=
agon/fp_hvx_disabled.c<br>
new file mode 100644<br>
index 0000000000..388a42e2b7<br>
--- /dev/null<br>
+++ b/tests/tcg/hexagon/fp_hvx_disabled.c<br>
@@ -0,0 +1,57 @@<br>
+/*<br>
+ *=C2=A0 Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries=
.<br>
+ *<br>
+ *=C2=A0 SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;string.h&gt;<br>
+#include &lt;hexagon_types.h&gt;<br>
+#include &lt;hvx_hexagon_protos.h&gt;<br>
+<br>
+int err;<br>
+#include &quot;hvx_misc.h&quot;<br>
+<br>
+static void test_disabled(void)<br>
+{<br>
+=C2=A0 =C2=A0 memset(output, 0xAA, sizeof(output));<br>
+=C2=A0 =C2=A0 memset(expect, 0, sizeof(expect));<br>
+=C2=A0 =C2=A0 asm volatile(&quot;r0 =3D #0xff\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;v0 =3D=
 vsplat(r0)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;r1 =3D=
 #0x1\n&quot;<br></blockquote><div><br></div><div>Minor nit - consider know=
n floating point values (e.g., SF_one) (but since the vadd is going to writ=
e zeros, it really doesn&#39;t matter).</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;v1 =3D=
 vsplat(r1)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;v2 =3D=
 vsplat(r1)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;v0.sf =
=3D vadd(v1.sf, v2.sf)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;vmem(%=
0 + #0) =3D v0\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: &quot;r&qu=
ot;(output)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: &quot;r0&q=
uot;, &quot;r1&quot;, &quot;v0&quot;, &quot;v1&quot;, &quot;v2&quot;, &quot=
;memory&quot;);<br>
+=C2=A0 =C2=A0 check_output_w(__LINE__, 1);<br>
+}<br>
+<br>
+static void test_disabled_with_new(void)<br>
+{<br>
+=C2=A0 =C2=A0 memset(output, 0xAA, sizeof(output));<br>
+=C2=A0 =C2=A0 memset(expect, 0, sizeof(expect));<br>
+=C2=A0 =C2=A0 asm volatile(&quot;r0 =3D #0xff\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;v0 =3D=
 vsplat(r0)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;r1 =3D=
 #0x1\n&quot;<br></blockquote><div><br></div><div>Ditto</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;v1 =3D=
 vsplat(r1)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;v2 =3D=
 vsplat(r1)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;{\n&qu=
ot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0=
 =C2=A0 v0.sf =3D vadd(v1.sf, v2.sf)\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=C2=A0=
 =C2=A0 vmem(%0 + #0) =3D <a href=3D"http://v0.new" rel=3D"noreferrer" targ=
et=3D"_blank">v0.new</a>\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;}\n&qu=
ot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: &quot;r&qu=
ot;(output)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: &quot;r0&q=
uot;, &quot;r1&quot;, &quot;v0&quot;, &quot;v1&quot;, &quot;v2&quot;, &quot=
;memory&quot;);<br>
+=C2=A0 =C2=A0 check_output_w(__LINE__, 1);<br>
+}<br>
+<br>
+int main(void)<br>
+{<br>
+=C2=A0 =C2=A0 test_disabled();<br>
+=C2=A0 =C2=A0 test_disabled_with_new();<br>
+=C2=A0 =C2=A0 puts(err ? &quot;FAIL&quot; : &quot;PASS&quot;);<br>
+=C2=A0 =C2=A0 return err ? 1 : 0;<br>
+}<br>
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile=
.target<br>
index 549c95082f..789721bdac 100644<br>
--- a/tests/tcg/hexagon/Makefile.target<br>
+++ b/tests/tcg/hexagon/Makefile.target<br>
@@ -50,6 +50,8 @@ HEX_TESTS +=3D vector_add_int<br>
=C2=A0HEX_TESTS +=3D scatter_gather<br>
=C2=A0HEX_TESTS +=3D hvx_misc<br>
=C2=A0HEX_TESTS +=3D hvx_histogram<br>
+HEX_TESTS +=3D fp_hvx<br>
+HEX_TESTS +=3D fp_hvx_disabled<br>
=C2=A0HEX_TESTS +=3D invalid-slots<br>
=C2=A0HEX_TESTS +=3D invalid-encoding<br>
=C2=A0HEX_TESTS +=3D multiple-writes<br>
@@ -126,6 +128,12 @@ v68_hvx: CFLAGS +=3D -mhvx -Wno-unused-function<br>
=C2=A0v69_hvx: v69_hvx.c hvx_misc.h<br>
=C2=A0v69_hvx: CFLAGS +=3D -mhvx -Wno-unused-function<br>
=C2=A0v73_scalar: CFLAGS +=3D -Wno-unused-function<br>
+fp_hvx: fp_hvx.c hvx_misc.h<br></blockquote><div><br></div><div>Also hex_t=
est.h</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
+fp_hvx: CFLAGS +=3D -mhvx -mhvx-ieee-fp<br>
+fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h<br></blockquote><div><br></d=
iv><div>Also hex_test.h</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
+fp_hvx_disabled: CFLAGS +=3D -mhvx -mhvx-ieee-fp<br>
+<br>
+run-fp_hvx_disabled: QEMU_OPTS +=3D -cpu v73,ieee-fp=3Dfalse<br>
<br>
=C2=A0hvx_histogram: hvx_histogram.c hvx_histogram_row.S<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(CC) $(CFLAGS) $(CROSS_CC_GUEST_CFLAGS) $^ -o =
$@ $(LDFLAGS)<br></blockquote><div><br></div><div>Otherwise</div><div>Revie=
wed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com">ltay=
lorsimpson@gmail.com</a>&gt;</div><div>=C2=A0</div></div></div>

--000000000000488230064f09db0a--

