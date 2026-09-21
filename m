Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78560C982DE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8b8b-0002RY-Hi; Mon, 21 Sep 2026 06:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8Z-0002QR-75
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:39 -0400
Received: from mail-oi2-x0f.google.com ([2607:f8b0:4864:32::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8X-0002fk-H5
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:38 -0400
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-7f4f0d1779dso2440184a34.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 03:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789986036; x=1790590836;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UaoBfGYtj+XBQk/Pn9BUZGITNmY8c6uE/0zBnA0+eBs=;
 b=kfggN8Vkn4k6uIxpCaQYswl8rzvhiEIYbTk2FP32KCkRvay2wLu8FQrZv2xWGdXT4o
 cNti1dzdP4pQ1MQKreEK9rPXgtMyNZ+gso1MW1UwX5nONOtkhmFrSvY51LRgVZqwR/tt
 bM3MulYu02T251vSrD2ZVh/Kn6+J6hl1KE310T4k6NtjFwYJDiXjOkZMLD5gyr4+2gwA
 YwYCeLfZfx7iWTAcRG053RMr0DicoNtQTZoQWFMQfrxBJWGnYmlN61NbfPjd5nd27o2+
 V/AhTUK9fCGjosMN0ImUNxHoHFKBqpHkP3bXcTcwsENSSkTC7GcEe3eX7janBvw52F2H
 U5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789986036; x=1790590836;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UaoBfGYtj+XBQk/Pn9BUZGITNmY8c6uE/0zBnA0+eBs=;
 b=HsoXEIHJZ6gUeDoW2cYadLGBzXPhjYiq71IspH7060+CrcMGaALTOCXISeOGNdacA8
 AKcatQl7FtTn+HxTNWG3gg8dqeZEY2F4uS0kjDPWIEe906Z+yQKqyJ2u9MXD7zL5s9lb
 0An+W2VA6xygYlc1oYRsbh+yelwZ7uMq8a4xnhxMbr/JceIufu+LYDPk7wZMTweWTaLD
 +OyeQneg0hEl2WPqFq97fEqXqKKCm4L1PMT6JK7ZiMgvMIcbkv1OlSHCabYI0hBHezdC
 rCo+WwDmKmepMr+OxaqIKvN4DGirZaC2yH/Q/dTJLyhIK77bbGWjAik5ZMVjKvQ4VyYu
 9J6w==
X-Gm-Message-State: AFuF++ndSxvcNLVHoSvPNqPRyMgtSHM5KT4zwVrWykx+HPE55SAJf7Lv
 c43s6pxd/1O0QjsCPUFV3K1JX5WKHceznZXGKWGDLBWKKAjLVHdQdtnWE/uEhFYR1DY=
X-Gm-Gg: AYBFou1Uq92vs0hFpumFFxd1naMEs7cl/SI939a33gzOUcF0mZlGLaKFgWP5WmAuJUn
 weYSbegZ82ak6LXem32wKptv/QNchb0Xl7HKZm4/ZK30yooL6zHbgT9e6lCw0FlZPyHuGU9LP6X
 ijCTo7CBYSZC12wMdfO4/U6X5lP6KA4CXbpW5JB9HqKUgc7hM6QfcdR6oS7NKz18KiGXGxK/NEl
 xpg3Qvs9vF8q8AsyHd3kDPPn7r6YkQp5Qn2cVbAPHiXNN0Rjzuv5pAU0wsmBTlekp4u3rXbinXA
 qZ7xqhUtTcU9R7Agf7GMCbKzF+oeOlsXrq+xlugBn5hWbIVXVStBhCDA7aFXQZcsl0JT/nut4DS
 WHagbXc0K8TnK70HBU0e/kv2xqh/Ncp9juF6i2eWHUW28TWJDPIERVH0U9JYhcmnUoIgv+cdBdF
 fl/B+pZatbMGJKviogR2kGlLyfSUY80cjkPH4PEopZRAy7knPB9cozk8NQdw==
X-Received: by 2002:a05:6830:82c3:b0:80c:88c9:7dc5 with SMTP id
 46e09a7af769-80de125a209mr10087654a34.13.1789986036463; 
 Mon, 21 Sep 2026 03:20:36 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8107dd8f425sm7613601a34.4.2026.09.21.03.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 03:20:35 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 21 Sep 2026 04:19:47 -0600
Subject: [PATCH v2 05/11] bsd-user: Fix crazy bug with mmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-misc-2025q4-v2-5-5eae157d31d3@bsdimp.com>
References: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
In-Reply-To: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3326; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=dXewvp/yMZ4bM4b8QZtjmK+kFp0IRtwVPf1hzp00CEM=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqsQTePlEEI0epUo9jGakIv4qWVgAe+raKLW+KN
 vUmukHHQBOJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCarEE3hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQCl4xAAqz1Dsnev04rmnh3RM1TZqflvRbyh5tM
 V4Ocar8A083OnXWRXNsYDmwGm2ABc+vXae76/fy0lHHuDbOItjpDyPZtU+EqgtrQo45feCe9e2S
 EC5uEgwKKDqvaRbM/KkhYLlVsc7nTYiYatKmJK8y4Y2k8+4zI9urW+h1BVm1vc6yQxpUj9jalXW
 V/53OKZy2krLwPWuHDDq4T8b3YMJzy/iSOYFPi0iTLn/C9Rik6obgTiF+VnKRdn0i5e2c5lnDwx
 3Fxh59/L/s0p0V/lf1ZmjIUz1uTouFF6x65xgg4mS/Od9CeZAHmVPSR1SBhFKeGyTJBEp8BK8y8
 /yCGXVNgWP9AvwpaWL4hmmuqHo5KKtyjSU9Io7+2MNrMvvSsrZUZuw5y0RvAaRiKznh8WQGSmzn
 2YcdaMa2rihJFWXqSbEHQKMsIhTwiqZJLQbKCoc/i8bJtoKFWGEV/qqkS84cC9xToWLqoc52N8x
 1JIOZsmiP9t1vQbwitgIpaE7LUvDneKtOGiI/lHZHJhrC6Y7EO80FkaVr1Ksgx9LUr7XFFIC0KZ
 fGT14VK3o84X90pgSn9CmmhSJGCUaHcnYhzdEo/1Nc0oGxcTfonTcAt3fp8m8iY77xQGTf35CIx
 J83xsrD9jlZDcBfqXh6nUSDRWpi/PqfEsAcZVg/wtrEx8RtxxEEk=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:32::f; envelope-from=imp@bsdimp.com;
 helo=mail-oi2-x0f.google.com
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

So, for some crazy reason, we checked that only the SHARED bit was set
out of all these bits. The only ones that were live was MAP_ANON and
MAP_FIXED. We never called mmap with MAP_FIXED and MAP_SHARED. And the
equivalent from linux-user tested that MAP_ANON was off, but MAP_SHARED
was on. So incorporate the more direct approach from linux-user for
testing this condition. Many of these bits haven't been actually used in
FreeBSD since the very early days....

Also fix MAP_TYPE definition. The 0xf I think was copied from the Linux
headers a long time ago, since BSD doesn't define this. In FreeBSD,
there's only two bits of this low nibble that are used for the sharing
type (linux has 2 more types encoded in these low bits). The kernel
rejects bogus flags (0xc part of 0xf mask), so it's better to have just
these two bits here.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/mmap.c         | 17 +++++++++++------
 bsd-user/syscall_defs.h |  9 ++++++++-
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 548b4824df..5068e5c3b7 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -215,11 +215,15 @@ static int mmap_frag(abi_ulong real_start,
 
     prot_new = prot | prot1;
     if (fd != -1) {
-        /* msync() won't work here, so we return an error if write is
-           possible while it is a shared mapping */
-        if ((flags & TARGET_BSD_MAP_FLAGMASK) == MAP_SHARED &&
-            (prot & PROT_WRITE))
+        /*
+         * msync() won't work here, so we return an error if write is
+         * possible while it is a shared mapping
+         */
+        if (!(flags & MAP_ANON)
+            && (flags & MAP_TYPE) == MAP_SHARED
+            && (prot & PROT_WRITE)) {
             return -1;
+        }
 
         /* adjust protection to be able to read */
         if (!(prot1 & PROT_WRITE))
@@ -586,8 +590,9 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
              * msync() won't work here, so we return an error if write is
              * possible while it is a shared mapping
              */
-            if ((flags & TARGET_BSD_MAP_FLAGMASK) == MAP_SHARED &&
-                (prot & PROT_WRITE)) {
+            if (!(flags & MAP_ANON)
+                && (flags & MAP_TYPE) == MAP_SHARED
+                && (prot & PROT_WRITE)) {
                 errno = EINVAL;
                 goto fail;
             }
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 9fa16e0863..c4fd5f5589 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -121,7 +121,14 @@ struct target_msgbuf {
 /*
  *  sys/mman.h
  */
-#define TARGET_BSD_MAP_FLAGMASK         0x3ff7
+/*
+ * FreeBSD doesn't define this, but Linux does. In Linux, it's only MAP_PRIVATE
+ * and MAP_SHARED and a few Linux-specific types (0xf). FreeBSD allows other
+ * types of mapping with MAP_ANON, MAP_GUARD, and MAP_STACK. The mask on Linux
+ * excludes these: They don't have MAP_GUARD, and MAP_STACK and MAP_ANON have
+ * similar flags with different names that aren't in it's 0xf MAP_TYPE.
+ */
+#define MAP_TYPE (MAP_PRIVATE | MAP_SHARED)
 
 /*
  * sys/time.h

-- 
2.55.0


