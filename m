Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BFEC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIeR-0008UQ-4o; Mon, 13 Jul 2026 11:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeI-0008S6-8O
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeB-00017D-Tb
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493ba701891so383195e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956761; x=1784561561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Iw0DAfgObCHFOCOXoM5lfjnjSDz7e/AvrJLIEvX5AMU=;
 b=ddQRUGihm4fnsFioAoT+3eVR5EwFRvIjhKSi172J9VpIQFxevoIuXfrg6QL42lRKr/
 5FLgMsfuFbYPzqbLxESPqsTp4fdnkjvBGkjFqgcZzKTKCxZMmzGPCG8PuZTxpEdHttYe
 3jreGdLY2zYZsBXk3p6vgkzSfi82Ehwb5WmVJxDJQ+LgFIxqk2wSgBu72Dj5vtZC3vup
 wENdCp2Su0KGZdI/++Oa8bvQP9hZOnPQjo3HFHoTWj9nhg82eR7ZpvAbrvNHZkk3vvK2
 Wk9094s3ZEnXuv3aYbzd/SE7PyUieC2+6LOIvdKWWZucFpY6uw6xdF5Js4ztK4WHuoDk
 aYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956761; x=1784561561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Iw0DAfgObCHFOCOXoM5lfjnjSDz7e/AvrJLIEvX5AMU=;
 b=LFFgZs3aIzBsz+hgUaxOVTJY7sKJcGnKQ+BaxxJf03Aze3nDOyuZXGwcJFKDLkpWSi
 OIq3VA61Q4panvzzvBSRVRXJihfhvDSwLHW8LCk2XkSlPBfWVyfZbwPHIh/Wi9f+s3C2
 9tYQ4B5557rXKypVyo6V+xocs69ElPaYxLPUs+QLmg8DMp8euSRRBd73zhfeR6+Rr07f
 65ZI7cXz3zgKACzaxG3/hN/21MoB9tCLZu12yuu4+eVXnODO1GT8FfMsd8cQd1YhEN9X
 n2kVjKNU0Cd0rprmpHZPThackVUKHPNSJ8EUxhaieHxEIxFVAQvpa0gOThZEqt41Uk2X
 2k6Q==
X-Gm-Message-State: AOJu0YxW9RQrmrMPpHVVQaPfY7fIhvO0t1bNJONKIwnvJFUWN29KniVS
 /QK6HUtyQX0NIsLZ+KjWsqZvtNh5F08NB+sglLxWSXT1E/XEvt7PzEPVbVHBaljlcGojM4vF2Sm
 pBl4JCSgA1w==
X-Gm-Gg: AfdE7ckPQr6DKb5SzXOOgzdfrHyLN2eAGO2tOAVvCJP8265d9VxyMOn4OWoFOszXfwh
 5f4JVUZ/VfmFl+Qrlz5ZyRUmioYVrKKc+Kmqr+ySpErYyS/bH7NNy1Ca9FZYspwWWXb61GjdOIZ
 2TaTcCf0p3B0Te73FsVyDaBBfbyTAbWSAB61lPtFFgHz4AAK+L/ILgm9t6swF4dSKEgxqfSWFQm
 gKmCvt+zyVW0VQ6T6VoiXER1BSrVoF5uErLbvDADCNh7A0SCqvtiD/954+qkoVdLNI7yqEKzUfZ
 xBLozvyZMBB0HEjGJXA9FpXakSqQYJCgh93+5okh6NsxqFplb0dVTx3AuvRrm+xUoxtqE4fmVYX
 awbUm/6kmNvbePtxorEGnabEzYeRAZThyzwPocTzY+l2jhwKpBjGjIhY0Mv2wYTB4FMQJEh1dfA
 mfni9vydl2BIYyZ+w8veAS80UI8XtiUW6gwMNOskEDOjezAbdFzkSekZ2RFRxRiq5EMiW9zxLbx
 OFPhboxWD02LnYU3xENyw==
X-Received: by 2002:a05:600c:6387:b0:492:3e69:a86f with SMTP id
 5b1f17b1804b1-493f87d89d2mr91973655e9.1.1783956760820; 
 Mon, 13 Jul 2026 08:32:40 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/26] hw/arm/smmuv3: Check L1STD.SPAN
Date: Mon, 13 Jul 2026 16:32:13 +0100
Message-ID: <20260713153233.3391818-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Span values above 11 are reserved and behave as 0.

Also span must be within the range of 0 to (SMMU_STRTAB_BASE_CFG.SPLIT + 1),
ie. it must stay within the bounds of the stream table split point.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260707085028.165557-5-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 3fd1dd7cf81..9008ba7acd9 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -707,7 +707,7 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
 
         span = L1STD_SPAN(&l1std);
 
-        if (!span) {
+        if (!span || span > 11) {
             /* l2ptr is not valid */
             if (!event->inval_ste_allowed) {
                 qemu_log_mask(LOG_GUEST_ERROR,
@@ -716,6 +716,16 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
             event->type = SMMU_EVT_C_BAD_STREAMID;
             return -EINVAL;
         }
+
+        if (span > s->sid_split + 1) {
+            if (!event->inval_ste_allowed) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "invalid span (0x%x)\n", span);
+            }
+            event->type = SMMU_EVT_C_BAD_STREAMID;
+            return -EINVAL;
+        }
+
         max_l2_ste = (1 << span) - 1;
         l2ptr = l1std_l2ptr(&l1std);
         trace_smmuv3_find_ste_2lvl(s->strtab_base, l1ptr, l1_ste_offset,
-- 
2.43.0


