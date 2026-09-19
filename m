Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D2DC982D8
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yFR-00032D-2K; Sat, 19 Sep 2026 12:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFP-0002yb-EA
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:07 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFN-0008J6-6W
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:06 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466cc9ab667so2033822fac.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836544; x=1790441344;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=amVhYExPd5s93ZHsdRsArbSCt7P6Dz5WkNFyQY2RDag=;
 b=Q8faxXuQjHbEwcnAqbpxp1knEIgvKE6eBfayOKXUabpBppZWxM9om9g5kIvpMbIQ8G
 +TszTpwoIQEJq3uZO3qVu+vOSoA4lZU6Sh5kb2qIaGbma5xd5lGSs8qWC/IyAYlsTMiE
 9lYwIev0PPljy5VHUeEHpR3F08EBk5weq+n0yE8ThsyhNRBOue7etuu0oU8Dg+toliiT
 L22M3sWk1s69vOoxlwIXDw0ITB1Zl7MGL0sZv70nRcmzadtPQtcTCJcb/kVFV8q7IFBA
 4Deau9uTCPAJKPR4RPMBRzBM0+I/iP7zV9OMX7aJbsQdNiN9L2Nf1j8bLuWC3nz4h+Ja
 TMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836544; x=1790441344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=amVhYExPd5s93ZHsdRsArbSCt7P6Dz5WkNFyQY2RDag=;
 b=V0d6LEpT3CDjF+WWUPJEeEbf2wss73XQ2J/t9aZPNG1cMbgUBslPMbU3Ca/y2VIg6g
 Yk/sjswBqsYSb6bPGLJhOyeE4+Le06Gpv7teXNHSdrE3B8NwLv1oAuxB7R2t3VDvPfvf
 L8bufCaHiiYIPql3Oto0Ri3+GN3bWABOs9zEiZXlTQgMzK6cX0SEX0RJUdUHQa9f6Oor
 83r4XIgSJikYwznhVdGm5+Le3Xd5BDCelh486itxiYEUb1GMeqnxvWdQelHAzqI1nv+F
 UZe2GTfFKTjCTTAQUtzgvlrmpf0ESI8+UuQPVvaDB1ijwDFuIn0Rxy9zzFwPCRn8Son/
 4v5A==
X-Gm-Message-State: AFuF++me6pk7eWqgKqOjAEHgbh1Y76cv3jqpOWvQLOW2f8oPljC5oUNY
 I+Lca1GrHWgKng2HhrMYG+Q9P6GgNqxTqufcu15bJ/IUajro7VT3EmwqOupo2gSgU3wVdnwPxiy
 7PsbntIE=
X-Gm-Gg: AYBFou0rX/djqv0AR4zuJOP6LLX6QSfoGQUyIwAgQd8Hz6UzJTI3SD0a9BWq92mvm3v
 RhdvyHjr1pTUWcb4qvuRoijOWv6LtoTyRRDzuUJWEIww9zbwyaOv161SdqyYWLtHvIYxtKcdt00
 OK10Oc4GCz8kAB314FhQd2pORspoMDg3ekZmyo3wGBPPOb9FNdOz08KT9CpCepRR30yPlut+fTz
 B9dWVTq+YfvYAbKHjkxaoHc2l0VtsBdw3dwC4oyt6ask4+aoulrdut16D7ZcClW6KP3cfNbp/Q9
 5wiqfr1e3rzAb+n1k13A8qz4SSqHFNiJP3SBkGEG3dZQB5sHTvE6+xovJbaANHXR+W1mK5liFcx
 CoBGNE5l0OpaQH6PNhMMhY8TMHRhRGGKBcKVR9XwQayHeMiI8JSs9oNtGDkcMMZLVLv56YXMs72
 J1cjVT40uZFs6FHoPWkgWRD9WdsiNMnLwM4JhlvnyoVD575cQbtYy0LWHZXg==
X-Received: by 2002:a05:6820:4c08:b0:6b7:46fa:1692 with SMTP id
 006d021491bc7-6ca9be5036cmr5549825eaf.39.1789836544147; 
 Sat, 19 Sep 2026 09:49:04 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:49:03 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 19/41] bsd-user: Add FreeBSD socket system calls
Date: Sat, 19 Sep 2026 10:47:47 -0600
Message-ID: <20260919164810.70151-20-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:30::10;
 envelope-from=imp@bsdimp.com; helo=mail-oa2-x10.google.com
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


