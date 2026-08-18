Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7000BC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTh1-0002At-P9; Tue, 18 Aug 2026 19:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTh0-0002Ak-QW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:06 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgz-0005GL-7P
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:06 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4b21f09ec76so340229b6e.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097484; x=1787702284;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CId43LBbKcBl5RKNJBzxoP27LJvXdGh0uXLlseMjipI=;
 b=R60h3tiysn8EkyLoVnlJAQWM1/hMjKKoDCHp6UxfiUQlIjD0ULGxJjtL2QJ5hvCYwB
 6KmSh4TYPn7rcj+UBcwUgX2QGQkJxfwwqhHCZOdMHknMPWDwiscG5yfy2z/pgEp4FM68
 7JHBYfdFQhsnlUdO8rjIfv5L3Qhs1P0u0ctx3DSNHZ+pyMN2oBoG8st/1kNhsnHphKuP
 8zOFlo6Tsjo3aElvmadLF4nH4T4zk2PViZL/PzIzqw9jElj8xFKoYZOddj6Hr5y3VOJh
 bBAqhgingWiFe5MP3soXRLEeDmeFWIWTroddvq3czZSu5vg2QE/sePVtXgzXykVlz2Iz
 CgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097484; x=1787702284;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CId43LBbKcBl5RKNJBzxoP27LJvXdGh0uXLlseMjipI=;
 b=Md+68JfR+JBYkk/tItvClFIbrahz7lYFvPxvtsWEoHyUEbujYH1hP4pzg1mFvVoHkt
 PfoRBEKJiPiKHEE6fXvOK9D3bpl+wr3Ay3e52eugWQXkXOJSYXbrwlyVpujRWmqdyDbe
 ZFuxnzW0F9jaAPXQVaYDd9uJF9G6AS3oK8yGpHIwBnk/lCBjuePKjgU8n83LKU8Hh5WF
 JuZRLs/txA/8GfIg3QNRjYtjpUGwYVJC/ldMGu+3NKaSxEF7W5wx8avS1wFnGZCp7yLd
 6f8K1NW01XISFZVY4rKTTme9MKZLQrbqa/2DBZQtmhnsutwVMt7D8XxQqQLjAbtvEdq+
 qDZQ==
X-Gm-Message-State: AOJu0YwOc9LhuwlLxVE2ORY6ryRn/o4JelSdA5lv1hlFe+GwnTSIDbMC
 c5CS6rsYt/Vcfyg4fZcN19hel6RpvxHp1rmuCS4q74JiW0R/OvxyaioUEQ0+vB9dwnw=
X-Gm-Gg: AR+sD133wtu1cZlvlwnvafrIoJygQxruR9IYMS0Hv3W7Ml80qbBlyGbp9XNrOfVq0RW
 xvy8PPb+dKyrveOUtnMdZLymIHutwopdIQhKB8qrheio/WXbYEs4gTwcAxIiJImf6chHk/Ayp/W
 MMf3/ml7BjEWyOZ+bEcLy7/4lH8K0lBI/F/UT9KnpJ2cfQhpbQOGhpQMC+d+tIr7Hj1nSb7wK/a
 hpLP7RmA5aJOIOKHyRKDU0GzQKDqoNSdIcfqu9dKxgVLJfhN6SfdGxxlXQHdSlqBNoGoV2vI4my
 c5cWKgmRlWLt+pjxc9j2Vl08D7D+gGObbmo3DgwqNiym1Lo7B5mnuqWB78ca+JxSdeP/+RRYYm2
 ujTIPtVrMgtosbmcnk/Ra9R2yUnq71RnM5c20+gXU1DWbr7C0UbFR4Xf/bjYjuSwGWEhTKlZov/
 fvi/Ifkcc7GxhIxPgVIlsELEYu/DH/VmspDNmwAK3PIVspmkA=
X-Received: by 2002:a05:6808:4fe5:b0:495:e997:528d with SMTP id
 5614622812f47-4b2bc88425fmr454840b6e.3.1787097484227; 
 Tue, 18 Aug 2026 16:58:04 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:02 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:11 -0600
