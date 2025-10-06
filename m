Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7420ACAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 17:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5p8H-00081I-QF; Mon, 06 Oct 2025 13:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1v5p8F-0007xU-T2
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 13:36:19 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1v5p8C-0004vD-M3
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 13:36:19 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b6271ea3a6fso2964224a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 10:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759772170; x=1760376970; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3C6CwuqIFrFI2iiklFYKdtcNRgwZcaZQoza37YVI6Y=;
 b=dYFtnmoPoKCfmNxQzhzlXIotE0mbPoHTXysUggVCEXXrHyleh4KE4JfhJih9AlLASY
 qD4jRlPGkHqU6Rcxv8ZwVAch/kdxZHNX5+EZyu9YgusTimYj7vFZdmFeSVECtm8rZGbh
 aiPUAx3icaWyorC6mBXwG8QU/1NfowsubNYLh1Uv0o4+gneyW3Zk+P7feBKIk36HaEMz
 HCMmFSkFQnKseyOMkGlNfG8/3qCBbnXmgUT3m3LyRlp8mmm2+wkLjSL6I4uRptqU2Vrj
 tjxlikwps+bZvM7S9I6Wdq2eszGKFqbcvjdKC5a2xde0mHdSCKH+Njw/xwF0wPXSyNS5
 boOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759772170; x=1760376970;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q3C6CwuqIFrFI2iiklFYKdtcNRgwZcaZQoza37YVI6Y=;
 b=PqDwdHos5NzlTCd5Su2kws+dHGypIBRNiDw5o7ezfmw1DiVX/95qKc88pMIEv7uN84
 qeeyC6+iEePQvxs+HTB/2rf/fg3IJsj2vGniwKVr6HYhY22QvFBYr8VpwNtOc9nd9v3B
 ymFsuvFGWsWAVly+lb2Se46xd8i5IrIH4ka9L/zRzzlH/PFSV7DlHLZv0ODDG54wI2jU
 O2np25do6OtZFPs4MzZen6ibLWDOOLM4fQyjrPNULyznRzBLAaiefSSsIq30LKHlHUbw
 i68wrWkZNT1VUda6X4Pb3CVIoirzudmkwwxsd8wRrc/w5Sc7HgOKhYHdllG/tjydY4pw
 Ox/A==
X-Gm-Message-State: AOJu0YwcJTJS5czE0yMGSaP2mKq3sF/vsr/VEecBB1bKbwJWhdygG9/b
 4+6sdT6EKfhUzyN70zJkMp0hhROIsYJTDbRoiRx5AKBawTij9LZUJBj0LNM7KJORd4r05U0xTCv
 A9BNeGNUEk+PUfktOwkOmNM6mwG5HPjWQybvoeOKDUw==
X-Gm-Gg: ASbGncsS4yQpnaT7yV7ZKNHjyavmvwlqnp8FJexnrxoYiVuQSoSzCYivZS6A8XsXjui
 ep0DjPA+178NaVBKjBx/SSjj/dg1rybowUAakrFaCGxdJ5iaQplCdTS+9XtgTcketrocQ0zR7oj
 XLqSlZmi59P9otUvRAxKZXtnYjFTh3cFapf8zV/JH9axcotAe5D8qTBlb/6pmVcvIdubwGqy3V1
 +hsQPo8kKdDgiRny+6qv/cI+FdVnA==
X-Google-Smtp-Source: AGHT+IEIPK10UABKg8NL03FDJA81+SiXWFxxPBN/jVhYAXi08ON2MHpu2SKWUGGjuD3n1nVLPwZOL9APBAOI0NOi8II=
X-Received: by 2002:a17:903:11cf:b0:275:b1cf:6dd7 with SMTP id
 d9443c01a7336-28e9a61a9a0mr152506755ad.34.1759772170111; Mon, 06 Oct 2025
 10:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20251006173350.17455-1-philmd@linaro.org>
In-Reply-To: <20251006173350.17455-1-philmd@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Mon, 6 Oct 2025 19:35:57 +0200
X-Gm-Features: AS18NWDfcfqo26xRjAetJgiUC6-QceKursJYBV9sUI8JC5d3EJkqx9GIj4w78LI
Message-ID: <CAJy5ezrAs7i9_gQjBTLXanFCYotTgJuL7DuecNwLTZtvTTEp4A@mail.gmail.com>
Subject: Re: [PATCH] linux-user/microblaze: Fix little-endianness binary
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000015ce77064080e32d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-pg1-x52e.google.com
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

