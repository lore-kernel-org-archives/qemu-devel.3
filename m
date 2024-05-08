Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402FEC25B5F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lNM-0001G5-As; Wed, 08 May 2024 13:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lNC-0000ZO-5h
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:34 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lMp-0007Zy-JW
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:13 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-51ff65b1e14so5445585e87.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190368; x=1715795168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WpkAm6Hg1nlOzBAO4vDNkPRXv+LXQE3F1WzdPdPpy9g=;
 b=Bb/1mYXGasgbIp0beH0g2XAyusrzkR5gmYATFXJ/PDHMVGMNkew/QxDpEzRCxoRql0
 +gKjLyQylrGDT3vofOxZkKM38A3CNeJjoIkB/iU62qk7Xq10eZQRHR46mm22LXbi9Fxa
 8FBkn9GQdjO0NL6r320rjreBbjBym+ZQKfTzPkvsqcHVcZZTkYYd8B3TtvuJhWJNzGIn
 UIOeUB7FCFeHVwfXrE0FnYIgWLr+1YqKYUCUzzdoPokiQhcJApS4pfn+6ea3Ea9iF/C2
 TC7JBKwUin4NmQns6fSnuw2JP7uyrPYwbq9SVDo6OOu2UspuBfscDlicI73tv6h7gOLu
 xOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190368; x=1715795168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WpkAm6Hg1nlOzBAO4vDNkPRXv+LXQE3F1WzdPdPpy9g=;
 b=IsYkEZfcRyhRWLnol+3DzR/ToTx3l55st0JPnWZUe3Jf8oXpQeBp8cYbqFN1uzPhk/
 RYGmuWlLYCr57c+AO4mkonFQkKmksMTfK8QdLS/tjvJCxZzJugieBv9B1FN/yFR+w7l2
 fe7WWm477NDeNQ66Ulnjamv1aqu56gcW2TmOiPghB6Y2rFoHL/fNc9VYMnIiUeqB8xoK
 X/cNFlRexq7nbIxZzZBmhZrhh42E4thwwUpmh682UQBX9Tz+CZUJyE+f+S3iLAkK5p3k
 Gn2boFk6T10E1N2dwcb7RsnkEfnOTZI7pkBMRI8G9caAMtTZUVL2HFRph6KOVHAW7iG3
 QvcA==
X-Gm-Message-State: AOJu0YyJSLx+GuUkwCJ8Gi/ogXuGHTG6CORnS+uMexG3tzQUXDVz2kqv
 1ndkC3mINnfwQZ8013dCMYxvJClNByvRjITwHRSADnO0JGlvEU9kGiQ7lB2p2evULMszVeSdOCC
 F
X-Google-Smtp-Source: AGHT+IHzilZL0UsJQg7qOE+WrXTMEeL8wAgXmaA85cXDJp/ux2bKdSihtYvsMB89Nyh69Sc9m87yfw==
X-Received: by 2002:a05:6512:b0f:b0:51b:79b7:8322 with SMTP id
 2adb3069b0e04-5217cc4ae15mr2511328e87.52.1715190368031; 
 Wed, 08 May 2024 10:46:08 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 t22-20020a1709060c5600b00a59c7a001b6sm4499003ejf.177.2024.05.08.10.46.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:46:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/26] hw/i386/Kconfig: Allow to compile Q35 without FDC_ISA
Date: Wed,  8 May 2024 19:44:54 +0200
Message-ID: <20240508174510.60470-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

From: Thomas Huth <thuth@redhat.com>

The q35 machine can be used without floppy disk controller (FDC),
but due to our current Kconfig setup, the FDC code is still always
included in the binary. To fix this, the "PC" config option should
only imply the "FDC_ISA" instead of always selecting it.

The i440fx and the isa-pc machine currently always instantiate
the FDC, so we have to add the select statements now there instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240425184315.553329-3-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 4362164962..58ca8f246d 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -32,7 +32,7 @@ config PC
     imply VGA_PCI
     imply VIRTIO_VGA
     imply NVDIMM
-    select FDC_ISA
+    imply FDC_ISA
     select I8259
     select I8254
     select PCKBD
@@ -72,6 +72,7 @@ config I440FX
     imply VMPORT
     imply VMMOUSE
     select ACPI_PIIX4
+    select FDC_ISA
     select PC_PCI
     select PC_ACPI
     select PCI_I440FX
@@ -87,6 +88,7 @@ config ISAPC
     depends on I386
     imply VGA_ISA
     select ISA_BUS
+    select FDC_ISA
     select PC
     select IDE_ISA
     # FIXME: it is in the same file as i440fx, and does not compile
-- 
2.41.0


