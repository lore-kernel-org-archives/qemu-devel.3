Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D69AD3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 11:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZolu-0003ah-FF; Sun, 28 Dec 2025 06:17:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZolt-0003aL-D1
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 06:17:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZolr-0007gT-5b
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 06:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766920629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i1JMcCUheOqdKpaDs7nEs+Tc8EKYGNPqvKwgXdHCCa8=;
 b=XiAdcI8Gf5sMS1ye4LG5WKRCX0wedQzynq6EesrGs8Kd/4kLRW/bIiiNN6RkyXtTC6gBFf
 O0sZBfaLe6FyPvL3xwMV1QRG3mrTsW9aCv6CdzpeZZQjIlPFa1nC5V02+m3nYawyXtj0Ni
 W3AyxSc6zP+ayIaJU1OWK+paO0kBLc8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-P--4L7nIMrKzzW_616XXGg-1; Sun, 28 Dec 2025 06:17:07 -0500
X-MC-Unique: P--4L7nIMrKzzW_616XXGg-1
X-Mimecast-MFC-AGG-ID: P--4L7nIMrKzzW_616XXGg_1766920627
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430ffa9fccaso6611519f8f.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 03:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766920627; x=1767525427; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i1JMcCUheOqdKpaDs7nEs+Tc8EKYGNPqvKwgXdHCCa8=;
 b=UMNoHdzbYo5alWUBonxEmEWirCH+6px7+cS5+D4OLINLj3dvu70a+EpnlM8W8nef9X
 JtwrGrK75sbf0TaVezjgi6Y/LwKyNWrQMqdYAw9QjzlB/nVonGp99hKsvJx5QltN7rRo
 JUezm6SnrgRyWWxWEBhQu7n21Mz0oSa7gSjko2tQfDvr2Tiaj5PTMq7EE8z8m+1O+ejB
 789NcSG6NhEOnl5YwdlPX7irpy+Y1hCsKKJ4B4soassJe02KU0W4GEwOZSmih5e/zn7L
 Cfj3lwv2qGjp+nuFPWJohcqnpvGd03vldtZYMSvyBdcWLbOV1X05RAAwGJ1QXe0Uh3+R
 qJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766920627; x=1767525427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i1JMcCUheOqdKpaDs7nEs+Tc8EKYGNPqvKwgXdHCCa8=;
 b=RUq29ZMukGl6t2Mgh++ZQnbnpXU80wvoU/N9Wioa8RMXJ0mfgwLtjc78jdjupD8WYD
 jtU/NEic7o7S+w52Vzfg+42JPrHO+PH6XqSBwOpE7mD4xPCWn2AtuiLoNYcRWNQahzu4
 mvZDo2/w/PPTVzlUbNOBvpViTCJApu6CljjduW7AvjVqcUt1Kh5rBHX467Ry04RfzeZl
 tt/dSU/sYM+0/4CrX4BBwIeiE549DociFqWmuyIRseQiMDCMWcZfzAoX/4SbWe0iY/Tp
 VZP7sVCX5Bq7UPVWp+zbnBVgdQdcdZtEeD4m6lKtN5BLit5vzWM26wJJRxoCIynQYeH3
 aHGw==
X-Gm-Message-State: AOJu0YxSudjhcP+PETbJSBosk895HBoAr0J6DXwTdOOprZMcWiWmpyCC
 a5/bvqIhWUrYqze8t19OqQN8nIXi6MBwB3ZS2aMUagv74I1k74JONcmqRTD+l6aKaF8vWxLup5d
 4p4zWyDGrf4Kh0mh/Lz4I/XrNyI4VrUMUAjUL1t7KkwAACES2X2452jIBgfL7JzQUWw7lqarL26
 TzDPM1eP9jdlgdOYaaWAQc4WcB9jz7550=
X-Gm-Gg: AY/fxX6bZ7Zpgztrvmla9PCtVeQ4zHMpAsI9mdKi81aL8Gy9sxEkVsLTsocRbdJ/2Kh
 xhRbmuXvh/01UGhHAlOMgP2sYuMs1Uvtreuz1QPANvan8ckcyZ9AOuIn+6fhPlgJknlyupGCkDB
 kjK/GfnbHakB3/ADpBZ11Iag1PeXluQ7pS8cC8DvSLSpl/kq/0D9vh5ZsUobTxacyEaeGgQbN6Z
 fFbTEOfVAgR7mYTMKpNGUbHFpEf6Kan0bilMuLcyhkIrEp9wAvBl1ejzQt6gxTCBgeH
