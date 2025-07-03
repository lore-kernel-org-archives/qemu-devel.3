Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34854C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHil-00053L-0B; Thu, 03 Jul 2025 07:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHgP-0007pJ-4W
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:52 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHgK-0003w0-UE
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:46 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a6e2d85705so4324279f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540443; x=1752145243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tF+udBuXlMZaTJB7NQwpx0fE1exKYPgD405Hy0Dxyzg=;
 b=G2XpVDw9QhCqWMNjxyMt+2JBY7rCChvQqwtpfM3ev4k3Hs5l25lC1PKepadoAdPJHn
 o8kggRO+aCUGiW91nc/3eZOua+MTb+XPujDffNmIyHkBSPUDi2Rckmus6OWxwIBwCYmv
 3h7UjtW+1HFRmvsG5BI/LTJNM/LuM/3LhFM4aYSOED8N15+YNDjlUFX++mO6LbZgj8pR
 hP/10/DwgRLBbhm1mCaQqcB4p2OrH56Ib6L0GJYx9pPSzIa6e3WYaApvfs3a2SFEwrEA
 oeIymow4HLyGfGS2lMNPAFFqH4JjYYk4watXcVtPlNhQBoLrxXTCAu+y5csq5VUZPH9v
 wMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540443; x=1752145243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tF+udBuXlMZaTJB7NQwpx0fE1exKYPgD405Hy0Dxyzg=;
 b=CHHMi++NtGJ2fgsn6IwJCN3bm1Fw4yTDXISTVdrpl1iqvWHUvTYxe0bJyry2rb6nnD
 5TOUFgIGwetP4hBeMwgXSc0Dq0A7CB374q19CpqQyJNi8RLuFgIkwoZnHYYN7/JSXn9z
 oPcTGUZYTVD0W5AoBiUMVsMyznjyw7GLupMd6C69q6x0qQ7j4CQWSiUKo6sylp5+5nYV
 5bnCU1e0fG+SY2vbVd3R2d/YQiIQ3d2YtCyKhnCSp4j6ZbMKx7YZuaCLq5XKn+NaYfzi
 qWvmFMvf0HxCHOvvj7sRca0XGWEVP135x2Z65+5KWakZ2tZfOQzHdIgSmXCrFtZ91Xh1
 8zoA==
X-Gm-Message-State: AOJu0YwriBaBrqzGXzV5iUL1ybkWZdCh0nSkMqmRqYse5xMfEs6Gv/qr
 7eVw/kdV0n0rDbnycEvEfkQD2TiVoiW0OdHcOAQpDojesTp/Px2FvoqHh0Bzx5Jbp6q4jsPZ+LI
 XvMugqhM=
X-Gm-Gg: ASbGncv3i/U7SXWoVqq1aBl+OwEjfB1vfcF5uC7Ms/1jQt44T0lNXbRwYV0sU+Tjkiv
 A7agVTIFRkz1hmehBA7jSs+XVKHN3St+ZweL9rXjNBOkm9kRaS1HaciVuAqFXY1MLFRA2Yuu4NZ
 3KxfV2xrG4IzWg3mMD/G8S9jxoiGy62IaaM+a7EfH55beAVTAy3BP+lTbnwDLqPtb1Z+2ZdSr9d
 8QD/7gbqwk2qfIMNmrjyHScyJNu87wflKbZ7ty2u1t2pbv1/pI9kKg1BieA46Bqjswir+yiQOr/
 5Dtn3SM8UjKc2kEDyJTM98QWLNulkpF35DXgv/v2QnS+ccYRGLMbLtxnJlh+rTblxfyFJDyz39Z
 nlE9tDNXAPo0=
X-Google-Smtp-Source: AGHT+IE9MaP6O8rg7LcUD14UXSi8Yb3/Nbk4djuxfcMPH9STA702dENVi7CTAIjgya/lSPc6DJculA==
X-Received: by 2002:a05:6000:2503:b0:3a5:8a68:b82d with SMTP id
 ffacd0b85a97d-3b32f28e522mr2309608f8f.43.1751540442845; 
 Thu, 03 Jul 2025 04:00:42 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a87e947431sm18348471f8f.0.2025.07.03.04.00.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 04:00:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>
Subject: [PATCH v5 57/69] accel/nvmm: Convert to
 AccelOpsClass::cpu_thread_routine
Date: Thu,  3 Jul 2025 12:55:23 +0200
Message-ID: <20250703105540.67664-58-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

By converting to AccelOpsClass::cpu_thread_routine we can
let the common accel_create_vcpu_thread() create the thread.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/nvmm/nvmm-accel-ops.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index 21443078b72..bef6f61b776 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -61,16 +61,6 @@ static void *qemu_nvmm_cpu_thread_fn(void *arg)
     return NULL;
 }
 
-static void nvmm_start_vcpu_thread(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-
-    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/NVMM",
-             cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qemu_nvmm_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
-}
-
 /*
  * Abort the call to run the virtual processor by another thread, and to
  * return the control to that thread.
@@ -85,7 +75,7 @@ static void nvmm_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->create_vcpu_thread = nvmm_start_vcpu_thread;
+    ops->cpu_thread_routine = qemu_nvmm_cpu_thread_fn;
     ops->kick_vcpu_thread = nvmm_kick_vcpu_thread;
 
     ops->synchronize_post_reset = nvmm_cpu_synchronize_post_reset;
-- 
2.49.0


