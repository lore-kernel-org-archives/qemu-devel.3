Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020F9E784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 11:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZohd-0002uq-N3; Sun, 28 Dec 2025 06:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZohb-0002uZ-S7
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 06:12:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZohZ-000780-Su
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 06:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766920365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eP7OclIbPLwTnStBvHShbYmvuFTrLaGUlhOF1+z0M8U=;
 b=SoYFyMhuGfbigsnka/ezuEqw19eYs9QK7/syemoMYOFj09tIZpJ85kg/kvbzKFaHeqmFp8
 fIG3vIXRHT2eGDOTGFIKXKdroHtRG449S6GLjiR1RnoNq0LquVqhqPRqm0eRyPQ0QL9KN/
 w/dXev7GpXFn0ryWJFYpm6MiHpRHUl0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-s16huc1oMCebTgq0dcS2PA-1; Sun, 28 Dec 2025 06:12:42 -0500
X-MC-Unique: s16huc1oMCebTgq0dcS2PA-1
X-Mimecast-MFC-AGG-ID: s16huc1oMCebTgq0dcS2PA_1766920361
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fc153d50so6701592f8f.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 03:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766920360; x=1767525160; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eP7OclIbPLwTnStBvHShbYmvuFTrLaGUlhOF1+z0M8U=;
 b=YDuCy22RY7uJ32DbhHDm+AxA1u0aBo2tg701WwKVV8adUiuJkXFMfIl0w8VXhQuhix
 ATFsZo7+WGnAk5kRBs9jOmOjTRJTQCvByEJ76kJ1kQ4zDB9FtZYe1w2YH9kl+hGgyxha
 tuKKUhTvsRhXFH3K6vSeJaI1GMmnjXuR0bIlq2kGi8Fqp6TVYj9KHqCYFeXCIFWpuZeu
 W4lvYEaie+DMMl2ekVuNSTdUKlxlaPW0Vh68GzM4AcxI5YjDAe8lTV+Xg3ydO3txby1l
 LP5anVzY0uFHk5rokLeY+1N0rcWCIolKOIzZ2pqA1JcfFqqDWzGJ9RmVf3k1plB69lIJ
 Nf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766920360; x=1767525160;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eP7OclIbPLwTnStBvHShbYmvuFTrLaGUlhOF1+z0M8U=;
 b=eOWlqOVBddJPW2H9twpTHa5hWiXt15rooGh+r2JlsL+non4KAL/wbrTG5ENSqVUFu+
 CiP1ttHqAHKPIqdELSZBj++yNl1ayNmEWCIhd/rnkf8/PIVYcgVeSChX3izckRp43huG
 Z55pnYaTvna6Em6fzn06aub0MjTLXvTq878D6ge00+9Y1TgOHDHu5o1wyDtoOEeX4Qhr
 hugg918YkfguXHx6tvtHsn7//yImQrhftuywBDqyrGJU4aIopkZqANSRPe5fWOPMJLUf
 +j1Y0KR035EQZ2Ml98oey+1lPKSgNgatNSmndUIjmTr//iZCrgpNpFNF9TCzAGiJQGm1
 30lQ==
X-Gm-Message-State: AOJu0YwmyszpF0V8JFZL5Il89eLYjJP+brbehz+pGuvR5NaGRlOzhuAF
 KmQ7RpC4xDOuDjG8OyqyMo0TPaeq/f1PAJ1+e7l4osoTh3ZLjS8K4eMtkYEuZiWV/2EmApgOob/
 MV51liPeNG4P36tuNIt/gYRmcBP/kiuS3flbdLQORrbm3MmNCM83qVfY8RP43fkWJcxLLD2tIFh
 kyba9r6ZIQ8ZbENmOAU6eiZ2WaLgRNSCpwjgdmqPo=
X-Gm-Gg: AY/fxX4qXPbiKpVANLxfe5PettIjgnOXYurcUH/AoM0hdF4tSEKeqZ2WYiKipf+3qOX
 dHGJ9Wl4cWN1c8mZTFOrO5JElInmKUpVTFrMmWSm6se+ySxELcmuC3bGhbpVVoeC6Z/jA5TT5UE
 RMOK+c0Vhfu/VlyLRkwLfC1LVMn4aaDzJ12MYp13ESTnMPxpBfUl8BqOi0mtNtJEsa7Am9mAEc6
 lSvqKaQ+sUoXMPZjujDY94NuDq42civtHxP0yrzkLtWZJ0cITwtSAMr+78RPmP8gWpi
