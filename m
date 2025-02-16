Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CDEC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 21:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjlmE-0003cy-I0; Sun, 16 Feb 2025 16:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjlm4-0003S5-HD
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:02:01 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjlm2-0007xK-P6
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:02:00 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38dcac27bcbso2857593f8f.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 13:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739739716; x=1740344516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EoUEir+L/Lwibe4TspeNvCoRQYIzBlRMRbwzJOivCrE=;
 b=pZQItYlDfY0i7Rp6xKgQ4nIRWGQ4AxBdeQ0P//K6pVbg5dU1ohsRFewWGWQ/0JrJG0
 NfQxCQBK7e/gxAskdQAcLt3vm8GBJSSuUPLXidwqoV2HxxO4Gjzt20+HZsLXDcNzy+Ir
 vrUiW0R5obtrR/tIT5erXhehXmC6K3YBe1v4rSwP83J6OODjLvKiyOVp8YI7KrbqmUSy
 qhX2bvNXBsJ1bMWKpytRf+QKc2O/943G5bNYl0Y8ssHNtX+ze49okJKAZSJhSq9wFrZM
 yMF/AXSp4j2DdlnmSrorBUyRW8SXSWk8SGOx81lfdHNREnGz4iiveR5rcCHCy1aiDvxC
 mJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739739716; x=1740344516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EoUEir+L/Lwibe4TspeNvCoRQYIzBlRMRbwzJOivCrE=;
 b=RgtHMJMLPjAIAcy1zaDiuEj4Lg/sjk2+OIS2dfKmOIvdlCqSeTpg/ENGtEVWyUYWZM
 K7lUUCSiQYGsncNLgLdQoZjULMNZVVu6u2jV3HkTbGIEcyq/X5eo9VkryYyeCytekrF9
 vy7muTfQ1iFT/bH3TqUGOKeNqPzmhvZCIzPp7xSKSYg5d+FFofQY+vUUL/KTKT/U6/8z
 x/VgQRD70Cdkb0qXOMy/mS8/cH2sES4VDghnKcv5IC5/unL6BB8sDq7ZIq8Nns252LQB
 LCSAczTFDv1xCWj4iRNbn0N28JE7Qf258hAfjmkP8hDkp3AtkDAHO62932lUsX8OyBhE
 gVeg==
X-Gm-Message-State: AOJu0YwAT/Z7+2ZwXh4DoDLSKkfoiPh41v8I7pdwP8FmG04vUL6lv6k4
 zMJ2Wr/+2HxTXPRoafRo7/pipVv8KqgxWfzENQZAAp9icu+ZR0gV2PmCejC1oL7YuosknEE6lNR
 ziz4=
X-Gm-Gg: ASbGncuyulWrY5Ud9n5MQLmBDcsant2eaMiUePpk3MLmmHik1ins52VoKvxJdOMAKyL
 nroEBGQaWIWPbmqEQwxx0i9cUZrbUursfDjVL2LJ7+crVuOCa31K9nu1u0Rw/bDVTIoexjmVsAl
 Yq9XpL9oCbuDlhN3pZHOtNMstBeTwuy5D3IHWCVuScZgqZnDszxZFSstoyNMv/D6qgwo99XROPG
 DjfHQzz743JCYSXtlQScv2AfuAR2KvZ6AjS2zap6a3YIFyqD61HgXQC3VbaZ4uk+7wJTt19Pxg1
 7rqbELUG6z8IDY81vax3NBTjzMzy+MvsFk6d/GpDGpAJlCpBTqlZY/3FZm7EgGdi1pbO6rI=
X-Google-Smtp-Source: AGHT+IE6dykI484uJsqmaKwZf+SdzfeGN1sqv/JuhTYA4j6X4SeL9SrWzL8Lcb4Lm7AhTj1+nLJb+Q==
X-Received: by 2002:a05:6000:1f8d:b0:38d:b028:d906 with SMTP id
 ffacd0b85a97d-38f33c20f7cmr6473292f8f.21.1739739716276; 
 Sun, 16 Feb 2025 13:01:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d65bcsm10498204f8f.65.2025.02.16.13.01.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Feb 2025 13:01:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 38/39] hw/pci-host: Mark versatile regions as little-endian
Date: Sun, 16 Feb 2025 22:01:02 +0100
Message-ID: <20250216210103.70235-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250216210103.70235-1-philmd@linaro.org>
References: <20250216210103.70235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

This device is only used by the ARM targets, which are only
built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_LITTLE_ENDIAN (besides, the
DEVICE_BIG_ENDIAN case isn't tested). Simplify directly
using DEVICE_LITTLE_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250212113938.38692-5-philmd@linaro.org>
---
 hw/pci-host/versatile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index c3fbf4cbf94..33a8ceb3b54 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -246,7 +246,7 @@ static uint64_t pci_vpb_reg_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps pci_vpb_reg_ops = {
     .read = pci_vpb_reg_read,
     .write = pci_vpb_reg_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -312,7 +312,7 @@ static uint64_t pci_vpb_config_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps pci_vpb_config_ops = {
     .read = pci_vpb_config_read,
     .write = pci_vpb_config_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static int pci_vpb_map_irq(PCIDevice *d, int irq_num)
-- 
2.47.1


