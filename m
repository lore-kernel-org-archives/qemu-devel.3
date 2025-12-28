Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A32D3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 11:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZoe1-0001tg-Q8; Sun, 28 Dec 2025 06:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZody-0001sr-NC
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 06:09:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZodv-0006mB-LV
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 06:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766920138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3l2phkXCJaytY2ehavBw7H8fQY5W/jClO6TyvC/6NvQ=;
 b=Hs5nXDMwT6ymnM4sgzD8NwyrggsFLdDGDHOivQ8HSCEXl0yXq6WN943kDuZzGLVC+2s5CR
 SpH+R/Ea6wXeSngFtrHNSYeEKJlJ4A5E9vA9CPjsMdVjzvC0UMMwjhcdo7AO/XU5V56EcH
 L4TkYfHz455gdblKWHt3Ge9NmIXYynA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-5c0sRSuuOc6oqPv5pvqYxQ-1; Sun, 28 Dec 2025 06:08:55 -0500
X-MC-Unique: 5c0sRSuuOc6oqPv5pvqYxQ-1
X-Mimecast-MFC-AGG-ID: 5c0sRSuuOc6oqPv5pvqYxQ_1766920134
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430fc153d50so6700147f8f.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 03:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766920134; x=1767524934; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3l2phkXCJaytY2ehavBw7H8fQY5W/jClO6TyvC/6NvQ=;
 b=iUTWNbXYE8YZQrM5bBsNSVZOppOCCdGM5xuLP50k7iCkfs6uB1JOjJnKDVgz+DPwKG
 gcl5xfyuQgGawhgV/vEoo+T+v3evZ3c//z3okX/GSaizXw0nNqqRbYMPGoWffUMz1d+K
 WVTAAyfmXJClfC/I1CV6HH7p7azn53OQgYfxXc2tWvLRNQ4otHkSG0/DjDOPh2WzqbEl
 KZuD5cqJMbKuP0En6jU1ZOqt5rBseCzUw6eDCBtQATRVVjBbLq6Hx6KUgyE+4WkYq08r
 RSjvKRQ2DLPN3j1rwASIQkOoLCNyDzvzCIHntRL7UsDH0JFojcj3wiizRhYOugsRH601
 6sFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766920134; x=1767524934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3l2phkXCJaytY2ehavBw7H8fQY5W/jClO6TyvC/6NvQ=;
 b=g4teAHY2uop6MA/8RJbnJHX3TCqKYnhDEblJJUjFiAQHTN0XNtsXvmiutRdvg3FrMv
 j3pR+G1ulwZvlYcbE4EU2GAn5ScKfCqMzm1dg5CvEpZHaeHB1thKHPE0FeHNl/sq0qqi
 Ht0Y3GQex1pNyAufoeYlUs0QbAgcZyK0AJW7wg7izRZ1mfD5xgerLXDEg5gu1ZFGzvFh
 vgSW0Kx+utNCCme+wznDYkeDHqSL4NvMUsl4KiNibiw2JV0Z6GGamDvOKO6WwnMuFsRq
 okICqgJOCnAdQ9heF6PZb3418kW7tjuf2URANdcpYaDR+A5fEM7wBDXRK/p64ju+E61m
 eI5w==
X-Gm-Message-State: AOJu0Yx1psRAV+UagG7WpQ29JX3otpQlxZcA2VGQn9a5NCfpP7bUKk9k
 XOsO+O/0POfOBoTP/soO8iJI7XqXbeoeJsNq90zgqnlxrkIo7eJpSBLrCBz/dB26eEwRFdxBsr2
 LtruWC0hQQ1G7AN4mmUOxC847IYSYsAZt3jLM0VtuSXOyPM8MH7/0ooPnf3n/266+0oq5U3sZxi
 Tnv9s/jI39vVkgpvcf+zbjJ/2/NBK59Fs=
X-Gm-Gg: AY/fxX79Ew8Nrd4nAze/d0WDRQ8cDD1Rz7MDJR8MjOnMCluU5gg/3mGgkvuDp0OeORI
 M6hCFitaiKALvBacHYLDQAwgxZc9mLTnsBZRlHPJJb+ihTb7wDR97pkPZS9KiozsmEme+1CVyWs
 UNCMqbY7R3Z3zeHd0ETfblFsPB968ifF5vywvagyOf4J4zKIftfKQfYiUTGMmF67XA/bCpXWPz6
 rwgnVFdzA/OESLZDfwLQ84AiO53QB1JccpVHePSqYxXsHzRdb5cCErNG9ash49rp7GP
X-Received: by 2002:a05:6000:186a:b0:430:f301:3e6c with SMTP id
 ffacd0b85a97d-4324e4fdcd8mr28911670f8f.34.1766920134285; 
 Sun, 28 Dec 2025 03:08:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYIs5OWrPvUqWIGlpm+gzIgcPFg6prD8UcY+7tWzniK0nu0WCP9gI5fHInlW7aZXWYTlsUGO5PCWN/GvgIdsI=
X-Received: by 2002:a05:6000:186a:b0:430:f301:3e6c with SMTP id
 ffacd0b85a97d-4324e4fdcd8mr28911645f8f.34.1766920133809; Sun, 28 Dec 2025
 03:08:53 -0800 (PST)
MIME-Version: 1.0
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-12-philmd@linaro.org>
In-Reply-To: <20251224152210.87880-12-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 28 Dec 2025 12:08:41 +0100
X-Gm-Features: AQt7F2p2LrR6LqNCIQrTFN-Z0WhDl0Dyu-EuKb2g9BK8EY6E5pnPAxS6LMdk_D0
Message-ID: <CABgObfYWG8ot6ZLpoj6Bh7fXRUZaLtVKZ7bVQLbUbAyzs+LiyQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/25] system/memory: Pass device_endian argument as
 MemOp bit
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>
Content-Type: multipart/alternative; boundary="000000000000ec2d31064701261c"
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

