Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109C8C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 14:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2B6H-0002va-QO; Wed, 01 May 2024 10:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5n-0002h3-IZ
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:56 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5l-00029C-7d
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:37:54 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ec92e355bfso6587915ad.3
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 07:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714574272; x=1715179072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yq7gfhqzCEYtWciBbW30RRAKn3Q931Bk5u6D2pAF6UU=;
 b=qXotNAux2/Veppk9v5okXtsAUrjFB/1Xbyl6tDFWSH7EQKPXbJv1853CEg3XdoRcIA
 0iXCp7h8JItymWUDAR3Y49GKFMIKtm8b3l0W5NaQgQ6h6pE7eHT1HrJH45VNWnpXok1x
 vRmQEzFVKJ2dVNDZ1UTMiyy49fwdsFnFDq9gDXZwzBlAt58FjIH83vZfwhCSGD7BpA89
 tZtq/KbYPnVNfpWLggJp7nMVzJ8G4vJ5O3+4Htx0+J7sM7X5M2I3MyKXFvu7zku240Um
 6F5/f7l0VoqWiDEVVIAsltSJNdJ8EB200nchMjy17vTSZKLwInZEY1fiDoaapJW4ca3C
 +QvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714574272; x=1715179072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yq7gfhqzCEYtWciBbW30RRAKn3Q931Bk5u6D2pAF6UU=;
 b=fA3tds+EqvoAE3OUWEELkM3TCBfEkMvWq0FLFBkwO6h2OgWRo1lhsUFCRJce41zaeW
 Ass7ZIJY/oVRi5/yD02S6CC+su5+57SZGNocRnl4obMbIt9LBzYC475/HSuILbE3eIEr
 NLUGorRlyMeiWQCSxtxkA0mToi3EfaRrAsIGuniUqWAIdRhMWYqWU+uH7r8s4K1gx8ry
 rP4Jyua6Nm48VEAMM2sEhvPfVptOSzuKmgilbXMYN0pzqWbXO55OWe1vJGaM5HXCtpaL
 9porNrjl/KdFXWiyFIpQVXZ/5VMr4tauQ5kEjrkwZtCmhUvCtA/TFdtduoV4N/3L8rcv
 lR7g==
X-Gm-Message-State: AOJu0Yy2xcdo0Hp3ggqcKNDtrExgH9xs1SRNYWEo93gOuSvrhKTiKMTf
 1HlpsWhwqLetAiC7QBR6dn32x4vJ88C34u9gPoTw5s0/gtas7FSBEQMy0ZES5gHqu4K1BZwn+RR
 k
X-Google-Smtp-Source: AGHT+IERjOeGyLscDHR4/uVthkzGM0yBS09pHx667iykXlG0tWhhytlqhomjzlyiYJT1XP9U94bCgw==
X-Received: by 2002:a17:902:ee84:b0:1e5:10e5:b66e with SMTP id
 a4-20020a170902ee8400b001e510e5b66emr2286173pld.27.1714574271727; 
 Wed, 01 May 2024 07:37:51 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f54c00b001ebd73f61fcsm5751573plf.121.2024.05.01.07.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 07:37:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 11/20] plugins: Remove plugin helpers
Date: Wed,  1 May 2024 07:37:30 -0700
Message-Id: <20240501143739.10541-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501143739.10541-1-richard.henderson@linaro.org>
References: <20240501143739.10541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

These placeholder helpers are no longer required.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-helpers.h         |  5 -----
 include/exec/helper-gen-common.h   |  4 ----
 include/exec/helper-proto-common.h |  4 ----
 accel/tcg/plugin-gen.c             | 20 --------------------
 4 files changed, 33 deletions(-)
 delete mode 100644 accel/tcg/plugin-helpers.h

diff --git a/accel/tcg/plugin-helpers.h b/accel/tcg/plugin-helpers.h
deleted file mode 100644
index 11796436f3..0000000000
--- a/accel/tcg/plugin-helpers.h
+++ /dev/null
@@ -1,5 +0,0 @@
-#ifdef CONFIG_PLUGIN
-DEF_HELPER_FLAGS_2(plugin_vcpu_udata_cb_no_wg, TCG_CALL_NO_WG | TCG_CALL_PLUGIN, void, i32, ptr)
-DEF_HELPER_FLAGS_2(plugin_vcpu_udata_cb_no_rwg, TCG_CALL_NO_RWG | TCG_CALL_PLUGIN, void, i32, ptr)
-DEF_HELPER_FLAGS_4(plugin_vcpu_mem_cb, TCG_CALL_NO_RWG | TCG_CALL_PLUGIN, void, i32, i32, i64, ptr)
-#endif
diff --git a/include/exec/helper-gen-common.h b/include/exec/helper-gen-common.h
index 5d6d78a625..834590dc4e 100644
--- a/include/exec/helper-gen-common.h
+++ b/include/exec/helper-gen-common.h
@@ -11,8 +11,4 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
-#define HELPER_H "accel/tcg/plugin-helpers.h"
-#include "exec/helper-gen.h.inc"
-#undef  HELPER_H
-
 #endif /* HELPER_GEN_COMMON_H */
diff --git a/include/exec/helper-proto-common.h b/include/exec/helper-proto-common.h
index 8b67170a22..16782ef46c 100644
--- a/include/exec/helper-proto-common.h
+++ b/include/exec/helper-proto-common.h
@@ -13,8 +13,4 @@
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
-#define HELPER_H "accel/tcg/plugin-helpers.h"
-#include "exec/helper-proto.h.inc"
-#undef  HELPER_H
-
 #endif /* HELPER_PROTO_COMMON_H */
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 8f8ae156b6..fb77585ac0 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -51,11 +51,6 @@
 #include "exec/exec-all.h"
 #include "exec/plugin-gen.h"
 #include "exec/translator.h"
-#include "exec/helper-proto-common.h"
-
-#define HELPER_H  "accel/tcg/plugin-helpers.h"
-#include "exec/helper-info.c.inc"
-#undef  HELPER_H
 
 /*
  * plugin_cb_start TCG op args[]:
@@ -82,21 +77,6 @@ enum plugin_gen_cb {
     PLUGIN_GEN_N_CBS,
 };
 
-/*
- * These helpers are stubs that get dynamically switched out for calls
- * direct to the plugin if they are subscribed to.
- */
-void HELPER(plugin_vcpu_udata_cb_no_wg)(uint32_t cpu_index, void *udata)
-{ }
-
-void HELPER(plugin_vcpu_udata_cb_no_rwg)(uint32_t cpu_index, void *udata)
-{ }
-
-void HELPER(plugin_vcpu_mem_cb)(unsigned int vcpu_index,
-                                qemu_plugin_meminfo_t info, uint64_t vaddr,
-                                void *userdata)
-{ }
-
 static void plugin_gen_empty_callback(enum plugin_gen_from from)
 {
     switch (from) {
-- 
2.34.1


