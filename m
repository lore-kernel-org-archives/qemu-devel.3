Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F34CFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 09:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTJ7-0006ui-EO; Mon, 24 Nov 2025 04:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTFW-0004bw-3w
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:52:48 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTFT-0001gh-Ba
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:52:45 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477b5e0323bso26133435e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 01:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763977961; x=1764582761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uc44ADaQfZAO5yHzRIAGfCESDuHxn2hliuvpghcTObQ=;
 b=lVaehmsbdIJXMzIaF8Pt9rsCGkVDBa0W1gE6TbvrtZlDtJM3f8rbWs6L5ENrLMM2UH
 3NoUndyZEWXZmMF/QQ+8D/sjrJvOAcduXkhMRSeeyXsNmc7OtIoFcOpIwOROk9ZTrOQ6
 uyOugz97vM/d9/MrsbhH/in/ENWuZ9lTZxEFytVIVc1W+kPmWD4LpsSnkmA0X2F0+eck
 1gmhPkXwF1en3DKSCsFJjyBRjzOCQVObz61FWn4dq33mGbqhg2fAUXmr8mmYZx/724h0
 F+8wUSKwWafEQH7/30oTZ99Z3Fx8oJIeoVKCwxxRLAJGurrfV2ZsRHkVfv2nj1Y4VEny
 wmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763977961; x=1764582761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uc44ADaQfZAO5yHzRIAGfCESDuHxn2hliuvpghcTObQ=;
 b=XUSO1N89cRvxFyF06XozlZW+FudWnArhgh28McD3GrCWy2PRZMmpFprn+F/ass9S3c
 lXF9o3823+Ga58czEOsLhtvlZU/WaORmqzlWDzcsMCXlYJNWVUjCZY0iDBZ2v6knKvHY
 HOG3ThvFRbZpcTqEP//19dZ3bCaJ4AXIZgtgveMELjIXfg/8oY+tB3zm9KQ0f7oME2xZ
 BSu6EIi713Kazhg3zPsDD99NFeH+yadEAz1jPoMvm+sE5g9f7NKLMeDyrK2ZX8UgjP1Z
 JnTiOR8Bo4ZNMhxGDdesizo5NEit8xlVSBDqjpdA49wNIrQycP3V+nzKRT5F14yhpojE
 Kx7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZH3lTv19cS5pLFSFMFQZVYn/fAmLoYaT6itN1QH/b2Pr2zvXiGJYUN/+mbcNOmw16o0wR9L1vi+ns@nongnu.org
X-Gm-Message-State: AOJu0YxbZbnEM/oH4j6AKaOfPdLpGtsLCVfcuNrtyirzryv1RlrRkRef
 E6pvL0NvGVThU+GbP9ytD17nF+4maXU6Bx+oCbUDgkDafV8Fn6iUSgaQH2sImiPtz/M=
X-Gm-Gg: ASbGncuwLmBEqd+P4GZARaXsuFMqqZVOty9ZsAM61Kfe/WuoYd7GpPMV2VOKcsKVVtM
 Rqne7UUJgMhG6TwoqXSBwT9Vq6w/I3gZF5UBDxF53V5hnLPTLx6Oj/Q+3MtZ6RkFM7Me3+8Vb6h
 sK4XwueIPndqQ4jik3yKfD5xjG6UURXhtMNWSU4kFbxnOdSV7mAVLoHN45DyYiWzKtjsrBUAXMN
 qDomVji6h1kNt/LhZS6LLWo5xGwlBbzLChKfT7znZBgXJMQPayfywsDyTzPxUtiM1iANQKLR6f4
 rOwq/3yAXudbEHDL/WR+2lTJjnUJk+fMYWtmrgGzahOLiyUsKIrDobLQjb6lqCd37dmE3RBzcIY
 dDejeYazViU2EGzluYaGX7BftkNCEfZYXwDSO3ncZX/cjt22C96biHRsnUO50KwN/8PO5D2I05Z
 cI8LEW1c+1ZZrnGbSTLRDtmmr2bxpHGzK+Q0IV1H0rwUaVx82La+1AgpFJWd3K
X-Google-Smtp-Source: AGHT+IETD6vrGelvXPBL1ztJ5xzr3iLtn97NmN45wmYdzNSDKptjo554EOwzRXSTyvl+g3FG+XYI2w==
X-Received: by 2002:a05:600c:642:b0:477:9a61:fd06 with SMTP id
 5b1f17b1804b1-477b9ead384mr90687895e9.8.1763977961009; 
 Mon, 24 Nov 2025 01:52:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a974cdc8sm153352695e9.2.2025.11.24.01.52.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Nov 2025 01:52:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 qemu-devel@nongnu.org
Cc: Rob Landley <rob@landley.net>, Thorsten Glaser <tg@debian.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0 13/13] hw/sh4/r2d: Add 64MB of SRAM in CS#6
Date: Mon, 24 Nov 2025 10:51:08 +0100
Message-ID: <20251124095109.66091-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124095109.66091-1-philmd@linaro.org>
References: <20251124095109.66091-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Expand maximum memory from 128MB to 192MB.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sh4/r2d.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index f5bc7c46965..445cc9a246d 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -245,6 +245,7 @@ static void r2d_init(MachineState *machine)
     ResetData *reset_info;
     struct SH7750State *s;
     MemoryRegion *sdram = g_new(MemoryRegion, 1);
+    MemoryRegion *sram = g_new(MemoryRegion, 1);
     DriveInfo *dinfo;
     DeviceState *dev;
     SysBusDevice *busdev;
@@ -266,8 +267,15 @@ static void r2d_init(MachineState *machine)
     case 128 * MiB:
         sdram_base = EXT_CS_BASE(2); /* 64M @CS2, 64M@CS3 */
         break;
+    case 192 * MiB:
+        sdram_base = EXT_CS_BASE(2); /* 64M @CS2, 64M@CS3, 64M@CS6 */
+        sdram_size = 128 * MiB;
+        memory_region_init_alias(sram, NULL,
+                                 "sram", machine->ram, 128 * MiB, 64 * MiB);
+        memory_region_add_subregion(address_space_mem, EXT_CS_BASE(6), sram);
+        break;
     default:
-        error_report("This machine can only use 64M or 128M of memory");
+        error_report("This machine can only use 64M, 128M or 192M of memory");
         exit(EXIT_FAILURE);
     }
 
@@ -365,6 +373,7 @@ static void r2d_init(MachineState *machine)
         address_space_stw(&address_space_memory, SH7750_BCR2,
                           (0b11 << 2 * 2) | /* Area 2 Bus width is 32 bits */
                           (0b11 << 2 * 3) | /* Area 3 Bus width is 32 bits */
+                          (0b11 << 2 * 6) | /* Area 6 Bus width is 32 bits */
                           (0b10 << 14) |    /* Area 0 Bus Width is 16 bits */
                           0, MEMTXATTRS_UNSPECIFIED, NULL);
         /* Start from P2 area */
-- 
2.51.0


