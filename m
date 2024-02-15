Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6CCC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag0h-000310-T2; Thu, 15 Feb 2024 12:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag0f-0002uu-6y
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:58:57 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag0d-0001dy-BC
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:58:56 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41223e0777dso5683345e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019933; x=1708624733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hD8QAEO8EbU5eNO1CRG3i0Yg3oXr277vzzBLMpE0y8U=;
 b=scyoVn6Ham4tZol/QCpB1xrrnDs/nLkG3EBS7sOoEp9dhb9kSY1TS6/EDoiNAiaW4h
 bwsKDZdQKMF1ywawiHVSU33SGBuHoVu/QVeY+EnMleVk34UtXyR7aoeczBV7SCSewqQQ
 6vetTpj5AQfMUr+lGrWXJw3VRfUceIn8RGgVgIOCu2sDKoRU1fCZSbCxTIz9PPSo/ba6
 VT5OM2CKTfwGU+cQ0JucKwzig29qOV7H1Y+ZxD7QUvS7Q+b7lHjQUa957zklMIGsE20m
 NE08a1aKeG7XsnfJGmabR0raWHaYXaxXdJt7CPJDyYdcitxXYGlgR4ZoRASJUcJNfAbS
 Hc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019933; x=1708624733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hD8QAEO8EbU5eNO1CRG3i0Yg3oXr277vzzBLMpE0y8U=;
 b=K7ywZj2YgT+Qcs6Bj36bqFS2x4HGPcad8GuRRgv+HKPbaYRM6uj1DTMgI005k2FBvw
 awwicLKW1nVlAsJml1nB6ijs4zt47xS+jQxUueAn0SMcI2Q3qCqPNN+4Na4vMrWL2ZwZ
 J0KRCsU/j0GcRrGhYrs1vWsFu8PGAPhY+iscJ75MhWUdrdto1bp4j9v7dyd9EEVufGXd
 R6ZwVXxr1NjEAGPnv+uq/FQz61S9XVxPayZqq+AR9OjvERjFwUGCaGaMZt6F4JWiHB7T
 +QwizROZGnAMATUN6SNeo3f/yJZLqEzFWQdLbNyNxSPmv4wW+IHHdOocW7ZJx8sB0cbt
 tj0w==
X-Gm-Message-State: AOJu0YyRXpCRk94wi96ijAufPy/wXPANNpfk6PPDU6jHUy4uFodCP5PM
 ypumDp33VRHnHKY0LDPyw6OdqjZRYzLHcXGx1liTOiimUsFkPNYbmGfnCddsemU++aDxzB643Xc
 BfN4=
X-Google-Smtp-Source: AGHT+IECSKHevyuxPS2fWdwcWQbw+hobfnQOM4Pz0SZC5xXj2UmIH7I1zf1iIFPf4Kph90jz4Xev/w==
X-Received: by 2002:a05:600c:46cd:b0:410:cf60:d857 with SMTP id
 q13-20020a05600c46cd00b00410cf60d857mr1896947wmo.18.1708019933682; 
 Thu, 15 Feb 2024 09:58:53 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 by7-20020a056000098700b0033b684d6d5csm2601836wrb.20.2024.02.15.09.58.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 09:58:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 09/56] hw/misc/mips_itu: Remove MIPSITUState::saar field
Date: Thu, 15 Feb 2024 18:57:03 +0100
Message-ID: <20240215175752.82828-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This field is not set. Remove it along with the dead
code it was guarding.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240209090513.9401-7-philmd@linaro.org>
---
 include/hw/misc/mips_itu.h |  3 ---
 hw/misc/mips_itu.c         | 22 +++-------------------
 2 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/include/hw/misc/mips_itu.h b/include/hw/misc/mips_itu.h
index de7400c1fe..27c9a1090d 100644
--- a/include/hw/misc/mips_itu.h
+++ b/include/hw/misc/mips_itu.h
@@ -70,9 +70,6 @@ struct MIPSITUState {
 
     /* ITU Control Register */
     uint64_t icr0;
-
-    /* SAAR */
-    uint64_t *saar;
 };
 
 /* Get ITC Configuration Tag memory region. */
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index 9705efeafe..f8acfb3ee2 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -94,12 +94,6 @@ static void itc_reconfigure(MIPSITUState *tag)
     uint64_t size = (1 * KiB) + (am[1] & ITC_AM1_ADDR_MASK_MASK);
     bool is_enabled = (am[0] & ITC_AM0_EN_MASK) != 0;
 
-    if (tag->saar) {
-        address = (tag->saar[0] & 0xFFFFFFFFE000ULL) << 4;
-        size = 1ULL << ((tag->saar[0] >> 1) & 0x1f);
-        is_enabled = tag->saar[0] & 1;
-    }
-
     memory_region_transaction_begin();
     if (!(size & (size - 1))) {
         memory_region_set_size(mr, size);
@@ -158,12 +152,7 @@ static inline ITCView get_itc_view(hwaddr addr)
 static inline int get_cell_stride_shift(const MIPSITUState *s)
 {
     /* Minimum interval (for EntryGain = 0) is 128 B */
-    if (s->saar) {
-        return 7 + ((s->icr0 >> ITC_ICR0_BLK_GRAIN) &
-                    ITC_ICR0_BLK_GRAIN_MASK);
-    } else {
-        return 7 + (s->ITCAddressMap[1] & ITC_AM1_ENTRY_GRAIN_MASK);
-    }
+    return 7 + (s->ITCAddressMap[1] & ITC_AM1_ENTRY_GRAIN_MASK);
 }
 
 static inline ITCStorageCell *get_cell(MIPSITUState *s,
@@ -535,15 +524,10 @@ static void mips_itu_reset(DeviceState *dev)
 {
     MIPSITUState *s = MIPS_ITU(dev);
 
-    if (s->saar) {
-        s->saar[0] = 0x11 << 1;
-        s->icr0 = get_num_cells(s) << ITC_ICR0_CELL_NUM;
-    } else {
-        s->ITCAddressMap[0] = 0;
-        s->ITCAddressMap[1] =
+    s->ITCAddressMap[0] = 0;
+    s->ITCAddressMap[1] =
             ((ITC_STORAGE_ADDRSPACE_SZ - 1) & ITC_AM1_ADDR_MASK_MASK) |
             (get_num_cells(s) << ITC_AM1_NUMENTRIES_OFS);
-    }
     itc_reconfigure(s);
 
     itc_reset_cells(s);
-- 
2.41.0


