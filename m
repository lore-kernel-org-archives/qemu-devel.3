Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55ED4C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIed-0000KI-3g; Mon, 13 Jul 2026 11:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeI-0008S7-93
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:50 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeB-00017h-Ts
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:49 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493f4638f4aso394045e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956762; x=1784561562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LsLbQ+QRPhQlpy01lQawniYUzJdZ1vrNpWmjnr/ayAY=;
 b=R+C7lEVBSxSvDqH3ERj+4dyyWVGrRB1LkvLyE0su7+9lUksRfiO37EB3iroya43UIT
 RtoSrAwwxFsm48UMp4tzpRq1e4SYSrjyDLyBynF4YoXMG4DpyUtB8mXLFiEwH+etPmqc
 xiIiZA4jdg+B67t8tLKeZF/ILK/OfFTrGtsmxzolR+UB2Ir8JqtErrle6UTQ8MXnODw8
 9WUYYEKu7zrEVBAsugWZgp801UaODBUynGh16OL+dLN6nBhp+vRUH9O0r0Y2hnM99Bly
 /gVcWC8fw18/KRS1EBU+9ZcMFNSmfHBsCDOexjO8blGwXeAl3t/vyJZtYrf1fC52+w+5
 YEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956762; x=1784561562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LsLbQ+QRPhQlpy01lQawniYUzJdZ1vrNpWmjnr/ayAY=;
 b=l60uCw4iRfUmAWnHPmiMyPo4Jni+5ccp2suee6QQGQ0RY50x8KE8peOpBuqhP3XOGP
 Uyf4n/yZ1oN6jYva0vegLsZAfOBPa12WXn/a4zSmag6GEHu/GDxmGrn+jQ41sqRGt4aB
 nzB8tKB0hiBwO5VOQzAIgzpTtqfBQqvh31ORMPXQAXg1BJUkCIBVw4xYsKglWJEinKWu
 S0ZL5pyViRBg28EwKjxun1lZ0vDU7FMdPbSKkQd2ggn+7wx2Gf9+N5KGqGt6KbZ4wCJU
 Pr7foufN3vnNMwLpg3R9njnxS8YSNctNy8OKQEynsKhdYuNTgGykjfY39EOx9FpcuOFf
 4Mrw==
X-Gm-Message-State: AOJu0YyxKmVxbq/YLmiJZNQX8vO1ZKWujGboLNgkYYXVE0nnFNaQXo6G
 DZuY4PuucMwKZkmorLNA0mlxyvkRfV4F+Verv/l5Knfa1xes01onhQJYuPAnUpKWPtQW5ZWE9PA
 kF4NVxQzlzA==
X-Gm-Gg: AfdE7clLdlkQZ+jfwvy72z7AmPtx3WhY7kxLFQThjQzPATFPsxHB3CZJ3WJBejdslvM
 kO8pIhMoKKDTpzizoSGtH21hfHaVSjlr6rbFO0kyQascOuWkXWt1oyOYkgMoWg+jRx8vp0VqloA
 XwXYMWBJ5ej9fta3fCRpw2pQXqjCyUvid+3lMOHxRQeQkGyfgdJjwYlF6/pTKBe1GkmFLvgYrRy
 HPiw4nVfKFhlMK/0d6rAePdxIkKVIfulMknGy04tevrTrmf/BV0KVxWPWoG2tK/aqtL9k1/v7uw
 ZVD7crO4ImERYlxMDbGgD5dfxNNvncOLycSXWO0JwsErJaNw0n+hDFEB1iomkOrYHtQsZk3As6B
 SRpJqjxMNzzFDbqXgF2LvzV+Wq60EM4ZJLdUWM6ju5E/UDxebAhUimSicUwD/g97bhnfp0Kz9gW
 6clwLLFShhqxQbV2itl5+k73mBVoH868G/LNqiz2PPfaz+f3N+SD7xAp4mGaWtTHet0CtRi16Uq
 D/pRVsHMiSOMjOhGgx+nQ==
X-Received: by 2002:a05:600c:310f:b0:493:d115:d835 with SMTP id
 5b1f17b1804b1-493f87d5800mr98491115e9.8.1783956761803; 
 Mon, 13 Jul 2026 08:32:41 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/26] hw/arm/smmuv3: Enforce alignment of L2Ptr according to
 the span
Date: Mon, 13 Jul 2026 16:32:14 +0100
Message-ID: <20260713153233.3391818-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
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

From: Eric Auger <eric.auger@redhat.com>

Spec says: Bits L2Ptr[N:0] are treated as 0 by the SMMU, where
N == 5 + (Span - 1).

Let's enforce this alignment.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260707085028.165557-6-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 9008ba7acd9..ed19536a4dc 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -728,6 +728,8 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
 
         max_l2_ste = (1 << span) - 1;
         l2ptr = l1std_l2ptr(&l1std);
+
+        l2ptr &= ~MAKE_64BIT_MASK(0, 6 + (span - 1));
         trace_smmuv3_find_ste_2lvl(s->strtab_base, l1ptr, l1_ste_offset,
                                    l2ptr, l2_ste_offset, max_l2_ste);
         if (l2_ste_offset > max_l2_ste) {
-- 
2.43.0


