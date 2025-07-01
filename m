Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848EDC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcDS-00035w-JP; Tue, 01 Jul 2025 10:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcDO-00034E-Qf
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:06 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcDM-00077w-Nf
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:44:06 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-453608ed113so34696165e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381041; x=1751985841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mASTgkLVaSCN2uwTTMG88n2cx+5cADn+bdq+fXVtXuo=;
 b=gHsHMbh97wI8mzzAM8uXfmTCX0TBD3irPisEt4kUVuYQXooyeSCazD7xKhJ4NwYjeH
 QphyuX0emMhydOD4iYPpHlqP33hDVtUnONlKWRajZFCvy7W4tYlO/q0+Wdjnn6T6fYA6
 8zyxufyZOIKTTx+UA2eqq+Nn7WSRPRTTjqS5Pv22OFjbmo6t+HAoHXOVhLAe1OLnvOo/
 XjUlh7t+CIDYvYmdwxJ95dsGtHPkNPeBpS7DK3SkY1w8JDXh1Z2Q0ImjfCeq5QpWIuZO
 qCM4+V0ZScZFzOODZU6jAPQNTkEFLf3eoc/jq626FUS9HM25cv92vFkPmjnUdv9kxXGZ
 3muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381041; x=1751985841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mASTgkLVaSCN2uwTTMG88n2cx+5cADn+bdq+fXVtXuo=;
 b=uLucVHCPtXtgr4kVTXWCrztnIeMO+pNP4REPAR5/ApAc+IUVWMQe7TukGtM4wHbvdr
 iN7MWT1D0T+velRlW5m1062XIfMkjY5mTWFnexCUZIvOvsQgrRYJGo93I9nxtPwxUMlk
 L+UNrBpETjsf7pX3lQDr46Kdd8515FmbDUJ5TmuWhbTHjHJBTeK2ozAGD0uehlNYqh5S
 AWGyKvBQGbVqovtWLY5/ZG/GE38Ikn/cODUkxMMPxcrLJSX/8m6R7iYbNnfN0kpOIb7x
 MI2xDyzaR9HH5PKsB5RAQr6BiR/e9fnybwH0hnUatLtsY6xlEAjj17EP1TGQoF/oeOyb
 quuA==
X-Gm-Message-State: AOJu0YxlhIqTRie6q/gxwyBBoSX4UFBmqGGH3Znvg0gxrbslPV+VDUOi
 J3TNEz0oEc3VZyKQ87vic17bZXokZQ9Bdb+EkrheGhpzx9dASApRBrOcKDjmTk0XjnvDgJ4TWcg
 xKpig
X-Gm-Gg: ASbGncu0X6vZbPHTPVIwnhDKJNqQpGGoeihVll51cmZ3P7IF3/wneiAMgvAH+ZKYANv
 hK7DBub+J8OY5/87ozEDIzoahz8IuqeEyI/fAz5EF/bjPRCXMVlGajrGNbMi7sUXS4hgduBxQ+F
 gS0Ruk21xF9iaI2jcCY+lTyFa5/Bv2/ZDkEIiVBsCavBLrTlKkiDepj87zq1agssDiiSuMeAP2M
 iNKNToaXA07s7XkBgWGPka0gj5UWQ7lRWlb2Gz38ISfQbVGJ5HsGCIzzr73mLDz/fgP4KD27ft+
 2tRIX7XO0br42T991BpLdRV3HxLR5YYgmrl8a2LrSEFhPt8J2EDMFlg6mRNfbtbtC1dG8p7AVl4
 DDgkATcu0LbMNVhWhh6DUA8r3uhl/jwJuucmji/gIjOaonsA=
X-Google-Smtp-Source: AGHT+IE6OGrvvhsGpN9+DkyWq61xbCbSq/o2NA6HVmCsbpjFVqj7ptKMtvl6ueumMSFr1t2Cj5+gFQ==
X-Received: by 2002:a05:600c:1c94:b0:43d:1b74:e89a with SMTP id
 5b1f17b1804b1-453a9171809mr37223495e9.9.1751381040885; 
 Tue, 01 Jul 2025 07:44:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fa5easm13196496f8f.26.2025.07.01.07.43.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:44:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 42/68] target/arm: Use generic hwaccel_enabled() to check
 'host' cpu type
Date: Tue,  1 Jul 2025 16:39:50 +0200
Message-ID: <20250701144017.43487-43-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

We should be able to use the 'host' CPU with any hardware accelerator.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/arm-qmp-cmds.c | 5 +++--
 target/arm/cpu.c          | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index cefd2352638..ee5eb1bac9f 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -30,6 +30,7 @@
 #include "qapi/qapi-commands-misc-arm.h"
 #include "qobject/qdict.h"
 #include "qom/qom-qobject.h"
+#include "system/hw_accel.h"
 #include "cpu.h"
 
 static GICCapability *gic_cap_new(int version)
@@ -116,8 +117,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
         return NULL;
     }
 
-    if (!kvm_enabled() && !strcmp(model->name, "host")) {
-        error_setg(errp, "The CPU type '%s' requires KVM", model->name);
+    if (!hwaccel_enabled() && !strcmp(model->name, "host")) {
+        error_setg(errp, "The CPU type 'host' requires hardware accelerator");
         return NULL;
     }
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e025e241eda..f3bde82b3a6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1976,8 +1976,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * this is the first point where we can report it.
      */
     if (cpu->host_cpu_probe_failed) {
-        if (!kvm_enabled() && !hvf_enabled()) {
-            error_setg(errp, "The 'host' CPU type can only be used with KVM or HVF");
+        if (!hwaccel_enabled()) {
+            error_setg(errp, "The 'host' CPU type can only be used with "
+                             "hardware accelator such KVM/HVF");
         } else {
             error_setg(errp, "Failed to retrieve host CPU features");
         }
-- 
2.49.0


