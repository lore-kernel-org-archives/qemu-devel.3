Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE686CD98F0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9h9-0002z5-Mc; Sun, 21 Jun 2026 00:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9h5-0002yS-BA
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:05 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9h3-0005Ad-Dx
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:03 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-69d7aa0ac14so2520869eaf.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015720; x=1782620520;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g9pMkQjbvCRyzCC8NY9CFRAVGzzfTcdxA6DGnN9j47c=;
 b=Ab2k9jGWylnusIE9lvd8XXFuEJ+OxxLze9LAteEm73fEUbPmc5f8uKx4r91fHYah9c
 Oaxm8tW9SSLPQ7oP5OJOx+keB2Q5Z7uOTRx4jATOk6yUDfPPM7+bv78v4C90lhUz8k/0
 Idu5lEIUsENJ533ew+GGEmESI4qGlZTe+zWNkMi966fI8O4pEefW+WG7Dadq5xsHkurA
 jKWPJTOZAx+5IKQShEYDP8eGEdBf+kJKWA4lI5xU8IkJFPc4s2k3XacRM3eMbVzSTz62
 lXaINe0UE/ABU8FNUD2RF2ddp886VhFqnO8B3kXAPw9CoFaSLwHv7HTsM0Wg7uX4V93R
 Yi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015720; x=1782620520;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g9pMkQjbvCRyzCC8NY9CFRAVGzzfTcdxA6DGnN9j47c=;
 b=pyYHZWPoGa9CYfhLxn2x8hyAE6dZfNuqzdVahC3fQXRkYg/vI45hDhvlSF8ZWj8ayi
 M5Jp9cAkFwjfb2q9QqLcZ/OOojv+aBvnBJcvWqJDZhrUrTzJKeqnnpwZEaiuHMhts4OP
 v2IWsqJaoOtJZEYSKWPz6Uq2cHstVelcoitxvfo75vYoOwLgCgvG5fcQ0CEIus6ARl3E
 lsrgs7kZTyY0FacrjrYti0/VO+GBRm8F2Q2aFFAxXpy/AEI2JMISi5fdD0pJ3djQESrx
 GKiZ/4MKPwtlwwUn5NkVARxJhwPpvrJ2bmYwNxMd+HmJK1+1lc3sUHuFFcLOaTA8EPhm
 8kXg==
X-Gm-Message-State: AOJu0YzWCI7/r3LOB28rZOmC+ggv+iqqUtezqjAJy+gQGgzHAuMhToUA
 ACUe7kuhxZPX00lsCUjBJXDCK+SLZeuETHc+2DfP0Gk3S2BjDm+e0NxNsY4wmkR/K5k=
X-Gm-Gg: AfdE7cmHcRXFDA4uJs6x7VCXkoRi/gVdZo2JQhCADxUvCStPDrubSsoUvz53ZkuyjnY
 D/CJrTGTYD5ocvDsUDzLaMritKWq2MN8w9s2qYMvQIBzAjnLfHyOZohCLJUoLmV71jlT/NVLwJT
 rz6AHTbE0mD8o7784rFWfcaX586LrrYAenr8Heyw9yhB6dAr5mEqTbj+t74DpkVf7q6zkvZ4X6W
 55CbkpQhaXbgQJ7l6mdjbpLt0s1bOApo+KbxBbd7O43zbi+3GtKnj7VRu0rS8+EYWDT96x9QUs/
 s0uuiAgjRZTQHVhsinu0/yvQcFE2gg5orJh8Q1BJOgOt+36lXZQAcFfypZWQB1KTUyfP+698jIz
 7/DO2PLH3Mn+984PJp/QWLy+R/EAJi8ZoEGgSz0JdmnghjZrIoy4XKG4o3ZMaZKqKQPALCMjK6J
 E=
X-Received: by 2002:a4a:ec4b:0:b0:68a:daca:94d8 with SMTP id
 006d021491bc7-6a0eb300044mr4479980eaf.12.1782015720303; 
 Sat, 20 Jun 2026 21:22:00 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:21:59 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:02 -0600
