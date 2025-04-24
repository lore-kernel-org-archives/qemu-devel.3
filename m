Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4361C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kwt-000586-Rh; Wed, 23 Apr 2025 21:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwi-0004d0-KI
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:10 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwe-0005IK-MF
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:07 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2279915e06eso4597945ad.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456403; x=1746061203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMTFwuyzTM5DV5D1Qj0NNV6OmW0mRELjIvfKoj8LUWY=;
 b=LaE7ApI532dyxl0UvnysQXJyIY8MUWUcqFvFINVxxcQXdGixu69LylKgAFsiFiKHT4
 ggML9CL/biKRH3GUA3Hzb7lB5uKMXhmxnr/3XQlmWjNO/brhOXkMr2hUTj7Dw5m++RMB
 gSRjh4gt0VOpXmUrI3hg11/GpEjyeR9sPkv+SnEVco1EEFPIW1BvcRiGS+F+15Cf4ti4
 4dDdK4cpCdeQgRzNjAjSkLJK2ZLUpg+B6BT78T1iygFE/tXoUSOgjNLx/4BN0oNpFa3s
 zfPRmCKpFb5+JHWqOTpxddLWfUZ+GGP/OMQmMuSIkm2lUtDqMCzU4O8hneL/2e0OBpoi
 iUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456403; x=1746061203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tMTFwuyzTM5DV5D1Qj0NNV6OmW0mRELjIvfKoj8LUWY=;
 b=QIGEEbR+KmrJmJDOXUznD3NW8lVyww1PHZ2Z7EMsL9pckpYliBWNhwkiS8+GHDi1nN
 9nHOGJohFPaUxpavX1GNdJSG/3OLgmsSM4JPXOH2Wg2WkBonleggXHanZrZB8bbMJ5Wf
 Fef1VpidJYdDX63Qn7Sq8gr94W06IfdnA0FqozMeIJkk5ugMuUiZWYukCHSUmWm3UBRk
 MrLK367VtiMCzrEoOehUwJ9C1zmR9q31oQkz2rgDL3kpwN3qyGZPYKoEwbchuQKrq3zy
 HXt5kJnjpiERKSsk/ekSoJ7yBm0VDACItZ9WxQ01XX4DOQS9vibK8/bjwTdQIW2R3APW
 gPjw==
X-Gm-Message-State: AOJu0YxYxDqTssU76rLcc1F5ezvZg0aBnYbxqM9b+Ock4kve03hNGV4C
 y1FwTp02QzJZY3b3/QB1PwsP5AG39C5EF25NpOpMS0NMzRlAK1Xdwaxk0ZqjnGcmX605n0PLgWT
 4
X-Gm-Gg: ASbGnct2ot3wlWtFjzFv+LH31sSFVXlatE0IhS2qOspsc/eiw3GnSafxHYnhk0p/43N
 2Tea7iqx/xOdNcd2O2yWwnVPV/ChOxHxQnFBtz/5C8jX6yekFhPBY8K6AUxAUJjOy5Vbv1OtUNM
 IOLRfAAdwpftviQk3UPotSFqiTf+2CX6+6s3Fw2RkKAvo8wKRKkZlUQJFluxPL2sRa/ticVz9cm
 1maSSRNwkH1sYV3oo2G/rx9YcTJlOF0CZzl86Q4XE5a0dUqGiKCQ+4dnUBGBeRSEqwy4kW71LCz
 I1eUKC9pMSkREgaYy++qRRfr6jYWSlfVsaCNSocI10GVP4MUkX1sKdAMsZ15dPIfmF825EMSLlg
 =
X-Google-Smtp-Source: AGHT+IH1u50zo9Zr2IL3wJQGKsc4Hocwgak+as9x1ErlDozx1ZUiaQR7ZzZI9em1Y6y3Bh7BUYUN1g==
X-Received: by 2002:a17:902:f652:b0:224:e33:889b with SMTP id
 d9443c01a7336-22db3be43abmr10597835ad.12.1745456402642; 
 Wed, 23 Apr 2025 18:00:02 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 121/148] hw/arm/boot: make compilation unit hw common
Date: Wed, 23 Apr 2025 17:49:06 -0700
Message-ID: <20250424004934.598783-122-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Now we eliminated poisoned identifiers from headers, this file can now
be compiled once for all arm targets.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-25-pierrick.bouvier@linaro.org>
---
 hw/arm/boot.c      | 1 +
 hw/arm/meson.build | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index d3811b896f..f94b940bc3 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -14,6 +14,7 @@
 #include <libfdt.h>
 #include "hw/arm/boot.h"
 #include "hw/arm/linux-boot-if.h"
+#include "cpu.h"
 #include "exec/target_page.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index ac473ce7cd..9e8c96059e 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,5 +1,5 @@
 arm_ss = ss.source_set()
-arm_ss.add(files('boot.c'))
+arm_common_ss = ss.source_set()
 arm_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 arm_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
@@ -75,4 +75,7 @@ system_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
 system_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 system_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
+arm_common_ss.add(fdt, files('boot.c'))
+
 hw_arch += {'arm': arm_ss}
+hw_common_arch += {'arm': arm_common_ss}
-- 
2.43.0


