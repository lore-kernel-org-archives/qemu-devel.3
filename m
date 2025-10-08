Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26006CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6c9b-00041Y-QK; Wed, 08 Oct 2025 17:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9a-00040N-AA
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:56:58 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c93-0006eG-IF
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:56:56 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b62fcddfa21so176458a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960582; x=1760565382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u8jzmwbEOdXd1Y+zB9l972AjYHk0b/qSjoQoHCfbnn8=;
 b=mCwAKay2RXiDtvUn5i5SCoURZS/tjFXmdS8bc0h3MDbkUHcbsFGEdBkLcbniYQSUBQ
 JO4yjX33ASZn0zjePIoS7poOyrJC3Y5Mz5WtT05UdyvAHDiubPhiuQflrJIaqPlpP2uT
 62mbN9xfyDG5LOHcYaFnGn2qbd8uRJMms/p/F3JQxyclUmxN68NKqEJHX8nD6j0//wms
 auvRnMBkKVH6O/kLntP67FIcpKCIbzj4Il1akytm6h7T7tx+xTp6/zlJLTcDaMGwUW7k
 YeCFwhMpWkVbliQr0sDp2E57+0twLfqkiol3pSQmssh2uys3GfEpRTB2N7aSzNIdZpAE
 ELmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960582; x=1760565382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u8jzmwbEOdXd1Y+zB9l972AjYHk0b/qSjoQoHCfbnn8=;
 b=XUJYe6qv/k42yViOrp3BQN0z8MMDmgBML+BYX3a3z7q53AeTeBoIuUY+qKRWQ6Pv7U
 SVVtgXhDF9+vbAOT7nXOctX6wvE+t3ravHLwjU3SoY4VbzU63p2vg9euRdok8TIgB/No
 Uyi05jTHPImden0o/NRTDXV3m7eVLrbKWPQkzNcLddILh2kZFbdVPy0ig9tGpYZeLVKa
 dUEOkD2FAnvwWGshjUqpGO+3TnWnbteVLAPzwg0aCXC5kzwSWVsHry400ruTC0yO+Dw+
 ecsCyh30eBBPO6gJwM69Mj2NgndMh1JHrBblMsR5zpi85eJOalIjrV0Kh++oRDz/FG+l
 meaA==
X-Gm-Message-State: AOJu0YwlP6yu+hWsMc7l+h9y9nE/iZ9zV2bScK91xOQA46Jp36pXQuCA
 faL6k1G5BwJ/G+9pvNqokIpb4L7jczhbg5hwDabZlq/3rFOnmf6WnFjzi4FmakpzMiteWNkIu9Q
 ajeMc/OY=
X-Gm-Gg: ASbGncvwoTI3hkaexGuUGkNgPn7WaTH3nHWop3JOiWlJFkI8PXcL9O8m3YR+SLqJvoG
 B+D/3qQ9msApKDh9eVILkUOtsY3aatO4RIWaXuDGRNXj/C1zjytrsBUcSI7/M665H+EkF86FPsB
 EIrYEyZ77hLNk9C/TL5oKz2vPuHl2zX/um/kvMVc9I4qBKA1rvRmmYuGLj9TA2gKn7j4o5Cnre6
 req225r2XpN5CZG5d430bVd3POpVPxf8RmkD+kLoUM+AMG0SpXDK0+lmwxgG1aqmsZZkRwXLZA8
 +GX9zbvAxL1rMgmfa7kABSj1HkVbDXsBTO/g8DNufuW/d1yYbJHNk8pruD0vy45nAWzY3RmxkEZ
 Rf5tdPPNqioDR9FAb4qPu00d2nyGylhmS4BVH0iIwBOO9RyxqXx4rAIUN2AewAY5VJaM=
X-Google-Smtp-Source: AGHT+IF5wkEP2yRVuvkjCG85rUX4HHWM/TXYTR0Az8Quw73+hNrAeNv6eZANJaKLqP9QjTGmBpY9kg==
X-Received: by 2002:a17:903:1aeb:b0:26d:72f8:8d0a with SMTP id
 d9443c01a7336-2902721672amr67151065ad.12.1759960582139; 
 Wed, 08 Oct 2025 14:56:22 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 11/73] target/arm: Expand syndrome parameter to
 raise_exception*
Date: Wed,  8 Oct 2025 14:55:11 -0700
Message-ID: <20251008215613.300150-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Prepare for raising exceptions with 64-bit syndromes.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h     | 6 +++---
 target/arm/tcg-stubs.c     | 2 +-
 target/arm/tcg/op_helper.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 22947c4b78..b59650959e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -304,14 +304,14 @@ FIELD(CNTHCTL, CNTPMASK, 19, 1)
  * and never returns because we will longjump back up to the CPU main loop.
  */
 G_NORETURN void raise_exception(CPUARMState *env, uint32_t excp,
-                                uint32_t syndrome, uint32_t target_el);
+                                uint64_t syndrome, uint32_t target_el);
 
 /*
  * Similarly, but also use unwinding to restore cpu state.
  */
 G_NORETURN void raise_exception_ra(CPUARMState *env, uint32_t excp,
-                                      uint32_t syndrome, uint32_t target_el,
-                                      uintptr_t ra);
+                                   uint64_t syndrome, uint32_t target_el,
+                                   uintptr_t ra);
 
 /*
  * For AArch64, map a given EL to an index in the banked_spsr array.
diff --git a/target/arm/tcg-stubs.c b/target/arm/tcg-stubs.c
index aac99b2672..aeeede8066 100644
--- a/target/arm/tcg-stubs.c
+++ b/target/arm/tcg-stubs.c
@@ -16,7 +16,7 @@ void write_v7m_exception(CPUARMState *env, uint32_t new_exc)
     g_assert_not_reached();
 }
 
-void raise_exception_ra(CPUARMState *env, uint32_t excp, uint32_t syndrome,
+void raise_exception_ra(CPUARMState *env, uint32_t excp, uint64_t syndrome,
                         uint32_t target_el, uintptr_t ra)
 {
     g_assert_not_reached();
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 5373e0e998..dd3700dc6f 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -46,7 +46,7 @@ int exception_target_el(CPUARMState *env)
 }
 
 void raise_exception(CPUARMState *env, uint32_t excp,
-                     uint32_t syndrome, uint32_t target_el)
+                     uint64_t syndrome, uint32_t target_el)
 {
     CPUState *cs = env_cpu(env);
 
@@ -70,7 +70,7 @@ void raise_exception(CPUARMState *env, uint32_t excp,
     cpu_loop_exit(cs);
 }
 
-void raise_exception_ra(CPUARMState *env, uint32_t excp, uint32_t syndrome,
+void raise_exception_ra(CPUARMState *env, uint32_t excp, uint64_t syndrome,
                         uint32_t target_el, uintptr_t ra)
 {
     CPUState *cs = env_cpu(env);
-- 
2.43.0


