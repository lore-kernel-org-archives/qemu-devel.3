Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900F6C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJQZ-0001Q8-PF; Tue, 06 May 2025 10:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJPg-0000R6-2b
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:55 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJPc-0001B4-J3
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:51 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso47064575e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542207; x=1747147007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VcUIrYmbGjwMRc++oq35b0qq7zt00pXf6AQPz2o0MDQ=;
 b=s2OeNlwzVaD835HxtDSuPMpyRJ+VAHeye8X4+KnCfdVuumfmqPP9Oo/yv2ucBpLz4Z
 QuXTSTbJ7d/SORHtzPkfpY9Ny7XL64A3MOCjqkZnZx+fEd3CrgS2SAmnwopLNJEGv4yP
 GqPGAkTcGJMiFzPX22XIfjC19ybrIyqfSNxjgku1ggvqclc1hW4SNMEeWs5HFthInB7L
 1md2qoRbdQlu0/acTPVmVSH5QdVIkyPWIgvHWcHTc8WdwSbL1klWLLccZrao5s7qF9OH
 I2ek1E24PJfgfQ/3GEKpiFxTGWsQ25d25fuGIdtjfK8ZFF7Bjmnp5QJLo8x8NdISypl3
 OAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542207; x=1747147007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VcUIrYmbGjwMRc++oq35b0qq7zt00pXf6AQPz2o0MDQ=;
 b=pERa04NSezU8nSt/0MUVg94CqlXIA81ovzutumg52GYAArPNi5whfhq8sBFzfTXucR
 9/jJzx+UA8w6cBhF/y4CM3qJ4jz0ZOT2NsWyT2lnj73LOq/V7M+VmbavrqSAECVnnNvc
 uDDUHY+m4z99xWh2wDl3+xdB88BfoYbw9hxUuCzmJQOuCE5DhNTyilCkT/dYXgbaapyk
 CW3ptGa6g6+Y7AMbMmpNXGXh7LaMlJzpp90l2bJ7vXBxmehgsywC5/UDb9vSyJ0u8lhe
 JzrgJIHn4BDhTtMGi0IssGyTBuRzBOq/dhIIj2TFs7g4bvd44xWtkU19E6D9zRH0bbbx
 G6lw==
X-Gm-Message-State: AOJu0Yxh/evV8piFKqQLRErSJtd5P2irGheTwq3Fs4H0xs2WjxkouxNH
 SNEEhxI0SIj2LmYiFvcIWKXFQa0UFjODXOexVvo8+lnIfGZF9zNvXqPtyt6tRTGIVplAsd+IKR8
 S
X-Gm-Gg: ASbGnctYXYm2htoLPn4voQT2WRu2aQROvQc/W/I8mW7ibHsJ7Ejz4HZLZO1xhCaXbzz
 mmQRWRh6MAps88N78uKBG/ovmBPamPW5Z2kSirTOBaK9V+QeSgS3ykrGdw9uRo63SuOYoglwkz6
 lWeJxJ58nE31gma+Tsba7darYFtfFjz8P2Vxe79v8y8OZJqhYfIyOCfV444qlksHXUnKOW5XX1J
 Jy5aG1tekz+msD0Gg0wqn+VxiVjfNqij+BHztbCIRiq6sFcJTh6jCwo0/6y0OBf9Jd11BveB4NJ
 cnmdx+Gc6TmUHelWVsYDEQtM40U6i8wdeyOGndqgtc/iaVX6HkEHoZQqtbaoljQEMB2OxQmcgLV
 kyQ0m9COo5Z5jTXke1JLh
X-Google-Smtp-Source: AGHT+IFqEHayzZIkr54iEVOBn+5T+fQKfVPCFG66STijX0p/hN1GM8e6deIuQgIy9EcRn/Ie8DoSnw==
X-Received: by 2002:a05:600c:1d0a:b0:43c:fffc:7855 with SMTP id
 5b1f17b1804b1-441d052322bmr33756225e9.15.1746542206772; 
 Tue, 06 May 2025 07:36:46 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae34e2sm13641958f8f.24.2025.05.06.07.36.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:36:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/22] hw/i386/acpi-build: Update document reference
Date: Tue,  6 May 2025 16:35:08 +0200
Message-ID: <20250506143512.4315-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Update the reference for QEMU's ACPI PCI hotplug device interface. Also,
use the possessive form in the comment.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20250504215639.54860-9-gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/acpi-build.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
index 0dce155c8cc..275ec058a12 100644
--- a/hw/i386/acpi-build.h
+++ b/hw/i386/acpi-build.h
@@ -5,7 +5,7 @@
 
 extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
 
-/* PCI Hot-plug registers bases. See docs/spec/acpi_pci_hotplug.txt */
+/* PCI Hot-plug registers' base. See docs/specs/acpi_pci_hotplug.rst */
 #define ACPI_PCIHP_SEJ_BASE 0x8
 #define ACPI_PCIHP_BNMR_BASE 0x10
 
-- 
2.47.1


