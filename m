Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D040BC369B4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 15:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Llu-0000gZ-DT; Mon, 14 Apr 2025 11:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4Llr-0000e6-Km
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:30:51 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4Lln-0005Xn-EF
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:30:50 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22a976f3131so46250605ad.3
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 08:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744644640; x=1745249440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c4v87EGjTuaQERVq3RVHNWa3GtHDbP3djfUZXGNYCVw=;
 b=M6HZr1FzQcGRtOMMrtRblHUGSJ2c/X0+YX7iaYopFIg+SgmUBgPyAwSwyuqeSJcSqP
 6vwHmA6LCnfmG7cDsji29aEamHBKNvPJf7s1770g59V6ykY0K+uADtnOJVWZ+qXikWjH
 pr8R2GGfKOxHDLS88wzG1ae1nPEWpJTMjZBnmbtM/+dlTiL61Rw3nP0Qfywdvq+skF3V
 BbqF8L1ciK3Z9gO4vtxiullCTnPY20Js29YeDZwUBdyA4jo/y24zszRAOKdOIJxmTM1J
 0Mru0m7xunI9UagP2UNuJdWq67kXybBS6uyX0o5vcMiDH0dls2fXOZWaNVJyHck7bCpJ
 Yffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744644640; x=1745249440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c4v87EGjTuaQERVq3RVHNWa3GtHDbP3djfUZXGNYCVw=;
 b=MKbG5XAm27MqB7Unf4NS2V9KM6srcG1jo5wvPhL2mcLGL/5L7gsPdv0GNB+NVKP4Id
 x3zNPmJWj1HgqG591I3FDOGPP+QrLOw7PXYmGPq5cllVcXKCqB4dObH0O0G03Vl3N51/
 hos3UUcL4IlhimUFlKDVN2zT2F/UiKSKHWAIQ9tH+9BAamBCDGLs4P5hklH5akkEsTde
 6wZ3I2xtff6jw032zVtebfnE235G/GDO93XlBt1758/a3KbKegA96TwO2DVW40t3iJI5
 CjLJDy57ScXZzUkBFtw8oFJL/2AHqcbAHVuD+CxHOE0p+Sm2ViYNVtD+c4o4/u1X8y1R
 mktw==
X-Gm-Message-State: AOJu0YyE26CsYtWyd0JWSQarLpcYtQoc5ci/hu0uAJ3f6sFe6dScCWqF
 EfAdLxUWnz8S1xUK56OREn6l+Mnnmtr/62jp4QVs3GqEkKtSuwnGORj8Bc+4lhieq6BUisshHBn
 O
X-Gm-Gg: ASbGnctGcOSvcZYQBeYxLCZP8GRdZBL/YmdrV57bKs6uf4ip6IIXKl045rqAuyPTPOB
 rpW5OXZ138DL8MiI/QrwESMedZ/AKL4PJrSxiKHmwUmSDoed7P+N23gtc+MmvzlsTa9rS+gxzw/
 uwNt+6LyZ5bGkMS3iQl8buvq08lLwFae1VAFoA4r9yva/HDhCiGkJ8+noy1h9RIS0NljrP59EMS
 MnSiytm75zU8GaJFNNNIPJWOqj3O/RqzqA1wtLOurbg/0iz7PZrCYCSIQMzZfGoJ1pQMBQEARo/
 73CCPWzAuHRpWe3KOyQiEKxyy9qAp6qKxBeaRAJKgdfpSgUx0Ic=
X-Google-Smtp-Source: AGHT+IErOMe/2SumgHtLOhL72nnzAQPEXbOu62JvPMBkg7DycAM+FmSMWOFseN/zpAk5e4qGNnlOvg==
X-Received: by 2002:a17:902:f64e:b0:223:f9a4:3f99 with SMTP id
 d9443c01a7336-22bea4c76acmr193097885ad.29.1744644639773; 
 Mon, 14 Apr 2025 08:30:39 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm100735235ad.248.2025.04.14.08.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 08:30:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 Yannis Bolliger <yannis.bolliger@protonmail.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 4/4] target/arm/ptw: fix arm_cpu_get_phys_page_attrs_debug
Date: Mon, 14 Apr 2025 08:30:27 -0700
Message-Id: <20250414153027.1486719-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414153027.1486719-1-pierrick.bouvier@linaro.org>
References: <20250414153027.1486719-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

It was reported that QEMU monitor command gva2gpa was reporting unmapped
memory for a valid access (qemu-system-aarch64), during a copy from
kernel to user space (__arch_copy_to_user symbol in Linux) [1].
This was affecting cpu_memory_rw_debug also, which
is used in numerous places in our codebase. After investigating, the
problem was specific to arm_cpu_get_phys_page_attrs_debug.

When performing user access from a privileged space, we need to do a
second lookup for user mmu idx, following what get_a64_user_mem_index is
doing at translation time.

[1] https://lists.nongnu.org/archive/html/qemu-discuss/2025-04/msg00013.html

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/ptw.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index bf92c165175..cdcb6a49fa5 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3655,5 +3655,25 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     CPUARMState *env = &cpu->env;
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
 
-    return arm_cpu_get_phys_page(env, addr, attrs, mmu_idx);
+    hwaddr res = arm_cpu_get_phys_page(env, addr, attrs, mmu_idx);
+
+    if (res != -1) {
+        return res;
+    }
+
+    /*
+     * Memory may be accessible for an "unprivileged load/store" variant.
+     * In this case, get_a64_user_mem_index function generates an op using an
+     * unprivileged mmu idx, so we need to try with it.
+     */
+    switch (mmu_idx) {
+    case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_E10_1_PAN:
+        return arm_cpu_get_phys_page(env, addr, attrs, ARMMMUIdx_E10_0);
+    case ARMMMUIdx_E20_2:
+    case ARMMMUIdx_E20_2_PAN:
+        return arm_cpu_get_phys_page(env, addr, attrs, ARMMMUIdx_E20_0);
+    default:
+        return -1;
+    }
 }
-- 
2.39.5


