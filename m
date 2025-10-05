Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9454CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 14:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5PMO-0000ep-Vq; Sun, 05 Oct 2025 10:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shlomolevi354@gmail.com>)
 id 1v5IDm-0000nf-AP
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 02:27:50 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shlomolevi354@gmail.com>)
 id 1v5IDj-00057F-N4
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 02:27:49 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-58afb2f42e3so4463059e87.2
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 23:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759645661; x=1760250461; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=y1cBylOV6yn+vUTVhr6kQopUK6piHTSKbvkC8ZmT0fM=;
 b=TupYa8wsGyKS0MxctPUCrvotP1XS3LZcwS7COVPaLOz0mWB4a8jAwDGr0gdaN4RetD
 qlwZnpSlIlF1o99Y42eBoT9rLREpaC9h4u6mt1KF8PmKsdvL8YjtFx2Wm4fR5wt93CTv
 vtIINXwcE4Ql/Pu1sRapzbXyqVHBuYlXO6q+lbD+LG0pdy51Q2erQy7HLNy2MdnRWdl5
 PrIveEmb+MSO7hoeCEyJFWRjmfoeoH1KpESBC7Yv2zXnujeODWonPiQVPUmoGX3ZZSAp
 BsboGKi1/JepXfhMWvU7qcCelQegSZGHsYJ3xysVp7O1Lb8Bi4Vn55KQh2JgYw4XqIrL
 pa1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759645661; x=1760250461;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y1cBylOV6yn+vUTVhr6kQopUK6piHTSKbvkC8ZmT0fM=;
 b=VmNK8qUrbSQt9TTuWaBO5pjTK4QvNZTwKL/6akDHFrg5OBczRIuQCIYhz9lDC+WQEn
 j/HJ+DATJDuEn42Rh+3u981gTfxCs2Bcjhn+/fIavcRp2Oz/DzprnYM9Wrds7mcmQFV7
 8zRjgZ3nv2GWGkh8BcGE3uBIjBdpTOHOPXc5hw1/jBsW/EUgh/wu34I85+Ll75qaNzb4
 xgKMyNFCF8vsIAYwcbMsLSL1kUCIAtmv2hb5MdrJlr7O927xE3NcqgzzmyA9iVTcfM7n
 tGzYB1G6CY8zDSgOP7Vab1rFw/lnBWY8OQA0Dl3p5m2LAqll3jc7H2je+Gsx4MpNIkCq
 KMsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1epiyodQk87UYK4W9Tcu3pD7KOBZeBT8QzyRWL7B78SW1sBfL3cm9WNmpfpawAKh+V3nc6P58qDjv@nongnu.org
X-Gm-Message-State: AOJu0Yw1RbjdWEgqho0rz/EdB+vlytru8Sm10zGEwPfkMsyDHXiL21R5
 bWrMSI8NKC8dnuItVH1poIqn0hpxvFOZApCwVx1uqwP0Be41W2wywcU9BjozMRc8VjNWuryhcZJ
 Ogu+lgg9bsUx1CyZ75XWr9XFnOUTd82U=
X-Gm-Gg: ASbGncuaEuHBS8/FNUzVJZ1mq1KrwPY4TmTYXZ7PkZl1YRtXnBNxdaCSPocqIsEp+wH
 dp7jFm6ov8OjGZDYVmWskmyzD176/lq3C+ACx33wLDQZD+7//sO9SfD3ybWR0Slbt0sSJsusznj
 tKHPuVLAuudmHoMBhsyeKOfcrXMBnziNhfoNNCV6ee7/M/ZWKnmvJ4PG6jalKeVM7c6mXXJLjul
 fnrYaTcK0uFNI6clIvlvYu8n5VQcSFVhwIKuENi
X-Google-Smtp-Source: AGHT+IFROLCJbn7KSVUo1ZwqslqgZSiZOUJh8AiEwjJKLg2njRcgGcRuMfQktCHrQCwC0B/Goe6CBmQNVyPIQt9OaH8=
X-Received: by 2002:ac2:4bd3:0:b0:58b:43:9d92 with SMTP id
 2adb3069b0e04-58cbbfc32afmr2935276e87.51.1759645660796; 
 Sat, 04 Oct 2025 23:27:40 -0700 (PDT)
MIME-Version: 1.0
From: Shlomo Levi <shlomolevi354@gmail.com>
Date: Sun, 5 Oct 2025 09:27:29 +0300
X-Gm-Features: AS18NWA3tyIaAvXNYxJ91apNCcbZDPev5fTbjOdxkpSILBvNJ3-SEtid8xXNZ68
Message-ID: <CAP6KXTWhYzzSGq-P5ntsaTqy6Qt01XfG+MGzwT+qBFBU12jhow@mail.gmail.com>
Subject: [PATCH 1/1] Possibly bug where the wrong register is used when
 writing to the watchdog on imx2
