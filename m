Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFFBCDB466
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9h5-0002xz-2m; Sun, 21 Jun 2026 00:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9h0-0002xG-FR
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:58 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gy-00059K-RN
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:58 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-69e1f777bcaso2930156eaf.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015716; x=1782620516;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MvzdOyiF2y1MIvT+QTKGvq56/uFT2/67tUiQCVPCd7w=;
 b=GU27Vu5+sZSQeTJsxOOkgYNTu2YbEpYVonVflskbIA0KpEOKLza6HgEa0RWPuQMqQ0
 wgWOM09DxIpNUNqTIacszaJiiF19lSNATmT8nBSzUMNodPZrCVLoV5WtyhoCSQmdvP9/
 bFl90LHrKc+qwLo0pIekE0K4RtwwaStLBLS0UpZca8M8hJncO+gYqKUKAS1dCherWzt+
 Y12sYrbnn4R9zBYHEcjMxxyKRuo/eON51Yg/zjWJmJeXW0P2IGSiT+IHr3GOxBtGruXo
 oPlybzCc2te15dqjddohyfrxlfCYTBJ0nvwt+F5y/03i4mSYF72IKz6FJZ8BQLEg2yRl
 1/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015716; x=1782620516;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MvzdOyiF2y1MIvT+QTKGvq56/uFT2/67tUiQCVPCd7w=;
 b=UCXahOTcsQEzYQffkSg0jgVd32m9clNp0/epJG66HJJ6nOnwZaBc/l6r8UyZI153SI
 hiQP9bSkXQ3dMEgHyp/NRY2sv2xmBEr3uU70xTyZzc9wCAES4pQD48sZYkrBzwxPP+rT
 QnX1iUTO6ufAAYrBIMS8hQHnL6AD5v9v2hlMTvimnzVGIejsK2yDKEVCfNJ3n3bqMtDT
 2npE84JjW3s3JWngZnvnclUoKqNPVLmPoUmTMl0l46meBeaGk3spYlnQoUkefsnCTzzb
 ++ZEaO/v1RA+SvbzBWHACBLVDWXKULksT94sSNKXN1reNpdNLClEs591eaBEqTkD1TT/
 dw8w==
X-Gm-Message-State: AOJu0YwdBdhmHrxV043oPpaBOALSYOoHfnNrry0QP9KH1+1aTNHuHQKR
 L7/oZ5rcK5z0F8PefaLwGsm+cTgh2dTCQlku1Kp/GUmX15nHQ6QhcXOzB/11IvDs2Og=
X-Gm-Gg: AfdE7clGbD+cauxSrhEScATCC2kuqwcUMO8hozvcrRR4PC2jXtgucZHwceMI30rEEXK
 YjlKyXX4RkWma3nyh0nE9jQdojHGScAaZHUfWUBVDzgkLKFz0tQCx1xzOSeczzeswZtuyVTY4qv
 MpkXUzIB74TXWWme5ciQggeJXN5xeAinlN1vARTJceh25tOEcnwMiihRY6VUAWQWYfsGeCMokIO
 3Cs6+c6GZOr+abqpC1xKxpxsy1kd0BoFwJMHijlO2nvNlQ92JbC35u64fdo1G58sBZHi5BeWts9
 HbBPEXLkhqsyttpdUvWIVX0X04NAAaB8JzyKYUMU3jvg9BP9vuFdAvVkX6kccexJliqWK/U7W9Y
 +7SiyG4tVVsXqbUxtSNpj7tyxPQ2OcD6hGNceY0pE4WrnFNyOKgGQXKbxXaJmFx5mwROGMwzUCS
 +htRlnBVaWjQ==
X-Received: by 2002:a4a:e911:0:b0:696:1594:c5bd with SMTP id
 006d021491bc7-6a0da05b4a5mr5794788eaf.12.1782015715753; 
 Sat, 20 Jun 2026 21:21:55 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:21:54 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:19:59 -0600
Subject: [PATCH v3 12/40] bsd-user: Add socket shims socketpair through
 shutdown
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-12-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4353; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=MqY1unKJzBNNJ0wbC3yInaYYVvafwqt+1PzNlApqdfs=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z+fwbww5yOkgj3oNdaHNzEN8K7DHZrKPxAS
 eBQzaPDB1iJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfgAKCRBsHNEofbAR
 ACUqEADqzYHx2xjFDJqKmPi7yXKQX5UspmDJ1oieVEeemjkCZAtXeLKzGUbrbUlqWt7uG6Bzsr/
 WhqjbT3SjsPYh3qV5HWGKbhNHC/rMTJoFMwcdYfqyLkftw+3kdcRT5V/Yct4Y3uozWXdyHZc3Xc
 GOkMjQEFyXQbGDV57Nk5+wpbrlxixfVte5P+0lMAu6o02/RDKq2rUyV9mOgIAyoEwnMkpXQBmlG
 39N55mpNslc0wtUiJlF1GcZa+GMMX8QrEmRP5djDOXn8LLZfrIBsC04Oab+awtmKJRhkm6F0RQL
 Kfdz0cwhETJ6h+Wn5mdu/lyk4T5Y53qD/IEYAvi0YDA2a6vQsUqMw30MdHjdmlhPtiM+6yKWEMU
 AsW0LCTrHZYhuDCzZPCGhUw/tcnvLJToDYCrXcDSo6tDsIIkvqM8HXgAuPLmolcK+/yXjlXefwL
 +lJTgmp59ozJl0lT/GGCP6MtTsFEMix3CXp04yi1GX7EiKw5Q0j4vapdtWGDzdOIG5hHsATfgP0
 bLjoC9UNxQxirZbjOZK35FedgvmiMTx56QivM9d3+OdNWkwicKDE6rH811th2fzQXg3xABp558F
 J+VEZ4OxjLzoULCCHagGTPDClK6YEADgUPyWodoqkVH/mzfIaWgyR0QLlJkFckk24HL16GgxnYv
 QZSZ/hCROVfFCKA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c34;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc34.google.com
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

Complete bsd-socket.h with socketpair, sendto, recvfrom, socket,
and shutdown system call shims.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-socket.h | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++
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
2.52.0


