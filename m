Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F558C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJYI-0006X4-7K; Tue, 06 May 2025 10:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJV0-0001Rs-Ue
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJUy-00024y-ON
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:22 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-441d1ed82faso5311655e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542539; x=1747147339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PaHqhFsD9PqNlrmLgTeqd/y23SukxVysfdMiiupcidk=;
 b=aUp/X89GLq/ekMhCovbC12ibpezIPDWrbydXCe3UZmQNhQxtIE76DxQXDufLpDpk/F
 +PvX8VOjIvC6Yh2kzSZSbgQIKvRXOEq6VTCEw0mx9R8eQg+ssX3N/xlQsq2XvFSU+tAs
 Cum6ECqugocWx9r97KM05kS7U5MThY3zLC3YlJvnuumikC06AjEFxspeIrXGK5tgM9T5
 5UOGz4Io1qH9UqiwYvGAr7p5T/2TS+nRqcaaMBKKn8wEG3dlBRXtn2sreE2Qc6MeGpqC
 9sluk6cTfLOGIQSJA5Glm7BvR3whO8NU2o1z3HAq1U1LRKLRNnj58Xt+O+k75C/NZ4wp
 GTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542539; x=1747147339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PaHqhFsD9PqNlrmLgTeqd/y23SukxVysfdMiiupcidk=;
 b=j8K9TGArMgfbON7ouJoJp/KmFk7FnOzvfJR0+K2o3K8EiZQ47tx8eskYrlFMx5o6CJ
 kC4XS/5gcwUh/NN61MjhsVrFBXHL9bh0HGQM1Zo6MRHM+KWwede88PfZeOSl5Nyd7wQK
 0LgyK7E8geZ2hYAiRJkUA5fVshpLXfBNrfZpsMOaXMJJFDqAZtXu+tb/Qsh4ZRkkFb1N
 dYIXXV+crce66+bIbr7huLRoxbfmxO4L9/f1O/7P2N0aWe1op27DCtuakqjuaPzLt2ju
 2ieggClRp8pluWTsBMRFGI4jNZTZ7/cgNrJeaGn6O4/WNCNGOyIafiHm9/6mWmq9kXNE
 dzBw==
X-Gm-Message-State: AOJu0Yx71cjRe8arVjFVlu3rbDfniimiG2NkgEw7dsXz5bhj92qIne26
 VrVbthg6lQ46dp+74mW5emhyKurbX94SfBcQgy2KEUic/+xBFPyz6cVq7M6f+Vmh09TzFKhGorA
 p
X-Gm-Gg: ASbGnctDvWZ+tRiJIjGkVffNDaIDSSTkxdQBBWKU1mX6szBtXWwCYf18SIvA+aR6IEq
 xqZB5oCR0gPYJU36WTDto0TI0uGEWpiAPIB/PFLr+IvLeW12SgYZW/giC8Vvb47sKwAJK5ijrWw
 9X2dg7lZl9MnU9yTTZNYKK2sfhLdUMPDOHRU3C1bSMny+Oyp98KHJ2pEWza/Gbqy1KEoZmM+k2r
 mlsdzjDoFzj/Jp0liL+Ja3VMoQUbo0k2bkYQOgZkZugJOQnP7lHWWk/Dx7GwiYLC/6UaTs4ReNy
 XIjAxXMRCR3Hu5CYZvsbMiuHtFxTwF9iE6RdDB1yQCk6Iyo=
X-Google-Smtp-Source: AGHT+IHK7rAlwmZxuFY2Rb9yWGjH/DQxnWv58DRW/1Fh4Xe0JCPkIlQHl9VUgadIvA5a+9FKfvnIuw==
X-Received: by 2002:a05:600c:5117:b0:43d:fa5d:9315 with SMTP id
 5b1f17b1804b1-441c4947339mr87878735e9.33.1746542538761; 
 Tue, 06 May 2025 07:42:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/32] hvf: avoid repeatedly setting trap debug for each cpu
Date: Tue,  6 May 2025 15:41:44 +0100
Message-ID: <20250506144214.1221450-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Mads Ynddal <m.ynddal@samsung.com>

hvf_arch_set_traps is already called from a context of a specific
CPUState, so we don't need to do a nested CPU_FOREACH.

It also results in an error from hv_vcpu_set_sys_reg, as it may only be
called from the thread owning the vCPU.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2895
Tested-by: Daniel Gomez <da.gomez@samsung.com>
Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
Reported-by: Daniel Gomez <da.gomez@samsung.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20250402135229.28143-2-mads@ynddal.dk
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 34ca36fab55..42258cc2d88 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2278,28 +2278,23 @@ static inline bool hvf_arm_hw_debug_active(CPUState *cpu)
     return ((cur_hw_wps > 0) || (cur_hw_bps > 0));
 }
 
-static void hvf_arch_set_traps(void)
+static void hvf_arch_set_traps(CPUState *cpu)
 {
-    CPUState *cpu;
     bool should_enable_traps = false;
     hv_return_t r = HV_SUCCESS;
 
     /* Check whether guest debugging is enabled for at least one vCPU; if it
      * is, enable exiting the guest on all vCPUs */
-    CPU_FOREACH(cpu) {
-        should_enable_traps |= cpu->accel->guest_debug_enabled;
-    }
-    CPU_FOREACH(cpu) {
-        /* Set whether debug exceptions exit the guest */
-        r = hv_vcpu_set_trap_debug_exceptions(cpu->accel->fd,
-                                              should_enable_traps);
-        assert_hvf_ok(r);
+    should_enable_traps |= cpu->accel->guest_debug_enabled;
+    /* Set whether debug exceptions exit the guest */
+    r = hv_vcpu_set_trap_debug_exceptions(cpu->accel->fd,
+                                            should_enable_traps);
+    assert_hvf_ok(r);
 
-        /* Set whether accesses to debug registers exit the guest */
-        r = hv_vcpu_set_trap_debug_reg_accesses(cpu->accel->fd,
-                                                should_enable_traps);
-        assert_hvf_ok(r);
-    }
+    /* Set whether accesses to debug registers exit the guest */
+    r = hv_vcpu_set_trap_debug_reg_accesses(cpu->accel->fd,
+                                            should_enable_traps);
+    assert_hvf_ok(r);
 }
 
 void hvf_arch_update_guest_debug(CPUState *cpu)
@@ -2340,7 +2335,7 @@ void hvf_arch_update_guest_debug(CPUState *cpu)
             deposit64(env->cp15.mdscr_el1, MDSCR_EL1_MDE_SHIFT, 1, 0);
     }
 
-    hvf_arch_set_traps();
+    hvf_arch_set_traps(cpu);
 }
 
 bool hvf_arch_supports_guest_debug(void)
-- 
2.43.0


