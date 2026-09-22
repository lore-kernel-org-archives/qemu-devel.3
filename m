Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D69FC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x964E-0000ey-DM; Tue, 22 Sep 2026 15:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963i-0000Z4-BT
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:45 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963g-0002PG-97
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:41 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-46a63c34533so247954fac.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 12:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1790104899; x=1790709699;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q4+lieatj6iS2uRJzWD1BUtasZ3z3npUrCZve+r0t14=;
 b=EFOH67ykKqYjUUzsjAh0jXRjP1Dsg2WojczVa8A4fmS7GNrvE+rNGkRftk79e5IHnI
 bMood1x+UIU/i29eWOxojhjtnpezqSgFNyTY3xKpTzLp1UX6zVHe2UoXZgFjIpXE4x4i
 MMik+eft6nEAYAd08k3IieTfcZBUHiOGfJ5UDhzXeOuPBPwil7owpsbe6weprbjl4NIL
 m11FG05Tqjbye876khbJjlmnbQcGGoHw1QWcoL1Lc+7424BQ5oaSkYkqL0g34conIzCL
 8iQIDQe0ZGrCNrVi2339XNQr3R5wgLEFZWz0THUXa7iD9wdSVDGxF+jiAZdYGLZ5UtIY
 xV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790104899; x=1790709699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q4+lieatj6iS2uRJzWD1BUtasZ3z3npUrCZve+r0t14=;
 b=IqY2kg3ee22yroDmtg8lKDGgWQSMvUbu80Q7ZWwZ0petlvAu8IBQrZhWNl5faM+lyV
 DAQAkXnZwQh4uJ4H/KgLlQ22cqbMVxuqdhQSxRdoZwcwj4KvoDGvmqLvznm2lhyDN19H
 OouhRZC1MeUwGJKouqWFZ+te3B7E8Br0xRxr23JsGY1MkVQfF5BcbpY4y2sfgztN57S3
 OX25DIIXYIwbEddYp/83VYJRB6f0iB3PnPEaY8bKx0MAcpwsOMOJA3sOjTgIFqGX0kBD
 H8I5kaGRi2VKZIMw+fA4XdNh7FqtSwqEp9hLEVttvoK8/ERyzozsyjHu9ftPqT0AOZYi
 z3+A==
X-Gm-Message-State: AFuF++niQz5ZfR7obmaf/2FHZ0nB6rQK9jKtZaXAKFl2XlBhaf1Uje3z
 r9ybhYiVnh6w/CfoCNaAnFgbmgSEwo5Zc47DsDZGpN/L1pKpVUJp67dh0U2dzSAEdM24Nb1DCMG
 Ns8rzbhA=
X-Gm-Gg: AYBFou3UaawN2ENSeaS6iKtffClfUxTYfTLNVaYDEC1en7KsyQEs0FChV9UAU8F0fHJ
 Jcez//UBMoDmQCQ5Vhj3EYXdkw5uPxy8XqSHdEDgQGRZrlS8WWRVk9+SPMZ0An/ya8Ao6MJFoWK
 jh2+xVCjDkJNstW1zxK1l9JcouOkh9dTsaxUHnpc7XF4KJTPy33bbgKO/1MKdEp0DZaUnAhVll2
 Usk6pbOitgQJ63fnz20KWkxdFuShF2qzhvDsc0ysYYGWBv/Wx7Zk54lY91yILoSbE+I7gXjjUEv
 8foaU9bZ78FOdu/yG6Gq4z2wBF+y+OG2OfTFI43zHi6SjG6osDTm2N6DaLB5ejGD9rBf6F8ozlM
 IN+HxueLtI9WvjBPLcPeU1i+3MJ8hMoFMSVMMiYMidCurPxXxqHhN6fhI+FDHh52lGohqpY/Ewv
 W+RJT7wzooVF9K28VY5vRmnrCe2E9nXdP3MpFpAIWO+D08Gg9/r82TMp+ygw==
X-Received: by 2002:a05:6820:2010:b0:6c1:4051:b891 with SMTP id
 006d021491bc7-6d2d2b118cemr337667eaf.61.1790104898887; 
 Tue, 22 Sep 2026 12:21:38 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d2ce763f72sm646776eaf.7.2026.09.22.12.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:21:38 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/11] bsd-user: Remove host-os.h
Date: Tue, 22 Sep 2026 13:21:09 -0600
Message-ID: <20260922192109.98467-12-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922192109.98467-1-imp@bsdimp.com>
References: <20260922192109.98467-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:30::10;
 envelope-from=imp@bsdimp.com; helo=mail-oa2-x10.google.com
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

host-os.h was used to just set the default bsd flavor, but it's no
longer used. Retire it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/host-os.h | 25 -------------------------
 bsd-user/main.c            |  2 --
 2 files changed, 27 deletions(-)
 delete mode 100644 bsd-user/freebsd/host-os.h

diff --git a/bsd-user/freebsd/host-os.h b/bsd-user/freebsd/host-os.h
deleted file mode 100644
index 40cae72ec9..0000000000
--- a/bsd-user/freebsd/host-os.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- *  FreeBSD host dependent code and definitions
- *
- *  Copyright (c) 2013 Stacey D. Son
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef HOST_OS_H
-#define HOST_OS_H
-
-#define HOST_DEFAULT_BSD_TYPE target_freebsd
-
-#endif /* HOST_OS_H */
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 13cd752b99..29ee59de2c 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -52,10 +52,8 @@
 #include "exec/page-vary.h"
 #include "exec/watchpoint.h"
 
-#include "host-os.h"
 #include "target_arch_cpu.h"
 
-
 /*
  * TODO: Remove these and rely only on qemu_real_host_page_size().
  */
-- 
2.55.0


