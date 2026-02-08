Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E28EF06E4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpASw-00020i-Ng; Sun, 08 Feb 2026 14:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpARC-0000e0-Nz
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:23 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAR8-00008S-6T
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:18 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-662fe3ff6f6so2007707eaf.0
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578816; x=1771183616;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BK+wKOc6zZ2nYGCtU5nlQ0n7tVwc1fbTvxbWLUKJFcg=;
 b=xhCLNFYT68KDezp2Zg5fOHKJHaK14qNge3vrubdeWTws1qqa8915uH85ScbKMqZ5Q3
 sZe+WHUULuwB+yFNB7m8cibEIGcw3Lsek08tgYKl/DRl+lvOzvwUCGgKgsiF04jJo7X7
 1Zb4Fn3SpOqm2IbbU1yQ08SyVmxCbThZowo3PZiayeE3wkewl7QtWKT0l/i9O6UR3H13
 YsZTWK3qwg1jL1gYeBZ10HS/zyddqYDAbMtuRxQuwJTfWQi8so9WE84mqafDTO5MIJ5J
 iOqPUw5X+yV28RGqOPjit8R/9g0GIpBiNSFmPV4MWdbhvinAhq0hJ2rRHgZA0BkkSObS
 xqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578816; x=1771183616;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BK+wKOc6zZ2nYGCtU5nlQ0n7tVwc1fbTvxbWLUKJFcg=;
 b=hI+hzEEIaYr9kxMcaJI10Ugohf+OgeLYwXPUnKAsiiUFgZe5tIV2OChwHEhqBjV1D/
 z4pCF+4ksK0dVdEtXowGzB3ND4w/7pfRVlDy0Z0riIsLb7aZ4euxpYcIz+SWTOYQLTfJ
 ueLDW1HPDV+SqNj5vPjmjqE8QW3xWxVKY0wlRKYy+0ZhYg/OQ+e3X5UbcHB51oYJM6J8
 M5rB4tqSUmp+WwYUGyYCh1jgySkX2ByKEg/0MxsG7I+c+zlW7w1drhLPu+uTGVTGaZll
 w5jEFlVTS+AdjlyYo3TRIt7/iCIYn9kqLyp83osXqiXekejTr4hYdn37fKiA8eJnlvlM
 rJIg==
X-Gm-Message-State: AOJu0Yzgdq/T1JXIhs95e8iHkrUhnISJhLRDbImxCgD4ytz+RIN4JXHh
 h8wAnIKqYLYEzK+mG46T5MfgPnvwq4ruTKFr2o5qe/bOY+CvSWOH3NYH8RhKsglKuA4=
X-Gm-Gg: AZuq6aLoWQkihYKDVKAhf75p/dmyf6vq/gxdILPDDoUiyvRL0JsaEzdUHK3qpJ9rMzN
 AN2vLA54QNFI/VDWbRUpxcT5MidC1mV9Fnm/akxwKKJpC+U7ENM9V53ukRrwFvtd40XRKFehxlb
 8yZjzAsvhzkgKo0dmGIy8NBLiMF5g3RXSQ9hJYTrjJK7nxiYjDSlyFKo6f+tAzy+NH0Cov1ge7W
 KbygIwq8p/NU5BZ0uqO4YWDLkVkPgPojvWKmyQntUPJgWsdHem56rGQKgBuxeuV7qyipjQMYKED
 fa8OAuhlN5fx8WBHXIKS0dGOZx2Fekp/+Fg+9T5XxWElrqCDHdO8FRwcfVGE5Can6YeRVBh6Mm6
 esrSMLyDp4C8RYOd+sflbaZpRdSOUbq9uOc+oZ0S4XAn+m3LyT4N1kiF7g6zn5czirw/GskZ3Ag
 WGRdxGlqYC
X-Received: by 2002:a05:6820:4411:b0:66f:f316:b222 with SMTP id
 006d021491bc7-66ff316b6e5mr918669eaf.53.1770578816645; 
 Sun, 08 Feb 2026 11:26:56 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:56 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:32 -0700
Subject: [PATCH v2 23/24] bsd-user: Add System V message queue syscalls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-23-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
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
 h=from:subject:message-id; bh=j3nVNqnTHEd+vk2+gsHFNdUPxCKloFqP8T85bhoIz5g=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONheTf5V7Nk8z4QlP/tgoCCf4imSPWv5nwKz
 opugZ62JdKJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjYQAKCRBsHNEofbAR
 ABFED/45eiqK8xKJrYw+WbdpWEQ6HWpaWhTVfBy1Nd42uGo9nfNXHQqhs0WEyldf/VoS/kylzaq
 +DBxGpdHnW+46NJG85nVsr9xAZJ9OyG80mqSq7v/EosE7c272wCKywiEwscPzLyOCWpSOd1N6m6
 6UIIeBGRi+RCvtchgNXYPIaCUkIxz3048SZaoug1roqDysEYXLPDsb9euJ9YycEHa76qFwRgmp6
 tY7XqoIKk+K14nzC0FjatEOUnhac8rhZUMl+1ON692kz2SEIRoBOOupftUnlSJ9ht7/C5HZxati
 LmtWz6OSbBQpWFgJVXNnVxxwOMQZ3Tmi00+dGP4mNRaxYzlkZOSQDEU5NMRx99lraaCAYNGsn3V
 NC6X/02a9Kst1zXCLD3ma/krQ4HD4snSa44Th/ZWF29NK4XumH7tkE+HjjOGdwhTUOIJAmkMruv
 Mugxyt+tw0HjSdSxOLwB99gfjAxdgIaZr+OhOnZJfVohezbVWDMKiEjY2VP3LQeMjzvTDuhQlbl
 jpORClCJJLX3wQNYQQ28pfTj0XEoHtyhBrWVYZXNGUqUfBrNf6dT+up+NZXvB2tb7HfztE/5KkP
 qFjUiHNWLmOo3ZZPO/7lGNiPYnOK0qd2cDEztoCrVZaP1E7e4tn/UdPwfy+X8JOtNwuz8piUfnY
 cs98q/tQKgcN7uw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2d.google.com
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
index ecdd5d7628..b081420ee7 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -895,6 +895,26 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
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