X-Received: by 2002:a05:6000:4023:b0:431:48f:f78f with SMTP id
 ffacd0b85a97d-4324e4c3d1dmr27715251f8f.1.1766920360339; 
 Sun, 28 Dec 2025 03:12:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqunccwXBdmD6cOV2XlwWAFLGUrw4i7R47xnBaIn5aNDXL8G1YS4HbxsQDgTmte5stHF85nxj4g/9Vu1M/6SA=
X-Received: by 2002:a05:6000:4023:b0:431:48f:f78f with SMTP id
 ffacd0b85a97d-4324e4c3d1dmr27715227f8f.1.1766920359890; Sun, 28 Dec 2025
 03:12:39 -0800 (PST)
MIME-Version: 1.0
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-15-philmd@linaro.org>
In-Reply-To: <20251224152210.87880-15-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 28 Dec 2025 12:12:28 +0100
X-Gm-Features: AQt7F2qrzsXlx8MHnr6IEMkBRm9qx4wSOSccbHUJxU1U-EyEOiMYEHJmtMLpZXc
Message-ID: <CABgObfbcsao=NdVN0tg-m5ZCNB3soCq-nwyFkarLVYdEGV_NAA@mail.gmail.com>
Subject: Re: [PATCH v3 14/25] system/memory: Use explicit endianness in
 ram_device::read/write()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>
Content-Type: multipart/alternative; boundary="00000000000065e6040647013456"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000065e6040647013456
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 24 dic 2025, 16:24 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> Replace the ldn_he_p/stn_he_p() calls by their explicit endianness
> variants. Duplicate the MemoryRegionOps, using one entry for BIG
> and another for LITTLE endianness. Select the proper MemoryRegionOps
> in memory_region_init_ram_device_ptr().
>

This extra complication makes no sense to me. You're introducing dead code
and dead data, because only one of the MemoryRegionOps will be ever used on
a given host.

Given this example and the ATI one, I would really prefer to keep _he_
functions around and use them whenever you're reading from host memory as
in this case.

Paolo


> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  system/memory.c | 68 ++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 48 insertions(+), 20 deletions(-)
>
> diff --git a/system/memory.c b/system/memory.c
> index 8b84661ae36..5bcdeaf0bee 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1361,41 +1361,69 @@ const MemoryRegionOps unassigned_mem_ops =3D {
>      .endianness =3D DEVICE_NATIVE_ENDIAN,
>  };
>
> -static uint64_t memory_region_ram_device_read(void *opaque,
> -                                              hwaddr addr, unsigned size=
)
> +static uint64_t memory_region_ram_device_read_le(void *opaque,
> +                                                 hwaddr addr, unsigned
> size)
>  {
>      MemoryRegion *mr =3D opaque;
> -    uint64_t data =3D ldn_he_p(mr->ram_block->host + addr, size);
> +    uint64_t data =3D ldn_le_p(mr->ram_block->host + addr, size);
>
>      trace_memory_region_ram_device_read(get_cpu_index(), mr, addr, data,
> size);
>
>      return data;
>  }
>
> -static void memory_region_ram_device_write(void *opaque, hwaddr addr,
> -                                           uint64_t data, unsigned size)
> +static uint64_t memory_region_ram_device_read_be(void *opaque,
> +                                                 hwaddr addr, unsigned
> size)
> +{
> +    MemoryRegion *mr =3D opaque;
> +    uint64_t data =3D ldn_be_p(mr->ram_block->host + addr, size);
> +
> +    trace_memory_region_ram_device_read(get_cpu_index(), mr, addr, data,
> size);
> +
> +    return data;
> +}
> +
> +static void memory_region_ram_device_write_le(void *opaque, hwaddr addr,
> +                                              uint64_t data, unsigned
> size)
>  {
>      MemoryRegion *mr =3D opaque;
>
>      trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data=
,
> size);
>
> -    stn_he_p(mr->ram_block->host + addr, size, data);
> +    stn_le_p(mr->ram_block->host + addr, size, data);
>  }
>
> -static const MemoryRegionOps ram_device_mem_ops =3D {
> -    .read =3D memory_region_ram_device_read,
> -    .write =3D memory_region_ram_device_write,
> -    .endianness =3D HOST_BIG_ENDIAN ? DEVICE_BIG_ENDIAN :
> DEVICE_LITTLE_ENDIAN,
> -    .valid =3D {
> -        .min_access_size =3D 1,
> -        .max_access_size =3D 8,
> -        .unaligned =3D true,
> -    },
> -    .impl =3D {
> -        .min_access_size =3D 1,
> -        .max_access_size =3D 8,
> -        .unaligned =3D true,
> +static void memory_region_ram_device_write_be(void *opaque, hwaddr addr,
> +                                              uint64_t data, unsigned
> size)
> +{
> +    MemoryRegion *mr =3D opaque;
> +
> +    trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data=
,
> size);
> +
> +    stn_be_p(mr->ram_block->host + addr, size, data);
> +}
> +
> +static const MemoryRegionOps ram_device_mem_ops[2] =3D {
> +    [0 ... 1] =3D {
> +        .valid =3D {
> +            .min_access_size =3D 1,
> +            .max_access_size =3D 8,
> +            .unaligned =3D true,
> +        },
> +        .impl =3D {
> +            .min_access_size =3D 1,
> +            .max_access_size =3D 8,
> +            .unaligned =3D true,
> +        },
>      },
> +
> +    [0].endianness =3D DEVICE_LITTLE_ENDIAN,
> +    [0].read =3D memory_region_ram_device_read_le,
> +    [0].write =3D memory_region_ram_device_write_le,
> +
> +    [1].endianness =3D DEVICE_BIG_ENDIAN,
> +    [1].read =3D memory_region_ram_device_read_be,
> +    [1].write =3D memory_region_ram_device_write_be,
>  };
>
>  bool memory_region_access_valid(MemoryRegion *mr,
> @@ -1712,7 +1740,7 @@ void memory_region_init_ram_device_ptr(MemoryRegion
> *mr,
>      mr->ram =3D true;
>      mr->terminates =3D true;
>      mr->ram_device =3D true;
> -    mr->ops =3D &ram_device_mem_ops;
> +    mr->ops =3D &ram_device_mem_ops[HOST_BIG_ENDIAN];
>      mr->opaque =3D mr;
>      mr->destructor =3D memory_region_destructor_ram;
>
> --
> 2.52.0
>
>

--00000000000065e6040647013456
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 24 dic 2025, 16:24 Philip=
pe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linar=
o.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Replace the ldn_he_p/stn_he_p() calls by their explicit endianne=
ss<br>
variants. Duplicate the MemoryRegionOps, using one entry for BIG<br>
and another for LITTLE endianness. Select the proper MemoryRegionOps<br>
in memory_region_init_ram_device_ptr().<br></blockquote></div></div><div di=
r=3D"auto"><br></div><div dir=3D"auto">This extra complication makes no sen=
se to me. You&#39;re introducing dead code and dead data, because only one =
of the MemoryRegionOps will be ever used on a given host.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Given this example and the ATI one, I wou=
ld really prefer to keep _he_ functions around and use them whenever you&#3=
9;re reading from host memory as in this case.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank" rel=3D"noreferrer">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0system/memory.c | 68 ++++++++++++++++++++++++++++++++++--------------=
-<br>
=C2=A01 file changed, 48 insertions(+), 20 deletions(-)<br>
<br>
diff --git a/system/memory.c b/system/memory.c<br>
index 8b84661ae36..5bcdeaf0bee 100644<br>
--- a/system/memory.c<br>
+++ b/system/memory.c<br>
@@ -1361,41 +1361,69 @@ const MemoryRegionOps unassigned_mem_ops =3D {<br>
=C2=A0 =C2=A0 =C2=A0.endianness =3D DEVICE_NATIVE_ENDIAN,<br>
=C2=A0};<br>
<br>
-static uint64_t memory_region_ram_device_read(void *opaque,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 hwaddr addr, unsigned size)<br>
+static uint64_t memory_region_ram_device_read_le(void *opaque,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0hwaddr addr, unsigned size)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *mr =3D opaque;<br>
-=C2=A0 =C2=A0 uint64_t data =3D ldn_he_p(mr-&gt;ram_block-&gt;host + addr,=
 size);<br>
+=C2=A0 =C2=A0 uint64_t data =3D ldn_le_p(mr-&gt;ram_block-&gt;host + addr,=
 size);<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_memory_region_ram_device_read(get_cpu_index(), mr=
, addr, data, size);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return data;<br>
=C2=A0}<br>
<br>
-static void memory_region_ram_device_write(void *opaque, hwaddr addr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0uint64_t data, unsigned size)<br>
+static uint64_t memory_region_ram_device_read_be(void *opaque,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0hwaddr addr, unsigned size)<br>
+{<br>
+=C2=A0 =C2=A0 MemoryRegion *mr =3D opaque;<br>
+=C2=A0 =C2=A0 uint64_t data =3D ldn_be_p(mr-&gt;ram_block-&gt;host + addr,=
 size);<br>
+<br>
+=C2=A0 =C2=A0 trace_memory_region_ram_device_read(get_cpu_index(), mr, add=
r, data, size);<br>
+<br>
+=C2=A0 =C2=A0 return data;<br>
+}<br>
+<br>
+static void memory_region_ram_device_write_le(void *opaque, hwaddr addr,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 uint64_t data, unsigned size)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *mr =3D opaque;<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_memory_region_ram_device_write(get_cpu_index(), m=
r, addr, data, size);<br>
<br>
-=C2=A0 =C2=A0 stn_he_p(mr-&gt;ram_block-&gt;host + addr, size, data);<br>
+=C2=A0 =C2=A0 stn_le_p(mr-&gt;ram_block-&gt;host + addr, size, data);<br>
=C2=A0}<br>
<br>
-static const MemoryRegionOps ram_device_mem_ops =3D {<br>
-=C2=A0 =C2=A0 .read =3D memory_region_ram_device_read,<br>
-=C2=A0 =C2=A0 .write =3D memory_region_ram_device_write,<br>
-=C2=A0 =C2=A0 .endianness =3D HOST_BIG_ENDIAN ? DEVICE_BIG_ENDIAN : DEVICE=
_LITTLE_ENDIAN,<br>
-=C2=A0 =C2=A0 .valid =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 1,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 8,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .unaligned =3D true,<br>
-=C2=A0 =C2=A0 },<br>
-=C2=A0 =C2=A0 .impl =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 1,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 8,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .unaligned =3D true,<br>
+static void memory_region_ram_device_write_be(void *opaque, hwaddr addr,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 uint64_t data, unsigned size)<br>
+{<br>
+=C2=A0 =C2=A0 MemoryRegion *mr =3D opaque;<br>
+<br>
+=C2=A0 =C2=A0 trace_memory_region_ram_device_write(get_cpu_index(), mr, ad=
dr, data, size);<br>
+<br>
+=C2=A0 =C2=A0 stn_be_p(mr-&gt;ram_block-&gt;host + addr, size, data);<br>
+}<br>
+<br>
+static const MemoryRegionOps ram_device_mem_ops[2] =3D {<br>
+=C2=A0 =C2=A0 [0 ... 1] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .valid =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 8,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .unaligned =3D true,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .impl =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 8,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .unaligned =3D true,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0},<br>
+<br>
+=C2=A0 =C2=A0 [0].endianness =3D DEVICE_LITTLE_ENDIAN,<br>
+=C2=A0 =C2=A0 [0].read =3D memory_region_ram_device_read_le,<br>
+=C2=A0 =C2=A0 [0].write =3D memory_region_ram_device_write_le,<br>
+<br>
+=C2=A0 =C2=A0 [1].endianness =3D DEVICE_BIG_ENDIAN,<br>
+=C2=A0 =C2=A0 [1].read =3D memory_region_ram_device_read_be,<br>
+=C2=A0 =C2=A0 [1].write =3D memory_region_ram_device_write_be,<br>
=C2=A0};<br>
<br>
=C2=A0bool memory_region_access_valid(MemoryRegion *mr,<br>
@@ -1712,7 +1740,7 @@ void memory_region_init_ram_device_ptr(MemoryRegion *=
mr,<br>
=C2=A0 =C2=A0 =C2=A0mr-&gt;ram =3D true;<br>
=C2=A0 =C2=A0 =C2=A0mr-&gt;terminates =3D true;<br>
=C2=A0 =C2=A0 =C2=A0mr-&gt;ram_device =3D true;<br>
-=C2=A0 =C2=A0 mr-&gt;ops =3D &amp;ram_device_mem_ops;<br>
+=C2=A0 =C2=A0 mr-&gt;ops =3D &amp;ram_device_mem_ops[HOST_BIG_ENDIAN];<br>
=C2=A0 =C2=A0 =C2=A0mr-&gt;opaque =3D mr;<br>
=C2=A0 =C2=A0 =C2=A0mr-&gt;destructor =3D memory_region_destructor_ram;<br>
<br>
-- <br>
2.52.0<br>
<br>
</blockquote></div></div></div>

--00000000000065e6040647013456--


