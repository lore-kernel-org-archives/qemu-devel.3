Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF9FC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x964H-0000lI-0v; Tue, 22 Sep 2026 15:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963g-0000YY-QQ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:41 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963e-0002Or-Cc
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:40 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c6ed1de994so202120b6e.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 12:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1790104896; x=1790709696;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rWbNjRGMUh1mhOTZ0cR2qTpaFZU82Xi9hzlRzoXXeGw=;
 b=w5Hyn1jugGJZAQr1SYXe57QWoESBnvdEcPjV1RcMU4kNGYjI8+CpsWbiD4kyZJ2vkE
 eBf4C6fUuCIkwIv2SmI6lKlrpaePLIAhzJidA9LAGByFEUAG2WPzYPoYreNOlIeaZa6/
 UsQ/Hyo81MQct+84BrA702/UZBwpVNH4N17++L2kIqSUKyRLfXpN6LcAAmToDWvEt3O3
 J4jU2FLh7A3HyKBzamfjSyII+P+PSJPDRGGuqJtYc45/IDY/4vakYTouM/dweJeRYxBh
 RGC9pBbmuyrNdJiKSmIZ5L7C/OLnH/OLYWTAI4YQSR452LqYdx2XCf9k7lYIczZSA1h6
 /nSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790104896; x=1790709696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rWbNjRGMUh1mhOTZ0cR2qTpaFZU82Xi9hzlRzoXXeGw=;
 b=0KFE3oFM2Ehr+KH8IWhzYkECktjIfCXp8Zs8VaKN+UxLg+K1amjjREaUekhjGs9lVG
 2U48gbOrgPJvkMrYtgGMqD1PKpnqqQXAsTbguXs8e3K9vNc6uIOLet+yno/9JgTh9Xqa
 0eg+F1ZITWPoS62SoADLedx0vEX93jxiXXbXTKJfP5/SVLmsNbseodJtZwyLP4pbFIqe
 SB+KSZ8RQKIBw3AG0GUM1lyDXnHJKiqK6VE4CtP4/uecnZcttO3Z23qo+307yd5JLRRw
 LKZFCoaJKFxCvb06mR/PSC/PoVJJzQJgPxBZ+93q6BxcxrbP4SVgYfugmeQKZlnhSNJV
 VJTw==
X-Gm-Message-State: AFuF++m6LoZMKI7bo0kEplJreJFbPIWq5AYo3J15wV7OdyKdI/yo9SXa
 rnGeN8BOr5crIEECYMXlUDaQqsI623/7oJ4hmvLlF9fYof1tCisWK3eY0n8mwIBPoNLPuMUrcUV
 a6nHWxWc=
X-Gm-Gg: AYBFou0q7lBlHVsdsDb7wOYXsB27cR5Qkilw7lWMgKSiwv+MYc9lFYLJkWBKuDIQ4dn
 cQcv+eDfhaVACc2L/TOhWSZ4F+qK4qNwfmqyZ59wSO1A3ChXWBc11yBm+Ll8JImQT5pzOCC/6IU
 yZnRcx62WfQBaN4ruzJ8STowx6eUXKAMKWfK+7YpKqIC1HyQpd7eWphP3PLaTYalOeaIsgRo7XA
 R1pyw5OLaPEs/Iz62zyp0fi4JNiX7BmSmexbrQDe8VAvCQcU/w0II+bxpanZcQT/ELX2MeQc6GH
 oB7X+pZdodJyDwcVk0ooSXnJH1v1+1aNZVW8+664AjoZ/clREsU6iCtDVZVAuWGweOvDWTPDCxE
 +4YeXkO5DbBajRLXdIy3dDpY/GhlVhF4cJ2byYX1HzA/300Az7EPRIDda9jXHC6iyypdfpqQUUl
 lLOa6Lp8FxSqrElyQmZDZWCExlApQjKIXkrI+95CbXD0WS3HBQUrgOg4tx07LafyvrZr2/
X-Received: by 2002:a05:6820:168b:b0:6c6:6e0c:478c with SMTP id
 006d021491bc7-6d2d034453amr346944eaf.20.1790104896583; 
 Tue, 22 Sep 2026 12:21:36 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d2ce763f72sm646776eaf.7.2026.09.22.12.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:21:36 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 08/11] bsd-user: Implement sigfastblock
Date: Tue, 22 Sep 2026 13:21:06 -0600
Message-ID: <20260922192109.98467-9-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922192109.98467-1-imp@bsdimp.com>
References: <20260922192109.98467-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::11;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x11.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c |  5 +++++
 bsd-user/freebsd/os-thread.h  | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index e87924fbb5..b5178f298e 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -97,6 +97,7 @@ safe_syscall3(ssize_t, sendmsg, int, s, const struct msghdr *, msg, int, flags);
 safe_syscall1(int, thr_suspend, struct timespec *, timeout);
 safe_syscall5(int, _umtx_op, void *, obj, int, op, unsigned long, val, void *,
     uaddr, void *, uaddr2);
+safe_syscall2(int, sigfastblock, int, cmd, void *, ptr);
 
 /* used in os-time */
 safe_syscall2(int, nanosleep, const struct timespec *, rqtp, struct timespec *,
@@ -1175,6 +1176,10 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd__umtx_op(arg1, arg2, arg3, arg4, arg5);
         break;
 
+    case TARGET_FREEBSD_NR_sigfastblock: /* internal */
+        ret = do_freebsd_sigfastblock(arg1, arg2);
+        break;
+
         /*
          * ioctl(2)
          */
diff --git a/bsd-user/freebsd/os-thread.h b/bsd-user/freebsd/os-thread.h
index 6552c60337..dfb22e7cc2 100644
--- a/bsd-user/freebsd/os-thread.h
+++ b/bsd-user/freebsd/os-thread.h
@@ -17,6 +17,7 @@
 
 int safe_thr_suspend(struct timespec *timeout);
 int safe__umtx_op(void *, int, unsigned long, void *, void *);
+int safe_sigfastblock(int, void *);
 
 #if HOST_BIG_ENDIAN == TARGET_BIG_ENDIAN && \
     (TARGET_ABI_BITS == HOST_LONG_BITS || defined(UMTX_OP__32BIT))
@@ -593,4 +594,14 @@ static inline abi_long do_freebsd__umtx_op(abi_ulong obj, int op, abi_ulong val,
     return ret;
 }
 
+static inline abi_long do_freebsd_sigfastblock(abi_long cmd, abi_long ptr)
+{
+    void *hostptr = g2h_untagged(ptr);
+
+    if (hostptr == NULL) {
+        return -TARGET_EFAULT;
+    }
+    return get_errno(safe_sigfastblock(cmd, hostptr));
+}
+
 #endif /* FREEBSD_OS_THREAD_H */
-- 
2.55.0


