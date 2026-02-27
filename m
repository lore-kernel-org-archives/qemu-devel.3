Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8263EFEFB48
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 12:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvwrE-0008N3-6K; Fri, 27 Feb 2026 07:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vvwrA-0008Lc-KH
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 07:22:10 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vvwr6-0004lb-LU
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 07:22:08 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-354c19bf64bso824686a91.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 04:22:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772194922; cv=none;
 d=google.com; s=arc-20240605;
 b=SQFBS/V3Ym0PozQOCGzK4z+rMeePChdgKqLivYr3T/DC8RG426ynZ/phx9jrdHAQNy
 7tmN36FO7YDuBwLI77LbraMplZp+VQCTbqCMs6rItriRI3I60RxDrTJs+XDk5uEgxjeb
 A/Cimal3rZ3xB/7paHESYP/dJlweFyODUF5DZYArWVH1Fpgdpfa4+zgtqcdCFeV9hGid
 1XJTwnAeK1UmLscWCOkYtAvt390MmF0EBuqXMSwPBiTAZjI6Wq51UuzOz1KgpURKAn9x
 3VLFREZy6v/BnlhI9HyNQcj4xz3ymZI9+D5kIPk0mcHOsO+mf5xK8J5z+n9yz9YczNyf
 rasA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sltoDfI7b+Q6VzMhsvUxu98Dr2T+egh3zldsnt/YSy8=;
 fh=YTxI/2B0tIA4OGE8g1nLoHfXTEPH/KCzPpRqw/hY+Dc=;
 b=Gi1M/A3rZRdJTB5VZ2M2F7IIZHTB5/AZr9DybembObK2778h7P1h3Uyf+WJEJyEYPX
 wam7aDEUcZ8t/5g/Rxv0embYada3Hp5He82MFPKE3V+1GOWsb6ckqE/LxUPYjBiK+6CG
 Bjzv2KT5xIsZtLS8iwpWHE9+CDt/TFv6eP7hEXzH9wudiQRYOnou7QcLim9J6R366ezf
 C2Fa1nMh3qHYar+XDVZPx1k8QvfjKB6/TVPn7KfQhPFrarsWrjE5ra8jdw97SeAnkwhq
 rs577V14jm+MCoPwv8wcMYliSxPKPXlB+OzVPAgpF7X4XLX4iuZIwN2bIceAMarH/o8e
 5vHQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772194922; x=1772799722;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sltoDfI7b+Q6VzMhsvUxu98Dr2T+egh3zldsnt/YSy8=;
 b=IBLNSeRkQ7k7VKDTRGcNGTV4MCWE1MYwutiALLEBSXfvoV/McWXq2jYh+aT37ZtWr4
 LFbAKCGHWzEpAO8zaZyGw1QxJOmbWV4JelR4XVN3G8Q7EEFBCBGUcbmfEFlidWztZyEM
 WmlMBhprTIkxKwjj3vxIyRW4EVayYoUqILfyzWQ8WS56oLYTZlBUW96jbHmfxZEuFHN1
 RjAbKeL+ES7WR8vHQf7CyJKP7GPj7ydFXOzCpK4ozz+vCT6DGC60KLx7KICulWJmCrcd
 innSoDjMOCPWdj4ACNt0zZNElXs/IZOUAaWHrG3pdzh8byLNJFQohohSVQPjEzICyZry
 klMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772194922; x=1772799722;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sltoDfI7b+Q6VzMhsvUxu98Dr2T+egh3zldsnt/YSy8=;
 b=TpS58IZ9FLT2sL5RX1M5J1EbREg/XmFunDRS3bf3kfJ0tNku/uY8BvHbMAYqyx8xxK
 jCDj2UadHq5xKPH1stzaoXXocd4mz86uOl1X5uBfViM1PV+03dzYCE+zH4paTslfxpwS
 CRxUIRM+HscIRlny+23RaR4c9rLt3O4ei4LnYhFfiyYMC3aqeewRAp9llLPpgv/8MxnO
 u8GqsOIQMVx9DfJJCcUr1ePvLal0eWqtKE2s5bc+25rLOx1PpEMLCy8NtCYQwb1hm8VZ
 d+ZVBn+NzSj6ul4lEvZ4O65vNSzsEuHrn/G3g4/D2rh0ktptEQ9JldlmyNODyu3Fk4ne
 5qUw==