--000000000000ec2d31064701261c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 24 dic 2025, 16:24 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> -        switch (endian) {
> -        case DEVICE_LITTLE_ENDIAN:
> +        if ((mop & MO_BSWAP) =3D=3D MO_LE) {
>              val =3D ldn_le_p(ptr, size);
> -            break;
> -        case DEVICE_BIG_ENDIAN:
> +        } else {
>              val =3D ldn_be_p(ptr, size);
> -            break;
> -        default:
> -            val =3D ldn_p(ptr, size);
> -            break;
>          }
>

This is an example in which you could use ldn_he_p as a memcpy, followed by
the bswap if mop & MO_BSWAP. It would be closer to how MemOp bits are
defined.

Paolo

         r =3D MEMTX_OK;
>      }
> @@ -73,37 +65,33 @@ uint64_t glue(address_space_ldm_internal,
> SUFFIX)(ARG1_DECL, MemOp mop,
>
>  /* warning: addr must be aligned */
>  static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DEC=
L,
> -    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
> -    enum device_endian endian)
> +    MemOp mop, hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
>  {
> -    return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_32, addr,
> -                                                    attrs, result,
> endian);
> +    return glue(address_space_ldm_internal, SUFFIX)(ARG1, mop | MO_32,
> addr,
> +                                                    attrs, result);
>  }
>
>  /* warning: addr must be aligned */
>  static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DEC=
L,
> -    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
> -    enum device_endian endian)
> +    MemOp mop, hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
>  {
> -    return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_64, addr,
> -                                                    attrs, result,
> endian);
> +    return glue(address_space_ldm_internal, SUFFIX)(ARG1, mop | MO_64,
> addr,
> +                                                    attrs, result);
>  }
>
>  uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL, hwaddr addr,
>                                           MemTxAttrs attrs, MemTxResult
> *result)
>  {
>      return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_8, addr,
> -                                                    attrs, result,
> -                                                    DEVICE_NATIVE_ENDIAN=
);
> +                                                    attrs, result);
>  }
>
>  /* warning: addr must be aligned */
>  static inline uint16_t glue(address_space_lduw_internal,
> SUFFIX)(ARG1_DECL,
> -    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
> -    enum device_endian endian)
> +    MemOp mop, hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
>  {
> -    return glue(address_space_ldm_internal, SUFFIX)(ARG1, MO_16, addr,
> -                                                    attrs, result,
> endian);
> +    return glue(address_space_ldm_internal, SUFFIX)(ARG1, mop | MO_16,
> addr,
> +                                                    attrs, result);
>  }
>
>  /* warning: addr must be aligned */
> @@ -111,8 +99,7 @@ static inline
>  void glue(address_space_stm_internal, SUFFIX)(ARG1_DECL, MemOp mop,
>                                                hwaddr addr, uint64_t val,
>                                                MemTxAttrs attrs,
> -                                              MemTxResult *result,
> -                                              enum device_endian endian)
> +                                              MemTxResult *result)
>  {
>      const unsigned size =3D memop_size(mop);
>      uint8_t *ptr;
> @@ -126,21 +113,14 @@ void glue(address_space_stm_internal,
> SUFFIX)(ARG1_DECL, MemOp mop,
>      mr =3D TRANSLATE(addr, &addr1, &l, true, attrs);
>      if (l < size || !memory_access_is_direct(mr, true, attrs)) {
>          release_lock |=3D prepare_mmio_access(mr);
> -        r =3D memory_region_dispatch_write(mr, addr1, val,
> -                                         mop | devend_memop(endian),
> attrs);
> +        r =3D memory_region_dispatch_write(mr, addr1, val, mop, attrs);
>      } else {
>          /* RAM case */
>          ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
> -        switch (endian) {
> -        case DEVICE_LITTLE_ENDIAN:
> +        if ((mop & MO_BSWAP) =3D=3D MO_LE) {
>              stn_le_p(ptr, size, val);
> -            break;
> -        case DEVICE_BIG_ENDIAN:
> +        } else {
>              stn_be_p(ptr, size, val);
> -            break;
> -        default:
> -            stn_p(ptr, size, val);
> -            break;
>          }
>          invalidate_and_set_dirty(mr, addr1, size);
>          r =3D MEMTX_OK;
> @@ -156,48 +136,44 @@ void glue(address_space_stm_internal,
> SUFFIX)(ARG1_DECL, MemOp mop,
>
>  /* warning: addr must be aligned */
>  static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
> -    hwaddr addr, uint32_t val, MemTxAttrs attrs,
> -    MemTxResult *result, enum device_endian endian)
> +    MemOp mop, hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult
> *result)
>  {
> -    glue(address_space_stm_internal, SUFFIX)(ARG1, MO_32, addr, val,
> -                                             attrs, result, endian);
> +    glue(address_space_stm_internal, SUFFIX)(ARG1, mop | MO_32, addr, va=
l,
> +                                             attrs, result);
>  }
>
>  void glue(address_space_stb, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val=
,
>                                       MemTxAttrs attrs, MemTxResult
> *result)
>  {
>      glue(address_space_stm_internal, SUFFIX)(ARG1, MO_8, addr, val,
> -                                             attrs, result,
> -                                             DEVICE_NATIVE_ENDIAN);
> +                                             attrs, result);
>  }
>
>  /* warning: addr must be aligned */
>  static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
> -    hwaddr addr, uint16_t val, MemTxAttrs attrs,
> -    MemTxResult *result, enum device_endian endian)
> +    MemOp mop, hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult
> *result)
>  {
> -    glue(address_space_stm_internal, SUFFIX)(ARG1, MO_16, addr, val,
> -                                             attrs, result, endian);
> +    glue(address_space_stm_internal, SUFFIX)(ARG1, mop | MO_16, addr, va=
l,
> +                                             attrs, result);
>  }
>
>  static inline void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
> -    hwaddr addr, uint64_t val, MemTxAttrs attrs,
> -    MemTxResult *result, enum device_endian endian)
> +    MemOp mop, hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult
> *result)
>  {
> -    glue(address_space_stm_internal, SUFFIX)(ARG1, MO_64, addr, val,
> -                                             attrs, result, endian);
> +    glue(address_space_stm_internal, SUFFIX)(ARG1, mop | MO_64, addr, va=
l,
> +                                             attrs, result);
>  }
>
>  #define ENDIANNESS
> -#define DEVICE_ENDIANNESS       DEVICE_NATIVE_ENDIAN
> +#define MO_ENDIAN               (target_big_endian() ? MO_BE : MO_LE)
>  #include "memory_ldst_endian.c.inc"
>
>  #define ENDIANNESS              _le
> -#define DEVICE_ENDIANNESS       DEVICE_LITTLE_ENDIAN
> +#define MO_ENDIAN               MO_LE
>  #include "memory_ldst_endian.c.inc"
>
>  #define ENDIANNESS              _be
> -#define DEVICE_ENDIANNESS       DEVICE_BIG_ENDIAN
> +#define MO_ENDIAN               MO_BE
>  #include "memory_ldst_endian.c.inc"
>
>  #undef ARG1_DECL
> diff --git a/system/memory_ldst_endian.c.inc
> b/system/memory_ldst_endian.c.inc
> index 791d041b15d..9cf36017135 100644
> --- a/system/memory_ldst_endian.c.inc
> +++ b/system/memory_ldst_endian.c.inc
> @@ -22,43 +22,43 @@
>  uint16_t ADDRESS_SPACE_LD(uw)(ARG1_DECL, hwaddr addr,
>                                MemTxAttrs attrs, MemTxResult *result)
>  {
> -    return ADDRESS_SPACE_LD_INTERNAL(uw)(ARG1, addr, attrs, result,
> -                                         DEVICE_ENDIANNESS);
> +    return ADDRESS_SPACE_LD_INTERNAL(uw)(ARG1, MO_ENDIAN,
> +                                        addr, attrs, result);
>  }
>
>  uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
>                               MemTxAttrs attrs, MemTxResult *result)
>  {
> -    return ADDRESS_SPACE_LD_INTERNAL(l)(ARG1, addr, attrs, result,
> -                                        DEVICE_ENDIANNESS);
> +    return ADDRESS_SPACE_LD_INTERNAL(l)(ARG1, MO_ENDIAN,
> +                                        addr, attrs, result);
>  }
>
>  uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,
>                               MemTxAttrs attrs, MemTxResult *result)
>  {
> -    return ADDRESS_SPACE_LD_INTERNAL(q)(ARG1, addr, attrs, result,
> -                                        DEVICE_ENDIANNESS);
> +    return ADDRESS_SPACE_LD_INTERNAL(q)(ARG1, MO_ENDIAN,
> +                                        addr, attrs, result);
>  }
>
>  void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
>                           MemTxAttrs attrs, MemTxResult *result)
>  {
> -    ADDRESS_SPACE_ST_INTERNAL(w)(ARG1, addr, val, attrs, result,
> -                                 DEVICE_ENDIANNESS);
> +    ADDRESS_SPACE_ST_INTERNAL(w)(ARG1, MO_ENDIAN,
> +                                 addr, val, attrs, result);
>  }
>
>  void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
>                           MemTxAttrs attrs, MemTxResult *result)
>  {
> -    ADDRESS_SPACE_ST_INTERNAL(l)(ARG1, addr, val, attrs, result,
> -                                 DEVICE_ENDIANNESS);
> +    ADDRESS_SPACE_ST_INTERNAL(l)(ARG1, MO_ENDIAN,
> +                                 addr, val, attrs, result);
>  }
>
>  void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
>                           MemTxAttrs attrs, MemTxResult *result)
>  {
> -    ADDRESS_SPACE_ST_INTERNAL(q)(ARG1, addr, val, attrs, result,
> -                                 DEVICE_ENDIANNESS);
> +    ADDRESS_SPACE_ST_INTERNAL(q)(ARG1, MO_ENDIAN,
> +                                 addr, val, attrs, result);
>  }
>
>  #undef ADDRESS_SPACE_LD
> @@ -67,4 +67,4 @@ void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr,
> uint64_t val,
>  #undef ADDRESS_SPACE_ST_INTERNAL
>
>  #undef ENDIANNESS
> -#undef DEVICE_ENDIANNESS
> +#undef MO_ENDIAN
> --
> 2.52.0
>
>

