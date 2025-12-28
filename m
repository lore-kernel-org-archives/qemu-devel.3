Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1C7D3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 20:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZxQ5-0005m6-Cb; Sun, 28 Dec 2025 15:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZxQ2-0005j7-VD
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 15:31:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZxPz-00052z-G6
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 15:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766953871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bYHAbgFDiFq2rRw4aEdu+21friVlqL2FY4Huiu0+hgQ=;
 b=UAqvdAF6YnF7DgyYQ7u3bcua6wtp47r9XNkMeZ4Q1oAAIRESvPVHZjUMGqXvQnw/dks7Rq
 MNEYpKy4DKQBIQUIc07HnAp+ZI/+DWqvYj9qb2A1bqSeDluvUDjc/Tfrm19K17vG38Ymwq
 sn4TN8PDjz2Q05MAuPRHcL3OjNwPaEg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-Zk31L8oxNH--LvC_d9CJQg-1; Sun, 28 Dec 2025 15:31:07 -0500
X-MC-Unique: Zk31L8oxNH--LvC_d9CJQg-1
X-Mimecast-MFC-AGG-ID: Zk31L8oxNH--LvC_d9CJQg_1766953866
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430fcf10280so6329027f8f.0
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 12:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766953866; x=1767558666; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bYHAbgFDiFq2rRw4aEdu+21friVlqL2FY4Huiu0+hgQ=;
 b=MFlAsY9PgAs939KkAozEyE6meEvJNlulJMcv+MfcWjGnuVLUiL+A7k3RpkgD0/w8cq
 mQSV+TYxqal5Fuaqs1qg/xP+HK/RXpyXSVwAX4NHpYxFiXSJllm/2zB2El7x6DGK16UW
 Fe/DKjt2ADywE1omDq0aVbxtlrPLUhkWIPgEPzFL5+FVAN/2rwIGZFVQbNfiqJ0AtZvM
 WAvZGK5JBXcJw2CMj9AjhV6o2MoGikKiHqqSJlV+DZvwdjY13qdaWrCLGp+BFV0b1E8O
 kDx0/itPHDBcqvKMjOet1YdtC8qK8/IKuAWGKVV41zvAdq7cJQ/6I7Lr9WilTpLQ/5jQ
 MQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953866; x=1767558666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYHAbgFDiFq2rRw4aEdu+21friVlqL2FY4Huiu0+hgQ=;
 b=noHun7ZT7JbLjuAfP3/wefQAdgsPJt+9+6LN+32OZE/dT39M3wDEfuACvM+xB1b3+d
 LU4F2a/aQW2j65KMFuKUSJQ8ct1ohkNtQWY0kK6zmfO7XXJXec5j1tAcqlRoM/+ntaag
 rO8IJMJIl/HSbKP6Fs0hsxd8qlOHxSNKpK1TK9+cERtrcuaOdCALks8I12idmWKvzUhP
 ZrnT+hVhQdGqS9s5dBFp/14ooN3cihOw85FxQ+IK3os4K8Ii9OwpvU1PT+UKuSatHGxS
 8a2Us8P1ZCPG7EFIlNZ66z1Z3n8FtAZkk+BFdyxUaqlbKlgq0nCrMePJ8wrlNLynA31r
 w2IA==
X-Gm-Message-State: AOJu0Yx1J1UiMayIpTf5BXPEqgxnRpU+1NIT19J4AZdk3uqWjMUwjF5i
 5DGmiv3/mE4rJ5L8S9aRD8ryVx2Kj0YuZfzTapisxB3XqCDwAPDJb/fVRnYJd5o5HBzZYUzRy9+
 YkeZgfjf6kYkkCowvlJfEWwuFQJIvs4DLg0FjWwMeymkFXQLid31t3Yl9g91Dm50kALdNDarI/I
 iucprjuzOgKUmujXrFWsW3K5pJcsxh05A=
X-Gm-Gg: AY/fxX6sWpSk4DCjRno2CWenm3aaa9G8aKu3N+vpfi978YDA7yPEaz9X61PuHVtbMpP
 u730R1rzWHXeLJ9XWNUg0djJODGmA4WSS1xkj8wzfkdLz1ARO5ZBUgf0FHUCbecJvNPKq3pzEN9
 VXxQQH+5p8Mrgso9fAcNP3azdbnaDFBieJg7v10GneRWyv36eEg/FH0A9b/O4wg8Q7xnAIow0TJ
 oUGbWQEyM4YAzg9d83PxzjVRniobA4BtDPaF13Y0W190u86IKA0KaHTjPcmUKyOculYBno=
X-Received: by 2002:a05:6000:2305:b0:431:808:2d49 with SMTP id
 ffacd0b85a97d-4324e4c6fbfmr30116840f8f.8.1766953865486; 
 Sun, 28 Dec 2025 12:31:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsmgv6RnjX5GYGZQHDeAdJTvNydTV/uJmCZWLawcqdTmPTnTRGHkzsMGojeMWFJmBFHU1wf5Ag3foyKu4ZiGY=
X-Received: by 2002:a05:6000:2305:b0:431:808:2d49 with SMTP id
 ffacd0b85a97d-4324e4c6fbfmr30116827f8f.8.1766953864966; Sun, 28 Dec 2025
 12:31:04 -0800 (PST)
MIME-Version: 1.0
References: <20251228161837.12413-1-philmd@linaro.org>
 <20251228161837.12413-4-philmd@linaro.org>
In-Reply-To: <20251228161837.12413-4-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 28 Dec 2025 21:30:52 +0100
X-Gm-Features: AQt7F2oDGhqLafQpdcsg1YU8xH43tkgYM-NqutrpZf5DKHXO-71AfNIYhRejwrY
Message-ID: <CABgObfYmP2jrM+uGj0Vpb-7Fx+W2LZge=Tf231GJSUQWfjOO9w@mail.gmail.com>
Subject: Re: [PATCH 3/3] system/memory: Rename unaligned load/store API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 David Hildenbrand <david@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, 
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Jason Wang <jasowang@redhat.com>, 
 "zmta06.collab.prod.int.phx2.redhat.com, list@suse.de" <qemu-ppc@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000074cb6a0647090159"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--00000000000074cb6a0647090159
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il dom 28 dic 2025, 17:19 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> Rename the API methods using the explicit 'unaligned'
> description instead of 'he' which stands for 'host
> endianness'.
>
> Inspired-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/qemu/bswap.h                 | 32 ++++++++++++++--------------
>  include/qemu/memory_ldst_unaligned.h | 16 +++++++-------
>

No "memory_" since it's for host pointers and not guest memory addresses.

Paolo

 accel/tcg/translator.c               |  6 +++---
