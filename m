Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB317C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbiiA-0006Ks-ET; Sat, 25 Jan 2025 11:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbih6-0005NK-Tz
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:40 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbih5-0000pL-6x
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:07:36 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso19666355e9.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821253; x=1738426053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vwxPouX1MPfj+qZCG+Ip7+cwlRNTkTH48zQoUyHbOFI=;
 b=vwHy1xlGxP7b/EPE33Y8/li9Q3umNNUN06eGCcHrFsuRrUllqZrMwQGY1BQuBHDLQi
 pIROPhw9evbPePHZyeY5v5P9/fXoLyojXDhtNud6tr+4pj9uObaasUcpjoRCApEOC0Zg
 tIPapEfhIU3/oqBRNdQ7MjlBmeWRo3I3uqtKZTwJEs8urkFPmCmeOPaOSz5cFT0Y3Mwt
 yig5+ViYlkBsn0u/nLa1a/4fL/tZzhkRcgpXyOO9Qw1IRx60wfSgcuv/j0UAimJaHkPQ
 UE5POHrbVHrwyCg5m2p2MlWBfQPh6WJdn93ijdwlctClDQvOAfynPv32KSQATFEZxWqX
 HHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821253; x=1738426053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vwxPouX1MPfj+qZCG+Ip7+cwlRNTkTH48zQoUyHbOFI=;
 b=cbNYZAgkA3TVxwNd72evDLiTHIB2A7Epy+8Ts0B2MvQgrIjIA358N5TPsbHFT8pzVg
 DsuRH5wfQMOatQYcoU/BEdCObRc5PmB3MGXnMMh+td7rn/+1z/5LbNi4EoW39kxF7zLh
 zmzWe+mhmgl5fmkXrf0kyubWx5cmUduywjBGHVFWeJ/lqTKl6iX6ixcBtEQyBQ3z8ZIL
 YvzlxrcSLuvdsO3/ggWnNgn2Mue4Ce9QJD2sjxKbxhbnYdtMr2By4WdJNxuhhFKr/N8M
 zZ0Ep3OnkGistzRGcRBTMRqTVVmBUfDV1V3cyMBukhM7f9GfY7z2vGAijLeEMZkxI5IX
 LcqQ==
X-Gm-Message-State: AOJu0Yy8+J7sRuIQmiei2u4BB/mZoefFzq/yOFgyvifre1uQ4H7sySDn
 0rh4H8fx4NeVbp/rHD1fvZYjGDzulMy1K7VXAmeFeYMTSVEe0sxJkjrb15frXJbITnDhBXi7J9S
 aGNU=
X-Gm-Gg: ASbGncv1nvQVCGt70Zyb3N/LuXYclv/T0/GAkm4o8qXB3uLa3YQxLdcf9zsKl1RLZi6
 B8eCNmVkbhAe+s++xEgFjvL/UZjVNssEb6LFuw5wFFgLJmE0LVmWd0j5Ew9KmKVC4pAg64OD7aC
 M/wa6DFlwDNcs6BSGsbOuXl5NWDsduqKO65EUb+L54tUe2mPXkY8Cn6HDbaKUpThaYelW6vZKfJ
 8Q4ubJg0RcLCFqFXmSMTz1eoCZHjHnKANbw7Ic5iyYKBnpohTTtS75jao+Jtq6U68s57B37nyr5
 bviGhdHfnTM9AuETmM+S/gl2OPHYqZvF30C8pkwHy7nD6sB0YpULDGydFuWB
X-Google-Smtp-Source: AGHT+IG/g7VKpQ0gBoBlw4D7ZteRzDvKJuwDglZZfiZJj6vtZ0t+hazzSH4ku1B2g+xp7iiO/6U/LQ==
X-Received: by 2002:a05:600c:3585:b0:434:9936:c823 with SMTP id
 5b1f17b1804b1-438913ef6d0mr330481085e9.18.1737821252907; 
 Sat, 25 Jan 2025 08:07:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd48ae29sm67355635e9.22.2025.01.25.08.07.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:07:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 20/24] target/sh4: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 17:05:48 +0100
Message-ID: <20250125160552.20546-21-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sh4/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 24a22724c61..80a66e1f1d6 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -82,12 +82,12 @@ static bool superh_io_recompile_replay_branch(CPUState *cs,
     }
     return false;
 }
-#endif
 
 static bool superh_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int sh4_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -243,6 +243,7 @@ static const VMStateDescription vmstate_sh_cpu = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps sh4_sysemu_ops = {
+    .has_work = superh_cpu_has_work,
     .get_phys_page_debug = superh_cpu_get_phys_page_debug,
 };
 #endif
@@ -279,7 +280,6 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = superh_cpu_class_by_name;
-    cc->has_work = superh_cpu_has_work;
     cc->mmu_index = sh4_cpu_mmu_index;
     cc->dump_state = superh_cpu_dump_state;
     cc->set_pc = superh_cpu_set_pc;
-- 
2.47.1


