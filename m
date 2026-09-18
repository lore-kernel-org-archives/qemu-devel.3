Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF46C88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QAH-0005XH-0g; Fri, 18 Sep 2026 00:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAC-0005Py-1G
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:28 -0400
Received: from mail-oi2-x12.google.com ([2607:f8b0:4864:32::12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAA-0004GH-G8
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:27 -0400
Received: by mail-oi2-x12.google.com with SMTP id
 46e09a7af769-7f4f0c89e35so187930a34.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705525; x=1790310325;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1UnoJZ2salmo3FsO31OG+t/xnG8LyqG6BerW+1cdcvI=;
 b=UyyINc4d57mWYlGdS2ILXfLf9T9i/sxY+wS6e3x7DZyponwHbKr3Yt+X/yqEFhY8ao
 EP7ac9nHNTq8Zw1ecQJwRGVyHB+yXK433+z1ye0o+pTDxo7dR+OzgrE3PAyYSrnFSczO
 jCsiEIkLUwDj52hn5cMfB5VPjsCzUbVnux3bdkQ9F2qh+7ZDPY/ngY7/GbX+O0bCDpI2
 dah3k5ft+k9BApcLrNS6Y33ht3Eki1xe/lS/4phfxumOQPfEh6upKSAWduHiO4PKsoCa
 Ss96NYmpK0JJ2tPEXvDIDn/Zq8cuKsW9y0QE/xW8lNOmI+L7vbDzeucMtc70tG/54TQk
 TTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705525; x=1790310325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1UnoJZ2salmo3FsO31OG+t/xnG8LyqG6BerW+1cdcvI=;
 b=bzatFGDCc3ZpwHm0iVyZSVhJGsSwQJdAXlAoTMC6JysL3IN3nbOn6GkjlcuvYhLXP+
 jm5r4IhRBK5t4V5grzDhT5xyOvOOLy1cC4XJCV5n6sdGtrE1ayK1pcC2oNDcxfABAE0J
 /t9Ae4UFQwPW9wlaRCWHD4oqMQAr3KB2aaW1V2E5lEJYFmhR0QpHRqJ8dDY0vIO0Ip2R
 X/i+w9A2kgykiMrYxc1HN6hSQKNwY+JvrBDEmYw/gUgQlm9Nc+prDEfMPzZv9hdlQuuG
 gghL0drDrC3XaGRnrNNY6d5WNxeIhPrZ6Y2m9lJH6J+y2sioL7HFuQTx+8nlGJAsWq4u
 ohdw==
X-Gm-Message-State: AFuF++mF1p3HVKlnbAbTnZ0nqMDay/9SFmEM+OlwUZhc1mL0DAnt8Hl1
 MUzXouaRZYZB5BciecW8TFaL9PyD/REbezd56vDfA5yhTiHd5UskfyEV+umXb6+1m601w4YOfPL
 5cuRHZLs=
X-Gm-Gg: AYBFou2QOssb1K2Nep7caPbHhQsx6gljfqE/teNTT+DE0otqTmrXJ4lCo/XJ9HAinFK
 O/h+EX/7f2ZOM+ci5YRaA6QIwk6Yim2PlQQdY24pwxX1oQUhsveE6ltXkbjxFlOWoACsaDMx9jt
 bKwFIJqHZ8DG0XWVGpJcvnQqxzHmgrs7Ghc4pp6g1YB1NVObtvmtEhjaRAUJUmJOMd8HPiWYrfS
 MuItZWxKOE770EcMzI+gepoWVMMSZ3GWFbnoqGe2u+sqSu6tthJFviw/J+PcxFtToO10WTCqGX8
 kOEwhsIXxnH+ZkfdudKVFXUbANeCp1AIwFZnFqCyaFu2N6VZGn/+HpmGAcGtIT55b05qx5JNZlj
 0GvmI4QrIrFrA3mz6Cp+/BMkuOazljJPvz9GERGJ6lxF2cy+pidJmLDZM2OSYtCv8xMgLQsWxeL
 kJI6aF+xgKG+Nq1HFsowBiYsyQtWvIctWzvP7vkfetz0xAUc2jEujuMCL1Pg==
X-Received: by 2002:a05:6830:2903:b0:802:4cf7:ea46 with SMTP id
 46e09a7af769-80de31ee87cmr1453559a34.20.1789705525427; 
 Thu, 17 Sep 2026 21:25:25 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:24 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/41] bsd-user: Add socket shims socketpair through shutdown
Date: Thu, 17 Sep 2026 22:23:57 -0600
Message-ID: <20260918042422.38713-17-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::12;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x12.google.com
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

Complete bsd-socket.h with socketpair, sendto, recvfrom, socket,
and shutdown system call shims.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-socket.h | 116 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/bsd-user/bsd-socket.h b/bsd-user/bsd-socket.h
index c786d6717a..43aacce5dc 100644
--- a/bsd-user/bsd-socket.h
+++ b/bsd-user/bsd-socket.h
@@ -164,4 +164,120 @@ static inline abi_long do_bsd_getsockname(int fd, abi_ulong target_addr,
     return ret;
 }
 
+/* socketpair(2) */
+static inline abi_long do_bsd_socketpair(int domain, int type, int protocol,
+                                         abi_ulong target_tab_addr)
+{
+    int tab[2];
+    abi_long ret;
+
+    if (!access_ok(VERIFY_WRITE, target_tab_addr, sizeof(tab[0]) * 2)) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(socketpair(domain, type, protocol, tab));
+    if (!is_error(ret)) {
+        if (put_user_s32(tab[0], target_tab_addr) ||
+                put_user_s32(tab[1], target_tab_addr + sizeof(tab[0]))) {
+            ret = -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
+/* sendto(2) */
+static inline abi_long do_bsd_sendto(int fd, abi_ulong msg, size_t len,
+                                     int flags, abi_ulong target_addr,
+                                     socklen_t addrlen)
+{
+    struct sockaddr *saddr;
+    void *host_msg;
+    abi_long ret;
+
+    if ((int)addrlen < 0) {
+        return -TARGET_EINVAL;
+    }
+    if (len != 0) {
+        host_msg = lock_user(VERIFY_READ, msg, len, 1);
+        if (!host_msg) {
+            return -TARGET_EFAULT;
+        }
+    } else {
+        host_msg = NULL;
+    }
+    if (target_addr) {
+        saddr = alloca(addrlen + 1);
+        ret = target_to_host_sockaddr(saddr, target_addr, addrlen);
+        if (is_error(ret)) {
+            unlock_user(host_msg, msg, 0);
+            return ret;
+        }
+        ret = get_errno(safe_sendto(fd, host_msg, len, flags, saddr, addrlen));
+    } else {
+        ret = get_errno(send(fd, host_msg, len, flags));
+    }
+    unlock_user(host_msg, msg, 0);
+    return ret;
+}
+
+/* recvfrom(2) */
+static inline abi_long do_bsd_recvfrom(int fd, abi_ulong msg, size_t len,
+                                       int flags, abi_ulong target_addr,
+                                       abi_ulong target_addrlen)
+{
+    socklen_t addrlen;
+    struct sockaddr *saddr;
+    void *host_msg;
+    abi_long ret;
+
+    host_msg = lock_user(VERIFY_WRITE, msg, len, 0);
+    if (!host_msg) {
+        return -TARGET_EFAULT;
+    }
+    if (target_addr) {
+        if (get_user_u32(addrlen, target_addrlen)) {
+            ret = -TARGET_EFAULT;
+            goto fail;
+        }
+        if ((int)addrlen < 0) {
+            ret = -TARGET_EINVAL;
+            goto fail;
+        }
+        saddr = alloca(addrlen + 1);
+        ret = get_errno(safe_recvfrom(fd, host_msg, len, flags, saddr,
+                    &addrlen));
+    } else {
+        saddr = NULL; /* To keep compiler quiet.  */
+        ret = get_errno(recv(fd, host_msg, len, flags));
+    }
+    if (!is_error(ret)) {
+        if (target_addr) {
+            if (is_error(host_to_target_sockaddr(target_addr, saddr, addrlen))) {
+                ret = -TARGET_EFAULT;
+                goto fail;
+            } else if (put_user_u32(addrlen, target_addrlen)) {
+                ret = -TARGET_EFAULT;
+                goto fail;
+            }
+        }
+        unlock_user(host_msg, msg, ret);
+    } else {
+fail:
+        unlock_user(host_msg, msg, 0);
+    }
+    return ret;
+}
+
+/* socket(2) */
+static inline abi_long do_bsd_socket(abi_long domain, abi_long type,
+                                     abi_long protocol)
+{
+    return get_errno(socket(domain, type, protocol));
+}
+
+/* shutdown(2) */
+static inline abi_long do_bsd_shutdown(abi_long s, abi_long how)
+{
+    return get_errno(shutdown(s, how));
+}
+
 #endif /* BSD_SOCKET_H */
-- 
2.55.0