X-Received: by 2002:a05:6000:611:b0:42f:b690:6788 with SMTP id
 ffacd0b85a97d-4324e4c1264mr33591531f8f.10.1766920626210; 
 Sun, 28 Dec 2025 03:17:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYonncJDFj84zwqnB/eP8xsXWigI9HyereGiBotlx40EdApeYcPUzZd5xQKKNxIWYlXvVdXxSUb40v4FDqIPk=
X-Received: by 2002:a05:6000:611:b0:42f:b690:6788 with SMTP id
 ffacd0b85a97d-4324e4c1264mr33591491f8f.10.1766920625444; Sun, 28 Dec 2025
 03:17:05 -0800 (PST)
MIME-Version: 1.0
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-14-philmd@linaro.org>
In-Reply-To: <20251224152210.87880-14-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 28 Dec 2025 12:16:53 +0100
X-Gm-Features: AQt7F2rpEOyhywkK4IkUZeAUnssti4e01bloV3V_KTV1OUF7wX0kcIQoDbfJmfA
Message-ID: <CABgObfbnxaWf38t-nMatzxjiriwRJbQhydLEyrRftne3-s3M6Q@mail.gmail.com>
Subject: Re: [PATCH v3 13/25] system/memory: Introduce LD/ST helpers with @n
 suffix (variable size)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>
Content-Type: multipart/alternative; boundary="00000000000039ece2064701448b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000039ece2064701448b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 24 dic 2025, 16:24 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> Introduce load/store helpers taking an unsigned size argument.
>

Are they used anywhere (or do you have plans)?

Overall I like the introduction of MemOp! But host endianness should be the
basis of everything else instead of something to shun.

Paolo

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  docs/devel/loads-stores.rst             | 10 ++++++----
>  include/system/memory_ldst_endian.h.inc |  4 ++++
>  system/memory_ldst_endian.c.inc         | 14 ++++++++++++++
>  3 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> index c906c6509ee..8db6285538e 100644
> --- a/docs/devel/loads-stores.rst
> +++ b/docs/devel/loads-stores.rst
> @@ -375,6 +375,7 @@ succeeded using a MemTxResult return code.
>   - ``w`` : 16 bits
>   - ``l`` : 32 bits
>   - ``q`` : 64 bits
> + - ``n`` : size in bytes
>
>  ``endian``
>   - ``le`` : little endian
> @@ -384,8 +385,8 @@ The ``_{endian}`` suffix is omitted for byte accesses=
.
>
>  Regexes for git grep:
>   - ``\<address_space_\(read\|write\|rw\)\>``
> - - ``\<address_space_ldu\?[bwql]\(_[lb]e\)\?\>``
> - - ``\<address_space_st[bwql]\(_[lb]e\)\?\>``
> + - ``\<address_space_ldu\?[bwlqn]\(_[lb]e\)\?\>``
> + - ``\<address_space_st[bwlqn]\(_[lb]e\)\?\>``
>
>  ``address_space_write_rom``
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -431,6 +432,7 @@ device doing the access has no way to report such an
> error.
>   - ``w`` : 16 bits
>   - ``l`` : 32 bits
>   - ``q`` : 64 bits
> + - ``n`` : size in bytes
>
>  ``endian``
>   - ``le`` : little endian
> @@ -439,8 +441,8 @@ device doing the access has no way to report such an
> error.
>  The ``_{endian}_`` infix is omitted for byte accesses.
>
>  Regexes for git grep:
> - - ``\<ldu\?[bwlq]\(_[bl]e\)\?_phys\>``
> - - ``\<st[bwlq]\(_[bl]e\)\?_phys\>``
> + - ``\<ldu\?[bwlqn]\(_[bl]e\)\?_phys\>``
> + - ``\<st[bwlqn]\(_[bl]e\)\?_phys\>``
>
>  ``cpu_physical_memory_*``
>  ~~~~~~~~~~~~~~~~~~~~~~~~~
> diff --git a/include/system/memory_ldst_endian.h.inc
> b/include/system/memory_ldst_endian.h.inc
> index f5b6b496be5..77850f1a18d 100644
> --- a/include/system/memory_ldst_endian.h.inc
> +++ b/include/system/memory_ldst_endian.h.inc
> @@ -20,12 +20,16 @@ uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
>                               MemTxAttrs attrs, MemTxResult *result);
>  uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,
>                               MemTxAttrs attrs, MemTxResult *result);
> +uint64_t ADDRESS_SPACE_LD(n)(ARG1_DECL, unsigned size, hwaddr addr,
> +                             MemTxAttrs attrs, MemTxResult *result);
>  void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
>                           MemTxAttrs attrs, MemTxResult *result);
>  void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
>                           MemTxAttrs attrs, MemTxResult *result);
>  void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
>                           MemTxAttrs attrs, MemTxResult *result);
> +void ADDRESS_SPACE_ST(n)(ARG1_DECL, unsigned size, hwaddr addr, uint64_t
> val,
> +                         MemTxAttrs attrs, MemTxResult *result);
>
>  #undef ADDRESS_SPACE_LD
>  #undef ADDRESS_SPACE_ST
> diff --git a/system/memory_ldst_endian.c.inc
> b/system/memory_ldst_endian.c.inc
> index fb933de11f8..4ff050027f5 100644
> --- a/system/memory_ldst_endian.c.inc
> +++ b/system/memory_ldst_endian.c.inc
> @@ -40,6 +40,13 @@ uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,
>                                          addr, attrs, result);
>  }
>
> +uint64_t ADDRESS_SPACE_LD(n)(ARG1_DECL, unsigned size, hwaddr addr,
> +                             MemTxAttrs attrs, MemTxResult *result)
> +{
> +    return ADDRESS_SPACE_LD_INTERNAL(m)(ARG1, MO_ENDIAN |
> size_memop(size),
> +                                        addr, attrs, result);
> +}
> +
>  void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
>                           MemTxAttrs attrs, MemTxResult *result)
>  {
> @@ -61,6 +68,13 @@ void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr,
> uint64_t val,
>                                   addr, val, attrs, result);
>  }
>
> +void ADDRESS_SPACE_ST(n)(ARG1_DECL, unsigned size, hwaddr addr, uint64_t
> val,
> +                         MemTxAttrs attrs, MemTxResult *result)
> +{
> +    ADDRESS_SPACE_ST_INTERNAL(m)(ARG1, MO_ENDIAN | size_memop(size),
> +                                 addr, val, attrs, result);
> +}
> +
>  #undef ADDRESS_SPACE_LD
>  #undef ADDRESS_SPACE_LD_INTERNAL
>  #undef ADDRESS_SPACE_ST
> --
> 2.52.0
>
>

