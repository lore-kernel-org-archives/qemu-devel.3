Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB352C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTh9-0002Em-0s; Tue, 18 Aug 2026 19:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTh5-0002BO-IN
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:11 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTh4-0005Gm-11
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:11 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4b28db06775so314963b6e.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097489; x=1787702289;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rgEPzUg88M3QnVNTgGZyRzTnSIXE6rtmq8dv27La6po=;
 b=D7HaP2z5/zwRSLvLPO+R5FOnUGgGiHE8cRxIbKj+HWqW6zty02rFG4r3uHrDGOhM4F
 mZJahcGpIzqh5t49ORKoW0kxYJj1e+5aUzZ3e8VKcL9Rm9/81q/+X0dZQ/uVXspuGO4p
 ipxyEAMnHASM2wG5HEyGMKUy1yrZuUJxD/7LsVBCVFvBj7mzUaQJNV8mFKP1P+jpFxiL
 ijXh07I3S9eCW577Y35FPn3EDRAAjVq+qz5EymAfPWCd3LMqCOdfgFDmfBkanCnvVL4H
 sQBQBm9rjKEvh9l9Cgvs274IaaiVBe7RAo1KdGw4Q6j5Tx/MlxsbemrqUUZH3aBWeSJ/
 xJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097489; x=1787702289;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rgEPzUg88M3QnVNTgGZyRzTnSIXE6rtmq8dv27La6po=;
 b=DUfcq0QhZHNjBJa1qPfPlPbfneSXkThMO/H+zkQY98EO+yDyRj0Xc/QZs6XnOok+Eq
 abcwPIVkXvZ+IiI2NYQX0rQC4quZzbwIBRj/9ip+YMN4pHAjhB/4Tnndjh78d9J2HDqq
 pu9izK/sEcEIU9uLSxZ4ZGD/+NGMZ5gLyMd8g3thqovIEFgboc4dijYAEP6PYjtp8EQ0
 wN47MnEzdEQyyctLSumxFohzyud7FeltH6YoBHvewfNxfSs9Elk2akxcA06z7FSooI9N
 KKSrx7dmIwNfaY0XnJfjze+qYEI/c9XRfKlxyGF7ejljiqbUanIGJVqDyBHXqEd7KqqL
 avqg==
X-Gm-Message-State: AOJu0YziAcO2arOStjDLQGp60MeJ+EEjvm9Zib8MwWH0eSzM3L+3KHIN
 fHOSQLpUQJd1xixeV+qZYiw/b3j0ozSAIvfI2mjGKH1QeeiHyJbe0n+hKPACPf2kr6Hi7JQ6e2A
 50VZXej0=
X-Gm-Gg: AR+sD105Bo/l1DtNKCFT3v2zuk+XUtsadLJ34C+sIMAorGiEkWmF2KuQKxSmPDRMTba
 4Li+oEwhDJSG5txPOtdARgQSEvdqB1xmol3gDjRJhcvwt6CvDHdpo1pX2tKgMuDb8ca+Suxjte9
 WB497YLKJ7remUolZjD63G3QUReZKj3JB1Vr9DKARZrGcp/Mt5lJq0Ni6Kzyy+Yn7jlyeksbFR9
 DvXG2cvEuHgd4d8IIKSdtQBFLGVf5EUotxNECiRWSTWp/I9k+BBwC3kXJdezZRfNH+qX5OBP1kJ
 KSjBOLWUVAKyEsnCotUltdyogYytgrpIgjniqCQthiOZ8yZTXB+B9jEFW/Ub9HhYf2EZdtKvriN
 DfS37fx6m5iw9sBkbc0oD1Zbxr4TJZn7xSn0baU4pIlA0YOdLIVGQ713gPS3DR8UoVFQeg849tM
 pTbeJBOLasZraErlMxLtBgmrPDTWZ0QmnmL0oN0JKNQky03bE=
X-Received: by 2002:a05:6808:3990:b0:4b2:21e2:82d5 with SMTP id
 5614622812f47-4b2bca4ab33mr318740b6e.10.1787097488959; 
 Tue, 18 Aug 2026 16:58:08 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:07 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:13 -0600
Subject: [PATCH v4 20/40] bsd-user: Add socket system call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-20-09bf5647c98e@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3690; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=J7YaSfbDYmF4putWqYCInx12O3KyzUuhNh+0vRKoqyo=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPE+BDE/oDtyEwEnOxq1CAvWCMNMMeBXdsBOm
 tcmUl1AFKOJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxPhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBc5BAAxuntb+IJ1y0iOZn7yhxOGlXmrv2lzAp
 LjaHzF9e/x96v2ds5ymE367KewL7/9TMgeYyHeaqg1CXuCIsbW8pJV3klMH/6nRsWe1ZSVyT/NF
 ihkaX+y/7jpGhnKZe9mCudABcfatL6zOlnHfNR+3lequ5tUOg1y85m8C6XzeWSdenSGEMlTpaS/
 dA0qq0Fg6LPO9VEMPopW1TVGgFAoCIxjZj6ftMniAxMkg1HkFkE9TeqjlBJATIdRlRGZY/058Ai
 0HcC4r5mwl76S4IP9CyWr4uasGzL22tpYc2UtbJOx+3YKzoiVNLH8/2L9WwPQssEEkv6KViqcZU
 kbffK0vjRjJ6OAS3gXXvwpBJhDV1kienbLRxyENmjK1F1JhqYVMvzpbUN/ksPgQ+XuDKJwEa7OT
 Nvp+vKRqfSctPMCeETb6hck44yXbJ4aztd4s04xapnslaZ8/7fe/KRgf8uNdAYM2Oi7Odaj4tuy
 CpW6BhN6ZN6dnMf8vbL+ZS5iGfoFFfWYHG/IyeqDQkGI25cuJnIiAfsnU3faUY818Nsf6MC5YkD
 ZxfgfTIXjxZEpSg3h/UFAm7ZNQ2zb2Y/P0YUmjrHzqu6T6504QfMdTRrc1+HCsz1v+2PUCPQ/hw
 L6I9H55GUPR5tWNHt2WiQ0+QM/ZhaHNnZls7NkueyqtnKPdmfOCE=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22d;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22d.google.com
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
 bsd-user/freebsd/os-syscall.c | 79 +++++++++++++++++++++++++++++++++++++++++++
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


