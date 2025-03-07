Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEADDC28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcsX-0007UF-Mm; Fri, 07 Mar 2025 13:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsP-0007Rg-Vu
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:54 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsN-0007lh-Np
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:53 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2feb91a2492so4019101a91.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741373810; x=1741978610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6rq6CIIqovi+rqTbWr+nZgRpCqEfphmlSslf2GR3LU=;
 b=ApNry4HTsE4L5IdCITjCRkk4QHvKn5RWgFtJV+7RXL79FlqWTkPTk88rEVNsGNu2Zw
 LXcyolFnOJiGJqKBFzpcqsoAR9je1LjjsoRYc9JAHvzCSQBSgP25b2ynf0uafbOaZeJB
 I9Eh4lSTMmhDovl2mIcdyF4QbnweHAbPPjByXIL/Grv4qbbq9rzlhny2hGxfaPG+Gpz6
 zfPuWzpo3kccyP5rrxGCneOQwoCXRZ+TpY3g3Q9Ad1Lm+5qG6vgPA5FQknGYrjgPz/Y2
 v20X7qm2ySO4gAcij5IjxzzUS24KZUyrVW2Frz2kW1ctrK2Xksxw1SJTBuKyAhiPxX3O
 f+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741373810; x=1741978610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k6rq6CIIqovi+rqTbWr+nZgRpCqEfphmlSslf2GR3LU=;
 b=UMBgtaAMes1YNtZ2h1Ge6uiXLjbD7KcWSb/ElH751nbl98durYsCpOBnQfYTcSx31F
 5d4NEXcUKBR2U8cDp07d6pP9E7JQ7ATgJsMEwEsLO3zzcu9VeWg30iFbV6yyYAOLjFiT
 Z3t8SdT4UP4jeD6JT4R8BXN15bF1RvCjFUsySxcVGR88+xOderTwWChRMyLc/v7acl4y
 Im3VYaJwNNHuNYKbhcQGyis7mr5LMSld+UAJ7UrXqdyfjuYotF2w65R1IQfcrkfwI7jZ
 vg7RLHckckVswbN3QHJ7zBmGmNT0mjj/G3nP8UOiRoJtZe/GkaF/B1z0NFeAeRl4bn3c
 0Ong==
X-Gm-Message-State: AOJu0Yx40Mi4E3twn8rdIQE64sJQ4Wyqb18c8CQdRsdYPPjEO1aD3dHY
 +y5D+7egTny25B6aCZIYsbnUYwAYoV0X3ytmuXE/KNnxbCO0N9VxibtNDA8WKaYuJoqRLxOQKax
 e
X-Gm-Gg: ASbGncs6tbIt8WQJim40AkZ43r/xZrhwUeeNcVYnE4KP0k1F0WaBO88QWCiPSaNsfed
 xD/+LHgMGu5QeTcxL5apW7P76hUDFcHjE0uLeS+/CuTtqX7pBgKhi22wwkS88Hsudylf6h5UhZI
 Icn1n0O/x11oJ4WPmdpL5cHkKVv28QSjeDoLwBUX1sWiBw18MluLadK4S5pTizSrIPgZAFtbSJF
 bLKEbnGc/L1e3DuMxmjvFXOU9mSYJEcPx9dxnuG0GdV7YuzNha6Xbk0sHi0uqw7uA4cjWr4w3Ba
 uLumFKe92LCxwR+goZUdeirx3+IeVCgHXZDc6sdGKKg1yJ9cEkmGC8/7VHi5vvdesdWYMsq2/+k
 3
X-Google-Smtp-Source: AGHT+IHm3ACmK48dcxvecCMc0q8ObbimEvoFT+PEBg5oQDTvsotjyz6ve+I+ZO6Vqa6s1AQ0+tMkVA==
X-Received: by 2002:a17:90a:e7c2:b0:2ee:c91a:ad05 with SMTP id
 98e67ed59e1d1-2ff7ce52479mr6405940a91.3.1741373810325; 
 Fri, 07 Mar 2025 10:56:50 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693534f8sm3391917a91.17.2025.03.07.10.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 10:56:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 03/16] exec: Declare tlb_reset_dirty*() in 'exec/cputlb.h'
Date: Fri,  7 Mar 2025 10:56:32 -0800
Message-ID: <20250307185645.970034-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307185645.970034-1-richard.henderson@linaro.org>
References: <20250307185645.970034-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move CPU TLB related methods to "exec/cputlb.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20241114011310.3615-14-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cputlb.h   | 7 +++++++
 include/exec/exec-all.h | 3 ---
 include/exec/ram_addr.h | 1 +
 system/physmem.c        | 1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index ef18642a32..6cac7d530f 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -32,4 +32,11 @@ void tlb_unprotect_code(ram_addr_t ram_addr);
 
 #endif /* CONFIG_TCG */
 
+#ifndef CONFIG_USER_ONLY
+
+void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
+void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
+
+#endif
+
 #endif
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 8eb0df48f9..f24256fb5e 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -486,9 +486,6 @@ static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
 
 #if !defined(CONFIG_USER_ONLY)
 
-void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
-void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
-
 MemoryRegionSection *
 address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
                                   hwaddr *xlat, hwaddr *plen,
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 94bb3ccbe4..3d8df4edf1 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -23,6 +23,7 @@
 #include "cpu.h"
 #include "system/xen.h"
 #include "system/tcg.h"
+#include "exec/cputlb.h"
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
 #include "exec/exec-all.h"
diff --git a/system/physmem.c b/system/physmem.c
index 8c1736f84e..a6af555f4b 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -32,6 +32,7 @@
 #endif /* CONFIG_TCG */
 
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "exec/translation-block.h"
-- 
2.43.0


