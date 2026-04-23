Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0C8F99363
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqtb-0006PJ-RP; Thu, 23 Apr 2026 06:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqta-0006OH-8A
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:54 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtY-00023d-2L
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:53 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso59719605e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938571; x=1777543371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z74Lu1fNc2TIQf0Sy4MvTYdXdhFVZWUeva99aw7JFVI=;
 b=iYBIATGRvNHaBQf7GUf1fsq0StwxU3GexHbc9cbxPws2YvaMUImUVfz8F7rqnFt1HV
 NAUFMyPf22Hzk13EyLstJtIadaYdCPze+9AB5fLOWD+FjUrVlE+74XOIngzPPU6Zhm5W
 wZoCbEbEYspyb8LU04/A8qwlggf0cnMxyWmE+f7dR8w090Pwb5/lDcMRnV/9fof6Ax8D
 z3mJ/VPNJAmYFyA+clPdauQf9AqsSiJiO28O+FbsTqjLB/aHZrIGMKh8Jf3Vg/ajWsjV
 rg4a3i3rjW/B3gF0oy3SmHdiU6svhtfbuT4b+Fmq44ZWwoaKUaNoQ5NVH9X0dFFgCjJ8
 RaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938571; x=1777543371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z74Lu1fNc2TIQf0Sy4MvTYdXdhFVZWUeva99aw7JFVI=;
 b=mjVSIB8vb711ZoM8k5IDzBiFRzTGyx4qSM20Tw+cnXyepCukZCKdUyQvZQhsvAC44q
 0GHdELfPm3piBDNS4ZREosjCRtKRDOxAelPdM3zvE9dTJtXaHPllq9K4YVNvKTCsTWNv
 bikpEbH+TFAZ3sBQb1UtbR0ES4WI8N+tk9JAdV9hBSNqHkUAqqRMMOVynCIQ9JRoLOfh
 3yExVtnEvBuWjh65n4MO5oDzuFrjqvGPdZxe5/NQ77bV44HeJX2oyGt86ZJ1Ra0Z6H9L
 KVAGtLgt+miK6UiRQhHz4gpXEZYT/lYfYnJR9xyiVIlNkWhtYkxxvKpZZ82+6MoNQBQR
 6Onw==
X-Gm-Message-State: AOJu0YyJR58MWGn4E6Lxe7GswLUs+llHBxM6HXFnkv1smpWNaz4KIBRY
 pUnroXcdIrFOcoPnnuChywqIlmzURmr5wPja85opt8XNA6cDR6Vlx4RWMhkpaR/Deaeisq3luOx
 r4TAK
X-Gm-Gg: AeBDievGI2jvvAjo6pepCQ1rGhREgUFNAOD3DCGIbb5noPzW5DjtUt/CsWwq34hFXfK
 7LDW05FXUhpukPbT9vOwpFlZ5g+QsBdQE5XQLtArG0ANzSFaFeA9X1XTmrQ9DixPMjQDmvv1tkf
 AYiJrIpQD8GT6xbIrKpYMsrWS3aLsp/javPKgO0EyRO+M3h0utHLf/pCkf6MqZGZyyGnWTxkqnr
 1TB/cV4vr9zIzz7qrvv6W03oNXO6mKBFAPoJRJYicJWVmCidMaGAfWg/CmVFT6W7TSZL4yZLqsL
 oD7eqMG7K1EX4JjfkDId8f+DgmIMrs/UXSaWrMwySn5phm01LEsSnRzgl23bXnN25+HsUoh0qsP
 5X8yuMyOWYiuRFtIVaCB3NZ1ucbrDmCBphIHpjMbP9kVgTq4oIx3UDzcyCDA2oKz3o8lOzzYFLF
 6D5z+ajbet/kq4J/+NbRee6mNbMGsZuvRMIe6GaUGAYclTjT9/UZCdqAVsJ419egYBKADlQcWNn
 pAlJi6IY3j0B4ZMPlaM4HdN8fWRASduc7iLZps1bg==
X-Received: by 2002:a5d:4b81:0:b0:43f:e721:76ca with SMTP id
 ffacd0b85a97d-43fe7217864mr24232256f8f.45.1776938570520; 
 Thu, 23 Apr 2026 03:02:50 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/59] target/arm/tcg/op_helper.c: make compilation unit common
Date: Thu, 23 Apr 2026 11:01:48 +0100
Message-ID: <20260423100229.2941820-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Remove unused header accel/tcg/cpu-ldst.h that has target specifics.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260407222208.271838-10-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/meson.build | 3 ++-
 target/arm/tcg/op_helper.c | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 70beec7a6c..1fa2667058 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -37,7 +37,6 @@ arm_ss.add(files(
   'translate.c',
   'm_helper.c',
   'mve_helper.c',
-  'op_helper.c',
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
@@ -74,6 +73,7 @@ arm_common_system_ss.add(
   'debug.c',
   'hflags.c',
   'neon_helper.c',
+  'op_helper.c',
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
@@ -93,6 +93,7 @@ arm_user_ss.add(
   'debug.c',
   'hflags.c',
   'neon_helper.c',
+  'op_helper.c',
   'tlb_helper.c',
   'translate-m-nocp.c',
   'translate-mve.c',
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index aa14f15eb6..75ad53ec6c 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -23,7 +23,6 @@
 #include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
 #include "cpregs.h"
 
-- 
2.43.0


