Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F65C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2U4G-0004eI-Rp; Fri, 04 Sep 2026 09:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2U4F-0004de-2L
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2U4C-0002Sg-LQ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788528890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zpNZ6lGqi2oWOrilbzigP8ELdcE+UQn7z/jXdGjezoc=;
 b=AmF4VZf3Aov9f7f0hryBAfcZEGbiBUf9TvvJ/1nRGFjKPbuk2ajDAOsEPcZNLmUAstIFal
 YVZ8Ouzx5d+P6GKRSwR2FYNt3abr6yJCP6oW96sC7TKT8pkgJfztcca+aavwNdaAHbOfcg
 OHsMAZ1KqTB89dEiPpstkgUGXtv9itE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-kakPz378NK2q1ygvqSJPDw-1; Fri, 04 Sep 2026 09:34:47 -0400
X-MC-Unique: kakPz378NK2q1ygvqSJPDw-1
X-Mimecast-MFC-AGG-ID: kakPz378NK2q1ygvqSJPDw_1788528887
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0e702df8so31527731cf.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788528887; x=1789133687; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zpNZ6lGqi2oWOrilbzigP8ELdcE+UQn7z/jXdGjezoc=;
 b=padELBn2ebNIzlohPz7nhcAZPhMPJPLUTU3sjEWvRb8G9YIzmDOF3UWUaEbLLefSS0
 6c1pEr0eo4glvobGmGT6tiwZZ9f2Bfmal4mbbaC91F2gqMOMMxej3fd4xwxrH12NIjSx
 Pr8GWK9/Ai0/mGPbMgpaL6fjGRH4YbcnVHFQlzuET1cYPEk4KoX29wDRK5sFBUKRdaFo
 w3AHCu0Gp4zdXEVl/8cGo8PeLxOm+7oiccc+mVtiaGwZ9ZsDwyDPCPzrP3eXqYwaL/fd
 KEpZ2uW8rXw62VnndurPhB1tGGyrVMoaZDoO3Kq/h3cnMdubCpSnT63XHctLhkeE6p9q
 fL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788528887; x=1789133687;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zpNZ6lGqi2oWOrilbzigP8ELdcE+UQn7z/jXdGjezoc=;
 b=OwsaMuvcEp3+9VcKSmhwKL4k2p3lx8tP49PWSJmEyKumTkcHs0+7oYj1faQevF49tr
 jkajZcAKsHjWUuj4NU3CI+seXJlbmzKv94WOh/vVU2cqC9/AlI0gK1cVbjaXgWUw4NUX
 h9az6JjQKKpHgIwV0sM2bevTLO+hUqHHFNubG2WXu/pNdWuBoTWt9+1tP+gtmcc4h1El
 WQ0eImc/1RXxHQp/6Vejs7FbZuGziPzHQPs0HPTJcwnSCe/8kE578Y1jaVQbPCXjnWDb
 zEvotQ3fUmQH6xbmkcV3Oxm3SFy5S7Z5kn8CEtzevpNDJzxZ2zwfbRXSszg9etGHwUqA
 KAVw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXMvQOcp9B9RPSaSoNxbVVrzeWPwE9C5ZFdNDdqAkD144PySzbDsg22p8zEc81MIM4Tb8unbXzIzT0@nongnu.org
X-Gm-Message-State: AFuF++lmV+k9mpcrCsEf+u82pAnG1eWSxFG75y7d6x9KqWF9chho1aTs
 9GIxXFycUa7YzhmkqrOFeMdbfkLsTFJJGIFZI6swMXNxsXZLcS5hr1nJv9nkLITrDyEUkXuX6Mw
 FdMHn0dc4mHCXs2zwgGJcsvEnYbl/C9Sf+gBUTakkKax6jS2xiiJ2T5E6
X-Gm-Gg: AYBFou2vgFBIj6qo95lgsdmtCF0bqmCpCmBfcGIZFAPnk4rqtILQJgo5HrYIg5vG4RG
 di74N5HM0aG68uQhA+ri4FFctSGNf8byw3IcyC1vvsm3TGaB9sMRupsRnLeY+4YBkeRGSU17rbT
 c2xAUESkDhd54BPsErA7XsLe3Khm/XYwpD3DWrgYmSJBvn98afHdOzS2lKS1fZ1gLJCS3LeppQl
 LSO4qbDY4K5JyJnVJ+rByMiNYuTkAt4C9fyV1QkqUTUJpN+TuvOMzBIe0JXx6H1A0hMto7Ldo0u
 YG0USmRprlpWmmc+ORaHS723jOs+DoPc6a1QtRbEDMX2Xc6p8zgBy4RBBnrRmPRvvX8MPVR7
