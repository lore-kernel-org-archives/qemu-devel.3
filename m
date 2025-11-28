Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D2FCFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 12:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOxoE-0002EK-LE; Fri, 28 Nov 2025 07:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vOxo3-00026N-IQ
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:42:35 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vOxo1-00038Z-5L
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 07:42:35 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-55b2f2ae1cbso1223242e0c.1
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 04:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764333751; x=1764938551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8EnHLBHH/9x6RQh+DJhX2515VrjyRTLJawVS+ytU3po=;
 b=bhhLVW3lAzqtoLuPNy1OM+dJyGy6Saz3hC38fRL2FAfxZ8sGX6hXdSjqrlrN6mwkJd
 cPebKEVDL7fnboCp6GdzD+cWmYM9SSxH1s2PJxVI9rAFPgklbOTqLOmUW/eP9aqh5Rzf
 W0DmLOVLuKlL0HrO0y+t84lXEkbygAhyQSQSzVMfMs8y/4w0CM6507mYDIyyCPo1Zk9E
 OMrGZqOA/XKm6uJ9V20gKbGzMF/XJWp5SIlmg+WFOgCGuZMVyMz1Tc5V4/HxsiLBKD90
 yQHK1B+n0SLIwGoyNMcBlzB210DQ3ngZ7vzbjMJ9IBAZS5BTKtP7oRo3YZqSrNRao5fn
 1apQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764333751; x=1764938551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8EnHLBHH/9x6RQh+DJhX2515VrjyRTLJawVS+ytU3po=;
 b=BNmB/uiQlX3WnEQDDH9rTL692546D4GQrjK0OBjMguZukXSDDuJjp5r35RasMd/cF3
 qv3Mj1darWzBhwGZpOzFd1U93GUTwJkFTsxWumvgQ4zGK7bbg5vQMcXZlj8XbtEAqkA3
 Op25xvb/UXAjgUmg8WBJX9yno+Qjtp3tZOH9wh+lJNvK/CKyVW6Vc/rIqHDqZ7Q3P+qF
 4oY8y+anp/35k+YGTvWRGqG0VYK6XCWGX8UB0qzlLchDSZCvrv18FwWZeX2Km7SS4w9c
 oaJVzC5XdgKDLfxAioQwG6xu0bJbfdcDTgenU+lTmBQlyum6242SL4BXmeCluIz4lPUx
 X6Rg==
X-Gm-Message-State: AOJu0YzKSsZh1LigtseHXCHPMuP3VPTx8GbA8Xv63QnCYG+VKcOyJPSD
 T0y8UacVSV3qFQJAR3O4dU6wgAYxGKezvmoKsSbggsyZhOxW9LHhJw7oAmwYY+4mNT3TOGFbPoE
 JlphB
X-Gm-Gg: ASbGncsnfbAogfqaP93wv2S8LuqPj1bQXzc5gGtimAWkna8BkrzIbe+aQ98xXeKHuGo
 uA06OQfyJ2QV4VZ4WMgxn+T53o5H0xU5XWNxsUhFrjuQeoXFaStDJhe4PosYM5nBxf9TbFLb+LD
 XK9yNjIcQEvkbZBOg28LdRt4JvCjtGpFOOawL+BW5vsnpDbBwcMl4/3InpihBO6zsqzSRbC0Wpw
 dQ5DvAq0ZnARO8qnPxOZ7zbcjJb/1JsXOH5n9IAxXGA5XCISQ/GVdVw/iHEoiwjorxt1ATNo7l2
 VYCfoo1UyclkEa573nrfTqNoz9ImN5qqtg6BuaYg6Qd2jOkheoNG42HAs+qtIQeSORDradmD34j
 02mY+NxSmFkQeiAsbVjTJsdpjs+IWIno8lrVYTSlLNac1bhptEZklZB4Pn03RrxyGKyouGeBGJh
 r+1O3hC3mACduIgR4=
X-Google-Smtp-Source: AGHT+IE1XwJbhnwRfpKp/QmFEs/Vyr3ToUaWkjZtCzNVh3Ue+/R4Dd09aT4bwBukw92fekOy+d98rQ==
X-Received: by 2002:a05:6122:2224:b0:559:7acd:1d3a with SMTP id
 71dfb90a1353d-55cd755d6c6mr4455044e0c.2.1764333751255; 
 Fri, 28 Nov 2025 04:42:31 -0800 (PST)
Received: from gromero0.. ([177.139.2.175]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-55cf4e1d56asm1776930e0c.4.2025.11.28.04.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 04:42:30 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v1 4/6] target/arm: Use new CPU address space API
Date: Fri, 28 Nov 2025 12:41:08 +0000
Message-Id: <20251128124110.1272336-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251128124110.1272336-1-gustavo.romero@linaro.org>
References: <20251128124110.1272336-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa2a.google.com
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

Use new cpu_addess_space_init() to initialize the ASes for CPU, instead
of setting cpu->num_ases directly and use cpu_address_space_add() to
add the required ASes dynamically.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/cpu.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1640b20b4d..c7151a2c1e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2148,31 +2148,23 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     unsigned int smp_cpus = ms->smp.cpus;
     bool has_secure = cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY);
 
-    /*
-     * We must set cs->num_ases to the final value before
-     * the first call to cpu_address_space_init.
-     */
-    if (cpu->tag_memory != NULL) {
-        cs->num_ases = 3 + has_secure;
-    } else {
-        cs->num_ases = 1 + has_secure;
-    }
+    cpu_address_space_init(cs, ARMASIdx_MAX);
 
-    cpu_address_space_init(cs, ARMASIdx_NS, "cpu-memory", cs->memory);
+    cpu_address_space_add(cs, ARMASIdx_NS, "cpu-memory", cs->memory);
 
     if (has_secure) {
         if (!cpu->secure_memory) {
             cpu->secure_memory = cs->memory;
         }
-        cpu_address_space_init(cs, ARMASIdx_S, "cpu-secure-memory",
+        cpu_address_space_add(cs, ARMASIdx_S, "cpu-secure-memory",
                                cpu->secure_memory);
     }
 
     if (cpu->tag_memory != NULL) {
-        cpu_address_space_init(cs, ARMASIdx_TagNS, "cpu-tag-memory",
+        cpu_address_space_add(cs, ARMASIdx_TagNS, "cpu-tag-memory",
                                cpu->tag_memory);
         if (has_secure) {
-            cpu_address_space_init(cs, ARMASIdx_TagS, "cpu-tag-memory",
+            cpu_address_space_add(cs, ARMASIdx_TagS, "cpu-tag-memory",
                                    cpu->secure_tag_memory);
         }
     }
-- 
2.34.1


