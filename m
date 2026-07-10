Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22B1C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 11:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi8x1-0006Z5-5D; Fri, 10 Jul 2026 06:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wi8wu-0006Sr-Fn
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:59:18 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wi8ws-0001OH-Nd
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:59:16 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493f60208a5so2683875e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 03:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783681153; x=1784285953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/ucYtSuy5GlYosuT4raxReezYE6ZXB4/gAcNEyJFOq4=;
 b=FX9UWjwjtf32+IdYg/UGroqy4kfKmE1zsqgVXF8x7bXH8FJH7pYdPPh+gaKFTy1UJh
 r3ag3X4xWUOfjg/cjsbxys7jq/xrR0FmI4HORdPfSsDdBgkqLrLABm+MPno6hzBccs3t
 WmeZp6B8bhaNWJHkWk2vIVn1ybfjAQjZPPkoQUUUYKNBH00wrmIZVawYDFSq1kL0dZXD
 mWn5CLChINbkcfAGX0rAS2icZwkbncizG8JzD7SQGWNs4a9bxlyjqAhiYBiM8puA9W6j
 2ANCoGScncUfK80yv1rKvo3PzIlz11SBcwyUtGGJkANAmE9zapXq6zvTpuPEbDAFA4D/
 gBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783681153; x=1784285953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/ucYtSuy5GlYosuT4raxReezYE6ZXB4/gAcNEyJFOq4=;
 b=nu+EivKWZSW8YYOYXSl3rHeKGi7BdMUNtkVuFkbUVgcQlIkSNU3NyDbRhP2HJqOpO5
 V9XyX60OC0wNzk4HD41nerb+HW6uPsFQTb/ocwE1Qc6tplMWRkMc/kl7zjeDNv9dCCZR
 4ZJ/vTTGhxxxQNSkbUj2DrJ7BfArilVU8a8CEcia7KFqQ8nIrftTya2oytdJEt0P8os4
 jWoQbca0rAXHAvNUKDIUfTxUCBBRHNklh1TOCAcrqF4oQ2uaJKGJsNBbCH0cg161t/zu
 lGSALQ6rTozanETur471jFuHPXpfnNXfvYybcGtyDK0F8haFiJJLh6UJM4kAane/8BE3
 7K0g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpKMxcqLbV5KdUjyCxO7RONZ2l0LCmUNK1YLIW2UoALoMRyQnzdHhte1lXNqRP8yV/iKBYUyF6pn3VY@nongnu.org
X-Gm-Message-State: AOJu0YxErSeJMorSnGJ+mzus3z+v3LLPoVaJ5rkyRRiyyQYQtNVGepZ8
 qjN+wAfRPT8ms993JwI0yRRpGQEmYSog501RGpR6m+CR2xWm2qTnPI2RD2rLY0KVh68=
X-Gm-Gg: AfdE7cnqIyukUe2EWBfaM4+nCam2kTyuhMMob02sWTL8qB5CSkdOQBMrPXZnxDag2LK
 W0e2e89pQuqqn09P3Oh+qRo2XOmq2dt0R1GHRSbV8OUnK/A7mLger1qENjcE7L/qEq7WBe9AveS
 2ipTi9l6HLDOIGtugmCpCy1Qao3DLsrlbzuFBov9Shx3vagV4hPxHF2l2JgtVYu1TltuI8AeOUn
 Cok7PKLVEJYKUk1TMR8eF+oc5SNrEve0oKRZ4wykH9eWg5fsbCJmLNcamkncFeJuhWJ+WUXrtww
 gRkViFDUKWtIY3lXicOHbR30r/UdhpYm7qL8mqA5Pg4k59zvnCa0kBMR+jfwKH9HhvsIRte22Y0
 dV6qlDfQhEQwCegKBiGCc8RMjG9EbUYfjr1fLBKey43O4kemoDgMF1x885JvlZTHgTeXU44oajb
 RO3d1pKezNzJqs27qR30zcDXKlc+nBrDaZy/W4Vnq1F+wMX+18g/yQElhqu0Uc+HSys6I2zrmw/
 JUd3tnEa6k6oCZwcIKceA==
X-Received: by 2002:a05:600c:8215:b0:493:f278:ba2f with SMTP id
 5b1f17b1804b1-493f278c63fmr34038605e9.9.1783681153335; 
 Fri, 10 Jul 2026 03:59:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d88698sm51946175e9.1.2026.07.10.03.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 03:59:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH 4/9] hw/dma/omap_dma: Be more careful about overflow in
 transfer setup
