Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895C3C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBvy-0007wq-4u; Wed, 28 May 2025 04:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvd-0007uX-5d
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:25 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvZ-0005DM-3n
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so4680345e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420059; x=1749024859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ut4ejvSFbwk24WYmUsrI+zOUaG8BYhlKDaBtnXw+HS8=;
 b=SPedQGEIDnEepD71FVNZ0QUYNnztKmaM1rXJIbm3FTIxvP9r5JNnVAZX99WUll/IA3
 fLZa2GnuV5hgwPJKRgi/BnD2IsqU60nHQBECg4wlZolGGGZJBSK3AWDN7j/glpfcJT07
 9ouPbqJvrg3Kl92jLNAJ2+KWmvdsMRw6WtndhXKPozjdyYUGE/Ama8s82UvTb+NhyuAY
 mPFZqiK0Q3HDhJ76J53AGsIJu7XATuDlJIt+HGtP4cLfj7H5xhjy3xyIrkukYiqrjkRN
 nDXotmmy2+VnI0sNY6m7zYYP+gLjDIluAh11fy8GOrzlEzprfJI3tdMLEGWixaiIYEpJ
 AS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420059; x=1749024859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ut4ejvSFbwk24WYmUsrI+zOUaG8BYhlKDaBtnXw+HS8=;
 b=ur9+zmTQInjsN0PD5+P5opUh1aV3fBzu/RkUWLRpRpZXU+IQimv/tnXGY98klxg1WM
 eQ041JY5eMO9EuHifZE8AeFORfmdG9/wKyHAVGp2zoINHz37pQQRut0xtbU08LFgPpi7
 4wZZAHiIqlwxiMxEGeq0kr1M+b0gPa6kosCyhpeGEPhzxwGmHX2Xk8BkpbyifaMYxyDZ
 I+wjYEAKVowVRzcUJw7kAT6//LB8hxxriAEYXauUIRjbCCQzMl4wdXfp2OiadhNEgMgo
 rAwb++Cb7e107S/L8MINt1dd0PlMhPnKXHZc6TaRCB+iHhTt3RsK97d85R0+UFFbVdQM
 9duA==
X-Gm-Message-State: AOJu0YzZa6jqGmtJS9EnWVpKYX3Uqc4X7ZhqljIOuQ5F18rvBbpziyNJ
 yZKYy7LWgW43Y+R6VTAjdrgOHtOeBYBJCB2R9nzrTcj8ZOaOPKy6Kbky9RbOGhIcLvB75T45hnF
 Yavm8BpZf2Q==
X-Gm-Gg: ASbGnct+tgrfU45nLgMwp2+onKd9ln05Xm/fMsqi8qxvJ2K9CUZQSuevJVpUAWxf6wb
 UM2kUKpWjwb3TFmIU0t6kDFcKq/dnY908XA74uWic/f8c8TF0FddgxbzFmcOFMAFdBl6bP6v134
 l6blr/qWo1ZOLwRCAHkjdNbUfQhQKqhM3N6EczJgP6Cj8y15YN0cnpzrlSYK4lBcnjuC52mGOth
 I/9bUF6rJMsxxEtBx/VY5Hvzph3eoydXyzRdCFdrPKRDrSVs0Rd/msuL9eR/FgrsUHldCEwE2ho
 8u/5UTtxR9JdBjnGseoZNNIbsByZKAPv90oikMaMgsB92FhHNEoJl6/i
X-Google-Smtp-Source: AGHT+IHDaPg47xHcNY9CFznaSo9r9DF5MMIv5a/BXj2piooLq/jd6/kIvG3AsVEIvFoo8SFsThAm5w==
X-Received: by 2002:a05:600c:46c7:b0:442:7c40:fda4 with SMTP id
 5b1f17b1804b1-44fd1a02059mr32882895e9.1.1748420059518; 
 Wed, 28 May 2025 01:14:19 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 05/28] target/microblaze: Introduce helper_unaligned_access
Date: Wed, 28 May 2025 09:13:47 +0100
Message-ID: <20250528081410.157251-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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


