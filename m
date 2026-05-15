Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7434FCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzyB-0004WY-MT; Fri, 15 May 2026 17:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxw-00037Z-FN
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:05 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxu-0003Bk-RF
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:21:04 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7de7c57b52cso298918a34.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880061; x=1779484861;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PW08fDBi+WkYVgPnXuwlMTIGJ/Vvzyv0nYTxtfJ8C20=;
 b=Swl6MDtfshtRovw4+hrujajurPjPShFfAX1Ha9m5IYfQHfaVfFPmGYlLdMorsG1hOG
 H/xDV4oIoZL6vw+0Xyo8uYhRNv3TDN/lB2KkfDos/3ymquP7idNu1B7UAF806DhufWM9
 mRYdnofzXD9I3FRinLZ7949ZgfPf9DuUws0MnigOIz2iKQQzwtWOmVQUsf+0V50hCVQg
 JHP1yHn/Me31mqcTKQ3Xz5V4z7cfiGpvBWDTg8edh0YUJY3+EYooHERXkgzhAMlJCuTC
 Uzlnzmk3rBawuyD/1p2/gT1pwK/5QF16h211GR8ndAPWC8ilYLzCgRsNWeb/SH+IBVtd
 kmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880061; x=1779484861;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PW08fDBi+WkYVgPnXuwlMTIGJ/Vvzyv0nYTxtfJ8C20=;
 b=PO6/bfrU0sCjKw3aogaU0yqR9MJJV6Nn59ImYJfMtVkO6CXY2aqZgPa0vyNfJ3ORc4
 8deBgM4Gu02ihaR4gcl5Ei4XaCRyvDqYNJQx0LAqM0WPjUco3uFJxrX9OfV9FicDulCo
 0wB9TGZTQ2hHP9Ed/IasMie6Yo44uHm8gk8+P5wAJJhoaFUphKP4Gfd5iFZo3zGODyBP
 XkF4sHByN4vSBIqfx/Sz+dTcFiCr+g09uiu//DxdJJ7LBju0PYNIzS9xJHMwgxEKmFEg
 JcSzI0YtjwBfUpY9NScdz/6CCe9jUo2j0tGK2RVZyuBwDQsRMjHA/7JHMK4VMqsZBvQI
 MI0g==
X-Gm-Message-State: AOJu0YxAZ5dmy1JbOqH0NCOfLJc8HeVU/6WcOlRPziN3YVkYbvTNcF5p
 6dnJFul4LMDTC/xidpLfTm32xyFJ3Z/KT8pEQ3H79wm3230Zm1OeiCevrfk5V6tDJIQYjS5JGGz
 gVWfuaSg=
X-Gm-Gg: Acq92OEA/JWrTd5FHwm+Xrxx4J43yd4So/cM92g/6f4C/2CIQ6cP8PuaHg9jsECHOB2
 Fc6yZnfKqpNzH0Q4yhvWISViC2SsZPABUbCcsMVP3X5ql1cCnfWA8xpxRt4gejMAMGG7S/uzN6Y
 7phy1vNKnDFn1GPQMXwy2enCjhh1Kyw92d0qDLwwYvEAjSfwABWiTv5kDXLRwPlKKYFkQuspzy8
 8r9dASFPaXdeE6ASUlaJBxnqz2EuGucRnxOJvSqs4oKLGTPhDa0wXBBHfTogv9fGMJDnIMzP9oS
 hJEY+MnlScuxLHRwqMAJu/H1vs++wWIRF2ehIe5czxeIHZt+2jiBgR9Mm/U2Du1AZw6Ik+cbWte
 6408x0CmhCcL3mWb8srdJU6SB7KxaQnT/ZGKy/Vdgp/wxPK/RyxDU99zoz79908ltSWmlU9xpkr
 9WStUnlsAEn6abYIDVdCvM
X-Received: by 2002:a05:6830:3812:b0:7e4:230:96ca with SMTP id
 46e09a7af769-7e4fa05a5bfmr4300228a34.21.1778880060493; 
 Fri, 15 May 2026 14:21:00 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:59 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:55 -0600
Subject: [PATCH 56/66] bsd-user: os-time.c -- Fix copy in time conversion
 rotuines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-56-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4164; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=UpHDOK/W2Mty/CuHJEzgqpBYAYvdVYEYL6hNdUT39t8=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43ndrohkmdIAfupQvp+GJpKjY0urHnIFqn5N
 QI8kad4DNGJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5wAKCRBsHNEofbAR
 AFR3D/49CXgFQuxUxgdc6c3v2Zboqd/prqJRCoayAEb7pE3KC9W07s82OjD3aN2HWZcUZx+KgXb
 6GrPBM5EtQ3uni0C43VRvyn4zQbXdpTUbL8uNkrB0tHITbb3DYVeVCa2cdFarR6SKSSguimxO6x
 bKWlEqMmsrsipc7qvIMHasyDZQE7hlwcX/K5Ax7Kb5W6MzI812Z6mWjIa3yUPuZO9IJMs1mLLBt
 3SDuqLAlnHMWkONliIHDkuZewUmgT38F8rPmtkgojEsz0Tye5u7gYeVj4goVmu5UhsPuyw1bFLO
 3A4aTi3iOUxJHk+/8VcMFn2iLl373SslMfeLOee4oGOVy3gEnVEiLXNsdoZ2uBsOHHDMfN8l5Rx
 /I+asLW1WWsUHlAfeIWMbMt4y4X0D/e6xADeDcAXMfWPiyjS1jIde3A5z0Mo2Nfv61djlKwU7qW
 VSAvmA6o6kY8fcA9XtDnRMQI/9DW6/tSEA55wyDXFcGiWgB3l6JsuDFv5DBHLO5b2YerEEV3Pns
 JakdsFIom1/FzAANtlZiloK2KkVqNEU8/NQS5dEcSAlBrgMk5rt3H+Xrlj49VBsoH3JwnlKgRuv
 2utI0VFrUB/p4fQbUfJiwhEFGzlGM/sP2LNkvUFPnLjXq7GDlX2kAIvH7F0fkIzLMnjKTl0gb63
 k676Kwvts0KtV6w==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::329;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x329.google.com
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

