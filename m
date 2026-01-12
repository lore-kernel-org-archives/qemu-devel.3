Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6B9C9EC67
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFCX-0000kW-4M; Mon, 12 Jan 2026 05:31:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFCK-0000Qh-Lp
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:30:58 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFCH-0001eF-6A
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:30:55 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42fb2314eb0so5143101f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768213850; x=1768818650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iuteZZxP72AdlZG/ZllJpEmgG/znqQ6KfrKPEYlPSPU=;
 b=RHIpCqsehl4bge5RejRPLxpoE8U3D9o8Os0ghh2qzGztC5QWXAFrfxU7ldi5Z10eAm
 9bn7ny7I+U4KtmXFGfbgoODIa7oBtFJTVlbeoo5ze1eCfLpNtql7au4+dJwtlW//qhdc
 11krX4N99bfSnhQX8KTj+qDRXQv84qXHkAyvnH6VUONGljGd4EUmYOFU9tTZcuzp0/pf
 Glar4sQA1dHxz8QniQMFJZIZjWtY2PV9VW0DmRQXy2jQAJFzXTeSKWprnbZBYTQbGXU/
 McMH+butvmsCWMv29s1Xtc6uLKgCnHUjHGDkNKqnzCGKmLd6K4gUAT6zN6ZErLvK9Xg4
 Z9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768213850; x=1768818650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iuteZZxP72AdlZG/ZllJpEmgG/znqQ6KfrKPEYlPSPU=;
 b=XWaqh/EkeAaUBPVpR5CheeNgljFueyozBA4Gaw10sM1UJ5Hxhmhh0OyAKE13KZjJPV
 ouOexrC7UcyBpz7bOKmKAR2VBaJcdigrDPMymTVKSJCsM5KELftfNWwqw2GcaAyP722p
 Lyg0ZThCtNAuAK7Oh7CojaskDIazu2l/R68m3+MlJ6xQ01YIi3BV2/m4VoT4F7D5LaRp
 41kKZycOPheHlRjfhN129lqlM9Z/31sYwje2VRgeRrB+x7cP23HAd/6F8Hw4fs7JZ0hT
 UkmmDW1EO4qe0Kwe922kkIsklmF2qaiXKBMLaHTI9z4OFOWK6uQ83od2KarJqdr3Mxwf
 uHGA==
X-Gm-Message-State: AOJu0Yy0jVoTdBzOxTSJeDuIAYtF/SclX+p3WP1Fo1JTEo0NKBnUjZC6
 04MDQgKMUzHHWk1ye5ry0dfJAY7F10vAJrvTiNQp7+mNaXjoiDMeAM75rJHBNCbiy9ozE8ghN0p
 fBaC5lLM=
X-Gm-Gg: AY/fxX5qEXOK4UpXqH+yqHqmufDDic5UeGT1FyDFWjtKtwrcpDu9CGmVel+AGZEu7P6
 fYiiVrLlbOmzQasCbyClGL+HU1+2pyysyI4GcWo/sTB+qjanWGfdzR5Ts+AIibn8qpyA7PcV5GJ
 /yxNeR8DEv1AX6NUjwX4aG2ZcH/aADpHvKMeDFbJgu7XUiNpsIdO8mkQdVBF/4ewzynCYcVfwXl
 +7mndvH90PqJaXxX66JC+Gu5Xi87EQDV3jflRqx/e4fwi/6k8v3HYGYh2ljVIPlNoEasiAva9R6
 HLxecq5y8eouSjcrFzOGBPxqhpnOyTQOJjfaQ9tEtoS36/qSB5UIotmG9iqns2gnzO+//ZrFxTS
 2R+2Xsq4S8im310maW0f86kf5TVu+HkOs1eL98evJ8rnDrs732sKZg2E9z8T6dxQD716n4MOqUl
 KSXswcbLZjadc1ML2oipiDjDpChQ4Q5hgGmPtmdjA+7d3OAVHR3i0Tk6SFx/S3
X-Google-Smtp-Source: AGHT+IF3ZTbLdnzutbrVwqWTwnPZgqWmiDXh0eTf7bS3s1GZRQU2C189gzuaYXrsvaFVRd2tv+1gxw==
X-Received: by 2002:a05:6000:4313:b0:433:1d30:44c with SMTP id
 ffacd0b85a97d-4331d3005d3mr1641586f8f.43.1768213849925; 
 Mon, 12 Jan 2026 02:30:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e19bfsm37495823f8f.18.2026.01.12.02.30.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 02:30:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Joelle van Dyne <j@getutm.app>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Nguyen Dinh Phi <phind.uet@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Collingbourne <pcc@google.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 02/19] target/i386/hvf: Use host page alignment in
 ept_emulation_fault()
Date: Mon, 12 Jan 2026 11:30:16 +0100
Message-ID: <20260112103034.65310-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112103034.65310-1-philmd@linaro.org>
References: <20260112103034.65310-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

While on x86 the host page size is fixed to 4KB, it is
better to call qemu_real_host_page_size() for consistency.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 target/i386/hvf/hvf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 2023a7bfbb0..731cd954630 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -76,7 +76,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/accel.h"
 #include "target/i386/cpu.h"
-#include "exec/target_page.h"
+#include "exec/cpu-common.h"
 
 static Error *invtsc_mig_blocker;
 
@@ -137,9 +137,12 @@ static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
 
     if (write && slot) {
         if (slot->flags & HVF_SLOT_LOG) {
-            uint64_t dirty_page_start = gpa & ~(TARGET_PAGE_SIZE - 1u);
+            uintptr_t page_size = qemu_real_host_page_size();
+            intptr_t page_mask = -(intptr_t)page_size;
+            uint64_t dirty_page_start = gpa & page_mask;
+
             memory_region_set_dirty(slot->region, gpa - slot->start, 1);
-            hv_vm_protect(dirty_page_start, TARGET_PAGE_SIZE,
+            hv_vm_protect(dirty_page_start, page_size,
                           HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
         }
     }
-- 
2.52.0


