Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F96CDB466
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9hK-00032b-AS; Sun, 21 Jun 2026 00:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hG-000319-Eb
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:14 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hE-0005En-5t
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:14 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6a0eb989530so433108eaf.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015730; x=1782620530;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xp2PW1UQBDltfWrkoKTSVa6VIpi6uaQyLkZXDXJeAPI=;
 b=qBn0+N0UszMhLLxqXPQrJwk2Wx0yeO8LEtS/zyfg6sGrEz8N1bb5BJMWtI5y+F7xse
 jyZl8uUT/jz2jW02R6oeZ5xLhI+AOrgKT2SxuvkV/Ap/IwH+viY0yrgGCGJgO9r2CQOF
 wCfhcNg7UiR+PZmPxnqVHA9Dhz5R/TJNlEAaFz6Secp6YDbZZu4V42x6GPsRN2ItzJdh
 MG00XxYxMqvKN7CrPo9bAA2oqefvE3v+v5BF5iIrRvrt1+11arrPDNZ3Kubz8XY+LPbe
 VIBnDpX/cb3+SmnYr0TNVmCWO1Bp2ltjuAUE7SX2cLC3JAtpgTtXU4aE62SCEJkknBF4
 /0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015730; x=1782620530;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xp2PW1UQBDltfWrkoKTSVa6VIpi6uaQyLkZXDXJeAPI=;
 b=bIyCE0ttoUTztHeHBA9WiFRjuKBhHDvIw34j2RnhgvK+N/ZY5B1dpdeP70MED892wK
 G5SYh/z/3yxO+5YWKEWLoymjl6UispGxPer3okdlxdzVjvAElVPIg4xgl+2PP73TPWK+
 SrQBej4wtEj9tcNwAt+EOFZSyIyclwv6JDqNbXNUl5VE1LVIT36pa0Ntw6YW8unzQ4Ms
 ptm4qM+smF2bsPIVsdE8WA9+GfBxQAnAGZRsMwFfgxvawyXh9MwNW4UFBNMgWCivSXEU
 HUbr5jHYAy80Q8G1cNmM2qOUHA5URG+3GFsAly+ASgxZgoDtn14IofLYSM3Kh+JMidS2
 U4KQ==
X-Gm-Message-State: AOJu0YzA0G0ifMSm2ZZ4zgEHkJQgfVaGL4/Y0wqyAX9ldr9BbKhjwZgF
 ++3oh4yk6/frPFQIkhtCOwEPBBQoHeqeTyQui64yBWBfeVOs4BxwZYmq6UUTixeTcSgWrm2ebJJ
 Y4cqI/VugmA==
X-Gm-Gg: AfdE7ckFEppExADKF4xGVWoyKU4iX0qdvXHKeJ8UDdcNrijSltjSnOlabGXlnavoHHq
 yZ00m4M1Pnhb8Bm6iObOhRoS20WJd2JJRKdX3ZubrwI3T5ZcMNH2tLc/JCHlksjWwWwJiEHhyIz
 F27r8hOcMgaRUQ7A76O2oT6WLnf4rxsLPvSXZIfG6ucYDoev2J+HvARFTlID8785UcsamQ5YaFG
 yjUhJp/ze5SZFqlC7vzMKj00XAMnkW5HwOO05bciN5+dClvpOX95otvVJLcENppwHsUTCuKzST6
 lIgOnrnVmZBtqYeDzKomwOhzW1KFP574ZO9+gHRLAxHlYewvUejmjQQ2ab+Epz+D1tWKI2wz6S4
 /9Wmu8/IEdCV21RSZoMKPKB3Dik7eaNHxQjtXhZ/rkPEh6em8k/elsOLCrx9yL/AiEN/E8BXH9j
 4=
X-Received: by 2002:a05:6820:206:b0:6a0:fdc4:115d with SMTP id
 006d021491bc7-6a0fdc411efmr896010eaf.47.1782015729897; 
 Sat, 20 Jun 2026 21:22:09 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:09 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:08 -0600