Date: Fri, 10 Jul 2026 11:59:02 +0100
Message-ID: <20260710105907.2570621-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710105907.2570621-1-peter.maydell@linaro.org>
References: <20260710105907.2570621-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

In omap_dma_transfer_setup(), the maximum number of elements we can
transfer is 0xffff * 0xffff == 0xfffe0001 (because the max frame
count and max elements per frame are both 65535).  However, we store
total element counts in 'int' variables, and use INT_MAX as a "bigger
than any valid value" sentinel, and when performing arithmetic with
the total count of transferred elements we are not careful about
avoiding overflows. Fix these:

 - use uint32_t rather than int for the local variables tracking
   various element and frame counts
 - use UINT_MAX as our sentinel
 - calculate new packet, element and frame counter values using
   arithmetic on a local uint32_t, rather than doing it in-place
   on local variables that are only 'int' because the actual
   counter registers are 16 bits
 - use 64-bit arithmetic when calculating how much to advance the
   source and dest pointers and the total dma->bytes transferred

Note that since soc_dma_ch_s::bytes is only 'int' this can still
overflow; we'll fix that in a subsequent patch.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/omap_dma.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index 77f1441498..14b310bf40 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -391,7 +391,7 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
     struct omap_dma_reg_set_s *a;
     struct omap_dma_channel_s *ch = dma->opaque;
     struct omap_dma_s *s = dma->dma->opaque;
-    int frames, min_elems, elements[__omap_dma_intr_last];
+    uint32_t frames, min_elems, elements[__omap_dma_intr_last];
 
     a = &ch->active_set;
 
@@ -403,7 +403,14 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
                         __func__, dma->num);
     }
 
-    min_elems = INT_MAX;
+    /*
+     * The maximum frame count and maximum element count are both 0xffff,
+     * so our worst case possible number of elements to transfer is
+     * 0xffff * 0xffff == 0xfffe0001. We can therefore keep element
+     * counts in a uint32_t and use UINT_MAX as a sentinel value for
+     * "not set" / "condition does not occur".
+     */
+    min_elems = UINT_MAX;
 
     /* Check all the conditions that terminate the transfer starting
      * with those that can occur the soonest.  */
@@ -413,7 +420,7 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
         if (elements[id] < min_elems)   \
             min_elems = elements[id];   \
     } else              \
-        elements[id] = INT_MAX;
+        elements[id] = UINT_MAX;
 
     /* Elements */
     INTR_CHECK(
@@ -465,7 +472,7 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
                     (a->frames - a->frame - 1) * a->elements +
                     (a->elements - a->element))
 
-    dma->bytes = min_elems * ch->data_type;
+    dma->bytes = (uint64_t)min_elems * ch->data_type;
 
     /* Set appropriate interrupts and/or deactivate channels */
 
@@ -528,8 +535,9 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
 
     /* Update packet number */
     if (ch->fs && ch->bs) {
-        a->pck_element += min_elems;
-        a->pck_element %= a->pck_elements;
+        /* Can't overflow: worst case min_elems 0xFFFE0001 + element 0xFFFF */
+        uint32_t new_pck_element = a->pck_element + min_elems;
+        a->pck_element = new_pck_element % a->pck_elements;
     }
 
     /*
@@ -537,13 +545,15 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
      * can skip part of this.
      */
     if (dma->update) {
+        /* Can't overflow: worst case min_elems 0xFFFE0001 + element 0xFFFF */
+        uint32_t new_element = a->element + min_elems;
         a->element += min_elems;
 
-        frames = a->element / a->elements;
-        a->element = a->element % a->elements;
+        frames = new_element / a->elements;
+        a->element = new_element % a->elements;
         a->frame += frames;
-        a->src += min_elems * a->elem_delta[0] + frames * a->frame_delta[0];
-        a->dest += min_elems * a->elem_delta[1] + frames * a->frame_delta[1];
+        a->src += (uint64_t)min_elems * a->elem_delta[0] + frames * a->frame_delta[0];
+        a->dest += (uint64_t)min_elems * a->elem_delta[1] + frames * a->frame_delta[1];
 
         /* If the channel is async, update cpc */
         if (!ch->sync && frames) {
-- 
2.43.0


