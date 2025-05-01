Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB524C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbQI-00012k-Ev; Thu, 01 May 2025 17:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOx-0005TI-0Z
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:25:03 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOv-0002FC-0T
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:25:02 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7fd581c2bf4so1215954a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134699; x=1746739499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D8QU7G6StI/VTOXfIkZKxNy1/7wiHIoofQ7NN/1U07c=;
 b=cQIGv50LVEQd7u09KlA9rnpenFFcom4QV7XVq+usKR5bQCX/LnnU3FF+HxFZfP1v7n
 3JRQ9ptHfs9gBtMyIz4MhchiytoMhmt2b7JueqLOMxuh6cT7N9HwEQSgZvVI0hy2F+Is
 DD+FdD+UI1xlpDIfqONNNoV/2/OqnySMqPNAqPH9rpXd/FSKR/+2mJXsc2WLDXeN5H8l
 lL7pwaXFEJ3IaPIfB42GA2P6/hFmmtzSoqJS3Y4gylmiUa5rj6kpUzmhWATmjwek2fo/
 yKdnf/CS7HwjiqInt02tiu/tDaWKSsRlI7C7RJUGIb+f/ifSSupZWHNuQP6I9fHHJjQP
 mUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134699; x=1746739499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D8QU7G6StI/VTOXfIkZKxNy1/7wiHIoofQ7NN/1U07c=;
 b=mcbwMs3XOnwxLCud9gmNxi9O05d8V21FIN9X8cNhLAQ1d4r2edHEMtsfcieHR+QS3C
 Fi6SPooWuVOI0ZbqZQaeqY5y9FWwfY4ctMASIa4HT5MZdvL9yPPDxQDBAcFcHaJZbnpl
 ixkKhIkTyMnVZk1Vg5Hk9dIa9n4w2SWJte1j1sK1cIz31dd26r5IEYUCZTDFDYeo8Umm
 cuzpWOMCnn7uvaShnpiz/lgxqmjMIA0eef+3KfVra/E49ubuIEUeK9BzwNfUskCcBskY
 I/qilNx3dQO+ob7tn+K/Nlp314OulH7QqeM/zVPQ3FAV++gN6a/xKxYakpEdX7i7ktSH
 //iQ==
X-Gm-Message-State: AOJu0Ywz+mu93tFNnTvD0zSBwI+qhLr2qa0pU7RoG6Gk8oQUTU1MJbiv
 hvIHlOI7BLJ1YFHmmgpWDvkZ6raBU4+iTG2rKrVyW1Cgb2M1nmd16S+7UDxaONynpdvzB60v4mY
 v
X-Gm-Gg: ASbGnctBQ2DBOo3KO5lxuH+CW+MvSI3x5cfnCeoZJ4Htj53wMG4kCgMfPH0sbAqEX7i
 A6Xz1i6X01ntf38ZkWZy6DkJ5+o9EGrus14bN8wA5sURb3M0zjTdV6au/3Ad1k4eGeb+x724Su+
 FfKKbjlhKDA06p/D4S+Elz1tNSKi3WPsN8lqV/Uk8J6KaqK3y/vulKZeEGTIGuK27Myg78qVUio
 Y9CpJpuxUd74235i+iUY8iIsVkxLxXVFYDwHC6L87iSpgFyUD/on5YWYYXyCyTk66ZrHXbu+b4H
 fDDjmpNWZ6Zcgnhm3k0BrznDhuVcvMlwasxz4COjpn8LPrsE/4HkwoKudp8yHzr9Vb6tfE8nzOg
 =
X-Google-Smtp-Source: AGHT+IErUm6bUGIZMQHmDjtE7vUHJTVNhj/95b7bYSO1mahMeZsaSlPQPQ2rxpQa62XSkZa4gG8M2g==
X-Received: by 2002:a05:6a20:c78e:b0:1f5:884a:7549 with SMTP id
 adf61e73a8af0-20ce03e9599mr709491637.41.1746134699455; 
 Thu, 01 May 2025 14:24:59 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590610desm135897b3a.146.2025.05.01.14.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:24:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 59/59] accel/tcg: Build user-exec.c once
Date: Thu,  1 May 2025 14:21:13 -0700
Message-ID: <20250501212113.2961531-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c | 5 ++---
 accel/tcg/meson.build | 5 +----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 085da0c036..f25d80e2dc 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -19,13 +19,12 @@
 #include "qemu/osdep.h"
 #include "accel/tcg/cpu-ops.h"
 #include "disas/disas.h"
-#include "cpu.h"
 #include "exec/vaddr.h"
 #include "exec/tlb-flags.h"
 #include "tcg/tcg.h"
 #include "qemu/bitops.h"
 #include "qemu/rcu.h"
-#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/helper-retaddr.h"
 #include "accel/tcg/probe.h"
 #include "user/cpu_loop.h"
@@ -33,7 +32,7 @@
 #include "qemu/main-loop.h"
 #include "user/page-protection.h"
 #include "exec/page-protection.h"
-#include "exec/helper-proto.h"
+#include "exec/helper-proto-common.h"
 #include "qemu/atomic128.h"
 #include "qemu/bswap.h"
 #include "qemu/int128.h"
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 9b86051b82..d6f533f9a1 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -21,11 +21,8 @@ endif
 libuser_ss.add_all(tcg_ss)
 libsystem_ss.add_all(tcg_ss)
 
-tcg_specific_ss = ss.source_set()
-tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
-specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
-
 libuser_ss.add(files(
+  'user-exec.c',
   'user-exec-stub.c',
 ))
 
-- 
2.43.0