Many of these time conversion routines either don't copy back or don't
copy in when they should (for reads) or vice versa for writes. Correct
them.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-time.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/bsd-user/freebsd/os-time.c b/bsd-user/freebsd/os-time.c
index 2dba352b2d..5b7c05ceb6 100644
--- a/bsd-user/freebsd/os-time.c
+++ b/bsd-user/freebsd/os-time.c
@@ -24,12 +24,12 @@ abi_long t2h_freebsd_timeval(struct timeval *tv, abi_ulong target_tv_addr)
 {
     struct target_freebsd_timeval *target_tv;
 
-    if (!lock_user_struct(VERIFY_READ, target_tv, target_tv_addr, 0)) {
+    if (!lock_user_struct(VERIFY_READ, target_tv, target_tv_addr, 1)) {
         return -TARGET_EFAULT;
     }
     __get_user(tv->tv_sec, &target_tv->tv_sec);
     __get_user(tv->tv_usec, &target_tv->tv_usec);
-    unlock_user_struct(target_tv, target_tv_addr, 1);
+    unlock_user_struct(target_tv, target_tv_addr, 0);
 
     return 0;
 }
@@ -52,12 +52,12 @@ abi_long t2h_freebsd_timespec(struct timespec *ts, abi_ulong target_ts_addr)
 {
     struct target_freebsd_timespec *target_ts;
 
-    if (!lock_user_struct(VERIFY_READ, target_ts, target_ts_addr, 0)) {
+    if (!lock_user_struct(VERIFY_READ, target_ts, target_ts_addr, 1)) {
         return -TARGET_EFAULT;
     }
     __get_user(ts->tv_sec, &target_ts->tv_sec);
     __get_user(ts->tv_nsec, &target_ts->tv_nsec);
-    unlock_user_struct(target_ts, target_ts_addr, 1);
+    unlock_user_struct(target_ts, target_ts_addr, 0);
 
     return 0;
 }
@@ -91,7 +91,7 @@ abi_long t2h_freebsd_umtx_time(abi_ulong target_ut_addr,
         struct target_freebsd__umtx_time *target_ut;
         struct _umtx_time *ut = (struct _umtx_time *)host_t;
 
-        if (!lock_user_struct(VERIFY_READ, target_ut, target_ut_addr, 0)) {
+        if (!lock_user_struct(VERIFY_READ, target_ut, target_ut_addr, 1)) {
             return -TARGET_EFAULT;
         }
         if (t2h_freebsd_timespec(&ut->_timeout, h2g(&target_ut->_timeout))) {
@@ -99,7 +99,7 @@ abi_long t2h_freebsd_umtx_time(abi_ulong target_ut_addr,
         }
         __get_user(ut->_flags, &target_ut->_flags);
         __get_user(ut->_clockid, &target_ut->_clockid);
-        unlock_user_struct(target_ut, target_ut_addr, 1);
+        unlock_user_struct(target_ut, target_ut_addr, 0);
 
         if (target_ut_size > sizeof(struct target_freebsd__umtx_time)) {
             *host_tsz = sizeof(struct _umtx_time) + sizeof(struct timespec);
@@ -115,7 +115,7 @@ abi_long t2h_freebsd_timex(struct timex *host_tx, abi_ulong target_tx_addr)
 {
     struct target_freebsd_timex *target_tx;
 
-    if (!lock_user_struct(VERIFY_READ, target_tx, target_tx_addr, 0)) {
+    if (!lock_user_struct(VERIFY_READ, target_tx, target_tx_addr, 1)) {
         return -TARGET_EFAULT;
     }
     __get_user(host_tx->modes, &target_tx->modes);
@@ -134,7 +134,7 @@ abi_long t2h_freebsd_timex(struct timex *host_tx, abi_ulong target_tx_addr)
     __get_user(host_tx->calcnt, &target_tx->calcnt);
     __get_user(host_tx->errcnt, &target_tx->errcnt);
     __get_user(host_tx->stbcnt, &target_tx->stbcnt);
-    unlock_user_struct(target_tx, target_tx_addr, 1);
+    unlock_user_struct(target_tx, target_tx_addr, 0);
 
     return 0;
 }
@@ -274,7 +274,7 @@ abi_long target_to_host_itimerspec(struct itimerspec *host_itspec,
     host_itspec->it_value.tv_sec = tswapal(target_itspec->it_value.tv_sec);
     host_itspec->it_value.tv_nsec = tswapal(target_itspec->it_value.tv_nsec);
 
-    unlock_user_struct(target_itspec, target_addr, 1);
+    unlock_user_struct(target_itspec, target_addr, 0);
     return 0;
 }
 
@@ -293,7 +293,7 @@ abi_long host_to_target_itimerspec(abi_ulong target_addr,
     target_itspec->it_value.tv_sec = tswapal(host_its->it_value.tv_sec);
     target_itspec->it_value.tv_nsec = tswapal(host_its->it_value.tv_nsec);
 
-    unlock_user_struct(target_itspec, target_addr, 0);
+    unlock_user_struct(target_itspec, target_addr, 1);
     return 0;
 }
 

-- 
2.52.0


