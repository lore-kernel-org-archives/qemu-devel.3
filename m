Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCDFECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1X2-0007qV-Ba; Tue, 10 Sep 2024 10:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1X0-0007hO-7T
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:46 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1Wv-0006VG-Ve
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:45 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a8d4093722bso449358366b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977260; x=1726582060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4x/2lUUGLpLRO+8rqUP/+rQmXa+2LMUSZP6UGcSNzgE=;
 b=O7E6uwHSbHOuWwdIOCEcsg4vaGkmKongHQIe22PkTFdYOShs/iAWUf3JRvA9Yplfkv
 2/+O9Q5OnuEQaO234QyRvxBkpU6pjYBrySXxduQ+X9PIigOXhxACQXvlyBr7TAHJdmEL
 gieD45sL3mPkLojRY9WQpaP88W74arVX7xg+LsciyzYylTLeV8AfatMWzOKhT/WgT+3E
 5bXNhyuom5EIBrs+lWdl354f5SmMukps5MwWKv+JDRQqc/uJLWPaewXEEr4SnNaZ4D6S
 XnXVx8NWdKdEIsedP4FJQClWds70M4LzL/TRAghq8quUp1yIAMxHXd0eQBnRcQNkICzI
 W8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977260; x=1726582060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4x/2lUUGLpLRO+8rqUP/+rQmXa+2LMUSZP6UGcSNzgE=;
 b=G7OZ0wIfJUKrkbYx9UbVKiPFkCfAzAjntv7i0ape2uwNaOKXnUVTvZlme9sI98FRMn
 lyU4LGbOhIKoeZ2+9Inrh4m6nuqZ+sBYsAQ7yIZ/lewLWnPg5Du0AMEEQzVcApJ648pN
 VeDRkq6lTvOEyx1rSQOb65L/N+lv0JgPy0Lr4NLx2oFrMmFexYHtkpa767Rt4Nq1Cz+t
 4j4Y9ZFYJew4aekeH+XPb6rLEbCU6cDAST/7hkolbX1++Siav5kc5zncwzOJ8e3bi2bz
 w+AAgOO2ypnNxzgKEvGTj2aaTUPoySRD/H0LjJP1Hu0VRpXuiLl5TWdsAbv82nxYcbaA
 i2oQ==
X-Gm-Message-State: AOJu0Yw6HCRi/lcfCtIWKtzcWiFFmzkQEK22Dh7JZHYYicjAZKAQ8TXC
 U/tfeLZDJi6VJMDJYglOBCkiThsRSqZBryORJwDkILdX1e9HUG3yG7BQmXf7OA4=
X-Google-Smtp-Source: AGHT+IEvuWIAiAG/1WQfC8cKFBctoP0A4dYQjLeoHf7iKJZzLcR5lBFadtqLJorqSvb5dGkIUb/WEg==
X-Received: by 2002:a17:906:dc92:b0:a7a:3928:3529 with SMTP id
 a640c23a62f3a-a8ffaaa54d0mr74864366b.13.1725977260214; 
 Tue, 10 Sep 2024 07:07:40 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c7286esm481008866b.138.2024.09.10.07.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:07:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 22ADC5F9CE;
 Tue, 10 Sep 2024 15:07:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 05/26] gdbstub: Use specific MMU index when probing MTE
 addresses
Date: Tue, 10 Sep 2024 15:07:12 +0100
Message-Id: <20240910140733.4007719-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910140733.4007719-1-alex.bennee@linaro.org>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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
---
 target/arm/gdbstub64.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

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


