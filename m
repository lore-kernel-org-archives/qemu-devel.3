Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4413DC982DE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8b8V-0002OC-5H; Mon, 21 Sep 2026 06:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8T-0002Mq-Ue
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:33 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8R-0002eY-PP
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:33 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c6b4783778so1520266b6e.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 03:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789986030; x=1790590830;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=25LjOfeKTQcmMeCxITdAZ3CXvVbnOFuL7T38wF7gg2o=;
 b=pLtiA5ka79gvFQ3jLGNu+WSkC/X691i1FVoMokbiq8vcAoMSAn51zt+r7hf2Wv+1c0
 J0noo9zkVEiypmcOJfEJeWu8KCqbRNWFMnEl7Vco3kF4E7ZmGRWSlN0Vin0eaeojHbqG
 09GaV9JKB6nINJkL3HuQBs/26CdyHWeiPEz0i1i1hn4Qn0sivjGvYJ4JewHIA++fDuXe
 JqfDO25R76UAIwnhUQLtCT1IdhUGQDvvSWiqnk6Lc4oUu6SvtfEE0JGcr3V/pnwQWTo3
 4CSDw2wQVWFHbogI+8EDFTizoNmzmyqAwy2vNsfLoYTBv3Msus0V5bKi8BMk2Y2XnRt3
 YKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789986030; x=1790590830;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=25LjOfeKTQcmMeCxITdAZ3CXvVbnOFuL7T38wF7gg2o=;
 b=rsgy6lphNm86zIlvGDvwclNLFjoJCpnIQkbrS67z8+Gz1ZY7q/tJikCUeHsmVwGtSX
 x7CGFEUdBWg0C2osFM16CP0NR34LlCuuJTDAPDKj+4OKHkfQkOPhTAZP9wbZFXn9LF+T
 7wnEvPHs1wYXYKuKoupDTEpK6Wt1lhdVZo0sjSVevwxb69zVQi6G/OWw2VNGN5MR4A5M
 ao7Eg1y5jxV9sL42vDk4tz7q3Rzk0vHMNSA747f5Uyy99m3VKo4VKdkTNNRzsatrEP1I
 828q+hqVBrV/hnNKSErEYc86NrRr+v+PQzinufwiFCbB8Eo7uDkuQl7JHLySlPbxUVwu
 uWmA==
X-Gm-Message-State: AFuF++nfFjSVJ0VZKauhj0dkOv2GqLDuyPEmHt9w7e3ZgpNAiOCe2fm4
 lruBe7Bc2gHVfthiH3Z4IctnC1EmbV3Yu3Q7K/vT7/94BqaDZ0+q/l/PiBckG8sQtb4=
X-Gm-Gg: AYBFou1OHbqDbNWsCa/19eaLYfs/d5gjE6S8pkwnhJywdzdqOK9NMNRyCHmxmS0fKvG
 IdljQv636stAkq2HC/Z1zdk9NQOyQZbokjWZiGyKieEUZo1yUVIR35FVycOiLY0kL+9Wgd8JrCq
 Wf4nnuS1jPC77H9K+XCwR/o1CEWRcAwrrTseLFH+SJi2JzIrrtREMXMr6pVCrQ8YPEfA4lKV8mR
 iOBtGGeTW/AkuBcDXIBlfTxb1bXqhZu+DrbgV4Y1tzGUbCLFCt4qwDYmJFniXrlxNxA7vFXocdv
 L/+9Pj6Fyn6Ex/Bbp8NXd4YwvQ7jr6DADnJwnmJzU3OlgICyI6TNi9VZzE9WHSF8W0MSDXsGfV6
 0iMDjLuUs/bHutd32pxf2HOOPjhlgaYkFhyGVTEsA8e+/E/WPYsKG2R8BFdWvfXhCkLDfcIJODS
 K9oJsA12MZ6cXkVlB/07p0pgckF6cUEADtaSg7usdpXi4k498Xe9VmXQ7fhA==