To: peter.maydell@linaro.org, jcd@tribudubois.net, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000008adb5f0640636e23"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=shlomolevi354@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 05 Oct 2025 10:05:11 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000008adb5f0640636e23
Content-Type: text/plain; charset="UTF-8"

Noticed this while trying to learn more about watchdog in general, and
specifically on imx.
WICR was used to "negate" writes to write-once registers, but those
registers are part of WCR, not WICR (as can be seen from the fact that
later WCR is assigned the value),
so WCR should be used instead.

I had some trouble setting up git send-email, so I hope the format turned
out OK.

Signed-off-by: Shlomo Levi <shlomolevi354@gmail.com>
---
 hw/watchdog/wdt_imx2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index 10151a15d0..784ab79555 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -156,18 +156,18 @@ static void imx2_wdt_write(void *opaque, hwaddr addr,
     case IMX2_WDT_WCR:
         if (s->wcr_locked) {
             value &= ~IMX2_WDT_WCR_LOCK_MASK;
-            value |= (s->wicr & IMX2_WDT_WCR_LOCK_MASK);
+            value |= (s->wcr & IMX2_WDT_WCR_LOCK_MASK);
         }
         s->wcr_locked = true;
         if (s->wcr_wde_locked) {
             value &= ~IMX2_WDT_WCR_WDE;
-            value |= (s->wicr & ~IMX2_WDT_WCR_WDE);
+            value |= (s->wcr & ~IMX2_WDT_WCR_WDE);
         } else if (value & IMX2_WDT_WCR_WDE) {
             s->wcr_wde_locked = true;
         }
         if (s->wcr_wdt_locked) {
             value &= ~IMX2_WDT_WCR_WDT;
-            value |= (s->wicr & ~IMX2_WDT_WCR_WDT);
+            value |= (s->wcr & ~IMX2_WDT_WCR_WDT);
         } else if (value & IMX2_WDT_WCR_WDT) {
             s->wcr_wdt_locked = true;
         }
--

--0000000000008adb5f0640636e23
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Noticed this while trying to learn more a=
bout watchdog in general, and specifically on imx.<br>WICR was used to &quo=
t;negate&quot; writes to write-once registers, but those registers are part=
 of WCR, not WICR (as can be seen from the fact that later WCR is assigned =
the value),<br>so WCR should be used instead.</div><div dir=3D"ltr"><br></d=
iv><div>I had some trouble setting up git send-email, so I hope the format =
turned out OK.</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">Signed-off-=
by: Shlomo Levi &lt;<a href=3D"mailto:shlomolevi354@gmail.com" target=3D"_b=
lank">shlomolevi354@gmail.com</a>&gt;<br>---<br>=C2=A0hw/watchdog/wdt_imx2.=
c | 6 +++---<br>=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br><b=
r>diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c<br>index 101=
51a15d0..784ab79555 100644<br>--- a/hw/watchdog/wdt_imx2.c<br>+++ b/hw/watc=
hdog/wdt_imx2.c<br>@@ -156,18 +156,18 @@ static void imx2_wdt_write(void *o=
paque, hwaddr addr,<br>=C2=A0 =C2=A0 =C2=A0case IMX2_WDT_WCR:<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;wcr_locked) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0value &amp;=3D ~IMX2_WDT_WCR_LOCK_MASK;<br>- =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value |=3D (s-&gt;wicr &amp; IMX2_WDT_WC=
R_LOCK_MASK);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value |=3D (s-&=
gt;wcr &amp; IMX2_WDT_WCR_LOCK_MASK);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;wcr_locked =3D true;<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;wcr_wde_locked) {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value &amp;=3D ~IMX2_WDT_WCR_WDE;<br>- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value |=3D (s-&gt;wicr &amp; ~IMX2=
_WDT_WCR_WDE);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value |=3D (s-=
&gt;wcr &amp; ~IMX2_WDT_WCR_WDE);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} el=
se if (value &amp; IMX2_WDT_WCR_WDE) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;wcr_wde_locked =3D true;<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;wcr_wdt_locked) =
{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value &amp;=3D ~IMX2_W=
DT_WCR_WDT;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value |=3D (s-&gt=
;wicr &amp; ~IMX2_WDT_WCR_WDT);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0value |=3D (s-&gt;wcr &amp; ~IMX2_WDT_WCR_WDT);<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0} else if (value &amp; IMX2_WDT_WCR_WDT) {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;wcr_wdt_locked =3D true;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>--</div>
</div>

--0000000000008adb5f0640636e23--

