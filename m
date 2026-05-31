Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F136CD5BD1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 04:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTY3C-0005oT-CZ; Sun, 31 May 2026 00:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTY3A-0005nw-7u
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:45:24 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTY38-0001wY-G4
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:45:23 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2be1dd4af34so137851755ad.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 21:45:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780202721; cv=none;
 d=google.com; s=arc-20240605;
 b=aimA6ytOTQ1fwMvhmSjmI17VlHf4EIiQr+iV2eNvxSMCbXqzlA8MfJqE2oDHLSs4f3
 y7H6+dE9YHO0kX7iYs1IzSXffMI6X2eIv11oPDPJC5VsW72cbymT9BHD5o98BvQTUAhC
 H5j5HKwnFcbdN8wZVlSz3ry3qBqsPSHaEwJubhvuc0/cfAgqiuivMzJwcJzPfr41pM5a
 wkc3jrX8jERbs+awNUKwTOz1s16PehxaSJX3QuO1Kk69TFC1smYHrl3Vla8VORfQQLad
 ixdHq9Qu/910wTbsKlGAeMcIIt7bBF0tti0V5alwOEbbZ9TuBT6WcY0BTAU4p981Ap2j
 3ZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jMUaN2mK6QvdcV6QAQn6pFE8Rhqvdm8Pdwam40bg9Eg=;
 fh=+DxRVnEC95Ptxk5HMfIFqaUwIao1HhLaAPFCgZPm1R4=;
 b=XJ8vvDw1o51+VpI1ZgN5MNWU9ztFkDP8v6hwLA8aTsKE9ZStoMN9qO+kA3TuvUqhx+
 S50111QxU3m9Pc6FDerObbuoBxjUZzdoEOlW5qzBdQu+axBGAtrpQlYMvW1xhLMwsdxj
 KUS7ni5DE4yRli4WTrHhsqoi5x9MLdNxoRLmWNLfztk5tvVHKy9KKakbtVLP4HDQ3O7l
 jp19qVTIyfN45PmVShTS0+qACFYGAf8mORv6Omg5dFmBLM4YpklkTD5x3JBLErLxxK+H
 VGeuNQVbqAy9eSP0vgfOfv/buzb3GJw8OvmfoEtPc4ls3B0qxB95UBJ7zHinvKt9Hqiy
 rYdQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1780202721; x=1780807521;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jMUaN2mK6QvdcV6QAQn6pFE8Rhqvdm8Pdwam40bg9Eg=;
 b=Z5j5VzNfAmmetv9dJfnduI95FmlIEC5qTyCb/k3qAiGGwsOpDyW450rB7HA6eUFB9l
 pzWU8aZZdeUuw6QVT1WSidbwdXq8TqLs5e5tNXlufz5bvqXZCZaeoNzGg0wMH4xw5U85
 K3AfZZo2DRW14r2ZkA6D/I2iAo6U5axqN6qqW2zPA92AHkEG/pob+/0NYiy/1LZ8n9P8
 C34cm+gRUpsK/0te6b9uou49tbkM42iTq0byviA++o1i6oZnkuBUVnglcpFP010jL1Qr
 rHMdcCcBtnYr9a4b59e2VhqwwrlYelJYuRyGkfFXxS5SWEuGIHC6nfzYJs5WKAFdtabm
 M96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780202721; x=1780807521;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jMUaN2mK6QvdcV6QAQn6pFE8Rhqvdm8Pdwam40bg9Eg=;
 b=d4cjc8hHGEXUWOz8aXOnRjEV3Ru3SztmhgmjMaJhhyxt1StZt3x4LTcRxVR9dfWmN6
 0cYZSV4+cVlOw8yaRUe08OaceeGEeUHrViLDLMvQxBMdATc5dKtqy0vu6kA43hO7E3Fo
 rcvby8raAVV+oVRLPRiOwKdQ03gO9HlF8Bs7pEQfzAnObYBS3FOaxpAF0N+uGtCmyjHu
 Idi6ZzwryDvZmThT5V4ielkQ2WrrxSqQ1j8p9wgzcjfbqXJ7Ou3rTOwDTJFFKsECpcUA
 FohgsvSXSYTf+bhWS5i1bvgFG7dVYktimqYhSrDp6a+LkLhJ9K1XrNY1oBDjv0nlvaDw
 zuXw==