Subject: [PATCH v3 15/40] bsd-user: Implement both getsockopt and
 setsockopt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-15-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7385; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=zL2J55rvu1tUCnrynrgzeb4o1brjwtYqdonYadiQvSQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z+Y3sIVnbfqrYQcvT2MFI2gEic38R1UJc9Y
 TeOQ+Si+q+JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfgAKCRBsHNEofbAR
 ACFoEAC2UU2fpXKw0bm5XDvDc3WEHnM3ojkahp6QM25g53UWMTPlEDVtLHpODgaOV1hV+g4Ba4R
 AArY81rn8J4yM3BCX4uxGOhd8PIe5dv7FB7jLXVtmuCsnkJWi/OUnKKm5H6vWeh1eLRl43bZo0O
 hkE7gxPrH77uJQqWU6ewPOlISQyUUlfw5N6S1cpcHsQFUs1BoN8ewPKsb0StJk5mSWLlaL7n0xm
 bAKbJBXGOIQmBYlu5yZCQAGuJ776rfRtCqMzSctKqP8o6e1zyzyLs2gx5ghpXpYdwNvdWpeqSJt
 NegXkSidymC+igrykBAFFHu5ifnyEv/vUHhrI99UYDD8e/SeLUVT47K15sDmarmsjxlOmlTbcMl
 x3YeAvgl/l+ao2U1ATg0g5VbKvI5RdlVWNSY1gd9RKMfk0RE3Yug8atwhme8eNCRL1Ktwla5bme
 fPoOi+273VEeXAy8Ld4HhdtXIf7RREMW19oS8Tn5zlMAzGOobuPI/NO5BSp1sskGeV9mSXy/4SD
 sv6QMh7BdyNdhCHyl1x/2X0xd4S17Cjnm2Dm6jU5TmAAicgYyY0dwr6IG6ySDJ8THr7hSwrMzen
 BVPfAOvQ+cgQ0OwSKAtM8uZ2t83AaEQcxaykHe8CnxrSxPsV2bfJ92QQhlUafM/VvU+omy2pJWF
 q2hDEKCj824s5Rg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c35;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc35.google.com
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

Implement get/setsockopt with the generated file describing the socket
options. This uses a table driven conversion. At the moment, we only
implement the simple types. For 64 on 64 with the same endian, we also
try to just copy in/out since the representation should be the same.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-socket.h | 199 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/bsd-user/freebsd/os-socket.h b/bsd-user/freebsd/os-socket.h
index 279157dd05..30d62ebaf1 100644
--- a/bsd-user/freebsd/os-socket.h
+++ b/bsd-user/freebsd/os-socket.h
@@ -14,6 +14,7 @@
 #include <netinet/in.h>
 
 #include "qemu-os.h"
+#include "os-sockopt.h"
 
 ssize_t safe_recvmsg(int s, struct msghdr *msg, int flags);
 ssize_t safe_sendmsg(int s, const struct msghdr *msg, int flags);
@@ -138,5 +139,203 @@ static abi_long do_sendrecvmsg(int fd, abi_ulong target_msg,
     return ret;
 }
 
