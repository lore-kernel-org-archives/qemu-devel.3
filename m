Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8184C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 14:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVJz-0005gx-9p; Thu, 01 May 2025 10:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVJu-0005dl-Vh
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:26 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVJs-0005QT-7V
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:26 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-227d6b530d8so11603785ad.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 07:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746111323; x=1746716123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OKdlxq7vj1lY48Y8P5jMGdkGRsWPnW4o2KqIcZOb+Nc=;
 b=RcgL596hjSV5/UwMA8/wNWmsmW6ELIIDddfsNbHcidtKB2LagEcrb7owpslz8fZSbL
 r2WMCK2uPbJlfct68Jy/w7hRlunjf+/0hGV29y+9Dpp1nGZLX2YFfh/9sTIuiB/OI0fD
 EYE70xg++60c0dzhdWEanuBKhnbk6juEwdPk8oG+gNxo/G65hts9MfNaG1idO19JuMIM
 74g2D21Qc/6ehh8XwxOYQaBEHP8Zo/0MhMaUM8aSmErtARlNOtY9/5AruWnVnEIKGUJa
 GZoGVIS7lxM+++nNzeIpsEnUtS8gZrZgBP5dQYEqRYSrCjb38AwLjm8KCIavALY3HH2x
 Aq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746111323; x=1746716123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OKdlxq7vj1lY48Y8P5jMGdkGRsWPnW4o2KqIcZOb+Nc=;
 b=l3nJKVdekMnsFplMTgpQ1zcDs06ZgkoKiChGVar0g6OFMeWYyEWlWWZYlrD0k17NEx
 Ip9k93Kx2X32QqNdrPsiw1ziuswMjh2TgCQythWrwDCNwetctbWCSIVXAudsqSfJpJ+E
 Pk6jA0uLW36G2SVeSxZeaZWkb4eq9oN2IcEB2o0HhAziqoWfsHq/fb3SbCI7JiVEu7Qy
 sQxHAPe5vJBPZiJ3ITNTgQfBy8qi+KNQDjweTZ+OtCIuxhgIipefEvjOY2dUU5ViDzlS
 67l6SNBVFQ2rjBaBoasiboK05yTIWD1yJebO1EuvgyjRiizWWz/xsXwmi79aIZFWszEZ
 W5fg==
X-Gm-Message-State: AOJu0Yzg3ZRk6oEVT1VK5ySx6O3WZV0/Z8iYoFWfiykBZq05KBqLWEL8
 9OvLgTOLRD3uXOV767ps4bhAeXVBqic/pmDymtwKJKd0SdXLsfVtBSl15bv6AF7atfbSkzSk72C
 3
X-Gm-Gg: ASbGncsTVOIQV6/s3DagqqSMMhH16TNtyAq0+4DdJmMgBJLi4cUBSy8Fx+5evp23nji
 4XtZNEnBco5xMkTrU4mPiVZPVN73GwSgbPgalehF0cgd2PGwawlTo/897wDqySyMTNXphxp5SQX
 /GqzA3ComLBsU5FRxy//yBkVd6nBmaaGmhZTbOJctp6wZpQr3fDgVj2SoTIIXG4n7WyPhe+6sai
 pI6X1NeBdaaQNSAsapIIi5uZnYk7MPLpvSMm/H8kIvE/8Z8e/FRhTV/2yKDRHLs9OlUejXuVjw3
 YYlrjfg99R722RDAgRXHw3iJPnMH5LJ1aCVVGliTUUNe4RqAK6q+pddEDM4aZDK9jWNiTn9JgdE
 =
X-Google-Smtp-Source: AGHT+IEPBxuBAsji6SR2hzaNR7jq2VRXnLQECuychZ/X2Mk7GUVUOBmg76X0mIBqXAPpI5zP5v8l5Q==
X-Received: by 2002:a17:903:1a6b:b0:226:3781:379d with SMTP id
 d9443c01a7336-22e0863a896mr43920245ad.33.1746111322699; 
 Thu, 01 May 2025 07:55:22 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bb0e770sm7644415ad.92.2025.05.01.07.55.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 07:55:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/11] accel/tcg: Move tlb_vaddr_to_host declaration to probe.h
Date: Thu,  1 May 2025 07:55:10 -0700
Message-ID: <20250501145520.2695073-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501145520.2695073-1-richard.henderson@linaro.org>
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

This is a probing function, not a load/store function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ldst.h | 16 ----------------
 include/accel/tcg/probe.h    | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index 00e6419e13..0de7f5eaa6 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -502,20 +502,4 @@ static inline uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
     return cpu_ldq_code_mmu(env, addr, oi, 0);
 }
 
-/**
- * tlb_vaddr_to_host:
- * @env: CPUArchState
- * @addr: guest virtual address to look up
- * @access_type: 0 for read, 1 for write, 2 for execute
- * @mmu_idx: MMU index to use for lookup
- *
- * Look up the specified guest virtual index in the TCG softmmu TLB.
- * If we can translate a host virtual address suitable for direct RAM
- * access, without causing a guest exception, then return it.
- * Otherwise (TLB entry is for an I/O access, guest software
- * TLB fill required, etc) return NULL.
- */
-void *tlb_vaddr_to_host(CPUArchState *env, vaddr addr,
-                        MMUAccessType access_type, int mmu_idx);
-
 #endif /* ACCEL_TCG_CPU_LDST_H */
diff --git a/include/accel/tcg/probe.h b/include/accel/tcg/probe.h
index 177bd1608d..dd9ecbbdf1 100644
--- a/include/accel/tcg/probe.h
+++ b/include/accel/tcg/probe.h
@@ -103,4 +103,20 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
 
 #endif /* !CONFIG_USER_ONLY */
 
+/**
+ * tlb_vaddr_to_host:
+ * @env: CPUArchState
+ * @addr: guest virtual address to look up
+ * @access_type: 0 for read, 1 for write, 2 for execute
+ * @mmu_idx: MMU index to use for lookup
+ *
+ * Look up the specified guest virtual index in the TCG softmmu TLB.
+ * If we can translate a host virtual address suitable for direct RAM
+ * access, without causing a guest exception, then return it.
+ * Otherwise (TLB entry is for an I/O access, guest software
+ * TLB fill required, etc) return NULL.
+ */
+void *tlb_vaddr_to_host(CPUArchState *env, vaddr addr,
+                        MMUAccessType access_type, int mmu_idx);
+
 #endif
-- 
2.43.0