Subject: [PATCH v3 21/40] bsd-user: Add select, pselect, and ppoll to os-time.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260620-misc-2026q2-v3-21-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6810; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=KLkGmYaTpJcDwjXumJN4nwyOJ9HgTF7+CflZ752H6KQ=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z/OZI0ScbeWEhveAqBopcqU04ELxcddns5W
 KZTAsZFv9WJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfwAKCRBsHNEofbAR
 AM9mD/0f5wOCqDNxWnmJ8pz2d/d5Rcvdii5qrkcawHErFhAh0dVBUVILRm523Ru66Hp5ZpS1/Te
 nTV7efsMhhrCitRoWoj46U9Bkur5sRfWRy1pRGUZeMcF9hklDL42Hy1z+snMml/kLM5N9vgN1Zo
 EsO4o7zfVld6mBsqnx9W9kOG2TkUKmQXFve4k+OfZE1pR3dTFIUTu6IJNi+Z4HDlhQRRJkNAor5
 3XlBK5ZqJJaiVdNaScFrghouq+Vd/u64DYvkS60FqkBFr5Mwy18iY9i/7TOZdNoacNO72oqkEq4
 1+uDtA9ipQaUCncZieoEv6ZBLDA74kYe4cIeYwf1Gi2x2jA1SQ18H2VAzaKca8Td7iOrsN5Nu+l
 cMjeVisjglqY0ngPqLdb5DmHBkusN3lYABWVqtWCVDIPT5nmfl9gE81C3merDAigcXsmUswGMvK
 YTkT9Vi46MNbPJsNHPZg9KG8NqLyvXsvXm2eyMKgSgX9fBkPYtmbsX8qkL+MhcjzsEeKrTy0P+Z
 ZZukDpzPkvszri0SeFCKGpQtXWC6FABkSoM2nJgvniai+TytdiL50uBOY9WYFTMoQZScJVJqKoK
 f8tT0Mez08oQ0IhIYUPDyXblGdU/MIWrJ/cqFoxxvXvZwjEwqEWJKHstXEmMUe/3+4XVScuf/oZ
 rB/Rn7M3kNYlrog==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2a.google.com
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

Add I/O multiplexing system call shims: select, pselect, and ppoll
with proper fd_set, timespec/timeval, and signal mask conversion.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-time.h | 202 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 202 insertions(+)

diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
index 06104a5b7d..5f537fac40 100644
--- a/bsd-user/freebsd/os-time.h
+++ b/bsd-user/freebsd/os-time.h
@@ -433,5 +433,207 @@ static inline abi_long do_freebsd_ktimer_gettime(abi_long arg1, abi_long arg2)
     return ret;
 }
 
