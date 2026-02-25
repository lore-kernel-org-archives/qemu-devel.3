Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23797F55456
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv62L-00045o-HR; Tue, 24 Feb 2026 22:58:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv62J-00045Y-SO
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:58:08 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv62H-0001ig-Po
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:58:07 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4836f4cbe0bso47291775e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771991883; x=1772596683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQyLNHiEWerL/o55NeAOS+PwlpQu4AObZ5sw3qEZTLg=;
 b=V/a+AkRdTtrQbg74lxT53EzODMnTePxBuhlF1N11i1EQv0U4S/IuZXlOQQ9vLqOBPz
 SWYKfGOG3EPwah47RiezkxpwnJo2OnT1W4FV3DL8q/uAJCRAZdORJwyfeaShvyJmt6Od
 oohjv2dZN72OsUQLwtNvuLsO1A9U0xHGinDS+7kLwHHjAwumNYw62EMc7EVBC45xTlmX
 GkJRiUnBQuyGx2J7DD5PTNA9veNFMM9XIOt7RkMIbUa2Bf6zqD5PJhjertdd1TG4gPln
 Ijg19P8JuhjBW1vFkfRHuDqxmzYXQ9Ga7LGpoF8T++YU6NvNOG6G3t7mNbO46CGnVOPt
 /Wew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991883; x=1772596683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DQyLNHiEWerL/o55NeAOS+PwlpQu4AObZ5sw3qEZTLg=;
 b=AA7S7R7N92ODa2X8J+HyGuIEJKK92lLKnCCrreKDXPeQuuzKkcSAJT2ALK7tzWNveD
 bzwZlA9fMV5wVdPj2BriZalU3CRrTE1mfWcegynvYHHRT8C84B8cZOok6Nomknxy5UOL
 Gkz8EAY6RXVa7ymmoykUQf2lzw8mZsH6PATsyB/b1OUf0Bnp6ldLvkRBl/qhAL//Uau2
 6t4Xr7fx+DfNtd1L7XngxnSmMynnx9ieD1dWcEQxxNp7LTTX9wChQRfCx46J8mSewqN+
 Ix0xbkgDtv7muUwetqqYxqYTTEbzlsr+21FeKARn7XaZXqghmpMPxpnSUCM7Xn/ROKIi
 0FFQ==
X-Gm-Message-State: AOJu0YzKDNt5nfLd/dzrpM1HITIOc88l10CYYitFSqw120A2MGGRzWEW
 D5jiS3KP9woePbSktyOFDmPPJTGBeF5D7JWRUrHJnqtT9KdFpggPg3MIpznojJeOpzHC9Zx3nvt
 mi+cnB4E=
X-Gm-Gg: ATEYQzxeB6EcPV/FA8j7HkU8EmYY4eCBKWLXubZnNIiceXZ5OkPqmzh1km/Erdah6EL
 YEXbTxkNFpdfO4GXVOvZNDJhY7gItZ3IoqqBRYsZUAZb6yY7y1VurMT18Hivbd/c69Cv1YNyQ4p
 /Y6cJpyPjDE2tq+O0c27Rhl3Qw+CJjmWS7gZBmwVY64b0yH5gC7zWJ6Ao35GRBvbDgnaVXgiWjU
 3pu5z757stzW0RFpgffCovUItZMrwS8ZJvouO8yrA6sqD18d5OIfgJarTE58l/o9KQF6j71f+gf
 56qh3B/Xgo/NYeKR7Is6g9GHB85Pu+n/HHFlgkpzyt3zOiwH8Ol4KEd3b8/CgMy48USE9xjpzA9
 UoWwqcZDkyGVS+1yw5niBTXV6NeY2+TiTHR2NaZt0RC/p8fWII4h/nDNI54C5XkrKnLdnu8pBer
 3mHKG1thZVHnEYR7E816DXMlpkXbZ05K3W1v1RZTncWOjf2EGxaC2rD5zJKs7MFgO6wVMLmb1n
X-Received: by 2002:a05:600c:4589:b0:45d:d97c:236c with SMTP id
 5b1f17b1804b1-483a95deea7mr249398045e9.21.1771991882965; 
 Tue, 24 Feb 2026 19:58:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd70b3f3sm43123415e9.6.2026.02.24.19.58.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 19:58:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 03/11] hw/acpi: Move qbus_build_aml() function out of
 acpi_interface.c
Date: Wed, 25 Feb 2026 04:57:31 +0100
Message-ID: <20260225035739.42848-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225035739.42848-1-philmd@linaro.org>
References: <20260225035739.42848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
2.52.0