X-Received: by 2002:a05:6214:f07:b0:90e:9408:b6b8 with SMTP id
 6a1803df08f44-9103ef9f1ffmr72831756d6.14.1788528886994; 
 Fri, 04 Sep 2026 06:34:46 -0700 (PDT)
X-Received: by 2002:a05:6214:f07:b0:90e:9408:b6b8 with SMTP id
 6a1803df08f44-9103ef9f1ffmr72830856d6.14.1788528886285; 
 Fri, 04 Sep 2026 06:34:46 -0700 (PDT)
Received: from localhost ([2605:8d80:6d61:1b95:5d7e:c15d:7429:70fd])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-910406af144sm20456376d6.40.2026.09.04.06.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:34:45 -0700 (PDT)
Date: Fri, 4 Sep 2026 09:34:43 -0400
From: Peter Xu <peterx@redhat.com>
To: BillXiang <xiangwencheng@lanxincomputing.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, mst@redhat.com,
 pbonzini@redhat.com, philmd@mailo.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: Re: [PATCH v2] virtio: Add aligned ld/st accessors for vring
Message-ID: <aprI8xQIDCRTJOV1@x1.local>
References: <20260821100856.1794011-1-xiangwencheng@lanxincomputing.com>
 <CAFEAcA_kLpaz0UQi3Q315kLVqvDtxKh77kU2meN9G1_evfKBeQ@mail.gmail.com>
 <bad5c8b3-668f-4893-974f-9dbca8dc6893@linaro.org>
 <02da9676-febf-4389-b09b-5e5d41c1084e@lanxincomputing.com>
 <aoxiBB2Wn8NiL5s6@x1.local>
 <5a2a8e0e-2fa6-4905-9752-b2ed0ab3f0ac@lanxincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a2a8e0e-2fa6-4905-9752-b2ed0ab3f0ac@lanxincomputing.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 01, 2026 at 10:44:13AM +0800, BillXiang wrote:
> On 8/24/2026 11:23 PM, Peter Xu wrote:
> > On Mon, Aug 24, 2026 at 12:19:15PM +0800, BillXiang wrote:
> >> Hi Richard, I've read your code in accel/tcg/ldst_atomicity.c.inc. Do
> >> you think it would be better to make the load/store_atomic* public?
> > 
> > They do not fit by default, as we need to still process unaligned cases?
> 
> You mentioned the use of guest CPU context in [1]. However, what I meant 
> by load/store_atomic* is code like the following:
> 
> static inline uint16_t load_atomic2(void *pv)
> {
>      uint16_t *p = __builtin_assume_aligned(pv, 2);
>      return qatomic_read(p);
> }
> 
> static inline void store_atomic2(void *pv, uint16_t val)
> {
>      uint16_t *p = __builtin_assume_aligned(pv, 2);
>      qatomic_set(p, val);
> }
> 
> I consider these to be generic atomic load/store primitives.

__builtin_assume_aligned() tells the compiler the address is aligned.  What
if it is not?

