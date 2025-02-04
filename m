Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938C1C02192
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 00:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf6ir-0000Ec-94; Mon, 03 Feb 2025 19:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6io-00009w-Et
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:23:22 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tf6im-00074i-Uo
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 19:23:22 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so4146668f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 16:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738628599; x=1739233399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ETuzJ6SLiQ/NiVSSl3xkPrhN42XnijAgudKaENxFFg=;
 b=hhG/7OZe/znQ5f1S7qyAWD4XACKBwXpdTucUHCSiGpEVqW751yn5jhTti6J9iAkoDc
 3luef1D8FvsoEy9AMlzbcqxPZW4mbHRhg2WiatHqlsYa9iVsjQcIapq2pMEGiQ9RRtID
 UwiKYHj0yocvH5h2V1X7ypAB1K0Yu4YDuXthYw7zfXtUqjJjY3NnsFQXS3oB3MDFvZgd
 lGZ4OLOvNlSzGLkrQ4lMz/ZcOgBTapg/N3nYHQLWex1QYEBe0KF9tvnhpuQFB9c9sq5p
 Y5bUNwHXcw3Ohtj/ALGd7De26MHytbcpQjroK7L7cmZmfTU5EsTp4IVlRHrabqzqQI+E
 6gaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738628599; x=1739233399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ETuzJ6SLiQ/NiVSSl3xkPrhN42XnijAgudKaENxFFg=;
 b=rmNu/j05tB9hwklJMWG9ttgPBslnPx4a2uzGSvZynawkgNTehjjf8AfTB1thXpwYMS
 fuN2rG2ko27KWLzkxItTzEFG9BI99mAPoqeTcGDwls8WhV4A+MGYI9z2XrIrBlZcyrEr
 RwU0sdTf79S1xbQdSDR3WmEjRqmg8fTaCHtXuOVZN7W8tFsa1PkrJA4i7Q213YMuG+b4
 yuzgdWn7f1nQOPnJnOuX0NvSuDKVVmykjJ32Ci1hh9T+dWVdpTjD7wRF6XYooNBNqx2D
 qdaLUv7MW+BAkksvy+3xj+Sztd4CYuAaKZlcwIjMMPS6WE3DwJYnVAAtazo1dYiPbZGO
 4feg==
X-Gm-Message-State: AOJu0YxmhFKNvzGf/qWtAI/rUDTLYJXgEHmO4ZS8/uZJuVcpgLUa0BNR
 A63XEmxN4UuN6gWCdky5D91oNLkEHCIFCoLMm2mMvCEv2XGEvjcjYqBxh0G+DBGRWl2EZUt9GiL
 uArQ=
X-Gm-Gg: ASbGnctFPru9CRxPfUUC14hACHLwL+qRfz/Epjmx0n3jNeBNt11x+7iD0NfT/cm5cQc
 sEubmFAHAjU5raKtzpa9RGHDEbYr/qqnvJcgihF4tJYkL451eSXGCvud/Sc7blNqBCU9MSvAQ2Z
 q6b+v5/o7o/9QW8qg+xfWI+lM+7gg3YinpGLZmw33B8CzLZL64phj/Za0PPzmiaSxDYW/KEYAxw
 owL/YDgHO8xo5Dherd28hA3MKyT1z51aX/HuTHC1Kz8we26TPkgW7/NqUZDc2JtqP6AQpvRtj1K
 gDdLa5YorGyqtEp827Bz1WfquaBHc9g+A22ebQIXUBUkNM5/qc7JTEzCvEBW7y6y5w==
X-Google-Smtp-Source: AGHT+IE5eacu+tscRKXYBvGC7D2HiLBrNH0amLlpLTUZJ+7YJSAfPVR1pLS83k8+E9AGhYYQnO6mrQ==
X-Received: by 2002:a5d:5988:0:b0:385:fd07:8616 with SMTP id
 ffacd0b85a97d-38c5167d80bmr20625537f8f.0.1738628599192; 
 Mon, 03 Feb 2025 16:23:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e245efbcsm168179175e9.33.2025.02.03.16.23.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Feb 2025 16:23:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
Subject: [PATCH v2 06/12] hw/arm/raspi: Consider network interface for B models
Date: Tue,  4 Feb 2025 01:22:34 +0100
Message-ID: <20250204002240.97830-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204002240.97830-1-philmd@linaro.org>
References: <20250204002240.97830-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Raspberry Pi 'B' models have an ethernet chipset (the LAN9512).
Since we don't yet model it, add a /* TODO */ comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/raspi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 1a6a1f8ff22..68332fba027 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -143,6 +143,16 @@ static const char *board_type(uint32_t board_rev)
     return types[bt].model;
 }
 
+static bool is_model_b(uint32_t board_rev)
+{
+    return !!strchr(board_type(board_rev), 'B');
+}
+
+static bool has_enet(uint32_t board_rev)
+{
+    return is_model_b(board_rev);
+}
+
 static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info)
 {
     static const ARMInsnFixup smpboot[] = {
@@ -304,6 +314,10 @@ void raspi_base_machine_init(MachineState *machine,
                             machine->kernel_cmdline, &error_abort);
     qdev_realize(DEVICE(soc), NULL, &error_fatal);
 
+    if (has_enet(board_rev)) {
+        /* TODO: model LAN9512 and wire over USB2 */
+    }
+
     /* Create and plug in the SD cards */
     di = drive_get(IF_SD, 0, 0);
     blk = di ? blk_by_legacy_dinfo(di) : NULL;
-- 
2.47.1


