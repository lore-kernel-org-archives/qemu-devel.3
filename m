Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060EAC00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 16:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvJRt-0001uO-G2; Fri, 12 Apr 2024 12:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvJRq-0001sj-2m
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 12:08:18 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvJRm-0004ZE-G6
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 12:08:17 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41819c27ea3so116435e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 09:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712938091; x=1713542891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dnNoCn2uuTyof16mVyr36WFsEKC/7L9I7y8bsz+RKho=;
 b=qN27ALbOigZLK8Eod9grGvVpybJOgDXRrFFonbfhYKJf7hnXEHRjP7i06DgWywPx8u
 KwgMEGtRiF6VFU0c957cSWO7zuj6TA2boQzw6uPPFHsZIk3Gn0Nn4UuzwvYKfCNJRx4n
 8KMt39BQEsHiZArk2qEy2qAMad1eLNv+6ZcsEmN+xqedlnSN/uqdwpPXjoG+rl/LRmRp
 H4W+BP+olg/OyE2c8l/gnsdj6ORBaa/qP6jcxXLdo04QZDiUvYb9MmjeHssMP6jr9Wth
 0zKQRI+bUILpF4uNrZkuQM0YWc9TQzgSGPhDz2ws1Wsa2A6VottIlMXcyh2cohhNg36u
 yBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712938091; x=1713542891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dnNoCn2uuTyof16mVyr36WFsEKC/7L9I7y8bsz+RKho=;
 b=BwEH9vdLLN4dIbh5HOleOEVOduyLd0Ad3+Yop8zA/wgDcki9zbBKnq0fM3eC245Uby
 uB2WE5wXegYqgfIla05nu/XtjdOfWUsoE2rHkLo1h33ZevJi5dAEFqgkkha1RtrQClDy
 rZU36bsxrLB+dalZL9GmB3wbAnTPCM15w64ndYtmbIIGVVOSOFBBBo9FMyJ2cyv/+ewy
 fJbfApRwUyeqwlSa+GP6w78vlvxS7cIrToTNsPz3m0P+UEBGLpNe6gYE1JhfL4DqRXee
 l7BNkciItcsbHJZIRh/7QXlrK3PbhTo51yGbp4RojBQEiRowOBnqh5YdGQuVtZmLH5Hw
 wxaA==
X-Gm-Message-State: AOJu0YyMZOmNMEoxh31Kt/XTZPvYFoPfPRKiNjVxc/IVgXiHDe+i34tQ
 6yO32g2RWI+SfMKsY7IH5fUwOChQzpnulkvGr6RdrBRExa7jMIpRIlGvpPj5itJPTkh8EwkofLR
 l
X-Google-Smtp-Source: AGHT+IGgDifFk87qM9eBg/xZtCCIz6uynT3d0aviSe/eQtDiQ6mVWI84p/TrO00VFqZyYFJ+F+DxiA==
X-Received: by 2002:a5d:6841:0:b0:346:bbd8:dd07 with SMTP id
 o1-20020a5d6841000000b00346bbd8dd07mr1785319wrw.30.1712938091057; 
 Fri, 12 Apr 2024 09:08:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 cr12-20020a05600004ec00b00341ce80ea66sm4582371wrb.82.2024.04.12.09.08.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 09:08:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] hw/misc: Don't special case RESET_TYPE_COLD in
 npcm7xx_clk, gcr
Date: Fri, 12 Apr 2024 17:08:04 +0100
Message-Id: <20240412160809.1260625-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412160809.1260625-1-peter.maydell@linaro.org>
References: <20240412160809.1260625-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

The npcm7xx_clk and npcm7xx_gcr device reset methods look at
the ResetType argument and only handle RESET_TYPE_COLD,
producing a warning if another reset type is passed. This
is different from how every other three-phase-reset method
we have works, and makes it difficult to add new reset types.

A better pattern is "assume that any reset type you don't know
about should be handled like RESET_TYPE_COLD"; switch these
devices to do that. Then adding a new reset type will only
need to touch those devices where its behaviour really needs
to be different from the standard cold reset.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/npcm7xx_clk.c | 13 +++----------
 hw/misc/npcm7xx_gcr.c | 12 ++++--------
 2 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/hw/misc/npcm7xx_clk.c b/hw/misc/npcm7xx_clk.c
index ac1622c38aa..2098c85ee01 100644
--- a/hw/misc/npcm7xx_clk.c
+++ b/hw/misc/npcm7xx_clk.c
@@ -873,20 +873,13 @@ static void npcm7xx_clk_enter_reset(Object *obj, ResetType type)
 
     QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
 
-    switch (type) {
-    case RESET_TYPE_COLD:
-        memcpy(s->regs, cold_reset_values, sizeof(cold_reset_values));
-        s->ref_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        npcm7xx_clk_update_all_clocks(s);
-        return;
-    }
-
+    memcpy(s->regs, cold_reset_values, sizeof(cold_reset_values));
+    s->ref_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    npcm7xx_clk_update_all_clocks(s);
     /*
      * A small number of registers need to be reset on a core domain reset,
      * but no such reset type exists yet.
      */
-    qemu_log_mask(LOG_UNIMP, "%s: reset type %d not implemented.",
-                  __func__, type);
 }
 
 static void npcm7xx_clk_init_clock_hierarchy(NPCM7xxCLKState *s)
diff --git a/hw/misc/npcm7xx_gcr.c b/hw/misc/npcm7xx_gcr.c
index 9252f9d1488..c4c4e246d7e 100644
--- a/hw/misc/npcm7xx_gcr.c
+++ b/hw/misc/npcm7xx_gcr.c
@@ -159,14 +159,10 @@ static void npcm7xx_gcr_enter_reset(Object *obj, ResetType type)
 
     QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
 
-    switch (type) {
-    case RESET_TYPE_COLD:
-        memcpy(s->regs, cold_reset_values, sizeof(s->regs));
-        s->regs[NPCM7XX_GCR_PWRON] = s->reset_pwron;
-        s->regs[NPCM7XX_GCR_MDLR] = s->reset_mdlr;
-        s->regs[NPCM7XX_GCR_INTCR3] = s->reset_intcr3;
-        break;
-    }
+    memcpy(s->regs, cold_reset_values, sizeof(s->regs));
+    s->regs[NPCM7XX_GCR_PWRON] = s->reset_pwron;
+    s->regs[NPCM7XX_GCR_MDLR] = s->reset_mdlr;
+    s->regs[NPCM7XX_GCR_INTCR3] = s->reset_intcr3;
 }
 
 static void npcm7xx_gcr_realize(DeviceState *dev, Error **errp)
-- 
2.34.1


