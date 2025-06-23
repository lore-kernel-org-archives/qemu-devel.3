Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC883C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTg9c-0001nj-KQ; Mon, 23 Jun 2025 08:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg9R-0001Zt-MS
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:57 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg9K-0000ap-9M
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:52 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so3235203f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681184; x=1751285984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YG0rGkpeQcTfIwjCevzyaz+W/QtJY+1YJlHHFNrDtaE=;
 b=PujxoB1yYXuFkDNbAS01UCCuAdTHJgIjRx/zU7zQAqtDykGf9oO3ekLeEVfOdHFKeg
 ClNh78UCW3PhS3C8vWdupnFctW5SGMw4t/xJKQysLRWg33lL3IQ0qbVjwZ1Jlnh9+zca
 EU8kVny9efKRv3VZ6OkH6U+II/u0fhDRr8U7SfA77O0/pV4Go8bySFcuQ+YLnO9dUjvB
 mAvhRquv80UFqzGSXY3tHv/NBJH+CVAJlWQTCzrFtSnTWCrAZjP9RBHpKcbwMeKGUot4
 x7Hgkyc9EbgokMT09mVLzP1U8S+CBG/4RRsRAX6MRERDGp3DMUbOQWIgoj5mJi+1YcO1
 srGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681184; x=1751285984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YG0rGkpeQcTfIwjCevzyaz+W/QtJY+1YJlHHFNrDtaE=;
 b=eF7c7rBN/ZBk+E9iadteShShdHWxGylDFSKoYWRHVXr8zZGrC7OryhZoJ+5pMNDB9d
 QIsYcGx2sLa4CFa+Z4efW7zcYDDR3r6QP2p2d7coPwr/CcESc6NM38c5ZKaQc6M5iGS0
 MSbd2i+LuORSApcscxq1JNblXwHkA41fsf/QWhbQWU8kEHcoHXyFgBlUZRgGv5aDLmt/
 HaYgGinIf+JM/u/gzoWjDldVTkGnKIwL7OInwTwwjvJhX6bzvgmI+1+rnQhdM83eK8G0
 ImK7Dp/UFBs1EQZz6Ma4G5IDXXyaqEWrRpNZ1xpeh7sqY5EOsp6K/Egt1wVlavjyMUEm
 Wn9w==
X-Gm-Message-State: AOJu0Ywq3cgZ4d9Y1crnYDTP7/aFwlsvSnqR1zY9KzV07698hw6KcQt1
 zCt4w3D4CRATtwkySdSlSbRwVdDyqWNtVcvC42njw94NBFEU34s1J75WzDWL2CCIAE8MdYCUsv6
 1jX/t
X-Gm-Gg: ASbGncu1aEBAUJCYH6u5MwO2gfz+BULkzjhQ6CBznFBsI8aUenaO2Ud8VlV1qmCa4h4
 gYbfXVYYO0h4IkaByMJ+1nuXuRnyfjKKTsEG2qoH+XRZoAghlK2pjCoeHNQvl2/xzKSQWysDbWW
 kot27uAJJPkBXp6mTS3g7mn36U7VLFruzjrbkSiIyyiY8pU7svx+Ryu43JnR48M/eDM94+mFga6
 nOeYkqXvFEaqgd8HlUTz3k6aICF1rdlrUFkP357N7IdBphzqdAlueBqScXWSCh2JlZDEHwBGhcT
 EadNoZNsxxBXBejney4wtfx9Mm6jKNIGJy9sSFYmC/0Dcre1LLbKjgwAhH6q1MlhzBOnwJfKe2w
 nnAqpczMGP0/KcKXOdJwprj3a0X6bMh1yznFz
X-Google-Smtp-Source: AGHT+IHTcK8NRdR7PNArgyYQkG0nUCVoom+k7oQ1rJFLDhrBWTeykxYJUpFWrxkFgsUFr33IXybNlg==
X-Received: by 2002:a5d:64ce:0:b0:3a4:f513:7f03 with SMTP id
 ffacd0b85a97d-3a6d1303b0fmr9477486f8f.44.1750681183940; 
 Mon, 23 Jun 2025 05:19:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646d14f3sm108727095e9.13.2025.06.23.05.19.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:19:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 11/26] target/arm/hvf: Pass @target_el argument to
 hvf_raise_exception()
Date: Mon, 23 Jun 2025 14:18:30 +0200
Message-ID: <20250623121845.7214-12-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


