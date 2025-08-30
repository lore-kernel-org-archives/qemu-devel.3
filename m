Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2082CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNsW-0004Lk-Vr; Sat, 30 Aug 2025 11:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usCRG-00052b-4S
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 23:39:39 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usCRE-00052k-6t
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 23:39:37 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-248ff4403b9so17137235ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 20:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756525175; x=1757129975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/kPH6riYNOweQhnmn/RRL6i17iJqnbvBitGNZ3+s7oE=;
 b=N2+c3b041/8AsoJbylas1AcFxZUzs9Lf9e2cBGJajpFmnO1lbBiMjWd7AcZDz5rBJc
 Mej+9VIO3InNmP9lskcTPjg1fl4vyQEjOR7kVttDijmM/Dp5/xYfdKWrJOhdDlzV69FT
 PxqLG/tFnCdlYg+hJZCI4FHb4qe3nmkpWZVqCvXfLfLL9y2sbfIfezl1mKVpTeCRimg0
 grGVVuMML91bmA9G5nzuRAPkbK5Byyn3/yp7UJoXps6yejKkNGjaKgCATU8AijlNkYWp
 +7v7sc7AW6A6CQi090eIeWOSJZik8vldLzDKTStcH+zFWO53LrRVt3dCi0b1MvpMkpLE
 4FZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756525175; x=1757129975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/kPH6riYNOweQhnmn/RRL6i17iJqnbvBitGNZ3+s7oE=;
 b=Bw4d/9wW9+6ip04oFAKtSadV+DmvL1VwzDnmWnMRFOsN3Vue8Dsy4/Bl0wVgUCNuH/
 E2E1K7RiOInBoN/twIA4tZNT9mRh2hR6bmeui5lzYBN/IhYc+vHwHNhljOQlcE1PH0Mi
 peZ69AVW3AL7LdJ54TLsHcB3/BLIqx6ME8imM/Zwbb+LEPbD6+TA4SWyEUMBraEGwVQg
 ALhYZfVq8tHh2YyePnooPv+NDR3rrFMYYNc/DrYYKIxdCy28CVIgOMdhHMoVbczG/1H7
 7HddCBT7wDZ1fy2VIoluGJKbGO9Uq3y5bgBoU3Ob5vaanHgHtiACzB0IXsRMSQPUlpku
 uFQg==
X-Gm-Message-State: AOJu0YxojueJ/VYG/anp5ruR7nseFHGJsuklXZjMgBdFt8g4DlsNalBf
 zmQQKRfq/jSQ2V65X1iVTrbNMU/qsm3pcNXfLaV+UwenPHc4S0Rk3Abmxr+lNHiM8zpYlpjGBqK
 /vGwKh6Q=
X-Gm-Gg: ASbGncudw0yUpTW5QpUPI5Je40GLEyMJIpVpckpVEdeuez8jcBsxUTHy2mRc0CqaozG
 eNV5aUmHknYZPJS6fyR0vQFkfWndGmqffp7wYU5fX6p97WDOkUrl3WqAt0BVIiLdDXMMujwbRq7
 +4aEab+gE7NpCOLt7DzbdVdc9dcUoq40ZE5SGyVw8zaL3g8cPevqnLvVciOVBPw6dsElx0XNbqW
 Sa9ZHn9cdCp9zMn/vYFlVnP2e14ZRwMzVHejimWlDsiz14FTlxXxNquZUIs+991HyHXostJLbhW
 OAyk2qAfF6TTm9slLvK0QkIJRKfkHVxu2cEeh8xdXdDgVi6j5PSijhGI1/gXaq5IyissmeRqPJs
 3J8S0Eu5r13qikXHmqP6XkSR7UUfVSBxVeLXSrejBi+f4WEpF9S/OfoyO/eZi2O8=
X-Google-Smtp-Source: AGHT+IEf/E7/fn/EFXd3pP+tALwMK3dxEbTHbXsrpxObaOKTCXVnmpSmLBscr0OXpA2LjLb0XABcgA==
X-Received: by 2002:a17:903:37c4:b0:246:cb10:6e2f with SMTP id
 d9443c01a7336-24944907804mr11575335ad.26.1756525174653; 
 Fri, 29 Aug 2025 20:39:34 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24905da4784sm39551685ad.90.2025.08.29.20.39.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 20:39:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/5] cpuinfo/i386: Detect GFNI as an AVX extension
Date: Sat, 30 Aug 2025 13:39:22 +1000
Message-ID: <20250830033926.372955-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830033926.372955-1-richard.henderson@linaro.org>
References: <20250830033926.372955-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

We won't use the SSE GFNI instructions, so delay
detection until we know AVX is present.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/i386/host/cpuinfo.h | 1 +
 include/qemu/cpuid.h             | 3 +++
 util/cpuinfo-i386.c              | 1 +
 3 files changed, 5 insertions(+)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index 9541a64da6..93d029d499 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -27,6 +27,7 @@
 #define CPUINFO_ATOMIC_VMOVDQU  (1u << 17)
 #define CPUINFO_AES             (1u << 18)
 #define CPUINFO_PCLMUL          (1u << 19)
+#define CPUINFO_GFNI            (1u << 20)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/include/qemu/cpuid.h b/include/qemu/cpuid.h
index b11161555b..de7a900509 100644
--- a/include/qemu/cpuid.h
+++ b/include/qemu/cpuid.h
@@ -68,6 +68,9 @@
 #ifndef bit_AVX512VBMI2
 #define bit_AVX512VBMI2 (1 << 6)
 #endif
+#ifndef bit_GFNI
+#define bit_GFNI        (1 << 8)
+#endif
 
 /* Leaf 0x80000001, %ecx */
 #ifndef bit_LZCNT
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index c8c8a1b370..f4c5b6ff40 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -50,6 +50,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
             if ((bv & 6) == 6) {
                 info |= CPUINFO_AVX1;
                 info |= (b7 & bit_AVX2 ? CPUINFO_AVX2 : 0);
+                info |= (c7 & bit_GFNI ? CPUINFO_GFNI : 0);
 
                 if ((bv & 0xe0) == 0xe0) {
                     info |= (b7 & bit_AVX512F ? CPUINFO_AVX512F : 0);
-- 
2.43.0


