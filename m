Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCADCD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoQ9-0007QH-Fw; Wed, 06 May 2026 22:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoQ2-00078P-Ex
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:55 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoQ0-0007jX-4o
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:54 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6948ed7139eso196556eaf.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120691; x=1778725491;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hc7ktAKkXmg4BG5PFQIrRCVxKx0sZHqRW/Vi7G51a1U=;
 b=qNbQQcwj0oQAQsXd2R2qQKxLPHukrb8NN/MoZTPRjnrSpuF5KmU8EHcnQTHJTUc+jb
 H51Au4atlqkheEmLyc86Mr3KquqLOPaJ7stPfXXOmALoFz48QwQFxMwTyFC1D3hQXXZM
 RJYIdU2R1Ah36MqXRZAaPNvunaCsWmMrUeb3PLhLvyLDNL6JtQsy3J4t4x6YR+6MDr48
 tSwARYLzGUNazu/vzLiASogZPJE0+0x5U6pvd3J5MRaIl1Usk5EJum6tYwO7Snrvy32x
 N4kIkit7QJC2TVit+RgBJlaq/7dOjkIa56yJAjxHVXjLXIU22TXjDhkLdouLAlOk/n8Y
 4+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120691; x=1778725491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hc7ktAKkXmg4BG5PFQIrRCVxKx0sZHqRW/Vi7G51a1U=;
 b=MZVkfHME55vlg6ikIpPqI0xucpuIjl0zfSWsAtv4pkbPsuEUjwOIhSuhqeM6Vsx21E
 7Hd7KwQZQJ43Gbc8AC4GKzIFaMFY3Jy4tPEBortsqnVOR5FeleDvTnVDjh8DZRcDZ5s1
 DPiC5Rb6Ai5blPz8C7g9iQyVHUgovXYKeztFfKkfYh5zu9lTux8dU9egciS3nOSw98P3
 n9bAqtmxZBNmtceo3m1FQMF93sHDs1UH9RxFedu4LuxBNUl1f5JXn/2PV5C8ZdUOOFFq
 o/5HWxo/991yK8dY5ObrH/8y6rcr1rZlMCQQFlA6BTlOH/2f/Egd3rycvPKsdIPtO1oa
 e5yA==
X-Gm-Message-State: AOJu0Yw9cPh/nehdfs8XD8zaAh4lSu+lfY1z/VwrwphcrThCjqQEfRXz
 UtKjmJqZ3Vq1/I5WqWyCsAZdmuBIRQT7NMb7RPI0CIbCnjGKodGSGl0hUuXcGuchr9VHp4lJOOs
 ClW9ZIR8=
X-Gm-Gg: AeBDietfX3GIfdsQzRAwgt5VOIzKRdWxj4rSug4AbczI1VuSyy6dzWUeOFpiHVplhuR
 d5SiBiLFClaYrdEL4ATbbop8EaZqIH9msf8u0pmh8LnFq5HpXHyLRN1iNtUf8bQ5wCAYJm4WPzg
 /ncbLrnjBNHy/WTYNYBlcLHI0BLMTgSOt8YCcQQDiKYSgoPksjRB1L8zagBRJi/F1P6901pJmsf
 e0Qd1JnIbR5OKrRFsg+DunRMGY9spGr520d3mC48ju868j/ah+gs3YUDWAFdK5CQpcHzj4xMiFy
 6A9pQm2FS8lqJ2BrGA/ITPu2Gh3oih28OpGM73bXJKaGjLJCB560IoO3Ga4gl8tay/YyNRiOZ6m
 x7ZVmsc9t6c+ejXset6Cvo/S3kU7rs0Ru0aANhJYPlz456nONGMM+Enh6S14GEGM3oGgsSXmwfN
 iwln1FBTU2fTWA/MjAnfPn
X-Received: by 2002:a05:6820:610:b0:696:7fcc:6113 with SMTP id
 006d021491bc7-69998d35e06mr3408750eaf.49.1778120690811; 
 Wed, 06 May 2026 19:24:50 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:50 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 25/25] bsd-user: Add call to do_bsd_ioctl and add bsd-ioctl.c
 to the build
Date: Wed,  6 May 2026 20:22:19 -0600
Message-ID: <20260507022219.44171-26-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c29;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc29.google.com
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

Finally, connect do_bsd_ioctl to the build. Call bsd_ioctl_init() from
syscall_init()

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 9 +++++++++
 bsd-user/meson.build          | 1 +
 2 files changed, 10 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index ca819fc530..90ef1bd916 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -34,6 +34,7 @@
 
 /* BSD independent syscall shims */
 #include "bsd-file.h"
+#include "bsd-ioctl.h"
 #include "bsd-mem.h"
 #include "bsd-proc.h"
 #include "bsd-misc.h"
@@ -689,6 +690,13 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_undelete(arg1);
         break;
 
+        /*
+         * ioctl(2)
+         */
+    case TARGET_FREEBSD_NR_ioctl: /* ioctl(2) */
+        ret = do_bsd_ioctl(arg1, arg2, arg3);
+        break;
+
         /*
          * stat system calls
          */
@@ -993,4 +1001,5 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
 
 void syscall_init(void)
 {
+    init_bsd_ioctl();
 }
diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index 9cc5c6c459..2abcae5122 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -7,6 +7,7 @@ bsd_user_ss = ss.source_set()
 common_user_inc += include_directories('include')
 
 bsd_user_ss.add(files(
+  'bsd-ioctl.c',
   'bsd-mem.c',
   'bsd-misc.c',
   'bsd-proc.c',
-- 
2.52.0


