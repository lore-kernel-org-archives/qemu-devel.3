Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44164C5DF87
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTgv-00029I-Ui; Tue, 18 Aug 2026 19:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgu-00028z-Dx
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:00 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgs-0005Fb-QY
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:00 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4af81963f35so412591b6e.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097478; x=1787702278;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8294n884KVGJva1YRI5QhIhR/RZ1F/vd4a8RO/2ocQs=;
 b=aJ6bd183hKDitMeqRwXyIiopQy6iQMkOtyWraFVt714y1CKEn3BUA5raT5th/lOYFl
 tv4u5zllx35DIg+m98CQP+S2nVArL2IYWiVKgANZgZpkbVkkfkN93/hCt7Uyak+8ZSU8
 +mSplxFf5qVH0NZFxKHg1xHtdXOqfkRlClTDuVXLGV5fv/nuHxhul9dXvKr11u8UlcFU
 HvwXo/28AN2OoB+yb3c1HTkYiI4THasF7ORBR9vg5bOr88yOf+JaFxG2TU/DxcOUw7ls
 pegto8NdoQYpwiYYbXJrdpAB0E4roh2rYzqFAdgHbZhuEX/kpvGJe/YWRSMmlFmi2/B1
 BvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097478; x=1787702278;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8294n884KVGJva1YRI5QhIhR/RZ1F/vd4a8RO/2ocQs=;
 b=V+7owK/+uiwbXeH6txi4jFCE5PKcDWWhfq4FeQNq+lmCmRVe35Iwx5xACpJPA5RvXk
 72x+6zzXG/R5cDRkRbnPuLoxRd6iAoeWIyv7jRYZ8Jni3O7Q0t9/W/L6oLOFW90APPbf
 zZClwxt8Um09Jgtq+vY6xnVLDf0lXS0mu7sk0PBDNhmvng6/4yA2cDujVqSjdaHFPSnS
 j2oYA/CM8Wv1kuyqUFujlsIVrAd8DWXrcbJ7NhM7f5hGOFvjXMfqIeFzqrtgpQd+z1gi
 Ps2YEZxAfa40hhtZmHFfOdBMZQcu+A7+NT7STJNhMumRLY7AzE409LSXcMddjysd6izR
 syfA==
X-Gm-Message-State: AOJu0YwKH+iSWr854nU/lbwBfP8xS+zVTg/PySMPvT1Xfs+IYxEz9fyh
 tUXpEgaNxDmzGJndd068PKQKbbJRP9f7d1Pd2gn4zhRlRGwrow5ntlZEEnLrl02e/LFQkpjSPk+
 vSHYbmvU=
X-Gm-Gg: AR+sD11PQPfstYrebOsFcsMae2WQce4ZgNkcq/xjJpHJ5mjPOimTlfJD+KL+0i8QlBe
 7EWA+Sw+QOhD0OfNKkXaeHN75KsgR+kKj6NhOlS1SYzO0o823Cazl+N7I8ytUN8luH/S/XSw96Z
 kSN6dMuKYes9nEFrtNd6NRr8OY0bB3QjmXETYDqH+Fji4LXIicOWaWL6paaaHrbWSdYAqhR+KFw
 reFpEYCvWlbiVTE6krYReHrtJl2/Hbf7XSQEzPIRPr0u6XI6esN1ldricfRuL5U76z9hVLOfAPg
 79WogkB76H7zdbyJH/odD78ms+C74yuM1iMWmroRBdhfdQFZ57VzJzyeRBVZD/xdKycTfISYPWK
 +FOor8wxutQPJDKFEGS6B3/D7zaeoT2+08AixxMhzWVJuZ12tP4HeREa01MB5zFofFm/i1aSSPU
 4C+xPoC2sSmtYtbnULln1HCHmqKZQ1V7Uls1zvNuC6Nf45KF8=
X-Received: by 2002:a05:6808:1a08:b0:4b2:8d89:6a40 with SMTP id
 5614622812f47-4b2bc903077mr313182b6e.7.1787097477824; 
 Tue, 18 Aug 2026 16:57:57 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:57:55 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:08 -0600
Subject: [PATCH v4 15/40] bsd-user: Add socket shims socketpair through
 shutdown
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-15-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4413; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=JyExbELLtZERoEtbIzRdDiDpg31vaLIGV/sZy3cGa8c=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPE2N1G/L6GQ/Npov4eK3jl7uwXbGr9chn9qh
 pui10UoiI+JAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxNhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQAofxAAkuudgep+C3hVtefZQkGp8HmOW7P3z09
 KNVHe5ofSJdRCWQr/Fuq8KPUkB0TH976zuOSK5JvOSSAYQHUK4AYloc31wvKKPI+q2YOKdQsAER
 tsv7l6BAdyKrxEsbZu2mvb8O7CzSE/a6vRdc+WTaZPzq8hEiba1jVhlWIg8R8cauidfNt4B4hU5
 W6cUpHyo6WNMV8CwFc0sNIUCtwtxrXVqLKFG0nuvkvYSAoKZ8t/HvtNsEMH5rj0J2jhssxa+cl3
 zXkmCVWyDhLt2kMrARlSghspk7ujHKYNoD6Kkt81ow6b02L12mWAR1IB8IJpnkZ1d+HWLOy2nij
 qXUdy21YZDuE/S3f3Qqcoo6gK0wo1CQy5Qeo/tmwwA37rnwfnd3sWDNXv31uDNyaF+Tu6SEoacP
 SYiQKKO8UsepuEEVHW2dUC9J0Q+5mJ29VFYQEGVY1mo+dvnTjXZIX8EVg9ZXwxt44COE7cr8gJC
 JBklSAQaGNM1VBkV0JbuCjlJC6KbgYwuLTl/Tb0YLnXvrXsz+isKSUGJ/39JK8CTCmPAREqsaUY
 EgdnNtLxFylFr9CR5ywp3HX80lnKSWSmR4q69vBSfAhbtWY11o57hTB1df77ISgtGjiivoYnVVS
 stL9aUp83QoRrbtqdsIYh3qX8fnMDfHkhc0n7/R0k02irDE+Mwus=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::235;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x235.google.com
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
Acked-by: Richard Henderson <richard.henderson@linaro.org>
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
2.55.0


