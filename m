Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12C2C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 13:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uThh1-0008EX-BO; Mon, 23 Jun 2025 09:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uThgz-0008EF-3b
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:58:37 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uThgx-0007HC-Eg
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:58:36 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-748feca4a61so2258174b3a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 06:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750687114; x=1751291914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KCO4Ulw21w48TY/8gHQVa7B2eOfuj0N7B3tO1GbSlc=;
 b=X0IjcMN2Z1ZBLqjqcodnvT9efzMOCZNs0ilPaZVSXioepVnGRciAS4BY4pUW9f2TUx
 gQEJ7vOZFVGLPQHlRVtcVSYc99iH90EhA4Gt62sR00egfUVEjbD33tfkjf6Fe5iTL5R5
 lyukawTQCYCPbOQCEAEBFmYM8xmuKtk9payAUf/Zbu6daZ6ysNO/m5412/lanYYg3eU0
 LOBhQ5YuTPHsBkjiLf5nEqAlbITS1gjukstetFqme3IgMatzva+uejs6X1mus+13mB4n
 oMS79VR1IAMVA9ouEhzCKGRKCYGkXBb4qfT+PvosgRAulkFx0gR14jxhaG/WeazoijE8
 NuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750687114; x=1751291914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+KCO4Ulw21w48TY/8gHQVa7B2eOfuj0N7B3tO1GbSlc=;
 b=JXJXWGBvJXn4+eING+3pnrbVnINE8IsOd/j9PpeRrYT67QKUMiWGMfey/jmfhFP/G9
 PM7/q59GRrq51GCuFNTs33YzB9cxc1MhjqxoKgINNzQ3hAgbQIthO38sFsgSM9C9PTIy
 8oejvRhqedWgKy0fA50m+Rf3+muSHz4Qexsbme2nEXseFauDJhVPVU2SmntA0fvOLdrj
 cbcr8Dfsbr5WIDYG0TBer0wvXtacvsxRJo8lGz/vn9PJEYxTok3Bneh8sH+scR+rE+bz
 CjpoM5xmLZCf4EXr8qfuA74NRfZlR1tZHnRRNGH3vix9WfSD2pc/QAG4t32m8qSDFMJO
 RAaQ==
X-Gm-Message-State: AOJu0YzzraV6z7dUHfqWLmRHqB04Petd+Wmku4q/zUqLDUFpMhS2rVr6
 iowmEPh6FVd4Pwus5qltpK71xNdXUldK2XnpXWsQFGvZSSzoL/2+jN+PWRUMcZYgwXHAURALp4c
 HcpcE
X-Gm-Gg: ASbGncvWTF9BJPzEqZHL8XG+9TCLy+gOjUUEMUEa0GaIeRrrOSzu1rWEWp7uyCZzJ07
 fuChxQvU7jlFz+6f3hQJUy2OCiNXEnZLJ0zQ9lwjwK0cZfIZtPJmZFdeCugVRfOPGbPAv85qdX8
 /EUcRrKKFbG2JDlKKv2ur7o6HCbzQDSzhpJZ10M8FawLEwncsTIP5i6j+cJW+SFRBZ4hCOUgDB8
 ZQ5C1X6VC9tM8bdy4BAm3TDfMhcRHq6uMEOnoV3WriCzFe70MbLjP0XHm62HPpUN/tD7klGzEfD
 ZgAIF7EwbAbKahYHCEDxRHvnobf5oKoTVDnxBNwhFlEdtBdiT4uHUeBwJWKW9vI5Qb4=
X-Google-Smtp-Source: AGHT+IFjQAm59TTKInxOZjJuXB8hdE+jbTwwM+gqUvzv9UPWZ6u/2k9EzU7681DoI3yXvDXyaxvJhA==
X-Received: by 2002:a05:6a20:a108:b0:216:1476:f71 with SMTP id
 adf61e73a8af0-22026f13166mr19283222637.39.1750687113626; 
 Mon, 23 Jun 2025 06:58:33 -0700 (PDT)
Received: from gromero0.. ([186.215.58.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f119eb64sm8063490a12.31.2025.06.23.06.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 06:58:33 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 3/9] hw/arm/virt: Simplify create_its()
Date: Mon, 23 Jun 2025 13:57:43 +0000
Message-Id: <20250623135749.691137-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623135749.691137-1-gustavo.romero@linaro.org>
References: <20250623135749.691137-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

No need to strstr() check the class name when we can use
kvm_irqchip_in_kernel() to check if the ITS from the host can be used.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/arm/virt.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 19f85d0abf..96a09c3eac 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -705,21 +705,18 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
 
 static void create_its(VirtMachineState *vms)
 {
-    const char *itsclass = its_class_name();
     DeviceState *dev;
 
-    if (!strcmp(itsclass, "arm-gicv3-its")) {
-        if (!vms->tcg_its) {
-            itsclass = NULL;
-        }
-    }
-
-    if (!itsclass) {
-        /* Do nothing if not supported */
+    assert(vms->its);
+    if (!kvm_irqchip_in_kernel() && !vms->tcg_its) {
+        /*
+         * Do nothing if ITS is neither supported by the host nor emulated by
+         * the machine.
+         */
         return;
     }
 
-    dev = qdev_new(itsclass);
+    dev = qdev_new(its_class_name());
 
     object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(vms->gic),
                              &error_abort);
-- 
2.34.1