Subject: [PATCH v4 18/40] bsd-user: Add FreeBSD socket system calls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-18-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2906; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=9/LodQEazNPxU574lND5yAoPfGvZro3GQ14ZKs590XQ=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPE7Mn9Bo7oitIpHOCG/ThcPY6yE2raPnJuW+
 xn6qOgRSsmJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxOxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQCeNw/+Px9aIPHAtfpcCXaTAb9+tpw8dnMHlMI
 VpBvtBylQcYWkYgqKthmgmdKidvcLOY8RB+9+p4MfZcSBhtuVZ6PNI9yAw/4z9E6a0GYeiZqtHD
 s1P47i22AHi8WWh6mTFuUyx4iKTtaOczXlAWQbPnj/gimzpLnfT9QmZAei3/mHg3lQDnw2PMZJz
 YsMoHNi1x9wMAHZ1C+Cwf5P3v1tJDxaRnjReW9BALLY7PstBCFb8jqcV6YbnyVns7tT+zFTN5ML
 mCzXw/qlIQhcgHKUjoxBMXmcMQO/mPzUvkwvqNaRIjITu/J5TdZfy84JcknCXCXrJ/fc6TV9yE0
 1l+kk54VtbS8r4kRn8lB5RcHA6MGMAxtWjHF79CVaddzbCEGHp41sUdP5plVoCsEIAO2AU//T7Q
 yovMS9IX+rsgAtCXnYq/5jS1fFsSvUqSbeE+GAzx9Hru47QbRypYrXndUsjEvLQpCj7S6GI9BUm
 FQ/nXkLuoLElLnjyQwncWj/6HkykOHQCWP8jsDgONYJodh+yDStnIcZ/f/s9/6szdM9DLd9IV68
 OeAgOT5JVxFpsTJQDbisktFFSs4AwLRYwt1AD3614sWf4ei+sMZd+UhUwVky66QDXkBdWEN8Xl3
 saEfVUphR5iRF8ehi2E9nBObaOjiu7Q+INVHH4thWQ0fZEzndBE8=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22d;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22d.google.com
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

Complete os-socket.h with setfib, bindat, connectat, and accept4.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-socket.h | 83 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/bsd-user/freebsd/os-socket.h b/bsd-user/freebsd/os-socket.h
index 126e49b282..b0f2498ff7 100644
--- a/bsd-user/freebsd/os-socket.h
+++ b/bsd-user/freebsd/os-socket.h
@@ -336,5 +336,88 @@ done:
     return ret;
 }
 
+/* setfib(2) */
+static inline abi_long do_freebsd_setfib(abi_long fib)
+{
+
+    return get_errno(setfib(fib));
+}
+
+/* bindat(2) */
+static inline abi_long do_freebsd_bindat(int fd, int sockfd,
+        abi_ulong target_addr, socklen_t addrlen)
+{
+    abi_long ret;
+    void *addr;
+
+    if ((int)addrlen < 0) {
+        return -TARGET_EINVAL;
+    }
+
+    addr = alloca(addrlen + 1);
+    ret = target_to_host_sockaddr(addr, target_addr, addrlen);
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    return get_errno(bindat(fd, sockfd, addr, addrlen));
+}
+
+/* connectat(2) */
+static inline abi_long do_freebsd_connectat(int fd, int sockfd,
+        abi_ulong target_addr, socklen_t addrlen)
+{
+    abi_long ret;
+    void *addr;
+
+    if ((int)addrlen < 0) {
+        return -TARGET_EINVAL;
+    }
+    addr = alloca(addrlen + 1);
+
+    ret = target_to_host_sockaddr(addr, target_addr, addrlen);
+
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    return get_errno(connectat(fd, sockfd, addr, addrlen));
+}
+
+/* accept4(2) */
+static inline abi_long do_freebsd_accept4(int fd, abi_ulong target_addr,
+        abi_ulong target_addrlen_addr, int flags)
+{
+    socklen_t addrlen;
+    void *addr;
+    abi_long ret;
+
+    if (target_addr == 0) {
+        return get_errno(accept(fd, NULL, NULL));
+    }
+    /* return EINVAL if addrlen pointer is invalid */
+    if (get_user_u32(addrlen, target_addrlen_addr)) {
+        return -TARGET_EINVAL;
+    }
+    if ((int)addrlen < 0) {
+        return -TARGET_EINVAL;
+    }
+    if (!access_ok(VERIFY_WRITE, target_addr, addrlen)) {
+        return -TARGET_EINVAL;
+    }
+    addr = alloca(addrlen);
+
+    ret = get_errno(accept4(fd, addr, &addrlen, flags));
+    if (!is_error(ret)) {
+        if (is_error(host_to_target_sockaddr(target_addr, addr, addrlen))) {
+            close(ret);
+            ret = -TARGET_EFAULT;
+        } else if (put_user_u32(addrlen, target_addrlen_addr)) {
+            close(ret);
+            ret = -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
 
 #endif /* BSD_USER_FREEBSD_OS_SOCKET_H */

-- 
2.55.0


