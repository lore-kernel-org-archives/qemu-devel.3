Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BDECCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 21:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJUy-0004yx-8P; Tue, 21 Oct 2025 17:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJUw-0004wJ-Ju
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:02:26 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJUu-0002yS-My
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:02:26 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so37917705e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 14:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761080543; x=1761685343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iIq3d7ugauwSFwb7NuuD2EvqM+PTyDDPePzmnW8HEF0=;
 b=qMbja7AA1UIgQzarIpzugfYAQDGSiI4hWL05qoO2MTsCt8Fvz3qfPg5K7/JkVNxIlV
 BKrJo8dz8RinJGmXTnoBNaoDNDkvfYFSIAPzpSbXFPEqg1Nu+zySaIKZn1cC+Whjc/8z
 dnj29mWAxCNajz6fV1c5pQQQjzIw0KV2CdTfaPkvWTJsdxNZVuznnk9gyXV1ByeBC1Zg
 8uImvei3BRenD1niD0UZa7HlHKsSspgwJqil9w5P7ED8OA0njyrFdRLF+nhuwt6sFZt9
 0GWLRCA+R0OkPYCEe9I5aROnfo/WayrN8b6IWzVJ4nThkmtLpxetvv5arvxekhhom9Se
 0uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761080543; x=1761685343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iIq3d7ugauwSFwb7NuuD2EvqM+PTyDDPePzmnW8HEF0=;
 b=XqPOsfPZmHFxMblHYf/W3uIQIHEhKbdlYThsuMQyMIAbrKIAjSfAD/nrHMlW2qJdaQ
 hrfHHEJjyxWSU8kao3RK7CwGc00IiBaJ70sWul+7DYBAYm3mUeyipsg7F7IH5l1W5eWJ
 4aqgJJgrLQ4ArKq+lLQyxFPTCVyGUe350NUDv9PwIsr/XzsHPv51qTgqjIcTlKkKCxVn
 208N/KfBzizv7NF09Utb1dpOTrEd4EYzkCTX9jX/RXMQrJLuDIdqH0vrcaYyXBM3D0GP
 olMxv1y10POoSo3QGGW/3Uot7kk48oJTVkvrEpHCCSO3YRGPZF4IuJMnDf1ig9ReVHzg
 Zb3g==
X-Gm-Message-State: AOJu0YxoeI0pwDuUe/ejlgJLiZL4tckF33nzE0AZ3XiMqR6rld7Y1eFp
 sVEDg22CviHZIqqVgMo52AI7OfaAUWyuntJjPAafp3eDFsBzVPOF9WbAs+wN8ye5GClC5SaC4Fl
 FkmBTIwc=
X-Gm-Gg: ASbGncvz8glD7apY3n0JrxSvjtoGDqEVqaxAZOhgxwdI7aoYBC/J/njJCb8rfB2HCS3
 ijC+12NwFugnWncLyzwoNuIQq4TRCuSsl9YG2BCIA+nrjMCJDqAzgBLjH0K1UqHu+ro+5I2JGQb
 IQUNsKlSjkOQzw6noySicUvkN0nTMK059pQw4kJARhBYGQWTABaupHabq8+0lTD9S53De2Cgsy5
 1nEAbe+SC02cIuDXBgQ3w1+CgR5i8xMoOeiDwl9+d8Q4b3CC/4amde4rLeAf9BzK/PvRNGpYvlK
 7iqfgFyhWA6kX/73Fp3PmkpBTOBTHD69wHD9wN0chicdiwrutjS98LATw5895JM53afvXlXyYwa
 pWAabGPbqt3L+IQJ2t2y/qpB0I8FG/tDOIO/JI5qNBIx1uDZLpMVS9eTtn530khQIVpW9xhQAOg
 EE9YlZ9npBLy73Z1KnpwTQpOBqWw8NAQvfY4Rlf6o7qNfAZ0PApbZAhOyhmtqv
X-Google-Smtp-Source: AGHT+IGlxLpKGiDvbY+/eOy2AoXYIjfu20hGzq1WIqAINBjbacA2LwPJq1Avda/RLOQ5NRdF8Xo7Zg==
X-Received: by 2002:a05:600c:34d0:b0:45f:2922:2aef with SMTP id
 5b1f17b1804b1-47117911751mr144849095e9.28.1761080542799; 
 Tue, 21 Oct 2025 14:02:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a0ec2sm21773307f8f.3.2025.10.21.14.02.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 14:02:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 12/19] hw/arm/virt: Replace TARGET_AARCH64 ->
 target_aarch64()
Date: Tue, 21 Oct 2025 23:01:36 +0200
Message-ID: <20251021210144.58108-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021205741.57109-1-philmd@linaro.org>
References: <20251021205741.57109-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Replace the target-specific TARGET_AARCH64 definition
by a call to the generic target_aarch64() helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/virt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d3809754460..dda8edb2745 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -32,6 +32,7 @@
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qemu/option.h"
+#include "qemu/target-info.h"
 #include "monitor/qdev.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
@@ -3263,7 +3264,8 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
     if (tcg_enabled()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a7")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a15")));
-#ifdef TARGET_AARCH64
+    }
+    if (tcg_enabled() && target_aarch64()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a35")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a55")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a72")));
@@ -3273,15 +3275,14 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n1")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-v1")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-n2")));
-#endif /* TARGET_AARCH64 */
     }
-#ifdef TARGET_AARCH64
+    if (target_aarch64()) {
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
         g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a57")));
         if (kvm_enabled() || hvf_enabled()) {
             g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("host")));
         }
-#endif /* TARGET_AARCH64 */
+    }
     g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("max")));
 
     return vct;
-- 
2.51.0