+static inline struct sockopt_entry *get_sockopt_entry(int level)
+{
+    for (int i = 0; i < ARRAY_SIZE(so_cache); i++) {
+        if (so_cache[i].level == level) {
+            return so_cache[i].entry;
+        }
+    }
+    return NULL;
+}
+
+/* setsockopt(2) */
+static inline abi_long do_bsd_setsockopt(int sockfd, int level, int optname,
+        abi_ulong optval_addr, socklen_t optlen)
+{
+    abi_long ret;
+    int val;
+    u_char ch;
+    uint64_t val64;
+    struct sockopt_entry *e = get_sockopt_entry(level);
+    void *p;
+
+    if (e == NULL) {
+        gemu_log("Unsupported setsockopt level=%d optname=%d\n",
+                 level, optname);
+        return -TARGET_ENOPROTOOPT;
+    }
+
+    while (e->level != SOCK_LEVEL_NONE && e->optname != optname) {
+        e++;
+    }
+
+    if (e->level == SOCK_LEVEL_NONE) {
+        gemu_log("Unsupported setsockopt level=%d optname=%d\n",
+                 level, optname);
+        return -TARGET_ENOPROTOOPT;
+    }
+
+    for (int i = 0; i < ARRAY_SIZE(e->type) && e->type[i] != 0; i++) {
+        switch (e->type[i]) {
+        case SOCKOPT_TYPE_BOOL:
+        case SOCKOPT_TYPE_INT:
+        case SOCKOPT_TYPE_U_INT:
+        case SOCKOPT_TYPE_UINT32_T:
+            if (optlen != sizeof(int)) {
+                continue;
+            }
+            if (get_user_u32(val, optval_addr)) {
+                return -TARGET_EFAULT;
+            }
+            return get_errno(setsockopt(sockfd, level, optname, &val, sizeof(val)));
+        case SOCKOPT_TYPE_U_CHAR:
+            if (optlen != sizeof(u_char)) {
+                continue;
+            }
+            if (get_user_u8(ch, optval_addr)) {
+                return -TARGET_EFAULT;
+            }
+            return get_errno(setsockopt(sockfd, level, optname, &ch, sizeof(ch)));
+        case SOCKOPT_TYPE_UINT64_T:
+            if (optlen != sizeof(uint64_t)) {
+                continue;
+            }
+            if (get_user_u64(val64, optval_addr)) {
+                return -TARGET_EFAULT;
+            }
+            return get_errno(setsockopt(sockfd, level, optname, &val64, sizeof(val64)));
+        default:
+#if HOST_LONG_BITS != TARGET_ABI_BITS || HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
+            gemu_log("Unsupported setsockopt level=%d optname=%d since host and target differ\n",
+                     level, optname);
+            return -TARGET_ENOPROTOOPT;
+#endif
+            break;
+        }
+    }
+
+    /*
+     * When bit size and endian are the same, the structures are the same (we hope).
+     */
+    p = lock_user(VERIFY_READ, optval_addr, optlen, 1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(setsockopt(sockfd, level, optname, p, optlen));
+    unlock_user(p, optval_addr, 0);
+    return ret;
+}
+
+/* getsockopt(2) */
+static inline abi_long do_bsd_getsockopt(int sockfd, int level, int optname,
+        abi_ulong optval_addr, abi_ulong optlen)
+{
+    abi_long ret;
+    int val;
+    u_char ch;
+    socklen_t len;
+    uint64_t val64;
+    struct sockopt_entry *e = get_sockopt_entry(level);
+    void *p;
+
+    
+    if (e == NULL) {
+        gemu_log("Unsupported getsockopt level=%d optname=%d\n",
+                 level, optname);
+        return -TARGET_ENOPROTOOPT;
+    }
+
+    while (e->level != SOCK_LEVEL_NONE && e->optname != optname) {
+        e++;
+    }
+
+    if (e->level == SOCK_LEVEL_NONE) {
+        gemu_log("Unsupported getsockopt level=%d optname=%d\n",
+                 level, optname);
+        return -TARGET_ENOPROTOOPT;
+    }
+
+    if (get_user_u32(len, optlen)) {
+        return -TARGET_EFAULT;
+    }
+
+    for (int i = 0; i < ARRAY_SIZE(e->type) && e->type[i] != 0; i++) {
+        switch (e->type[i]) {
+        case SOCKOPT_TYPE_BOOL:
+        case SOCKOPT_TYPE_INT:
+        case SOCKOPT_TYPE_U_INT:
+        case SOCKOPT_TYPE_UINT32_T:
+            if (len != sizeof(int)) {
+                continue;
+            }
+            ret = get_errno(getsockopt(sockfd, level, optname, &val, &len));
+            if (ret < 0) {
+                return ret;
+            }
+            if (len == sizeof(int)) {
+                if (put_user_u32(val, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+                goto done;
+            }
+            continue;
+        case SOCKOPT_TYPE_U_CHAR:
+            if (len != sizeof(u_char)) {
+                continue;
+            }
+            ret = get_errno(getsockopt(sockfd, level, optname, &ch, &len));
+            if (ret < 0) {
+                return ret;
+            }
+            if (len == sizeof(u_char)) {
+                if (put_user_u8(ch, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+                goto done;
+            }
+            continue;
+        case SOCKOPT_TYPE_UINT64_T:
+            if (len != sizeof(uint64_t)) {
+                continue;
+            }
+            ret = get_errno(getsockopt(sockfd, level, optname, &val64, &len));
+            if (ret < 0) {
+                return ret;
+            }
+            if (len == sizeof(uint64_t)) {
+                if (put_user_u64(val64, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+                goto done;
+            }
+            continue;
+        default:
+#if HOST_LONG_BITS != TARGET_ABI_BITS || HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
+            gemu_log("Unsupported getsockopt level=%d optname=%d since host and target differ\n",
+                     level, optname);
+            return -TARGET_ENOPROTOOPT;
+#endif
+            break;
+        }
+    }
+
+    /*
+     * When bit size and endian are the same, the structures are the same, and
+     * if not that is handled above.
+     */
+    p = lock_user(VERIFY_WRITE, optval_addr, len, 0);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(getsockopt(sockfd, level, optname, p, &len));
+    unlock_user(p, optval_addr, ret < 0 ? 0 : len);
+done:
+    if (put_user_u32(len, optlen)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+
 
 #endif /* BSD_USER_FREEBSD_OS_SOCKET_H */

-- 
2.52.0


