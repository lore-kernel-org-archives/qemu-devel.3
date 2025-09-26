Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010ECCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v298S-0007FC-5g; Fri, 26 Sep 2025 10:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298G-00078Z-Jf
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:09 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2987-0005dv-Ui
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:06 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3f0ae439bc3so1027015f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895734; x=1759500534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XeUKkMJnd9x6RuIEqbezgHWnfk6CHPapq1x+ZqRbw18=;
 b=PTDmU8lbmJ5ZAbhP2OeoAK2K5ZFBaKGwy7PtmuucPKagJ9GGvZL1O9gThHh8TZMUSQ
 tIwmReYjyj8qDPlmBpTXnEZKAzSdzLlPlPSgt2AaCYKIhEvTdLQI51O75Y31QE+oD2bx
 8EY/3rQAavQHlcPD3HgW+j0I5Dk9dxEf0Sa13JsHgt7uxRVYBQGOVPSkYKaPEO9/8Gnp
 bwLEr7lRXDNTRnpqDki3UCDtQEEmt5j6jbcH/NxfCRvTiC77SWC+CmUtOh8w552KQ0rT
 +LCe8ssdlOiPraLWXbRWKBpueESjXPfGMs8mXWXDqyJ/ws9geITfs6xqR5ulzzGvjQh4
 xFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895734; x=1759500534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XeUKkMJnd9x6RuIEqbezgHWnfk6CHPapq1x+ZqRbw18=;
 b=ApBdLEiPfRR8IYxonDch2R8MFhc9YQubL9FiwpkWMzM4HE0YHx1ZIw4fq2/8idgBU3
 B4gM/ZZzzCLSsRFuYJ2R1E/Yvht/yqlKN4Ujsgq4NXYRWbI/PT/VruRc9TIe5zcjeRE4
 WLtARRkD1/RfBIqZ6+sZeIWB2AM7JSXns514KFjz+6uaqah5LRAKn73C3+0jr3rddA3l
 K9MIgm4gnnVsKf1K/OuT+dOoMMbWPQk4FM0/cHxXDaZLX01hy/PBfw+dZe2FiO0drpJ/
 y3kvPtXGw7Q4D6ZmIzDnhlvi2VR5Apok1KwdqL6NFp6kgPy0+7gED6wVfTzDsslqy4eb
 FVFw==
X-Gm-Message-State: AOJu0YyOzaokYfVW0FlPItP2K3CJh8qABQCvVwJhElkF+vjM4M8oHRoE
 XxGz1pPKnDo+ycfFla39rQpLGziN3QS7W11hO/FelPbTayRG/8yNT3dh+rLf6FYMwWkrjAvaL5J
 T4WTQ
X-Gm-Gg: ASbGncsjIPqbu/e4Dy4N8nenSqEGPjfx+ZFXcX7iDNVlAi2bIftxY43QrtgET1S9Nbg
 JQDOp7LwKqyw+mfOteQ2pcGO6KtR4PM/5YsFT3sbaZfUu62BZ89J+HOeEcIazetZh9o3mUgeeMc
 o37RH5CLNNfddZg8n3ammhyPLvWEED+kMEO2wjVhQ8ejtUS8O0urtMN7Ap8T3Y33jP4u9bzSinM
 P+KmovYtWleyV0QcIUICOjGrybukYILky8szKs7KfX4uRZEgxUgJHxwk7jutiSZ9UAX5D1QB8BT
 l6FHAjl4HpM+W36sKqEpHvyye9rbwEOxMdViakTklIwRwsysJoR/tTXxx8IX7vFvgdtBSiiLYc/
 5D0Ax5x9X0Bqo29OxJVxVLfb7+qIl
X-Google-Smtp-Source: AGHT+IGF+DW7G9VqR5kXo3kmCyj0Wu4QklrJxmwsdpbD8Xwp0R4zHZK0m0xDG0F4pU5oX1uKwPRvxQ==
X-Received: by 2002:a05:6000:2c10:b0:3d9:7021:fff0 with SMTP id
 ffacd0b85a97d-40e4adce713mr6517541f8f.37.1758895734395; 
 Fri, 26 Sep 2025 07:08:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.08.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:08:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/44] target/arm/hvf: Add KVMID_TO_HVF, HVF_TO_KVMID
Date: Fri, 26 Sep 2025 15:08:07 +0100
Message-ID: <20250926140844.1493020-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Conversion between KVM system registers ids and the HVF system
register ids is trivial.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index f68924ba1f3..7515e59c56d 100644
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


