Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB748D74EE3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIop-0000Zw-79; Fri, 23 Jan 2026 10:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInP-00077K-Q8
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:10:05 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInM-00035a-JB
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:09:59 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so21750955e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180995; x=1769785795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TEHOQ0P1nVV/r/Ov+TtdJ+mMxJLPwQFjgLDhjatGonI=;
 b=beSe4JCZxHy6QLjowL3TZd4KHvWECocCfH2CTVaQCo1TyQWN6JGzto/GhcT2ukRSaW
 92hkJa1afN6rdpBHPUPUBFnnV83kIc2U3A7p/ll7D9JFRLXuh/xfNWZP1z5UXDo0wVUh
 cKP3KJSimg8ubYLrqeBQFJ4+GMaD26ISJKmACNfTPOl+Qwmz3KGRVjeqEHximvmRaFNV
 yNhql6nIZ00338k9PJqWEBHieBnkIMmDt4gTLB48Rwm9p/HOBLHXProk2fiZdTKxh1OE
 QO0fjLwxq8XSBTv8AhPujEIDPkxRxCrY1I4usi5ILBXalzCZdZwbV1TQ2gRUFexQ9z+f
 dUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180995; x=1769785795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TEHOQ0P1nVV/r/Ov+TtdJ+mMxJLPwQFjgLDhjatGonI=;
 b=RBp/AwcWidKNdThxh8d/Vk8qSlY18Dx6BuqMu5B5pbWd382Gpm5Ocjmw5PolWm0SFx
 EWq4xJvBLc3q4Wm9A9GwKPsz7MY2WcjFbgDugdS9quIoCkPAvS6SP0YK61PHgPnvipoM
 h/bbSwY+HIlT8SWCfswpD/aK1EsQvBkm9JakmQQ2c/gl2/60yC1si7lA4vtTZFCDydN1
 7MtkmmrKkQJDwG8rCr1SVnK5INSExAvyYz3FYSwDKqnNpSAKY+TRChet3Y6+l26fXBwv
 K5mOI4yoLnBHNGLUOMvcBslrGkgpL/cgYXycoh9AmHNKDXpEjymHMhjM0bvhzJUcuVUW
 NwrQ==
X-Gm-Message-State: AOJu0YzAFNRe5CsABB0rzNgvA+2JNqnqvMOhqrbZ5Wbnxtl8T+vNiOn1
 WkSIvtOGPnGDqq6BqB0Dwa2OrWSJR/Jwj8B2PZXhoqnmDhYo6bCOdiGdizrgA6cOZLhnLXzpBoK
 T5zFowCI=
X-Gm-Gg: AZuq6aLm5aBMu/9Cn0+eNRC4jU8hgu8b1vMJ2JMpl3WZv8elSZp9dXT3un7Q3aUI8it
 uvJu8qWxsKCE+J9MXA1uWMPoVHUg/LiEsBdNqQ8GH8dADMBnWjg7CjYtZPA+Scpk0qkLo+1cPYh
 HpqP3RcdfrZPPB7IIde8HeWISWQzVqxeAgtSBpS6u+dV4fkeOEgIXOQtaxI1z7w/8FEey6VBLqj
 bl7h/DuCje6IWtRfRlZFsQomFR6BZ3hgvE18n7r7u9eK7ZAnuEDaEqIWLE085RYm4hRXxgflUMy
 nQGMD17KVYoBBiQ3ihv5dPt9Jcl5EphQk8O0mSBMmCx3UWcpKnJXx/C8ofL6sHFQ0nJOnuIzuT3
 +Kb92/VvOx1eImrPmG/I4LL9/ppEQyXT5iUV13jaTsy1Zq7NwKQXwpfYbZBFjrPiDm/3lkzI8LS
 gNWYm3vOMHy/z7Zv749mwCFuQA+w2oGtsJsQpLq50pNikUWHGLxZuP
X-Received: by 2002:a05:6000:400a:b0:431:2ff:128f with SMTP id
 ffacd0b85a97d-435b1ab836dmr6238018f8f.6.1769180993842; 
 Fri, 23 Jan 2026 07:09:53 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.09.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:09:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/22] bsd-user: Clean up includes
Date: Fri, 23 Jan 2026 15:09:30 +0000
Message-ID: <20260123150941.1877768-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit was created with scripts/clean-includes:
 ./scripts/clean-includes '--git' 'bsd-user' 'bsd-user'

All .c should include qemu/osdep.h first.  The script performs three
related cleanups:

* Ensure .c files include qemu/osdep.h first.
* Including it in a .h is redundant, since the .c  already includes
  it.  Drop such inclusions.
* Likewise, including headers qemu/osdep.h includes is redundant.
  Drop these, too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-id: 20260116125830.926296-3-peter.maydell@linaro.org
---
 bsd-user/bsd-mem.h         | 3 ---
 bsd-user/bsd-proc.c        | 1 -
 bsd-user/freebsd/os-proc.h | 2 --
 bsd-user/qemu-bsd.h        | 1 -
 4 files changed, 7 deletions(-)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 416d0f8c23..a118e57260 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -49,11 +49,8 @@
 #ifndef BSD_USER_BSD_MEM_H
 #define BSD_USER_BSD_MEM_H
 
-#include <sys/types.h>
 #include <sys/ipc.h>
-#include <sys/mman.h>
 #include <sys/shm.h>
-#include <fcntl.h>
 
 #include "qemu-bsd.h"
 #include "exec/mmap-lock.h"
diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
index ca3c1bf94f..8dcac9608d 100644
--- a/bsd-user/bsd-proc.c
+++ b/bsd-user/bsd-proc.c
@@ -19,7 +19,6 @@
 #include "qemu/osdep.h"
 
 #include <sys/param.h>
-#include <sys/types.h>
 #include <sys/cpuset.h>
 #include <sys/resource.h>
 #include <sys/wait.h>
diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 3003c8cb63..cc53215138 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -23,10 +23,8 @@
 #include <sys/param.h>
 #include <sys/procctl.h>
 #include <sys/signal.h>
-#include <sys/types.h>
 #include <sys/procdesc.h>
 #include <sys/wait.h>
-#include <unistd.h>
 
 #include "target_arch_cpu.h"
 
diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
index ffc64bb244..56affcd31d 100644
--- a/bsd-user/qemu-bsd.h
+++ b/bsd-user/qemu-bsd.h
@@ -20,7 +20,6 @@
 #ifndef QEMU_BSD_H
 #define QEMU_BSD_H
 
-#include <sys/types.h>
 #include <sys/resource.h>
 #include <sys/ipc.h>
 #include <sys/msg.h>
-- 
2.47.3


