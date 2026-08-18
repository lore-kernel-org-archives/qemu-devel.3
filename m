Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98F2C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNUd-0002SO-Cu; Tue, 18 Aug 2026 13:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNUX-0002PO-Dp
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNUS-0001kr-PH
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787073636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rUu6+862zyMb0hpnxlF3SrtWQqy75TUV86TRgaByDa0=;
 b=jV+jZEXCJhoo3TxqcW7noNnk3pZ7u/oM1vnvlWG06Y6t+9+9oiF7xd4tiYLauvb6R5K1xZ
 rJsXEfSRnprkRkKrHU6rdTpiwzQJfuuFHyAdKv+hm55PolO1ULOrZAwZ1jI6VNJEzJd5J8
 eJZjZCu9OyOB1Jm5MpiJoI/3HNLhirE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-cOwdL0ujMkSi_h2iCRdCdQ-1; Tue, 18 Aug 2026 13:20:33 -0400
X-MC-Unique: cOwdL0ujMkSi_h2iCRdCdQ-1
X-Mimecast-MFC-AGG-ID: cOwdL0ujMkSi_h2iCRdCdQ_1787073632
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90410c668adso2183106d6.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787073632; x=1787678432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rUu6+862zyMb0hpnxlF3SrtWQqy75TUV86TRgaByDa0=;
 b=keqArDugXRT31Z2C97UwdfPrvQwvLxbeGjHAaa4ctZKAUVM4xqKpdekbcExL+bIMdo
 gqtETd0E/K1MVKEbKamvIhzcuO0BA3+8aRQwkG0z9kTLSadKCOy6GAgIatwofhQxpySs
 yLE2f8Okm8AntIvHNn+dlOwCtbczlkrQiouyWkZvSf1kLEsx7EKJmXJSEzkGlQy9zxIG
 24Mb0vCIW5HXSFAJYPUlrfrN75YclNFVRnqhbX3akOCJzIC2wiHNyLX57TqekoHF224m
 dduQLbSeZOjpPNS4AOSld0awDoN4aoZprSBehWKVtxvDdyzufdHHCxh8pe3+cWXoEYdb
 GvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787073632; x=1787678432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rUu6+862zyMb0hpnxlF3SrtWQqy75TUV86TRgaByDa0=;
 b=rO5391ZY3fcPDhGryq19EI7UK5Osa/bAvueeixcxFEuCcUAetToQ7LQ1j9Ki8OyWIe
 QBGOj+g3WdIkGseWTW0yBb87YU/JWNN2eMUFExNJnYXS2/RoDlZ/h2UOPxSP3PZjaImP
 CESJugytEfZ//h2SL9KRbwo00tS4zNZZ7V9f6p3zfGmclwwHraxTiI5nEgR/ebuwM+lY
 zvA5/cTLS3rYOni2yYX36QpMMgTCFk7BjdwfZlbYfunzO12UDtYR3V2CJR9fsIxwuESj
 bfU26XCZd2P8megQyXJ2ankCITifs8e+OkAYDJEx7mqi1FDxYEa2Cm/p5xqDz4lFqFIm
 zF0A==
X-Gm-Message-State: AOJu0Yz5dWHcg8DURWOFJg2LqP9Z02RTLBvHcFUei/jBppvngV5Q8Mpe
 ZkrAdy0I5VOf9bqIPvJ2jcQhwSH4EWd3rCrFFGA2UwaA7INeokVT8m6QEOTahr8qoymiTC3Gc1H
 YwAvSo9uVuGvN8zov+2AJV1xBs5KgQYy/FHd3LlT4KRRTVS9F/2imke/wY8wsi1MUyBCaR4+SM9
 2GxNp2JhN5Vn256sWX4YYPl8Mben9GAg1oPMU3aQ==
X-Gm-Gg: AR+sD10v5E5obPKUkUV/bdYW3pggiMUbnw8OlcOecsH6PcqDmPRJfiRe5Yl/maRtR2L
 VPZvaRSLU2rBkMebMZBfEwQou+NdIOBICNSfFvipu2vzi1f78Dg5MLRygbYwt+NV8XTHvJ1PSn2
 prEKlX8hLiNgIemEgGs+QnAuIDW/m/LSdgLMM4buukHzRaD0iJfMNhvXa7pFzR+qg9LD87anzOj
 R5LBQODJrp8GOgvYW620jedqyRlXlOv2NY5Ys3iCtJga2zTwEFqwsMWXAEf4djDgjAM0p8E1Qgy
 2lwvXACnN+JzTdLFgyzz10XXn+AEMEJOOahSNx0JTYX36jmKShMDYOymeQVvvTq/fX5YfXC7fh+
 iYg75rrqYD1GNn23OS1OARQ6F0YfFz7k2NndrdEE+jsBypaOoF2AGGAV6
