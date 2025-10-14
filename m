Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552FCCCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lJn-0002R9-2c; Tue, 14 Oct 2025 16:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJX-0002IQ-EZ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:10 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lIz-0005Lv-CU
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:05 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2698384978dso40791455ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472449; x=1761077249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RYs+R8nBuhH5wnLhGR7+Tv1X+mkctfJ2nU8EoakcyGU=;
 b=YTiQdQqsJlHekxaruxFhBOR2Tbqk/yNl8wISELCn4vBMRebGC24QeJSg0ZPEiV7Uz9
 0X/6V0Glb+nfgfCKQU3tEeMu394ZuTkF55XGu8DbVnL7LA8n3tvjyWMLk17Wv2ZQJpMA
 ZkxrJsNiHPX7zH9X8DxJv61F/XBrKh4UQOxqLbyBt2i1YuQykJM3lHS0lTbZp2RwcrLv
 N4hUu6eRlLHB6+bnyVtydt0rFS0tuhuAfUC0lSdJA8b+7nz6GPLNRpxFgUH6Zp5hYB7P
 ufb4DOBlqO4oWQgEljkmYpjjzKnxW35dPP1XceRwOkivW53BIFUQ+Es0idfdjzY3/KBk
 kVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472449; x=1761077249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RYs+R8nBuhH5wnLhGR7+Tv1X+mkctfJ2nU8EoakcyGU=;
 b=KKAaq7qlQPNEgY9VFnwuX67bLTRuRF9NU22MSt6CBECar6rfYl6s6qHX7NKYK671dw
 3tBhqWS/VKrtYiBNlxGpXaMlCM+3ypNDxdYGtOr/x0MW3Gh3W6dz6XoNGOvY9VD0eH2L
 AszdDy3THEyU4aSQkBI2D9zeHEi6N/cbvUPb6zECF64kLmQd8Izu2SmptgG84lQwLFR+
 2KgwqtcCEE1ZNrreCcfiea/lKzjRRh9ASKkMPgoTTHFuE3LYim3l7M1VOdIZkJ0hb5Uk
 ZBF8giN7W8IDuHyotU7ItNw/zafL62yTa5J09rkA230azfjOFaBXku+/2JISaca1p7O8
 2iMg==
X-Gm-Message-State: AOJu0YytgiQOr99W+T2l7Qa+laU2DW5PDtOEoY6tcNkePV5mthTH9kKX
 L85QIMWde/AI4Ym0CQz1DtxJ47/wwCb9NfK1k/6JdpTQ5yGNzmNmf/MqHRNy4xqCHlCn80VeHR7
 1ieqzF7Q=
X-Gm-Gg: ASbGnctVsOPrVxFDu4oUddahDExyNuJemrLAn3YUhTEQ5eMneAfPeyluyL6BlPAtW0I
 FuUADMIzqwVQyol3F5/VVPn3hvPnQwMQX+f9EK1FJRhNCBzXinOSKkrrPYh++R8Db0l4r/13m9T
 zNcp54wnJWCY+JNY42cmFB3T0GVBNbZAxOVZCXDEPlLqqoxlxUWkGyeywvLsQmbQLmAizba4RV4
 adHqLCNVjw4K+ZZ+tlJa6GRitnG3eUp5sa8dzPRB87GQGQBDQ/9RuPn2QkEb9pKo5kg7Y2HlFNC
 3gfvnNeoAwBod4lQ8xnZwxdndUGdo65F5un/PNqxl2/5vduObc8F9birROxOQgqsDQ+Wpsq9mdd
 J7vtgRJGGCPEOWxSV+WkELcl0KpBZj7VN8EBZ4zya/XcdaGzO7T8=
X-Google-Smtp-Source: AGHT+IHPEMx4e4eTE1GhbtCL72Gkra25XCwoVcJSGS5u1w7u0d5tMSGxSSED9iUGP0IXib1cEP4xXw==
X-Received: by 2002:a17:902:ef09:b0:27f:1c1a:ee43 with SMTP id
 d9443c01a7336-290272c2564mr335665385ad.29.1760472449429; 
 Tue, 14 Oct 2025 13:07:29 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 14/37] target/arm/hvf: Assert no 128-bit sysregs in
 hvf_arch_init_vcpu
Date: Tue, 14 Oct 2025 13:06:55 -0700
Message-ID: <20251014200718.422022-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

HVF has not yet enabled 128-bit system registers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0658a99a2d..aa42fa09c3 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -897,6 +897,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     env->aarch64 = true;
     asm volatile("mrs %0, cntfrq_el0" : "=r"(arm_cpu->gt_cntfrq_hz));
 
+    /* No support yet for FEAT_D128 */
+    assert(arm_cpu->cpreg128_array_len == 0);
+
     /* Allocate enough space for our sysreg sync */
     arm_cpu->cpreg_indexes = g_renew(uint64_t, arm_cpu->cpreg_indexes,
                                      sregs_match_len);
@@ -920,6 +923,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
         if (ri) {
             assert(!(ri->type & ARM_CP_NO_RAW));
+            assert(!(ri->type & ARM_CP_128BIT));
             arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
         }
     }
-- 
2.43.0