X-Received: by 2002:a05:6808:3086:b0:4cb:f21c:a79d with SMTP id
 5614622812f47-4ccf946feeemr12977537b6e.37.1789986030482; 
 Mon, 21 Sep 2026 03:20:30 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8107dd8f425sm7613601a34.4.2026.09.21.03.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 03:20:29 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 21 Sep 2026 04:19:43 -0600
Subject: [PATCH v2 01/11] bsd-user: HOST_BIG_ENDIAN and TARGET_BIG_ENDIAN
 are always
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-misc-2025q4-v2-1-5eae157d31d3@bsdimp.com>
References: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
In-Reply-To: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 Rick Richard <rick@sloservers.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7730; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=gBZ+A1c4KGglUwktvyfOghqJluuqvYjPT5k9ueBNReE=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqsQTdpdrv78xLRjECu5JWDURan6kthypcqeAYV
 PmSXzsHy16JAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCarEE3RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBe5A/+N/gia7mkSM5B2JFOxBm39lkozCfJuQJ
 Sw/RbH0ELtr2qOV9p9fKSTKapWW8p0RlaZSfwRD/RQYRu3sD8oc+NxSZzCaZTGqKlHfupGgEicI
 YYkWPCpr/p35S9sTN3kCVttUAajk6BKGcqOMcr7Pf6C73FKleg9FOsvPvcJcI+MJvdUE+FNhH8h
 Wlcd3BUQCAN4yvZHHBAGZK8mvmRf4mDsJ4hAOipYv+dWIIi1l9SdCh1aYtW4mCFBqqrMrSqt+vC
 L46KazgG9o7HKd08MyFZkdpi2Kg1tjAnUasSnl0YjRvvL0SrQdYjlOCmvrAVDvdPreoN/7YjlX1
 nzCWENv1JbuYhuCNTFt/Ayf71WDYe8sqYcQedFF6/e/QdIsQEfvVjx1Fxdvztqz6x/QxqFnI+Jm
 F1KyVXnBIvd058yXaZXSCyiOYzVBgSOyPeHSJtRHDdU4kBbvP8q7cWALlqLj4yzuypO4bLT7jew
 qFSlSAm6Q09JY4zfq7Jq3ROw+YFUGqr9BTd/NeV1h+VEsbccFcbs6ZsBPMxLGOrO4WyLEKxmdoq
 HxwOcEi0SFQLGO2P50S3P9zOHP1WvE3scPQlgqGkYD5VaXMDMcpmYT/U8u3bH0g4N44pf9Bef/1
 fHxHh11cG/TVJgqW6cym8cdO7I4H+cMKtFPXMTI3DAQQAagTIGqc=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:32::11;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x11.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Rick Richard <rick@sloservers.com>

TARGET_BIG_ENDIAN and HOST_BIG_ENDIAN are always defined.

lseek and target_offset64() transpose upper and lower halves
on 32-bit ABIs, -strace prints wrong off_t.

Signed-off-by: Rick Richard <rick@sloservers.com>
[ fixed defined() too and moved to C if() instead of ifdef ]
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-file.h          |  43 +++++++++---------
 bsd-user/freebsd/os-misc.h   | 105 +++++++++++++++++++++----------------------
 bsd-user/freebsd/os-thread.h |   2 +-
 3 files changed, 74 insertions(+), 76 deletions(-)

