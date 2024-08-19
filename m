Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58169C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgBG3-0006OM-2R; Mon, 19 Aug 2024 18:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBEP-0000pO-Oh
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:14 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBEN-0000jf-0s
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:09 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4281faefea9so37930355e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724107925; x=1724712725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWWwpfQxRAAbj0joei2mdKLyEuAn6gjZiKaYfsPccaM=;
 b=At6IbjmEJ25Pv1TJEUlw3Sy/P4BWMFCMeXU3ttOV0T52VUm7GP6Fy/wo2qaK4JXebw
 yyZ6/7cQw7onkWvNdadNnJ8aW/ARtre07vIFR5t7JSnPMRfsG04DY5nN6Hrb2VxgqpIF
 0PWfYYka5HvZAqn7eBEoz07/aGKCbnFAGFNs46IBN6Dx8A/aC3k8gTEhLTZu2G2GCzhs
 rcZrKmxu4Y78I4zxt2iv12t4+epXL6sygnXdQbPq7c95h8WJlP/yTued/atGtKYKhLT+
 wM5pVaCAzZQ+XAMD3qCksgXyXjp4ajs1wBmU2DST+9oRpPQoH1d47sb6k9ngmdHzmDGW
 oIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724107925; x=1724712725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EWWwpfQxRAAbj0joei2mdKLyEuAn6gjZiKaYfsPccaM=;
 b=BlpwPHSjRGxsl09enGX3fYHehma1JGBMYrLRBD6802P/7wi63KcPKI0+T0eZPGEFiW
 o+mmBncQcVYtr6QG3Ne0FOjq1eM9v42mekwjV41LWqb34DfDJJyL270CVYs0Y2YAhPPS
 HRDCLyORFzZFurBpdMWi5xfzDUet/yo9M8h5AYAVGQtaBkIFr2vMTdWS3GHFkLq7hQZY
 JZepPettnvqVJmkk+DX30T1rZBLZg0j9Q1GeYykTuEkEm/BcEpNvsFTTx1m3uC/eyOcE
 7sPROPt1OT0xv4KEx4nvJxgylyTasSm7VTKks2Cgh92v+Doad/zu91RQqNYOd4/F7Lge
 6ncw==
X-Gm-Message-State: AOJu0Yz0BtvCU0ifdzo2kLBMeyTajw/FK3aiTvAm0379CaUWhPcwcJIo
 7blvELdtX6iO/1NAQRTUak2Ffem5U3DsfRpSpZn4wmytoyKFYaMN+25Nq0seNaKUDy03QsX+mBq
 uiOo=
X-Google-Smtp-Source: AGHT+IFzDFbCIAxlgQLRx00KeagIgsITOuejAYij0/ID88tPUOz8tw6CuQSnEpwqqL3Y6fyrBoKCuw==
X-Received: by 2002:a05:600c:30d2:b0:42a:b0a4:8828 with SMTP id
 5b1f17b1804b1-42ab0a48880mr26857165e9.37.1724107924923; 
 Mon, 19 Aug 2024 15:52:04 -0700 (PDT)
Received: from localhost.localdomain (88-178-97-237.subs.proxad.net.
 [88.178.97.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded180dcsm176905445e9.4.2024.08.19.15.52.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Aug 2024 15:52:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Johnathan=20H=E1=BB=AFu=20Tr=C3=AD?= <nhtri2003@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/20] linux-user/mips: Select Octeon68XX CPU for Octeon
 binaries
Date: Tue, 20 Aug 2024 00:51:06 +0200
Message-ID: <20240819225116.17928-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819225116.17928-1-philmd@linaro.org>
References: <20240819225116.17928-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The Octeon68XX CPU is available since commit 9a6046a655
("target/mips: introduce Cavium Octeon CPU model").

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1722
Reported-by: Johnathan Hữu Trí <nhtri2003@gmail.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240814133928.6746-3-philmd@linaro.org>
---
 linux-user/mips64/target_elf.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index ec55d8542a..ce6fb6541e 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -9,6 +9,14 @@
 #define MIPS64_TARGET_ELF_H
 static inline const char *cpu_get_model(uint32_t eflags)
 {
+    switch (eflags & EF_MIPS_MACH) {
+    case EF_MIPS_MACH_OCTEON:
+    case EF_MIPS_MACH_OCTEON2:
+    case EF_MIPS_MACH_OCTEON3:
+        return "Octeon68XX";
+    default:
+        break;
+    }
     if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_64R6) {
         return "I6400";
     }
-- 
2.45.2


