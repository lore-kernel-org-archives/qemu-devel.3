Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DC7C5DF7D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTgg-00022W-4Y; Tue, 18 Aug 2026 19:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTge-000201-Gn
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:44 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgd-0005Dx-4o
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:44 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4b190cdc9feso380629b6e.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097462; x=1787702262;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uNfk2u0RGhpCzN267GPGuMQc65uLjr+nZWGb3qRlYsU=;
 b=dFBN1dC4HE555eyOnR1h87oHHWPM+SD12IT9dJdVT83w/09flWYztSkNH+7LmicqGy
 cVGBwP6IB4FqN78AQ4CR6R0Cq7r8E3KRwgUFDd0qgRkaY9/1AkPzEWwLmZRHBZrKgqS3
 JBAe5XwAD2Igdvrd3s10lqa9YtxOrZoQ+SvGr2gABZNOOKQecabFgFOR9YAtw3dPXsT3
 tr1vsrByPyimE9gI1XiKiB38E3lMQqlsfqKLOj6h3Z0HkgK7YueQbRw95VrPWj8BEKSQ
 KWeu2kP3ChzMyHaWmvNWT0MmoYu4bpxr8Fa+8eiv2yjRIjfiGGErO/mqCdCS1lsjEUQN
 HT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097462; x=1787702262;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uNfk2u0RGhpCzN267GPGuMQc65uLjr+nZWGb3qRlYsU=;
 b=ErTph536T2vv5AKSQJQEFzwOLGddVmr6LgY2e5psxaWayfDKeqtQCU3Llt9hkiUaQe
 XE7gHQz6WPfvyNWs+ZruRcbywQrn3QGbbeY/vQmGn7Ozh/7AyCHMgzWLhptzNMS+2CJC
 gzIeTtyDeCx08dTbk92eWBWphwXyc5zf3YxlVI9ZVkdiNwjAGwB0xXNdpHJ8mvZKMoxI
 D0bEMiOUFXQYVS3CNER0kiKdkgLt4oi9pe3nyya7kff/5bU7KRZMrvcQe/jiFawpMWUI
 wWBQXxhvv6q1XUTsOJl0YQu4swt9XCSFTJXat97A/Tck5HDWpxJOU3A89UJa8OTp+o46
 keoA==
X-Gm-Message-State: AOJu0Yx3Oa/HJL1Xu2urtcWf8P/OHUeJT+0r2khBjqkoRC23SoxqGezL
 /XjZIKdBYhBCqz0YvCca+DYUQSegLV2dgn/FPNcUi1WKo9E699TYOqrRJQSHbXEroec=
X-Gm-Gg: AR+sD10MqsffyCL+FJ8Q5BbF4p9wSjSCUddIZHnlJ5nXdcUm4xX/JFoJDszKY1xe1aS
 g/5uyb2f/gOoE5QiF2ovPqE6UkUeXKO725sXtmjKmGeR6Q/3/q3OXW5LmbU/9TPo1WwJRzHyxMi
 u8iEueihNKdog+uuc/FptrgjIbhxfVISX2ys4BP/Dq07X4CDAhAnFn7ERnJXnmEFxeLuNhxl3u7
 ZKQ3IEFGoXkEEkr579E3y2fJfGx0u+eqS0QFHDP+udUK5hWIXb6ZfkwVrh3wclYEHh1XHcKMLdt
 1c9qlOpxIFG87Wq6nT4emtMLMd6Qe3FOkuYkdFVVUrPrppysSvaAxveCZUxaI1m7kTDNfuqtCKr
 QCJLq+w2lbGr8hiXQvi/u+rq2uWey4ocSrTNcNN5LuDj1J5IJu+Ib78i8AfmXcBM0Phh6HSKI+i
 xT4/7290RYg3/I3UrOfzJwmZxC8M55sBN00xUjm4N+H5/grdQ=
X-Received: by 2002:a05:6808:198d:b0:497:da47:df4d with SMTP id
 5614622812f47-4b2bcbb6acemr330995b6e.16.1787097461897; 
 Tue, 18 Aug 2026 16:57:41 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:57:39 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:01 -0600
Subject: [PATCH v4 08/40] bsd-user: Use target_suseconds_t
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-8-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=PtCMEanQ3MZJnYzIGAK9fNWKJ69JoNE7DZmPQcTbkJw=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPEqDw0MEjRxLjauJD8ksHQ2btbIQSuC8vgaR
 5vxovk8eemJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxKhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQAU4xAA2VyTbm7XQ/rOBC/9R4tV//gWgK8WG+H
 XhPpc3Fr/F95Z+WN3bjumCXZavcfK9EXwCp7QDn2LxMbtwmY+NT4xmPytQJgokiGfIuojzcCnM0
 qUbDY2fdSZ2XfNzQmOJmStAQ3FmIPb/kGSWGdjP0eEjVcjmIlPmXaiKQCsEGhcphohnX6+SwizM
 jlqJjy8TJuCHHXoamAohxG5KGJrwsUZvZVImOgCq+kOxDkpDY4tgW4lOYhBGn1Lx1Sl2XXBedvn
 BqlIm1PH/RA+sgcUt3JY/z0hp8LMy4fQuSPSEsbLTZKwhitjx+90xbEagWY1JMMKEoj5UfB8Jf4
 gOtUfsq6txGiWcnqMvJ+5lHK/cnkMm/FPYf0iY7iOzvMseL4em6fBbPENcyK89kxPAfuZ5DKyMt
 8FCj0fKRxVU3jx7ZTq7bJx0SbD99OCyo4lPz8bTo3YB8jBUGQx0y2DWgHKUe2+fiyOWGd77dVaU
 r4ib2vejtgDbe0VQK6968/sTL+sJatLD3OZSyZ6TgucSrCy9ST6guwA/Ar1RPm6vCBwOR6hCZF1
 BhL0FowZ991JmIkVp9pUMr5ve9Xm6Udgw/7kP7AIhPwqG3jWHyNmdZqfdt32+HEIf0AuExNP9zy
 uhqcRnzXIDncsLnrsLWlyG+qhsK6quwJFMDU4qUnPHj07Li7PVX4=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22e;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22e.google.com
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

We no longer need target_freebsd_suseconds_t, so use target_suseconds_t
instead.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 7646a52744..4af79669e2 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -128,8 +128,6 @@ struct target_msgbuf {
  * sys/timex.h
  */
 
-typedef abi_long target_freebsd_suseconds_t;
-
 /* compare to sys/timespec.h */
 struct target_freebsd_timespec {
     target_time_t   tv_sec;     /* seconds */
@@ -151,7 +149,7 @@ struct target_freebsd__umtx_time {
 
 struct target_freebsd_timeval {
     target_time_t       tv_sec; /* seconds */
-    target_freebsd_suseconds_t  tv_usec;/* and microseconds */
+    target_suseconds_t  tv_usec;/* and microseconds */
 #if !defined(TARGET_I386) && TARGET_ABI_BITS == 32
     abi_long _pad;
 #endif

-- 
2.55.0


