Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA26D59D69
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFM-0005GN-Qa; Mon, 25 Nov 2024 14:59:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFI-0005Bf-Q0
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:44 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFC-0004rZ-1D
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:44 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38231e9d518so3171520f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564776; x=1733169576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EExZMgepRcWmxIXjjA6QAMdeM+PVS7qSljKvbhpCK2g=;
 b=RmTDz9imuVe5UtgC8SIeKmKaxnKorqRey1D5rliAOoh8zRYuChE7VkDhnwr2PCBBD+
 P0UlaCEYFPv8JdcgGGM6EDqaMTCIH9vbTyC/LZwDGYSQ4CYoJKPAR/ZfvPhMTtrmPHiK
 kbGy1uyu5iP5YGIG//5wjv1/yiKVKuHBBMr3/4RKue0jj0d3mVGGeY0FGyxsIexK9TzW
 Ru/cd/fj37JSMAS3T4Z7FljGGvz8Draxgc7Ae8O+qIqOEBfEm2eSVjgV0S5DZ/HDjywE
 1U4GI2PPjtBhjrDwu3oa44yFo5WB9Gtamvhqs+1ufeyGEDvhHLcSNJDe7IOs5ubnuacD
 PPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564776; x=1733169576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EExZMgepRcWmxIXjjA6QAMdeM+PVS7qSljKvbhpCK2g=;
 b=jEbUFbORlkqs90B21GQyBQuB5FfBQyyDwSxIAoz8RJITrCe51h5ekjNQDYGnwApwW2
 mBmycCioa1oKAZ4hkzvOp59OQmA712HudgCmVU6IT6S06STeKBf6URyI+SbOZQpk/P84
 dRGtmSEl7GB0I3tYtjfaiiiDU0gYppNL+DEQK4LVFoCg+yOzpG4XUT0hRpPDCCLx3nKk
 SLL8++P/Pu/lafPaOvJQ9j6kgEzh6R2JX6rZ1Y8nZq3mDKVU1xjMkH82MzT/MB4WqMkV
 ohelvZYkqcox1yF5okAItwW9M54cA1X9BVAiWHsUkjnd2RBxNuVEjDoahXuFUYWx88Wh
 UzOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJuIETjkotUaJgFrdqPAjRXC8UBPpcGDOMOKBbUhoJiT64OiVjjt5AwGnXK49Rsp0AmGI9Gg9wJIKx@nongnu.org
X-Gm-Message-State: AOJu0YxcZBDnjWQRWbBHAfEkgvQEgNPBz6UOwwZkXzbkSanyjQfXbROY
 zigWe8j8vjS6edhulK8UKvpuDsGHs8Ll6t2DJgArJUChCY88qN+vJrCfkomDcXk=
X-Gm-Gg: ASbGncvBwPBQ4Rf6Vtd6d1k59SWKW4gyUi0XnmdqnCj/WxU+iBFQTuM+FzUsptTKkjY
 igO+I91tp7LH7vXbSyxPyViUCW+7Lm41HFdf8s6LCB7Cy5/x1Y4OYL1+rKNy57Aw7BG2hDabEYo
 5OLERDRFMZOmo/g2NbxGwmhXkEx9jCKaSprpPLsxvYVJxk2++BkTsg3TG+3UTrDdm4Oa30YrqpO
 3/btftVDWeiQ/Hf0x5v9q2MCzXjufM0TpQNSqRVslIQmIE4x7GwGWnwA2S/4CdbLoN5
X-Google-Smtp-Source: AGHT+IEpRKX4vqQ5F4ReAVoyjQEr4k+dgtHCLaUTopY3J7lBIhLeQk4UiEwxtDtCCt9+elRt/DkjZA==
X-Received: by 2002:a5d:6dad:0:b0:381:b68f:d14b with SMTP id
 ffacd0b85a97d-38260bc860dmr13424465f8f.45.1732564776596; 
 Mon, 25 Nov 2024 11:59:36 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:36 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC PATCH v3 21/26] hw/arm/boot: Load DTB as is for confidential VMs
Date: Mon, 25 Nov 2024 19:56:20 +0000
Message-ID: <20241125195626.856992-23-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42c.google.com
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

For confidential VMs it may be necessary to measure the DTB, to ensure a
malicious host does not insert harmful information in there. In case an
external tool can generated and measured the DTB, load it as is without
patching it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v2->v3: new
---
 hw/arm/boot.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 4cf7dd5b4d..20b3071339 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -523,7 +523,14 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     char **node_path;
     Error *err = NULL;
 
-    if (binfo->dtb_filename) {
+    if (binfo->dtb_filename && binfo->confidential) {
+        /*
+         * If the user is providing a DTB for a confidential VM, it is already
+         * tailored to this configuration and measured. Load it as is, without
+         * any modification.
+         */
+        return rom_add_file_fixed_as(binfo->dtb_filename, addr, -1, as);
+    } else if (binfo->dtb_filename) {
         char *filename;
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, binfo->dtb_filename);
         if (!filename) {
-- 
2.47.0


