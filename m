Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F236C3ABAC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbPd-0006j4-EO; Thu, 01 May 2025 17:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOr-0004rV-Kq
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:58 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbOp-0002Cz-E1
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:24:57 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso1210398b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134694; x=1746739494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ICTmvXj5A3w7ZXPfgfLwt1QtBgbPFqHkFzgva30CPac=;
 b=Yqai3dhuWLqYhuwcH9tQWqis/1RfSV1w0jCZ+46gv901yOqVtJfdu4BHi76153nlKa
 DP2NWXeVQfsP2Gx0jM6Kgee3kN6mC/h30ectwVUD9Pbuy3GZcvhtNr6TIH/WXDAMITUY
 N/8XGQfemS/oLRTvGqjY+upcTESDM+GoTL2c4ei0C9UTcIzKQOdWzoGO9/rv18Ar9Znx
 2ANCM6MtUNY1Wh4/UltdCEsUukKM5L/5U/9SYpO9eZYFsdmpwfnKRseUkGHGWSSlMBE9
 MaLVYar1XN97updlNwmVIUwSdjJY37pwus0ARg7g3Njie2Sa7yrC9eW+UKiSPoMGF/vC
 6oeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134694; x=1746739494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ICTmvXj5A3w7ZXPfgfLwt1QtBgbPFqHkFzgva30CPac=;
 b=EvecX46IxwiwQW7u+JlJd+pFpjIcUmf0Tshjgzs+H4I5OHLfwcyWKzBoBtXDWQybjE
 7MLyfy+VQ7j/TFGJTdhCS543w2K11zEBFgzaRmKgibYN7Rqs2yKFbxMdwIAVJM0KFrJO
 AK2cSvRgzwwdlnjUpTfS90sdhR7cwCpu1FdKZYL9pZb75TY2rORgftOd4a9oZp2Q6IGH
 B7fv6E5Uc8jxO74MWQfFAz+xC++ZOH0/R9VCjFJrPbqTFkplR/6EL4SM/0Ez/7OOqo4S
 ioYYZ/lUZ5axCFV8wzeOCVO9jJtlNw1Hs2DImHjXiAqck1gSyaEHUFFsJDL6+C9MSkiv
 GkLg==
X-Gm-Message-State: AOJu0Yz/iiazplUA0he1qLxc1gv0hDxgoi73ZZ2We6Wu6ntl6l2nwoE8
 u6Q+zo9hxX9nRA//0kbxjFU1vdBizZHDrYjEMrNjkDykCc+NfaJpI5X0PJFVxs/jcg2YvOQyuMm
 G
X-Gm-Gg: ASbGncvN6yM0HZXoNQc0P4BZipi6MhyyCmMVDeUfwXScMlBxFbk5tXuU5utc+HoCurS
 kN4Y7UWBRRTnmlgaM7jvt3DOnGgElsxnKwkIHp3Q6tgiFFuY8KqmD5JGRCH1PCwnfcahjn27Nym
 v+bMsYudAGjfoPHFACm4S6X8qoHbvtKy4hw1ByBEMneLElYPKn6fLS2uYWP3ZHpFqGjPBWOTIqZ
 hW38JE69XBdGzqzRtJAEd1fpHUegU/78tM6/keaFjcAIE4931wDAaIaigEfKlhexlJFFLDmd2Q+
 /7JAtwN5PoPrFAKZICRdn5k97BhTostjEbg/7rHO0vR3JOmqfoFoK4NZZOhMVrV53IOsL1stpPM
 =
X-Google-Smtp-Source: AGHT+IE+kBNt/6RsI0YkznovL1BOqcBzFqX2FnW/fQgfvMip9JOn3A7Rrb2Q6xcPmSE7BtvDZhYZiQ==
X-Received: by 2002:aa7:8b59:0:b0:736:b3cb:5db with SMTP id
 d2e1a72fcca58-74049264140mr4987140b3a.11.1746134693736; 
 Thu, 01 May 2025 14:24:53 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590610desm135897b3a.146.2025.05.01.14.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:24:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 50/59] accel/tcg: Move tlb_vaddr_to_host declaration to probe.h
Date: Thu,  1 May 2025 14:21:04 -0700
Message-ID: <20250501212113.2961531-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


