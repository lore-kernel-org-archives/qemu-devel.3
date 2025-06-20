Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CA8C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbTk-00038Y-3E; Fri, 20 Jun 2025 09:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbTi-00037m-2X
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:08:22 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbTc-0004dY-PW
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:08:21 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-450cf214200so17544345e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424895; x=1751029695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZYVTt5RemOQGhErk/wxiT1GRcR8x45vVeqGw/eKctk=;
 b=NwF6LY1gkY0jTrfmu8pocegTrmHtCD0rHvvz7dh65JpW0BOgmBQE44lv5wvOZn5NMO
 pPb1cN1/x/G7j4GgCyVgvpuY7xZn1A3aG2+oRoAGU96rbJTa9VAm+Fr7YwYl//cdrmjR
 2Cx1eMzjaWP7nx+laOt1teHHXqCIwdKG1F6d4DYLwnc2UdPwBSof9k9Q+lYqgKQIhx0z
 TuD5ayVUvjfRgGRR6T0UVDYpK36pqNTZmpbdsGE4hT+R/p+V28H2URxRzz0VDUwaoYdB
 aJ0rfbr+AnLtGoVwL+z8+B0xrFpp3lV1FpVrMW/zeqqmht2ewodUukDpYWfq4oHkFLHT
 7tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424895; x=1751029695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZYVTt5RemOQGhErk/wxiT1GRcR8x45vVeqGw/eKctk=;
 b=lc5PzNdlbLUexF0iuSnC0ycHUQk10Vp5lIdf9WGZiLRck0Dbv46DxnK9DBxtAgPAC1
 YRZf9fB+7T3W0smpULLrbdZ1Hk6BxEh49Lwi6FwBUnV8yYVxZyuuZhp5ybVSh6o8kRTt
 ZjPjXHC4SfH2XvLwMW1uB5//JJq7kRRU3H+0BU2fTHQBFfek8Mll8ugEgO7rE5pERxGc
 dsQRsbA/9uIr7pfmzpFhLczuffUSOFfd/csuw+aSiEzjFgXlCIURFuQ0Z7c4XH4X0Pa7
 0MfflqhzI+0kaBXVHJKQ5Z3JsYtEaKiJnmt6IihtCI4nNt0lBE8Hd2676+GD0s+c/DYT
 X/UQ==
X-Gm-Message-State: AOJu0YwjxZeli3BeVQiYWtPiR/8djR0HEkA010TE7xyRY6JQ7w/XLUiE
 z9aAEMgFKlzvgreaA4NkQGBQJHlLh5pRTguvui/uPLq2c1xu232BVTVbF9DoW1nyQa4Df1BfGJ4
 pRnvOR14=
X-Gm-Gg: ASbGncsvPzyoOSVCm0MyMPAQq0K7BvsgJ7ceanr5OizPBZjgtHyma47gNsvdk2m708H
 bdnYqW8bQdj0FWTX/WIw0ibvu3Co1UysEFOAPdNy328PcvsDfFjE1qMicjgR66SMcxQRBvtEvHo
 fot1YrGYKH6DSRMqGPao6kV3H0RHpoQkUhUtM9xN+eutE+4cIKHxE3x+F69F+dVCtkByq6Edld1
 ww3EArRo9mjrUvgm/ZRpQ+7Gi0dshioHOHjVM5KF+3EXwrkG5zgwFCGuylbP9v2nSvVIhY4zDVc
 gsDGE/H21phR/gVuFzERHEvPscuTPaEqBhKNX4bpSFQPnmipQ4EsoeuhO8MYSCBNfsl3bq9eWgA
 HWF+6+Sdn0oJlvbEQgxUQ49ZMMWDDJxzelsYt4Bt2i6SjBgc=
X-Google-Smtp-Source: AGHT+IFVLdhGyOe5Gwiz0JlxZs0z4PUuLavXcnnSLq49twNgh52Q6RjdjYzWXSk1EhN5FYPARRZVKg==
X-Received: by 2002:a05:600c:1f94:b0:439:9424:1b70 with SMTP id
 5b1f17b1804b1-45365a05192mr27153005e9.30.1750424894423; 
 Fri, 20 Jun 2025 06:08:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d117c663sm2084326f8f.64.2025.06.20.06.08.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:08:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 11/26] target/arm/hvf: Pass @target_el argument to
 hvf_raise_exception()
Date: Fri, 20 Jun 2025 15:06:54 +0200
Message-ID: <20250620130709.31073-12-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

In preparation of raising exceptions at EL2, add the 'target_el'
argument to hvf_raise_exception().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5169bf6e23c..b932134a833 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1089,13 +1089,13 @@ void hvf_kick_vcpu_thread(CPUState *cpu)
 }
 
 static void hvf_raise_exception(CPUState *cpu, uint32_t excp,
-                                uint32_t syndrome)
+                                uint32_t syndrome, int target_el)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
 
     cpu->exception_index = excp;
-    env->exception.target_el = 1;
+    env->exception.target_el = target_el;
     env->exception.syndrome = syndrome;
 
     arm_cpu_do_interrupt(cpu);
@@ -1454,7 +1454,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
                                     SYSREG_CRN(reg),
                                     SYSREG_CRM(reg),
                                     SYSREG_OP2(reg));
-    hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
+    hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);
     return 1;
 }
 
@@ -1760,7 +1760,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
                                      SYSREG_CRN(reg),
                                      SYSREG_CRM(reg),
                                      SYSREG_OP2(reg));
-    hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
+    hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);
     return 1;
 }
 
@@ -1963,7 +1963,7 @@ int hvf_vcpu_exec(CPUState *cpu)
         if (!hvf_find_sw_breakpoint(cpu, env->pc)) {
             /* Re-inject into the guest */
             ret = 0;
-            hvf_raise_exception(cpu, EXCP_BKPT, syn_aa64_bkpt(0));
+            hvf_raise_exception(cpu, EXCP_BKPT, syn_aa64_bkpt(0), 1);
         }
         break;
     }
@@ -2074,7 +2074,7 @@ int hvf_vcpu_exec(CPUState *cpu)
             }
         } else {
             trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
-            hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
+            hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);
         }
         break;
     case EC_AA64_SMC:
@@ -2089,7 +2089,7 @@ int hvf_vcpu_exec(CPUState *cpu)
             }
         } else {
             trace_hvf_unknown_smc(env->xregs[0]);
-            hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
+            hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);
         }
         break;
     default:
-- 
2.49.0


