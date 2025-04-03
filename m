Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7B2C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0MMw-0000mW-9L; Thu, 03 Apr 2025 11:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MLj-0007lk-S1
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:19:30 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MLh-0000WI-5y
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:19:22 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3914a5def6bso690741f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743693559; x=1744298359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TkNWzS/5Q0X1wok5s6TRzd+7v9TwGIUutsDTBjTDsAk=;
 b=koCTxZ3du0y0CvksF7OGuQUac6tVNY6BHfLs3imR6iQKaU8yDoe26Eve+uBz+nYjdQ
 E5ENUZzf2CnpA0X99UHJTSlZ1YMFWAj80swxGlday6CqKJO33ysIVDGM8k2eGYyOztj8
 fIOWk1KqMELKZ3bvRNXsXIXr2ho7JNhyXtah6a1kE6Sl9LCQ5B16s9oaVram3q/OBeBH
 eccncIsOYTaTXe/Dx1Hr4Z7CDgI4lSubnyEvzoxLKiCfjmHrMZjXvKJy/BqmZ0KfTJ/N
 FAcl6hFPuYeZwCucjJuqcXpRYUgGOfZt5Px6VlGEu+t0++/MFWcfuISNgNbLDK+4ZGLV
 7DZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743693559; x=1744298359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TkNWzS/5Q0X1wok5s6TRzd+7v9TwGIUutsDTBjTDsAk=;
 b=V28KwF5Xma8J8djhvopMH9BXH2VDSrij5jK+A8lSILNvFBOO4h7QqI7rxovnGJFsAL
 mrQD2gbin34Mwk8QZmhrhOYO765Sbas83iBt+KyBIZ1kn1uDrzAnY/Ds9ZCFjfYD5FHY
 O98lQFwJ9BV+TkWngpVhkUHWosEwspZJQkF1OYF2QzC/g8CTM77u6Vx3esUXMTyluq66
 DuEnbLnJEoULo/otE+/lZMu9cfohHSa6yFeSlP4amkLO2GTckGezVAM1wb21rBNmHbLr
 z1n/drCcsu0HF/cfjkwZ1dd6LE0X5l0tXMoSI7lHtSZzax30DD881juPSASrYboLHsT6
 X0DA==
X-Gm-Message-State: AOJu0YyjDPOzqxaFHcuWfCkvNon8IKSjkkSxGPNwaVk9D1sHxCTHGwKA
 +lPSg4D3xjogoFQnVKyjtXMUdis+LXelJBihoiUui4pBY+1nl5jOCVCRk94vz72oz8O8don6IOB
 e
X-Gm-Gg: ASbGncumKodZhJzoU5UUQTrIibFW45JSjmv7JwwiNEqRXox21d7gtGGQ7wzaD+2GHLI
 O86eAg1Fi2NDDlmTDcZ2bOxAiV0alcTTyasZzTC2YyRWzJkeIkKangJ5tAh6J774vtmC2sF1Koa
 2fgVuzDa9gGCZWCBAXYowYu6csHgTVcWdLkTMGfmV+za4blQeBzpXZlF2lQ2BREeDWTdNz2VxBF
 D5DXlFkc7ws36huJI39PhWFrbWOO6GypXUf3zgpESup9qyInqGNFJ0UPK7CnricoEpinBnnfKKK
 efQqMv3rC25xVX25a5AAWUxQ5H+CaPwbAbqbomNZBj4c8uMG9aPlPDGbegryBOBYo1v1yoXe6Vf
 zaLp97TZTlukNvA7X/65xGJ4a89haNw==
X-Google-Smtp-Source: AGHT+IH9Gt8qY01Hxqjy+L8vfzdPwKRObYb9XyNG+k0b+HEZ0c+CExk2RCPwjhCk7SDaHusGD8ysFg==
X-Received: by 2002:a05:6000:4211:b0:39c:1f04:a646 with SMTP id
 ffacd0b85a97d-39c2f8cfe62mr2784406f8f.13.1743693559057; 
 Thu, 03 Apr 2025 08:19:19 -0700 (PDT)
Received: from localhost.localdomain (145.171.88.92.rev.sfr.net.
 [92.88.171.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a7225sm2065828f8f.26.2025.04.03.08.19.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 08:19:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Udo Steinberg <udo@hypervisor.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH-for-10.0? v2 07/14] hw/intc/gicv3_its: Do not check
 its_class_name() for NULL
Date: Thu,  3 Apr 2025 17:18:22 +0200
Message-ID: <20250403151829.44858-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403151829.44858-1-philmd@linaro.org>
References: <20250403151829.44858-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since commit cc5e719e2c8 ("kvm: require KVM_CAP_SIGNAL_MSI"),
its_class_name() single implementation doesn't return NULL
anymore. Update the prototype docstring, and remove the
pointless checks.

Reported-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/intc/arm_gicv3_its_common.h | 2 +-
 hw/arm/virt-acpi-build.c               | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/intc/arm_gicv3_its_common.h b/include/hw/intc/arm_gicv3_its_common.h
index 7dc712b38d2..3c7b543b018 100644
--- a/include/hw/intc/arm_gicv3_its_common.h
+++ b/include/hw/intc/arm_gicv3_its_common.h
@@ -128,7 +128,7 @@ struct GICv3ITSCommonClass {
  * Return the ITS class name to use depending on whether KVM acceleration
  * and KVM CAP_SIGNAL_MSI are supported
  *
- * Returns: class name to use or NULL
+ * Returns: class name to use
  */
 const char *its_class_name(void);
 
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3ac8f8e1786..9b7fc99f170 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -741,7 +741,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                                           memmap[VIRT_HIGH_GIC_REDIST2].size);
         }
 
-        if (its_class_name() && !vmc->no_its) {
+        if (!vmc->no_its) {
             /*
              * ACPI spec, Revision 6.0 Errata A
              * (original 6.0 definition has invalid Length)
@@ -973,7 +973,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
                           vms->oem_table_id);
     }
 
-    if (its_class_name() && !vmc->no_its) {
+    if (!vmc->no_its) {
         acpi_add_table(table_offsets, tables_blob);
         build_iort(tables_blob, tables->linker, vms);
     }
-- 
2.47.1


