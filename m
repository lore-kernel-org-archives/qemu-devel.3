Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C25C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIec-0000GB-8M; Mon, 13 Jul 2026 11:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeC-0008QP-5m
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:46 -0400
Received: from mail-wm2-x0b.google.com ([2a00:1450:4864:31::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIe8-00016c-Iw
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:42 -0400
Received: by mail-wm2-x0b.google.com with SMTP id
 5b1f17b1804b1-493d43b6c28so178185e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956759; x=1784561559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=39AA7WPmxRp4YCKAHA7xgB02rdXN+HLANX0oQbIqL8E=;
 b=xId33aINYE/AOeGHHLuj6mGYwhZC5wRWJRFARAoZKibhdLClFnbKS6vukqso5URmYL
 phhMs5vBH2+eGRfNUBDUqjEEGEyd7rISBNJHMdlLek7AG6Dane1detH6X3s9he+DX2Th
 7yD9Tt5DrsQ6oAZ/3iWkrxK2bEvr5V8R2xlZ0lvO+BhLJtGGm1B3iIUlZQ1GpWpQn3aj
 5ZJztpOjl/rgHU2R8DzoBNe2QlIgrVdEXBhnOa6jLdpI3wYR74wHAxkQpsDpz0Wa2DyM
 0ZDvxfxbiMKtuYvE7PnUQ/jCvzzQg7ESYnZ/7aOV9pQ9cE3icNIYz9xcLCcSxWOK/FZk
 CXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956759; x=1784561559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=39AA7WPmxRp4YCKAHA7xgB02rdXN+HLANX0oQbIqL8E=;
 b=SiDwe3RLeWUcETE0v3BlBHSFXxgXjCeTxjMYH1j0FjWk7Mh/NEwBcXfJZe8hk9PSek
 TWkCpV6W8awEyFr08N0Mk49FNeL5gvDVRNyaA4PnRXq0Cxt9kC5C9HBAUx77h+bFiiBe
 VJzZ9tNip6q+2vMmG4qc2vntkYYmNoQtK1beY12bbQBA3blmLi5OlFO/EgnoanffT+0U
 gA5tqPyEULVtNoiHTVgCZO866I4mzn9XBx1QOEvKQq+nRDFeEaifME+FDlBhPxFbHVPP
 oevQKagbN2BIt/PGIZxDFPBx2QDhTLuLNnbBECy7nKcM2gmk7JAdbETjbqBDJGuR/Vrp
 Gy+w==
X-Gm-Message-State: AOJu0Yx1emr9XWzWyaKGW5VCiN2CItiV8yLpT+oaNPLch8e4ARoIYp76
 3UZfMaEQV9AwdIpvAyBy6as74CWGjxQm3lI0iqTxBW5K21q0I+QjgJgEQ1Q3BPQrHkBVqxgC50Z
 wAeETQbqyixPE
X-Gm-Gg: AfdE7cn5Jv6+JE3idnY5yowNZqvK6Mlw4siIy6l+2lcqTDK9MjGkQLMfp9dpqc80zeY
 u1Vi9ShTsIP88aWxP9s5cuvKHsw5xhVnDFike7yjW9Q/r1d4bAOEpRydC+dF+k/IqaHp4Rbztpz
 AkGH1jYOtfgewuo1YL+769rwoa67HBQBrLGocz6imdBu02D8D1G0gXMPZpbF4lnN/ToG1y3cof9
 vs7AgW5M0r6LfDaB34u/3EPhj9LP7VCJNAXzk9UBD8LnQPPj74XaUjLrSESawapaJac7RvsZdpP
 i1uS8ylqANcCfjl7+dfzy1EyYBJ2yj4TQBktuPL9RHz6jJiz05hCQAURNbu5wqegd/PNtz+3pCU
 bQ9VT3rHYcisuMLOW//8468o0fyEvxbLV5xIYpL0LRVqeEtSHFrFhhYrS94CJfz/HCUjfU+lR2+
 aLyxXdPmgBeBspduJQ1a7BtgSFLBRCDd1C2zaXj+uHVIlfOOmzIHhv5rYVczw1lkLTSR8UBi95U
 KzulpS8e0TCJ/YeE2fmrQ==
X-Received: by 2002:a05:600c:5489:b0:493:e97c:216e with SMTP id
 5b1f17b1804b1-493f8851d4emr98418335e9.39.1783956759112; 
 Mon, 13 Jul 2026 08:32:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/26] hw/arm/smmuv3: Sanitize SMMU_S_STRTAB_BASE_CFG.SPLIT
Date: Mon, 13 Jul 2026 16:32:11 +0100
Message-ID: <20260713153233.3391818-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x0b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Currently the guest value for the SPLIT field is not checked.
Also the spec says that values different from 6, 8, 10, respectively
meaning 4KB, 16kB and 64kB leaf tables are reserved and behave as 6.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3632
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260707085028.165557-3-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 10c67645a57..c2946d8d23c 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1688,6 +1688,13 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         s->strtab_base_cfg = data;
         if (FIELD_EX32(data, STRTAB_BASE_CFG, FMT) == 1) {
             s->sid_split = FIELD_EX32(data, STRTAB_BASE_CFG, SPLIT);
+            if (s->sid_split != 6 && s->sid_split != 8 && s->sid_split != 10) {
+                /* Other values are reserved, behave as 6 */
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "Invalid STRTAB_BASE_CFG.SPLIT=%u, use 6 instead\n",
+                              s->sid_split);
+                s->sid_split = 6;
+            }
             s->features |= SMMU_FEATURE_2LVL_STE;
         }
         break;
-- 
2.43.0