> 
> > 
> > I wished we can use qemu_mem_move() directly that just got introduced.. but
> > it does slightly more than wanted.  Maybe something like this?  Below diff
> > dropped ldsw_he_p() alone the way as it's never used.
> > 
> > Thanks,
> > 
> > ===8<===
> > 
> > diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> > index 387d65c0b0..04a0f63612 100644
> > --- a/include/qemu/bswap.h
> > +++ b/include/qemu/bswap.h
> > @@ -1,6 +1,7 @@
> >   #ifndef BSWAP_H
> >   #define BSWAP_H
> >   
> > +#include "qemu/atomic.h"
> >   #include "qemu/target-info.h"
> >   #include "exec/memop.h"
> >   
> > @@ -238,62 +239,52 @@ static inline void stb_p(void *ptr, uint8_t v)
> >       *(uint8_t *)ptr = v;
> >   }
> >   
> > -/*
> > - * Any compiler worth its salt will turn these memcpy into native unaligned
> > - * operations.  Thus we don't need to play games with packed attributes, or
> > - * inline byte-by-byte stores.
> > - * Some compilation environments (eg some fortify-source implementations)
> > - * may intercept memcpy() in a way that defeats the compiler optimization,
> > - * though, so we use __builtin_memcpy() to give ourselves the best chance
> > - * of good performance.
> > - */
> > -
> > -static inline int lduw_he_p(const void *ptr)
> > -{
> > -    uint16_t r;
> > -    __builtin_memcpy(&r, ptr, sizeof(r));
> > -    return r;
> > -}
> > -
> > -static inline int ldsw_he_p(const void *ptr)
> > -{
> > -    int16_t r;
> > -    __builtin_memcpy(&r, ptr, sizeof(r));
> > -    return r;
> > -}
> > +#define  LD_HE_P(type, size)                                \
> > +    static inline type                                      \
> > +    glue(glue(ld, size), _he_p)(const void *ptr)            \
> > +    {                                                       \
> > +        type v;                                             \
> > +        if (unlikely((uintptr_t)ptr & (sizeof(v) - 1))) {   \
> > +            __builtin_memcpy(&v, ptr, sizeof(v));           \
> > +        } else {                                            \
> > +            v = qatomic_read((type *)ptr);                  \
> > +        }                                                   \
> > +        return v;                                           \
> > +    }
> >   
> > -static inline void stw_he_p(void *ptr, uint16_t v)
> > -{
> > -    __builtin_memcpy(ptr, &v, sizeof(v));
> > -}
> > +#define  ST_HE_P(type, size)                                \
> > +    static inline void                                      \
> > +    glue(glue(st, size), _he_p)(void *ptr, type v)          \
> > +    {                                                       \
> > +        if (unlikely((uintptr_t)ptr & (sizeof(v) - 1))) {   \
> > +            __builtin_memcpy(ptr, &v, sizeof(v));           \
> > +        } else {                                            \
> > +            qatomic_set((type *)ptr, v);                    \
> > +        }                                                   \
> > +    }
> >   
> > -static inline void st24_he_p(void *ptr, uint32_t v)
> > -{
> > -    __builtin_memcpy(ptr, &v, 3);
> > -}
> > +LD_HE_P(uint16_t, 16)
> > +LD_HE_P(uint32_t, 32)
> > +LD_HE_P(uint64_t, 64)
> > +ST_HE_P(uint16_t, 16)
> > +ST_HE_P(uint32_t, 32)
> > +ST_HE_P(uint64_t, 64)
> >   
> > -static inline int ldl_he_p(const void *ptr)
> > -{
> > -    int32_t r;
> > -    __builtin_memcpy(&r, ptr, sizeof(r));
> > -    return r;
> > -}
> > +#undef LD_HE_P
> > +#undef ST_HE_P
> > +#undef ADDR_ALIGNED
> >   
> > -static inline void stl_he_p(void *ptr, uint32_t v)
> > -{
> > -    __builtin_memcpy(ptr, &v, sizeof(v));
> > -}
> > +#define  lduw_he_p  ld16_he_p
> > +#define  ldl_he_p  ld32_he_p
> > +#define  ldq_he_p  ld64_he_p
> >   
> > -static inline uint64_t ldq_he_p(const void *ptr)
> > -{
> > -    uint64_t r;
> > -    __builtin_memcpy(&r, ptr, sizeof(r));
> > -    return r;
> > -}
> > +#define  stw_he_p  st16_he_p
> > +#define  stl_he_p  st32_he_p
> > +#define  stq_he_p  st64_he_p
> >   
> > -static inline void stq_he_p(void *ptr, uint64_t v)
> > +static inline void st24_he_p(void *ptr, uint32_t v)
> >   {
> > -    __builtin_memcpy(ptr, &v, sizeof(v));
> > +    __builtin_memcpy(ptr, &v, 3);
> >   }
> >   
> >   static inline int lduw_le_p(const void *ptr)
> 
> IMO, your change serves as a good optimization for the original 
> load/store by taking advantage of alignment. However, the real issue I'm 
> trying to address is the atomicity of these operations—for use cases 
> like avail_idx in virtio, and this should not limited to virtio alone. I 
> still believe we should provide explicit atomic load/store interfaces 
> for callers, rather than relying solely on aligned load/store. And I 
> admit it was my mistake to use the aligned versions here in the first 
> place. I'll send another version later and look forward to more feedback.

Explicit atomic load/store maybe still make sense somewhere as API, but I
think Peter Maydell also raised that this exact failure may not be the only
one.

IMHO we could directly switch to aligned access automatically when it can,
the only concern is we add one more test instruction in this path, but I
expect it always hit the aligned case.  Also I expect callers of these host
endian APIs to not loop over a range of addr.  So irrelevant of whether
above change would make sense, we want to study more on the impact of the
extra if on the callers.  The hope is it is minimum impact and in case
there're corner cases we can switch to other API even if existed.

Thanks,

> 
> Thanks,
> 
> --
> BillXiang
> 
> [1] https://lore.kernel.org/qemu-devel/apW0SkNxWPCyvVV6@x1.local/
> 

-- 
Peter Xu


