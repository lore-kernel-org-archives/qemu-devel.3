Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B455C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Wx1-0000Vc-Jv; Fri, 18 Sep 2026 07:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7Wx0-0000VB-5n
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:40:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7Wwy-0001rz-Fa
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789731615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f0YAk1LgwLEMJZh6lGah9roTe2m/EXT2KmvH9Za1r6I=;
 b=fQ7JxnDjwjnY0jz6ozEMt7OV4VCyQLkMD9h0k89PkA8sEXEJok+RD4l2R2QvhYT3b5+NSS
 ZG4tx8AeCYfnkUfTffEirLuY7ZPrHTikDuk2WSlPcC+wbd5qj8gafK+/n0nCHrmHmQ1eKR
 1r9tt7dbOrXNj/Gl0aRTRFcF2eaXsl4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-keWH_FP5Nh6Tji5FeLem4g-1; Fri, 18 Sep 2026 07:40:14 -0400
X-MC-Unique: keWH_FP5Nh6Tji5FeLem4g-1
X-Mimecast-MFC-AGG-ID: keWH_FP5Nh6Tji5FeLem4g_1789731613
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a00c70d28so95435285a.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 04:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789731613; x=1790336413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f0YAk1LgwLEMJZh6lGah9roTe2m/EXT2KmvH9Za1r6I=;
 b=nBECGrW4eO0+7RwgtFYz1VH9t1LbiWN0Im5atW2u5Ht8XIJwFbGgLkw4fBgA6Ze0LO
 1GNXnChAOIQcMaN0u87HoWGYMlhDT4Z4B3UVWpB+GSS3SOMtqxVp7+cF483CZnkc/sjf
 bQVACn8cxn/4FtgfvKsjdoeF6EWBCFcjCU+k+RWdLvCxONC1DfAzUzzWWEVyZMHuiIvA
 hvBHuzm9DvCKrSapIeE4GsRyqlTrnAgUQneZdE65gIk6o+Td7hOZQL6Si9wYpPR3geyw
 aeu0ZcggqAb0PGIBfsg+FGpIsiEDBhTRnQSQ2xmQzU52XBTbDWboscNX69bH6jxQ+OJG
 sCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789731613; x=1790336413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f0YAk1LgwLEMJZh6lGah9roTe2m/EXT2KmvH9Za1r6I=;
 b=Z6l75YTq8luGvAN8tUJATmK4uxD/OlWG4ZiBS5Hxqm4v5FBd6qPrHBNPg50VVwQF9l
 sR8KOztAfYYDK8Zm8o+iwsGxoTbssoixOc9s9tEUVR6JKGQcIzSEEvChCZ1B5UEpnee5
 t0wAnLvuFh+GwJINQpPo+99fNbemEJ+nJ+TsWxJGtpNz+kJrzSngb8yM+fShBC46OIho
 JHZ4Erzr7wKk3k8m9l9kAwA61OcYgLJNfoTj+JbnAGYwgQFi1ihGtmqkQi+mgZ7EPdmj
 dvXGMB2kPVOURk/FP8MeWAqrZIecWXLjNolz2dvUoR4WXg4JA7TQIyDU16miuXNhmfWU
 kNcw==
X-Gm-Message-State: AFuF++nQgDJWV+4TIa72CO2LgIq4WfHZvxSIJJlVsMS3X4g69tybH2e6
 XYRQ/S/QARKkJNIvrf2vzT/pJ/mtsTsiWMzdKLJx6rEhPYVTyeS1qnMDYIYiniRqyBeNwUFF4BX
 YEpLCll3bfG9aevKIEmZahp7WKP3sU/6m4foh7Wx5rEv9uJTnclkPF84gxj3Q2W2z6HlvorSag/
 jKIeeYLVb6zjjhnxssSPoJpH/aM57Z3Rq56MsdC/MZ
X-Gm-Gg: AYBFou0sICyexPfaaGj1IdV6m4rb0hh0scKcGUDRYrytrGReDc37ZIQr09VIO9x0gQw
 ZHilad3fxwhs3KrSvj5B80fj96bk3EbpZANVMKAxTk7Lf2msoN9lzSfH7XV11XEVlgoTQGXN8qP
 Ra/mYwV3QaSfUcQS1DYS02UktCCvoi7g0bVxqW9+WJtxb4vrso1TpPnxEUxzNI7pIVLcZdGu+wj
 n6YcasXcKDt9bHm5Il1KPgOAQsCyRCjtDkireS0sXm3Gjv+3HV2SRAC2mXRUcI8FR8bajyV0liU
 yYce2NIUL3hv97Ta4LhHitkuKOYV2Qj8hbKJ4t1LbdYK+HtOrJW5pCjTFh58MATF+nkTUbYSQ6Z
 3QBgZFSQPxJxeEzRYfJrxdLCSf1Lmh2/Bc6f5kQUSIF7LCVIj9DUTWOI9KzU=
X-Received: by 2002:a05:620a:6493:b0:93b:d7a2:83d5 with SMTP id
 af79cd13be357-93bdca24c27mr251790185a.68.1789731613479; 
 Fri, 18 Sep 2026 04:40:13 -0700 (PDT)
X-Received: by 2002:a05:620a:6493:b0:93b:d7a2:83d5 with SMTP id
 af79cd13be357-93bdca24c27mr251785285a.68.1789731612873; 
 Fri, 18 Sep 2026 04:40:12 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93be0a9eb64sm121185985a.0.2026.09.18.04.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 04:40:12 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>
Subject: [PULL 05/11] bsd-user: Remove 32bit host support in
 thunk_convert|print()
Date: Fri, 18 Sep 2026 07:39:20 -0400
Message-ID: <20260918113926.831204-6-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918113926.831204-1-peterx@redhat.com>
References: <20260918113926.831204-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20260818172012.3052821-6-peterx@redhat.com
Cc: Warner Losh <imp@bsdimp.com>
Cc: Kyle Evans <kevans@freebsd.org>
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
2.55.0


