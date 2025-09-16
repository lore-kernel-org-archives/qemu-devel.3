Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CACACAC59E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWaX-0005uw-Bc; Tue, 16 Sep 2025 10:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWa7-0005jS-2f
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:22:56 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWZz-0008I4-SA
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:22:51 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b54dc768f11so980064a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032564; x=1758637364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QcyFmSED1U74WI9UXgtn2Nss5f/zzYuv4zo9qx3ZJkk=;
 b=K/wn7zA+v3WfQFi3s6rOOs3uOS+6RMNDB4Fqtwj2O0TzQlGULj4ul0mXYk/FJfYnkn
 5jmYUrR4zcaooybQ2fiJdekFcsPyWzUFhZd6/3vF7trpBEf08LOuq+SSiSqsEgjZHUa3
 oUZx9l+RCCT+4HSDhbkbit0syllM98pKnWGk+G2AMd1VX9szKVMZq+nYGhmhYA7qighp
 NyKg01KXbe5mC1weJ2g0JMh+Trynbi1Jl9xjR+/Mt2NdE8hMYWaPPqPDCHTeAqYMjul7
 uFmbFIPUr7R3+6myPVtujXteSp79yPnrbugEpzNa8XVceivUcPnhsCFY5/UMOz2U/pzC
 OCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032564; x=1758637364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QcyFmSED1U74WI9UXgtn2Nss5f/zzYuv4zo9qx3ZJkk=;
 b=iDE5f0Dy0MN5tyGq1EVv01R8Auw2GkHKgUaUonMFpxx/lSFZYdsVevhJd8v6pms7An
 ya45BbogL82+PzGpWbHUb+NJFcGgsKfjgbteL/+spaanResjUN+ztStAAaSqAKp6lzyw
 CKqyjY+vxsVCYvaqNMacgu6sRnizFIo4k6ZsmenZWviAWLSVGSC+BeTJOddZIDPPC3RF
 FnebxvrvMkC4egIx3J660rrXJiA5Dg8UckrAYhtBELERUIYiwiEYwPUEMI0YK7jat+Qi
 ZXVTXosT+IUG8BH2dZfp0mbA6b9BtCWo/ma8yEqNDPx6PGx53e2cADr1vnurzM/nWSNA
 hXnw==
X-Gm-Message-State: AOJu0YzB4cy0zfSQHAaMerOx8mAXcTquV0WBDcGmm2B5kXjKGC7yZYeY
 WpZceopGH86xGr2jtFLfJVe1nMKRyzkArZ2JtCVmOCGazJC1gRU03qoTBDgx8CXCkkLwAFDzfWS
 mzE2b
X-Gm-Gg: ASbGncusVt/WcoOWRFnLSj7Vr3vOIWnxjvy0DPpbK91AEwpefqAvMjjFmh/94Dudmor
 wmAGTmbjcS5UV91oy4/XIpN6LAY0GnbMGBYOayrWgeBIGbBB4+XZn8J0KWTwcelRok1qQ3CVvYZ
 Xm7tLdUmUjPVsStUH6/md5WemLOWD259S2IB+UP+zIucVcQ7JUgekKb1WZxnwZtISDGo8i5G4vn
 OyG4EmSmgP1DOkJsdtDKAzUbwZ5YPg38rwXrxjOwAgAuNgP5O7sB4cRAVXJnGcoSQIiFxsM12hx
 3OpGjDjduUohaPdy31Hie2hMfppAvOOayR3gHBkO+VQLoakYwodbMUHwNck+qHcALBjHgtYOUiY
 syvdGONuTC+YxzUs3AIkYOMhoOWDm
X-Google-Smtp-Source: AGHT+IFO9aLpqlUq4ALNHy4YL2aoDcdWvGCLnoR53xQbmihLpHzayoUaY7Jvd2er+TwKrjBfNG305w==
X-Received: by 2002:a17:902:cecf:b0:24d:a3a0:5230 with SMTP id
 d9443c01a7336-25d27131d84mr259931945ad.58.1758032563990; 
 Tue, 16 Sep 2025 07:22:43 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:22:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 05/36] target/arm/hvf: Add KVMID_TO_HVF, HVF_TO_KVMID
Date: Tue, 16 Sep 2025 07:22:06 -0700
Message-ID: <20250916142238.664316-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Conversion between KVM system registers ids and the HVF system
register ids is trivial.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index f68924ba1f..7515e59c56 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -403,6 +403,26 @@ struct hvf_sreg_match {
     uint32_t cp_idx;
 };
 
+/*
+ * QEMU uses KVM system register ids in the migration format.
+ * Conveniently, HVF uses the same encoding of the op* and cr* parameters
+ * within the low 16 bits of the ids.  Thus conversion between the
+ * formats is trivial.
+ */
+
+#define KVMID_TO_HVF(KVM)  ((KVM) & 0xffff)
+#define HVF_TO_KVMID(HVF)  \
+    (CP_REG_ARM64 | CP_REG_SIZE_U64 | CP_REG_ARM64_SYSREG | (HVF))
+
+/* Verify this at compile-time. */
+
+#define DEF_SYSREG(HVF_ID, ...) \
+  QEMU_BUILD_BUG_ON(HVF_ID != KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
+
+#include "sysreg.c.inc"
+
+#undef DEF_SYSREG
+
 #define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2) \
     { HVF_ID, HVF_SYSREG(crn, crm, op0, op1, op2) },
 
-- 
2.43.0


