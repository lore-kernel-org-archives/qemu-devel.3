Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A19C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLj-0000xY-Fg; Thu, 01 May 2025 17:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLa-0000oF-Hs
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:35 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLY-0001V6-1B
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:34 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-306b6ae4fb2so1303104a91.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134490; x=1746739290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3IM3WNY4+mvaPjMT/1TSQTeg+RIG05hYdcLT8hVpAu0=;
 b=EebyiA8H9f4uQTKXGXQezAQeq++zKQhPeQnrzctxbzwgRgIfVZpDYMXvUKH4opYU7C
 7kW6F62vznf402v04HRYOKS5+Vg1+kYH4Umy5hUJJREpwvaGvLGH+s60dPcFNrHastTO
 U3qVA4b9IHFPxIwWyocmjqTw2M1Kn+PiQgMjR249G1gsxvWOWh0v16B9FbXIMrmVoznj
 D4shaf3BL62chfS2AfpdSuhba6c5y0MzEQCsfOsCpjd5HndfJBG13knI021bxkcA1OB8
 Q/1XsEPk5uNKbmOCPXdb+9UQtlTloeM5tNq5EkHWiIEe65fGo41p0Z5AQHQy1BTTFVta
 jhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134490; x=1746739290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3IM3WNY4+mvaPjMT/1TSQTeg+RIG05hYdcLT8hVpAu0=;
 b=c2u6h7okki2gHE96PNzRdJ3wByPG4ADJBTs850JXVXOkvBYfq23bxPF9pr6Vvo9lgi
 NqSRKHKM3EY9s9k0zyVJe4qQBCOYljrQ6CiSaaQpbJFEtwQvip6QecoWWJfSPpgKNJo7
 lAP6tugLBCS2ys+8yUTVZan0vV4RsCjq5LM+FK6G2vxa4PxMWgsVFWi6hVJcyKzAXhym
 /aCCcLIpf92KPBVNHEu9QS7AYxmntvhJbIgYDrGQ95PyYc5wjZn4X/CKXp9Ew7H+tDvh
 yuP6YvNkz0qwkgVErV88R4V5RVbYkyR1saYlS4r17ws+JPVpAvmiX/CR0qTFG9vaKwte
 kPAw==
X-Gm-Message-State: AOJu0YzRoQWVF61+uohCEu5SJmbN5nTzE/WCYm3GREGm5Q8dUhJL3Oo2
 2IE+j0voPjj/a8n7PlL805n34Ekf33+ThVTX4WQ4KUEB9exVI7bDbujOUAtL24dKzT/yhfXRPAo
 L
X-Gm-Gg: ASbGncuD9JHTt2LYF1fn4L0M89loFFLUEeUpGLXUygeQsZt5QKS/L1LN740h9PjYoRf
 RotZGiHBKN8ICBh2xKadgZQuSYrmX++DdHPz4uOkCH8+oG5eiLYyjWBBSAOZ5FPooveQMhc9ZRF
 ZJXATIsWVjaSC3akFs5JxAMNAc6ubF86FBvvzWy7cX7aZ7+SN45IktmZeXTxXlS7xsG83Y2S8ST
 ObncsJ1zYjBotA9B/upgtfhmANgTzmuZ7ZVWcm0mOG5/5emUbpqOMYnVWPeX1SKw2HmXTym76LD
 sjatY/wbbkluU1YFxENre/nH8oCkGtsVCqSjPjcvssGKKgyyswa2Pe/591DMEjLO67C3GkXCsLE
 =
X-Google-Smtp-Source: AGHT+IGit4o1KJyAFXlSDsyoKIM8udhg6Umqt241SC/XoNvyFEOdLW18VRudmTHyH1UwzYSd7serSA==
X-Received: by 2002:a17:90b:3c4e:b0:2ff:502e:62d4 with SMTP id
 98e67ed59e1d1-30a4e6b55d2mr720455a91.32.1746134490648; 
 Thu, 01 May 2025 14:21:30 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/59] accel/tcg: Include 'accel/tcg/getpc.h' in
 'exec/helper-proto'
Date: Thu,  1 May 2025 14:20:33 -0700
Message-ID: <20250501212113.2961531-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Most files including "exec/helper-proto.h" call GETPC().
Include it there (in the common part) instead of the
unspecific "exec/exec-all.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250424202412.91612-10-philmd@linaro.org>
---
 include/exec/exec-all.h            | 1 -
 include/exec/helper-proto-common.h | 2 ++
 accel/tcg/translate-all.c          | 1 +
 target/avr/helper.c                | 1 -
 4 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 4c5ad98c6a..816274bf90 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -26,7 +26,6 @@
 #include "exec/vaddr.h"
 
 #if defined(CONFIG_TCG)
-#include "accel/tcg/getpc.h"
 
 /**
  * probe_access:
diff --git a/include/exec/helper-proto-common.h b/include/exec/helper-proto-common.h
index 16782ef46c..76e6c25bec 100644
--- a/include/exec/helper-proto-common.h
+++ b/include/exec/helper-proto-common.h
@@ -13,4 +13,6 @@
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
+#include "accel/tcg/getpc.h"
+
 #endif /* HELPER_PROTO_COMMON_H */
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 38819a507b..0408e2522a 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -61,6 +61,7 @@
 #include "system/tcg.h"
 #include "qapi/error.h"
 #include "accel/tcg/cpu-ops.h"
+#include "accel/tcg/getpc.h"
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
diff --git a/target/avr/helper.c b/target/avr/helper.c
index afa591470f..b9cd6d5ef2 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -23,7 +23,6 @@
 #include "qemu/error-report.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-ops.h"
-#include "accel/tcg/getpc.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
-- 
2.43.0


