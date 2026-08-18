Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA9DC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNUe-0002Sc-Ce; Tue, 18 Aug 2026 13:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNUU-0002Nx-5G
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:20:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNUQ-0001kn-8t
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787073636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oi6N2hpYi6TBcw8yaCUWHmVJhJUKVZayh9Rz5r7yfBY=;
 b=S18qquHT1cpS7iBXDOCW/ImbpdecNgu6Smf3FhA6MFlmMBFJ+MMaV9LXO99EprkRRtBKWj
 eOe29oUg7bgYTkkMRPcnC5+MeHUdr2icoT41rhQcF+Dylyl9NwV3P/xtdpQ33IYEco5kyk
 gJN6kzfBKltuPAUqhx9HKt3EZTlSb64=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-zlAfiYGjMWipxi8ShILvxw-1; Tue, 18 Aug 2026 13:20:34 -0400
X-MC-Unique: zlAfiYGjMWipxi8ShILvxw-1
X-Mimecast-MFC-AGG-ID: zlAfiYGjMWipxi8ShILvxw_1787073634
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90284139cceso13456426d6.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787073634; x=1787678434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oi6N2hpYi6TBcw8yaCUWHmVJhJUKVZayh9Rz5r7yfBY=;
 b=YLY4P4VFJhp75rCfNxZHU7dX5U0b04kNgSmuUbi4ghvQNf/9CT9tR2naGm7kv4XEr8
 OCjyap4hsPRDDcDQAgN8O4ZRCR++X4szYjA3qQuo0gd6LT9lLyOlk+S/g/gx2wOBHwt0
 snojOHfykjwgEQ4Vu9A9sQ6QrKE3RhpZCEMOqhZWpqAfIZWXnS11+wH9IpjvFevP1BH2
 +fjfidWDMhl1KrThXZL4C3HVpETSeD7BdT84WltTx2CPof8Ix8tFSX/4JtUScHpCVBkZ
 UxPEP7FgeGcUGNw7lggsBi9Dl8c43ui4LW7ZApI/Iddt8unyc2NTPBnRCo8zvBywttgA
 8U3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787073634; x=1787678434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oi6N2hpYi6TBcw8yaCUWHmVJhJUKVZayh9Rz5r7yfBY=;
 b=JAFr/GOUpNEzoiV/1Cj4ZXcexyERX8qXgqSn9M0ev7XeGXt5s8KgLe+qZghNEq3WQS
 itidQ4aVCCRaU36+W6naG+TX1HlunN7VyI4cUH5fHpUPYhsnTaXpkzatgijtx/vgEGdI
 qQ/5RG5pelx33WEOpzj5CylygxRBudAfMzbI9zEroDYPP907MEcoLmeX0ilxZgC+EeZG
 kzN6oLsTAXw2ujsjFbe8ekGltW1RUSmM4XXIXQZmG16O+JafbLMm77fjDJtaZ2ZXnrtb
 uBKuhn3HsOkqmt2+EGBVzm1NJc6JdRP9ZckLAoMUmz6TvIOqjkow+Q4ojJA3B9Sg9Hnk
 zjKw==
X-Gm-Message-State: AOJu0YxhIBGMDJcWgMn0evH+jWWc9wLeJvdCUZ0CbKiOHSuEMsM0Vq95
 EDQ3s1iOkvWmdp0rltDIahtSPAOgrsUws2DJWqK51yH4T6fgo3xbRMqtqhjVt8SllyTjZfyvFx/
 ZyH96AXIX1rktLQ87t34BFerFck/RWZlUB/pM/E/oFk5yn821Hod0wVUzg663cv0arnu4Et3xFr
 TUBHrrpw4W1w5DmSEPbw+xp5jj4fTNpcwrjIMQvQ==
X-Gm-Gg: AR+sD106t6b9P+balOiAu9bNNg74z6GqaxQ/YMe2ukT8DfBKL/buquwZMPDAKGXNLCd
 d9mf4w4MMtI30Hlfs3Fs7w8eIXHs+d9WkHAMi38NpJyefcJyRV48+3D9b1a2OFuCSDiipreA44P
 vXAOEe1vijTYrrPa/c92unhNw/8GFU1kmeyZipZowATP+0cO37J+G4uATFV2Fc0FSODPz6axKCg
 Clqt59bIgB9kX76p5y5Ns2p55hLFh7eMSUhXeZuNvqzNmXDWqAMmsK8bMKv/+pUS9gO04NzxXff
 spbD2STa4RoW9/6LDq87hxv7dvc6FUaxs5Q+8UM8bLM4CVDr1D4eArjNiPITA2n7ZelRbW8431I
 VFhTlopccvb9MJfiTSz2odvL/I9iULUK9DAKMZPv76HTE2U4a4usDVxz1
X-Received: by 2002:ad4:5c42:0:b0:90c:225b:163e with SMTP id
 6a1803df08f44-90c4cec7675mr87785126d6.7.1787073633733; 
 Tue, 18 Aug 2026 10:20:33 -0700 (PDT)
X-Received: by 2002:ad4:5c42:0:b0:90c:225b:163e with SMTP id
 6a1803df08f44-90c4cec7675mr87783906d6.7.1787073633146; 
 Tue, 18 Aug 2026 10:20:33 -0700 (PDT)
Received: from x1.com
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c4584418bsm36560896d6.17.2026.08.18.10.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:20:32 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 6/9] linux-user: Remove 32bit host support in
 thunk_convert|print()
Date: Tue, 18 Aug 2026 13:20:09 -0400
Message-ID: <20260818172012.3052821-7-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818172012.3052821-1-peterx@redhat.com>
References: <20260818172012.3052821-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 linux-user/thunk.c | 47 +++-------------------------------------------
 1 file changed, 3 insertions(+), 44 deletions(-)

diff --git a/linux-user/thunk.c b/linux-user/thunk.c
index 3cd19e79c6..892ff3d154 100644
--- a/linux-user/thunk.c
+++ b/linux-user/thunk.c
@@ -145,13 +145,7 @@ const argtype *thunk_convert(void *dst, const void *src,
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
@@ -166,27 +160,12 @@ const argtype *thunk_convert(void *dst, const void *src,
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
@@ -294,17 +273,7 @@ const argtype *thunk_print(void *arg, const argtype *type_ptr)
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
@@ -314,16 +283,6 @@ const argtype *thunk_print(void *arg, const argtype *type_ptr)
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