+/* select(2) */
+static inline abi_long do_freebsd_select(CPUArchState *env, int n,
+        abi_ulong rfd_addr, abi_ulong wfd_addr, abi_ulong efd_addr,
+        abi_ulong target_tv_addr)
+{
+    fd_set rfds, wfds, efds;
+    fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
+    struct timeval tv, *tvp;
+    abi_long ret, error;
+
+    ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
+    if (ret != 0) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
+    if (ret != 0) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
+    if (ret != 0) {
+        return ret;
+    }
+
+    if (target_tv_addr != 0) {
+        if (t2h_freebsd_timeval(&tv, target_tv_addr)) {
+            return -TARGET_EFAULT;
+        }
+        tvp = &tv;
+    } else {
+        tvp = NULL;
+    }
+
+    ret = get_errno(safe_select(n, rfds_ptr, wfds_ptr, efds_ptr, tvp));
+
+    if (!is_error(ret)) {
+        if (rfd_addr != 0) {
+            error = copy_to_user_fdset(rfd_addr, &rfds, n);
+            if (error != 0) {
+                return error;
+            }
+        }
+        if (wfd_addr != 0) {
+            error = copy_to_user_fdset(wfd_addr, &wfds, n);
+            if (error != 0) {
+                return error;
+            }
+        }
+        if (efd_addr != 0) {
+            error = copy_to_user_fdset(efd_addr, &efds, n);
+            if (error != 0) {
+                return error;
+            }
+        }
+        if (target_tv_addr != 0) {
+            error = h2t_freebsd_timeval(&tv, target_tv_addr);
+            if (is_error(error)) {
+                return error;
+            }
+        }
+    }
+    return ret;
+}
+
+/* pselect(2) */
+static inline abi_long do_freebsd_pselect(CPUArchState *env, int n,
+        abi_ulong rfd_addr, abi_ulong wfd_addr, abi_ulong efd_addr,
+        abi_ulong ts_addr, abi_ulong set_addr)
+{
+    CPUState *cpu = env_cpu(env);
+    TaskState *tstate = cpu->opaque;
+    fd_set rfds, wfds, efds;
+    fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
+    sigset_t *set_ptr;
+    struct timespec ts, *ts_ptr;
+    void *p;
+    abi_long ret, error;
+
+    ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    /* Unlike select(), pselect() uses struct timespec instead of timeval */
+    if (ts_addr) {
+        if (t2h_freebsd_timespec(&ts, ts_addr)) {
+            return -TARGET_EFAULT;
+        }
+        ts_ptr = &ts;
+    } else {
+        ts_ptr = NULL;
+    }
+
+    if (set_addr != 0) {
+        p = lock_user(VERIFY_READ, set_addr, sizeof(target_sigset_t), 1);
+        if (p == NULL) {
+            return -TARGET_EFAULT;
+        }
+        target_to_host_sigset(&tstate->sigsuspend_mask, p);
+        unlock_user(p, set_addr, 0);
+        set_ptr = &tstate->sigsuspend_mask;
+    } else {
+        set_ptr = NULL;
+    }
+
+    ret = get_errno(safe_pselect(n, rfds_ptr, wfds_ptr, efds_ptr, ts_ptr,
+        set_ptr));
+    if (ret != -TARGET_ERESTART)  {
+        tstate->in_sigsuspend = true;
+    }
+    if (!is_error(ret)) {
+        if (rfd_addr != 0) {
+            error = copy_to_user_fdset(rfd_addr, &rfds, n);
+            if (is_error(error)) {
+                return error;
+            }
+        }
+        if (wfd_addr != 0) {
+            error = copy_to_user_fdset(wfd_addr, &wfds, n);
+            if (is_error(error)) {
+                return error;
+            }
+        }
+        if (efd_addr != 0) {
+            error = copy_to_user_fdset(efd_addr, &efds, n);
+            if (is_error(error)) {
+                return error;
+            }
+        }
+    }
+    return ret;
+}
+
+/* ppoll(2) */
+static inline abi_long do_freebsd_ppoll(CPUArchState *env, abi_long arg1,
+        abi_long arg2, abi_ulong arg3, abi_ulong arg4)
+{
+    CPUState *cpu = env_cpu(env);
+    TaskState *tstate = cpu->opaque;
+    abi_long ret;
+    nfds_t i, nfds = arg2;
+    struct pollfd *pfd;
+    struct target_pollfd *target_pfd;
+    struct timespec ts, *ts_ptr;
+    sigset_t *set_ptr;
+    void *p;
+
+    target_pfd = lock_user(VERIFY_WRITE, arg1,
+                           sizeof(struct target_pollfd) * nfds, 1);
+    if (!target_pfd) {
+        return -TARGET_EFAULT;
+    }
+    pfd = alloca(sizeof(struct pollfd) * nfds);
+    for (i = 0; i < nfds; i++) {
+        pfd[i].fd = tswap32(target_pfd[i].fd);
+        pfd[i].events = tswap16(target_pfd[i].events);
+    }
+
+    /* Unlike poll(), ppoll() uses struct timespec. */
+    if (arg3) {
+        if (t2h_freebsd_timespec(&ts, arg3)) {
+            return -TARGET_EFAULT;
+        }
+        ts_ptr = &ts;
+    } else {
+        ts_ptr = NULL;
+    }
+
+    if (arg4 != 0) {
+        p = lock_user(VERIFY_READ, arg4, sizeof(target_sigset_t), 1);
+        if (p == NULL) {
+            return -TARGET_EFAULT;
+        }
+        target_to_host_sigset(&tstate->sigsuspend_mask, p);
+        unlock_user(p, arg4, 0);
+        set_ptr = &tstate->sigsuspend_mask;
+    } else {
+        set_ptr = NULL;
+    }
+
+    ret = get_errno(ppoll(pfd, nfds, ts_ptr, set_ptr));
+    if (ret != -TARGET_ERESTART) {
+        tstate->in_sigsuspend = true;
+    }
+    if (!is_error(ret)) {
+        for (i = 0; i < nfds; i++) {
+            target_pfd[i].revents = tswap16(pfd[i].revents);
+        }
+    }
+    unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);
+
+    return ret;
+}
+
+/* kqueue(2) */
 
 #endif /* FREEBSD_OS_TIME_H */

-- 
2.52.0


