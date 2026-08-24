Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CADC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyWWz-0003ye-3X; Mon, 24 Aug 2026 11:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wyWWt-0003mY-NS
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:24:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wyWWr-0006uH-Mh
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787585044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mq0VL5IOt0OWrfZWdj1Tq3ZXi0CqelrWqpmzxUIR4s0=;
 b=OaGtdFfsXuU3UFB9z5fVySXy/+5AfE/qpTsVEsZK1AisR07ehdr6oBnbKH8bnpFdFYEyp5
 cYoSODhvs49YBaBRmRojGN8C3tk0eWN69F6sSGOtUYpTD+Fniwf+Dg11KeWML4QQpGWDjB
 P8k2+h0E7eINovE7urywVzt1Jg83dkU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-ovQLp8CuMkONUwMrW4M2QQ-1; Mon, 24 Aug 2026 11:23:54 -0400
X-MC-Unique: ovQLp8CuMkONUwMrW4M2QQ-1
X-Mimecast-MFC-AGG-ID: ovQLp8CuMkONUwMrW4M2QQ_1787585034
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52d7b3b6aa2so46292661cf.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787585034; x=1788189834; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mq0VL5IOt0OWrfZWdj1Tq3ZXi0CqelrWqpmzxUIR4s0=;
 b=qy9iWq8KDtQ9VegOoIXajp156gLfCNwRZvIm3XbBEnBtsN3Ofcyco+m/99wRvR4oiH
 kr+Ov6/Wf10Tvm9msxTezPYEpdrm1C59HwHoWJVwyVqHK5Mu0t5LbJoDlX/lloxXx/Jj
 eoN+Ix6VFxs9G0bcUuxLibhn3MGr4BCPw8zBTpUPPawJgiQZSOmMNaPAh8WEEoYg39Qd
 m+fPQeb1M0FDlKAAUHpc9J8dypqNUWLcCW6gMTeDvS340LuHLamBNx+GpEnqy+k4frPI
 +D3JPwfqqtiq/aDbCfinIUBYZGSNiUAVzsrrTYEqr1z+hSoz8tbjRfTar3hZv1XcIZIE
 1Kpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585034; x=1788189834;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mq0VL5IOt0OWrfZWdj1Tq3ZXi0CqelrWqpmzxUIR4s0=;
 b=jCwGS0j5ccT0Opc3Try2PfTIs2nYkUHDCJV1hNALkE4uV7LOCJalibTYNVbh+YqcSX
 Cq2198jFpaD3gMQpg4muW2056fdqGmWpMqGEgLauuZctIpdhGMu7ofpT9LYV2xsyL49D
 4aVECnZIhB7mSE/UBdY8QbCgwvvppmqD8aPyQ65Jjj1wHkmlPygXbqIDvS1m/nt+SjnJ
 7v1PLbJ5rFqiJViKKJSMp/uDVScNuU2UFqHRxwrfSlBur2V1t0d16vSq0aPGnHvkGVlv
 F2FlQNScF4oetqDPXyRf4TU/sB2zX7BrIDUVe2fgVt594mT4JIy+K16kbD2mRffhki90
 /xfw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpnM4yNVtJO0EwC/Hbzyf0KrSUJD7JwfmOKojFgVy4hcDoskVHEdeKNtRqd2c8VTZMtIH2oX3QhZI4/@nongnu.org
X-Gm-Message-State: AFuF++lp/aQSaGwKjGeTweKiikGVhJzV6Cezf6ZO9+UluPmw0UD5ylM1
 il+EjjKNyUa9tyzgb7HWSPUMJngvfnZOtbRuaGGr47V+pZtV0PbqCcT0Isci6QG70tHE9OjoRWy
 awCPhP64kk30bAn9vKOI2brqBhBMLf33ExT/SYo7UDRVAX8lzZj9sYBZ0
X-Gm-Gg: AR+sD13y4czBd9K+YP/L+0DDHr6Z4kEMwAlFbuS7EYpCIE1yrzK+tSlRPKhhti6BPwC
 kgATe3dAOEDfUMoAkEOi9BSJ2z4Y5fk9Le9MnHVULANYc6vW8h4vQmU5Ad80mEXqm9xgcEN+R9n
 8xsOpBpW3ceik4WWo68YQ80ZVcM41BM1M+tUjgm6FyAhJFfmiEESMtI+4r2gcFFZ4+JihO9j9oj
 5EJik8w/XhUm/eMSAw13l8QtHht8hdGK2cBasXQGOLBgvRnGTLC4kTfSkXyeaMmslNWNKshQoQM
 Ka9uze4EP/cJBHfOXWy93KNDgPZOebPD78mkp6Z761nhJ7Rf0tcXZb4j6LW7EPaIWeUq
X-Received: by 2002:a05:622a:a12:b0:52d:f12c:59ba with SMTP id
 d75a77b69052e-52df5a3d5b1mr261870671cf.33.1787585033703; 
 Mon, 24 Aug 2026 08:23:53 -0700 (PDT)
X-Received: by 2002:a05:622a:a12:b0:52d:f12c:59ba with SMTP id
 d75a77b69052e-52df5a3d5b1mr261869541cf.33.1787585032987; 
 Mon, 24 Aug 2026 08:23:52 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e09975f5asm50691141cf.2.2026.08.24.08.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:23:51 -0700 (PDT)