X-Gm-Message-State: AOJu0YxSeSVgXboDO8MJicKZthtSoGGMfpEGgLsBCM/urNnAqDEi06u5
 +fvioY5OSefdfrfoD7AQ0oDXKwLHlhGBpv5PZ7g/1WqTKO3YrcXLJfqE0e8euxeCxU+Uq+cggmD
 jV11azQpgivHkNJ1jOg2OBYbCHM87iw3b7GSMkntzEnPQ+CnCVpNZhcQ=
X-Gm-Gg: ATEYQzwN/25bcAy4ynYAJyCRJXszRD0F4qSYezBenQkNBNF0QEpx++jL6Aa37C8YWcw
 7uFlx88rRmf/HFZnL43mE5kCtUDa15sUjXs/htuBCpwY57/2NDKiJv3qgTJFYHqKHsl+2Cw1ns0
 6cO7e3ycttCa7W9nGWE6kRZOmw/EtQ79T9dpr5Tpla+kJrpKXsxhMORw9M4msrui8Q6sQBZCuzx
 KBy+n2zZVk+M0CJJ4b6y21Yqn08NRsBw5ar3rADnuT0RTjGqnOebJVS4H8nuF/lk/gf+5DmfXGA
 4LjMftg=
X-Received: by 2002:a17:90b:4d10:b0:356:21e9:73ff with SMTP id
 98e67ed59e1d1-359690182femr2341573a91.11.1772194921907; Fri, 27 Feb 2026
 04:22:01 -0800 (PST)
MIME-Version: 1.0
References: <20260227104314.81038-1-philmd@linaro.org>
 <20260227104314.81038-3-philmd@linaro.org>
In-Reply-To: <20260227104314.81038-3-philmd@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 27 Feb 2026 05:21:51 -0700
X-Gm-Features: AaiRm52PmePY7DPk3z8LBAuJhlnAaI_DA4zWLE4wiPk78in47f-tX-F-LQW9rqI
Message-ID: <CANCZdfqZjEza8=+FosNW4O_ygbGB-fdF2nik5sdbpjUOY2a7ng@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] gdbstub: Remove 'gdb-xml/' directory prefix in
 TARGET_XML_FILES
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000cb11d1064bcd4857"
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102b.google.com
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

--000000000000cb11d1064bcd4857
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 3:44=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> All GDB XML files are in the gdb-xml/ directory. No need to be
> so verbose in TARGET_XML_FILES, let meson prepend the directory.
>
> Except meson.build lines, this is a mechanical change done running:
>
>  $ sed -i -e s,gdb-xml/,,g $(git grep -l gdb-xml configs/targets/)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

This looks fine, and should work with the modified meson. One observation..=
.

diff --git a/configs/targets/aarch64-bsd-user.mak
> b/configs/targets/aarch64-bsd-user.mak
> index 7f42e060477..3a839b301e4 100644
> --- a/configs/targets/aarch64-bsd-user.mak
> +++ b/configs/targets/aarch64-bsd-user.mak
> @@ -1,4 +1,4 @@
>  TARGET_ARCH=3Daarch64
>  TARGET_BASE_ARCH=3Darm
> -TARGET_XML_FILES=3D gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml
> gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-sme2.xml
> +TARGET_XML_FILES=3D aarch64-core.xml aarch64-fpu.xml aarch64-pauth.xml
> aarch64-sme2.xml
>

This seems to be missing aarch64-mte.xml that linux-user has. I have a
patch in my queue to fix this since it leads to an instant assertion in
some cases. When are you landing these changes so I can plan? Otherwise
we'll collide when we submit the pull requests. The patch came in as a pull
request on the upstream blitz...


