Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7C0C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 21:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xADov-0008Ij-3Z; Fri, 25 Sep 2026 17:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADoE-0007ln-Kp
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:27 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADo9-0007mg-DV
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:21 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-880cb967dffso409477b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 14:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790373016; x=1790977816; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AMEmlBAFtWi79NQF55/dXyLKuHzSkHvrh+ifYujfOUA=;
 b=xHgbYR8U7/m9/riIChd4aTpjdBw0rP0RAyuQi13n4WMlxUVXonB3dyk9MY063r+vRb
 nc7WOSZi9iC+gIHPqvYqZ4fZbxLtMp7eUedhNZ+5QEdQvdouo2Pq39HRhOr+Uf/jzKjz
 Z1CkO50lds1CWEVxMwrSPUrOBpcf3BghRoqomqAdOgl7GHU6u+LktrOQnI7p03DUD8t8
 WxbmgWMbuW5WHv/FuJglMy+TJuu7iMHigMAa/1EXNYn9OqseQpgMc5ah6qZrRA2O/9FM
 d3D42l4WkEOgtWLm9sHemWIXLqkwocy831XzgB/mn4VW8Glauavze3gRYXpDA9Xip3JU
 dMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790373016; x=1790977816;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AMEmlBAFtWi79NQF55/dXyLKuHzSkHvrh+ifYujfOUA=;
 b=XrtpmQliBbGQlx+XS3Y1hLFlcAAZBZ29jHq/re5bIbcfN+M3gnvkc1jFvr7iD0+jEY
 2HpPt0CqNrn/AEDCvcNbp6lhn/Euum4jxvsE0T8Qy5+/0BKLUYgeXGZBeJJj13KXYzMU
 EQz7DUykXXONu+VXH/BHM28Nb5cbGGD0RHNwUlS9dX3sw0+FEo/30oNuHXQlVY5+yjB3
 r2rJea5AookSriSwJ1dGR5gmAH4dcYIN5PdrJAyugEE6g49mzOejSBL4cmhxXAFsuVeE
 53qv7nMctkVRHsINLZX1dkfV1tbHO9k3dQptujYMzkVP4hJR0vcFQIeym6aoSB0rKQGZ
 YjJw==
X-Gm-Message-State: AFuF++lKlICx+Bi0MaE7hgkEqmytGNvQFn7++hVuixStPwnG2kpY50J/
 62FUWF85JTrZOvlV4C6Ca+6KH/AqJSVXAFwnMR3dMdsiIrghHn12XENWuXR2Vgk44uUxFDeAxpG
 Fn3rY
X-Gm-Gg: AYBFou0nUTVIsbWQ3YMIKt5a6+9rg5ZTI8JWXG/f8RtzFpGgKj3VLIvWZfXHH4V2iAv
 mX/etD6fGWuinac9O5S2hC986rHSkOVWS5wIYFH503z9Mgi601Pjxc5gPX7nnf9HNSy3kXL/nBC
 SSa7tLVvysUnI5uyfL8ORrqgDCvOfwk6QxlWBAYAopLFdBN0j2bUlmyo5/aPT8lg9dFAsBa3uC2
 qzFVt/UoGOyzyGxskISci9lXUGjDZONkN0mf4zjmKyJ6prUCPmQ8rUZFRKSSb6krImc2+pWELHh
 fyKaH1iASJvlq/B78sX5rF7gsVTLdoe1G/qxQzta3K7QtalVecb2w/G8+gwTxnAPZeXUD51kfUl
 vd3cro1DtVi50kXMVQZ1mm0U+9c8LcMRyLffTus+1Z2CWwrNRYUGeZ8RmHeybGXm7dTNJ37s9UV
 BXbTjjOPVXVGPBYbtKL7U/eMEIuTpiC21dpUKepRE0dD7bA35PfPfhclPa70P9qvUd8TirXbmx8
 HkowTakytDZVgxBTSyQxNAaY4T+rg==
X-Received: by 2002:a05:6a00:c584:10b0:880:d895:4c60 with SMTP id
 d2e1a72fcca58-880d8955316mr661857b3a.30.1790373015215; 
 Fri, 25 Sep 2026 14:50:15 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fea1940ecsm1725256b3a.13.2026.09.25.14.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 14:50:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 09/14] target/arm: Widen cpsr_{read,
 write}_for_spsr_elx to uint64_t
Date: Fri, 25 Sep 2026 14:49:59 -0700
Message-ID: <20260925215004.456336-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925215004.456336-1-richard.henderson@linaro.org>
References: <20260925215004.456336-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We will shortly need to handle bit 36: PSTATE.UINJ.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 4 ++--
 target/arm/helper.c    | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1efda543270..843e12487ec 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -2016,8 +2016,8 @@ void vfp_clear_float_status_exc_flags(CPUARMState *env);
  */
 void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask);
 bool arm_pan_enabled(CPUARMState *env);
-uint32_t cpsr_read_for_spsr_elx(CPUARMState *env);
-void cpsr_write_from_spsr_elx(CPUARMState *env, uint32_t val);
+uint64_t cpsr_read_for_spsr_elx(CPUARMState *env);
+void cpsr_write_from_spsr_elx(CPUARMState *env, uint64_t val);
 
 /* Compare uint64_t for qsort and bsearch. */
 int compare_u64(const void *a, const void *b);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0111cbeac03..2034f1d1f17 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9376,9 +9376,9 @@ static int aarch64_regnum(CPUARMState *env, int aarch32_reg)
     }
 }
 
-uint32_t cpsr_read_for_spsr_elx(CPUARMState *env)
+uint64_t cpsr_read_for_spsr_elx(CPUARMState *env)
 {
-    uint32_t ret = cpsr_read(env);
+    uint64_t ret = cpsr_read(env);
 
     /* Move DIT to the correct location for SPSR_ELx */
     if (ret & CPSR_DIT) {
@@ -9391,7 +9391,7 @@ uint32_t cpsr_read_for_spsr_elx(CPUARMState *env)
     return ret;
 }
 
-void cpsr_write_from_spsr_elx(CPUARMState *env, uint32_t val)
+void cpsr_write_from_spsr_elx(CPUARMState *env, uint64_t val)
 {
     uint32_t mask;
 
-- 
2.53.0