X-Gm-Message-State: AOJu0Yx/guPXcRgq600tzquzvZSehBO1XemPTg7Pzu8oPK3HpQLG6M/m
 fmIALXjnodVm0kGabIvZEyD4mBDmK82vxS8gqZBZixz6XCOs1CDynd2CirZ31fpAN4SSUNweUJj
 cNX5uYGCaZU4s26rwB8tBy9GNhzIOgu+qmntgO7+Vpw==
X-Gm-Gg: Acq92OEBOdLndAncO1DxEonASLjm2e0POm/kzwxdzwhgpZvJE3+ZZCvMYOX/EgthkCQ
 b7XJkG0GiuyGCV2z3azUPlBqYAlQgdRlkGGeiKJJl6iiyE9Sv+NMpkvlwox4mn3VGQTaslmdLrb
 KaTnt5rooiNURpTJ7NASXsaQeMt01QxddlndYMN3Kmd+76edrYej13ovIBcXIhRP87FppNzOWYm
 fPOjpFvKWWMBrECwgLozq7CXIfKkAKKdRlVS9qlJ/iFZvd9TsOepd0MjPD1qR2wEjwPpEg6K4hL
 BsRWdXgq3V+VWvope7fSBrAiwfptIsrHhF41QF++Zuf+fKo=
X-Received: by 2002:a17:902:e74d:b0:2c0:b932:8680 with SMTP id
 d9443c01a7336-2c0b9328f18mr29091705ad.10.1780202720928; Sat, 30 May 2026
 21:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-14-richard.henderson@linaro.org>
In-Reply-To: <20260530211248.375318-14-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 30 May 2026 22:45:08 -0600
X-Gm-Features: AVHnY4JwS6TW6z1NSu9xpE_hBQu90VzSBNhJkEkR6AC8e2CdQSWEo3buR7VL82o
Message-ID: <CANCZdfr=C8n_cDQa3jWgSCMuoqnC-v0+qJnepjLKH0jMozXmeg@mail.gmail.com>
Subject: Re: [PATCH 13/13] common-user: Move guest_base,
 have_guest_base to probe-guest-base.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Content-Type: multipart/alternative; boundary="000000000000cf3c5c065315becc"
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x62f.google.com
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

--000000000000cf3c5c065315becc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 3:13=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Unify the definitions of guest_base and have_guest_base.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/main.c                | 3 +--
>  common-user/probe-guest-base.c | 4 ++++
>  linux-user/main.c              | 2 --
>  3 files changed, 5 insertions(+), 4 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>


> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index 772a26199b..3201da2318 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -62,8 +62,7 @@ intptr_t qemu_host_page_mask;
>
>  static bool opt_one_insn_per_tb;
>  static unsigned long opt_tb_size;
> -uintptr_t guest_base;
> -bool have_guest_base;
> +
>  /*
>   * When running 32-on-64 we should make sure we can fit all of the
> possible
>   * guest address space into a contiguous chunk of virtual host memory.
> diff --git a/common-user/probe-guest-base.c
> b/common-user/probe-guest-base.c
> index 77722fe63f..6f1247cf1a 100644
> --- a/common-user/probe-guest-base.c
> +++ b/common-user/probe-guest-base.c
> @@ -7,6 +7,7 @@
>  #include "qemu/log.h"
>  #include "user/guest-base.h"
>  #include "user/mmap-min-addr.h"
> +#include "user/guest-base.h"
>  #include "user/guest-host.h"
>  #include "user/probe-guest-base.h"
>  #include "user/selfmap.h"
> @@ -18,6 +19,9 @@
>  #define MAP_FIXED_NOREPLACE  (MAP_FIXED | MAP_EXCL)
>  #endif
>
> +uintptr_t guest_base;
> +bool have_guest_base;
> +
>  /**
>   * pgb_try_mmap:
>   * @addr: host start address
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 01cf5bf079..60a695b7ca 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -79,8 +79,6 @@ static envlist_t *envlist;
>  static const char *cpu_model;
>  static const char *cpu_type;
>  static const char *seed_optarg;
> -uintptr_t guest_base;
> -bool have_guest_base;
>
>  /*
>   * Used to implement backwards-compatibility for the `-strace`, and
> --
> 2.43.0
>
>

--000000000000cf3c5c065315becc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 30,=
 2026 at 3:13=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.he=
nderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Unify the definitions of gu=
est_base and have_guest_base.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 3 +--<br>
=C2=A0common-user/probe-guest-base.c | 4 ++++<br>
=C2=A0linux-user/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2=
 --<br>
=C2=A03 files changed, 5 insertions(+), 4 deletions(-)<br></blockquote><div=
><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.c=
om">imp@bsdimp.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
diff --git a/bsd-user/main.c b/bsd-user/main.c<br>
index 772a26199b..3201da2318 100644<br>
--- a/bsd-user/main.c<br>
+++ b/bsd-user/main.c<br>
@@ -62,8 +62,7 @@ intptr_t qemu_host_page_mask;<br>
<br>
=C2=A0static bool opt_one_insn_per_tb;<br>
=C2=A0static unsigned long opt_tb_size;<br>
-uintptr_t guest_base;<br>
-bool have_guest_base;<br>
+<br>
=C2=A0/*<br>
=C2=A0 * When running 32-on-64 we should make sure we can fit all of the po=
ssible<br>
=C2=A0 * guest address space into a contiguous chunk of virtual host memory=
.<br>
diff --git a/common-user/probe-guest-base.c b/common-user/probe-guest-base.=
c<br>
index 77722fe63f..6f1247cf1a 100644<br>
--- a/common-user/probe-guest-base.c<br>
+++ b/common-user/probe-guest-base.c<br>
@@ -7,6 +7,7 @@<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
=C2=A0#include &quot;user/guest-base.h&quot;<br>
=C2=A0#include &quot;user/mmap-min-addr.h&quot;<br>
+#include &quot;user/guest-base.h&quot;<br>
=C2=A0#include &quot;user/guest-host.h&quot;<br>
=C2=A0#include &quot;user/probe-guest-base.h&quot;<br>
=C2=A0#include &quot;user/selfmap.h&quot;<br>
@@ -18,6 +19,9 @@<br>
=C2=A0#define MAP_FIXED_NOREPLACE=C2=A0 (MAP_FIXED | MAP_EXCL)<br>
=C2=A0#endif<br>
<br>
+uintptr_t guest_base;<br>
+bool have_guest_base;<br>
+<br>
=C2=A0/**<br>
=C2=A0 * pgb_try_mmap:<br>
=C2=A0 * @addr: host start address<br>
diff --git a/linux-user/main.c b/linux-user/main.c<br>
index 01cf5bf079..60a695b7ca 100644<br>
--- a/linux-user/main.c<br>
+++ b/linux-user/main.c<br>
@@ -79,8 +79,6 @@ static envlist_t *envlist;<br>
=C2=A0static const char *cpu_model;<br>
=C2=A0static const char *cpu_type;<br>
=C2=A0static const char *seed_optarg;<br>
-uintptr_t guest_base;<br>
-bool have_guest_base;<br>
<br>
=C2=A0/*<br>
=C2=A0 * Used to implement backwards-compatibility for the `-strace`, and<b=
r>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000cf3c5c065315becc--

