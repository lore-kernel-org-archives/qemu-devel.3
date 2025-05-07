Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4144AC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoVG-0003Se-JV; Wed, 07 May 2025 19:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoTe-0000cL-Iz
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:47:03 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoTc-0003AV-Uy
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:47:02 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22fa48f7cb2so349765ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661619; x=1747266419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9+0A2smB/xfpAp/1FKWxfsvzCeqir2otJn6Vwgzfpo=;
 b=Co1OrU4veQnpKXk8rrKX964urj+7paZxiZRDdbODWSvW2d4brDwT4JXz37vbGbUI+S
 lu+HtqxedbBxbamh/KL4V/E9gubfqn/Lg4Yx5LL4d4bIHC409IdubSqPlG9hplocIht5
 oQeahf7WLAy8oITBpi2oTQK3TZ3Bh/qoAy9ACd4FsPqqNVTxxmVD7RCS66X1hcswWNER
 dgGTdun/rUGQh6kk1TRGzOFveFULOkK+4lq42A3Itxf4Lsu284KBypajAg2B60SKgBCr
 zokK+cVAM+iPv6U42MvcTqpj/uxT0cnjzgYOmOn+83NevtZAzGW5NqJ1dxdA+7ptqoUZ
 LHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661619; x=1747266419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h9+0A2smB/xfpAp/1FKWxfsvzCeqir2otJn6Vwgzfpo=;
 b=ndb4MIKfiGDiOUt2RPmvfTP3nHKYAgr6prUP6t/4P6KzZoZZp2Ad9DT1rPIxtRgbiX
 F2UPv2b6pu979wZIjaHoyp9ccKg2LH5At2loS5UrGzH5rsA/PC+BsDx8M8Fc6cMOKEb9
 rDoxczp08mMTynFNje57k7sQDLqJbOOOBDxPBv9HwXJC1nU1S0iXeq9IBBX2Qz9g1Qel
 a2OMK5cdbDIqWb7BENuj0EppfJmOqgqrlM1cigILF392S5U2NzRJfc26rNoHPhgoUXoY
 ZIq9ni4/uBYCbtOEUlo1CoNcuPqXpiQDLMB60epkokbovtkMHfTWjYg1m/kixgxjosPy
 TUHw==
X-Gm-Message-State: AOJu0Yxskn8SVz208nRqGpO1rPNS/mtrrMeHqW5Ratt+0aRIcxbG+SmJ
 ZGZ6jYA3D/ZKfyy9dkYWl5t5eRT1quqN8RDACV/SQQmPTxJdrPRMIAAHiVXkkdwCLUnirinTFVj
 gnZ/cqA==
X-Gm-Gg: ASbGnctDykQ+eem7CGtWF79J8cuxezoQFPRTZuZxvbG7uy90AAE62qKlYnLLT8hzwmW
 mECGLH2mR+Rc5ZgGTf0CnDhnSt/LY2OERpcOhRxEvBzofOVII/VgTXIlMwRvKFkKXirw3IGURhE
 fxC68X1/YW0hUdPeENyPxNtV2z3PBn94uZjwROy5kbjwdLPTtStQfkSNZCp2vmob0ow5e7HnGij
 IqU9Vt+0O8OJ5Y3K59FWZhELYj+6oqBrW3kdpQ0tcqmhre7uYVEFpOPKDUhQxl53r4x7tuy4XeH
 VMOIZ4dzlEvX1fptrkZojy7JnW1/myP150N9sBeG
X-Google-Smtp-Source: AGHT+IFD7JLl7PMkprSB+gonsSnigWdQwt5Gm7vQMOymA5jKMQ8arRw0rvIvBHmHIJgyHjopluQ80A==
X-Received: by 2002:a17:903:166e:b0:224:c47:cbd with SMTP id
 d9443c01a7336-22e5e98947fmr80767545ad.0.1746661619500; 
 Wed, 07 May 2025 16:46:59 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e97absm100792435ad.62.2025.05.07.16.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:46:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 49/49] target/arm/tcg/vfp_helper: compile file twice
 (system, user)
Date: Wed,  7 May 2025 16:42:40 -0700
Message-ID: <20250507234241.957746-50-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/vfp_helper.c | 4 +++-
 target/arm/tcg/meson.build  | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
index b32e2f4e27c..b1324c5c0a6 100644
--- a/target/arm/tcg/vfp_helper.c
+++ b/target/arm/tcg/vfp_helper.c
@@ -19,12 +19,14 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "fpu/softfloat.h"
 #include "qemu/log.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 /*
  * Set the float_status behaviour to match the Arm defaults:
  *  * tininess-before-rounding
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 7502c5cded6..2d1502ba882 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -34,7 +34,6 @@ arm_ss.add(files(
   'mve_helper.c',
   'op_helper.c',
   'vec_helper.c',
-  'vfp_helper.c',
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
@@ -68,10 +67,12 @@ arm_common_system_ss.add(files(
   'neon_helper.c',
   'tlb_helper.c',
   'tlb-insns.c',
+  'vfp_helper.c',
 ))
 arm_user_ss.add(files(
   'hflags.c',
   'iwmmxt_helper.c',
   'neon_helper.c',
   'tlb_helper.c',
+  'vfp_helper.c',
 ))
-- 
2.47.2


