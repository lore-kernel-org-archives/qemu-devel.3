Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D455FC3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 21:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2z0u-0005z2-S3; Thu, 10 Apr 2025 17:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u2z0s-0005y2-VC
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 17:00:43 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u2z0q-0001m5-VR
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 17:00:42 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so1170190b3a.1
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 14:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744318839; x=1744923639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9OwVMJQ+nPgoXVT+v3WG48aEZrZJjJFRvNoKJmm5KU=;
 b=genz2iH7VjZDoX8FyfqXEJoTHv8CZ3qUiUBLr5eyU7AWxndlM3cDNQr4DAvJgZwMCC
 oh+ZZSjU0ai+i3KlRR960zsFB2Ggk23Ivx2Lr9PZQaYC8RXaUNUu6CGvsxLhHAlUq3TP
 yEhY2F8mh/y72bj+dXB6cBcAGraep0ejqfD3YjLC3kxLaNNLM/HtIaPJMVR+fHjbBzCa
 3vRhfGmFhp76enPILSxNSdu2F0LYDUYEv9b9DG5r2IZEfywxBzi16s/Jn3sI6xcizTL8
 EvVV31mVxoSxRWpIWnO3AHSW1jbzDsgcxwisFEyLeD5+ftHOSab79RenZ+jT6q3jcVIn
 iT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744318839; x=1744923639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M9OwVMJQ+nPgoXVT+v3WG48aEZrZJjJFRvNoKJmm5KU=;
 b=l4o70oU7bDeT6Jp2QB+Z00YwBau/7zlJGyTL4bzK9Hk1Na8P5KIkKK50AIdm0y/GNk
 kh86FQRDBQTd3EHgC5uq/d1asGNRjcQ/iOWkd/NBz6Pcg9QV0cDKMPsIC5qw7QAttd2z
 Np2gTj5f4Q+iX0kpOjEr/klx+9oD2b9MSPtAC5n6jzXQ/Qrg25l+IEE3TDMuhxEyxAs+
 D2hIBoqYdQCpJaXUMrc3u+W3LrEaepMCK6tXhjq7ACqCXMkgE/XNMuCwr2fi9wH6fxSb
 qsFufGHHV3UMTk4qQmxv5gEImzxJ/nvtcwAMIt4WmAvvWtgfWqH7NBOWqh61tzUyWx+I
 NA4g==
X-Gm-Message-State: AOJu0YwRxsorzxeCcuDK7frsgkRsQ2/m2cApd0Ip+zXgdwhGu4uZh5Pu
 NHCdgdKNkuAVBw82R11jBaXRMI/MvNuyYXpfGBa9Hp2aYiYRyrxix2iIWIQQqhecWR8c8fVPWq4
 F
X-Gm-Gg: ASbGncsgBXlyAApPtl1cS7ysW4klKHSUBcf0A1y9eaUNlAuq3BT7ReBporJfj2uD/DM
 3vZ4vgbT1AWye8kR0IxMQfLuuu7IS+c++ZXvpfPJ+NZsVuljccnFkgVuia8X7TTeU33SkFF+6R5
 /uWwqbEGOIR3O2K/YtrlDJlniBNk9kZeFG8N4qM1yK+VaDnkRpq+iIT3bLtMcTyOnXudjCtVmy5
 Fc9HQEFHFWmkG2e1guJFZbHlad6g2EnU+4gOta2BIes/Um6JYKI7Jj/Zmow3P6cBZtcewmJQxh2
 Tqb1qTB64+3W6f6CYt5mXXyhawnHLl0hbDaqr2Lf
X-Google-Smtp-Source: AGHT+IE2yp1m6sBCLp+wVAJ0VFY7M3tuLn6xaXJpPkEtHMIenwsxdNR9U7U4c12ls+Lzhnd5joWPeQ==
X-Received: by 2002:a05:6a00:2284:b0:736:34ca:dee2 with SMTP id
 d2e1a72fcca58-73bd119993dmr361114b3a.4.1744318839065; 
 Thu, 10 Apr 2025 14:00:39 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82a3sm12431b3a.90.2025.04.10.14.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 14:00:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 alex.bennee@linaro.org, qemu-arm@nongnu.org,
 Yannis Bolliger <yannis.bolliger@protonmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 4/4] target/arm/ptw: fix arm_cpu_get_phys_page_attrs_debug
Date: Thu, 10 Apr 2025 14:00:22 -0700
Message-Id: <20250410210022.809905-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410210022.809905-1-pierrick.bouvier@linaro.org>
References: <20250410210022.809905-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/ptw.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 6ea39ee5755..5b8d84d44df 100644
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


