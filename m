Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B741CA0FF9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4be-0003lA-BV; Tue, 26 Aug 2025 21:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4bW-0003jB-Oj
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:05:35 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4bU-0007Gu-MO
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:05:34 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7704f3c4708so4272492b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256730; x=1756861530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j4IRJlXM6WlOC6HdRLDZoPfNGaWNXGIS7v/EQ+dzuD0=;
 b=ND8ogBivGoQ3ytY6EiM7geYKKsHDQwjcw97jezQZIuTwms8cndtttZ08jo/OGOxQIT
 Tp4dn7MRrtFkiPDD+zg2ifYXIJBPkIhNEN5H9y2QH8ReeFqh0vyU2gM60VU9oX8higso
 tL/FyhcLiyKraZYja03c/YHsm79WAGFVTts+/qymlaDSVfiiyvEo5O3nNlT+udxGAXlJ
 Ze6rjvTXWeVU9Eq8n9OdSCYBet9AmzskVrmfqlC31xCW4WWlTUk4gAWZPgxpknKmP9vM
 EIOgdLuuQJyM9zqwPfXnT3M50OXvjdyvZErd4ZKO9qLg2gbQCIJmDN5JM2pwaYsfXDvm
 LFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256730; x=1756861530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j4IRJlXM6WlOC6HdRLDZoPfNGaWNXGIS7v/EQ+dzuD0=;
 b=YhoNGJ7YYEFzk8g6mT03zIhc1ClgJ0w4qfdlvdB/fJ4d4ppjcwdKxmTQt6NSJq+nXX
 AjXGDSgnNrpLl2kBNJ9bqKd6D249bjNKAZ2cfEaFkQbVAhWnUKTDReXp4zXU+FE5lfwl
 8cgXesxWsEchqrlD4iaY3fuz4EDuuPR9cCnsVhORmfbs9bDXRX1gRkeLvqpNszzw/wVP
 LTvVNeQTtmY24hoSYbfDhl4wOSCjTnnBMaNdeEgQUxA3YCXXvW5lEiCP4vOKE/Bmz9hL
 Me/5f4k8m2CoJpa+YakHsD5Xe+lLj0sp+NAde+NLzq8HZJu85Oh2kuDjCkNGzNEEzXim
 yULA==
X-Gm-Message-State: AOJu0YxJ7eRtV8RaYoMLLKYvv9vcQt+Id5qiroeSf7pe+BBHuWukFskK
 RaQ/oc60icjwRkwRX51wqwymekR07W7TdZyrba9YdmLRmFL0oild2FshT0RHd9lTyLv2kk8m8A3
 Zrms0WyU=
X-Gm-Gg: ASbGncvLF783wywC6NCPvZqX1GxqfcxU3jfCTF1stCGh2GS95CdAuXwj42wH2BZbMa+
 3Vt0oCC+aAdRslVsEMHSdnW72ezD0jIz+g2rWBOPdzQTo9dCiv+Cs7KFs5Lfz00LQv/yOmtTzWS
 0DUyp/fiN4c95SSHbk9laEvTRrN1f4I6W7nJijIEAyUjPMfVxFLalnlGvgyAvBQB9x2pzX1JDZa
 IvqCrxoJoQGiTA0aib0bw5JfFOZkuRasEAcrvBJK3jPNAx9KqtnQKzRxyukWXC72w42uTC1odcn
 DONWqRyuP2N8n+b6Smf6XMQyo/c3Sn1AHCjdumGK+vxdP/4OgKcgqz8v8onrpFhAqp4WJ+jJ2f+
 gvZK0aewa2BZ7ySsmB5hfDs2qcQ==
X-Google-Smtp-Source: AGHT+IEfg0RV8HZ0MKe7sVyvR2MY0xdMsjAgdQp2skpx8s+Sto/jl962olvmqYF0Xp7BQRGztMgUlQ==
X-Received: by 2002:a05:6a00:7619:b0:771:b230:f0a3 with SMTP id
 d2e1a72fcca58-771b230f3a2mr10217489b3a.19.1756256730528; 
 Tue, 26 Aug 2025 18:05:30 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:05:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 05/61] target/arm/hvf: Add KVMID_TO_HVF, HVF_TO_KVMID
Date: Wed, 27 Aug 2025 11:03:53 +1000
Message-ID: <20250827010453.4059782-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 7b0413093d..47165bd29c 100644
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