diff --git a/bsd-user/bsd-file.h b/bsd-user/bsd-file.h
index 0fefc07232..5c32aa0396 100644
--- a/bsd-user/bsd-file.h
+++ b/bsd-user/bsd-file.h
@@ -973,30 +973,31 @@ static abi_long do_bsd_lseek(CPUArchState *env, abi_long arg1, abi_long arg2,
         abi_long arg3, abi_long arg4, abi_long arg5)
 {
     abi_long ret;
-#if TARGET_ABI_BITS == 32
-    int64_t res;
 
-    /* 32-bit arch's use two 32 registers for 64 bit return value */
-    if (regpairs_aligned(env) != 0) {
-        res = lseek(arg1, target_arg64(arg3, arg4), arg5);
-    } else {
-        res = lseek(arg1, target_arg64(arg2, arg3), arg4);
-    }
-    if (res == -1) {
-        ret = get_errno(res);
-        set_second_rval(env, 0xFFFFFFFF);
+    if (TARGET_ABI_BITS == 32) {
+        /* 32-bit arch's use two 32 registers for 64 bit return value */
+        int64_t res;
+
+        if (regpairs_aligned(env) != 0) {
+            res = lseek(arg1, target_arg64(arg3, arg4), arg5);
+        } else {
+            res = lseek(arg1, target_arg64(arg2, arg3), arg4);
+        }
+        if (res == -1) {
+            ret = get_errno(res);
+            set_second_rval(env, 0xFFFFFFFF);
+        } else {
+            if (TARGET_BIG_ENDIAN) {
+                ret = ((res >> 32) & 0xFFFFFFFF);
+                set_second_rval(env, res & 0xFFFFFFFF);
+            } else {
+                ret = res & 0xFFFFFFFF;
+                set_second_rval(env, (res >> 32) & 0xFFFFFFFF);
+            }
+        }
     } else {
-#ifdef TARGET_BIG_ENDIAN
-        ret = ((res >> 32) & 0xFFFFFFFF);
-        set_second_rval(env, res & 0xFFFFFFFF);
-#else
-        ret = res & 0xFFFFFFFF;
-        set_second_rval(env, (res >> 32) & 0xFFFFFFFF);
-#endif
+        ret = get_errno(lseek(arg1, arg2, arg3));
     }
-#else
-    ret = get_errno(lseek(arg1, arg2, arg3));
-#endif
     return ret;
 }
 
diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index 0f87b21cc8..be549c4bd9 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -106,19 +106,19 @@ static inline abi_long do_freebsd_cpuset_setid(CPUArchState *env, abi_long arg1,
     cpuwhich_t which;
 
     target_to_host_cpuset_which(&which, arg1);
-#if TARGET_ABI_BITS == 32
-    /* See if we need to align the register pairs */
-    if (regpairs_aligned(env)) {
-        id = target_arg64(arg3, arg4);
-        setid = arg5;
+    if (TARGET_ABI_BITS == 32) {
+        /* See if we need to align the register pairs */
+        if (regpairs_aligned(env)) {
+            id = target_arg64(arg3, arg4);
+            setid = arg5;
+        } else {
+            id = target_arg64(arg2, arg3);
+            setid = arg4;
+        }
     } else {
-        id = target_arg64(arg2, arg3);
-        setid = arg4;
+        id = arg2;
+        setid = arg3;
     }
-#else
-    id = arg2;
-    setid = arg3;
-#endif
     return get_errno(cpuset_setid(which, id, setid));
 }
 
@@ -135,13 +135,13 @@ static inline abi_long do_freebsd_cpuset_getid(abi_long arg1, abi_ulong arg2,
 
     target_to_host_cpuset_which(&which, arg1);
     target_to_host_cpuset_level(&level, arg2);
-#if TARGET_ABI_BITS == 32
-    id = target_arg64(arg3, arg4);
-    target_setid = arg5;
-#else
-    id = arg3;
-    target_setid = arg4;
-#endif
+    if (TARGET_ABI_BITS == 32) {
+        id = target_arg64(arg3, arg4);
+        target_setid = arg5;
+    } else {
+        id = arg3;
+        target_setid = arg4;
+    }
     ret = get_errno(cpuset_getid(level, which, id, &setid));
     if (is_error(ret)) {
         return ret;
@@ -212,15 +212,15 @@ static inline abi_long do_freebsd_cpuset_getaffinity(cpulevel_t level,
     id_t id;    /* 64-bit */
     abi_ulong setsize, target_mask;
 
-#if TARGET_ABI_BITS == 32
-    id = (id_t)target_arg64(arg3, arg4);
-    setsize = arg5;
-    target_mask = arg6;
-#else
-    id = (id_t)arg3;
-    setsize = arg4;
-    target_mask = arg5;
-#endif
+    if (TARGET_ABI_BITS == 32) {
+        id = (id_t)target_arg64(arg3, arg4);
+        setsize = arg5;
+        target_mask = arg6;
+    } else {
+        id = (id_t)arg3;
+        setsize = arg4;
+        target_mask = arg5;
+    }
 
     ret = get_errno(cpuset_getaffinity(level, which, id, setsize, &mask));
     if (ret == 0) {
@@ -241,15 +241,15 @@ static inline abi_long do_freebsd_cpuset_setaffinity(cpulevel_t level,
     id_t id; /* 64-bit */
     abi_ulong setsize, target_mask;
 
-#if TARGET_ABI_BITS == 32
-    id = (id_t)target_arg64(arg3, arg4);
-    setsize = arg5;
-    target_mask = arg6;
-#else
-    id = (id_t)arg3;
-    setsize = arg4;
-    target_mask = arg5;
-#endif
+    if (TARGET_ABI_BITS == 32) {
+        id = (id_t)target_arg64(arg3, arg4);
+        setsize = arg5;
+        target_mask = arg6;
+    } else {
+        id = (id_t)arg3;
+        setsize = arg4;
+        target_mask = arg5;
+    }
 
     ret = copy_from_user_cpuset_mask(&mask, target_mask);
     if (ret == 0) {
@@ -333,33 +333,30 @@ static inline abi_long do_freebsd_kldsym(abi_long fileid, abi_long cmd,
  * New posix calls
  */
 
-#if TARGET_ABI_BITS == 32
-static inline uint64_t target_offset64(uint32_t word0, uint32_t word1)
-{
-#ifdef TARGET_BIG_ENDIAN
-    return ((uint64_t)word0 << 32) | word1;
-#else
-    return ((uint64_t)word1 << 32) | word0;
-#endif
-}
-#else /* TARGET_ABI_BITS == 32 */
 static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
 {
-    return word0;
+    if (TARGET_ABI_BITS == 32) {
+        if (TARGET_BIG_ENDIAN) {
+            return ((uint64_t)word0 << 32) | word1;
+        } else {
+            return ((uint64_t)word1 << 32) | word0;
+        }
+    } else {
+        return word0;
+    }
 }
-#endif /* TARGET_ABI_BITS != 32 */
 
 /* posix_fallocate(2) */
 static inline abi_long do_freebsd_posix_fallocate(abi_long arg1, abi_long arg2,
     abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6)
 {
 
-#if TARGET_ABI_BITS == 32
-    return get_errno(posix_fallocate(arg1, target_offset64(arg3, arg4),
-        target_offset64(arg5, arg6)));
-#else
-    return get_errno(posix_fallocate(arg1, arg2, arg3));
-#endif
+    if (TARGET_ABI_BITS == 32) {
+        return get_errno(posix_fallocate(arg1, target_offset64(arg3, arg4),
+            target_offset64(arg5, arg6)));
+    } else {
+        return get_errno(posix_fallocate(arg1, arg2, arg3));
+    }
 }
 
 /* posix_openpt(2) */
diff --git a/bsd-user/freebsd/os-thread.h b/bsd-user/freebsd/os-thread.h
index 4258b24095..6552c60337 100644
--- a/bsd-user/freebsd/os-thread.h
+++ b/bsd-user/freebsd/os-thread.h
@@ -18,7 +18,7 @@
 int safe_thr_suspend(struct timespec *timeout);
 int safe__umtx_op(void *, int, unsigned long, void *, void *);
 
-#if defined(HOST_BIG_ENDIAN) == defined(TARGET_BIG_ENDIAN) && \
+#if HOST_BIG_ENDIAN == TARGET_BIG_ENDIAN && \
     (TARGET_ABI_BITS == HOST_LONG_BITS || defined(UMTX_OP__32BIT))
 #define _UMTX_OPTIMIZED
 #if defined(TARGET_ABI32)

-- 
2.55.0


