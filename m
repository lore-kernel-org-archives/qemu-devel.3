Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17C6FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI66t-00018b-WE; Wed, 29 Apr 2026 10:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI66p-00016g-Js
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:41:52 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI66m-00039m-Mo
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:41:51 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-479d593a0c3so812672b6e.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777473706; x=1778078506;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GM+VfAUDmtSj8y4orryZtYG1iLpOEqhbXeQi5rkOvMM=;
 b=NFsjNeTh/42QzD31Jc0SCnJa9pVM7EZ2DuIWJ0OtsgTGsHwlKnJaa3m4KeQC9Ysb2u
 2mTt7NTGB9lRLHP2kZB3wnDEmh4C6KI0MCaAHgBdBLVew/bmEiUWT430zBwwTpWchfBA
 hbGvanC3MUyR17NeqMqvERZl9I9wj2oA9RiphaN4kdavA66QH0YXs6/ijD1CS1AOe3oH
 063I7enNpEQpvDyljprHYsGx1UoD5lQOFQNWscirYFS8oGxzoRQPTAtwZf7PLymNy7s0
 xoiHAEbq5HPJc5d9B3mMLQChEqJ+h7B3uaF6HGFvkLWqyLeaiCWA9xBIJqt2eJIVjYPp
 nAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777473706; x=1778078506;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GM+VfAUDmtSj8y4orryZtYG1iLpOEqhbXeQi5rkOvMM=;
 b=qtSXIUOLwSzL992SAPlUL6IsdM/0LW0SOB3B3uDXlo7iY1X3Bc1R3DriHS7vNV1dmv
 MZMArfiRWdm3aZ+eTnrP5qTdAKL18gnOzqZZBQ5meMdSGFsYpSvkV3UsizdESRwTN5rq
 3Lz7mGLW9cH0kegBiGkXwCE/uBks1A/B9l4ooclf+fDPcccx+fkIBvkoFeZcFersK6F7
 tDSz7FVpq3dWGoZZi69Gx0z+TkFnaw2ityYLgJ5C/3TE4WcjXZs3DJmJrIWjTvRqxubI
 MC4LqfgwwXo9Suf+vWr7rk9v2ZLlHPpAhC+jqbpafklPnGucR7KY+Tx1nuRr0sbD55so
 BD0g==
X-Gm-Message-State: AOJu0YzOohScekw7sAgjcN1t7YEb8skWlgm/VyP8EyKCQwSK5Pf2GShO
 h+YvX3oGq2yj6K+mEWaP4lluUf09HGepwBKpkmnQ4GZSprgg1FLQGu521s3BSIfA3pk=
X-Gm-Gg: AeBDietqjehRabePlnFGNods4QNxNTpqYH0oCeK9OuN0L13aFL7g5F+VyUFC6AxL1Lu
 cbEaX3BOQV3DfBy+6GBn8TDdMfXTx8eS+8Y0odb2ADWAe8ExU6ScPqOOZ2/KJWnlx73YeulivY2
 qxUfoRsDxKarI80aEmMZNM8EVkw7LGfeDCS38UD4RNdsPECLn+eSAjW6FIdijHIlYyIvxWWjumW
 N9JS1UpuSwJZDPE2uIebqkZPIssSsNMqTrjYnW5xujptQLU6XPTQQAd3CbnVOxKnucGi0zZ1nN/
 5vuZscyYsqpbuk+TxABoO+z2Was0GDql9GxubzAPyUlzzEfTBOqpYux5C113gsLpw9u3AuwZzFi
 wzq7gHYzruMv67QMNfPDfR0Wb+hZYN1UHipYPq9rSSi6D2p7DZpz5jDeqRD19nl6dFV8j37ABNc
 MDqj7SFYJzCwCryyv6Vc+l
X-Received: by 2002:a05:6808:159b:b0:47b:c703:4236 with SMTP id
 5614622812f47-47c3fb58d44mr1535918b6e.10.1777473705953; 
 Wed, 29 Apr 2026 07:41:45 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deab9d6067sm1553377a34.22.2026.04.29.07.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:41:45 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Apr 2026 08:38:53 -0600
Subject: [PATCH v2 3/5] bsd-user: Create os-syscall.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-syscall-nr-v2-3-67a8d09dc13e@bsdimp.com>
References: <20260429-syscall-nr-v2-0-67a8d09dc13e@bsdimp.com>
In-Reply-To: <20260429-syscall-nr-v2-0-67a8d09dc13e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=XrvB42cdUbjGT/6e9K7hXwzF5dDYegII6Ryw8dKYaiU=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp8hhKbl5pc9Nro8fcrOU49zTPhL1gFg20Znmsd
 JpfOsNgInSJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafIYSgAKCRBsHNEofbAR
 AKHRD/0dpJc4m3eZheRhVDQBECxpcHooC2zgZeUr75lQV1xvYsuk0G5u6FTZnj+a3A68qWV71pK
 +qUjzjDBLIVbIjZC6SL39Hp9kPhC90aqCTsnxVpYCrEuS5fVWZeFR8oR0X8qmIaidkLfCgnjW3G
 txRYPz7joMXUEnx3BGoVgJt9OJM9LAv2ZVChVu1mq5fPfab2fQ7AHW1ZMQq06Z6bkNEPM+r9bAg
 viClRKR8hTKHQ7LwMupqPnX9XNvClBfPQNJoXTtxRDrfhwpPoNaQcFPoM/yIPsIDeHVBkace4Gj
 2MYqAnAGyQU3HToV7v1JOs05BHbfIrvfsNl37BHiQfyqeOQBVGmIGxCVUIDbJjkhkCh5pVsPWri
 qvWK+1D9KyptQt3Urnb6uJSP5hHwRxisn0DxUmezcGEBdoEjAjtgwfwHNERLTYyUnZInz9t4Wrq
 3YlUFH6fwUwVMz2M1VgtZfXD0LvrBWuTAZY64i/igy8/GdM++rosW2CpGN7gw1BXQjITvriMWDr
 7OchdWCqsgUB5Ks4ZAvSD7BuUJ5C1CwyLyk3ZTIdpYsRUva5AFmTEd7GMs33s8lo/xGKtm8cBl/
 RuXLPC3y8Wgso1XPwxdw7w9f9WngwO5EP6gLMFIy7CVFFhutI4hhGyoJ1y3wkDGPhpNml6KfgxA
 gejTlV9f0JClp/Q==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::231;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x231.google.com
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

Create os-syscall.h. The purpose of this file is to define anything
that's different among the BSDs, like system call numbers and
time_t. While there's a lot more different between the BSDs, this is at
least a start at capturing it.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.h b/bsd-user/freebsd/os-syscall.h
new file mode 100644
index 0000000000..962adfa91a
--- /dev/null
+++ b/bsd-user/freebsd/os-syscall.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (c) 2023 Warner Losh <imp@bsdimp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * OS-Specific portion of syscall_defs.h
+ */
+
+#include "syscall_nr.h"
+
+/*
+ * FreeBSD uses a 64bits time_t except on i386 so we have to add a special case
+ * here.
+ */
+#if defined(TARGET_I386) && !defined(TARGET_X86_64)
+typedef int32_t target_time_t;
+#else
+typedef int64_t target_time_t;
+#endif
+
+typedef abi_long target_suseconds_t;

-- 
2.52.0


