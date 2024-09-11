Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5314FEE0213
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 06:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soH83-000123-27; Wed, 11 Sep 2024 02:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1soH81-0000uZ-9c
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:47:01 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1soH7x-0004Qb-DY
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:47:00 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8d0d82e76aso94481266b.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 23:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726037214; x=1726642014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tWtyuSRUTsWzQ32wwrFhhMFhvMFudHu/cgYl3t03m1M=;
 b=FBkP61zrISEZPwIkiKP0CVqf4U45kPlAbU/poCcOX2UAeib5dxuRyjXubitD9cdGzL
 tasz5WcOkbGsIa2hukZZhGFsBP55mRa4Vb+lCB1shv3EGfOJZIMp5ctpAuFMppOz3fzw
 aXxAmNDEV/yLWG1O7ciq8IEw4oM8U9sTuV81s3dUky/WSML9fSyRhw6ysVEQgL6EmENa
 caM/8yLD+pZZgGacUq2lol6TMOwMPmtKhIhiICGdNTX7994zYJHhilSYHWXpX1NOZu7z
 56QID2mNtGy/kXn2e/pIgZXXBA9k/hh5aXCcdyCvjlZ55vFC7lFbwyrrsTGUZ23k6hxL
 Azyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726037214; x=1726642014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tWtyuSRUTsWzQ32wwrFhhMFhvMFudHu/cgYl3t03m1M=;
 b=WJTCfFPCqMES305+arovjUIOMW10eQdUIAyYN4nJxNJyBRjo/kmkySx9RhmeMPImRt
 E7I7qEuL9grRW1N0Ss25D4acOssn3sujHmvx2FRMXsDmDkX3p27B1LgVWGJLR/AFS2A0
 91HiisDLZYJsOIEzNsEcpSYauhDDZE3ySkDI61/mjhe5qWNV76m/yzuYcYK8bCcV2oCC
 w/MQf7RYp7cPuSL0qtTc/IagdjvuOmdbHLmZMiMIrC8aDi0jeys4ycDA65zvcSD0g25b
 1O50E9jFag/WeocS71us0YEBLCPdCYrWzwgukUFNiu0M96uVZixWbHy0fHoc91I8uIS9
 j9JA==
X-Gm-Message-State: AOJu0YzCDx7FvolB2UUean5pJxd6jyW0w3InIAH7QeC6vJbjMjTxQzbs
 XSVsSHP9hIDtMQjqnDewZZc22YFTynVB2Lh7qAhPlYwFcC32/5Sue/KP3mOiQpc=
X-Google-Smtp-Source: AGHT+IGKPjMsWlYh7lcQzXd0X9RGsdwNKlXMel3vbwkODaGBibXovDqAD83FsypmJjU5GGokdIWZgA==
X-Received: by 2002:a17:906:d550:b0:a80:d913:be07 with SMTP id
 a640c23a62f3a-a8ffab88f5fmr326396666b.36.1726037214068; 
 Tue, 10 Sep 2024 23:46:54 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd8d9d2sm5118539a12.90.2024.09.10.23.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:46:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 961D45FA11;
 Wed, 11 Sep 2024 07:46:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 06/10] gdbstub: Use specific MMU index when probing MTE
 addresses
Date: Wed, 11 Sep 2024 07:46:41 +0100
Message-Id: <20240911064645.357592-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240911064645.357592-1-alex.bennee@linaro.org>
References: <20240911064645.357592-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Use cpu_mmu_index() to determine the specific translation regime (MMU
index) before probing addresses using allocation_tag_mem_probe().

Currently, the MMU index is hardcoded to 0 and only works for user mode.
By obtaining the specific MMU index according to the translation regime,
future use of the stubs relying on allocation_tag_mem_probe in other
regimes will be possible, like in EL1.

This commit also changes the ptr_size value passed to
allocation_tag_mem_probe() from 8 to 1. The ptr_size parameter actually
represents the number of bytes in the memory access (which can be as
small as 1 byte), rather than the number of bits used in the address
space pointed to by ptr.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240906143316.657436-2-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240910173900.4154726-7-alex.bennee@linaro.org>

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 5221381cc8..85a19c14c7 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -435,6 +435,7 @@ static void handle_q_memtag(GArray *params, void *user_ctx)
 {
     ARMCPU *cpu = ARM_CPU(user_ctx);
     CPUARMState *env = &cpu->env;
+    uint32_t mmu_index;
 
     uint64_t addr = gdb_get_cmd_param(params, 0)->val_ull;
     uint64_t len = gdb_get_cmd_param(params, 1)->val_ul;
@@ -458,8 +459,10 @@ static void handle_q_memtag(GArray *params, void *user_ctx)
         gdb_put_packet("E03");
     }
 
+    /* Find out the current translation regime for probe. */
+    mmu_index = cpu_mmu_index(env_cpu(env), false);
     /* Note that tags are packed here (2 tags packed in one byte). */
-    tags = allocation_tag_mem_probe(env, 0, addr, MMU_DATA_LOAD, 8 /* 64-bit */,
+    tags = allocation_tag_mem_probe(env, mmu_index, addr, MMU_DATA_LOAD, 1,
                                     MMU_DATA_LOAD, true, 0);
     if (!tags) {
         /* Address is not in a tagged region. */
@@ -478,13 +481,16 @@ static void handle_q_isaddresstagged(GArray *params, void *user_ctx)
 {
     ARMCPU *cpu = ARM_CPU(user_ctx);
     CPUARMState *env = &cpu->env;
+    uint32_t mmu_index;
 
     uint64_t addr = gdb_get_cmd_param(params, 0)->val_ull;
 
     uint8_t *tags;
     const char *reply;
 
-    tags = allocation_tag_mem_probe(env, 0, addr, MMU_DATA_LOAD, 8 /* 64-bit */,
+    /* Find out the current translation regime for probe. */
+    mmu_index = cpu_mmu_index(env_cpu(env), false);
+    tags = allocation_tag_mem_probe(env, mmu_index, addr, MMU_DATA_LOAD, 1,
                                     MMU_DATA_LOAD, true, 0);
     reply = tags ? "01" : "00";
 
@@ -495,6 +501,7 @@ static void handle_Q_memtag(GArray *params, void *user_ctx)
 {
     ARMCPU *cpu = ARM_CPU(user_ctx);
     CPUARMState *env = &cpu->env;
+    uint32_t mmu_index;
 
     uint64_t start_addr = gdb_get_cmd_param(params, 0)->val_ull;
     uint64_t len = gdb_get_cmd_param(params, 1)->val_ul;
@@ -527,8 +534,10 @@ static void handle_Q_memtag(GArray *params, void *user_ctx)
      * Get all tags in the page starting from the tag of the start address.
      * Note that there are two tags packed into a single byte here.
      */
-    tags = allocation_tag_mem_probe(env, 0, start_addr, MMU_DATA_STORE,
-                                    8 /* 64-bit */, MMU_DATA_STORE, true, 0);
+    /* Find out the current translation regime for probe. */
+    mmu_index = cpu_mmu_index(env_cpu(env), false);
+    tags = allocation_tag_mem_probe(env, mmu_index, start_addr, MMU_DATA_STORE,
+                                    1, MMU_DATA_STORE, true, 0);
     if (!tags) {
         /* Address is not in a tagged region. */
         gdb_put_packet("E04");
-- 
2.39.2


