Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BF3C982DA
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yF9-0002px-U5; Sat, 19 Sep 2026 12:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yF6-0002pL-4v
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:48 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yF3-0008Dp-VL
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:47 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c17f382ff5so735487b6e.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836525; x=1790441325;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kYUlt20I8KHIPYiSRmKgCElsTxWsdBrolVifzGqZwc8=;
 b=qHXYbg5Oc8PCjWSE4qameJm3fk+TOIhQKEQttJi5n0CqMfqKnKDzAGt3Jjcf1qNh9r
 FCy7f+8hVZbm+VK531bu2SBhZiazXUVNSUwhkb7KB67/7fguavrVmDq7IlyyXDpo+XVN
 QTKTLpp80XVTWZXWnec/k8ngEVuoGdXM7EulrmXWz0Riifvn7nU1skdOVWJE4XU4Zdsr
 O78lSvsT5tv6PuOulWC7jyqyzcmkBlW5pJ4+hojIcfwVPPa7FHJAHpbM/Hs1Zt1TOoh7
 wPE97Ak6y7QfLkYd81cXeHO16EFQ5b/DgDbulrTffP8mJJ5lESMcY/ZovZR6VXzsVp62
 leyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836525; x=1790441325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kYUlt20I8KHIPYiSRmKgCElsTxWsdBrolVifzGqZwc8=;
 b=qjImlfz8r4Kjmrbb6851CywAyV9UXWw1rX1j2FZZ3D3VKBzMZRhghKDe7buMqfNC8X
 Vl81wfZRx5bkf3pZ+pt98ZJEH8e79Y1ZUOQWFxyq6TczvGgrJ86IYmwNOorI6Q3KErpg
 q1k2/WiOsxkarPmV3aPTVPpcSVVX7BqcyYGQOcTb2bRj/cyYZkS6VlaWjoYEKrcfKC9+
 j3S75ndvhMAaupifsmPb+qVhtpxvzS30dsBKr39d7anJpJLDPGCYSfzvh72qfMGIkXXQ
 /qOyIUiTN5ccLEAw+X976LsR7v38kawaUaoCKBeAtnNlSgLKc59LupEcUF5zy2zrkzag
 0P4A==
X-Gm-Message-State: AFuF++nxRLeLJr8IzqXC2pwT2zTIALPgvMTR2/o0JIfxfZeRg90HaKYJ
 IIeHeUy1WgYIIUFtOzTijSPtBmH29DWpdi5LHqVqR3CLdm/KICxQTcyxZdW9slQ47DYQX/R2WpS
 /Gk5NgKw=
X-Gm-Gg: AYBFou1ZRdh6zDVXdYwOnTVTEPb4ZBS0gym3nqilEspfVCzBqafhvdaCyE9wlUYU1MT
 jPSULNj9VvP1NW9Xpq8fOmtjLCEBstFuCSV7nHRy+gRFoadheqGLILnX8wXKiYEHKZUgyeK8Jg7
 +oV/qy1aRAzxcJhKDhcICXZUN1RK02hAVd/6Eo5rtlEyhlSgjDqAZzZD35Mh/xebukKzKpS0W8N
 u+J7l4vL0rKMS/vrgOlH2CKsUxBwaYigsA2/4yQ1dCW34TlHHQwPeJhQdfk1kuNV0zrQws6PjWl
 RZWGewnj6offfZh0HYFPkCFqxxjNH+XX1FX3KMWvHUDXF2+Vy8CpI3KTA8hf4M+RBplZ6PKaqlD
 MJQre+dRQEcmLjvsIVUjK89SZYosAjpRoMiX6HKT2qBdC5jLKR8upKGr0/xwSGrmiwFeapiEK2Y
 64V4nmv+SPZpEO4wEvrery9uC5WD1qxUVJ0PW9UkUpLmjInzsrBK7+WSvwM5g4FFJ6Ukd6
X-Received: by 2002:a05:6820:1807:b0:6c7:cd95:f106 with SMTP id
 006d021491bc7-6ca9bf49bc0mr5089042eaf.31.1789836524727; 
 Sat, 19 Sep 2026 09:48:44 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:48:43 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/41] bsd-user: Use target_suseconds_t
Date: Sat, 19 Sep 2026 10:47:37 -0600
Message-ID: <20260919164810.70151-10-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
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

We no longer need target_freebsd_suseconds_t, so use target_suseconds_t
instead.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
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


