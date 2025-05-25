Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDD7C54E90
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 16:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJDoK-000206-Iy; Sun, 25 May 2025 12:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDo1-0001kk-Sg
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:39 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDny-00035s-TK
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:33 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a361b8a664so1630344f8f.3
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 09:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748188948; x=1748793748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F/r6BR4u92dVav+xdpPWvNWTLbsmjFwEOJ+5r16ZoMU=;
 b=K17YbPMk2MaZXiNQoNNGkixnnSZBKjja0JCMN882gxH4M2mALW6jFeI+JyUIUw22So
 qfvbOTItU+QQHn/vKRGXr5KqdME8u8mVyk8xIDiKf6BvcNV5M03X35U2ox1K7UciGB7p
 YxV3GByeveXKqIQmealgnTGma4gGyHehENnfVfMDq8bSRbP8/ey57faVZzF3p41ADea3
 pvLoJUn1QfCq4JYxdQPbDr4iq+TQmx+smZZSa1gFU4jteANghN6xxxUPdXKjyRE/Nl4v
 g8jSYJo6/h2m7tJR0nNBhwUnVZ+fj1mpesvf5ipRYrWk0gYtwDvfgURM9WKVNKDOlakc
 Cauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748188948; x=1748793748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F/r6BR4u92dVav+xdpPWvNWTLbsmjFwEOJ+5r16ZoMU=;
 b=itKhvSly1eJsnid/wtblNsUFa9aCW0fKVHZ6/8XzeMof0BsByQUZIyK4+BoNboZQpd
 mVFdQ/alBJEBiPv0snkyNRcMKkYkDIaXjx2a7PqJOPqIyWl3gDlnyCDgRTrmqdC+YG80
 wlxiFYfU3Vc3jLBTcezmq4txqkIdJR0+7KixqwUNyLfL7LMLB3sPjNnwxNXKYY9EE5wG
 V+5nd5Ay3pf2Vg2PtbXrut4/TOSA9QveQ52RRZJ0gaVmBkTlMd0SaYpXGiuUru7dr4E3
 JnBNLJSa8HUfxAO3/J4NR6hv8yclwf+73rbOb94OJcYyZXg2tcQ+OQJW8SOYtJFrR3Il
 pEWA==
X-Gm-Message-State: AOJu0YyI/uCsZRCw5if8tyHY0GWq42//h2Gu09tELJcnKPD1EygVUIFs
 M60ZoXQ+FLXilyxySjFxCkXvThkb8kXQ3FTYPhNVZDc+eDxsjkts4ngeaTYPn+s04DiaHGDZaks
 zTF7HMIk=
X-Gm-Gg: ASbGncuus3Fb+lzVAhLH0d7ooSDODmIM5SXsZlAIlX2PhQ0m1XrCmc/9gnSuP22gYqR
 wvAq+GaS1LjZSi00cWF4nz0STX5PqW2oF6NIKUtjbZ3WH2K+Tag2BLSVeb7IhtYfmJCcx4A+iKt
 qLp2t9VUY7/dH5IhZS/dYAt34jsiRoVAHYiyBYM4J+yscaQp2nT1EcjF+GSMMDzdBAx+4ivTHHj
 Ga5uM5OmuosPjuO4x9iQKgBXe0hcuQ72vTGrfX9S+AAxdZtw8jf4iRlnDW7oC8u0+/1N/W6/iI0
 hRXDc/OzHlTk5gYNX5htcl/VW9D+2epo8tTAonECA40x5JsaEU6zDj9g
X-Google-Smtp-Source: AGHT+IF4hbYItQL1TnbDGCcbpEY6gyDJ92bIaWM/7mSooKTrb8xr/S+7qiiAtTT/y4rYZPVMIvPejg==
X-Received: by 2002:a05:6000:1a8c:b0:3a3:7bbc:d958 with SMTP id
 ffacd0b85a97d-3a4cb4299camr5166684f8f.1.1748188947709; 
 Sun, 25 May 2025 09:02:27 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f73d4a3csm215772545e9.22.2025.05.25.09.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 09:02:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH v2 02/10] target/microblaze: Introduce helper_unaligned_access
Date: Sun, 25 May 2025 17:02:12 +0100
Message-ID: <20250525160220.222154-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250525160220.222154-1-richard.henderson@linaro.org>
References: <20250525160220.222154-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/helper.h | 12 ++++++------
 target/microblaze/helper.c |  7 +++++++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index f740835fcb..41f56a5601 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -20,12 +20,12 @@ DEF_HELPER_FLAGS_3(fcmp_ne, TCG_CALL_NO_WG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(fcmp_ge, TCG_CALL_NO_WG, i32, env, i32, i32)
 
 DEF_HELPER_FLAGS_2(pcmpbf, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-#if !defined(CONFIG_USER_ONLY)
-DEF_HELPER_FLAGS_3(mmu_read, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_4(mmu_write, TCG_CALL_NO_RWG, void, env, i32, i32, i32)
-#endif
-
 DEF_HELPER_FLAGS_2(stackprot, TCG_CALL_NO_WG, void, env, tl)
-
 DEF_HELPER_FLAGS_2(get, TCG_CALL_NO_RWG, i32, i32, i32)
 DEF_HELPER_FLAGS_3(put, TCG_CALL_NO_RWG, void, i32, i32, i32)
+
+#ifndef CONFIG_USER_ONLY
+DEF_HELPER_FLAGS_3(mmu_read, TCG_CALL_NO_RWG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_4(mmu_write, TCG_CALL_NO_RWG, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_2(unaligned_access, TCG_CALL_NO_WG, noreturn, env, i64)
+#endif
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 5fe81e4b16..ef0e2f973f 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -26,6 +26,7 @@
 #include "exec/target_page.h"
 #include "qemu/host-utils.h"
 #include "exec/log.h"
+#include "exec/helper-proto.h"
 
 
 G_NORETURN
@@ -64,6 +65,12 @@ void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 }
 
 #ifndef CONFIG_USER_ONLY
+
+void HELPER(unaligned_access)(CPUMBState *env, uint64_t addr)
+{
+    mb_unaligned_access_internal(env_cpu(env), addr, GETPC());
+}
+
 static bool mb_cpu_access_is_secure(MicroBlazeCPU *cpu,
                                     MMUAccessType access_type)
 {
-- 
2.43.0


