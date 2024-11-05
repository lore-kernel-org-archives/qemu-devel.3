Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49584D3E77D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SLL-00058Y-Bm; Tue, 05 Nov 2024 17:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SLB-00054E-9W
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:03 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SL8-00049l-4q
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:00 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-37d808ae924so3353902f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846876; x=1731451676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3LEHugE7mZCgdtSwZax7wqcEWyZpEObOLM8OQShnbTo=;
 b=ENi0W8YEzoo/it7UPJUl/pSfM/smuTMkmi/1MA4/Xf6ckP3qG+ARtsoM0wSThPjsyY
 WjX/BTCqV/ireBvjOiCf2g6o2F7FPDwQ+W8hS4lmWTzr8zot4PfQMZIBn96T6IHtS5/x
 R27e8IBXR+VwuUNRFoZeDzDRRMSyOw6ajL4RHcfAivK4laALYJ/fMIDYAj8Jj42QFhFD
 ifDK49t7xvQwoBPPEXVZ3hcPBZDlQGfV6o7ylxc0efb2TRH/9x5WNgQJJByHP0ZjfFMS
 5T4xTFJ74qArmLQRslq9hfbc+W42rp5rGOK/moDhp5k5IGAOiWHagUVzRhmOZ+92OR4e
 zS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846876; x=1731451676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3LEHugE7mZCgdtSwZax7wqcEWyZpEObOLM8OQShnbTo=;
 b=M+13MpP6t/u7ThPp47Ok/Y5I0tMREomKdh0HaBJIoeoudjzI/jwsdCagVb1LQEdiTr
 X8QvWSgWAPQ7CvqMwA24HkubjW2+ftRzK/6AzNVbnllMGc0+LJwRc9rJdksJ2OYHA2aK
 dsFDl3cqOJkaszjNYv8KV/fR8+pUIGJ8yJc31syz3D0Ol/Dr37/7jbxiOzrzvUbZVeLK
 dl1ywpBT3oAWZjZtFqkvZ4WXh5sO9nQJW1xZLO2ia36GClUkTOVmH0PPlnuatq54cTIf
 3QC+mneyHT5QKUbVUsspi9tyVd8W+CIL8yeLJxEQYAF68Cja7KMmzwFSzKJI8RhimoB+
 LlpA==
X-Gm-Message-State: AOJu0YwiTnP218EzdQO44U5Dx6EgtzqwDPqYK5LJpixOrGix25GiRIc7
 zXkDwRfz+hIn4hMtgaJ6mkeRn7dhjReqQc2DDmIJflYqZfVFFQ1WCwuXS+HBIe7It5z9c+p02gK
 zwOkd8g==
X-Google-Smtp-Source: AGHT+IE3LcyMwk+41P/4VbRLJ8/i5lRJJokq8cblDLqdy520BlTmSPchWnTFG7B3BBIHTXInMxnz/w==
X-Received: by 2002:a5d:5705:0:b0:37d:2e59:68ca with SMTP id
 ffacd0b85a97d-380611633f3mr25596560f8f.28.1730846876407; 
 Tue, 05 Nov 2024 14:47:56 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116b181sm17221812f8f.107.2024.11.05.14.47.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:47:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/29] hw/microblaze/s3adsp1800: Declare machine type using
 DEFINE_TYPES macro
Date: Tue,  5 Nov 2024 22:47:03 +0000
Message-ID: <20241105224727.53059-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Replace DEFINE_MACHINE() by DEFINE_TYPES(), converting the
class_init() handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20241105130431.22564-6-philmd@linaro.org>
---
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 581b0411e29..6c0f5c6c651 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -55,6 +55,9 @@
 #define ETHLITE_IRQ         1
 #define UARTLITE_IRQ        3
 
+#define TYPE_PETALOGIX_S3ADSP1800_MACHINE \
+            MACHINE_TYPE_NAME("petalogix-s3adsp1800")
+
 static void
 petalogix_s3adsp1800_init(MachineState *machine)
 {
@@ -132,11 +135,21 @@ petalogix_s3adsp1800_init(MachineState *machine)
                            NULL);
 }
 
-static void petalogix_s3adsp1800_machine_init(MachineClass *mc)
+static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800";
     mc->init = petalogix_s3adsp1800_init;
     mc->is_default = true;
 }
 
-DEFINE_MACHINE("petalogix-s3adsp1800", petalogix_s3adsp1800_machine_init)
+static const TypeInfo petalogix_s3adsp1800_machine_types[] = {
+    {
+        .name           = TYPE_PETALOGIX_S3ADSP1800_MACHINE,
+        .parent         = TYPE_MACHINE,
+        .class_init     = petalogix_s3adsp1800_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(petalogix_s3adsp1800_machine_types)
-- 
2.45.2


