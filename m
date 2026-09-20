Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAABC982D0
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 05:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x89zC-0006Re-Js; Sun, 20 Sep 2026 01:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89zA-0006R1-5p
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:08 -0400
Received: from mail-oo2-x2b.google.com ([2607:f8b0:4864:31::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89z8-0002BH-L1
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:07 -0400
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6b1ae6b200fso1174608eaf.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 22:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789881665; x=1790486465;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EZ7uOOnl8fQEJZF0wBIw38nIparV+DQ4Ula3xkqLIAI=;
 b=SDvmS2UQyuwTqIla/Fj0ucI1NdtRK0lxmsKnKfbgwkF6IAbc5C7wGeAK+9TjN7uObO
 ZLLZYOJ1T9MKYQH/XY12AlJ1WcEBfHIN2+bm2qNo6f9Sv+U/kvCw9Ij4q9SYukyvrpIw
 QThPQzEpmUBl1A6EHOe8iD+LTO/yh8fC6TBCicE7rnmgaERzZW1LiALlCTzvmlRXHNAe
 jMaiPKCv4bUoQ3AUpjW1+nLU51gJ6R9U+BsJ8dUA/kOpP1Vc/97mD85oL8qhcObEnS5z
 kWsIKxhR8zFU/ofc/9z+FW4GYQ01kb2lnU2ieGJlwUFoOpLxzohQAujWCrFVeLCyctG7
 dH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789881665; x=1790486465;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EZ7uOOnl8fQEJZF0wBIw38nIparV+DQ4Ula3xkqLIAI=;
 b=SLrt+7h7N1tRQhZEVSREKUj/noSKbMr2b3qUN/UzVIcGpkcWfuTVlV8PqLsgxwkkL7
 J33gN1ZletZv6dGhDIIBfhtUT+wJ5FBZd4d1tfMfJz0ZXQt/0eRO01NdO7yttwq82ttS
 a0ptt5WFVqPBLIvvltf/xdYmfwoLRFfLQ4LI5zX7Sb4EGrCpiwiWwGFXxs0LsVJLS/Xs
 oMdlR5qzXgAe02AwxRjeiaKaNIUZ5tSKECam5PhgAc947N4N1mFbditMWvQomygNrAED
 lZCb4AX02VWlbDMLyaivtA0D7Lvv04f8qMbq1n2Hq7E8vkKWpMDDLOK7iwl9PZOyjsrD
 f4ZQ==
X-Gm-Message-State: AFuF++lB3ZLHw7GKg8X4A02x6jtwBeJ7lbj+IjYPqvJ70hy7Mo2WZyg4
 xwEmPbTWMY6OlvzioKBqZh2wBuqEOPsy7KgF9P6otdOxOFVjuWS+BFvjMYQC3BEYpdw=
X-Gm-Gg: AYBFou03EhFbNyWK6sFymjl7us3qAYGA5eYGo5S3KDne8fRUa2prHUe2yqxpxCOqadn
 CzlEV4jcQnupntk52/NwF3eBj23NF8+qq1Gbb4bBemFZ7M6csFulLkmRmUW6Lg3t7St8UmM7uGU
 rw5xBnwfWPdzMoHjej6SVGTugWHns8Qlwyn0uDYR5mJgf7H9/NB9An+/cRabEPZIxol6DdXaU6B
 hovbcK0K2EE4cxS1+v851q8Bh/rpXUHw6FxoIcAzUNWviU/Nm2e6L46BJSPrD6c6NwmOaExzI5l
 tDwXlYhsusDdRtKc54ofQaZ7eJ2liNRR0g7/yHxbIm6PAa5z9KUeNAc8Ol2470jmtmZxMqqoZto
 vJHR3FH7PELF4cjFJoJ7pOMwcB/2ZLh0glq6xxGd5CRck1pxGnwHlpi7j3P2OVNTLSO8N1Y8+9z
 Kmu4au3Jv8n9IDSADUmjRSAxEtO61Y6+y1B5EnXWcckK9RfIqUutCXJF/AHA==
X-Received: by 2002:a05:6820:4b8e:b0:6bd:bf80:9796 with SMTP id
 006d021491bc7-6ca9be50072mr7908590eaf.41.1789881665413; 
 Sat, 19 Sep 2026 22:21:05 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48821db3b4bsm3936865fac.17.2026.09.19.22.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 22:21:04 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Sep 2026 23:20:40 -0600
Subject: [PATCH 04/14] bsd-user: Add gdb for system calls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-misc-2025q4-v1-4-ebfa61049bd7@bsdimp.com>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
In-Reply-To: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1243; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=XesaWf9kFd2gYzAPU35fhvYE/hycZyCA2Ns6vKqOltA=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqr20wmg3nlajyhqCpCbZYToybTHIs/jGmr8XFO
 qqhUif8cGWJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaq9tMBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQAH4w//aXNzdgcbXwOWx4KKXEsTEmLQE1hu7QN
 Ri6U899bU3fgaR9Xq/R4Y0ukXfK7IY6CGcS72xk9e01sdy7qiUUAP5c7Ue9dfW9IjtOlrThFnuB
 8FWWSt8GTzwKe6ziifHJ4A04o6NOfppKa8Jol8l2h+B/sTY0GlmgpNPFJi9Bu+9mhmvnWZXE7nJ
 KWOzu6Uo3RWyqdCasXaE+WoD+OW/FDOKWjJroccs45jlsRDrJZ069TnfcJK4FgnMF9+PWtgl4Bn
 wOUs6ULnWNIlfGWrg5GZUFXkjFypjGncsYvUAuz8lDukTfgbWruJ8TA6H6GtEnsp+xZ43tpSU4r
 OUvCo5RcE8cU5j6G+gPeHMJ1r9NXYkPOXgRApa/9NjY1XyyLf1rnAsCwFgcaFokVeFQeOjyLSH+
 h/pYylBccEuNkzv7JEbJ8FmNk2PWOmuAJZweq90DeZH38xmul5BDk1VZZc86RQOnhrjVY2TjzK+
 zWsww+2zzoy5w9j+V1iWOuscIXobRWwoF7G/aFI6tgF+elFl/UtOLlzB6ij/1MfctfT0R3JS/85
 WwBhzKunetw8soYl/3stmKnTjalZYvZCDmlVQQxh+ejsBxcim0SKhCddUfG0hMTh+6FN8Tw+5A8
 2oBNhNlSTwW+5H5u+DmaENrcyr/DhZyocxEORuf/xyW+6mzcQGlU=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:31::2b;
 envelope-from=imp@bsdimp.com; helo=mail-oo2-x2b.google.com
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

Mirror what linux-user does around system calls.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 7e400c89bc..38dc87f745 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -29,7 +29,7 @@
 #include <utime.h>
 #include <poll.h>
 
-#include "include/gdbstub/syscalls.h"
+#include "gdbstub/user.h"
 
 #include "qemu.h"
 #include "signal-common.h"
@@ -1622,14 +1622,20 @@ abi_long do_freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
                             abi_long arg5, abi_long arg6, abi_long arg7,
                             abi_long arg8)
 {
+    CPUState *cpu = env_cpu(env);
     abi_long ret;
 
     if (do_strace) {
         print_freebsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
     }
 
+    gdb_syscall_entry(cpu, num);
+
     ret = freebsd_syscall(env, num, arg1, arg2, arg3, arg4, arg5, arg6,
                           arg7, arg8);
+
+    gdb_syscall_return(cpu, num);
+
     if (do_strace) {
         print_freebsd_syscall_ret(num, ret);
     }

-- 
2.55.0


