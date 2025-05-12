Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF926C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXb9-0002IL-2r; Mon, 12 May 2025 14:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXaE-0001ML-ED
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:08:58 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXaB-0000Sn-MT
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:08:58 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7411f65811cso4306492b3a.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073334; x=1747678134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rsZT/scaGxab+Vo7Y7hWrcYUC7iBy9GgtXflG2/7Eik=;
 b=PMJATSR4CwRoyP6bgnJZpATAIgQjvrmnbAwjcR5Nu9m58dyJstlTpBsHvpzl9/iZPD
 urc91BkcwrCGHdOpaKvGRriZZPwqPe5Dg0+K8D7ggA+2DKLDmXnZlx+Ha3LqY35y1YAt
 h+Ii4YfgX0vk/Wi5GVq9Zs2MQT6YGWM54Eu5t61lxMQdUJk/wjXo9C8DW9IAzWMyIFmI
 YtnttdWN+CBfgK8pf3AyaffNEJ/HuGSk/HXVufBI+XsYn17R2PoHtHpEjfIHfxlvAJCF
 bCDwj842bcnq491VX24MZrntvoyVMGlEt1kab8+9QMYVP4WeAXzvXrz7jOuB1CCe/O45
 YXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073334; x=1747678134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rsZT/scaGxab+Vo7Y7hWrcYUC7iBy9GgtXflG2/7Eik=;
 b=wY5I4U9ZRbKk0OWQU6YSOD1Te+Ud1fhKAB3O3QDpnL118beKJzF3CFm6ZoSCGh6C5/
 eoj9mlTO/PEGILRB6zgx/E7v2rql4lUeznzbPE5HPcfCy3TCDkJRKwL0bj68pKAxTAqc
 Z8lEcB3VZkTzb5JHywD0EOieYp2+kX+iMQx2ViGL5ndMLYlrKlE3mRVM/Y6vr5+0KxkJ
 d7MYPUTryIMehKfTnU39ccJ+BTlJPnhjJVutuTLRJg3LUW2hoCsAHFA/oDNrQ9Ssnrg6
 SxzMW1y8EOjDfOE5hyixhNr7hKtqDUvfgKv7YUwjzveXLV+JADXOMFQJR2oS4DtqT3D6
 ui+g==
X-Gm-Message-State: AOJu0YxLpKG5v0uTpeHZYphwlMOZOAi14oSrewNn1gFqE5UjUmuyIDko
 zA3aFGL1O+Tedu2nUMg7SzfAsr0lZjXPiHXokJ55z+weimfL3Hmgvwm40YcfROoGmhqMBxAV2ek
 P
X-Gm-Gg: ASbGncuqUvgnMzAcIddNs8DkkBfOaL5D9NCMzacBGwaXoDjBn+ZW0wKwYB4V7ZaJQvt
 Hh+x3eezAv11kDxgZ0kBUVC43Rve+JiAFw9BjJmrQM13zQZewstZLVDjqpbFKhIN5a3RaJz1vXF
 CZm2NolHG/ejav7JXyQO15us0NVsKKACiTFdx4lkS2BXbBNMqbFiKt/1twudaEPP1p99bnRVG7I
 FOAJAeLux1kVdj4FaabzH455cIu/UB3otgoJMJjwemfGajyItchkeOMV8kLXx55J/0Jxy7GT4v6
 qimRxRoRIKCGda6+N+4vh6KEp0ndpg2jDxKV6Gy26WARQnsHH6w=
X-Google-Smtp-Source: AGHT+IH6YdqrqSaks8wWBL7UflSDaRJSFa1wzyXZCbqTKawKIDKnpbS3w5JOi0gp4TZnERIb/sowVQ==
X-Received: by 2002:a05:6a20:3950:b0:1f5:7280:1cf2 with SMTP id
 adf61e73a8af0-215abb030femr18972486637.12.1747073334073; 
 Mon, 12 May 2025 11:08:54 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237705499sm6438580b3a.33.2025.05.12.11.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:08:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 42/48] target/arm/tcg/iwmmxt_helper: compile file twice
 (system, user)
Date: Mon, 12 May 2025 11:04:56 -0700
Message-ID: <20250512180502.2395029-43-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/iwmmxt_helper.c | 4 +++-
 target/arm/tcg/meson.build     | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/iwmmxt_helper.c b/target/arm/tcg/iwmmxt_helper.c
index 610b1b2103e..ba054b6b4db 100644
--- a/target/arm/tcg/iwmmxt_helper.c
+++ b/target/arm/tcg/iwmmxt_helper.c
@@ -22,7 +22,9 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/helper-proto.h"
+
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
 
 /* iwMMXt macros extracted from GNU gdb.  */
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index cee00b24cda..02dfe768c5d 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,7 +30,6 @@ arm_ss.add(files(
   'translate-mve.c',
   'translate-neon.c',
   'translate-vfp.c',
-  'iwmmxt_helper.c',
   'm_helper.c',
   'mve_helper.c',
   'neon_helper.c',
@@ -68,7 +67,9 @@ arm_common_ss.add(files(
 
 arm_common_system_ss.add(files(
   'hflags.c',
+  'iwmmxt_helper.c',
 ))
 arm_user_ss.add(files(
   'hflags.c',
+  'iwmmxt_helper.c',
 ))
-- 
2.47.2


