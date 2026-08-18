Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38EBC5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwThZ-0004WX-Mg; Tue, 18 Aug 2026 19:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThX-00048O-5p
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:39 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThV-0005JZ-BR
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:38 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4a483a552efso275458b6e.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097516; x=1787702316;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YEmaFToETsycZ7der5ViiFcTP4pGFJAFcTkNWhCg5/A=;
 b=VQD+uZpmSqHMX5F4ADFDp/oSTKfD31mr+QD8nQAYCh6BQWYxKGsKHmS2bwN4Ebfv5K
 lQgkw3bjSnU1Xv5pfyKVOfyUStWL7uJ6Bcn2HFqcjox3iRRuwjRKVDG6DXcKLE6I3tpQ
 cBvdHK+V2Zvpohx0G9pezqDFeL6LxK1wSXFSYdQDNYEmCAx1NlHAci/Hrc8XMxYZpN5T
 2BE87yt7cmRrssIf975avRlNpeKSKR8kIvMVkukeb0MD1XikXj0VP8xwZ2lHZOqoGfIt
 F8V4uZPbZ+7W2nvgCEI2q+V26Dcer6A2pTklbspZPWU8+jv31nqWux7pz1A4krJZf+WF
 V80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097516; x=1787702316;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YEmaFToETsycZ7der5ViiFcTP4pGFJAFcTkNWhCg5/A=;
 b=JUUlaKvFQnsKtZhiY8U2va3w2fSJpYSacRLl0OwU/BMMKdw+dO6ujyBykQvi6k/5PB
 i0b3sGzCf8IutjIZnMpI8a+qAXMKBxXTZAjiWDPFsUOZf4GrM6TgHJdKzK91yDPSY2d2
 GxHdfS4CrdZ4uSaBZIglEcrALqjb1j1uOSZ8pILN9qOu1F4bCLB7XLdYdDrbozLotp8R
 klcsKxtnIJsbkJbIzmaOtf8TdFPOYIFrEQIuKZHsH/Q7ck8DxDxyturPMmFE3WJeM9Dy
 TVcKNy/V7XGAGcqzAB54qdhJDl08GYPhR1oyyCfX9TCrA1rNSR+HcZSY1DN9eWaTVnZ2
 lm7w==
X-Gm-Message-State: AOJu0YzB8uKgyh4i3WRCtXnvONaLdSK7rtWPFux9KlsqVTvakQRr+pxl
 z1f5LrcmXG3ArEoXyOpT3Z9bSUe84e+AHX13m4kYBZLfQrO+BiY5v+Hln6peXiqTjTq1ewICDi5
 vdKCvOgQ=
X-Gm-Gg: AR+sD12P1PTYTNQyAKVIhYNWSRD3x65cdRum0zZdMY27xJ0c+T50qs5ngwnzXn11UJV
 Y2+DCBPJyKhDGGudJyKipvfs5/0Zg9v8uq4CXsrLwCG3I9DN1RTozRwLksRrky7VcFxiv9bZyUJ
 1iEFlYuwA1aEOTJnTMO7Me66ADdK0+7s7tlXpz+gOLhSPhIDZw2xPC3mXamdj40E50VzpbD9abP
 XKrKtcjcWQ/QNR0WUwGoflFBhsmi7P5+KcKQBLct5S1dZOIxTOH/xxw6QKmCDY2f75aKR8z3j54
 uwlerlO9i21aGpTZhUMaqn7b/oakyv8AsE6ucOI8hlIHJvx0aAWCPrdumXLA4plJ21LcArshkVu
 s9Z80OUKFs6g2ZyL4OoEl77d8lzw+hbUVG1uNgjSv6fZBeuYqSGnLB3FqZdogCwgLm+bGSB77Rl
 Q48+5lM/6pql6vVJwfI7PpGAzerW/BDgQomFwPbbt4KS6qzWQ=
X-Received: by 2002:a05:6808:6902:b0:4a4:856a:c622 with SMTP id
 5614622812f47-4b2bcc3ddaamr287134b6e.20.1787097516192; 
 Tue, 18 Aug 2026 16:58:36 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:35 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:26 -0600
Subject: [PATCH v4 33/40] bsd-user: Add link and list extattr functions to
 os-extattr.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-33-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5800; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=C2yjO1Srf50sIJtco5cn2xQKOYDP4oFckYjhyhcblEc=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPFTHaK4B+GlE1KnUk6h4bibHuTMqeyYQbX0i
 mrkuDOm4IyJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxUxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQAM6BAA7PwYATwOW2YS06K0CEl0JSLxcfWHp7u
 7qZC9q6dpdeLEXbkJU1Jlf85q3/Q+9eiarDVqgH7EqBsYheHtHS+U+W1dS3GUF+q4gJSXZeLQhU
 tFRA/Q/ZIi3//VmvAb92+O14N8tv6E8x2r1hR/v0ckw3f3xLNvC491r/viK2VRp0bGT/rt7c9he
 93fCjLG5DYi2uiZ++jmTPt0l8cPxTNZ4NTSYux/Da1gEoT5riCidluZxridjlkppsfHV+UZu/v+
 eCRKrtFH972CgOnGzCzRYZ2pGHCVSWOlUT59nY+P8n5TghK1Pgn7zLI8h4hHL5sdtzl6zsASktG
 EyYhIsT046UTah1YeLdrglRJQer/FYBJQRpQQeu2OpZPqsCcAsUj6xleoxl0poIetChnfD7yoz9
 7+pYc8beatKo/AbRYRWO0yWQ7Rssw2UJ3Kx+XNE6DCTtaGuoZhUCb4GdA7OU1dVgD2XuEjI/7bZ
 5KXPOSjuSKLEE/QPJ9Jw0dvUa0vpb3b8ch5mx4rOHf7gd3mcQqlFuHZK4sL9QhoeTo6oexjESTq
 9EdUkyvPjfeW/gFE4P+Mk7agi1K80Hnne0ZdQ/H1NV8FbzwxLNeyRq6ZEcHS79hm+HpteRR7ZEc
 Ns0OFZFV3D+dQihTZfD+0xjyuZxD3FicRbG5GMRwNhoqKCLYrL4A=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::234;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add extattr_get_link, extattr_set_link, extattr_delete_link,
