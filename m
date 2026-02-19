Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F504E9A04D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswVN-0002yk-UM; Thu, 19 Feb 2026 00:23:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswVM-0002y0-Bd
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:23:12 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswVK-0002D2-5B
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:23:12 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-679aebf4e56so306215eaf.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478588; x=1772083388;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jYGackA2bkmDICDd3P5+WxF3zAx2KI4dveSgUpAz0nQ=;
 b=H6cajS+7sJ31pt68RYLKQ9YoqeQrHBVsizllN2Nb0rcAXQcXB2ZjTqz+gJamqjkZC9
 DHtMTrfSqlBy2N0ML7GwqdjH3VxJKFI6h1rdxdlCnZ6uVRAJZUhbaAyKApMpQTlFQrJY
 qc+liPNYi/YoIpZrLf/Lv/XK00XtSwRCVOJO/OaSUhoxs3ZJhSpA9MZTxXKKpt1si/cJ
 wOLnEN0kGNWdL9v9bAnOizvpjUaLRmuG1keLDk21Rjr5kKqZ+6bzqwJ+l5LXavoPDFun
 kCb+YQVW0g70Q+XkkTO/8f8vuYM5UqMYIBGS2UeoGzs5o/1h+Py+L0PsQq7nQbmqYSDF
 mZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478588; x=1772083388;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jYGackA2bkmDICDd3P5+WxF3zAx2KI4dveSgUpAz0nQ=;
 b=Rm37w/eUoanoXhB8bSvebQ3IWNZrv9KN2pij6gshPB4s1khYcOPRZruCp7u/lRQj/p
 +K0bOoHDk+5nnF+bDdRuDqjKjGv/oUXDyMfPKSBoYnCq/zEfJV9pKySrim0apyyfpziG
 1sYBepzwej6ZC2u364jPxq9ahVk6TFxnFpbQg8B8PJOrxN8UTHGA3usZTE48xRwljV5c
 JZ9P8xvRWRYAs0Uel3vdHy1AJxWGHZPWdWppCib/w6iqiMr/CBZKSSXTlqyLdofyChv7
 Fc2r6JmsJZd1+llKZPleEa+7kv0XU9mTwWpv4lNjHGsW+FXVu40+iJ9capcZaETIi3qg
 GD4w==
X-Gm-Message-State: AOJu0YwXkutWWcY++9+TLOhyz90NLInSmCxa4GQugZ9/vmdIBFx0EwkG
 0tXvmENR5tC0jQ+nm+2EC3iMNN6GYTlYITNPEJc2Yn1Cc7A1wfMqFOr7tB73CKjdOlo=
X-Gm-Gg: AZuq6aJPhmmDEAXy0DmYJqjubcH9Es9Dgh/bKIEI3eaIgZ+FKMETEHz240zol1/NXGv
 thyBnc8KnwG/bO8RAr9fpGzK+KwzMyiNdjVaJMjVPAXLFgwlZ+Rq7GuMgnuUgeZCMWWH+Bn0obE
 Fp50wJW6SUpZ1noHjT/NYSG3NliiqZmJ/bYd4lT635KLiPevowIWyVO0o5kwtPcHczl4XBq8ny4
 tWB8U4JqOOuqdJ9Dwwf260+Mol07qTVqS0A8PyEmXyaoQefPKcESw7dLKggh7XPELfvecDtWBxP
 Qe97v5I9JHPAV87LyeYU0bSB9/Z1/fgUgn7kb41ITN9Cg5JNS+lTxUH1r7TH7nvnjrLFbF0nNN4
 y0OSC2HMtSGQ4mHUm/0nu+zOyCN/FQAfOZugSIBsoZOdVe3VsaDiluGnUgXv1QRQIK5GEtGCcKJ
 eiTFiigt4MRA==
X-Received: by 2002:a05:6820:824:b0:662:bfe5:92f1 with SMTP id
 006d021491bc7-6785bc5fc8amr9232976eaf.65.1771478588579; 
 Wed, 18 Feb 2026 21:23:08 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:23:07 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:46 -0700
Subject: [PATCH v3 23/24] bsd-user: Add System V message queue syscalls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-23-0137b37b221e@bsdimp.com>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
In-Reply-To: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1499; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=D3JiUPWJcH+meC/cZI0h7d8iJS/d6/OFbVel+kBR+zg=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4tBhvV9QL5Sz8EE/iE97TkU+kxOUQKFHtIP
 0P15YzBHwWJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeLQAKCRBsHNEofbAR
 AKgbEACNJouG0eFgrrv7D/pxkJfOKdGdywShVFjVPAYflC6jGpL7ucwYtQg4F04cT7zweWJ8Dq2
 obGnZcR7tNQxpiQQQNsMjoRWGgG/Fhav0m9zRYni/kdbW7OM6iTxkjo9TrXtikB06TYfHmbdxxp
 UY92s0inrcZRPg0426SkiK662vxG5H9pb2nZax1YxACsjPVwxxJEPII7ygMH8XJwH+4cZBs1ozm
 8nQMn5lVc8GhdsU3o06aLUAUXra8CQYmGt/AYXZuCu4JbmAmVd6yu4Tj138zKQfeSmLYN6L8iOf
 2nsaaRKQUYL+bns7pfLgst9/nTRk0AevL35/Az9y1JI40Q5H9/LohtagAo++UsXP29EkfGJ+Vhw
 +i264/LDPz9o2OZpJVJtmno0/jW6dVj89/3F4FHQ6ZSahkAJzYOVKgUZ19PtC00GX00jPmQ9ckM
 TYAq5n7DHjaL8oysPUqBthLyVT3N+aX0pr4jor3tVb8dwZhIqbEJ0btSWIUMg7GraFS85JQPnY0
 UDWzpsE999mbeKHtCy4Fs9qiq/MXcDR8V7OIay35j2qnIIcoRYalpbafzpObkJ3pf3OJck5tK08
 cFIBPY0RMB3R36kbTFJvQUPKCiP0O7FO2pubm+NauTNCXs+3iJGZIplh0AKe7K6cMig4IpQWkRe
 LtlnSbq2Brm2l4Q==
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

From: Stacey Son <sson@FreeBSD.org>

Connect the System V IPC message queue syscalls:
- msgctl(2): Message queue control
- msgget(2): Get message queue identifier
- msgsnd(2): Send message to queue
- msgrcv(2): Receive message from queue

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 234bd78fd2..f39e521e42 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -894,6 +894,26 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd___semctl(arg1, arg2, arg3, arg4);
         break;
     }
+
+        /*
+         * System V Messages
+         */
+    case TARGET_FREEBSD_NR_msgctl: /* msgctl(2) */
+        ret = do_bsd_msgctl(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_msgget: /* msgget(2) */
+        ret = do_bsd_msgget(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_msgsnd: /* msgsnd(2) */
+        ret = do_bsd_msgsnd(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_msgrcv: /* msgrcv(2) */
+        ret = do_bsd_msgrcv(arg1, arg2, arg3, arg4, arg5);
+        break;
+
     case TARGET_FREEBSD_NR_freebsd11_vadvise:
         ret = do_bsd_vadvise();
         break;

-- 
2.52.0


