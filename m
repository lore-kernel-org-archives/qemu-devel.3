Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C520FF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH2U-0004bH-V8; Mon, 27 Apr 2026 04:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH2R-00047G-8S
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:09:55 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH2O-0002BL-PC
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:09:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so130183795e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277391; x=1777882191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e+EDDgWhJI3ORltCGjgBjB3nc854c+rlyGvs0etBPgA=;
 b=Es8YNFZNny+dY5dEvhgmsb4sr8EMpY8g9DqoNHYlJDeCkgK7szn9jk/jqpRIsdC7uY
 AypSBjhi+uI1dOaVcbzODkJ7K1jKOqb6+va+yfGlkDhxANrsUKcMp+z/PNkbFIRjx9nf
 bxFc27TBADtwisn+A0UKfoLze/a7hRjpmaOFOEPNONptEYbGvvR4vhSHD4HbFfSgKalm
 hmPsddMOKyMmVjgGTkYvr4MQ5K1zgn6U2ADDVVm+u7JVhy4rrkUsVVCGtz6TM6LTJDsx
 UHXvCjB/TdDCDBbbEsQd2QlULL8mTmzsyd9b4ZU3pAP2HQJuB6DfguQCc1ER9dYLMq3x
 AgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277391; x=1777882191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e+EDDgWhJI3ORltCGjgBjB3nc854c+rlyGvs0etBPgA=;
 b=ibuIN7BVZSccsLAHgxIodfVY0BRc9KIErEx+TkazRXatJgt9y7/veV/GWPqE83vY0s
 T+G0CWcl3nxMHGdaB0w1o5RUjgjTt1KCH8asJHj5rciAiUHHbp2nRstYm+cgb2BOMTPh
 O2Lwd7OpFAMXnXD+RoesS6ND0jO7u4NQO7kzZfWpMiT7rHAPiC1NBT7H+u6E8WKTJc7E
 rilXa/5fB8KnK4vAtghddUTp1RO/JZISMuR6v5tEh2RZVfIcmRhaeYIERNcrIKLaoUGr
 eKyxOYz8mMN0WOYkgseLbYsf5Z78KlhTnOs0r96VCq7YUrDslr7F7nao2u8xAGDzZT7k
 autQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8eEevAXLBeJpYEbKzoold59AUG0cEREV3njwrU/8C2w/tYBv7XFcfbJqadNrW9wwSozsKRpV1rEIYC@nongnu.org
X-Gm-Message-State: AOJu0YwibuKZ9nXsOo9GN4CgTauk6CvOATPU3aFY9zW/jzBsRiJkzRdf
 j7WCDYn+lDLXOOlaibyjyOxRQtzt6HMlQkqaBU3AOTZuTRCVULWwuni3VJbza11JgaIJfqib3gX
 Uowjn0Oo=
X-Gm-Gg: AeBDietNcChuJH0Fgqc8kyHHCsOyLYouHGpvkVCBo5rGg5FqpbEEJYbyN/fv6UT9dmp
 DpRg46AAOqyXlZqvB9sXe1dkdL39XKtyVR7qSi6RBj3CGD8HjIZAMx/tKtyIYSDMIHD6yS+Vk+K
 8fw2mbvwj9o/zZCLB5mkeE5R9bBDEWka7x/a14RVu9zzf/jRmbORKdGsIs2l9g6qcKWykMYcHRr
 dGm1Ocujkh/F61njRWuHWMPs8YicYvT/kj01oonUzolvmbL+SGbR/AR/Qs34xofJaOLszz821UN
 POgF997SZXE7ZIQS2+y5UQhXcc5cWUVp27IpTSGfSHdQoTvhcvqT6laSk4XNm7m+yFIW4lYeVAh
 1A7PHS0V6ievUhe1Ue1uwBAS3dUJLVwteoZHzxi8mkMbgdsfMJ8Kr675ZPHEqaAkc3igXbLpCZM
 AKIU8vtiPxfBxcUaX4xzlmkkbtwJSE60C1SEm8WXnB2EIDhAhDVOoliitRS686R1XRrIavq+88k
 PwRf5nQf7A=
X-Received: by 2002:a05:600c:8483:b0:488:7ff6:1f75 with SMTP id
 5b1f17b1804b1-488fb782d91mr633195655e9.21.1777277391201; 
 Mon, 27 Apr 2026 01:09:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e591cesm106514862f8f.36.2026.04.27.01.09.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:09:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 19/32] cpus: Introduce SysemuCPUOps::monitor_get_register()
 hook
Date: Mon, 27 Apr 2026 10:07:25 +0200
Message-ID: <20260427080738.77138-20-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Allow targets to register their legacy target_get_monitor_def()
in SysemuCPUOps; check it first in get_monitor_def() otherwise
fall back to previous per-target helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/sysemu-cpu-ops.h |  8 ++++++++
 monitor/hmp-target.c             | 11 ++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 7b2d2d2610f..5b831393cf4 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -85,6 +85,14 @@ typedef struct SysemuCPUOps {
      */
     bool (*internal_is_big_endian)(CPUState *cpu);
 
+    /**
+     * @monitor_get_register: Callback to fill @pval with register @name value.
+     *                        This field is legacy, use @gdb_core_xml_file
+     *                        to dump registers instead.
+     * Returns: 0 on success or negative errno on failure.
+     */
+    int (*monitor_get_register)(CPUState *cs, const char *name, int64_t *pval);
+
     /**
      * @legacy_vmsd: Legacy state for migration.
      *               Do not use in new targets, use #DeviceClass::vmsd instead.
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index a222fd4c96a..46ccbd14aec 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -35,6 +35,7 @@
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-machine.h"
+#include "hw/core/sysemu-cpu-ops.h"
 
 /* Make devices configuration available for use in hmp-commands*.hx templates */
 #include CONFIG_DEVICES
@@ -85,9 +86,13 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
         }
     }
 
-    ret = target_get_monitor_def(cs, name, &tmp);
-    if (!ret) {
-        *pval = (target_long) tmp;
+    if (cs->cc->sysemu_ops->monitor_get_register) {
+        ret = cs->cc->sysemu_ops->monitor_get_register(cs, name, pval);
+    } else {
+        ret = target_get_monitor_def(cs, name, &tmp);
+        if (!ret) {
+            *pval = (target_long) tmp;
+        }
     }
 
     return ret;
-- 
2.53.0


