Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48634C624A4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 02:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1EUU-0006Qq-86; Mon, 31 Aug 2026 22:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1x1EUF-0006LM-BT
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 22:44:38 -0400
Received: from va-2-29.ptr.blmpb.com ([209.127.231.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1x1EU7-0003MR-TJ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 22:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1788230657;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=/dwDJJE9tK5MO97zjKOTyeDl627AaCmlf5Kz+YbbnQc=;
 b=HvPdrNtcikfjxVdiYg9jb9QSe6y+0y3g/p7jnz2h5IjrtB8UP64SMVawUKjEdJoxVnyy44
 BNSidMl37rOevC6JnfP4do7pfTbK2I52f1V3AjuekEHzaFBaG8qChdABstdsOM7ffFWz+N
 xY5e5LmFRjuuKtIIP3KQA4OU5NWXP9h7+3GvFC9gja7IaM9N37BFGuttnVC4FIWjOMmkDV
 cjC959oZ3Rd5UhZpLZJfanex8kx9oHPphhx4tRV34qk+P5Ky5a6+GYDF4NJQEbgf/C5f+g
 yYEUD4mt021f/eR6bYT6YNYYW+Foogwv5ZcgW1w2YtlAhGa9uUr0+oQghUo3pg==
Message-Id: <5a2a8e0e-2fa6-4905-9752-b2ed0ab3f0ac@lanxincomputing.com>
Content-Transfer-Encoding: quoted-printable
References: <20260821100856.1794011-1-xiangwencheng@lanxincomputing.com>
 <CAFEAcA_kLpaz0UQi3Q315kLVqvDtxKh77kU2meN9G1_evfKBeQ@mail.gmail.com>
 <bad5c8b3-668f-4893-974f-9dbca8dc6893@linaro.org>
 <02da9676-febf-4389-b09b-5e5d41c1084e@lanxincomputing.com>
 <aoxiBB2Wn8NiL5s6@x1.local>
Cc: "Richard Henderson" <richard.henderson@linaro.org>, 
 "Peter Maydell" <peter.maydell@linaro.org>, <mst@redhat.com>, 
 <pbonzini@redhat.com>, <philmd@mailo.com>, <qemu-devel@nongnu.org>, 
 <qemu-riscv@nongnu.org>, "BillXiang" <xiangwencheng@lanxincomputing.com>
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
In-Reply-To: <aoxiBB2Wn8NiL5s6@x1.local>
Mime-Version: 1.0
Content-Language: en-US
Subject: Re: [PATCH v2] virtio: Add aligned ld/st accessors for vring
User-Agent: Mozilla Thunderbird
Received: from [127.0.0.1] ([123.120.5.129]) by smtp.feishu.cn with ESMTPS;
 Tue, 01 Sep 2026 10:44:14 +0800
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26a963c00+a1dd44+nongnu.org+xiangwencheng@lanxincomputing.com>
To: "Peter Xu" <peterx@redhat.com>
Date: Tue, 1 Sep 2026 10:44:13 +0800
Received-SPF: pass client-ip=209.127.231.29;
 envelope-from=xiangwencheng@lanxincomputing.com; helo=va-2-29.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, SPF_HELO_NONE=0.001,
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

On 8/24/2026 11:23 PM, Peter Xu wrote:
> On Mon, Aug 24, 2026 at 12:19:15PM +0800, BillXiang wrote:
>> Hi Richard, I've read your code in accel/tcg/ldst_atomicity.c.inc. Do
>> you think it would be better to make the load/store_atomic* public?
>=20
> They do not fit by default, as we need to still process unaligned cases?

You mentioned the use of guest CPU context in [1]. However, what I meant=20
by load/store_atomic* is code like the following:

static inline uint16_t load_atomic2(void *pv)
{
     uint16_t *p =3D __builtin_assume_aligned(pv, 2);
     return qatomic_read(p);
}

static inline void store_atomic2(void *pv, uint16_t val)
{
     uint16_t *p =3D __builtin_assume_aligned(pv, 2);
     qatomic_set(p, val);
}

I consider these to be generic atomic load/store primitives.

>=20
> I wished we can use qemu_mem_move() directly that just got introduced.. b=
ut
> it does slightly more than wanted.  Maybe something like this?  Below dif=
f
> dropped ldsw_he_p() alone the way as it's never used.
>=20
> Thanks,
>=20
> =3D=3D=3D8<=3D=3D=3D
>=20
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 387d65c0b0..04a0f63612 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -1,6 +1,7 @@
>   #ifndef BSWAP_H
>   #define BSWAP_H
>  =20
> +#include "qemu/atomic.h"
>   #include "qemu/target-info.h"
>   #include "exec/memop.h"
>  =20
> @@ -238,62 +239,52 @@ static inline void stb_p(void *ptr, uint8_t v)
>       *(uint8_t *)ptr =3D v;
>   }
>  =20
> -/*
> - * Any compiler worth its salt will turn these memcpy into native unalig=
ned
> - * operations.  Thus we don't need to play games with packed attributes,=
 or
> - * inline byte-by-byte stores.
> - * Some compilation environments (eg some fortify-source implementations=
)
> - * may intercept memcpy() in a way that defeats the compiler optimizatio=
n,
> - * though, so we use __builtin_memcpy() to give ourselves the best chanc=
e
> - * of good performance.
> - */
> -
> -static inline int lduw_he_p(const void *ptr)
> -{
> -    uint16_t r;
> -    __builtin_memcpy(&r, ptr, sizeof(r));
> -    return r;
> -}
> -
> -static inline int ldsw_he_p(const void *ptr)
> -{
> -    int16_t r;
> -    __builtin_memcpy(&r, ptr, sizeof(r));
> -    return r;
> -}
> +#define  LD_HE_P(type, size)                                \
> +    static inline type                                      \
> +    glue(glue(ld, size), _he_p)(const void *ptr)            \
> +    {                                                       \
> +        type v;                                             \
> +        if (unlikely((uintptr_t)ptr & (sizeof(v) - 1))) {   \
> +            __builtin_memcpy(&v, ptr, sizeof(v));           \
> +        } else {                                            \
> +            v =3D qatomic_read((type *)ptr);                  \
> +        }                                                   \
> +        return v;                                           \
> +    }
>  =20
> -static inline void stw_he_p(void *ptr, uint16_t v)
> -{
> -    __builtin_memcpy(ptr, &v, sizeof(v));
> -}
> +#define  ST_HE_P(type, size)                                \
> +    static inline void                                      \
> +    glue(glue(st, size), _he_p)(void *ptr, type v)          \
> +    {                                                       \
> +        if (unlikely((uintptr_t)ptr & (sizeof(v) - 1))) {   \
> +            __builtin_memcpy(ptr, &v, sizeof(v));           \
> +        } else {                                            \
> +            qatomic_set((type *)ptr, v);                    \
> +        }                                                   \
> +    }
>  =20
> -static inline void st24_he_p(void *ptr, uint32_t v)
> -{
> -    __builtin_memcpy(ptr, &v, 3);
> -}
> +LD_HE_P(uint16_t, 16)
> +LD_HE_P(uint32_t, 32)
> +LD_HE_P(uint64_t, 64)
> +ST_HE_P(uint16_t, 16)
> +ST_HE_P(uint32_t, 32)
> +ST_HE_P(uint64_t, 64)
>  =20
> -static inline int ldl_he_p(const void *ptr)
> -{
> -    int32_t r;
> -    __builtin_memcpy(&r, ptr, sizeof(r));
> -    return r;
> -}
> +#undef LD_HE_P
> +#undef ST_HE_P
> +#undef ADDR_ALIGNED
>  =20
> -static inline void stl_he_p(void *ptr, uint32_t v)
> -{
> -    __builtin_memcpy(ptr, &v, sizeof(v));
> -}
> +#define  lduw_he_p  ld16_he_p
> +#define  ldl_he_p  ld32_he_p
> +#define  ldq_he_p  ld64_he_p
>  =20
> -static inline uint64_t ldq_he_p(const void *ptr)
> -{
> -    uint64_t r;
> -    __builtin_memcpy(&r, ptr, sizeof(r));
> -    return r;
> -}
> +#define  stw_he_p  st16_he_p
> +#define  stl_he_p  st32_he_p
> +#define  stq_he_p  st64_he_p
>  =20
> -static inline void stq_he_p(void *ptr, uint64_t v)
> +static inline void st24_he_p(void *ptr, uint32_t v)
>   {
> -    __builtin_memcpy(ptr, &v, sizeof(v));
> +    __builtin_memcpy(ptr, &v, 3);
>   }
>  =20
>   static inline int lduw_le_p(const void *ptr)

IMO, your change serves as a good optimization for the original=20
load/store by taking advantage of alignment. However, the real issue I'm=20
trying to address is the atomicity of these operations=E2=80=94for use case=
s=20
like avail_idx in virtio, and this should not limited to virtio alone. I=20
still believe we should provide explicit atomic load/store interfaces=20
for callers, rather than relying solely on aligned load/store. And I=20
admit it was my mistake to use the aligned versions here in the first=20
place. I'll send another version later and look forward to more feedback.

Thanks,

--
BillXiang

[1] https://lore.kernel.org/qemu-devel/apW0SkNxWPCyvVV6@x1.local/

