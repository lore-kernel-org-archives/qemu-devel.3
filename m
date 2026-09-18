Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64472C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QAI-0005Xq-IJ; Fri, 18 Sep 2026 00:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAF-0005Wy-EM
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:31 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAD-0004Mk-IY
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:30 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-7fcb425fb68so149161a34.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705528; x=1790310328;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=amVhYExPd5s93ZHsdRsArbSCt7P6Dz5WkNFyQY2RDag=;
 b=aDR0bug4B7yKnnMAMF8+1ZQxFOhTTc2j+V8+hReseM2Va+NeG4U0x3IrEknnNE14iT
 Qx54bFl9RHiuAtUrKSq7uj2lw91fw1fw29eoyG46AAaXq1kiWK+N3yl2JT8cCPlNL45u
 7409MRGSL/yiFxZnz88kLiB6AH3XfIEdnaF48ike2OKUwzmfm7wmi15GFwSFYqXjosox
 mFCCLzmDD9K+2XOY4xwtfMR+wDFJA1qp94K9fvKBJ++YtgXQfU4PgSqtxhYb+Up1cz7T
 584M96JofeSe7NcLCQdzYrnkzKq7AbDnlWuCOnNuYCsMaVV2aiFW+eokbQWHSIq8w0dO
 ZjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705528; x=1790310328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=amVhYExPd5s93ZHsdRsArbSCt7P6Dz5WkNFyQY2RDag=;
 b=hWuDchc2nsFOYH4ZYrvBmPJLUOGPFjgCZTVTX1EkRU1CrhSyO2b0AzVGolp6ZNrDJs
 V7mgFZ6IYhBKVWKzvwZz31U+LzozQ7VYn7CqcGkycLDLNUuY3MhSI0ud90/j+LikebBy
 dt95rXhyCJO6woRRRZTrHdttmP9ZlHIzFTqHsBGsijqJsvkp9itBS12Mh4qnGhXgLrI3
 Rctp1uXrY6mbbMItQf3V9Y7awFSfstcADQ+FvlSTI4hK8AozDM9oxVl808KtLLrYKv2Y
 asm143SQbJnohy4r2gKTmJKZlLV5DLhZYg1qWPMo98Qz7xm8RzpFSP5RYhSf0NvN5hxP
 +s0w==
X-Gm-Message-State: AFuF++kIAPNsPsJpeuvPIw3sd8+Ui1wsrbi1/1w/Jzfh+N/iS0uTa1AN
 lTke4gYVYTxz6XKTSNosn5waZZt7yHco9dVZOCR2dhMnan5l57HDrCtF4yUdA30dgHQWy7n1v6/
 mIPKw4zA=
X-Gm-Gg: AYBFou2sDmjSN36KWrukaH9HeAdBIsUeEeU0i7e1ly/DRLLtBLcyVV/i09W1OLxjcOj
 oBX7P545Rt6MlIaqANX7tfU/uG93pyIINq35oMwv7CzxtQue+q3mQhvYdlh+IADFz19xlQYyPBb
 8mZzbh8HoZMcMxcj27Qk4CmNZq0tzLjUvqKgkvfuSgQWVkWZB4z6dY0T9oNnnMHr8NF3urrx8by
 vAy8EpLEl4MUVWEfrY00qE/KbBqHt+vMRm/f4nSkrgN7kRmV6vs+mjf08grw52L7vOAgUxbEyVR
 Xaq/PyG5q40+ln1dAg6G7dxgvWB1EGa3Ise9/MPvwPGged++1C8U6KbetWJSHqTrbPDW7mR4nB2
 U+QVWyideu94tTzz9q6HhkYhgrOAp8ZD4C+76nA1ts2u3U6X6aQhu0eLu5QzFoaT3SqsgEzYLEy
 icVzrBBX+a8bhgG+r/rlX6JboA6IkyCpeJvuWCAdFqc2kg6hnK7cTf0D7HPQ==
X-Received: by 2002:a05:6830:488f:b0:7e9:e709:44f6 with SMTP id
 46e09a7af769-80de0f610f5mr1541858a34.12.1789705528635; 
 Thu, 17 Sep 2026 21:25:28 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:28 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 19/41] bsd-user: Add FreeBSD socket system calls
Date: Thu, 17 Sep 2026 22:24:00 -0600
Message-ID: <20260918042422.38713-20-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::10;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x10.google.com
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
 bsd-user/freebsd/os-socket.h | 83 ++++++++++++++++++++++++++++++++++++
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


