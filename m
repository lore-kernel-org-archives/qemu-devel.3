Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50735CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWaZ-0005wS-FZ; Tue, 16 Sep 2025 10:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWa0-0005i6-6W
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:22:48 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWZu-0008HP-Dq
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:22:45 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-25669596921so57024535ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032560; x=1758637360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ggwb1PQpRrrkLOGCaS9ng6BrXdIGDe+gz4mi5GKaHg4=;
 b=Qz5dtjqmycIzu1IkGeg7iLsNqD+MbZgs9cK5MzNp/+YbxQmXDwWC75vyfBcOHLa0Rj
 iLphL0UqWMzbfm3o9XKFAFB90u7D3jm9IC2I+jpmGhZA1OLGZtC81aSdJh8rxBgqwBnY
 8VvtuMOVhqnmZmM+6ig8Ljx8j0bYFzuQ08XN8YujTBmY3qkG3CLmLnOYeBqoZ77rriBZ
 L41DLHIb7Y9hmvXkiz+E+qdq2Dzq116Nv7qqF9v/0ilESyXbvkZOCR63ffEmNn+rJQ0J
 uQ0Wgv44hAOhkKlK120bH1Q+ZEF2n9QmfBcQU7ATYjED8kPsx1El644SRjwzYeFK2nOm
 2K7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032560; x=1758637360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ggwb1PQpRrrkLOGCaS9ng6BrXdIGDe+gz4mi5GKaHg4=;
 b=AdREueHiqbYH0e3k+9XYkV9Avnabaqid1ZOSfAXcQ9rL2rL4NOBF3PWT0op+pscttx
 1a06Ij51GjrusKAXPlQz8/PJwVkVFwPzQLzvw7Snny9EqHauVqmDHkavK8BNLlitB7O2
 aNDgfP4ivGy1wKFXO3JxbdYCLkpA8jq3qXqCJrPiA2boiB7mIjqoteMIrj+UoofKz6EK
 E+WaW+J80NJ57HB8vlFHaB3oZ7hbODoYMoumz/PDy4Ks2mgwrDs+Lb2BU3741E7vjuM2
 E1cJBmkH0DgQKXVW8BUDhfg3lvp3i6n8KAD8Q3N41W2J11KFEDGyYOqoWvFSPoB8XZeR
 /HEA==
X-Gm-Message-State: AOJu0Yya4BHxX76++w0oCogCzgJTZO0RlPtDG0pRxeVvNWygu2tViXts
 NHGOmYXK3f5CBNlIWjLm3TjQLuUF/E81sCf9jRUHJp/L9UPM38IC0M9ci9sPqNqYORgmFWyqhY8
 KmWEv
X-Gm-Gg: ASbGncttZ3fMQq9dVcKYy0NK32IxdXgaJ6BDQPr2pa1RLBdC7BOJzCtT8ezjeFzEJEd
 kX20Ja+IRwo+VItnhMBEwlFG+sz7/oJMbQDncLxXoTTqRlqnzrkC9WM/wYiaoseHK1eGeVFS1RN
 y80Di58767yHdWv7lKThMtjdJizAM43xjhnvnvYwt+jevrK3AG5+CTaFXlQdaKL7vd/g7/Ca1Bj
 Qjj+o+hhEgsO9VZ6dI5cA0QS/OPPisIVrlLuxqa4P3RaS82NZ2+AAFl4syVFx8KjTJwwpjae4af
 Q23FRXbFCW1jNVaskXA9UHkNlg3KiOItr00D11HWJhXE2qpopczQ/stGjATzeOtGrpe3+RLXS7i
 Nf1Xic80dQx1wftDPoVgPYC0PDr29
X-Google-Smtp-Source: AGHT+IE3CN+8SXPUqhiTrptq+LUoQb03jckSSvZOGZe49jHkgbp5Mfw/0e7ESoBQA2ho9ljZ3tPuCg==
X-Received: by 2002:a17:903:37c4:b0:248:811e:f86c with SMTP id
 d9443c01a7336-25d26663209mr182399855ad.34.1758032560232; 
 Tue, 16 Sep 2025 07:22:40 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:22:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 01/36] target/arm: Introduce KVMID_AA64_SYS_REG64
Date: Tue, 16 Sep 2025 07:22:02 -0700
Message-ID: <20250916142238.664316-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Allow us to create kvm ids directly, rather than going
through ENCODE_AA64_CP_REG + cpreg_to_kvm_id.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm-consts.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index c44d23dbe7..fdb305eea1 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -180,4 +180,15 @@ MISMATCH_CHECK(CP_REG_ARM64_SYSREG_OP2_SHIFT, KVM_REG_ARM64_SYSREG_OP2_SHIFT);
 
 #undef MISMATCH_CHECK
 
+#define KVMID_AA64_SYS_REG_(op0, op1, crn, crm, op2)    \
+    (CP_REG_AA64_MASK | CP_REG_ARM64_SYSREG |           \
+     ((op0) << CP_REG_ARM64_SYSREG_OP0_SHIFT) |         \
+     ((op1) << CP_REG_ARM64_SYSREG_OP1_SHIFT) |         \
+     ((crn) << CP_REG_ARM64_SYSREG_CRN_SHIFT) |         \
+     ((crm) << CP_REG_ARM64_SYSREG_CRM_SHIFT) |         \
+     ((op2) << CP_REG_ARM64_SYSREG_OP2_SHIFT))
+
+#define KVMID_AA64_SYS_REG64(op0, op1, crn, crm, op2)   \
+    (KVMID_AA64_SYS_REG_(op0, op1, crn, crm, op2) | CP_REG_SIZE_U64)
+
 #endif
-- 
2.43.0


