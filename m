Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A90DF47CD6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 20:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFje-0003c3-8W; Thu, 05 Mar 2026 15:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFjM-0003QN-A0
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:55:37 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFjI-0006gW-2u
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:55:34 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82418b0178cso4797609b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 12:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772744130; x=1773348930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76kT1LLbzqR90+aCRQBHop//yXjVEoX7825LzBvy7WA=;
 b=fC6KhEKTz9sYqX7Qzgnt7bqUzvZTGsy4XkVZ2AzLfMHeKs5di8QoelfUN0AB82NoSA
 +J6gb5ryUfqmeVUMjUjSQzOg44semA9ku3iCFfRwacvmA0E5SBbN3Q5heW/s+BRYAhSJ
 t487BrFButH5Yfe3j7ID2A5Kf8uJpH/f0FCLWX8BGELH0Q6Ro8JB3ubpU9EnjlsnV6Ri
 cg//WfUDqAkN7ZKgwN/x2t7889bmZrHr49IPfECVVgO7cM0NomC85coRfBd7kr+hsMK1
 iAcA7QJQ+hBtfZNg0CdwmzoPMGTF/nZOfHfYmBGJurfibmBgaYu8WWS4oR/+rCEhPac0
 veaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772744130; x=1773348930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=76kT1LLbzqR90+aCRQBHop//yXjVEoX7825LzBvy7WA=;
 b=KX9e8FuIdAjKLhRnaxsFNPcJs0KoW/soHDdxj72gbBzGcK0o+zlhbf+TpahpMUJtJV
 UmZOwlpGMrvSEURj++sg+unc5r2uS8H4Z7ThUO65RXjOIJQxnec1OsS5EIWSm9Y4b6vz
 rSYzwPgnhzjB20V8WFDuW49fyuftZOX4keODif0bSa4WnHA9+IjKjVCRHcg8FGwg5d3f
 eP0J4egR2gndPTIJEgSgZVz7QpqWjbOG3hWmJoXRYsrlKRzp6hUrD4kbU1ey8E+kYfeH
 bpjHxwhsPEEmCwwPyK9mx93PnuYCZIpYgljW1FUlMvM9C18VQx1a2qJcbv6lC+XvO2Fm
 EKww==
X-Gm-Message-State: AOJu0YxUzWIlhNeCBumjxvw0l5uY77ZfYA0tWXAQeqU3YOPv+I9XC7/0
 nGT1N4VAh4YhrBlyNIJ4ywoEPOIemb0dm6+OhE9KINOcId6zYsCcpL7a95GGgKQJ4T2GitHwRH5
 Y0WCT
X-Gm-Gg: ATEYQzwkis0ese0Gj8kM/fR1fqcxzylN3omLzxLOo41UsPXYg5bF+AbL5YKIVUWnPiN
 JJCUiZHxDnUVOTXP0MzyAJYWArfF5pdNfEnqTCTP11d9uBq5WkeCfgJB7hP+VwMHbowg2wLilHw
 dHj1XLO8Wok82RLdQBDFM4/j7sV8NJB0w0AFb5b36eCF8jzuw0W//RsnV9xdcBugLd1XSqVn8Py
 Vwv/xqN9tmSwc7kTL1NJqFh4I6nJ0xjvTwnNrtt5Rel4xMkcsVLDFmSPi4PL0V/XBqJInQwkgxZ
 UJTn7e5BXEzLsAtftbWGi/Zz05VNt/vLHVir9VyVbja/tbGbRFOTv0IVRWjspWW3AezNNR6qGqX
 HSFxQTXijtTBM5Djug9MUSLUqwva7UCkMV095kOZNZZMHDItoY+bPtS/05POHNauGwucM6jrE+1
 UeSYXVS+QyWxLDseSZcdK+goTmexPlmel4CzuS8odNc1gdeMZv/5Tsy0Ml7FOV9ickCGS6cKLAf
 T+M
X-Received: by 2002:a05:6a00:a01:b0:81f:50b1:51f2 with SMTP id
 d2e1a72fcca58-8299aba1f90mr927518b3a.41.1772744130182; 
 Thu, 05 Mar 2026 12:55:30 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8297e4fbbd4sm3847454b3a.53.2026.03.05.12.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 12:55:29 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 4/6] hw/virtio/vhost-user: make compilation unit common
Date: Thu,  5 Mar 2026 12:55:18 -0800
Message-ID: <20260305205520.2125218-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305205520.2125218-1-pierrick.bouvier@linaro.org>
References: <20260305205520.2125218-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

PPC architectures use a custom value for VHOST_USER_MAX_RAM_SLOTS (32
instead of 512).

vhost_user struct and several functions use VHOST_USER_MAX_RAM_SLOTS to
define stack allocated buffers. To avoid changing all functions to use
heap allocated buffers, we keep this max, and simply add a
target_base_ppc() conditional for the single place where size really
matters.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260225041948.52929-5-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/virtio/vhost-user.c | 11 ++++-------
 hw/virtio/meson.build  |  3 +--
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index bb8f8eab77e..a8907cca74e 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -44,13 +44,8 @@
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
 #define VHOST_USER_BACKEND_MAX_FDS     8
 
-#if defined(TARGET_PPC) || defined(TARGET_PPC64)
-#include "hw/ppc/spapr.h"
-#define VHOST_USER_MAX_RAM_SLOTS SPAPR_MAX_RAM_SLOTS
-
-#else
+#include "hw/ppc/spapr_common.h"
 #define VHOST_USER_MAX_RAM_SLOTS 512
-#endif
 
 /*
  * Maximum size of virtio device config space
@@ -2287,7 +2282,9 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
                 return -EINVAL;
             }
 
-            u->user->memory_slots = MIN(ram_slots, VHOST_USER_MAX_RAM_SLOTS);
+            const uint64_t vhost_user_max_ram_slots = target_base_ppc() ?
+                SPAPR_MAX_RAM_SLOTS : VHOST_USER_MAX_RAM_SLOTS;
+            u->user->memory_slots = MIN(ram_slots, vhost_user_max_ram_slots);
         }
     }
 
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 6675b63ce65..ae33d403cf7 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -17,8 +17,7 @@ if have_vhost
   system_virtio_ss.add(files('vhost.c'))
   system_virtio_ss.add(files('vhost-backend.c', 'vhost-iova-tree.c'))
   if have_vhost_user
-    # fixme - this really should be generic
-    specific_virtio_ss.add(files('vhost-user.c'))
+    system_virtio_ss.add(files('vhost-user.c'))
     system_virtio_ss.add(files('vhost-user-base.c'))
 
     # MMIO Stubs
-- 
2.47.3