>  hw/display/ati_2d.c                  |  2 +-
>  hw/display/sm501.c                   | 19 ++++++++++-------
>  hw/remote/vfio-user-obj.c            |  4 ++--
>  hw/vmapple/virtio-blk.c              |  2 +-
>  net/checksum.c                       |  6 +++---
>  system/memory.c                      |  4 ++--
>  system/physmem.c                     |  8 +++----
>  ui/vnc-enc-tight.c                   |  2 +-
>  util/bufferiszero.c                  |  6 +++---
>  accel/tcg/ldst_atomicity.c.inc       | 10 ++++-----
>  13 files changed, 60 insertions(+), 57 deletions(-)
>
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index e8b944988c3..f7c806085fb 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -237,82 +237,82 @@ static inline void stb_p(void *ptr, uint8_t v)
>
>  static inline int lduw_le_p(const void *ptr)
>  {
> -    return (uint16_t)le_bswap(lduw_he_p(ptr), 16);
> +    return (uint16_t)le_bswap(lduw_unaligned_p(ptr), 16);
>  }
>
>  static inline int ldsw_le_p(const void *ptr)
>  {
> -    return (int16_t)le_bswap(lduw_he_p(ptr), 16);
> +    return (int16_t)le_bswap(lduw_unaligned_p(ptr), 16);
>  }
>
>  static inline int ldl_le_p(const void *ptr)
>  {
> -    return le_bswap(ldl_he_p(ptr), 32);
> +    return le_bswap(ldl_unaligned_p(ptr), 32);
>  }
>
>  static inline uint64_t ldq_le_p(const void *ptr)
>  {
> -    return le_bswap(ldq_he_p(ptr), 64);
> +    return le_bswap(ldq_unaligned_p(ptr), 64);
>  }
>
>  static inline void stw_le_p(void *ptr, uint16_t v)
>  {
> -    stw_he_p(ptr, le_bswap(v, 16));
> +    stw_unaligned_p(ptr, le_bswap(v, 16));
>  }
>
>  static inline void st24_le_p(void *ptr, uint32_t v)
>  {
> -    st24_he_p(ptr, le_bswap24(v));
> +    st24_unaligned_p(ptr, le_bswap24(v));
>  }
>
>  static inline void stl_le_p(void *ptr, uint32_t v)
>  {
> -    stl_he_p(ptr, le_bswap(v, 32));
> +    stl_unaligned_p(ptr, le_bswap(v, 32));
>  }
>
>  static inline void stq_le_p(void *ptr, uint64_t v)
>  {
> -    stq_he_p(ptr, le_bswap(v, 64));
> +    stq_unaligned_p(ptr, le_bswap(v, 64));
>  }
>
>  static inline int lduw_be_p(const void *ptr)
>  {
> -    return (uint16_t)be_bswap(lduw_he_p(ptr), 16);
> +    return (uint16_t)be_bswap(lduw_unaligned_p(ptr), 16);
>  }
>
>  static inline int ldsw_be_p(const void *ptr)
>  {
> -    return (int16_t)be_bswap(lduw_he_p(ptr), 16);
> +    return (int16_t)be_bswap(lduw_unaligned_p(ptr), 16);
>  }
>
>  static inline int ldl_be_p(const void *ptr)
>  {
> -    return be_bswap(ldl_he_p(ptr), 32);
> +    return be_bswap(ldl_unaligned_p(ptr), 32);
>  }
>
>  static inline uint64_t ldq_be_p(const void *ptr)
>  {
> -    return be_bswap(ldq_he_p(ptr), 64);
> +    return be_bswap(ldq_unaligned_p(ptr), 64);
>  }
>
>  static inline void stw_be_p(void *ptr, uint16_t v)
>  {
> -    stw_he_p(ptr, be_bswap(v, 16));
> +    stw_unaligned_p(ptr, be_bswap(v, 16));
>  }
>
>  static inline void st24_be_p(void *ptr, uint32_t v)
>  {
> -    st24_he_p(ptr, be_bswap24(v));
> +    st24_unaligned_p(ptr, be_bswap24(v));
>  }
>
>  static inline void stl_be_p(void *ptr, uint32_t v)
>  {
> -    stl_he_p(ptr, be_bswap(v, 32));
> +    stl_unaligned_p(ptr, be_bswap(v, 32));
>  }
>
>  static inline void stq_be_p(void *ptr, uint64_t v)
>  {
> -    stq_he_p(ptr, be_bswap(v, 64));
> +    stq_unaligned_p(ptr, be_bswap(v, 64));
>  }
>
>  /* Store v to p as a sz byte value in host order */
> diff --git a/include/qemu/memory_ldst_unaligned.h
> b/include/qemu/memory_ldst_unaligned.h
> index f6b64e8fe9c..6b0cc3e2777 100644
> --- a/include/qemu/memory_ldst_unaligned.h
> +++ b/include/qemu/memory_ldst_unaligned.h
> @@ -16,50 +16,50 @@
>   * of good performance.
>   */
>
> -static inline int lduw_he_p(const void *ptr)
> +static inline int lduw_unaligned_p(const void *ptr)
>  {
>      uint16_t r;
>      __builtin_memcpy(&r, ptr, sizeof(r));
>      return r;
>  }
>
> -static inline int ldsw_he_p(const void *ptr)
> +static inline int ldsw_unaligned_p(const void *ptr)
>  {
>      int16_t r;
>      __builtin_memcpy(&r, ptr, sizeof(r));
>      return r;
>  }
>
> -static inline void stw_he_p(void *ptr, uint16_t v)
> +static inline void stw_unaligned_p(void *ptr, uint16_t v)
>  {
>      __builtin_memcpy(ptr, &v, sizeof(v));
>  }
>
> -static inline void st24_he_p(void *ptr, uint32_t v)
> +static inline void st24_unaligned_p(void *ptr, uint32_t v)
>  {
>      __builtin_memcpy(ptr, &v, 3);
>  }
>
> -static inline int ldl_he_p(const void *ptr)
> +static inline int ldl_unaligned_p(const void *ptr)
>  {
>      int32_t r;
>      __builtin_memcpy(&r, ptr, sizeof(r));
>      return r;
>  }
>
> -static inline void stl_he_p(void *ptr, uint32_t v)
> +static inline void stl_unaligned_p(void *ptr, uint32_t v)
>  {
>      __builtin_memcpy(ptr, &v, sizeof(v));
>  }
>
> -static inline uint64_t ldq_he_p(const void *ptr)
> +static inline uint64_t ldq_unaligned_p(const void *ptr)
>  {
>      uint64_t r;
>      __builtin_memcpy(&r, ptr, sizeof(r));
>      return r;
>  }
>
> -static inline void stq_he_p(void *ptr, uint64_t v)
> +static inline void stq_unaligned_p(void *ptr, uint64_t v)
>  {
>      __builtin_memcpy(ptr, &v, sizeof(v));
>  }
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 86cdd70c47f..497128c96c5 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -342,14 +342,14 @@ static bool translator_ld(CPUArchState *env,
> DisasContextBase *db,
>      case 2:
>          if (QEMU_IS_ALIGNED(pc, 2)) {
>              uint16_t t =3D qatomic_read((uint16_t *)host);
> -            stw_he_p(dest, t);
> +            stw_unaligned_p(dest, t);
>              return true;
>          }
>          break;
>      case 4:
>          if (QEMU_IS_ALIGNED(pc, 4)) {
>              uint32_t t =3D qatomic_read((uint32_t *)host);
> -            stl_he_p(dest, t);
> +            stl_unaligned_p(dest, t);
>              return true;
>          }
>          break;
> @@ -357,7 +357,7 @@ static bool translator_ld(CPUArchState *env,
> DisasContextBase *db,
>      case 8:
>          if (QEMU_IS_ALIGNED(pc, 8)) {
>              uint64_t t =3D qatomic_read__nocheck((uint64_t *)host);
> -            stq_he_p(dest, t);
> +            stq_unaligned_p(dest, t);
>              return true;
>          }
>          break;
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 24a3c3e942f..333d78d7455 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -222,7 +222,7 @@ void ati_2d_blt(ATIVGAState *s)
>              for (y =3D 0; y < s->regs.dst_height; y++) {
>                  i =3D dst_x * bypp + (dst_y + y) * dst_pitch;
>                  for (x =3D 0; x < s->regs.dst_width; x++, i +=3D bypp) {
> -                    stn_he_p(&dst_bits[i], bypp, filler);
> +                    stn_unaligned_p(&dst_bits[i], bypp, filler);
>                  }
>              }
>          }
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 51efe2ad41f..776fedebb13 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -768,7 +768,7 @@ static void sm501_2d_operation(SM501State *s)
>              for (y =3D 0; y < height; y++) {
>                  i =3D (dst_x + (dst_y + y) * dst_pitch) * bypp;
>                  for (x =3D 0; x < width; x++, i +=3D bypp) {
> -                    stn_he_p(&d[i], bypp, ~ldn_he_p(&d[i], bypp));
> +                    stn_unaligned_p(&d[i], bypp, ~ldn_unaligned_p(&d[i],
> bypp));
>                  }
>              }
>          } else if (!rop_mode && rop =3D=3D 0x99) {
> @@ -781,8 +781,9 @@ static void sm501_2d_operation(SM501State *s)
>                  i =3D (dst_x + (dst_y + y) * dst_pitch) * bypp;
>                  j =3D (src_x + (src_y + y) * src_pitch) * bypp;
>                  for (x =3D 0; x < width; x++, i +=3D bypp, j +=3D bypp) =
{
> -                    stn_he_p(&d[i], bypp,
> -                             ~(ldn_he_p(&sp[j], bypp) ^ ldn_he_p(&d[i],
> bypp)));
> +                    stn_unaligned_p(&d[i], bypp,
> +                                    ~(ldn_unaligned_p(&sp[j], bypp)
> +                                      ^ ldn_unaligned_p(&d[i], bypp)));
>                  }
>              }
>          } else if (!rop_mode && rop =3D=3D 0xee) {
> @@ -795,8 +796,9 @@ static void sm501_2d_operation(SM501State *s)
>                  i =3D (dst_x + (dst_y + y) * dst_pitch) * bypp;
>                  j =3D (src_x + (src_y + y) * src_pitch) * bypp;
>                  for (x =3D 0; x < width; x++, i +=3D bypp, j +=3D bypp) =
{
> -                    stn_he_p(&d[i], bypp,
> -                             ldn_he_p(&sp[j], bypp) | ldn_he_p(&d[i],
> bypp));
> +                    stn_unaligned_p(&d[i], bypp,
> +                                    ldn_unaligned_p(&sp[j], bypp)
> +                                    | ldn_unaligned_p(&d[i], bypp));
>                  }
>              }
>          } else {
> @@ -818,8 +820,9 @@ static void sm501_2d_operation(SM501State *s)
>              if (width =3D=3D 1 && height =3D=3D 1) {
>                  unsigned int si =3D (src_x + src_y * src_pitch) * bypp;
>                  unsigned int di =3D (dst_x + dst_y * dst_pitch) * bypp;
> -                stn_he_p(&s->local_mem[dst_base + di], bypp,
> -                         ldn_he_p(&s->local_mem[src_base + si], bypp));
> +                stn_unaligned_p(&s->local_mem[dst_base + di], bypp,
> +                                ldn_unaligned_p(&s->local_mem[src_base +
> si],
> +                                                bypp));
>                  break;
>              }
>              /* If reverse blit do simple check for overlaps */
> @@ -917,7 +920,7 @@ static void sm501_2d_operation(SM501State *s)
>                  for (y =3D 0; y < height; y++) {
>                      i =3D (dst_x + (dst_y + y) * dst_pitch) * bypp;
>                      for (x =3D 0; x < width; x++, i +=3D bypp) {
> -                        stn_he_p(&d[i], bypp, color);
> +                        stn_unaligned_p(&d[i], bypp, color);
>                      }
>                  }
>              }
> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index 9c9ac8b0d92..44adff10eb9 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -392,7 +392,7 @@ static int vfu_object_mr_rw(MemoryRegion *mr, uint8_t
> *buf, hwaddr offset,
>          access_size =3D memory_access_size(mr, size, offset);
>
>          if (is_write) {
> -            val =3D ldn_he_p(ptr, access_size);
> +            val =3D ldn_unaligned_p(ptr, access_size);
>
>              result =3D memory_region_dispatch_write(mr, offset, val,
>                                                    size_memop(access_size=
),
> @@ -402,7 +402,7 @@ static int vfu_object_mr_rw(MemoryRegion *mr, uint8_t
> *buf, hwaddr offset,
>                                                   size_memop(access_size)=
,
>                                                   MEMTXATTRS_UNSPECIFIED)=
;
>
> -            stn_he_p(ptr, access_size, val);
> +            stn_unaligned_p(ptr, access_size, val);
>          }
>
>          if (release_lock) {
> diff --git a/hw/vmapple/virtio-blk.c b/hw/vmapple/virtio-blk.c
> index f5e8e92df75..805bcbc9467 100644
> --- a/hw/vmapple/virtio-blk.c
> +++ b/hw/vmapple/virtio-blk.c
> @@ -79,7 +79,7 @@ static void vmapple_virtio_blk_get_config(VirtIODevice
> *vdev, uint8_t *config)
>      g_assert(dev->parent_obj.config_size >=3D endof(struct
> virtio_blk_config, zoned));
>
>      /* Apple abuses the field for max_secure_erase_sectors as type id */
> -    stl_he_p(&blkcfg->max_secure_erase_sectors, dev->apple_type);
> +    stl_unaligned_p(&blkcfg->max_secure_erase_sectors, dev->apple_type);
>  }
>
>  static void vmapple_virtio_blk_class_init(ObjectClass *klass, const void
> *data)
> diff --git a/net/checksum.c b/net/checksum.c
> index 18be31c26e5..56314f5e76d 100644
> --- a/net/checksum.c
> +++ b/net/checksum.c
> @@ -110,7 +110,7 @@ void net_checksum_calculate(void *data, int length,
> int csum_flag)
>
>      /* Calculate IP checksum */
>      if (csum_flag & CSUM_IP) {
> -        stw_he_p(&ip->ip_sum, 0);
> +        stw_unaligned_p(&ip->ip_sum, 0);
>          csum =3D net_raw_checksum((uint8_t *)ip, IP_HDR_GET_LEN(ip));
>          stw_be_p(&ip->ip_sum, csum);
>      }
> @@ -142,7 +142,7 @@ void net_checksum_calculate(void *data, int length,
> int csum_flag)
>          }
>
>          /* Set csum to 0 */
> -        stw_he_p(&tcp->th_sum, 0);
> +        stw_unaligned_p(&tcp->th_sum, 0);
>
>          csum =3D net_checksum_tcpudp(ip_len, ip->ip_p,
>                                     (uint8_t *)&ip->ip_src,
> @@ -166,7 +166,7 @@ void net_checksum_calculate(void *data, int length,
> int csum_flag)
>          }
>
>          /* Set csum to 0 */
> -        stw_he_p(&udp->uh_sum, 0);
> +        stw_unaligned_p(&udp->uh_sum, 0);
>
>          csum =3D net_checksum_tcpudp(ip_len, ip->ip_p,
>                                     (uint8_t *)&ip->ip_src,
> diff --git a/system/memory.c b/system/memory.c
> index 8b84661ae36..653d46e8e79 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1365,7 +1365,7 @@ static uint64_t memory_region_ram_device_read(void
> *opaque,
>                                                hwaddr addr, unsigned size=
)
>  {
>      MemoryRegion *mr =3D opaque;
> -    uint64_t data =3D ldn_he_p(mr->ram_block->host + addr, size);
> +    uint64_t data =3D ldn_unaligned_p(mr->ram_block->host + addr, size);
>
>      trace_memory_region_ram_device_read(get_cpu_index(), mr, addr, data,
> size);
>
> @@ -1379,7 +1379,7 @@ static void memory_region_ram_device_write(void
> *opaque, hwaddr addr,
>
>      trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data=
,
> size);
>
> -    stn_he_p(mr->ram_block->host + addr, size, data);
> +    stn_unaligned_p(mr->ram_block->host + addr, size, data);
>  }
>
>  static const MemoryRegionOps ram_device_mem_ops =3D {
> diff --git a/system/physmem.c b/system/physmem.c
> index fb69cdb57d9..d62af6f2480 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3284,7 +3284,7 @@ static MemTxResult
> flatview_write_continue_step(MemTxAttrs attrs,
>
>          /*
>           * Assure Coverity (and ourselves) that we are not going to
> OVERRUN
> -         * the buffer by following ldn_he_p().
> +         * the buffer by following ldn_unaligned_p().
>           */
>  #ifdef QEMU_STATIC_ANALYSIS
>          assert((*l =3D=3D 1 && len >=3D 1) ||
> @@ -3292,7 +3292,7 @@ static MemTxResult
> flatview_write_continue_step(MemTxAttrs attrs,
>                 (*l =3D=3D 4 && len >=3D 4) ||
>                 (*l =3D=3D 8 && len >=3D 8));
>  #endif
> -        val =3D ldn_he_p(buf, *l);
> +        val =3D ldn_unaligned_p(buf, *l);
>          result =3D memory_region_dispatch_write(mr, mr_addr, val,
>                                                size_memop(*l), attrs);
>          if (release_lock) {
> @@ -3379,7 +3379,7 @@ static MemTxResult
> flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
>
>          /*
>           * Assure Coverity (and ourselves) that we are not going to
> OVERRUN
> -         * the buffer by following stn_he_p().
> +         * the buffer by following stn_unaligned_p().
>           */
>  #ifdef QEMU_STATIC_ANALYSIS
>          assert((*l =3D=3D 1 && len >=3D 1) ||
> @@ -3387,7 +3387,7 @@ static MemTxResult
> flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
>                 (*l =3D=3D 4 && len >=3D 4) ||
>                 (*l =3D=3D 8 && len >=3D 8));
>  #endif
> -        stn_he_p(buf, *l, val);
> +        stn_unaligned_p(buf, *l, val);
>
>          if (release_lock) {
>              bql_unlock();
> diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
> index b645aebccef..62d825dc05f 100644
> --- a/ui/vnc-enc-tight.c
> +++ b/ui/vnc-enc-tight.c
> @@ -912,7 +912,7 @@ static void tight_pack24(VncState *vs, uint8_t *buf,
> size_t count, size_t *ret)
>      }
>
>      while (count--) {
> -        pix =3D ldl_he_p(buf8);
> +        pix =3D ldl_unaligned_p(buf8);
>          *buf++ =3D (char)(pix >> rshift);
>          *buf++ =3D (char)(pix >> gshift);
>          *buf++ =3D (char)(pix >> bshift);
> diff --git a/util/bufferiszero.c b/util/bufferiszero.c
> index 9548dd3ad1b..d7775dc891d 100644
> --- a/util/bufferiszero.c
> +++ b/util/bufferiszero.c
> @@ -38,10 +38,10 @@ static bool buffer_is_zero_int_lt256(const void *buf,
> size_t len)
>       * the beginning and end of the buffer.
>       */
>      if (unlikely(len <=3D 8)) {
> -        return (ldl_he_p(buf) | ldl_he_p(buf + len - 4)) =3D=3D 0;
> +        return (ldl_unaligned_p(buf) | ldl_unaligned_p(buf + len - 4)) =
=3D=3D
> 0;
>      }
>
> -    t =3D ldq_he_p(buf) | ldq_he_p(buf + len - 8);
> +    t =3D ldq_unaligned_p(buf) | ldq_unaligned_p(buf + len - 8);
>      p =3D QEMU_ALIGN_PTR_DOWN(buf + 8, 8);
>      e =3D QEMU_ALIGN_PTR_DOWN(buf + len - 1, 8);
>
> @@ -58,7 +58,7 @@ static bool buffer_is_zero_int_ge256(const void *buf,
> size_t len)
>       * Use unaligned memory access functions to handle
>       * the beginning and end of the buffer.
>       */
> -    uint64_t t =3D ldq_he_p(buf) | ldq_he_p(buf + len - 8);
> +    uint64_t t =3D ldq_unaligned_p(buf) | ldq_unaligned_p(buf + len - 8)=
;
>      const uint64_t *p =3D QEMU_ALIGN_PTR_DOWN(buf + 8, 8);
>      const uint64_t *e =3D QEMU_ALIGN_PTR_DOWN(buf + len - 1, 8);
>
> diff --git a/accel/tcg/ldst_atomicity.c.inc
> b/accel/tcg/ldst_atomicity.c.inc
> index c735add2615..eeb18c716c0 100644
> --- a/accel/tcg/ldst_atomicity.c.inc
> +++ b/accel/tcg/ldst_atomicity.c.inc
> @@ -415,7 +415,7 @@ static uint16_t load_atom_2(CPUState *cpu, uintptr_t
> ra,
>      atmax =3D required_atomicity(cpu, pi, memop);
>      switch (atmax) {
>      case MO_8:
> -        return lduw_he_p(pv);
> +        return lduw_unaligned_p(pv);
>      case MO_16:
>          /* The only case remaining is MO_ATOM_WITHIN16. */
>          if (!HAVE_al8_fast && (pi & 3) =3D=3D 1) {
> @@ -512,7 +512,7 @@ static uint64_t load_atom_8(CPUState *cpu, uintptr_t
> ra,
>      }
>      switch (atmax) {
>      case MO_8:
> -        return ldq_he_p(pv);
> +        return ldq_unaligned_p(pv);
>      case MO_16:
>          return load_atom_8_by_2(pv);
>      case MO_32:
> @@ -875,7 +875,7 @@ static void store_atom_2(CPUState *cpu, uintptr_t ra,
>
>      atmax =3D required_atomicity(cpu, pi, memop);
>      if (atmax =3D=3D MO_8) {
> -        stw_he_p(pv, val);
> +        stw_unaligned_p(pv, val);
>          return;
>      }
>
> @@ -928,7 +928,7 @@ static void store_atom_4(CPUState *cpu, uintptr_t ra,
>      atmax =3D required_atomicity(cpu, pi, memop);
>      switch (atmax) {
>      case MO_8:
> -        stl_he_p(pv, val);
> +        stl_unaligned_p(pv, val);
>          return;
>      case MO_16:
>          store_atom_4_by_2(pv, val);
> @@ -996,7 +996,7 @@ static void store_atom_8(CPUState *cpu, uintptr_t ra,
>      atmax =3D required_atomicity(cpu, pi, memop);
>      switch (atmax) {
>      case MO_8:
> -        stq_he_p(pv, val);
> +        stq_unaligned_p(pv, val);
>          return;
>      case MO_16:
>          store_atom_8_by_2(pv, val);
> --
> 2.52.0
>
>

--00000000000074cb6a0647090159
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il dom 28 dic 2025, 17:19 Philip=
pe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linar=
o.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Rename the API methods using the explicit &#39;unaligned&#39;<br=
>
description instead of &#39;he&#39; which stands for &#39;host<br>
endianness&#39;.<br>
<br>
Inspired-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank" rel=3D"noreferrer">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0include/qemu/bswap.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 32 ++++++++++++++--------------<br>
=C2=A0include/qemu/memory_ldst_unaligned.h | 16 +++++++-------<br></blockqu=
ote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">No &quot;memo=
ry_&quot; since it&#39;s for host pointers and not guest memory addresses.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_cont=
ainer"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0accel/tcg/translator.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 6 +++---<br>
=C2=A0hw/display/ati_2d.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0hw/display/sm501.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 19 ++++++++++-------<br>
=C2=A0hw/remote/vfio-user-obj.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 4 ++--<br>
=C2=A0hw/vmapple/virtio-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 2 +-<br>
=C2=A0net/checksum.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +++---<br>
=C2=A0system/memory.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
=C2=A0system/physmem.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 +++----<br>
=C2=A0ui/vnc-enc-tight.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0util/bufferiszero.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 6 +++---<br>
=C2=A0accel/tcg/ldst_atomicity.c.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 ++++---=
--<br>
=C2=A013 files changed, 60 insertions(+), 57 deletions(-)<br>
<br>
diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h<br>
index e8b944988c3..f7c806085fb 100644<br>
--- a/include/qemu/bswap.h<br>
+++ b/include/qemu/bswap.h<br>
@@ -237,82 +237,82 @@ static inline void stb_p(void *ptr, uint8_t v)<br>
<br>
=C2=A0static inline int lduw_le_p(const void *ptr)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return (uint16_t)le_bswap(lduw_he_p(ptr), 16);<br>
+=C2=A0 =C2=A0 return (uint16_t)le_bswap(lduw_unaligned_p(ptr), 16);<br>
=C2=A0}<br>
<br>
=C2=A0static inline int ldsw_le_p(const void *ptr)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return (int16_t)le_bswap(lduw_he_p(ptr), 16);<br>
+=C2=A0 =C2=A0 return (int16_t)le_bswap(lduw_unaligned_p(ptr), 16);<br>
=C2=A0}<br>
<br>
=C2=A0static inline int ldl_le_p(const void *ptr)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return le_bswap(ldl_he_p(ptr), 32);<br>
+=C2=A0 =C2=A0 return le_bswap(ldl_unaligned_p(ptr), 32);<br>
=C2=A0}<br>
<br>
=C2=A0static inline uint64_t ldq_le_p(const void *ptr)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return le_bswap(ldq_he_p(ptr), 64);<br>
+=C2=A0 =C2=A0 return le_bswap(ldq_unaligned_p(ptr), 64);<br>
=C2=A0}<br>
<br>
=C2=A0static inline void stw_le_p(void *ptr, uint16_t v)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 stw_he_p(ptr, le_bswap(v, 16));<br>
+=C2=A0 =C2=A0 stw_unaligned_p(ptr, le_bswap(v, 16));<br>
=C2=A0}<br>
<br>
=C2=A0static inline void st24_le_p(void *ptr, uint32_t v)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 st24_he_p(ptr, le_bswap24(v));<br>
+=C2=A0 =C2=A0 st24_unaligned_p(ptr, le_bswap24(v));<br>
=C2=A0}<br>
<br>
=C2=A0static inline void stl_le_p(void *ptr, uint32_t v)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 stl_he_p(ptr, le_bswap(v, 32));<br>
+=C2=A0 =C2=A0 stl_unaligned_p(ptr, le_bswap(v, 32));<br>
=C2=A0}<br>
<br>
=C2=A0static inline void stq_le_p(void *ptr, uint64_t v)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 stq_he_p(ptr, le_bswap(v, 64));<br>
+=C2=A0 =C2=A0 stq_unaligned_p(ptr, le_bswap(v, 64));<br>
=C2=A0}<br>
<br>
=C2=A0static inline int lduw_be_p(const void *ptr)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return (uint16_t)be_bswap(lduw_he_p(ptr), 16);<br>
+=C2=A0 =C2=A0 return (uint16_t)be_bswap(lduw_unaligned_p(ptr), 16);<br>
=C2=A0}<br>
<br>
=C2=A0static inline int ldsw_be_p(const void *ptr)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return (int16_t)be_bswap(lduw_he_p(ptr), 16);<br>
+=C2=A0 =C2=A0 return (int16_t)be_bswap(lduw_unaligned_p(ptr), 16);<br>
=C2=A0}<br>
<br>
=C2=A0static inline int ldl_be_p(const void *ptr)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return be_bswap(ldl_he_p(ptr), 32);<br>
+=C2=A0 =C2=A0 return be_bswap(ldl_unaligned_p(ptr), 32);<br>
=C2=A0}<br>
<br>
=C2=A0static inline uint64_t ldq_be_p(const void *ptr)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return be_bswap(ldq_he_p(ptr), 64);<br>
+=C2=A0 =C2=A0 return be_bswap(ldq_unaligned_p(ptr), 64);<br>
=C2=A0}<br>
<br>
=C2=A0static inline void stw_be_p(void *ptr, uint16_t v)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 stw_he_p(ptr, be_bswap(v, 16));<br>
+=C2=A0 =C2=A0 stw_unaligned_p(ptr, be_bswap(v, 16));<br>
=C2=A0}<br>
<br>
=C2=A0static inline void st24_be_p(void *ptr, uint32_t v)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 st24_he_p(ptr, be_bswap24(v));<br>
+=C2=A0 =C2=A0 st24_unaligned_p(ptr, be_bswap24(v));<br>
=C2=A0}<br>
<br>
=C2=A0static inline void stl_be_p(void *ptr, uint32_t v)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 stl_he_p(ptr, be_bswap(v, 32));<br>
+=C2=A0 =C2=A0 stl_unaligned_p(ptr, be_bswap(v, 32));<br>
=C2=A0}<br>
<br>
=C2=A0static inline void stq_be_p(void *ptr, uint64_t v)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 stq_he_p(ptr, be_bswap(v, 64));<br>
+=C2=A0 =C2=A0 stq_unaligned_p(ptr, be_bswap(v, 64));<br>
=C2=A0}<br>
<br>
=C2=A0/* Store v to p as a sz byte value in host order */<br>
diff --git a/include/qemu/memory_ldst_unaligned.h b/include/qemu/memory_lds=
t_unaligned.h<br>
index f6b64e8fe9c..6b0cc3e2777 100644<br>
--- a/include/qemu/memory_ldst_unaligned.h<br>
+++ b/include/qemu/memory_ldst_unaligned.h<br>
@@ -16,50 +16,50 @@<br>
=C2=A0 * of good performance.<br>
=C2=A0 */<br>
<br>
-static inline int lduw_he_p(const void *ptr)<br>
+static inline int lduw_unaligned_p(const void *ptr)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint16_t r;<br>
=C2=A0 =C2=A0 =C2=A0__builtin_memcpy(&amp;r, ptr, sizeof(r));<br>
=C2=A0 =C2=A0 =C2=A0return r;<br>
=C2=A0}<br>
<br>
-static inline int ldsw_he_p(const void *ptr)<br>
+static inline int ldsw_unaligned_p(const void *ptr)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int16_t r;<br>
=C2=A0 =C2=A0 =C2=A0__builtin_memcpy(&amp;r, ptr, sizeof(r));<br>
=C2=A0 =C2=A0 =C2=A0return r;<br>
=C2=A0}<br>
<br>
-static inline void stw_he_p(void *ptr, uint16_t v)<br>
+static inline void stw_unaligned_p(void *ptr, uint16_t v)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0__builtin_memcpy(ptr, &amp;v, sizeof(v));<br>
=C2=A0}<br>
<br>
-static inline void st24_he_p(void *ptr, uint32_t v)<br>
+static inline void st24_unaligned_p(void *ptr, uint32_t v)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0__builtin_memcpy(ptr, &amp;v, 3);<br>
=C2=A0}<br>
<br>
-static inline int ldl_he_p(const void *ptr)<br>
+static inline int ldl_unaligned_p(const void *ptr)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int32_t r;<br>
=C2=A0 =C2=A0 =C2=A0__builtin_memcpy(&amp;r, ptr, sizeof(r));<br>
=C2=A0 =C2=A0 =C2=A0return r;<br>
=C2=A0}<br>
<br>
-static inline void stl_he_p(void *ptr, uint32_t v)<br>
+static inline void stl_unaligned_p(void *ptr, uint32_t v)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0__builtin_memcpy(ptr, &amp;v, sizeof(v));<br>
=C2=A0}<br>
<br>
-static inline uint64_t ldq_he_p(const void *ptr)<br>
+static inline uint64_t ldq_unaligned_p(const void *ptr)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint64_t r;<br>
=C2=A0 =C2=A0 =C2=A0__builtin_memcpy(&amp;r, ptr, sizeof(r));<br>
=C2=A0 =C2=A0 =C2=A0return r;<br>
=C2=A0}<br>
<br>
-static inline void stq_he_p(void *ptr, uint64_t v)<br>
+static inline void stq_unaligned_p(void *ptr, uint64_t v)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0__builtin_memcpy(ptr, &amp;v, sizeof(v));<br>
=C2=A0}<br>
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c<br>
index 86cdd70c47f..497128c96c5 100644<br>
--- a/accel/tcg/translator.c<br>
+++ b/accel/tcg/translator.c<br>
@@ -342,14 +342,14 @@ static bool translator_ld(CPUArchState *env, DisasCon=
textBase *db,<br>
=C2=A0 =C2=A0 =C2=A0case 2:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (QEMU_IS_ALIGNED(pc, 2)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t t =3D qatomic_read=
((uint16_t *)host);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stw_he_p(dest, t);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stw_unaligned_p(dest, t);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case 4:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (QEMU_IS_ALIGNED(pc, 4)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t t =3D qatomic_read=
((uint32_t *)host);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stl_he_p(dest, t);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stl_unaligned_p(dest, t);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -357,7 +357,7 @@ static bool translator_ld(CPUArchState *env, DisasConte=
xtBase *db,<br>
=C2=A0 =C2=A0 =C2=A0case 8:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (QEMU_IS_ALIGNED(pc, 8)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t t =3D qatomic_read=
__nocheck((uint64_t *)host);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stq_he_p(dest, t);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stq_unaligned_p(dest, t);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c<br>
index 24a3c3e942f..333d78d7455 100644<br>
--- a/hw/display/ati_2d.c<br>
+++ b/hw/display/ati_2d.c<br>
@@ -222,7 +222,7 @@ void ati_2d_blt(ATIVGAState *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (y =3D 0; y &lt; s-&gt;=
regs.dst_height; y++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i =3D dst_x *=
 bypp + (dst_y + y) * dst_pitch;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (x =3D 0;=
 x &lt; s-&gt;regs.dst_width; x++, i +=3D bypp) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stn_=
he_p(&amp;dst_bits[i], bypp, filler);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stn_=
unaligned_p(&amp;dst_bits[i], bypp, filler);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/hw/display/sm501.c b/hw/display/sm501.c<br>
index 51efe2ad41f..776fedebb13 100644<br>
--- a/hw/display/sm501.c<br>
+++ b/hw/display/sm501.c<br>
@@ -768,7 +768,7 @@ static void sm501_2d_operation(SM501State *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (y =3D 0; y &lt; height=
; y++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i =3D (dst_x =
+ (dst_y + y) * dst_pitch) * bypp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (x =3D 0;=
 x &lt; width; x++, i +=3D bypp) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stn_=
he_p(&amp;d[i], bypp, ~ldn_he_p(&amp;d[i], bypp));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stn_=
unaligned_p(&amp;d[i], bypp, ~ldn_unaligned_p(&amp;d[i], bypp));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!rop_mode &amp;&amp; rop =3D=
=3D 0x99) {<br>
@@ -781,8 +781,9 @@ static void sm501_2d_operation(SM501State *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i =3D (dst_x =
+ (dst_y + y) * dst_pitch) * bypp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0j =3D (src_x =
+ (src_y + y) * src_pitch) * bypp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (x =3D 0;=
 x &lt; width; x++, i +=3D bypp, j +=3D bypp) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stn_=
he_p(&amp;d[i], bypp,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~(ldn_he_p(&amp;sp[j], bypp) ^ ldn_he_p(&amp=
;d[i], bypp)));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stn_=
unaligned_p(&amp;d[i], bypp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~(ldn_unaligned_p(&amp=
;sp[j], bypp)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^ ldn_unaligned=
_p(&amp;d[i], bypp)));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!rop_mode &amp;&amp; rop =3D=
=3D 0xee) {<br>
@@ -795,8 +796,9 @@ static void sm501_2d_operation(SM501State *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i =3D (dst_x =
+ (dst_y + y) * dst_pitch) * bypp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0j =3D (src_x =
+ (src_y + y) * src_pitch) * bypp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (x =3D 0;=
 x &lt; width; x++, i +=3D bypp, j +=3D bypp) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stn_=
he_p(&amp;d[i], bypp,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ldn_he_p(&amp;sp[j], bypp) | ldn_he_p(&amp;d=
[i], bypp));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stn_=
unaligned_p(&amp;d[i], bypp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ldn_unaligned_p(&amp;s=
p[j], bypp)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | ldn_unaligned_p(&amp=
;d[i], bypp));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
@@ -818,8 +820,9 @@ static void sm501_2d_operation(SM501State *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (width =3D=3D 1 &amp;&am=
p; height =3D=3D 1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =
si =3D (src_x + src_y * src_pitch) * bypp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =
di =3D (dst_x + dst_y * dst_pitch) * bypp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stn_he_p(&amp;s-&g=
t;local_mem[dst_base + di], bypp,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ldn_he_p(&amp;s-&gt;local_mem[src_base + si], bypp));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stn_unaligned_p(&a=
mp;s-&gt;local_mem[dst_base + di], bypp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ldn_unaligned_p(&amp;s-&gt;local_mem=
[src_base + si],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 bypp));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* If reverse blit do simpl=
e check for overlaps */<br>
@@ -917,7 +920,7 @@ static void sm501_2d_operation(SM501State *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (y =3D 0;=
 y &lt; height; y++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0i =3D (dst_x + (dst_y + y) * dst_pitch) * bypp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0for (x =3D 0; x &lt; width; x++, i +=3D bypp) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 stn_he_p(&amp;d[i], bypp, color);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 stn_unaligned_p(&amp;d[i], bypp, color);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c<br>
index 9c9ac8b0d92..44adff10eb9 100644<br>
--- a/hw/remote/vfio-user-obj.c<br>
+++ b/hw/remote/vfio-user-obj.c<br>
@@ -392,7 +392,7 @@ static int vfu_object_mr_rw(MemoryRegion *mr, uint8_t *=
buf, hwaddr offset,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0access_size =3D memory_access_size(mr, si=
ze, offset);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_write) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D ldn_he_p(ptr, access_siz=
e);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D ldn_unaligned_p(ptr, acc=
ess_size);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result =3D memory_region_di=
spatch_write(mr, offset, val,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_memop(access_size),<br>
@@ -402,7 +402,7 @@ static int vfu_object_mr_rw(MemoryRegion *mr, uint8_t *=
buf, hwaddr offset,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_memop(access_size),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 MEMTXATTRS_UNSPECIFIED);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stn_he_p(ptr, access_size, val);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stn_unaligned_p(ptr, access_size=
, val);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (release_lock) {<br>
diff --git a/hw/vmapple/virtio-blk.c b/hw/vmapple/virtio-blk.c<br>
index f5e8e92df75..805bcbc9467 100644<br>
--- a/hw/vmapple/virtio-blk.c<br>
+++ b/hw/vmapple/virtio-blk.c<br>
@@ -79,7 +79,7 @@ static void vmapple_virtio_blk_get_config(VirtIODevice *v=
dev, uint8_t *config)<br>
=C2=A0 =C2=A0 =C2=A0g_assert(dev-&gt;parent_obj.config_size &gt;=3D endof(s=
truct virtio_blk_config, zoned));<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Apple abuses the field for max_secure_erase_sectors =
as type id */<br>
-=C2=A0 =C2=A0 stl_he_p(&amp;blkcfg-&gt;max_secure_erase_sectors, dev-&gt;a=
pple_type);<br>
+=C2=A0 =C2=A0 stl_unaligned_p(&amp;blkcfg-&gt;max_secure_erase_sectors, de=
v-&gt;apple_type);<br>
=C2=A0}<br>
<br>
=C2=A0static void vmapple_virtio_blk_class_init(ObjectClass *klass, const v=
oid *data)<br>
diff --git a/net/checksum.c b/net/checksum.c<br>
index 18be31c26e5..56314f5e76d 100644<br>
--- a/net/checksum.c<br>
+++ b/net/checksum.c<br>
@@ -110,7 +110,7 @@ void net_checksum_calculate(void *data, int length, int=
 csum_flag)<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Calculate IP checksum */<br>
=C2=A0 =C2=A0 =C2=A0if (csum_flag &amp; CSUM_IP) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 stw_he_p(&amp;ip-&gt;ip_sum, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stw_unaligned_p(&amp;ip-&gt;ip_sum, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0csum =3D net_raw_checksum((uint8_t *)ip, =
IP_HDR_GET_LEN(ip));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stw_be_p(&amp;ip-&gt;ip_sum, csum);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -142,7 +142,7 @@ void net_checksum_calculate(void *data, int length, int=
 csum_flag)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Set csum to 0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 stw_he_p(&amp;tcp-&gt;th_sum, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stw_unaligned_p(&amp;tcp-&gt;th_sum, 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0csum =3D net_checksum_tcpudp(ip_len, ip-&=
gt;ip_p,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (uint8_t *)&amp;ip-&gt=
;ip_src,<br>
@@ -166,7 +166,7 @@ void net_checksum_calculate(void *data, int length, int=
 csum_flag)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Set csum to 0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 stw_he_p(&amp;udp-&gt;uh_sum, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stw_unaligned_p(&amp;udp-&gt;uh_sum, 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0csum =3D net_checksum_tcpudp(ip_len, ip-&=
gt;ip_p,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (uint8_t *)&amp;ip-&gt=
;ip_src,<br>
diff --git a/system/memory.c b/system/memory.c<br>
index 8b84661ae36..653d46e8e79 100644<br>
--- a/system/memory.c<br>
+++ b/system/memory.c<br>
@@ -1365,7 +1365,7 @@ static uint64_t memory_region_ram_device_read(void *o=
paque,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0hwaddr addr, unsigned size)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *mr =3D opaque;<br>
-=C2=A0 =C2=A0 uint64_t data =3D ldn_he_p(mr-&gt;ram_block-&gt;host + addr,=
 size);<br>
+=C2=A0 =C2=A0 uint64_t data =3D ldn_unaligned_p(mr-&gt;ram_block-&gt;host =
+ addr, size);<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_memory_region_ram_device_read(get_cpu_index(), mr=
, addr, data, size);<br>
<br>
@@ -1379,7 +1379,7 @@ static void memory_region_ram_device_write(void *opaq=
ue, hwaddr addr,<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_memory_region_ram_device_write(get_cpu_index(), m=
r, addr, data, size);<br>
<br>
-=C2=A0 =C2=A0 stn_he_p(mr-&gt;ram_block-&gt;host + addr, size, data);<br>
+=C2=A0 =C2=A0 stn_unaligned_p(mr-&gt;ram_block-&gt;host + addr, size, data=
);<br>
=C2=A0}<br>
<br>
=C2=A0static const MemoryRegionOps ram_device_mem_ops =3D {<br>
diff --git a/system/physmem.c b/system/physmem.c<br>
index fb69cdb57d9..d62af6f2480 100644<br>
--- a/system/physmem.c<br>
+++ b/system/physmem.c<br>
@@ -3284,7 +3284,7 @@ static MemTxResult flatview_write_continue_step(MemTx=
Attrs attrs,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Assure Coverity (and ourselves) that w=
e are not going to OVERRUN<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the buffer by following ldn_he_p().<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the buffer by following ldn_unaligned_=
p().<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0#ifdef QEMU_STATIC_ANALYSIS<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert((*l =3D=3D 1 &amp;&amp; len &gt;=
=3D 1) ||<br>
@@ -3292,7 +3292,7 @@ static MemTxResult flatview_write_continue_step(MemTx=
Attrs attrs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (*l =3D=3D 4 &amp;&=
amp; len &gt;=3D 4) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (*l =3D=3D 8 &amp;&=
amp; len &gt;=3D 8));<br>
=C2=A0#endif<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D ldn_he_p(buf, *l);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D ldn_unaligned_p(buf, *l);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result =3D memory_region_dispatch_write(m=
r, mr_addr, val,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0size_memop(*l), attrs);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (release_lock) {<br>
@@ -3379,7 +3379,7 @@ static MemTxResult flatview_read_continue_step(MemTxA=
ttrs attrs, uint8_t *buf,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Assure Coverity (and ourselves) that w=
e are not going to OVERRUN<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the buffer by following stn_he_p().<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the buffer by following stn_unaligned_=
p().<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0#ifdef QEMU_STATIC_ANALYSIS<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert((*l =3D=3D 1 &amp;&amp; len &gt;=
=3D 1) ||<br>
@@ -3387,7 +3387,7 @@ static MemTxResult flatview_read_continue_step(MemTxA=
ttrs attrs, uint8_t *buf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (*l =3D=3D 4 &amp;&=
amp; len &gt;=3D 4) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (*l =3D=3D 8 &amp;&=
amp; len &gt;=3D 8));<br>
=C2=A0#endif<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 stn_he_p(buf, *l, val);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stn_unaligned_p(buf, *l, val);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (release_lock) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bql_unlock();<br>
diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c<br>
index b645aebccef..62d825dc05f 100644<br>
--- a/ui/vnc-enc-tight.c<br>
+++ b/ui/vnc-enc-tight.c<br>
@@ -912,7 +912,7 @@ static void tight_pack24(VncState *vs, uint8_t *buf, si=
ze_t count, size_t *ret)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0while (count--) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pix =3D ldl_he_p(buf8);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pix =3D ldl_unaligned_p(buf8);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*buf++ =3D (char)(pix &gt;&gt; rshift);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*buf++ =3D (char)(pix &gt;&gt; gshift);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*buf++ =3D (char)(pix &gt;&gt; bshift);<b=
r>
diff --git a/util/bufferiszero.c b/util/bufferiszero.c<br>
index 9548dd3ad1b..d7775dc891d 100644<br>
--- a/util/bufferiszero.c<br>
+++ b/util/bufferiszero.c<br>
@@ -38,10 +38,10 @@ static bool buffer_is_zero_int_lt256(const void *buf, s=
ize_t len)<br>
=C2=A0 =C2=A0 =C2=A0 * the beginning and end of the buffer.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (unlikely(len &lt;=3D 8)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (ldl_he_p(buf) | ldl_he_p(buf + len - 4=
)) =3D=3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (ldl_unaligned_p(buf) | ldl_unaligned_p=
(buf + len - 4)) =3D=3D 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 t =3D ldq_he_p(buf) | ldq_he_p(buf + len - 8);<br>
+=C2=A0 =C2=A0 t =3D ldq_unaligned_p(buf) | ldq_unaligned_p(buf + len - 8);=
<br>
=C2=A0 =C2=A0 =C2=A0p =3D QEMU_ALIGN_PTR_DOWN(buf + 8, 8);<br>
=C2=A0 =C2=A0 =C2=A0e =3D QEMU_ALIGN_PTR_DOWN(buf + len - 1, 8);<br>
<br>
@@ -58,7 +58,7 @@ static bool buffer_is_zero_int_ge256(const void *buf, siz=
e_t len)<br>
=C2=A0 =C2=A0 =C2=A0 * Use unaligned memory access functions to handle<br>
=C2=A0 =C2=A0 =C2=A0 * the beginning and end of the buffer.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 uint64_t t =3D ldq_he_p(buf) | ldq_he_p(buf + len - 8);<br>
+=C2=A0 =C2=A0 uint64_t t =3D ldq_unaligned_p(buf) | ldq_unaligned_p(buf + =
len - 8);<br>
=C2=A0 =C2=A0 =C2=A0const uint64_t *p =3D QEMU_ALIGN_PTR_DOWN(buf + 8, 8);<=
br>
=C2=A0 =C2=A0 =C2=A0const uint64_t *e =3D QEMU_ALIGN_PTR_DOWN(buf + len - 1=
, 8);<br>
<br>
diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.in=
c<br>
index c735add2615..eeb18c716c0 100644<br>
--- a/accel/tcg/ldst_atomicity.c.inc<br>
+++ b/accel/tcg/ldst_atomicity.c.inc<br>
@@ -415,7 +415,7 @@ static uint16_t load_atom_2(CPUState *cpu, uintptr_t ra=
,<br>
=C2=A0 =C2=A0 =C2=A0atmax =3D required_atomicity(cpu, pi, memop);<br>
=C2=A0 =C2=A0 =C2=A0switch (atmax) {<br>
=C2=A0 =C2=A0 =C2=A0case MO_8:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return lduw_he_p(pv);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return lduw_unaligned_p(pv);<br>
=C2=A0 =C2=A0 =C2=A0case MO_16:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* The only case remaining is MO_ATOM_WIT=
HIN16. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!HAVE_al8_fast &amp;&amp; (pi &amp; 3=
) =3D=3D 1) {<br>
@@ -512,7 +512,7 @@ static uint64_t load_atom_8(CPUState *cpu, uintptr_t ra=
,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0switch (atmax) {<br>
=C2=A0 =C2=A0 =C2=A0case MO_8:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ldq_he_p(pv);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ldq_unaligned_p(pv);<br>
=C2=A0 =C2=A0 =C2=A0case MO_16:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return load_atom_8_by_2(pv);<br>
=C2=A0 =C2=A0 =C2=A0case MO_32:<br>
@@ -875,7 +875,7 @@ static void store_atom_2(CPUState *cpu, uintptr_t ra,<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0atmax =3D required_atomicity(cpu, pi, memop);<br>
=C2=A0 =C2=A0 =C2=A0if (atmax =3D=3D MO_8) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 stw_he_p(pv, val);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stw_unaligned_p(pv, val);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -928,7 +928,7 @@ static void store_atom_4(CPUState *cpu, uintptr_t ra,<b=
r>
=C2=A0 =C2=A0 =C2=A0atmax =3D required_atomicity(cpu, pi, memop);<br>
=C2=A0 =C2=A0 =C2=A0switch (atmax) {<br>
=C2=A0 =C2=A0 =C2=A0case MO_8:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 stl_he_p(pv, val);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stl_unaligned_p(pv, val);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0case MO_16:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0store_atom_4_by_2(pv, val);<br>
@@ -996,7 +996,7 @@ static void store_atom_8(CPUState *cpu, uintptr_t ra,<b=
r>
=C2=A0 =C2=A0 =C2=A0atmax =3D required_atomicity(cpu, pi, memop);<br>
=C2=A0 =C2=A0 =C2=A0switch (atmax) {<br>
=C2=A0 =C2=A0 =C2=A0case MO_8:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 stq_he_p(pv, val);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stq_unaligned_p(pv, val);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0case MO_16:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0store_atom_8_by_2(pv, val);<br>
-- <br>
2.52.0<br>
<br>
</blockquote></div></div></div>

--00000000000074cb6a0647090159--


