Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A69C25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 05:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2PFL-0008Tv-2q; Thu, 02 May 2024 01:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PF8-0008Mh-5m
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:31 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PF3-0002bv-Eb
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:29 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6ee4dcc4567so2095731a34.3
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 22:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714628663; x=1715233463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BO3Ii+A52/malNI8AUEcEUyt4enrdqxz3IH30eM+BG8=;
 b=d3znA4b4rneR6UEoy8iM1aiiZysVmHrtBuocz8IIg98yXERmf2njtvllYZC3K8J2mE
 Q/yKmAfHB20wRqbD7Ohb0+QLRvy21DOzWsR5fI+yeZNuicU9jaGFOIWnViEfW9ZH1ItR
 ZtSGMeRXz+krn154wJ4q1JXgEJ2ZPtB7oSuwj55fNuxIA1KzPPg2QkfD/H1rA7J08Xk9
 K8A9hqIrVRVag6r6oQcHsePs4yoXJCREmxQbkrlKxP4O+NKiDYHNSKtRCuM1jMpS2Lv1
 gKOGJrHon79RtQDQR2QA37VlCmqU/YK2msuH7zyzBA8Z/lNJE5jph/o3KkZwoV7bcBLv
 faRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714628663; x=1715233463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BO3Ii+A52/malNI8AUEcEUyt4enrdqxz3IH30eM+BG8=;
 b=dCBWNfxXoqScnnzR6E1ybBNJbxdt7Zy48OmK/6jeiWNf1XqKDs19bNxsYrFl6DJrfl
 +weIKHmNi552/2fpZPCDmuJXlIFR5tF3uUIlstFLwNtmkIxe4pN6WmHUezGIh3/WaWvI
 pHiVlILHb/u0WCi2YrNJQbrbVrB9wm4NEUTERRqusNq9CD8WjYRpWuDeNdZvdK92dwqx
 cc5pDONHNbyQxWY76og8oSfrAST1DbdxK3jwBDSBXIISlFZN9eOytfAQtobHwUqnevff
 2eeLsvee81VMknzsUHIM8MxQuF/Ab+ZTmXWKkMKE3esMyl3ASreBlTdUXDrI3awAfZeH
 z+qQ==
X-Gm-Message-State: AOJu0YxIrp/ve6UXjPJ0YvYpUTYcQvc9YKOHN5e7cTrrxwfjuE0WVvtB
 ZVKKNM5knxQGoD6yxylKevuX8p3anao/mKTapVjRdcntk4Bc7LQbW0ORJ+tsrUOmhie6orh/7kv
 4
X-Google-Smtp-Source: AGHT+IHm/PZ7iHI564ZkHNIQjy8bS5hbwhwEshx5DwME/PDwA547s70NPYIge3EgMauiWbEkQdmPcg==
X-Received: by 2002:a05:6870:9121:b0:233:276e:6bbf with SMTP id
 o33-20020a056870912100b00233276e6bbfmr5256272oae.15.1714628662898; 
 Wed, 01 May 2024 22:44:22 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a656492000000b006089cf2cde5sm294401pgv.26.2024.05.01.22.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 22:44:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, iii@linux.ibm.com, david@redhat.com,
 thuth@redhat.com
Subject: [PATCH 03/14] target/s390x: Update CR9 bits
Date: Wed,  1 May 2024 22:44:06 -0700
Message-Id: <20240502054417.234340-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502054417.234340-1-richard.henderson@linaro.org>
References: <20240502054417.234340-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

Update from the PoO 14th edition.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.h             | 18 +++++++++++-------
 target/s390x/tcg/misc_helper.c |  2 +-
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 950f84f316..1bb723a9d3 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -419,13 +419,17 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
 #endif /* CONFIG_TCG */
 
 /* PER bits from control register 9 */
-#define PER_CR9_EVENT_BRANCH           0x80000000
-#define PER_CR9_EVENT_IFETCH           0x40000000
-#define PER_CR9_EVENT_STORE            0x20000000
-#define PER_CR9_EVENT_STORE_REAL       0x08000000
-#define PER_CR9_EVENT_NULLIFICATION    0x01000000
-#define PER_CR9_CONTROL_BRANCH_ADDRESS 0x00800000
-#define PER_CR9_CONTROL_ALTERATION     0x00200000
+#define PER_CR9_EVENT_BRANCH                    0x80000000
+#define PER_CR9_EVENT_IFETCH                    0x40000000
+#define PER_CR9_EVENT_STORE                     0x20000000
+#define PER_CR9_EVENT_STORAGE_KEY_ALTERATION    0x10000000
+#define PER_CR9_EVENT_STORE_REAL                0x08000000
+#define PER_CR9_EVENT_ZERO_ADDRESS_DETECTION    0x04000000
+#define PER_CR9_EVENT_TRANSACTION_END           0x02000000
+#define PER_CR9_EVENT_IFETCH_NULLIFICATION      0x01000000
+#define PER_CR9_CONTROL_BRANCH_ADDRESS          0x00800000
+#define PER_CR9_CONTROL_TRANSACTION_SUPRESS     0x00400000
+#define PER_CR9_CONTROL_STORAGE_ALTERATION      0x00200000
 
 /* PER bits from the PER CODE/ATMID/AI in lowcore */
 #define PER_CODE_EVENT_BRANCH          0x8000
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 8c27998ab9..02215a7f18 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -644,7 +644,7 @@ void HELPER(per_ifetch)(CPUS390XState *env, uint64_t addr)
 
         /* If the instruction has to be nullified, trigger the
            exception immediately. */
-        if (env->cregs[9] & PER_CR9_EVENT_NULLIFICATION) {
+        if (env->cregs[9] & PER_CR9_EVENT_IFETCH_NULLIFICATION) {
             CPUState *cs = env_cpu(env);
 
             env->per_perc_atmid |= PER_CODE_EVENT_NULLIFICATION;
-- 
2.34.1


