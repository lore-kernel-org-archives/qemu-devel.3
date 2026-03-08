Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42AAEA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMie-0000HJ-Ho; Sun, 08 Mar 2026 18:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMid-0000Eb-Cs
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:35:27 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMib-0003H9-O4
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:35:27 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4853aec185aso3084565e9.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009324; x=1773614124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gpF+bC5Rqb9mt+abFwuopRjwAKXmFMYfU92epuLAv0Q=;
 b=jX+20VCSKmiTp2vmuAviFr9qx5AHXHJz8/eAh307NIwZtx5Pe7S+/dXPxrxNuTcv2v
 qEpCq+1THefHBS6m/QDobcuigCIcN7i6vesjeZveONEtZitbnwP3tmp4XbVt+3Gs/cx7
 Cdwg6G0TAAsVxvk8ZuCQYps1qIrIG/o2Yd6TPpPA/zBQdF9BKNnqi/iyzt6jmp00Qm/L
 f+M8qST8WbNLFFes876wuVhO4pINdEmGvdPUTyWMmRYFkXhQoru92lxvDzwI7JR7wwDj
 QjmXK/Gtn8Hmc+y3HQKC38wEGguTZRvtY9GqDLlwPxN6/H2Cr4r83yC2eojelZKug85v
 swOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009324; x=1773614124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gpF+bC5Rqb9mt+abFwuopRjwAKXmFMYfU92epuLAv0Q=;
 b=wl4s5OWjo91EsvK9Ecr0zBjcnWE+oTo4I/S2wkx9rqzvN8MPdgQzuOgix+a+AqqfMg
 5391apqYqZdOguicHpGob7gvgsPO+VWFXNJcRSNxQjDYlKEmbhlG1MSNqVm91NXB2eiu
 ird2Fp09kswzgWgZ4nbFiTVNwPD1EYspwJZsTbBPgvWKLG2wnf+JAeWL8vjkQpaGcb12
 KxbtYh8MAE2lffCGRcMQAix50Zi0x7tpDjQiGs/uLdNsCwZb0WTln9WRKj/CshX1AUh6
 tdAMSLUzH1QVu3H0Z0qxacLyn588bPuHfv3cWNZezMjf1khwXXIhK5Z9C7mKFfKmzDTw
 g2Qw==
X-Gm-Message-State: AOJu0YySudPgyWhy95DbuyCNQ0/de0uhFtr+QF0Y1kB1I+bBXh7/YgPl
 oqeBPxVvqBJH+Z91uttg+ARjtDca0bzXg3c1Kmvly89Bw4dhmh/efdUydEohFnQ0NmONHrqD6x/
 1V53jlhA=
X-Gm-Gg: ATEYQzyVzWltBqXX/wzZYCkl5sHBn3EO532+BljvhXhXoD7vAtLUDfzC8kKExX18T/S
 MkmO51ghZBn7HK9lZUzkWLfsgMy+HCfLA2dHHicb1aokKQipFTLHk7IX/Two2XH9SfIwUBMkk7o
 cEFEwwJjv7gfFxOqvXtQHP0rpxAUTclsCoZKtSo475hInS6M5YoLtF0Jb5B40RgP2UpHBlZPvAl
 5zsG3JtkwBMOm6492APq6KXeqNQK6wdj/KH0wel7kabCv5VaYBYvL4s59h5FhaCxLWNkEcX0Cmb
 O/FdMPAsmGzY1aNBP1hSJHOzidU8iy8mk817cT1dhJEzvrg0DsQavUls422KmYPWcLdf+13E6Vt
 YRAJ7wZAWZ15cZULldW5SCkQNTZZae0sbe+ly8gENnn0RG8DaVpOTnwXz4gIq/JiYGdNiEddHtd
 m6H04La8VCcOuMlM0fFYY3gXoFgYa/2nDZNdTOnDgEV8FaoxMYG3HRXl1NnWb9/KOQ6H6pV/tWz
 jaOWQ==
X-Received: by 2002:a05:600c:8218:b0:485:3692:e8f7 with SMTP id
 5b1f17b1804b1-4853692eaf6mr47314675e9.25.1773009323698; 
 Sun, 08 Mar 2026 15:35:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852687c1ecsm124430155e9.1.2026.03.08.15.35.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:35:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/49] hw/acpi: Move qbus_build_aml() function out of
 acpi_interface.c
Date: Sun,  8 Mar 2026 23:33:51 +0100
Message-ID: <20260308223433.25503-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
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

acpi_interface.c should only register QOM interfaces. Move
the qbus_build_aml() function to aml-build.c with the other
AML build-related helpers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20260225035739.42848-4-philmd@linaro.org>
---
 hw/acpi/acpi_interface.c | 10 ----------
 hw/acpi/aml-build.c      | 11 +++++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/acpi/acpi_interface.c b/hw/acpi/acpi_interface.c
index e58e8aaee23..a44679017ea 100644
--- a/hw/acpi/acpi_interface.c
+++ b/hw/acpi/acpi_interface.c
@@ -2,16 +2,6 @@
 #include "hw/acpi/acpi_dev_interface.h"
 #include "hw/acpi/acpi_aml_interface.h"
 #include "qemu/module.h"
-#include "qemu/queue.h"
-
-void qbus_build_aml(BusState *bus, Aml *scope)
-{
-    BusChild *kid;
-
-    QTAILQ_FOREACH(kid, &bus->children, sibling) {
-        call_dev_aml_func(DEVICE(kid->child), scope);
-    }
-}
 
 static void register_types(void)
 {
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index ea1c415b211..4b374050881 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -25,12 +25,14 @@
 #include "hw/acpi/acpi.h"
 #include "qemu/bswap.h"
 #include "qemu/bitops.h"
+#include "qemu/queue.h"
 #include "system/numa.h"
 #include "hw/core/boards.h"
 #include "hw/acpi/tpm.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_bridge.h"
+#include "hw/acpi/acpi_aml_interface.h"
 #include "qemu/cutils.h"
 
 static GArray *build_alloc_array(void)
@@ -2647,3 +2649,12 @@ Aml *aml_error_device(void)
 
     return dev;
 }
+
+void qbus_build_aml(BusState *bus, Aml *scope)
+{
+    BusChild *kid;
+
+    QTAILQ_FOREACH(kid, &bus->children, sibling) {
+        call_dev_aml_func(DEVICE(kid->child), scope);
+    }
+}
-- 
2.53.0