--00000000000039ece2064701448b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 24 dic 2025, 16:24 Philip=
pe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linar=
o.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Introduce load/store helpers taking an unsigned size argument.<b=
r></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Ar=
e they used anywhere (or do you have plans)?</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Overall I like the introduction of MemOp! But host end=
ianness should be the basis of everything else instead of something to shun=
.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D=
"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_co=
ntainer"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank" rel=3D"noreferrer">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0docs/devel/loads-stores.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 10 ++++++----<br>
=C2=A0include/system/memory_ldst_endian.h.inc |=C2=A0 4 ++++<br>
=C2=A0system/memory_ldst_endian.c.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 14=
 ++++++++++++++<br>
=C2=A03 files changed, 24 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst<br>
index c906c6509ee..8db6285538e 100644<br>
--- a/docs/devel/loads-stores.rst<br>
+++ b/docs/devel/loads-stores.rst<br>
@@ -375,6 +375,7 @@ succeeded using a MemTxResult return code.<br>
=C2=A0 - ``w`` : 16 bits<br>
=C2=A0 - ``l`` : 32 bits<br>
=C2=A0 - ``q`` : 64 bits<br>
+ - ``n`` : size in bytes<br>
<br>
=C2=A0``endian``<br>
=C2=A0 - ``le`` : little endian<br>
@@ -384,8 +385,8 @@ The ``_{endian}`` suffix is omitted for byte accesses.<=
br>
<br>
=C2=A0Regexes for git grep:<br>
=C2=A0 - ``\&lt;address_space_\(read\|write\|rw\)\&gt;``<br>
- - ``\&lt;address_space_ldu\?[bwql]\(_[lb]e\)\?\&gt;``<br>
- - ``\&lt;address_space_st[bwql]\(_[lb]e\)\?\&gt;``<br>
+ - ``\&lt;address_space_ldu\?[bwlqn]\(_[lb]e\)\?\&gt;``<br>
+ - ``\&lt;address_space_st[bwlqn]\(_[lb]e\)\?\&gt;``<br>
<br>
=C2=A0``address_space_write_rom``<br>
=C2=A0~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
@@ -431,6 +432,7 @@ device doing the access has no way to report such an er=
ror.<br>
=C2=A0 - ``w`` : 16 bits<br>
=C2=A0 - ``l`` : 32 bits<br>
=C2=A0 - ``q`` : 64 bits<br>
+ - ``n`` : size in bytes<br>
<br>
=C2=A0``endian``<br>
=C2=A0 - ``le`` : little endian<br>
@@ -439,8 +441,8 @@ device doing the access has no way to report such an er=
ror.<br>
=C2=A0The ``_{endian}_`` infix is omitted for byte accesses.<br>
<br>
=C2=A0Regexes for git grep:<br>
- - ``\&lt;ldu\?[bwlq]\(_[bl]e\)\?_phys\&gt;``<br>
- - ``\&lt;st[bwlq]\(_[bl]e\)\?_phys\&gt;``<br>
+ - ``\&lt;ldu\?[bwlqn]\(_[bl]e\)\?_phys\&gt;``<br>
+ - ``\&lt;st[bwlqn]\(_[bl]e\)\?_phys\&gt;``<br>
<br>
=C2=A0``cpu_physical_memory_*``<br>
=C2=A0~~~~~~~~~~~~~~~~~~~~~~~~~<br>
diff --git a/include/system/memory_ldst_endian.h.inc b/include/system/memor=
y_ldst_endian.h.inc<br>
index f5b6b496be5..77850f1a18d 100644<br>
--- a/include/system/memory_ldst_endian.h.inc<br>
+++ b/include/system/memory_ldst_endian.h.inc<br>
@@ -20,12 +20,16 @@ uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MemTxAttrs attrs, MemTxResult *result);<br>
=C2=A0uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MemTxAttrs attrs, MemTxResult *result);<br>
+uint64_t ADDRESS_SPACE_LD(n)(ARG1_DECL, unsigned size, hwaddr addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MemTxAttrs attrs, MemTxResult *result);<br>
=C2=A0void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 MemTxAttrs attrs, MemTxResult *result);<br>
=C2=A0void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 MemTxAttrs attrs, MemTxResult *result);<br>
=C2=A0void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 MemTxAttrs attrs, MemTxResult *result);<br>
+void ADDRESS_SPACE_ST(n)(ARG1_DECL, unsigned size, hwaddr addr, uint64_t v=
al,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0MemTxAttrs attrs, MemTxResult *result);<br>
<br>
=C2=A0#undef ADDRESS_SPACE_LD<br>
=C2=A0#undef ADDRESS_SPACE_ST<br>
diff --git a/system/memory_ldst_endian.c.inc b/system/memory_ldst_endian.c.=
inc<br>
index fb933de11f8..4ff050027f5 100644<br>
--- a/system/memory_ldst_endian.c.inc<br>
+++ b/system/memory_ldst_endian.c.inc<br>
@@ -40,6 +40,13 @@ uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ad=
dr, attrs, result);<br>
=C2=A0}<br>
<br>
+uint64_t ADDRESS_SPACE_LD(n)(ARG1_DECL, unsigned size, hwaddr addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MemTxAttrs attrs, MemTxResult *result)<br>
+{<br>
+=C2=A0 =C2=A0 return ADDRESS_SPACE_LD_INTERNAL(m)(ARG1, MO_ENDIAN | size_m=
emop(size),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr, at=
trs, result);<br>
+}<br>
+<br>
=C2=A0void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 MemTxAttrs attrs, MemTxResult *result)<br>
=C2=A0{<br>
@@ -61,6 +68,13 @@ void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_=
t val,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr, val, attrs, result);<br=
>
=C2=A0}<br>
<br>
+void ADDRESS_SPACE_ST(n)(ARG1_DECL, unsigned size, hwaddr addr, uint64_t v=
al,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0MemTxAttrs attrs, MemTxResult *result)<br>
+{<br>
+=C2=A0 =C2=A0 ADDRESS_SPACE_ST_INTERNAL(m)(ARG1, MO_ENDIAN | size_memop(si=
ze),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr, val, attrs, result);<br>
+}<br>
+<br>
=C2=A0#undef ADDRESS_SPACE_LD<br>
=C2=A0#undef ADDRESS_SPACE_LD_INTERNAL<br>
=C2=A0#undef ADDRESS_SPACE_ST<br>
-- <br>
2.52.0<br>
<br>
</blockquote></div></div></div>

--00000000000039ece2064701448b--


