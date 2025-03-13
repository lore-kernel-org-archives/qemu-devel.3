Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3170C28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZWf-0004qO-JM; Wed, 12 Mar 2025 23:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZWN-0004iW-CR
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:13 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZW5-0007pa-D0
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:46:09 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-224191d92e4so9431465ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837551; x=1742442351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZK4y75JMuNqGUqSKX3k26o8Ed83BdJjCreZWjLnQNVk=;
 b=XOwtI0tXtOhyI8FXuJKwMGfan8bmxES2BUiQENq+ZUYLuJcN9UMMLUeGPJnpTDFFuF
 A8Vge1oEMnc//QRTRu5X0WyiVMq/b9j+EiPB9PTLIKJbfIf1XxqiAWIdoKFYYrS8wYk6
 Up2LJAPYpHBxtODNiXe6C2yVaDMU5Tkwo9OJGHkmMDgAqlwfm92TzaDBdLLWHpOjlny8
 fuHCT5+KnhT7yhTX+t2Jjr/e1qCXyS4GER5vYQTfUaPoGJuY1iMw5aDD+NTemM4h8ee7
 sx3+HBBVRC7wgbY98bVPE5YIk/qMhPLQJ8bVuznCJ0oMPfCNPBSullH1V+kRKDNzi/zO
 /Snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837551; x=1742442351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZK4y75JMuNqGUqSKX3k26o8Ed83BdJjCreZWjLnQNVk=;
 b=jHc4htBe91OOvHRuHNewKPR5WqkeDKBvVJ6f3eDq2Xu31zRtGxJcN3KBxKUXYu4Nn4
 Os6ZdG+g8bt5QhmFRHFz1+Hq7+a2LLnFr2qbTIBqxNOX8yb2c6hqij4a0IMinAxSZuqn
 1YBVes1jPVPwuAVcIbnufqZAdQdEC2Y0KKii+oeQvXrLO/OiGm/qyPdVtfwS5sLzp3PV
 aMTWD17+gs4tRZER2O8tCagXnvxyjaRKznEObAtK+TJNS2/zJ0PFf5LQAGYosrLTQ4pj
 lz/COA+/JzdYo6GJXya3cwdTdnWghTON32spfBD3NHeenZRcLRKuIGeU2b1k4Nz2D70Z
 EI6A==
X-Gm-Message-State: AOJu0Yx+SzTzEyMPNpCJq/6ZrDBUS/rPBjBgBk2Fe9G8ypzQYGcTMNBV
 /WT4hmsAqupCNAb/kJc9KQs7GT/imA+W3l3Z0Bn17v7UQBUyZ/4CFBZSU9tikNUjGBRKybo12Ym
 m
X-Gm-Gg: ASbGncuTr4GozuFwvat1Euq5ei6SoGOEQiVcWXIm6uJ3JSRrk7qQ8P9gMz+/QrSC4wR
 1Ar82SxDb/kRGkCSpxidV359Fg1HPZKOn+XiVlNWBaHLwS1co44Pbr6EfWLI4h5zJnSn5JgETP2
 0YtCWmeuEUidaoupRCic35AXOg16GaFezfxld3h8jmpm/AkKaYJrrFsiHPZesRNL/R1nQXOpgZC
 4Ja/Y+G+lnOtLaqFOBou8G6pR/AHZjsZsks/458kXcu/35aCfZidScVHAKvMVOPG5+2qPJ3uH6d
 YU8oiGz1Xrz8VG1wLR0SQvN6C1kIHzg8lCOBl7/1k5dGGCWq9ZaPuD5Kc369bI9/ZR6ehlUc4w2
 i
X-Google-Smtp-Source: AGHT+IFFnx2f3hqYLGmtHM9bfzMj7fSCVl6g+akeRr7jvyqDKt5euCa7yr9Fo9Bonexxxd/yHsvfbg==
X-Received: by 2002:a17:902:d48c:b0:224:8bd:a482 with SMTP id
 d9443c01a7336-22428a9fcfemr357914165ad.25.1741837550164; 
 Wed, 12 Mar 2025 20:45:50 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 30/37] include/exec: Drop ifndef CONFIG_USER_ONLY from
 cpu-common.h
Date: Wed, 12 Mar 2025 20:45:10 -0700
Message-ID: <20250313034524.3069690-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

We were hiding a number of declarations from user-only,
although it hurts nothing to allow them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-common.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index be032e1a49..9b83fd7ac8 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -9,9 +9,7 @@
 #define CPU_COMMON_H
 
 #include "exec/vaddr.h"
-#ifndef CONFIG_USER_ONLY
 #include "exec/hwaddr.h"
-#endif
 #include "hw/core/cpu.h"
 #include "tcg/debug-assert.h"
 #include "exec/page-protection.h"
@@ -40,8 +38,6 @@ int cpu_get_free_index(void);
 void tcg_iommu_init_notifier_list(CPUState *cpu);
 void tcg_iommu_free_notifier_list(CPUState *cpu);
 
-#if !defined(CONFIG_USER_ONLY)
-
 enum device_endian {
     DEVICE_NATIVE_ENDIAN,
     DEVICE_BIG_ENDIAN,
@@ -176,8 +172,6 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
 int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
                                         size_t length);
 
-#endif
-
 /* Returns: 0 on success, -1 on error */
 int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
                         void *ptr, size_t len, bool is_write);
-- 
2.43.0


