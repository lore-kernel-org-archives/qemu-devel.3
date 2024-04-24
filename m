Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB7BC19F4E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzldT-0003mA-DU; Wed, 24 Apr 2024 19:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldR-0003l7-UO
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:41 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldP-0002eA-JL
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:41 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ecee1f325bso441777b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999758; x=1714604558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yq7gfhqzCEYtWciBbW30RRAKn3Q931Bk5u6D2pAF6UU=;
 b=oUBw6HnugmgtnHSy90lqeLge7UPZplMGuYSYmnqX01psRsWjDjqDQ9rdjJghTnhTEQ
 /QpDlmuXC35Z3lv7YM/rdZHA+h01aJEPjhKMuEHhOp29iHkfDeYG2p9P3583belVkIsZ
 5Vl/e2s9lpKur67j45NnbEd2aPazmZEV+a9RZG8sF5hRqwmhEIFVMX4S0F0FkpWQYcG5
 0KB/Q9mJAcHjKMvMJhca6edv9qF811iVrSqNK5BOivBGS/5NiLZIcgdw/f0pmofKhHH5
 maCrBi0SesQs+457UUjXlzTqGKZYXF4YBELmsq91znB0d9yNPGb9/KkGIw65lLwh/ALJ
 w+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999758; x=1714604558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yq7gfhqzCEYtWciBbW30RRAKn3Q931Bk5u6D2pAF6UU=;
 b=AR8dYhHuSlJnYABP8KklkDXL5CgRse1x5MdQEO0nszf8zoZjVCnahnMW+f75JqztM7
 /yecg/H9h4lVDMBWS45dftxyuFzVa4UEQSDmkKyTx/4YOwFNLVLIyBYaFwUv6FSszESv
 pt1zveMQUP5T7CcOEM8RlI6E4q3hYKTYi7o90Hhqh6nMxatvRZGN0O5BGcKWR1B6/KTA
 LVe9kregTpNMa6+qJiA3nQUDDAggOFstxdA/YXIhxtrafIRaeWKjq/ln8Qvh1FtZh8sM
 PEB/r9qUud49KrCQpXeHf5PtpdVdZ3KVNUZHOPhzJXrrpP9jkG+wCfo89I1LsGIe22br
 rXHQ==
X-Gm-Message-State: AOJu0Yy0Vn0GloSwjlEKLoIwAZVz/QgLxccRtsYNNWwBPrCD3W65Hz6W
 Nva30rMSpaAjSQjN81pQfi+YyHgZJQ4TcxTIJBiMFmISLp29FBM2izNAE66q/iQCSKwa03aUsbM
 v
X-Google-Smtp-Source: AGHT+IFLY9H7ijCDCFdukNknUaLFzCWx0hU9FuzLkcuze64niDXJniTGOR0dlJcVn7dtD4spSWSK3Q==
X-Received: by 2002:a05:6a00:4fc1:b0:6ea:d61b:edf4 with SMTP id
 le1-20020a056a004fc100b006ead61bedf4mr6794180pfb.7.1713999758287; 
 Wed, 24 Apr 2024 16:02:38 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h5-20020a056a00000500b006ed4aa9d5c0sm11981405pfk.188.2024.04.24.16.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:02:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 11/20] plugins: Remove plugin helpers
Date: Wed, 24 Apr 2024 16:02:15 -0700
Message-Id: <20240424230224.941028-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424230224.941028-1-richard.henderson@linaro.org>
References: <20240424230224.941028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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


