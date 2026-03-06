Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D769FCB605
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWeo-00042E-U2; Fri, 06 Mar 2026 10:00:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWen-0003zs-6o
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:01 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWel-0002PN-Lp
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:00 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439afc58ac7so6374878f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 06:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809198; x=1773413998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1gtuIMarbcGPXHXbhN62xYNjrLlfncGqcgn1fgiOBeA=;
 b=aL7DNDK9SXTSc+IsAU2p50+rlSHARsV5uyB08IqiOAtFRLhn9/cooT1oHL2UVge0tW
 Dh5Uwk9cf95qeYxLNQagACVzFaFXuSEXd8ds3mQn57L+Qfl9YRieRrS0FWsypEHKq3L1
 aTHEI1RNiLyqP5Ib6tTibRct3rVqcHXKfYYjS1JZl3DpryfROK3rA0olMRA+4F+R2Ehg
 AdrDSX1dlNDYrwdRlzAAIa/aabKbkhobXA5iJWqCATgMew5IN81m/D+gjLqgfDgGOQ1v
 JrwDjZK/gQ9Ra7CN0bqnS5ip9KSZMY+t9G6HqYJ+lIOKeKbJpIp87SYdpUR5wb0wBbSb
 Nc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809198; x=1773413998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1gtuIMarbcGPXHXbhN62xYNjrLlfncGqcgn1fgiOBeA=;
 b=smSujrzkseoikdQSa/DY44uo4wMW2Pis1qG2WJbqtCUpme5KhzNR4vvfIuvXxND8em
 UZpMo9x26+WYbyj0BJXu2azInOMqWgIIUXy3u6xIc6EhXrk82jOE80dFo3NunxmNs03n
 CwNlD16H++Rcjl6kRZmxZlJ04DekH5/Pbnbo3/QM8orTu2yJ/UiJDU9lr7qHXlXVlw8K
 a+sLVyJCUXWBiF+kknAgkzvGxm/rHf5G53vNtL9OrW5CV098F9Zb4YD7ZexT3q51ZYZ0
 +wEacoAz+l1Xa+z9CNVOmuqOyXZg0HgYRc0vA2WTww8lsqCcxsWhjwszbmA89b8W0tqj
 9tew==
X-Gm-Message-State: AOJu0Yws/19iGy3a0ZrUOtg2SYht9CdZCTazXmCafSMQILR8+b89rjbD
 gu1P+5SJkEfLqqGhafwhjllmSzWgBFr0q8Gjj8eJSMvw/GTnsAVPxHjqMeupslvIz2OOsiRQ2+P
 mSXuY
X-Gm-Gg: ATEYQzz0skhLM2XdU4FMhVP70ISVAI4DjgWUNeYxYnREiLk0EhFX8+QVyzr/IExlusC
 aSKJpF0Y/E4/q08LWXQmgR4b3M+WmbvBNc7zn+udDWqfu8nVvrfCnMctISDwg7DRcg1ovHDKwkU
 oyKc4FvvMj2+u33B7za1n/DHYBpFN3nTa0SGGevEk7A2Nj6E0Eg4FjrTKLO1wOZsOHtrO0Y9lVJ
 17vKAgnEcYADU0lJGOkqVIZ1VCrojwvFllnErWbHhsfBxAQJEBr3J5JdKxec6UjIDN0gHc+Sv1M
 FGFI8vqxaZ0cYHTsNeK/yIY+qasRrYWkCLPJ6HC8AyUwYbWas/yYnz34jVPOdMpopZt3S7vsYDB
 YUaRQFFta1jpiZqDeYE80qY1rEV1GdBXc+JuPZmebw9EFjJCDiyk5DpItrc6C7B4/RQYU4WQDki
 KpJcUR2C5A1gM8DxRBBPnlyYcMbb931H5she5mpYq32GMIpVFdPg3OEivcp2GwrgGn9CRlFk4b7
 cYlrhOPynJtmk+BBgepG2rjxIlmNgg=
X-Received: by 2002:a05:600c:1e88:b0:482:eec4:76d with SMTP id
 5b1f17b1804b1-48526959464mr39591675e9.17.1772809198203; 
 Fri, 06 Mar 2026 06:59:58 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.06.59.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 06:59:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/49] target/arm/machine: Trace cpreg names which do not match
 on migration
Date: Fri,  6 Mar 2026 14:59:08 +0000
Message-ID: <20260306145939.2162189-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Eric Auger <eric.auger@redhat.com>

Whenever there is a mismatch between cpreg indexes in the incoming
stream and cpregs exposed by the destination output the name of
the register. We use a print_register_name() wrapper helper. At the
moment we are only able to do a nice decoding of the index for
KVM regs.

Without this patch, the error would be:
qemu-system-aarch64: load of migration failed: Operation not permitted:
error while loading state for instance 0x0 of device 'cpu': post load
hook failed for: cpu, version_id: 22, minimum_version: 22, ret: -1
which is not helpful for the end user to understand the actual
issue.

This patch adds the actual information about the probme:
qemu-system-aarch64: cpu_post_load: system register
op0:3 op1:0 crn:2 crm:0 op2:3 in the incoming stream but
unknown on the destination, fail migration

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260304101625.1962633-6-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/machine.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index d3d4f2ddc1..d9b65b5eed 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "cpregs.h"
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "system/kvm.h"
@@ -1047,6 +1048,15 @@ static int cpu_pre_load(void *opaque)
     return 0;
 }
 
+static gchar *print_register_name(uint64_t kvm_regidx)
+{
+    if (kvm_enabled()) {
+        return kvm_print_register_name(kvm_regidx);
+    } else {
+        return g_strdup_printf("system register 0x%x", kvm_to_cpreg_id(kvm_regidx));
+    }
+}
+
 static int cpu_post_load(void *opaque, int version_id)
 {
     ARMCPU *cpu = opaque;
@@ -1085,11 +1095,18 @@ static int cpu_post_load(void *opaque, int version_id)
     for (i = 0, v = 0; i < cpu->cpreg_array_len
              && v < cpu->cpreg_vmstate_array_len; i++) {
         if (cpu->cpreg_vmstate_indexes[v] > cpu->cpreg_indexes[i]) {
-            /* register in our list but not incoming : skip it */
+            g_autofree gchar *name = print_register_name(cpu->cpreg_indexes[i]);
+
+            warn_report("%s: %s "
+                        "expected by the destination but not in the incoming stream: "
+                        "skip it", __func__, name);
             continue;
         }
         if (cpu->cpreg_vmstate_indexes[v] < cpu->cpreg_indexes[i]) {
-            /* register in their list but not ours: fail migration */
+            g_autofree gchar *name = print_register_name(cpu->cpreg_vmstate_indexes[v]);
+
+            error_report("%s: %s in the incoming stream but unknown on the destination: "
+                         "fail migration", __func__, name);
             return -1;
         }
         /* matching register, copy the value over */
-- 
2.43.0


