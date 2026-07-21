Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFB1C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6Bs-0005Pn-NH; Tue, 21 Jul 2026 04:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bp-0005O6-Nn
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:01 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bo-0005gd-9n
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:01 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so78316795e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784623859; x=1785228659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wyDVo0Oy7ludu4ybUH/QsUXKNrzdkD6NiRMRp1tTo+w=;
 b=IrgEhYhdmdDYr0sdgdmX2p32K0xFR4/SUiR9ag5NI1Qttt3R97QX4P1fJiKygR+Wux
 HXbqpKE6sIE/JqXV+sNsi6EX2NfSPAsNaVeiTUHuXKuN3MjWi3x+FiUSPKJkr1jst6pB
 2U4S4ZyMWchfj4dUpmRvcm476H535ayQI9t9fZ/xcAM2s2aEA1xQpvtDzMM1DVFv2RlF
 hQ6b2FMnMMR9r0IPa7EzxlFPstNJ+5HtTtcNqgk7ZLHd7oewKrWmV4Xfg0VxIQICQESr
 l6scDB0KoIUuQ+ric+aev0HJ7jVDVpB2A968iywFDHsGu9zA4aaDCEAyItBsRxMyelE4
 TqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784623859; x=1785228659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wyDVo0Oy7ludu4ybUH/QsUXKNrzdkD6NiRMRp1tTo+w=;
 b=cDRHU6pdBcDOwNz6RUkZt+2VzbXd5ERjSnHFAo29moYA95KEcsjCQzr9xK+1EgTHoR
 tI5TsyGwfJYbzv0sc+6tKQnt/hWjhBmtE8YFLdC06YTPduh7WXq5M5NW8haOkEUC686Z
 wqsCqeVlgJWhauK52gMRu59xffp1pfLoDt3W2e06I0eQNzwCVicliWAVKUATJG5ToaEh
 E+L8ZsNPeyR51qgA1zgrfCxP9rac/noRVLTgLNMFf7dcej7Yoi+hCuODdO4Qqq4Af/f6
 77GlpSsQSvr5yGuwOwtCPSHzmw1+UxIL9kBX1oAPiNUP4wHCedscqe28I/x9hPan/jSR
 0iDg==
X-Gm-Message-State: AOJu0YyqOAs6Si1yKw1RIZZ6SljqBKEYa0s1dYhZM2cvcAxuU6Rtxhsj
 mFUnk4o/NUs6vTU5Su+JM3uaoPkctCWnXPZh+8R/v7BLgMV5PRklDFky9j4cjzx86PtZEA176DC
 GSJM+Unz5gg==
X-Gm-Gg: AfdE7cmHu7a2E95ZLxmfqwVGr83H2gg+PoPWRiL6Xu2c80Y8Cy1im32Hk816G/j3cen
 k4vXCurmA/mPKO2kkrxnfF0PTAdu7algNoCVqD4mrXbOErtNC/eSVCHWJsMSO0mSHmT/+qZfyxL
 RwSi0Z0nUI2LVsp+ETJPMNCrsZbxaEScCtd7S5vg2ZWUrm1tAuHwlUN80LQBa4CG5bzoJVY6qXV
 egpIDq/oi04n5Rql9BsbXnvmlhTYdXPNb/F1WJPfvsbmvNSP4+rwXqz+oMcnnuPzmngxMuvRxys
 MF3vhqtTioDoz+qdI8PG+hkK+geyC0xWhaqITtO33q77ohkeAv6w2EL/JcVvUVZ9SxKtykgBRlm
 0Ah2CqeYipN6GvD9e1BtBlDTaeII0n6oyiJNjzwcp66JWJI+bYnqt8+X29o5xGcZic2pbxVZRpB
 D6G1brovQUTRa2QzVE5sNgESqivwnwDXj21MDh6HhLkgszXWov0+USk+LXBhtgBwyWyZO8+8mdg
 lgI6obOgRE=
X-Received: by 2002:a05:600c:4f12:b0:493:f0f5:f2d2 with SMTP id
 5b1f17b1804b1-4954a3d0ceemr210844225e9.1.1784623858648; 
 Tue, 21 Jul 2026 01:50:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c7desm68707245e9.7.2026.07.21.01.50.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:50:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/16] target/ppc: Remove unused helper_lscbx()
Date: Tue, 21 Jul 2026 09:50:39 +0100
Message-ID: <20260721085050.421257-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721085050.421257-1-peter.maydell@linaro.org>
References: <20260721085050.421257-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The helper_lscbx() function isn't called anywhere.  It used to be
used by the PPC 601 CPU support; we removed that in commit 005b69fdcc
in 2022 but missed this helper function.

Fixes: 005b69fdcc ("target/ppc: Remove PowerPC 601 CPUs")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Message-id: 20260709095056.1803725-1-peter.maydell@linaro.org
---
 target/ppc/helper.h     |  1 -
 target/ppc/mem_helper.c | 28 ----------------------------
 2 files changed, 29 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index e99c8c824b4..6b2d19a3ad9 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -54,7 +54,6 @@ DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void, env, tl)
 #endif
 DEF_HELPER_FLAGS_2(icbi, TCG_CALL_NO_WG, void, env, tl)
 DEF_HELPER_FLAGS_2(icbiep, TCG_CALL_NO_WG, void, env, tl)
-DEF_HELPER_5(lscbx, tl, env, tl, i32, i32, i32)
 
 #if defined(TARGET_PPC64)
 DEF_HELPER_4(DIVDEU, i64, env, i64, i64, i32)
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 119dc1df233..787ba2cdec5 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -367,34 +367,6 @@ void helper_icbiep(CPUPPCState *env, target_ulong addr)
 #endif
 }
 
-/* XXX: to be tested */
-target_ulong helper_lscbx(CPUPPCState *env, target_ulong addr, uint32_t reg,
-                          uint32_t ra, uint32_t rb)
-{
-    int i, c, d;
-
-    d = 24;
-    for (i = 0; i < xer_bc; i++) {
-        c = cpu_ldub_data_ra(env, addr, GETPC());
-        addr = addr_add(env, addr, 1);
-        /* ra (if not 0) and rb are never modified */
-        if (likely(reg != rb && (ra == 0 || reg != ra))) {
-            env->gpr[reg] = (env->gpr[reg] & ~(0xFF << d)) | (c << d);
-        }
-        if (unlikely(c == xer_cmp)) {
-            break;
-        }
-        if (likely(d != 0)) {
-            d -= 8;
-        } else {
-            d = 24;
-            reg++;
-            reg = reg & 0x1F;
-        }
-    }
-    return i;
-}
-
 /*****************************************************************************/
 /* Altivec extension helpers */
 #if HOST_BIG_ENDIAN
-- 
2.43.0


