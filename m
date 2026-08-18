Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8B5C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwThW-0003y9-ES; Tue, 18 Aug 2026 19:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThT-0003fL-UX
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:36 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThR-0005JB-Tn
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:35 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4a40bcc8d69so362450b6e.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097512; x=1787702312;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Azsv3qhLbzptctKWbtkhLj4TL+z8AzUXZNo0KfCAEzI=;
 b=SHdvO+kFjiKWZhqDM8LbBaFhE+8BnQbRC/DOTQZanEz8ptkJ+wHO4aXOgwO5d1JyDw
 x301/z1vWpcLjCAuIbI3PTupZH1OZzzPr626F0GMqAuB4IbEZQhvLJY7xDEU9JMwVPhV
 MwXddgYZyeVU65m0KT5HrbSKIOEhF7UgHf75qZgXTKuGs28o/+b/JqAjq3qQ3spPmaXQ
 NBdLAWoJzKHQEYrE0WGBTPf7f1aFSmY7vuyMQ7KQqylFLjogxZtTnGfsj2a/jAB0kVUU
 GXnAr6kBn/uydcBWRrOHozdMXakURzwIgFgf6bnS7/vxdk+BBG9id1+iSBOnGwa+iXBA
 Uh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097512; x=1787702312;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Azsv3qhLbzptctKWbtkhLj4TL+z8AzUXZNo0KfCAEzI=;
 b=TA8y+NAKiz0F3S2S6TDJwFLE8a+HOnd9gYcUEfN4zFpb8rLfXWGQXQj7erDUolLC6M
 go9MmnlUjoG2u45OUO/HrPpiW5eJdFPHMg0Osn1qt9GmRk3AndPhc/D8Od07wLYDpe3S
 4yHSVJP1h7kb+jaiOozi2amw8HGY0lFLaFWHOBPR3xVxx54akHmaoCWzOuRGMPpOD/ae
 fxL1Ds1sRJGpqSyfpSf+revdSfZEvasRGqOu+0JF063Lhuj1VZOQZe2H+Q6sWSICclEn
 K49DIP5T3VO3CQwpv7Qa3Y/67Uz1r5NA+MNnbB3Nqg88IgXEg6HMWQZzOxyqoKDOC9P/
 izZg==
X-Gm-Message-State: AOJu0Yy+Ocm5aTydIRCm/2w5u7bN9nkuiOap1y9j+iHMROvm0KrBRAQe
 Q2Ftim9hHVVY4miTG0JluCMBvd1gYhL+XOmuTSnqFe5oHeL45MW/0AmQhsHScKHk2BQ=
X-Gm-Gg: AR+sD13kuepasCKdWUtBzoThnqXRteWoiq0p/ShKZ16hgwP6ijyyCao9ZqiXj6fwpym
 ZqH37Hk0Ar8slXj/keOY1cTY3VSJhJpbltleje+WisUaFKMcDBcdyz3Umqp3UiUd5fpdHx/XAEs
 X9MbgO1ZhgCq/9TX00BUZ5XB7+gxOEYb2NNUEAqjTP3Npjn6qiEQHDDsGGkiAVHS9lJdk5agOOz
 cbrtfykwxOJBy7zgb/IkKKqwXSApGn2h35FiumYdh/1l8UW/GJ1c3UHl8NCVGEtWjbm1aEkCndu
 TW30N6y7YVRkDRwGbWv/TWXTpWEnZyroe0tw9VCVc460zixchYlnuD5edwPO/TRhvVPrSJwz9NP
 l0Fnt+ma9mV6tVsqQQo87o4uhcT1mksSxzKWxNm8AjatPpsH9/mfG6YAdtpODNgYdT5568AFAvr
 igS2YVoRHMr/ug8EVd4pWEZCGyJCxFUe3eTQzzuV6xb2LR5Q4=
X-Received: by 2002:a05:6808:1456:b0:4b2:8e21:622e with SMTP id
 5614622812f47-4b2bc93d92amr388716b6e.1.1787097512197; 
 Tue, 18 Aug 2026 16:58:32 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:31 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:24 -0600
