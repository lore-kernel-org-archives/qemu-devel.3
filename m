Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BF2CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UpQ-0001Ek-Ln; Wed, 24 Sep 2025 15:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Um5-0006zK-AV
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:39 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Uk3-0007t3-GT
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:30 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-323266cdf64so179735a91.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740481; x=1759345281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UkNyZZYFhHeil9ygYrAE1UXkAwT1+GtqIOD2Xj8zAVs=;
 b=xfnaMd3GCxto7S+RXW5e8h/hiVZboKUHj1LOSvPxBih0xNPBOEVY7B1TdZ/4MCUZf4
 GHRLrrbV+QoABilPxVmRLuOX6L8IIVgAOWGgQSnUOC64mhUzSNKEwomKA1iP5PK4T9dc
 T6cTUYxN6TKGKRee5YJjrxbg3Y0py982RzbVfS1HDcBeIJrNAWRELMaasRnFdVt58QB8
 npJTgKqeNSUq2KvQ/Honpqi+YTFp6nju1+lY+4bwh0up4e6haRKnycKOi8QN6Te/v9rs
 ZXX+He0uDO0Ro6lVbDMlc+HUwXh8PP1jIDonhyy+mpmgyV4Aw3dL5bLV3buZ1dJAjZdU
 u1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740481; x=1759345281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UkNyZZYFhHeil9ygYrAE1UXkAwT1+GtqIOD2Xj8zAVs=;
 b=sbrHiNa0T4L7mB1th9wFTGI2JhFjNGvr6I1F8Rs3fwqvmZG8T+N0CATmcs6mN3mCw0
 RkDaMsaY2Wh8a25M44MfAkapsmp6/tMHfvTcf+W7OYFr3IeitLiHb/yOrfzR7p184GqF
 Mc1r8GntnIbMsJzpnXjmW6c1knNkAYOM30aRdJqjx02kUUCektdUb0G9x05EKHGEenKl
 jncF2Y9v6nmh1axlcMtNxG87GHwqG5rQlqomX7pQDvMA9krYFX+OLVK5EHQUXBRL+T6w
 qaUvKsHkbccnHfxpXerlN1VIT4p0vOQ+nP/DR0HEWoKiAV3wIcvVMa/O75Bjmi8MsdE2
 Wzzg==
X-Gm-Message-State: AOJu0Yx2DcNi+4Z3ZcF8lWxPpvdI5Di5N87OchxJPH+BLw3kKm+0ZJvh
 27hH7V5ox5s52enpKKX7zzbpF+CTMBdlJldiP3rwrIBcwO2WFS7joatuwVSWZxpJgzcdvHiuEMn
 gs+/j
X-Gm-Gg: ASbGncuz1gGDEDNfimoEH9mX0p4mFuFL9u22BdPqfW+d1781y0qqGfIqev0o/uE4qCR
 vOlExwkCv8kaqjUjLCLJmg8hpbPOSJ+Iwj5DBwLOk6luU4jA4RagSiwTLxteJKcOB4oGqWkRE0d
 aQcnvWF9LOI2xsRLpJ9lfoMQdFHY1Y6hDo0iddSe7sK0iadkW8DxRoljv/MqvwEwfSD2242rxAL
 Lu1HyLLtDdG2lSVZ60l5E6ZvUHejGxwCffWEn13r4vbTRQ7aXabtBM97L7JmAyaiVlTpe4jpnUA
 CRpXp6B/5KrLk280wwDFMjDCCN4dkOru+UtaiuvkmacjvKjuxm1XcpzqS1qYxic9wSt5WQhcO7U
 Gxblsm6fEsFl3byYFrMo9TJ9HGOCb
X-Google-Smtp-Source: AGHT+IEwTKwIF0DYcR58coJaWifqQY7QeFWtGS1L5IVqv4V/HjE0YH+dMYvEWsZ3CyBC6HhnEHKu8w==
X-Received: by 2002:a17:90b:17ca:b0:32e:b36b:3711 with SMTP id
 98e67ed59e1d1-3342a30c997mr674793a91.28.1758740480926; 
 Wed, 24 Sep 2025 12:01:20 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 18/32] target/hppa: Adjust mmu indexes to begin with 0
Date: Wed, 24 Sep 2025 12:00:51 -0700
Message-ID: <20250924190106.7089-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

This is a logical reversion of 2ad04500543, though
there have been additions to the set of mmu indexes
since then.  The impetus to that original patch,
"9-15 will use shorter assembler instructions when
run on a x86-64 host" is now handled generically.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 11d59d11ca..672ab3750c 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -29,21 +29,21 @@
 #include "qemu/interval-tree.h"
 #include "hw/registerfields.h"
 
-#define MMU_ABS_W_IDX     6
-#define MMU_ABS_IDX       7
-#define MMU_KERNEL_IDX    8
-#define MMU_KERNEL_P_IDX  9
-#define MMU_PL1_IDX       10
-#define MMU_PL1_P_IDX     11
-#define MMU_PL2_IDX       12
-#define MMU_PL2_P_IDX     13
-#define MMU_USER_IDX      14
-#define MMU_USER_P_IDX    15
+#define MMU_KERNEL_IDX    0
+#define MMU_KERNEL_P_IDX  1
+#define MMU_PL1_IDX       2
+#define MMU_PL1_P_IDX     3
+#define MMU_PL2_IDX       4
+#define MMU_PL2_P_IDX     5
+#define MMU_USER_IDX      6
+#define MMU_USER_P_IDX    7
+#define MMU_ABS_IDX       8
+#define MMU_ABS_W_IDX     9
 
-#define MMU_IDX_MMU_DISABLED(MIDX)  ((MIDX) < MMU_KERNEL_IDX)
-#define MMU_IDX_TO_PRIV(MIDX)       (((MIDX) - MMU_KERNEL_IDX) / 2)
-#define MMU_IDX_TO_P(MIDX)          (((MIDX) - MMU_KERNEL_IDX) & 1)
-#define PRIV_P_TO_MMU_IDX(PRIV, P)  ((PRIV) * 2 + !!(P) + MMU_KERNEL_IDX)
+#define MMU_IDX_MMU_DISABLED(MIDX)  ((MIDX) >= MMU_ABS_IDX)
+#define MMU_IDX_TO_PRIV(MIDX)       ((MIDX) / 2)
+#define MMU_IDX_TO_P(MIDX)          ((MIDX) & 1)
+#define PRIV_P_TO_MMU_IDX(PRIV, P)  ((PRIV) * 2 + !!(P))
 
 #define PRIV_KERNEL       0
 #define PRIV_USER         3
-- 
2.43.0


