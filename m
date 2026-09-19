Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A9AC982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yFZ-000375-2j; Sat, 19 Sep 2026 12:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFU-00035e-Gs
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:12 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFR-0008Jv-G7
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:11 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b1ae6f5fc7so830774eaf.3
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836548; x=1790441348;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DfGCwdPIzmnH06tk/5wQEIrHfRFlBEUm1L70dd0gAsc=;
 b=QXQFBbiDtngXy0ra7moCX6osTQVQToZ19IcTucSe2kNKwayHaO1kcYFnxl1JIFZ1Ts
 6lkQ8jEe6dr0pNiUbRvcMWScc6ZXUcSyz7nZBbcZYcKFgHyinIF7GNETALfsBMDmbiLX
 0A2SbxkPi8RjDhn9xZaMIhQICaSWWOgGeBxlpnoP3lsuqLwAFpqxQLCWllF3J3AcU7Y8
 gskfi9czIGbWQt5+h8+sIdjGqO5VkBc5/g8voD4hKj9xacgO+9d5FqD5VjiGSMPOtd1e
 GPXDa6POsKn5dii2vFuMALaop791q0vACERkz0UuYjxyuxqPdkLpgbyRYEAbTxu07tij
 H5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836548; x=1790441348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DfGCwdPIzmnH06tk/5wQEIrHfRFlBEUm1L70dd0gAsc=;
 b=ND5SRTtW3PSBAnyt84RvyRjQuKPIoOpL1ZaeH/saC0NGugLKNM4LKbkciCvDwkoF14
 L1adJK2utsNWGO6Ofspj8L47+21vwKpe3KMKGCbb0DJeVimRdwahdE0EPim4s+g6uZ2A
 ukiiIxIeuWSoch7HcABZCVYG65tdmVgjq9HUYVjxzcQDL6bA9UkD47ExRxugD9C6wSSt
 SeIv2f2JFJzJZM9epOxLnyt5zeBKs52yERDkW+GOG3eRosO4LkKoEMh9hsWNVn574Jus
 pXDNGQIoCF3NU6U7BqCVgWQB2djBt0r5tWlF3zXgc7qxHvJnSqWgNmH4ZD75VWSQSv96
 Jr3Q==
X-Gm-Message-State: AFuF++nm49nK2kikqrI77DgcrNImpzSDyPjXuwgixZJ5OY05b+YgzBDN
 e2U8FOwmMz0+4zVcp8Pz3IlJNGNhi5oWc2k/hCBnfRIA24E4Vy1s7ENpWddokPi0S2RtSBKhdUf
 7Dt38vzU=
X-Gm-Gg: AYBFou1UgZ3ylpa8KHbmLQXoqx2yZFi3K1HFwVLjsJ++A1T8MB0LL6HXbblWxstQVAH
 HJ/J7WxrK6VdaEHSBEztHe+T5UewdwBAOdEVsy56z9uHeLilIBnjUHz80X9yqV6EO/t3+O5nVgE
 NKopfLs3KYtUlI/KjJGbaH9b5MfpnULh71sFcdiljVlLuUX3nTqvDA073pOPaFgTY+73G0MC7sv
 Jd5UDlc3F9IGLtZadlWXLCFznTYChjfRA1FwwrF8kWmkp0C2gPYVc37QeCiY7IdljNpHVLH7+mS
 TQsklW90IApLlJv3m9/gdT+yNBPnzU0e+odq3LCV+KlMxBZhlalUzKJcjaQnEHfjo6APJcWQ5/r
 9a66+xw8kKiIrQ3i8oD/nWsu6m+OW2MqDCs2Kb/7W48ftwzE3D0iz8+nvtr9KX4XoTawqYpZ496
 8nrxqQGeUWuzlQRIfZAd5/thcSkeDyM6sBE4oMzVc4lOJKA8JYsUNFvKZd934Ab6fPPV5R
X-Received: by 2002:a05:6820:2918:b0:6b3:50e5:c625 with SMTP id
 006d021491bc7-6ca9bf53d7cmr4579647eaf.32.1789836548269; 
 Sat, 19 Sep 2026 09:49:08 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:49:07 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 21/41] bsd-user: Add socket system call dispatch
Date: Sat, 19 Sep 2026 10:47:49 -0600
Message-ID: <20260919164810.70151-22-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:31::d; envelope-from=imp@bsdimp.com;
 helo=mail-oo2-x0d.google.com
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

Wire up socket-related system calls in the FreeBSD syscall dispatcher:
accept, accept4, bind, bindat, connect, connectat, getpeername,
getsockname, getsockopt, setsockopt, listen, recvfrom, recvmsg,
sendmsg, sendto, socket, socketpair, shutdown, and setfib.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 79 +++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 46fee46336..5d3a66e360 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -1073,6 +1073,85 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd_pdkill(arg1, arg2);
         break;
 
+        /*
+         * socket related system calls
+         */
+    case TARGET_FREEBSD_NR_accept: /* accept(2) */
+        ret = do_bsd_accept(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_accept4: /* accept4(2) */
+        ret = do_freebsd_accept4(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_bind: /* bind(2) */
+        ret = do_bsd_bind(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_bindat: /* bindat(2) */
+        ret = do_freebsd_bindat(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_connect: /* connect(2) */
+        ret = do_bsd_connect(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_connectat: /* connectat(2) */
+        ret = do_freebsd_connectat(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_getpeername: /* getpeername(2) */
+        ret = do_bsd_getpeername(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getsockname: /* getsockname(2) */
+        ret = do_bsd_getsockname(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getsockopt: /* getsockopt(2) */
+        ret = do_bsd_getsockopt(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_setsockopt: /* setsockopt(2) */
+        ret = do_bsd_setsockopt(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_listen: /* listen(2) */
+        ret = get_errno(listen(arg1, arg2));
+        break;
+
+    case TARGET_FREEBSD_NR_recvfrom: /* recvfrom(2) */
+        ret = do_bsd_recvfrom(arg1, arg2, arg3, arg4, arg5, arg6);
+        break;
+
+    case TARGET_FREEBSD_NR_recvmsg: /* recvmsg(2) */
+        ret = do_sendrecvmsg(arg1, arg2, arg3, 0);
+        break;
+
+    case TARGET_FREEBSD_NR_sendmsg: /* sendmsg(2) */
+        ret = do_sendrecvmsg(arg1, arg2, arg3, 1);
+        break;
+
+    case TARGET_FREEBSD_NR_sendto: /* sendto(2) */
+        ret = do_bsd_sendto(arg1, arg2, arg3, arg4, arg5, arg6);
+        break;
+
+    case TARGET_FREEBSD_NR_socket: /* socket(2) */
+        ret = do_bsd_socket(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_socketpair: /* socketpair(2) */
+        ret = do_bsd_socketpair(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_shutdown: /* shutdown(2) */
+        ret = do_bsd_shutdown(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_setfib: /* setfib(2) */
+        ret = do_freebsd_setfib(arg1);
+        break;
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.55.0