X-Received: by 2002:a05:6214:411:b0:8cc:de2:3b5d with SMTP id
 6a1803df08f44-90c4b3ae527mr121476006d6.16.1787073632154; 
 Tue, 18 Aug 2026 10:20:32 -0700 (PDT)
X-Received: by 2002:a05:6214:411:b0:8cc:de2:3b5d with SMTP id
 6a1803df08f44-90c4b3ae527mr121474886d6.16.1787073631433; 
 Tue, 18 Aug 2026 10:20:31 -0700 (PDT)
Received: from x1.com
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c4584418bsm36560896d6.17.2026.08.18.10.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:20:30 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 5/9] bsd-user: Remove 32bit host support in
 thunk_convert|print()
Date: Tue, 18 Aug 2026 13:20:08 -0400
Message-ID: <20260818172012.3052821-6-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818172012.3052821-1-peterx@redhat.com>
References: <20260818172012.3052821-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

QEMU has switched to 64bit-only hosts for all system/user emulations.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 bsd-user/thunk.c | 47 +++--------------------------------------------
 1 file changed, 3 insertions(+), 44 deletions(-)

diff --git a/bsd-user/thunk.c b/bsd-user/thunk.c
index 3c89ae3ab8..6703286609 100644
--- a/bsd-user/thunk.c
+++ b/bsd-user/thunk.c
@@ -134,13 +134,7 @@ const argtype *thunk_convert(void *dst, const void *src,
     case TYPE_ULONGLONG:
         *(uint64_t *)dst = tswap64(*(uint64_t *)src);
         break;
-#if HOST_LONG_BITS == 32 && TARGET_ABI_BITS == 32
-    case TYPE_LONG:
-    case TYPE_ULONG:
-    case TYPE_PTRVOID:
-        *(uint32_t *)dst = tswap32(*(uint32_t *)src);
-        break;
-#elif HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 32
+#if TARGET_ABI_BITS == 32
     case TYPE_LONG:
     case TYPE_ULONG:
     case TYPE_PTRVOID:
@@ -155,27 +149,12 @@ const argtype *thunk_convert(void *dst, const void *src,
             *(uint32_t *)dst = tswap32(*(uint64_t *)src & 0xffffffff);
         }
         break;
-#elif HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
+#elif TARGET_ABI_BITS == 64
     case TYPE_LONG:
     case TYPE_ULONG:
     case TYPE_PTRVOID:
         *(uint64_t *)dst = tswap64(*(uint64_t *)src);
         break;
-#elif HOST_LONG_BITS == 32 && TARGET_ABI_BITS == 64
-    case TYPE_LONG:
-    case TYPE_ULONG:
-    case TYPE_PTRVOID:
-        if (to_host) {
-            *(uint32_t *)dst = tswap64(*(uint64_t *)src);
-        } else {
-            if (type == TYPE_LONG) {
-                /* sign extension */
-                *(uint64_t *)dst = tswap64(*(int32_t *)src);
-            } else {
-                *(uint64_t *)dst = tswap64(*(uint32_t *)src);
-            }
-        }
-        break;
 #else
 #warning unsupported conversion
 #endif
@@ -283,17 +262,7 @@ const argtype *thunk_print(void *arg, const argtype *type_ptr)
     case TYPE_ULONGLONG:
         qemu_log("%" PRIu64, tswap64(*(uint64_t *)arg));
         break;
-#if HOST_LONG_BITS == 32 && TARGET_ABI_BITS == 32
-    case TYPE_PTRVOID:
-        qemu_log("0x%" PRIx32, tswap32(*(uint32_t *)arg));
-        break;
-    case TYPE_LONG:
-        qemu_log("%" PRId32, tswap32(*(uint32_t *)arg));
-        break;
-    case TYPE_ULONG:
-        qemu_log("%" PRIu32, tswap32(*(uint32_t *)arg));
-        break;
-#elif HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 32
+#if TARGET_ABI_BITS == 32
     case TYPE_PTRVOID:
         qemu_log("0x%" PRIx32, tswap32(*(uint64_t *)arg & 0xffffffff));
         break;
@@ -303,16 +272,6 @@ const argtype *thunk_print(void *arg, const argtype *type_ptr)
     case TYPE_ULONG:
         qemu_log("%" PRIu32, tswap32(*(uint64_t *)arg & 0xffffffff));
         break;
-#elif HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
-    case TYPE_PTRVOID:
-        qemu_log("0x%" PRIx64, tswap64(*(uint64_t *)arg));
-        break;
-    case TYPE_LONG:
-        qemu_log("%" PRId64, tswap64(*(uint64_t *)arg));
-        break;
-    case TYPE_ULONG:
-        qemu_log("%" PRIu64, tswap64(*(uint64_t *)arg));
-        break;
 #else
     case TYPE_PTRVOID:
         qemu_log("0x%" PRIx64, tswap64(*(uint64_t *)arg));
-- 
2.54.0


