Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376B1FA1FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdkW-0006wc-H9; Wed, 22 Apr 2026 16:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdk3-00063m-Eu
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:00:13 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdjv-0001HP-KD
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:00:05 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-483487335c2so58210445e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888001; x=1777492801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=40SByLyuW2PkJDpu1jfElcsJrTDuMaBUCvfo4BTaLuA=;
 b=EOvAIHuRgPaxjf5gCAovI8L6GyN8SZvMnypccih3Tk2RbEdLZIRfSTQ+3tLm7QTdXN
 Onm25bP4nAbqe6Pe37W4NNR7NDpyajjv+wzIUX5Q/OXiRpznI4n6/7Ht1/HfrGr1LIek
 4PlHNW1rSCJp/5D84E34fG6/IOWGn+i3QcFLba1k0Kai8wIKBmQnC2phyyXXxEFTM6Sm
 CVB6mDQwjbXLZnTftSrq/MwwTabF1YhKmjo2ZdptRADfpsa/bKTc8mW4OW/CMllipMNc
 rmArMbmI9VGFxHYqKhMlpsDmO241PwfAYjH50Px67bgf0ua9lMQMAlzaX2vJpjNf0aRO
 SrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888001; x=1777492801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=40SByLyuW2PkJDpu1jfElcsJrTDuMaBUCvfo4BTaLuA=;
 b=HKyzCsV8I0o80PdwIzlovmhnUoh/QmpcRM8GTzSA0cUmJgeRREiiZgjZqlQOnpSXqy
 GXCATt5Uk7UGdCflF0e/dfgghJLFFXeShrP+nXp6G0b25Uin33wldSAxCNCh2Miu/V0r
 xJ2cXHZpvaqYs1kEzkGKFyhMSHZ+zEBHq1xhJuk0wkPwsB8vzw2qwO4K5jcAUiOSRBo4
 7fZf1KdAag7Hg/zZAXM+CMzLEEoT4xMHgSQNaPIBa/5Yh+Gl3T/tuzqBaWX8VGBHz+C2
 +6uHTNnVpJjDiRFFNm9nURxYgzmEtdSgz4A+D0GIL7IWvnRCxEjAXAwjv25ITp1m523M
 DhSQ==
X-Gm-Message-State: AOJu0Yy4DmSXV1Ej+qfJotZQvQcqZ7T8xrctpJQdk7OE1MdcrKmhYII9
 HMU3T/r4/bK/6yIixCplKm0+A+mZ7M5YeWtvlLT70L5c8p/9H+uwfsMVYP1xcUWrg32ht37jsRj
 3wFVqp7Q=
X-Gm-Gg: AeBDietsyWJ/gykb4O/3aIAimX6eTuyUDjUVGYjN8J8WeLEa2i3imWVC70fToIRWZaG
 1ToUZKWqXCkL03aU7oHvAPY2G4hvvIz+XzwqSBf8UAt/jUacU6fulVOPC10GA5Pf3LlbNWZVj78
 apHbxCWnam2TdH+GpV9heTI7lcFH2+hQcamWXV+fxfvz6ardYAvG8JXNgTATH7OtWlHgl+70ZJL
 qc6IgYTChoVqkUW8g1Ra8anTqZ5hdUuM79YT5BOBKeN5dpJcJSjukkTeCQKL3jduYsMayFSUf4Q
 JfThw+w45pGXhTYyc3kWV0rpVSC897lOJfkHvekyefrDwjSAAC4BNrzUt2dF1BWdw9bxvzBoWz/
 5mouFJ3k7NpniiD3aj3PyYv9sY1DLz2bfO9JJSCgdaP3e7DDC+cyijF7Wryi3fxlFJvK88cB4iB
 yUbfrivTdV3t2N6+vITtA/qEdavgMGcbjCvxWubPW3ZCHR5RZ4v7aYb/Os7ANyCccC7oWq5a+Pl
 r9sdbePozY=
X-Received: by 2002:a05:600c:3b11:b0:48a:525b:e148 with SMTP id
 5b1f17b1804b1-48a525be2f8mr154296335e9.4.1776888001429; 
 Wed, 22 Apr 2026 13:00:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc10777csm533119085e9.8.2026.04.22.13.00.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:00:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/48] hw/tpm: Factor tpm_ppi_enabled() out
Date: Wed, 22 Apr 2026 21:57:17 +0200
Message-ID: <20260422195746.88865-20-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Factor out tpm_ppi_enabled() before modifying it in a unique place.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Message-Id: <20260317120241.16320-2-philmd@linaro.org>
---
 include/system/tpm.h | 9 +++++++++
 hw/acpi/tpm.c        | 2 +-
 hw/i386/acpi-build.c | 2 +-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/system/tpm.h b/include/system/tpm.h
index 1ee568b3b62..b90dd4e8cb0 100644
--- a/include/system/tpm.h
+++ b/include/system/tpm.h
@@ -13,6 +13,7 @@
 #define QEMU_TPM_H
 
 #include "qapi/qapi-types-tpm.h"
+#include "qapi/error.h"
 #include "qom/object.h"
 
 #ifdef CONFIG_TPM
@@ -78,6 +79,14 @@ static inline TPMVersion tpm_get_version(TPMIf *ti)
     return TPM_IF_GET_CLASS(ti)->get_version(ti);
 }
 
+static inline bool tpm_ppi_enabled(TPMIf *ti)
+{
+    if (!ti) {
+        return false;
+    }
+    return object_property_get_bool(OBJECT(ti), "ppi", &error_abort);
+}
+
 #else /* CONFIG_TPM */
 
 #define tpm_init()  (0)
diff --git a/hw/acpi/tpm.c b/hw/acpi/tpm.c
index cdc02275365..5fe95f2e3f1 100644
--- a/hw/acpi/tpm.c
+++ b/hw/acpi/tpm.c
@@ -25,7 +25,7 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
     Aml *method, *field, *ifctx, *ifctx2, *ifctx3, *func_mask,
         *not_implemented, *pak, *tpm2, *tpm3, *pprm, *pprq, *zero, *one;
 
-    if (!object_property_get_bool(OBJECT(tpm), "ppi", &error_abort)) {
+    if (!tpm_ppi_enabled(tpm)) {
         return;
     }
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index f622b91b76a..4f01e2c476e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2218,7 +2218,7 @@ void acpi_setup(void)
                     tables.tcpalog->data, acpi_data_len(tables.tcpalog));
 
     tpm = tpm_find();
-    if (tpm && object_property_get_bool(OBJECT(tpm), "ppi", &error_abort)) {
+    if (tpm_ppi_enabled(tpm)) {
         tpm_config = (FwCfgTPMConfig) {
             .tpmppi_address = cpu_to_le32(TPM_PPI_ADDR_BASE),
             .tpm_version = tpm_get_version(tpm),
-- 
2.53.0


