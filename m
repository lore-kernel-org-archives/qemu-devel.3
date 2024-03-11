Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B06BC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl9u-0007Hu-G9; Mon, 11 Mar 2024 15:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4x-0003OQ-HW
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:13:02 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4u-0000Ni-JF
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:55 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-513b1c69cb8so888985e87.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710184371; x=1710789171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SGZNrXP3eEMFAkYdDHaYkmUoBTYEXbgmFV3euRom/N8=;
 b=hVfqPziUAcHozo5wQjpWEcWYwT++u4PW7yHk8pqx4Lf/wtPSWYjkePAhC1tCm1NBkU
 lHXk4yeFDuc6hGKcMtXG59kROP7y80dCE9lL2njUfnAXNIAJ9vcy4PAH8LAKnaHVbYKH
 CpKafzs68YhRg15jfXzc8yloUFlo7MEzXGKWYaSML7WGxIdAjhHa8BxtHe8+vNKh03MM
 Ox+2pJtw8NHUMCyar1/d7lOZKgq4NzirdOA06+cuowxlt8ymQsabwIG2fGiKLAGqeuzZ
 jmQPTykgzuBC0q6E5ZfDMuVBFwJ2pEWzDejPKkL86U9qwK7YHwrEd0j1Sb9POZ344zZb
 us8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710184371; x=1710789171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SGZNrXP3eEMFAkYdDHaYkmUoBTYEXbgmFV3euRom/N8=;
 b=d9NYcVgkSpMIhX8prm3XYnMfQLv58T2w29STQVkhsVpCBB1RxuhCBi0T0IyEF4/KpP
 XlBa5QWH42lEntSF51y+oihepFmcTUXWFrVRxB7/EXhQjci/e3BmR/9AoiGzoPO+mxkr
 Ws6ysSdQlW59PMoQRt5wxBM4CL7O2YAqgB+8Qz4DU5F0WNxslLAl/7E9JbHR9u7I9akq
 /3PuPS5QKORbwlDpUyttiZ95xL/16oTIweNlHWXww1Af4m+MAyyvL6tYLTpTuimZ52gi
 MvH4RgY/vDYNalvFgVre0xrAzrJhUIrWmt0C5Hw/bez5SG+OctBLcHqmK98gaP2Unybn
 ichQ==
X-Gm-Message-State: AOJu0YxI4eagGO6Fi8q6ravFd2GfGLf4U1R+25gkYoymnVVVZVS3fGKf
 OmpmaxJW2Bl1upzS36CS1stLt+PqX56O7lEVQxqGR9Kmyph7ZnRB6Dd9YqdJydzYBM1gPLxY9cI
 y
X-Google-Smtp-Source: AGHT+IH3PDPHSNOCmgzXJZaI8I32pdUtOyaneCuJlvYHTwja78H7h40UhFtMOc8QC3aD9wGpXdsPxg==
X-Received: by 2002:ac2:5a09:0:b0:513:45b7:91c2 with SMTP id
 q9-20020ac25a09000000b0051345b791c2mr4405200lfn.36.1710184370636; 
 Mon, 11 Mar 2024 12:12:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm14425266wmo.0.2024.03.11.12.12.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:12:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/20] contrib/elf2dmp: Use GPtrArray
Date: Mon, 11 Mar 2024 19:12:38 +0000
Message-Id: <20240311191241.4177990-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311191241.4177990-1-peter.maydell@linaro.org>
References: <20240311191241.4177990-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

This removes the need to enumarate QEMUCPUState twice and saves code.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Message-id: 20240307-elf2dmp-v4-17-4f324ad4d99d@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/qemu_elf.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index a22c057d3ec..7d896cac5b1 100644
--- a/contrib/elf2dmp/qemu_elf.c
+++ b/contrib/elf2dmp/qemu_elf.c
@@ -66,7 +66,7 @@ static bool init_states(QEMU_Elf *qe)
     Elf64_Nhdr *start = (void *)((uint8_t *)qe->map + phdr[0].p_offset);
     Elf64_Nhdr *end = (void *)((uint8_t *)start + phdr[0].p_memsz);
     Elf64_Nhdr *nhdr;
-    size_t cpu_nr = 0;
+    GPtrArray *states;
 
     if (phdr[0].p_type != PT_NOTE) {
         eprintf("Failed to find PT_NOTE\n");
@@ -74,38 +74,29 @@ static bool init_states(QEMU_Elf *qe)
     }
 
     qe->has_kernel_gs_base = 1;
+    states = g_ptr_array_new();
 
     for (nhdr = start; nhdr < end; nhdr = nhdr_get_next(nhdr)) {
         if (!strcmp(nhdr_get_name(nhdr), QEMU_NOTE_NAME)) {
             QEMUCPUState *state = nhdr_get_desc(nhdr);
 
             if (state->size < sizeof(*state)) {
-                eprintf("CPU #%zu: QEMU CPU state size %u doesn't match\n",
-                        cpu_nr, state->size);
+                eprintf("CPU #%u: QEMU CPU state size %u doesn't match\n",
+                        states->len, state->size);
                 /*
                  * We assume either every QEMU CPU state has KERNEL_GS_BASE or
                  * no one has.
                  */
                 qe->has_kernel_gs_base = 0;
             }
-            cpu_nr++;
+            g_ptr_array_add(states, state);
         }
     }
 
-    printf("%zu CPU states has been found\n", cpu_nr);
+    printf("%u CPU states has been found\n", states->len);
 
-    qe->state = g_new(QEMUCPUState*, cpu_nr);
-
-    cpu_nr = 0;
-
-    for (nhdr = start; nhdr < end; nhdr = nhdr_get_next(nhdr)) {
-        if (!strcmp(nhdr_get_name(nhdr), QEMU_NOTE_NAME)) {
-            qe->state[cpu_nr] = nhdr_get_desc(nhdr);
-            cpu_nr++;
-        }
-    }
-
-    qe->state_nr = cpu_nr;
+    qe->state_nr = states->len;
+    qe->state = (void *)g_ptr_array_free(states, FALSE);
 
     return true;
 }
-- 
2.34.1