extattr_list_fd, extattr_list_file, and extattr_list_link.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-extattr.h | 172 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/bsd-user/freebsd/os-extattr.h b/bsd-user/freebsd/os-extattr.h
index fb3ef27346..90f0c64c93 100644
--- a/bsd-user/freebsd/os-extattr.h
+++ b/bsd-user/freebsd/os-extattr.h
@@ -204,5 +204,177 @@ static inline abi_long do_freebsd_extattr_delete_fd(abi_long arg1,
     return ret;
 }
 
+/* extattr_get_link(2) */
+static inline abi_long do_freebsd_extattr_get_link(abi_long arg1,
+                                                   abi_long arg2,
+                                                   abi_long arg3,
+                                                   abi_long arg4,
+                                                   abi_long arg5)
+{
+    abi_long ret;
+    void *p, *a, *d;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    if (arg4 && arg5 > 0) {
+        d = lock_user(VERIFY_WRITE, arg4, arg5, 0);
+        if (d == NULL) {
+            unlock_user(a, arg3, 0);
+            unlock_user(p, arg1, 0);
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(extattr_get_link(path(p), arg2, a, d, arg5));
+        unlock_user(d, arg4, arg5);
+    } else {
+        ret = get_errno(extattr_get_link(path(p), arg2, a, NULL, arg5));
+    }
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_set_link(2) */
+static inline abi_long do_freebsd_extattr_set_link(abi_long arg1,
+                                                   abi_long arg2,
+                                                   abi_long arg3,
+                                                   abi_long arg4,
+                                                   abi_long arg5)
+{
+    abi_long ret;
+    void *p, *a, *d;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    d = lock_user(VERIFY_READ, arg4, arg5, 1);
+    if (d == NULL) {
+        unlock_user(a, arg3, 0);
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(extattr_set_link(path(p), arg2, a, d, arg5));
+    unlock_user(d, arg4, arg5);
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_delete_link(2) */
+static inline abi_long do_freebsd_extattr_delete_link(abi_long arg1,
+                                                      abi_long arg2,
+                                                      abi_long arg3)
+{
+    abi_long ret;
+    void *p, *a;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(extattr_delete_link(path(p), arg2, a));
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_list_fd(2) */
+static inline abi_long do_freebsd_extattr_list_fd(
+    abi_long arg1, abi_long arg2, abi_long arg3, abi_long arg4)
+{
+    abi_long ret;
+    void *d;
+
+    if (arg3 && arg4 > 0) {
+        d = lock_user(VERIFY_WRITE, arg3, arg4, 0);
+        if (d == NULL) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(extattr_list_fd(arg1, arg2, d, arg4));
+        unlock_user(d, arg3, arg4);
+    } else {
+        ret = get_errno(extattr_list_fd(arg1, arg2, NULL, arg4));
+    }
+    return ret;
+}
+
+/* extattr_list_file(2) */
+static inline abi_long do_freebsd_extattr_list_file(
+    abi_long arg1, abi_long arg2, abi_long arg3, abi_long arg4)
+{
+    abi_long ret;
+    void *p, *d;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    if (arg3 && arg4 > 0) {
+        d = lock_user(VERIFY_WRITE, arg3, arg4, 0);
+        if (d == NULL) {
+            unlock_user(p, arg1, 0);
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(extattr_list_file(path(p), arg2, d, arg4));
+        unlock_user(d, arg3, arg4);
+    } else {
+        ret = get_errno(extattr_list_file(path(p), arg2, NULL, arg4));
+    }
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_list_link(2) */
+static inline abi_long do_freebsd_extattr_list_link(
+    abi_long arg1, abi_long arg2, abi_long arg3, abi_long arg4)
+{
+    abi_long ret;
+    void *p, *d;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    if (arg3 && arg4 > 0) {
+        d = lock_user(VERIFY_WRITE, arg3, arg4, 0);
+        if (d == NULL) {
+            unlock_user(p, arg1, 0);
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(extattr_list_link(path(p), arg2, d, arg4));
+        unlock_user(d, arg3, arg4);
+    } else {
+        ret = get_errno(extattr_list_link(path(p), arg2, NULL, arg4));
+    }
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/*
+ *  Access Control Lists
+ */
+
 
 #endif /* FREEBSD_OS_EXTATTR_H */

-- 
2.55.0


