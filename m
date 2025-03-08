Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FE8C28B28
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr1sI-0006S1-Qr; Sat, 08 Mar 2025 16:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1qw-0005OZ-95
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:37:05 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1qt-0003tO-UE
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:37:01 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-391211ea598so1779843f8f.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741469818; x=1742074618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rGeGYkd/RvTeD7MNw4buaroHbkJmR8tAE2eHN3vxKfs=;
 b=gjUlNPWTugBQD2cSA/a8U99zncJYPIx7pHUmrDsBWEia16XmZzrqrYD3L3NwzAb7wO
 cpuLwJ9oss1pmskcInwY3WSkVbeDY3GCkyqncZn9jzAboznTO55DClQt2odWLBSIhILO
 LVlYlliwnfjPPeBr6O3N/9UMHk7j8ZKAFERBBlDoNpdtgfuOXRYeCZOWroCpzR0zqESA
 vfniYH6+Di9Yllibfz7Atl/CzAP87eeFezzLLj40NALR+UWKVKCI1heWgpFDdvSFFuyP
 Cox7Gt2WBiW1aDixSU/CiWuyNkHMRGAm9o6+s/Op+BqnpXXE/wdbAT9ggRS318+Vulot
 dbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741469818; x=1742074618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rGeGYkd/RvTeD7MNw4buaroHbkJmR8tAE2eHN3vxKfs=;
 b=Py1+b6r3CaCCSCM5kGwe5qfVT07JWm/83KSgtllXglifskbEG+XhjzhN1ilLb/Dgnw
 VSTjZH/4bykm0gzlVLR0Ys7C+cDZ+TAmygEWEjMnaCSTdlJV8QS6HIimnicfaGvcxBT7
 uDNE/qlgNIYoeCJAw7/mI9R0auAdjT7+4zb+iAmaQ4Q6NtUeW93ZNGBoyW6V5sIQGh/k
 qy8z2YjJKOjzx4P8B4LjnP9ecWQH1S9GctkjuTUVC8Pwd/0G6KoMtrXIFQvJEBx1WAVw
 psPVg205VzkDHaimxt5anXI8dXdV8rToNpwcOcsRz0X75+eyUpCxZ/m9l25ndDuKL/F2
 Ya+g==
X-Gm-Message-State: AOJu0YyPzMru2AZYYqwi6av7lRugapWwzyrG+7H5QS97hThsbTrrZtEg
 vxadcXTv2dNX9OyCmOOxjedXysK/8CDw4jCzB0HhYEBC2TrJxgIp47r902DMkTHVKqbMhmm3Mtk
 v8po=
X-Gm-Gg: ASbGnctGH2525WdoovVetdFxnEM2ei37hs4NTm7pHhZMJiioTGIvHgFcEPEpYcqUzOk
 dHUqeQ/EvwL0wCPeg0o2F5s/auvOD9B5EjPrt9fCqopxKjzbdTt+p/ZedUPL1G2MfTzTbG5eQdI
 CqOydnhiFyYhRGPgFrIggRjPjalj0bFlk2qYO6g5UHlv6DQPp9DMmSU45Tg57b1WoZIaIP8/y5N
 TGsuOY6b6Rp89gVBU6LHhGUcY0J5XT9qOquGWJK4d6Dz2UUqgJljwekSbBIGKkI7IuWsPHDQJEA
 BRIsV+79Re5T5+2/3knZIWxrPqy9oABy9oL///w82Ty5NGy1cQU8LKqp1wB01W5ygXru+X3Ll1T
 bJJj5araPXjLdMJsFy30=
X-Google-Smtp-Source: AGHT+IEMElLuqeiItqUCxw1e5NAlsbPttD3M/bUUMRwKrRzuyDY9g0B8F0IaoP3gDh51ZBP70hYdBQ==
X-Received: by 2002:a5d:5987:0:b0:391:2bab:d2fd with SMTP id
 ffacd0b85a97d-39132da96c9mr5536253f8f.37.1741469817935; 
 Sat, 08 Mar 2025 13:36:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cec487fb2sm22294015e9.37.2025.03.08.13.36.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 13:36:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH v4 03/14] hw/sd/sdhci: Introduce SDHCIClass stub
Date: Sat,  8 Mar 2025 22:36:29 +0100
Message-ID: <20250308213640.13138-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308213640.13138-1-philmd@linaro.org>
References: <20250308213640.13138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

TYPE_SYSBUS_SDHCI is a bit odd because it uses an union
to work with both SysBus / PCI parent. As this is not a
normal use, introduce SDHCIClass in its own commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sdhci.h | 9 +++++++++
 hw/sd/sdhci.c         | 1 +
 2 files changed, 10 insertions(+)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 48247e9a20f..c4b20db3877 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -107,6 +107,13 @@ struct SDHCIState {
 };
 typedef struct SDHCIState SDHCIState;
 
+typedef struct SDHCIClass {
+    union {
+        PCIDeviceClass pci_parent_class;
+        SysBusDeviceClass sbd_parent_class;
+    };
+} SDHCIClass;
+
 /*
  * Controller does not provide transfer-complete interrupt when not
  * busy.
@@ -123,6 +130,8 @@ DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
 #define TYPE_SYSBUS_SDHCI "generic-sdhci"
 DECLARE_INSTANCE_CHECKER(SDHCIState, SYSBUS_SDHCI,
                          TYPE_SYSBUS_SDHCI)
+DECLARE_CLASS_CHECKERS(SDHCIClass, SYSBUS_SDHCI,
+                       TYPE_SYSBUS_SDHCI)
 
 #define TYPE_IMX_USDHC "imx-usdhc"
 
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 149b748cbee..4917a9b3632 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1960,6 +1960,7 @@ static const TypeInfo sdhci_types[] = {
         .instance_size = sizeof(SDHCIState),
         .instance_init = sdhci_sysbus_init,
         .instance_finalize = sdhci_sysbus_finalize,
+        .class_size = sizeof(SDHCIClass),
         .class_init = sdhci_sysbus_class_init,
     },
     {
-- 
2.47.1


