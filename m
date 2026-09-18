Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED90C982DD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7WxE-0000X5-LD; Fri, 18 Sep 2026 07:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7Wx7-0000W6-C7
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7Wx5-0001sj-Gd
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789731622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kaFcT6CYHC1FcV/k1jfKLkRPjoNRmIXg++hBLZu8564=;
 b=PjF0001whuOJxiECgz90hqji0blFmpCBWZbmYZ1MwRVRhhrlCjDsHE5zA68sSCykHydYBM
 p/FVxIzMy3U9d799jOJTwfNlqv95/8u/kRHjFqXOjMGA1GU8E1KebbDfu4GMQZyYL+zmDj
 Bp7MDjoq4kXygFQZUXH9vtHisYcyvyk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-ebLQijuNM9OKHryjtOeqMA-1; Fri, 18 Sep 2026 07:40:21 -0400
X-MC-Unique: ebLQijuNM9OKHryjtOeqMA-1
X-Mimecast-MFC-AGG-ID: ebLQijuNM9OKHryjtOeqMA_1789731621
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91064f6e75bso20156786d6.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 04:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789731621; x=1790336421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kaFcT6CYHC1FcV/k1jfKLkRPjoNRmIXg++hBLZu8564=;
 b=jEd8mSrANRv6wG/SrxR1j7bDPy2/wqQkQptEZk+ruBPCA4+mQmSqB1E0Qr0v5XR0nC
 bqYagPTSdgp1IwD07MCF1T8xCYSCcllk9kUmjKqv7E5i4BeELIojYKW8KSY8sBleni6d
 HFXY5CUWsH70mSVrD/XEajgz1xsYc4qa0pEwtHJIDsPtmSli5mi3AdOy6MAIrqR4k658
 +YqHu9kH26gG9RWHu0PEsktOPJLJJVjznQb4CNgkN7XsPgMRVtP25FKKEfYLjbq/4BJu
 6quVS4HXE9bqnj6YaOL7RaKqd0qmdygvwB7D3NMjTO1Ha23pKY+Jqk7JnIq68JXskt3A
 EDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789731621; x=1790336421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kaFcT6CYHC1FcV/k1jfKLkRPjoNRmIXg++hBLZu8564=;
 b=HRXFmAbW9bd3tq3j4QiGMUT7ZpDalkkg5FJFkhHezbQJ/uPBIgwVDy+O8Cj4GgUDbe
 60JImE/u5UMGNrVjEOfoj+tgOieb5HZ6LH+YTpih84xSgbvtZnBlW8AXIkrQm8PYQXiG
 eFevo0hc0Xx/Jlg1451xVQZGx8cu9rsiNBMPXUAudh3oKI5mPBTBrQOAoR5PvU5dTtUK
 ZfVhRjzpvnnbr2aifNYdg9RT9kSwBT9aFox57y1Fx0NtIxzjopYb6MFf69gAF79JBWPM
 a0giD3HoY8j6j4X6lL6DLuzGtVKxyH7if/OkU8DtGOJZ+oc3YOhrq6Hb/cPC7zKYZdfz
 FQ4A==
X-Gm-Message-State: AFuF++kNqTvSoWQd3HsepvASbnIha7aNmaL88LeBHU5XnMrLM+x8ZoFR
 N7KgRB8VYdRtTw19WJ/v88ZXgfGV2388W7SRZpOvAp7foEbTdAkgF7OvwmiIDycDPH9wRaxOZjM
 RiiGL3dQWIPgMJT7lFLsgJPib9896JamoJciAyeQiTTxSwCarla2h2pm5T3RMIaweVMBr6ffdBO
 zFqR7QZ99iwqTsZa46WAN28PpJx9ptZLcIh6LkoZNy
X-Gm-Gg: AYBFou0S4dkJGX0D3Aq8dG4ysn/Ur3to/bMiA9W/ZjZ/LPbc6oL8S5BkgrfrW/bJ1t7
 7lKrsS7BK1nX4hnUBEYR5KbqsBe6svw5UiFFLnNppjk/jvGYygVi0CHWzkUeRO/8m3q7Sj/oUjM
 Fh8BeSf/yBvczKwnRE/QQeY4VyOgM3HU2QUt82Dk99RCWT0y2Py6og6rIvk4M/UyLfoq+BNBzfH
 /T+7mpuC1W2DveztxUrBE9cBypYBf6wI08wqiLTCyBihtKKTbLA5uQbt9UCumwKCn7SrlVBbobN
 xCfW88+FzDrWFH0uc6d/yCin9xo+IqUbNj1l4FsFTueOuDgaw9qg78Xcpm4XHZwpQT25oILJ/ZY
 qxZdXyGUonIUF/z77qDfIUHc3YBSy64LnWPpvD+La+od8+P3MbgRmjdIs2H4=
X-Received: by 2002:a05:6214:334:b0:912:517b:40fb with SMTP id
 6a1803df08f44-91254c26a2emr26036516d6.45.1789731620996; 
 Fri, 18 Sep 2026 04:40:20 -0700 (PDT)
X-Received: by 2002:a05:6214:334:b0:912:517b:40fb with SMTP id
 6a1803df08f44-91254c26a2emr26036126d6.45.1789731620448; 
 Fri, 18 Sep 2026 04:40:20 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9125802adb7sm10539456d6.18.2026.09.18.04.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 04:40:19 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 06/11] linux-user: Remove 32bit host support in
 thunk_convert|print()
Date: Fri, 18 Sep 2026 07:39:21 -0400
Message-ID: <20260918113926.831204-7-peterx@redhat.com>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20260818172012.3052821-7-peterx@redhat.com
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Helge Deller <deller@gmx.de>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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
2.55.0