>  TARGET_LONG_BITS=3D64
> diff --git a/configs/targets/aarch64-linux-user.mak
> b/configs/targets/aarch64-linux-user.mak
> index bf328b3b80c..ddfacc092dd 100644
> --- a/configs/targets/aarch64-linux-user.mak
> +++ b/configs/targets/aarch64-linux-user.mak
> @@ -1,6 +1,6 @@
>  TARGET_ARCH=3Daarch64
>  TARGET_BASE_ARCH=3Darm
> -TARGET_XML_FILES=3D gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml
> gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-mte.xml gdb-xml/aarch64-sme2.xm=
l
> +TARGET_XML_FILES=3D aarch64-core.xml aarch64-fpu.xml aarch64-pauth.xml
> aarch64-mte.xml aarch64-sme2.xml
>  TARGET_HAS_BFLT=3Dy
>  CONFIG_SEMIHOSTING=3Dy
>  CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy


Warner

--000000000000cb11d1064bcd4857
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 27,=
 2026 at 3:44=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:=
philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">All GDB XML files are in the gdb-xml/ d=
irectory. No need to be<br>
so verbose in TARGET_XML_FILES, let meson prepend the directory.<br>
<br>
Except meson.build lines, this is a mechanical change done running:<br>
<br>
=C2=A0$ sed -i -e s,gdb-xml/,,g $(git grep -l gdb-xml configs/targets/)<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com=
">imp@bsdimp.com</a>&gt;</div><div><br></div><div>This looks fine, and shou=
ld work with the modified meson. One observation...</div><div><br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">diff --git a/configs/targets=
/aarch64-bsd-user.mak b/configs/targets/aarch64-bsd-user.mak<br>
index 7f42e060477..3a839b301e4 100644<br>
--- a/configs/targets/aarch64-bsd-user.mak<br>
+++ b/configs/targets/aarch64-bsd-user.mak<br>
@@ -1,4 +1,4 @@<br>
=C2=A0TARGET_ARCH=3Daarch64<br>
=C2=A0TARGET_BASE_ARCH=3Darm<br>
-TARGET_XML_FILES=3D gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-x=
ml/aarch64-pauth.xml gdb-xml/aarch64-sme2.xml<br>
+TARGET_XML_FILES=3D aarch64-core.xml aarch64-fpu.xml aarch64-pauth.xml aar=
ch64-sme2.xml<br></blockquote><div><br></div><div>This seems to be missing =
aarch64-mte.xml that linux-user has. I have a patch in my queue to fix this=
 since it leads to an instant assertion in some cases. When are you landing=
 these changes so I can plan? Otherwise we&#39;ll collide when we submit th=
e pull requests. The patch came in as a pull request on the upstream blitz.=
..</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0TARGET_LONG_BITS=3D64<br>
diff --git a/configs/targets/aarch64-linux-user.mak b/configs/targets/aarch=
64-linux-user.mak<br>
index bf328b3b80c..ddfacc092dd 100644<br>
--- a/configs/targets/aarch64-linux-user.mak<br>
+++ b/configs/targets/aarch64-linux-user.mak<br>
@@ -1,6 +1,6 @@<br>
=C2=A0TARGET_ARCH=3Daarch64<br>
=C2=A0TARGET_BASE_ARCH=3Darm<br>
-TARGET_XML_FILES=3D gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-x=
ml/aarch64-pauth.xml gdb-xml/aarch64-mte.xml gdb-xml/aarch64-sme2.xml<br>
+TARGET_XML_FILES=3D aarch64-core.xml aarch64-fpu.xml aarch64-pauth.xml aar=
ch64-mte.xml aarch64-sme2.xml<br>
=C2=A0TARGET_HAS_BFLT=3Dy<br>
=C2=A0CONFIG_SEMIHOSTING=3Dy<br>
=C2=A0CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy</blockquote><div><br></div><div=
>Warner=C2=A0</div></div></div>

--000000000000cb11d1064bcd4857--