--000000000000ec2d31064701261c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9ImF1dG8iPjxkaXY+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSBnbWFp
bF9xdW90ZV9jb250YWluZXIiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5JbCBt
ZXIgMjQgZGljIDIwMjUsIDE2OjI0IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpICZsdDs8YSBocmVm
PSJtYWlsdG86cGhpbG1kQGxpbmFyby5vcmciPnBoaWxtZEBsaW5hcm8ub3JnPC9hPiZndDsgaGEg
c2NyaXR0bzo8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIw
NCk7cGFkZGluZy1sZWZ0OjFleCI+DQotwqAgwqAgwqAgwqAgc3dpdGNoIChlbmRpYW4pIHs8YnI+
DQotwqAgwqAgwqAgwqAgY2FzZSBERVZJQ0VfTElUVExFX0VORElBTjo8YnI+DQorwqAgwqAgwqAg
wqAgaWYgKChtb3AgJmFtcDsgTU9fQlNXQVApID09IE1PX0xFKSB7PGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqB2YWwgPSBsZG5fbGVfcChwdHIsIHNpemUpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCBicmVhazs8YnI+DQotwqAgwqAgwqAgwqAgY2FzZSBERVZJQ0VfQklHX0VORElBTjo8YnI+DQor
wqAgwqAgwqAgwqAgfSBlbHNlIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoHZhbCA9IGxkbl9i
ZV9wKHB0ciwgc2l6ZSk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGJyZWFrOzxicj4NCi3CoCDC
oCDCoCDCoCBkZWZhdWx0Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCB2YWwgPSBsZG5fcChwdHIs
IHNpemUpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBicmVhazs8YnI+DQrCoCDCoCDCoCDCoCDC
oH08YnI+PC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+
PGRpdiBkaXI9ImF1dG8iPlRoaXMgaXMgYW4gZXhhbXBsZSBpbiB3aGljaCB5b3UgY291bGQgdXNl
IGxkbl9oZV9wIGFzIGEgbWVtY3B5LCBmb2xsb3dlZCBieSB0aGUgYnN3YXAgaWYgbW9wICZhbXA7
IE1PX0JTV0FQLiBJdCB3b3VsZCBiZSBjbG9zZXIgdG8gaG93IE1lbU9wIGJpdHMgYXJlIGRlZmlu
ZWQuPC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+UGFvbG/C
oDwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxkaXYgY2xh
c3M9ImdtYWlsX3F1b3RlIGdtYWlsX3F1b3RlX2NvbnRhaW5lciI+PGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0
OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPg0KwqAgwqAgwqAg
wqAgwqByID0gTUVNVFhfT0s7PGJyPg0KwqAgwqAgwqB9PGJyPg0KQEAgLTczLDM3ICs2NSwzMyBA
QCB1aW50NjRfdCBnbHVlKGFkZHJlc3Nfc3BhY2VfbGRtX2ludGVybmFsLCBTVUZGSVgpKEFSRzFf
REVDTCwgTWVtT3AgbW9wLDxicj4NCjxicj4NCsKgLyogd2FybmluZzogYWRkciBtdXN0IGJlIGFs
aWduZWQgKi88YnI+DQrCoHN0YXRpYyBpbmxpbmUgdWludDMyX3QgZ2x1ZShhZGRyZXNzX3NwYWNl
X2xkbF9pbnRlcm5hbCwgU1VGRklYKShBUkcxX0RFQ0wsPGJyPg0KLcKgIMKgIGh3YWRkciBhZGRy
LCBNZW1UeEF0dHJzIGF0dHJzLCBNZW1UeFJlc3VsdCAqcmVzdWx0LDxicj4NCi3CoCDCoCBlbnVt
IGRldmljZV9lbmRpYW4gZW5kaWFuKTxicj4NCivCoCDCoCBNZW1PcCBtb3AsIGh3YWRkciBhZGRy
LCBNZW1UeEF0dHJzIGF0dHJzLCBNZW1UeFJlc3VsdCAqcmVzdWx0KTxicj4NCsKgezxicj4NCi3C
oCDCoCByZXR1cm4gZ2x1ZShhZGRyZXNzX3NwYWNlX2xkbV9pbnRlcm5hbCwgU1VGRklYKShBUkcx
LCBNT18zMiwgYWRkciw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYXR0cnMsIHJlc3VsdCwg
ZW5kaWFuKTs8YnI+DQorwqAgwqAgcmV0dXJuIGdsdWUoYWRkcmVzc19zcGFjZV9sZG1faW50ZXJu
YWwsIFNVRkZJWCkoQVJHMSwgbW9wIHwgTU9fMzIsIGFkZHIsPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGF0dHJzLCByZXN1bHQpOzxicj4NCsKgfTxicj4NCjxicj4NCsKgLyogd2FybmluZzog
YWRkciBtdXN0IGJlIGFsaWduZWQgKi88YnI+DQrCoHN0YXRpYyBpbmxpbmUgdWludDY0X3QgZ2x1
ZShhZGRyZXNzX3NwYWNlX2xkcV9pbnRlcm5hbCwgU1VGRklYKShBUkcxX0RFQ0wsPGJyPg0KLcKg
IMKgIGh3YWRkciBhZGRyLCBNZW1UeEF0dHJzIGF0dHJzLCBNZW1UeFJlc3VsdCAqcmVzdWx0LDxi
cj4NCi3CoCDCoCBlbnVtIGRldmljZV9lbmRpYW4gZW5kaWFuKTxicj4NCivCoCDCoCBNZW1PcCBt
b3AsIGh3YWRkciBhZGRyLCBNZW1UeEF0dHJzIGF0dHJzLCBNZW1UeFJlc3VsdCAqcmVzdWx0KTxi
cj4NCsKgezxicj4NCi3CoCDCoCByZXR1cm4gZ2x1ZShhZGRyZXNzX3NwYWNlX2xkbV9pbnRlcm5h
bCwgU1VGRklYKShBUkcxLCBNT182NCwgYWRkciw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
YXR0cnMsIHJlc3VsdCwgZW5kaWFuKTs8YnI+DQorwqAgwqAgcmV0dXJuIGdsdWUoYWRkcmVzc19z
cGFjZV9sZG1faW50ZXJuYWwsIFNVRkZJWCkoQVJHMSwgbW9wIHwgTU9fNjQsIGFkZHIsPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGF0dHJzLCByZXN1bHQpOzxicj4NCsKgfTxicj4NCjxicj4N
CsKgdWludDhfdCBnbHVlKGFkZHJlc3Nfc3BhY2VfbGR1YiwgU1VGRklYKShBUkcxX0RFQ0wsIGh3
YWRkciBhZGRyLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1lbVR4QXR0cnMgYXR0cnMsIE1lbVR4UmVzdWx0ICpyZXN1
bHQpPGJyPg0KwqB7PGJyPg0KwqAgwqAgwqByZXR1cm4gZ2x1ZShhZGRyZXNzX3NwYWNlX2xkbV9p
bnRlcm5hbCwgU1VGRklYKShBUkcxLCBNT184LCBhZGRyLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBhdHRycywgcmVzdWx0LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBERVZJQ0VfTkFU
SVZFX0VORElBTik7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGF0dHJzLCByZXN1bHQpOzxi
cj4NCsKgfTxicj4NCjxicj4NCsKgLyogd2FybmluZzogYWRkciBtdXN0IGJlIGFsaWduZWQgKi88
YnI+DQrCoHN0YXRpYyBpbmxpbmUgdWludDE2X3QgZ2x1ZShhZGRyZXNzX3NwYWNlX2xkdXdfaW50
ZXJuYWwsIFNVRkZJWCkoQVJHMV9ERUNMLDxicj4NCi3CoCDCoCBod2FkZHIgYWRkciwgTWVtVHhB
dHRycyBhdHRycywgTWVtVHhSZXN1bHQgKnJlc3VsdCw8YnI+DQotwqAgwqAgZW51bSBkZXZpY2Vf
ZW5kaWFuIGVuZGlhbik8YnI+DQorwqAgwqAgTWVtT3AgbW9wLCBod2FkZHIgYWRkciwgTWVtVHhB
dHRycyBhdHRycywgTWVtVHhSZXN1bHQgKnJlc3VsdCk8YnI+DQrCoHs8YnI+DQotwqAgwqAgcmV0
dXJuIGdsdWUoYWRkcmVzc19zcGFjZV9sZG1faW50ZXJuYWwsIFNVRkZJWCkoQVJHMSwgTU9fMTYs
IGFkZHIsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGF0dHJzLCByZXN1bHQsIGVuZGlhbik7
PGJyPg0KK8KgIMKgIHJldHVybiBnbHVlKGFkZHJlc3Nfc3BhY2VfbGRtX2ludGVybmFsLCBTVUZG
SVgpKEFSRzEsIG1vcCB8IE1PXzE2LCBhZGRyLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBh
dHRycywgcmVzdWx0KTs8YnI+DQrCoH08YnI+DQo8YnI+DQrCoC8qIHdhcm5pbmc6IGFkZHIgbXVz
dCBiZSBhbGlnbmVkICovPGJyPg0KQEAgLTExMSw4ICs5OSw3IEBAIHN0YXRpYyBpbmxpbmU8YnI+
DQrCoHZvaWQgZ2x1ZShhZGRyZXNzX3NwYWNlX3N0bV9pbnRlcm5hbCwgU1VGRklYKShBUkcxX0RF
Q0wsIE1lbU9wIG1vcCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGh3YWRkciBhZGRyLCB1aW50NjRfdCB2
YWwsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBNZW1UeEF0dHJzIGF0dHJzLDxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBNZW1UeFJlc3VsdCAqcmVzdWx0LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBlbnVtIGRldmljZV9lbmRp
YW4gZW5kaWFuKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBNZW1UeFJlc3VsdCAqcmVzdWx0KTxicj4NCsKg
ezxicj4NCsKgIMKgIMKgY29uc3QgdW5zaWduZWQgc2l6ZSA9IG1lbW9wX3NpemUobW9wKTs8YnI+
DQrCoCDCoCDCoHVpbnQ4X3QgKnB0cjs8YnI+DQpAQCAtMTI2LDIxICsxMTMsMTQgQEAgdm9pZCBn
bHVlKGFkZHJlc3Nfc3BhY2Vfc3RtX2ludGVybmFsLCBTVUZGSVgpKEFSRzFfREVDTCwgTWVtT3Ag
bW9wLDxicj4NCsKgIMKgIMKgbXIgPSBUUkFOU0xBVEUoYWRkciwgJmFtcDthZGRyMSwgJmFtcDts
LCB0cnVlLCBhdHRycyk7PGJyPg0KwqAgwqAgwqBpZiAobCAmbHQ7IHNpemUgfHwgIW1lbW9yeV9h
Y2Nlc3NfaXNfZGlyZWN0KG1yLCB0cnVlLCBhdHRycykpIHs8YnI+DQrCoCDCoCDCoCDCoCDCoHJl
bGVhc2VfbG9jayB8PSBwcmVwYXJlX21taW9fYWNjZXNzKG1yKTs8YnI+DQotwqAgwqAgwqAgwqAg
ciA9IG1lbW9yeV9yZWdpb25fZGlzcGF0Y2hfd3JpdGUobXIsIGFkZHIxLCB2YWwsPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgbW9wIHwgZGV2ZW5kX21lbW9wKGVuZGlhbiksIGF0dHJzKTs8YnI+DQorwqAgwqAgwqAgwqAg
ciA9IG1lbW9yeV9yZWdpb25fZGlzcGF0Y2hfd3JpdGUobXIsIGFkZHIxLCB2YWwsIG1vcCwgYXR0
cnMpOzxicj4NCsKgIMKgIMKgfSBlbHNlIHs8YnI+DQrCoCDCoCDCoCDCoCDCoC8qIFJBTSBjYXNl
ICovPGJyPg0KwqAgwqAgwqAgwqAgwqBwdHIgPSBxZW11X21hcF9yYW1fcHRyKG1yLSZndDtyYW1f
YmxvY2ssIGFkZHIxKTs8YnI+DQotwqAgwqAgwqAgwqAgc3dpdGNoIChlbmRpYW4pIHs8YnI+DQot
wqAgwqAgwqAgwqAgY2FzZSBERVZJQ0VfTElUVExFX0VORElBTjo8YnI+DQorwqAgwqAgwqAgwqAg
aWYgKChtb3AgJmFtcDsgTU9fQlNXQVApID09IE1PX0xFKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqBzdG5fbGVfcChwdHIsIHNpemUsIHZhbCk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGJy
ZWFrOzxicj4NCi3CoCDCoCDCoCDCoCBjYXNlIERFVklDRV9CSUdfRU5ESUFOOjxicj4NCivCoCDC
oCDCoCDCoCB9IGVsc2Ugezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgc3RuX2JlX3AocHRyLCBz
aXplLCB2YWwpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBicmVhazs8YnI+DQotwqAgwqAgwqAg
wqAgZGVmYXVsdDo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgc3RuX3AocHRyLCBzaXplLCB2YWwp
Ozxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBicmVhazs8YnI+DQrCoCDCoCDCoCDCoCDCoH08YnI+
DQrCoCDCoCDCoCDCoCDCoGludmFsaWRhdGVfYW5kX3NldF9kaXJ0eShtciwgYWRkcjEsIHNpemUp
Ozxicj4NCsKgIMKgIMKgIMKgIMKgciA9IE1FTVRYX09LOzxicj4NCkBAIC0xNTYsNDggKzEzNiw0
NCBAQCB2b2lkIGdsdWUoYWRkcmVzc19zcGFjZV9zdG1faW50ZXJuYWwsIFNVRkZJWCkoQVJHMV9E
RUNMLCBNZW1PcCBtb3AsPGJyPg0KPGJyPg0KwqAvKiB3YXJuaW5nOiBhZGRyIG11c3QgYmUgYWxp
Z25lZCAqLzxicj4NCsKgc3RhdGljIGlubGluZSB2b2lkIGdsdWUoYWRkcmVzc19zcGFjZV9zdGxf
aW50ZXJuYWwsIFNVRkZJWCkoQVJHMV9ERUNMLDxicj4NCi3CoCDCoCBod2FkZHIgYWRkciwgdWlu
dDMyX3QgdmFsLCBNZW1UeEF0dHJzIGF0dHJzLDxicj4NCi3CoCDCoCBNZW1UeFJlc3VsdCAqcmVz
dWx0LCBlbnVtIGRldmljZV9lbmRpYW4gZW5kaWFuKTxicj4NCivCoCDCoCBNZW1PcCBtb3AsIGh3
YWRkciBhZGRyLCB1aW50MzJfdCB2YWwsIE1lbVR4QXR0cnMgYXR0cnMsIE1lbVR4UmVzdWx0ICpy
ZXN1bHQpPGJyPg0KwqB7PGJyPg0KLcKgIMKgIGdsdWUoYWRkcmVzc19zcGFjZV9zdG1faW50ZXJu
YWwsIFNVRkZJWCkoQVJHMSwgTU9fMzIsIGFkZHIsIHZhbCw8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhdHRy
cywgcmVzdWx0LCBlbmRpYW4pOzxicj4NCivCoCDCoCBnbHVlKGFkZHJlc3Nfc3BhY2Vfc3RtX2lu
dGVybmFsLCBTVUZGSVgpKEFSRzEsIG1vcCB8IE1PXzMyLCBhZGRyLCB2YWwsPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgYXR0cnMsIHJlc3VsdCk7PGJyPg0KwqB9PGJyPg0KPGJyPg0KwqB2b2lkIGdsdWUoYWRk
cmVzc19zcGFjZV9zdGIsIFNVRkZJWCkoQVJHMV9ERUNMLCBod2FkZHIgYWRkciwgdWludDhfdCB2
YWwsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgTWVtVHhBdHRycyBhdHRycywgTWVtVHhSZXN1bHQgKnJlc3VsdCk8YnI+DQrCoHs8
YnI+DQrCoCDCoCDCoGdsdWUoYWRkcmVzc19zcGFjZV9zdG1faW50ZXJuYWwsIFNVRkZJWCkoQVJH
MSwgTU9fOCwgYWRkciwgdmFsLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGF0dHJzLCByZXN1bHQsPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgREVWSUNFX05BVElWRV9FTkRJQU4pOzxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGF0dHJz
LCByZXN1bHQpOzxicj4NCsKgfTxicj4NCjxicj4NCsKgLyogd2FybmluZzogYWRkciBtdXN0IGJl
IGFsaWduZWQgKi88YnI+DQrCoHN0YXRpYyBpbmxpbmUgdm9pZCBnbHVlKGFkZHJlc3Nfc3BhY2Vf
c3R3X2ludGVybmFsLCBTVUZGSVgpKEFSRzFfREVDTCw8YnI+DQotwqAgwqAgaHdhZGRyIGFkZHIs
IHVpbnQxNl90IHZhbCwgTWVtVHhBdHRycyBhdHRycyw8YnI+DQotwqAgwqAgTWVtVHhSZXN1bHQg
KnJlc3VsdCwgZW51bSBkZXZpY2VfZW5kaWFuIGVuZGlhbik8YnI+DQorwqAgwqAgTWVtT3AgbW9w
LCBod2FkZHIgYWRkciwgdWludDE2X3QgdmFsLCBNZW1UeEF0dHJzIGF0dHJzLCBNZW1UeFJlc3Vs
dCAqcmVzdWx0KTxicj4NCsKgezxicj4NCi3CoCDCoCBnbHVlKGFkZHJlc3Nfc3BhY2Vfc3RtX2lu
dGVybmFsLCBTVUZGSVgpKEFSRzEsIE1PXzE2LCBhZGRyLCB2YWwsPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
YXR0cnMsIHJlc3VsdCwgZW5kaWFuKTs8YnI+DQorwqAgwqAgZ2x1ZShhZGRyZXNzX3NwYWNlX3N0
bV9pbnRlcm5hbCwgU1VGRklYKShBUkcxLCBtb3AgfCBNT18xNiwgYWRkciwgdmFsLDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGF0dHJzLCByZXN1bHQpOzxicj4NCsKgfTxicj4NCjxicj4NCsKgc3RhdGljIGlu
bGluZSB2b2lkIGdsdWUoYWRkcmVzc19zcGFjZV9zdHFfaW50ZXJuYWwsIFNVRkZJWCkoQVJHMV9E
RUNMLDxicj4NCi3CoCDCoCBod2FkZHIgYWRkciwgdWludDY0X3QgdmFsLCBNZW1UeEF0dHJzIGF0
dHJzLDxicj4NCi3CoCDCoCBNZW1UeFJlc3VsdCAqcmVzdWx0LCBlbnVtIGRldmljZV9lbmRpYW4g
ZW5kaWFuKTxicj4NCivCoCDCoCBNZW1PcCBtb3AsIGh3YWRkciBhZGRyLCB1aW50NjRfdCB2YWws
IE1lbVR4QXR0cnMgYXR0cnMsIE1lbVR4UmVzdWx0ICpyZXN1bHQpPGJyPg0KwqB7PGJyPg0KLcKg
IMKgIGdsdWUoYWRkcmVzc19zcGFjZV9zdG1faW50ZXJuYWwsIFNVRkZJWCkoQVJHMSwgTU9fNjQs
IGFkZHIsIHZhbCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhdHRycywgcmVzdWx0LCBlbmRpYW4pOzxicj4N
CivCoCDCoCBnbHVlKGFkZHJlc3Nfc3BhY2Vfc3RtX2ludGVybmFsLCBTVUZGSVgpKEFSRzEsIG1v
cCB8IE1PXzY0LCBhZGRyLCB2YWwsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYXR0cnMsIHJlc3VsdCk7PGJy
Pg0KwqB9PGJyPg0KPGJyPg0KwqAjZGVmaW5lIEVORElBTk5FU1M8YnI+DQotI2RlZmluZSBERVZJ
Q0VfRU5ESUFOTkVTU8KgIMKgIMKgIMKgREVWSUNFX05BVElWRV9FTkRJQU48YnI+DQorI2RlZmlu
ZSBNT19FTkRJQU7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCh0YXJnZXRfYmlnX2VuZGlhbigpID8g
TU9fQkUgOiBNT19MRSk8YnI+DQrCoCNpbmNsdWRlICZxdW90O21lbW9yeV9sZHN0X2VuZGlhbi5j
LmluYyZxdW90Ozxicj4NCjxicj4NCsKgI2RlZmluZSBFTkRJQU5ORVNTwqAgwqAgwqAgwqAgwqAg
wqAgwqAgX2xlPGJyPg0KLSNkZWZpbmUgREVWSUNFX0VORElBTk5FU1PCoCDCoCDCoCDCoERFVklD
RV9MSVRUTEVfRU5ESUFOPGJyPg0KKyNkZWZpbmUgTU9fRU5ESUFOwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBNT19MRTxicj4NCsKgI2luY2x1ZGUgJnF1b3Q7bWVtb3J5X2xkc3RfZW5kaWFuLmMuaW5j
JnF1b3Q7PGJyPg0KPGJyPg0KwqAjZGVmaW5lIEVORElBTk5FU1PCoCDCoCDCoCDCoCDCoCDCoCDC
oCBfYmU8YnI+DQotI2RlZmluZSBERVZJQ0VfRU5ESUFOTkVTU8KgIMKgIMKgIMKgREVWSUNFX0JJ
R19FTkRJQU48YnI+DQorI2RlZmluZSBNT19FTkRJQU7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE1P
X0JFPGJyPg0KwqAjaW5jbHVkZSAmcXVvdDttZW1vcnlfbGRzdF9lbmRpYW4uYy5pbmMmcXVvdDs8
YnI+DQo8YnI+DQrCoCN1bmRlZiBBUkcxX0RFQ0w8YnI+DQpkaWZmIC0tZ2l0IGEvc3lzdGVtL21l
bW9yeV9sZHN0X2VuZGlhbi5jLmluYyBiL3N5c3RlbS9tZW1vcnlfbGRzdF9lbmRpYW4uYy5pbmM8
YnI+DQppbmRleCA3OTFkMDQxYjE1ZC4uOWNmMzYwMTcxMzUgMTAwNjQ0PGJyPg0KLS0tIGEvc3lz
dGVtL21lbW9yeV9sZHN0X2VuZGlhbi5jLmluYzxicj4NCisrKyBiL3N5c3RlbS9tZW1vcnlfbGRz
dF9lbmRpYW4uYy5pbmM8YnI+DQpAQCAtMjIsNDMgKzIyLDQzIEBAPGJyPg0KwqB1aW50MTZfdCBB
RERSRVNTX1NQQUNFX0xEKHV3KShBUkcxX0RFQ0wsIGh3YWRkciBhZGRyLDxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTWVtVHhBdHRycyBhdHRycywg
TWVtVHhSZXN1bHQgKnJlc3VsdCk8YnI+DQrCoHs8YnI+DQotwqAgwqAgcmV0dXJuIEFERFJFU1Nf
U1BBQ0VfTERfSU5URVJOQUwodXcpKEFSRzEsIGFkZHIsIGF0dHJzLCByZXN1bHQsPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgREVWSUNFX0VORElBTk5FU1MpOzxicj4NCivCoCDCoCByZXR1cm4gQUREUkVTU19TUEFDRV9M
RF9JTlRFUk5BTCh1dykoQVJHMSwgTU9fRU5ESUFOLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBhZGRyLCBhdHRycywgcmVz
dWx0KTs8YnI+DQrCoH08YnI+DQo8YnI+DQrCoHVpbnQzMl90IEFERFJFU1NfU1BBQ0VfTEQobCko
QVJHMV9ERUNMLCBod2FkZHIgYWRkciw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBNZW1UeEF0dHJzIGF0dHJzLCBNZW1UeFJlc3VsdCAqcmVzdWx0KTxi
cj4NCsKgezxicj4NCi3CoCDCoCByZXR1cm4gQUREUkVTU19TUEFDRV9MRF9JTlRFUk5BTChsKShB
UkcxLCBhZGRyLCBhdHRycywgcmVzdWx0LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBERVZJQ0VfRU5ESUFOTkVTUyk7PGJy
Pg0KK8KgIMKgIHJldHVybiBBRERSRVNTX1NQQUNFX0xEX0lOVEVSTkFMKGwpKEFSRzEsIE1PX0VO
RElBTiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgYWRkciwgYXR0cnMsIHJlc3VsdCk7PGJyPg0KwqB9PGJyPg0KPGJyPg0K
wqB1aW50NjRfdCBBRERSRVNTX1NQQUNFX0xEKHEpKEFSRzFfREVDTCwgaHdhZGRyIGFkZHIsPGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTWVtVHhBdHRy
cyBhdHRycywgTWVtVHhSZXN1bHQgKnJlc3VsdCk8YnI+DQrCoHs8YnI+DQotwqAgwqAgcmV0dXJu
IEFERFJFU1NfU1BBQ0VfTERfSU5URVJOQUwocSkoQVJHMSwgYWRkciwgYXR0cnMsIHJlc3VsdCw8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgREVWSUNFX0VORElBTk5FU1MpOzxicj4NCivCoCDCoCByZXR1cm4gQUREUkVTU19T
UEFDRV9MRF9JTlRFUk5BTChxKShBUkcxLCBNT19FTkRJQU4sPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFkZHIsIGF0dHJz
LCByZXN1bHQpOzxicj4NCsKgfTxicj4NCjxicj4NCsKgdm9pZCBBRERSRVNTX1NQQUNFX1NUKHcp
KEFSRzFfREVDTCwgaHdhZGRyIGFkZHIsIHVpbnQxNl90IHZhbCw8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBNZW1UeEF0dHJzIGF0dHJzLCBNZW1UeFJlc3VsdCAq
cmVzdWx0KTxicj4NCsKgezxicj4NCi3CoCDCoCBBRERSRVNTX1NQQUNFX1NUX0lOVEVSTkFMKHcp
KEFSRzEsIGFkZHIsIHZhbCwgYXR0cnMsIHJlc3VsdCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBERVZJQ0VfRU5ESUFOTkVTUyk7PGJyPg0K
K8KgIMKgIEFERFJFU1NfU1BBQ0VfU1RfSU5URVJOQUwodykoQVJHMSwgTU9fRU5ESUFOLDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFkZHIs
IHZhbCwgYXR0cnMsIHJlc3VsdCk7PGJyPg0KwqB9PGJyPg0KPGJyPg0KwqB2b2lkIEFERFJFU1Nf
U1BBQ0VfU1QobCkoQVJHMV9ERUNMLCBod2FkZHIgYWRkciwgdWludDMyX3QgdmFsLDxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1lbVR4QXR0cnMgYXR0cnMsIE1l
bVR4UmVzdWx0ICpyZXN1bHQpPGJyPg0KwqB7PGJyPg0KLcKgIMKgIEFERFJFU1NfU1BBQ0VfU1Rf
SU5URVJOQUwobCkoQVJHMSwgYWRkciwgdmFsLCBhdHRycywgcmVzdWx0LDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoERFVklDRV9FTkRJQU5O
RVNTKTs8YnI+DQorwqAgwqAgQUREUkVTU19TUEFDRV9TVF9JTlRFUk5BTChsKShBUkcxLCBNT19F
TkRJQU4sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgYWRkciwgdmFsLCBhdHRycywgcmVzdWx0KTs8YnI+DQrCoH08YnI+DQo8YnI+DQrCoHZv
aWQgQUREUkVTU19TUEFDRV9TVChxKShBUkcxX0RFQ0wsIGh3YWRkciBhZGRyLCB1aW50NjRfdCB2
YWwsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTWVtVHhBdHRy
cyBhdHRycywgTWVtVHhSZXN1bHQgKnJlc3VsdCk8YnI+DQrCoHs8YnI+DQotwqAgwqAgQUREUkVT
U19TUEFDRV9TVF9JTlRFUk5BTChxKShBUkcxLCBhZGRyLCB2YWwsIGF0dHJzLCByZXN1bHQsPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgREVW
SUNFX0VORElBTk5FU1MpOzxicj4NCivCoCDCoCBBRERSRVNTX1NQQUNFX1NUX0lOVEVSTkFMKHEp
KEFSRzEsIE1PX0VORElBTiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBhZGRyLCB2YWwsIGF0dHJzLCByZXN1bHQpOzxicj4NCsKgfTxicj4N
Cjxicj4NCsKgI3VuZGVmIEFERFJFU1NfU1BBQ0VfTEQ8YnI+DQpAQCAtNjcsNCArNjcsNCBAQCB2
b2lkIEFERFJFU1NfU1BBQ0VfU1QocSkoQVJHMV9ERUNMLCBod2FkZHIgYWRkciwgdWludDY0X3Qg
dmFsLDxicj4NCsKgI3VuZGVmIEFERFJFU1NfU1BBQ0VfU1RfSU5URVJOQUw8YnI+DQo8YnI+DQrC
oCN1bmRlZiBFTkRJQU5ORVNTPGJyPg0KLSN1bmRlZiBERVZJQ0VfRU5ESUFOTkVTUzxicj4NCisj
dW5kZWYgTU9fRU5ESUFOPGJyPg0KLS0gPGJyPg0KMi41Mi4wPGJyPg0KPGJyPg0KPC9ibG9ja3F1
b3RlPjwvZGl2PjwvZGl2PjwvZGl2Pg0K
--000000000000ec2d31064701261c--


