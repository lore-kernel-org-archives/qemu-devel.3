Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FA0C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqEG4-0006pG-FW; Thu, 06 Mar 2025 11:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEFw-0006kf-PT
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:36 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEFu-0004XC-SL
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:32 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43bdc607c3fso5934355e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741279169; x=1741883969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E0hdGCsrUBN3Wc4QZ13PTDB9u8eo9z7EzbgSppoTB1E=;
 b=lg828fm8L9ZKBVx3DN8VQee9PmuHimim0HNhiER6bkAL9gEysurK4ozTluGC/JStt5
 bJ1vkE0uPn3YiKCPcDzaPDphCMya3Mrnr0hjMEaoG3BNgdY2hFLsD/dUb4HmqO5uuoQf
 5E+fizwghKiG9uhjswdr8UcJjTWq98KRgP9ZmMb+VrDo7Hx7nzlCouHWl/c4tSAtiJO+
 hBbSQ9W++bQq219b7+FvX1eOg+s+faLGlM5uxM09/deGfEczXHjEmd5al2HspQqisXl3
 vCHZnAw6dcT/5RQoW6gQvSeyb1nbQzeQTtQUMdXbhQD0nD9DLMVNO0L3axEfFB8JA5Xj
 9+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741279169; x=1741883969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E0hdGCsrUBN3Wc4QZ13PTDB9u8eo9z7EzbgSppoTB1E=;
 b=H0vQdH4s9urrrGPtgFbcNT01OvmMzeRFS+5i57nB48qEP0XbOOmkeSoU/oP+2RGn4Q
 SKq0xsZB/xUSjJY//mC6/tGWFaQ/vAhEUUPg8aiGCyeyTgcQAivY4SPXWr2Lzno4Lrno
 cfjBPZ6MKMMcGrg0VpTaqvudYxfAf0d1nVdyjnL/qX4YL0/6+yvSPt973/1/9zjLP0Ps
 ySX5C5Vg4IfIeecPWT5DtNrSAqJaS9Ncp1uH0/E9UgcWeGLBDpNmAM/3iBYidHzHBDhi
 rY93msR+8nZcu9rM08ypZL9YyAwDaMufB9cZK6x+GWOgDGFBRAxsVLoA8dpubPNxQGHo
 kaNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2KWSkXqjvnkGcn2GgQPNyuZjqC5P60LJkR/pmcD17JQPDDdxUzTgVgpQiBQKAu1qixPv2CBFIt645@nongnu.org
X-Gm-Message-State: AOJu0YzCJEBaoI5m1/NvBvdiXBSijaJcfvmTEDCZpOGIOnQ9io0lc5Hx
 F3dzDpzYkk4zIiHCCndZ0EKuecjpGVq8I94+ZvJr3wyn/HnEi8iAP53lzeL9zWo=
X-Gm-Gg: ASbGncvTw/qcA37ty7BGPRM4XPORlbP+9fJaPlgcC9YQZDycpG7UuPYaAyIhDyFkVMR
 aVd40Dn9ftfgUj2kYg0YXk/4h1et7kkHRWPSWgAVOdq9ms41I8/uv/lO5CqEFZzIL1FoAeod3gc
 4ftc8wET3TC2qc5iM5UDvnzsh+t9l/curQbCu+kbpNx1G2ESY3qMEK8BSb1LxuZ9GHLdkd85Fob
 1e4QCDG4cwZnXvho3x3E3eued57vXdRSHaclY8uxB4chgRD+Fl5ektP73/dZ+WMy7syOC9/tNCq
 bQ5zGrjVvEFwuFHGWMtY2b9Fuye0qipGGDT4/G4X6JIC9E8n44g=
X-Google-Smtp-Source: AGHT+IFsn/ec1R9i+Fpps338yQh6rBG8tA2TWcz6GS2dcpzjiXbcNjaeAPStctOe3FWvDL1vF5KGnQ==
X-Received: by 2002:a05:600c:3544:b0:43b:c878:1466 with SMTP id
 5b1f17b1804b1-43c601d94f1mr1280315e9.8.1741279169336; 
 Thu, 06 Mar 2025 08:39:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd94913fsm23999905e9.37.2025.03.06.08.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:39:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 02/10] target/arm: Un-inline access_secure_reg()
Date: Thu,  6 Mar 2025 16:39:16 +0000
Message-ID: <20250306163925.2940297-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306163925.2940297-1-peter.maydell@linaro.org>
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

We would like to move arm_el_is_aa64() to internals.h; however, it is
used by access_secure_reg().  Make that function not be inline, so
that it can stay in cpu.h.

access_secure_reg() is used only in two places:
 * in hflags.c
 * in the user-mode arm emulators, to decide whether to store
   the TLS value in the secure or non-secure banked field

The second of these is not on a super-hot path that would care about
the inlining (and incidentally will always use the NS banked field
because our user-mode CPUs never set ARM_FEATURE_EL3); put the
definition of access_secure_reg() in hflags.c, near its only use
inside target/arm.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h        | 12 +++---------
 target/arm/tcg/hflags.c |  9 +++++++++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c360b74ded9..5ae40f32491 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2666,21 +2666,15 @@ static inline bool arm_el_is_aa64(CPUARMState *env, int el)
     return aa64;
 }
 
-/* Function for determining whether guest cp register reads and writes should
+/*
+ * Function for determining whether guest cp register reads and writes should
  * access the secure or non-secure bank of a cp register.  When EL3 is
  * operating in AArch32 state, the NS-bit determines whether the secure
  * instance of a cp register should be used. When EL3 is AArch64 (or if
  * it doesn't exist at all) then there is no register banking, and all
  * accesses are to the non-secure version.
  */
-static inline bool access_secure_reg(CPUARMState *env)
-{
-    bool ret = (arm_feature(env, ARM_FEATURE_EL3) &&
-                !arm_el_is_aa64(env, 3) &&
-                !(env->cp15.scr_el3 & SCR_NS));
-
-    return ret;
-}
+bool access_secure_reg(CPUARMState *env);
 
 uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
                                  uint32_t cur_el, bool secure);
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 9e6a1869f94..8d79b8b7ae1 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -63,6 +63,15 @@ static bool aprofile_require_alignment(CPUARMState *env, int el, uint64_t sctlr)
 #endif
 }
 
+bool access_secure_reg(CPUARMState *env)
+{
+    bool ret = (arm_feature(env, ARM_FEATURE_EL3) &&
+                !arm_el_is_aa64(env, 3) &&
+                !(env->cp15.scr_el3 & SCR_NS));
+
+    return ret;
+}
+
 static CPUARMTBFlags rebuild_hflags_common(CPUARMState *env, int fp_el,
                                            ARMMMUIdx mmu_idx,
                                            CPUARMTBFlags flags)
-- 
2.43.0


