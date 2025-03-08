Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A3FC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr38y-0004qN-9b; Sat, 08 Mar 2025 17:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38X-0004bE-Ty
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:17 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38V-0005My-3h
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:17 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-223fd89d036so60316795ad.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474753; x=1742079553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RZdIHDSHGx7DjYFPOKN73GJ/ocYoTkMO/3fUlNv68hU=;
 b=S85kEc3bMa1xDjtFsc/k9EQEcYnGSLgb+xwlAAQGk4jmSEYu3JgObDweviuOD/72Y4
 T2Hw3Owk2jbPlcpkxzdVA60IiVojxHhRnVlDvbpdbCx+CV/0cEosWvJHbKNb1Jx6lc9j
 Y6Ke6rTpvpBLtfOBZ4QGgbkkyZ290+IoG1WC3rbcLhqrHzBjNox8b79ZlGa3y7iv3bX3
 a0KZd2So/c+goNjy55thNdYZU1De4NyMQMyroddgBUNEeZJovqpdUlKH0xfvDC8AhLhs
 MabyzCAl/9QXauAFImb3aWIiKgSVHru0FVQ8b6txHhqpvEc6RW/ylRrDuX1HBlCeU2O4
 yFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474753; x=1742079553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RZdIHDSHGx7DjYFPOKN73GJ/ocYoTkMO/3fUlNv68hU=;
 b=gvdwBvwu46JIe39spNZfOBBM91wTi6wwzdXO7EVEft/bU7dwMpZBqHLHT1QlHPB5dD
 aA8Iu8UgJUre7qdEwqNGpl2HnFqIJvwJ/6ejarTNEtSbAQqd4TmiefDButeVXtiAn25w
 BOZKUp3bpQO4h+MJ7NMBK+uzskzOVAo1JLW6ns7S80Z2QFLu2Fiytt9hHUKJ1PG3G/da
 OtwLdKjlTW5VwBsAzsEIBgIYuMa7Cr9SxJAMALKCpCk6VVcT+DgGr19VKsKHK6mIE5gH
 vntDasmsicZFeFaQ3oGV5hzF/VsAmy8NCeq9/3ClKokZCW9qf+ogR2rUAMZiqGz8wWIn
 b/+g==
X-Gm-Message-State: AOJu0YyPOGpWjBYjAmcqj6ytmgOIuDXTpiKB0l1DlbYFJhwnFqWyS21h
 tPoJmBZVWLkwfDC1U6iaxvGrWCLoaIwuJb/2yR2UMnoWGWJwa8ZNCvgPm8cMvfRLcrOYTq2RonB
 V
X-Gm-Gg: ASbGncsYX7Gk39BgEsL9mtq8XCQOmdXredwUYg/Qk7IwTki6DkpkFRB15RPbMVBLGt2
 p8l3JkN4/xeVhehRh4SgomrWb8kWfmJfkxOEYUy6Aini37X7KfRcQfCrR64CEKAEiy+dGwegplV
 QhNnGTkQyAS9qOIi33hBj81jv8UEabewWADs2LFNCKhMTX921gz2iKvcsyw3e76BuhoiXaJcFhK
 7Fy1coJREUlubz43rPg4i6fphKpfNTrL8Tiyl4KnWxwmFPTU/hk4K3+osybCTI6k+IR1eSFoeCA
 cM8gg4x0TZINEOCUtnCprSeUQbITKZtMFw1L7YckDQbJ+C7hm9DmPeSQ0h5h1j2Gc72W+8334+o
 t
X-Google-Smtp-Source: AGHT+IE21d60jB2o9YAF2moE+D60odVDqouNX0EtxQaAYpWS+O4td3+raYZept6mJ3O2QXKgVSmDbg==
X-Received: by 2002:a17:902:f689:b0:223:5645:8e1a with SMTP id
 d9443c01a7336-22428c1cd3emr105428625ad.51.1741474753372; 
 Sat, 08 Mar 2025 14:59:13 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 14/23] accel/tcg: Build tcg-accel-ops-icount.c once
Date: Sat,  8 Mar 2025 14:58:53 -0800
Message-ID: <20250308225902.1208237-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

All that is required is to avoid including exec-all.h.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops-icount.c | 2 +-
 accel/tcg/meson.build            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/tcg-accel-ops-icount.c
index d6b472a0b0..27cf1044c7 100644
--- a/accel/tcg/tcg-accel-ops-icount.c
+++ b/accel/tcg/tcg-accel-ops-icount.c
@@ -28,7 +28,7 @@
 #include "system/cpu-timers.h"
 #include "qemu/main-loop.h"
 #include "qemu/guest-random.h"
-#include "exec/exec-all.h"
+#include "hw/core/cpu.h"
 
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-icount.h"
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 70ada21f42..891b724eb6 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -21,7 +21,6 @@ specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
   'tcg-accel-ops-mttcg.c',
-  'tcg-accel-ops-icount.c',
   'tcg-accel-ops-rr.c',
 ))
 
@@ -29,5 +28,6 @@ system_ss.add(when: ['CONFIG_TCG'], if_true: files(
   'icount-common.c',
   'monitor.c',
   'tcg-accel-ops.c',
+  'tcg-accel-ops-icount.c',
   'watchpoint.c',
 ))
-- 
2.43.0