--00000000000015ce77064080e32d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 7:33=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> MicroBlaze CPU model has a "little-endian" property, pointing to
> the @endi internal field. Commit c36ec3a9655 ("hw/microblaze:
> Explicit CPU endianness") took care of having all MicroBlaze
> boards with an explicit default endianness, so later commit
> 415aae543ed ("target/microblaze: Consider endianness while
> translating code") could infer the endianness at runtime from
> the @endi field, and not a compile time via the TARGET_BIG_ENDIAN
> definition. Doing so, we forgot to make the endianness explicit
> on user emulation, so there all CPUs are started with the default
> "little-endian=3Doff" value, leading to breaking support for little
> endian binaries:
>
>   $ readelf -h ./hello-world-mbel
>   ELF Header:
>     Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
>     Class:                             ELF32
>     Data:                              2's complement, little endian
>
>   $ qemu-microblazeel ./hello-world-mbel
>   qemu: uncaught target signal 11 (Segmentation fault) - core dumped
>   Segmentation fault (core dumped)
>
> Fix by restoring the previous behavior of starting with the
> builtin endianness of the binary:
>
>   $ qemu-microblazeel ./hello-world-mbel
>   Hello World
>
> Cc: qemu-stable@nongnu.org
> Fixes: 415aae543ed ("target/microblaze: Consider endianness while
> translating code")
> Reported-by: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> ---
>  linux-user/microblaze/elfload.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/linux-user/microblaze/elfload.c
> b/linux-user/microblaze/elfload.c
> index 7eb1b26d170..bdc0a953d59 100644
> --- a/linux-user/microblaze/elfload.c
> +++ b/linux-user/microblaze/elfload.c
> @@ -8,7 +8,8 @@
>
>  const char *get_elf_cpu_model(uint32_t eflags)
>  {
> -    return "any";
> +    return TARGET_BIG_ENDIAN ? "any,little-endian=3Doff"
> +                             : "any,little-endian=3Don";
>  }
>
>  void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMBState *env)
> --
> 2.51.0
>
>

--00000000000015ce77064080e32d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, Oct 6, 2025 at 7:33=E2=80=AFPM Ph=
ilippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@l=
inaro.org</a>&gt; wrote:</div><div class=3D"gmail_quote gmail_quote_contain=
er"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">MicroBlaze CPU model =
has a &quot;little-endian&quot; property, pointing to<br>
the @endi internal field. Commit c36ec3a9655 (&quot;hw/microblaze:<br>
Explicit CPU endianness&quot;) took care of having all MicroBlaze<br>
boards with an explicit default endianness, so later commit<br>
415aae543ed (&quot;target/microblaze: Consider endianness while<br>
translating code&quot;) could infer the endianness at runtime from<br>
the @endi field, and not a compile time via the TARGET_BIG_ENDIAN<br>
definition. Doing so, we forgot to make the endianness explicit<br>
on user emulation, so there all CPUs are started with the default<br>
&quot;little-endian=3Doff&quot; value, leading to breaking support for litt=
le<br>
endian binaries:<br>
<br>
=C2=A0 $ readelf -h ./hello-world-mbel<br>
=C2=A0 ELF Header:<br>
=C2=A0 =C2=A0 Magic:=C2=A0 =C2=A07f 45 4c 46 01 01 01 00 00 00 00 00 00 00 =
00 00<br>
=C2=A0 =C2=A0 Class:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ELF32<br>
=C2=A0 =C2=A0 Data:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2&#39;s complement, little=
 endian<br>
<br>
=C2=A0 $ qemu-microblazeel ./hello-world-mbel<br>
=C2=A0 qemu: uncaught target signal 11 (Segmentation fault) - core dumped<b=
r>
=C2=A0 Segmentation fault (core dumped)<br>
<br>
Fix by restoring the previous behavior of starting with the<br>
builtin endianness of the binary:<br>
<br>
=C2=A0 $ qemu-microblazeel ./hello-world-mbel<br>
=C2=A0 Hello World<br>
<br>
Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-stable=
@nongnu.org</a><br>
Fixes: 415aae543ed (&quot;target/microblaze: Consider endianness while tran=
slating code&quot;)<br>
Reported-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@gmail.c=
om" target=3D"_blank">edgar.iglesias@gmail.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.ig=
lesias@amd.com">edgar.iglesias@amd.com</a>&gt;<br></div><div><br></div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0linux-user/microblaze/elfload.c | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/linux-user/microblaze/elfload.c b/linux-user/microblaze/elfloa=
d.c<br>
index 7eb1b26d170..bdc0a953d59 100644<br>
--- a/linux-user/microblaze/elfload.c<br>
+++ b/linux-user/microblaze/elfload.c<br>
@@ -8,7 +8,8 @@<br>
<br>
=C2=A0const char *get_elf_cpu_model(uint32_t eflags)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return &quot;any&quot;;<br>
+=C2=A0 =C2=A0 return TARGET_BIG_ENDIAN ? &quot;any,little-endian=3Doff&quo=
t;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: &quot;any,little-endian=3Don&quot;;<br>
=C2=A0}<br>
<br>
=C2=A0void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMBState *en=
v)<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div></div>

--00000000000015ce77064080e32d--

