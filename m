Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD580ECD98A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo38L-0004bx-VD; Thu, 05 Feb 2026 12:27:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38H-0004Y0-PM
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:09 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38E-0001TM-2E
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:07 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-4097b420ce0so656266fac.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312425; x=1770917225;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vRzGmD5AUD8c4fc/TGw/1te4u3wZVmaTyDgP2XOVktE=;
 b=wL2ZFN3OU3AvVANdnSGLShNUCPM6OXEWqCZLKQ1S8TQI41r0iOc5qSqFrkKsCDZsF0
 fdhauSTiN6jFmZ4nJnzUtSYsmaZUUpXK9jtNHbeRHZYVdQk9WgFKkViRMPB56gHNqbw2
 riwBc3YQQDvItIql3NnyFZd0T/L9NORZLky2k/ewBMHme8rUYkpRii1j+r+tSPXvAb2B
 buRxdGAqWx/TwtUGg9EiWzKMyq+c6RLqufxN7ZGzF9iNfrln+GTY+8xeslOwfk0m+UU6
 Ka6k8kIutSbiefhzwpvdx+h4+DuObztBTVMPBib7rTyNvklZ/Z9SBvJKmSBKuRXb7Iq6
 i9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312425; x=1770917225;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vRzGmD5AUD8c4fc/TGw/1te4u3wZVmaTyDgP2XOVktE=;
 b=Rg1eCEOtQZ+uJnUzV2YTWvGiEUGlYE9sRxdqWnn84e0sFP6CszpQf+kp/B9yHB9ivN
 LYHa5ucymnoBXMB3y0esM0jpPe0Ww9/fuIZsPtLGTrxGncNOL4dJgijLUyK0XK/I/7lR
 y/8dGFR56vCnydBCxcMUROW5LA/xmojIrlvBvxtVLh78jGfw36AOk+DpqrsC8hgEVnKH
 EwSWLjVfSVFrvvzjej44B7KS/eA1PeZOya/RxXTCorJc2rR6TM/+PKwWebR6DuCgdNN1
 DkIM3Nb+U9teIAy5PsSXXb74gauX7zYL30wMmKyEduWTl4V7fpKUY1+DicoFncyNnyRN
 QZzQ==
X-Gm-Message-State: AOJu0Yy5tZYfQCnGrnNOYfN/0OnHftVsa9UT32hUGxd+WnDXjy8h4rkO
 HXbk4V7F8/2mURUzPEbVkfJSXtVsAED+4w0nGHbRl0snB7M8/8gwm0Y0j6fde0r/iQg=
X-Gm-Gg: AZuq6aKPKU4/bnRu0yqEq2mzIuGWSSzZJQPT6cSzRjq4pZYSYdunFMP/04cFPM0hBxc
 2VAGGW/OMbNqIoBoheOVyFOVtW33Ny08aaaWgtbInvTPHashTLHDKwhhuQxXU9p7W5GQB+bD+su
 22hrj13/g6h6BEnHE1Vi89Ryq49pBtmNY+guNrtDVoSSLyS7EmWnK2anm/5a9AVUx+3wQRHt68G
 5JglG+JWSdUuKcVlXekuqL7qut2q3xMGdIpxljnNIiilQeg3HY9K0ie2oTH9SvcATnCzmq6azwS
 xeusQXYin1ld7t2Nxwmlo2RGAFR9YBngPLiyYI362/q6oai+4+zliC+wKCLGbg9QqDMMyK1Id/x
 WPACzWjIth+Qtj8e/cYpwCCkgIxlorKPoHef9CSnnxRB+feOHNdWiwTELV4hrCnL6k7Yk4OKDqg
 ==
X-Received: by 2002:a05:6870:b2d2:b0:3d4:94ef:d05c with SMTP id
 586e51a60fabf-40a96c9991cmr16850fac.21.1770312424953; 
 Thu, 05 Feb 2026 09:27:04 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:27:04 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:55 -0700
Subject: [PATCH 22/24] bsd-user: Implement System V semaphore calls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-22-8d8ff0035372@bsdimp.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
In-Reply-To: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1709; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=Um2KjWSrP/ZPW7xX3b5tIrSz4kbidNs0pwVSjDd0peU=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLbjAHiWFe1mMPAaL3i+0NZOnq6FVmvR40ed
 +fJv+quDQCJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2wAKCRBsHNEofbAR
 AK+HEACEJI9T/JWmrWqxLr2GjwDo95ytvWDPUVeRAaBqMndbChcfAh1EvNFo7r3LBGPiVal4SY3
 FstIU6YMhxApNj1Ymg9vOKAOb8ciBQttzoakl40m5tsbhOiuviPlD4y4A5NqatjaRHi5PDSFNLA
 5qpLY8pLLRJ0buPkZyG5YLjNUDfvxgcM5lMxmU/tnViNGYcxF5EGp7uEQrxT7LqechiLi3+Fr/U
 znHozO1pwWyCEhMYRleoGOqZjZvO7io5QLR9H9ZU0dAGxbRp8B7wxnWrg33N21JW4aKHRv5o6Uo
 qlmOMwu3pyKWQCFfrbowRa8Fs6/JzYeRzQNtD5WxDaJygFOd4wMCD+BuQE/k9J7BcFvHcv894fw
 jeJbNaGIhYo23Z6gfDiwJdU14BPQhyt4BgBASRteDMKxV5jnLF7ESF1cx7nvwbdCacbvcQCYr+F
 X5WqHCggp88ydQ9JsrkMP2mlJmObh0eElefLjG+bGtjXqVOICiazkvrvltFjiN5N41f7QD9vOlp
 t44Z4CUf1zp6+Zh8RHsBffT8gREJDNas0Rb8NrWjn12AU4gojObzRzuxUyw4obuE8lr2h2/n5e0
 nxSvXiB65Rg6zPjD4KvLgGKJuJhF2oxNYCFV2bp1Q8INk2ZUjks/8DAbq+5jl6o7mbhnFuK3+jn
 Bllq7YYCQj8ZNLA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2d;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2d.google.com
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

Wire up semget(2) and semop(2) syscalls to get System V semaphore
implementation, as well the undocumented __semctl used to implement the
bits of the interface in libc.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index ca2f6fdb66..6e38007bdd 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -37,6 +37,7 @@
 #include "bsd-file.h"
 #include "bsd-mem.h"
 #include "bsd-proc.h"
+#include "bsd-misc.h"
 
 /* BSD dependent syscall shims */
 #include "os-stat.h"
@@ -879,6 +880,28 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_shmdt(arg1);
         break;
 
+        /*
+         * System V Semaphores
+         */
+    case TARGET_FREEBSD_NR_semget: /* semget(2) */
+        ret = do_bsd_semget(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_semop: /* semop(2) */
+        ret = do_bsd_semop(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___semctl: { /* __semctl() undocumented */
+        /*
+         * The semun argument to semctl is passed by value, so dereference the
+         * ptr argument.
+         */
+        abi_ulong atptr;
+        get_user_ual(atptr, (abi_ulong)arg4);
+        ret = do_bsd___semctl(arg1, arg2, arg3,
+                (union target_semun)(abi_ulong) atptr);
+        break;
+    }
     case TARGET_FREEBSD_NR_freebsd11_vadvise:
         ret = do_bsd_vadvise();
         break;

-- 
2.52.0


