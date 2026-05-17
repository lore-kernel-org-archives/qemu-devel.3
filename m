Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B618ECD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPd-0007vd-E7; Sat, 16 May 2026 20:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOa-000793-8E
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:17 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOX-0004sI-7V
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:15 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-83537a80ab6so769183b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977811; x=1779582611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HTm+tJ9AXbaN4UCtQXozdvXW5oj4hpGtuMfl8xxCE7w=;
 b=ikix6iJFvuacZ8TXpQRF5hB4y/ysxl79LLFSAf5kbePiNcUflZakBfAnMZ8CFMHAKM
 2nnET4e9FZfG6hmZzC0x8gwGFi6b68x8Wz/wTzfWbX0CIVhcpE0T541db5VLd8VnFxGK
 oLm9oVdd1Yz+Fyi+DnE5mhF0+LVmEA+YBCI86a5cBV8f7imjbE83dJOPoxiFQF9rQa8+
 pPmG4L/lemeUXKl3wqgOzSrOO9KB47s1jdyKazqgQgBLatGZqtH3MzeYVOdsZ9K1H9kz
 +P5JupKta+4AsJosMCUOKeWIgY1DtXnjBa78ZNjAGFCAeIc3EHpr35F5AEYesXX8CA1I
 jkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977811; x=1779582611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HTm+tJ9AXbaN4UCtQXozdvXW5oj4hpGtuMfl8xxCE7w=;
 b=mwHms6w7C3/YC4g2wjKFOf8PxDTvpH31qRpPPs0DA2LROmLI99WL90TEzF3dvb+cyb
 4ugtQN98Q+B0Igoaxy/3CYSYFun468rVAbJRXWlO9AT8vYriElbBu5we7dd1kNRLWHII
 2RJZsyunESqJpoVHc0jWA0wRskR6LasDnCHNR/bssg4lOd5KNd+GywvwLBPo1isMBw+a
 14NBsE1Yr+MV+15PDmWKOpcvY5J2/dCMYnTiLTBvdydWaAEcn94MvPCOlqGZDVknyPhG
 /g89EYUIdJr8rh+bkzbb67k1ECT3/awTqmxRoia6K3I1wJNU/EZxiIk6okweA8Ment50
 gJUQ==
X-Gm-Message-State: AOJu0Ywsb1lm8ZZChlNqfdZhb3tSnxZu2A7+CIzgk1PMVD6Hb4yXYTUf
 hXRywGpyOSSv8z4lbhfmkI/Xeds7nDTgiIT34hmEq134XE5Y4Jf9VhLNhOKqvSx3WdxkJNWYE10
 jCIUn
X-Gm-Gg: Acq92OHu3cDHBvSmb7XY0snosgba+voZRnBgzixC2PMpA27XyduFNSj2XlHudx9KgNu
 m0B6pVMwpiOOQx1VhpTmwKqVRZp8DyzHfYuRIJ96yyFIosCuWUWngQYbeUhT7jRWaVjYX2oFvAE
 Nv0srLi/fMFuBd5GwsmNn5ErE3HMxa3HeyeCo/wANIWGxRED+lp4jx8b8nbQ+bnNhaNGYBbJH/l
 /Sc5Ge/+NZ0Du3mUdCzagY1kJzSEowaOp/DCH/KOIuvvnKFGL52LQ5bCtO0gHMzTFYyj34rFUXC
 GjJpymfC78UptoLNSGvBjCou+dwMSPySGlYHmkqnsI75Tbo72hQ0YlknnzZxsc2WhnWI5J2l3iL
 QSfUhPpXO41AYdGotvSN/3Rn4F5sHVIKV3gKu+jhpl3O99U2Pm+xmrDbyKhmzHzyZy6NL9x9iCH
 TOWnLVnmMRYSph45XxNnuGDHtAMkZT
X-Received: by 2002:a05:6a00:1404:b0:829:9a7b:db84 with SMTP id
 d2e1a72fcca58-83f33f30bf8mr9765756b3a.49.1778977810719; 
 Sat, 16 May 2026 17:30:10 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 08/63] target/arm: Update HCRX bits for Arm ARM M.a.a
Date: Sat, 16 May 2026 17:29:07 -0700
Message-ID: <20260517003002.321430-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 3edc15c7b4..4414be85d9 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -258,7 +258,9 @@ FIELD(VSTCR, SA, 30, 1)
 #define HCRX_TCR2EN   (1ULL << 14)
 #define HCRX_SCTLR2EN (1ULL << 15)
 #define HCRX_GCSEN    (1ULL << 22)
-
+#define HCRX_ENFPM    (1ULL << 23)
+#define HCRX_PACMEN   (1ULL << 24)
+#define HCRX_SRMASKEN (1ULL << 26)
 #define HPFAR_NS      (1ULL << 63)
 
 #define HSTR_TTEE (1 << 16)
-- 
2.43.0


