Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95F5CAC59D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya4X-00035g-TC; Tue, 16 Sep 2025 14:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4V-00034z-SX
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:32 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4T-0001au-Ph
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:31 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45dec026c78so58632485e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045988; x=1758650788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=81pXE1kDQVjDPPfH3enW9tfmeo8/1W7sfykAV4zpEFs=;
 b=Duo4Xph9P8dB94M7JP3EYvNJQYV+eF2Cqa9GOCsek7DYZVT8C/97Wbabe4wo22jxQO
 5b1U/RZW1pkgsxpo+CJ5eMqPWph5JXM+McWipLE+qUMy8FlPh8iXHlbjEaz+j3GWCFVD
 v8hWeaFV/466BUOfbm3XJhMqFnZCEQC9iMvqAeC4jS8SBND46dXTBXavDXfOSA23bOXF
 tKxwKDhkp2ZCEl/fH82VIFp3fEmXNA7XgLUSe5jdw6vMJmHMn6IYMufsf+lM2axtesfH
 3jQO8DjQTw6LOac4gEyMeHw2rHip0EBwEbnFwTeXTvqFoVPXnFmQv2kPw5UlRqRsvixj
 Gt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045988; x=1758650788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81pXE1kDQVjDPPfH3enW9tfmeo8/1W7sfykAV4zpEFs=;
 b=orDqWXn/Bd6fboGtv4IkN7fU+vO/Nyhl70y/mAp0gfOW84e12pZ2ba2UVsyQhX6WD/
 Cekc6rQ5dnXNNP8o+kO6N7t30Du1i7YopoqBW57YHxWDyvFME6khiEzoiY7OnHIx8KxT
 AMOV/fW0F3kWBwBJE5QGPns7bLJO16nqpycBTf7Ok7xAkfA/+ScZTjmaM4lypis81R7G
 L1NRnuLIsm1Bk43dH8MupNgBhNJXzDk2dDqbWdiXkYJ/VzF1uN9I8V/iahWeQZq+97Hx
 zvGixhCzq4AOMsWmggerq5b769XHkXiWaKb8RQp3cdOoYrrdodHI2eTD8duu42G+Ir3B
 40Qg==
X-Gm-Message-State: AOJu0YyJiIYAr3o/hff+ht/CXJMcjd0BcQ5DcS+AdJKJnXrKoNuQN7O/
 h1b8tAgTx2GAry4Vjw216PrHJ+fEp++4SDwC0wzMrsgqeTsBaSYcF5AMxuY1zaI7wMG1YMrgbmm
 26XQr
X-Gm-Gg: ASbGnctwB1v4feEYVjJNiTcab9OgV3z7ynqGuz3c43yCGEVfiJUw1Qumk9X2hFfWODM
 oUvrjRNPXGH195SYaMgpMXetEoGDlM45ecrkS2qgiQh2DYHYA68reDZyAtMDggRBoZF2xuthGso
 B77TNN07f1PpNLvH/813uOLN98KK56YGSXj2oE3XYa3+ReOn0T+4ackzIpwEC0wRE9mKbwnSi5L
 ABDRJ/cydCa6DOWYEV+eyyvIXu6cOZ6NkoZTWVMyEc3b9dnAKhOsgbJ1BhGUAM/Vqi/c33ZZakV
 MrNB07//wr+fVmGvXhK0rlxPYzoKGVSHePeBZ9nHJhtXEc3ctQEiPzLdlkQXeKi5wcdbLkNigMG
 XHTHgo2KsAV5iiCgKhDhe/6HaaBOr
X-Google-Smtp-Source: AGHT+IHuQGlsxLMbpaL+EqVM2QX50MEwqvKvApkrj9WmAGhTEMnKjhUDKB2tUdOV5tKszyJBPgOTnA==
X-Received: by 2002:a05:600c:458a:b0:45d:d1a3:ba6a with SMTP id
 5b1f17b1804b1-45f2218d97dmr179878095e9.33.1758045987756; 
 Tue, 16 Sep 2025 11:06:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/36] hw/arm/raspi4b: remove redundant check in
 raspi_add_memory_node
Date: Tue, 16 Sep 2025 19:05:48 +0100
Message-ID: <20250916180611.1481266-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Osama Abdelkader <osama.abdelkader@gmail.com>

The if (acells == 0 || scells == 0) check is redundant in
raspi_add_memory_node, since it is already checked in the call
chain, arm_load_dtb. Also the return value of the function is
not checked/used so it's removed.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20250902200818.43305-1-osama.abdelkader@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi4b.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 20082d52667..4df951a0d82 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -36,9 +36,8 @@ struct Raspi4bMachineState {
  * (see https://datasheets.raspberrypi.com/bcm2711/bcm2711-peripherals.pdf
  * 1.2 Address Map)
  */
-static int raspi_add_memory_node(void *fdt, hwaddr mem_base, hwaddr mem_len)
+static void raspi_add_memory_node(void *fdt, hwaddr mem_base, hwaddr mem_len)
 {
-    int ret;
     uint32_t acells, scells;
     char *nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
 
@@ -46,19 +45,16 @@ static int raspi_add_memory_node(void *fdt, hwaddr mem_base, hwaddr mem_len)
                                    NULL, &error_fatal);
     scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
                                    NULL, &error_fatal);
-    if (acells == 0 || scells == 0) {
-        fprintf(stderr, "dtb file invalid (#address-cells or #size-cells 0)\n");
-        ret = -1;
-    } else {
-        qemu_fdt_add_subnode(fdt, nodename);
-        qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
-        ret = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
-                                           acells, mem_base,
-                                           scells, mem_len);
-    }
+    /* validated by arm_load_dtb */
+    g_assert(acells && scells);
+
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
+    qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
+                                        acells, mem_base,
+                                        scells, mem_len);
 
     g_free(nodename);
-    return ret;
 }
 
 static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
-- 
2.43.0


