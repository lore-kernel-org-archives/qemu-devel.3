Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA78C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6Bz-0005Sq-Jr; Tue, 21 Jul 2026 04:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bv-0005RQ-U4
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:07 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bu-0005hk-7E
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:07 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so1458105f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784623865; x=1785228665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2OH8VSOIHdDNZWpR3lhruykF7B4xhDvib/Al3Gjf0HA=;
 b=gJEi6Le6zerxNlIgWzR3ILyEfp2H6ikWrrHDzS+1ueE4se5NsOcn3GpLJTwDM1Dfrr
 Bsx6d8McEyXvB2zAuJL+ZGk7sOwWh2/NIjBRnVEtC9GQsgubgHQya0vEcmRmhzq5ebh7
 X688HVdUtaoNWP7E4+Blk2tyEX5nKetIvCTcquLbFDZpQfnWPQ88PvdgVk3zlvxqiX8I
 LcIQwo9I0Cu76oMC/Y/pc59+TXxCi3Ar8/x6S1PhDNJ0lq0D74k1tJFSreWrNOzmNsB2
 hiQ71Ivqeiu8K9tDklnNtNUxqpnimNz/isqP96b9STZ628jvf2pkWH70ohkExZ4EKOFJ
 o/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784623865; x=1785228665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2OH8VSOIHdDNZWpR3lhruykF7B4xhDvib/Al3Gjf0HA=;
 b=STGI2elaPLHO9mPUseoWybw6e9ZkIxwmCetz35c3R9WEu5UHkalBxI/eYLf5z3e+Rv
 KjH6aksZrqSDb2p/C2obblCwyiNPIfOCfDhclwnOOP8PSa0bIXkk4OJ2CUkVOXCiBKnV
 sE2fXi2A9yGklAPIcZdVoskuP5qzlbUJh2den5bpJPwWHuyepbshiDK4jvif5MIj8hdL
 i+uKb71dUwTjW6fPo2A/jMPK2wl2obDgJbp5+I/KJT5EEtTvR9lKw2VCQZJVw8nwNnVO
 Mj4/u84iUYEmDcff157joAWPv2RW33VeDhM+zmXdekHvXxm1TmFFGUsXjfOggGu30jLD
 qQUQ==
X-Gm-Message-State: AOJu0YzXzNQO9HLx/U8tt4sbWrViJkp0xNH7JyzlzJCo680ElZVu1+wx
 VYVivY41y62kcPPleEpiZoYilNahBYr1gbZOeEsmmyXuVKwNkrLRjkmHR9JbwR5WcgEeyC6h9Dn
 ClMOvp234yg==
X-Gm-Gg: AfdE7cnSMh+93kbcoTqlpL7nTN5L7l5FO/hIFCpIxSF3Hm4fXkpSOdzIo81o00eKyqu
 tQtwYkVvW6Lcyums6lun9wgTUb6yZt3RaCuInGl77W+yhapAOMizztLLnPxhKl04jMT+TymD6VO
 LJHKwqcmlcvGYFR+nLu1g1eupSezPefejLhb3tSuqgMtxpLs3eN0ztBbNDMSo8ZrYkcpk/t9mKp
 YPcy4kHZdCkzDU4M8ZuyqyvT7PV8O3f2Bdb6tubi5aZm1z4peG28xl9zaWTsV2NBIm/aa8DnTXQ
 JSqKVHGpszicjO1FeAQbrMgZIyJCjXhVuWeOCiMXI8AnL0ljgjlwsQe1M+rex3R+G/2m5YFw9B9
 1LThwr7r8lvm1h81h8j9v6c4IkHcF1IPGfGzefuRNTLPH6KdjZzl96HQE1zLbGp14Uk7/Sx2ilj
 eLvJiNgCmbVqngD8C2InWN5wtIXB8715km3JMWy5GxVZ6fAb9MF25oAJIj3y/IMCnd1lDLB3wvX
 PIGzlxkjrs=
X-Received: by 2002:a05:600c:b8d:b0:493:a613:56b2 with SMTP id
 5b1f17b1804b1-4954a3d0d5fmr205377895e9.8.1784623864706; 
 Tue, 21 Jul 2026 01:51:04 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c7desm68707245e9.7.2026.07.21.01.51.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:51:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/16] hw/dma/omap_dma: Be more careful about overflow in
 transfer setup
Date: Tue, 21 Jul 2026 09:50:44 +0100
Message-ID: <20260721085050.421257-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721085050.421257-1-peter.maydell@linaro.org>
References: <20260721085050.421257-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Message-id: 20260710105907.2570621-5-peter.maydell@linaro.org
---
 hw/dma/omap_dma.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index 77f14414989..14b310bf404 100644
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