Subject: [PATCH v4 31/40] bsd-user: Add thread system call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-31-09bf5647c98e@bsdimp.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2758; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=PWFAmfJfGmjr0/aUNssCFME2ZDWecQP0pJwLKNnAxtM=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPFQLJ3bpgwtJiCxjb0vkuujAeVkmsFZAMFrx
 XrAkIfHk1eJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxUBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBqaQ/+L6jU/uhhG6V8gKypS5y9/WOGSg1ruUa
 sXgFHhDxPcwbK1ltJgLJCHP5dgYIbZboAPSU/C9BBNtJpagDa/AO0MHJAhstBqWfPr5lJcG4W5o
 NcEtOGxauk34oBBkrLn2WRithRviIis8jjwgauG2K8rX7kJZXPP4S1jfJjer3sav/VFRCXRI0rs
 joZ1P1oCKIxlwh0gq4ejwWbijtQUjVYOO+U0WFIHKsMcboDQHerkfbkxiWC3fXMiWaZJ3RojelR
 o/1fN1pWsf+bTEMEfdXXwIc8QjqAmo2uVhHOjorxbmnoMYmvHIsiX46nZ8mY1xXitaVn/vq9nIR
 54iqYsz4/l4y8tZk504Gy4hbqKuhF6iIs5Uv4PTNEx4POXwOK7oxVbZORwhrd9gnVG+woPoZaXh
 +NOzmyOqiMjCnBgNprxjqDi4H8i7LlnJWBpNg884Tl5fd6CxpRorE6AXaxUTGLK1X8WQa/9x2vl
 zWbxHGK9nYhDSFKcr0nqXyo7u+U1w6FZA5801mSs83ceTB3sgygGeXtXKYZVkI3u6qEhcwSiNXj
 N/gJUZ1nF+D9ZNU/Fwu48IT03E+CqLn631ao/iNAwHpXDsYrpo01pgBNP/r77nryEmS0+xMyjvD
 cOJGQS3x8Y2zVxMjolMQetphiNd+aAzpyxrU7Zt3kbcTi27GWjoI=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::229;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x229.google.com
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

Wire up thread-related system calls: thr_new, thr_set_name, thr_self,
thr_suspend, thr_wake, thr_kill, thr_kill2, thr_exit, rtprio_thread,
getcontext, setcontext, swapcontext, and _umtx_op.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 55 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index f2c3ff25e8..0c729da0ab 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -1293,6 +1293,61 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd_setfib(arg1);
         break;
 
+        /*
+         * thread system calls
+         */
+    case TARGET_FREEBSD_NR_thr_new: /* thr_new(2) */
+        ret = do_freebsd_thr_new(env, arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_thr_set_name: /* thr_set_name(2) */
+        ret = do_freebsd_thr_set_name(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_thr_self: /* thr_self(2) */
+        ret = do_freebsd_thr_self(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_thr_suspend: /* thr_suspend(2) */
+        ret = do_freebsd_thr_suspend(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_thr_wake: /* thr_wake(2) */
+        ret = do_freebsd_thr_wake(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_thr_kill: /* thr_kill(2) */
+        ret = do_freebsd_thr_kill(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_thr_kill2: /* thr_kill2(2) */
+        ret = do_freebsd_thr_kill2(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_thr_exit: /* thr_exit(2) */
+        ret = do_freebsd_thr_exit(env, arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_rtprio_thread: /* rtprio_thread(2) */
+        ret = do_freebsd_rtprio_thread(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getcontext: /* getcontext(2) */
+        ret = do_freebsd_getcontext(env, arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_setcontext: /* setcontext(2) */
+        ret = do_freebsd_setcontext(env, arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_swapcontext: /* swapcontext(2) */
+        ret = do_freebsd_swapcontext(env, arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR__umtx_op: /* undocumented */
+        ret = do_freebsd__umtx_op(arg1, arg2, arg3, arg4, arg5);
+        break;
+
         /*
          * sys{ctl, arch, call}
          */

-- 
2.55.0