Date: Mon, 24 Aug 2026 11:23:48 -0400
From: Peter Xu <peterx@redhat.com>
To: BillXiang <xiangwencheng@lanxincomputing.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, mst@redhat.com,
 pbonzini@redhat.com, philmd@mailo.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: Re: [PATCH v2] virtio: Add aligned ld/st accessors for vring
Message-ID: <aoxiBB2Wn8NiL5s6@x1.local>
References: <20260821100856.1794011-1-xiangwencheng@lanxincomputing.com>
 <CAFEAcA_kLpaz0UQi3Q315kLVqvDtxKh77kU2meN9G1_evfKBeQ@mail.gmail.com>
 <bad5c8b3-668f-4893-974f-9dbca8dc6893@linaro.org>
 <02da9676-febf-4389-b09b-5e5d41c1084e@lanxincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02da9676-febf-4389-b09b-5e5d41c1084e@lanxincomputing.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Aug 24, 2026 at 12:19:15PM +0800, BillXiang wrote:
> Hi Richard, I've read your code in accel/tcg/ldst_atomicity.c.inc. Do 
> you think it would be better to make the load/store_atomic* public?

They do not fit by default, as we need to still process unaligned cases?

I wished we can use qemu_mem_move() directly that just got introduced.. but
it does slightly more than wanted.  Maybe something like this?  Below diff
dropped ldsw_he_p() alone the way as it's never used.

Thanks,

===8<===

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 387d65c0b0..04a0f63612 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -1,6 +1,7 @@
 #ifndef BSWAP_H
 #define BSWAP_H
 
+#include "qemu/atomic.h"
 #include "qemu/target-info.h"
 #include "exec/memop.h"
 
@@ -238,62 +239,52 @@ static inline void stb_p(void *ptr, uint8_t v)
     *(uint8_t *)ptr = v;
 }
 
-/*
- * Any compiler worth its salt will turn these memcpy into native unaligned
- * operations.  Thus we don't need to play games with packed attributes, or
- * inline byte-by-byte stores.
- * Some compilation environments (eg some fortify-source implementations)
- * may intercept memcpy() in a way that defeats the compiler optimization,
- * though, so we use __builtin_memcpy() to give ourselves the best chance
- * of good performance.
- */
-
-static inline int lduw_he_p(const void *ptr)
-{
-    uint16_t r;
-    __builtin_memcpy(&r, ptr, sizeof(r));
-    return r;
-}
-
-static inline int ldsw_he_p(const void *ptr)
-{
-    int16_t r;
-    __builtin_memcpy(&r, ptr, sizeof(r));
-    return r;
-}
+#define  LD_HE_P(type, size)                                \
+    static inline type                                      \
+    glue(glue(ld, size), _he_p)(const void *ptr)            \
+    {                                                       \
+        type v;                                             \
+        if (unlikely((uintptr_t)ptr & (sizeof(v) - 1))) {   \
+            __builtin_memcpy(&v, ptr, sizeof(v));           \
+        } else {                                            \
+            v = qatomic_read((type *)ptr);                  \
+        }                                                   \
+        return v;                                           \
+    }
 
-static inline void stw_he_p(void *ptr, uint16_t v)
-{
-    __builtin_memcpy(ptr, &v, sizeof(v));
-}
+#define  ST_HE_P(type, size)                                \
+    static inline void                                      \
+    glue(glue(st, size), _he_p)(void *ptr, type v)          \
+    {                                                       \
+        if (unlikely((uintptr_t)ptr & (sizeof(v) - 1))) {   \
+            __builtin_memcpy(ptr, &v, sizeof(v));           \
+        } else {                                            \
+            qatomic_set((type *)ptr, v);                    \
+        }                                                   \
+    }
 
-static inline void st24_he_p(void *ptr, uint32_t v)
-{
-    __builtin_memcpy(ptr, &v, 3);
-}
+LD_HE_P(uint16_t, 16)
+LD_HE_P(uint32_t, 32)
+LD_HE_P(uint64_t, 64)
+ST_HE_P(uint16_t, 16)
+ST_HE_P(uint32_t, 32)
+ST_HE_P(uint64_t, 64)
 
-static inline int ldl_he_p(const void *ptr)
-{
-    int32_t r;
-    __builtin_memcpy(&r, ptr, sizeof(r));
-    return r;
-}
+#undef LD_HE_P
+#undef ST_HE_P
+#undef ADDR_ALIGNED
 
-static inline void stl_he_p(void *ptr, uint32_t v)
-{
-    __builtin_memcpy(ptr, &v, sizeof(v));
-}
+#define  lduw_he_p  ld16_he_p
+#define  ldl_he_p  ld32_he_p
+#define  ldq_he_p  ld64_he_p
 
-static inline uint64_t ldq_he_p(const void *ptr)
-{
-    uint64_t r;
-    __builtin_memcpy(&r, ptr, sizeof(r));
-    return r;
-}
+#define  stw_he_p  st16_he_p
+#define  stl_he_p  st32_he_p
+#define  stq_he_p  st64_he_p
 
-static inline void stq_he_p(void *ptr, uint64_t v)
+static inline void st24_he_p(void *ptr, uint32_t v)
 {
-    __builtin_memcpy(ptr, &v, sizeof(v));
+    __builtin_memcpy(ptr, &v, 3);
 }
 
 static inline int lduw_le_p(const void *ptr)
-- 
2.54.0

-- 
Peter Xu


