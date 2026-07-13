Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49EDC44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIef-0000UA-30; Mon, 13 Jul 2026 11:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeV-0008Uy-FP
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:33:06 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeS-0001DP-HC
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:33:03 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so12536985e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956778; x=1784561578; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M5b3q1vcJG+pOrSEqjL5McdQp6iUtRNJbg1c5s1UP7s=;
 b=uPuLUqUZkttdK52lt3oOlGi7Id0hxvzKLzb5cV5TD94Doha+kmCprs9BwZKU00VRWC
 uq7kvZxfSL8y6lDZYMwXzF0+SdKa+RIMvs9NJk1SJUeTLkOvxnkikZDIfTTTE9aAIv3x
 zYScriAKM9wl52Mtz76ZUUDVOAWr7uH0FnKQgOPKfvRCDSlR6PEQycbmgOsQP/2pnwcw
 jcHlfpWigakC/1mKwwal9K7sjDOcD0dGZSgX0rTRIiBT0a1QfjSKjl9Lcofki97kQFLY
 Es/2jS0275Xd7VFAgmF+i00DmGiPvgRN6BNQ/OMrcEixdkjMfBX9x7iRuaQW5wd2Ad4x
 Jj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956778; x=1784561578;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M5b3q1vcJG+pOrSEqjL5McdQp6iUtRNJbg1c5s1UP7s=;
 b=bbLFgFgJX7wpo7T+Kk0JSIJNj6AKUX8wZaPMjQ255AMB1fuUln8Mmc8d8wvtBqBeMS
 jLEmUvm1rNHIyGKChC8xBl9yFfbQg5CQvEuifa+5d8b8mRgQTIvtPRz2lT9NS0RVb0vj
 J1nfppkwZAdo/Pn80o1AWXB8mWTfrqFZFsI8D4/Pbggd3grQqshaF/Fs+zeBcgGv+WLl
 UFwOue+6O7Eo8ojHYCQ/c5FWwCqqu4lMtltBNMPtfx7yXZNd82uin26ATPaKSiPn64p/
 OC08UDRUvc/mwJhbmG5ztRdKwNC/nBMr5DflXWz9b/A9uCFny12H35MTrOhvvBL4AaI1
 KbeQ==
X-Gm-Message-State: AOJu0YyJcl2KCDNgBCFABUjA3RdF/6o1Qc1+Vji4fk3NujXyutZYyHUb
 A0qpEtc42J/EEdEMUlmUQiUQJyLYdY83aGhghZYZ41FDkv5m6QYXsrJr0aLcHDnUlmR25o2pCi+
 eVgzXYoAAXA==
X-Gm-Gg: AfdE7clWcJjUUlI8VXC+YEn4gcqN95zsbiJTUqEApIgRaiMq0EtRUQrxaY5Zlhziw2W
 DhTh/m55uTnauAn8UY1yf39wFOw/quzKPTUmx/orBOjIcMDQJq+YHmqEV5I/UZMIGJkvOIPay0V
 8Uj8YFmdIcMiAtxRzi0/3jItRbUL7OTOospt7Wob+ZUHmMtymxkvE67O4A4k5g7f+r+czzIb/Bx
 l+ZZeqlYWfFqKMTUiEnUTbJ0b4Inps2Xu+pFKgGQ8QIKYo8GfznkNwcv8boa3BjpmHacD68BiDK
 eyvX2m8Fduzry43JldAX6YZexr+0Sw5WNe9qeO2/wUXNucfu39ftr+2D4I4pAn7lgWgUCmlOn6z
 EVkelk3jIbsSXRmY9FYcD0x7+El4QZM6d5CEFswj9Dz2pXj5bk3W9ACnWvj0o/vL9fvoswpl1aq
 ouURZhmujrMIrONxhd8Purdt5hOA4X/ZIBoyktiuSGGzQO+koUMj9ZB0hBTuHY5J2A9dGXjxcFp
 j3l48ymC1IuwBapk8PUkUr8anMu0y0WSVbk5ZblHl0=
X-Received: by 2002:a05:600c:6216:b0:493:f6f0:d66b with SMTP id
 5b1f17b1804b1-4940033a949mr68591925e9.1.1783956777839; 
 Mon, 13 Jul 2026 08:32:57 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/26] hw/misc/allwinner-r40-ccu.c: Correct handling of out of
 range accesses
Date: Mon, 13 Jul 2026 16:32:32 +0100
Message-ID: <20260713153233.3391818-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

In allwinner_r40_ccu_write() we handle writes to a MemoryRegion of
size AW_R40_CCU_IOSIZE, and the register array is sized accordingly
at (AW_R40_CCU_IOSIZE / sizeof(uint32_t)).  However, one of the cases
in the switch is a range up to AW_R40_CCU_IOSIZE, which makes
Coverity think we might index off the end of the array. We also
have a similar case in the read function, but since that returns
early it doesn't have the same issue.

Adjust the handling of out of range accesses:
 - use AW_R40_CCU_IOSIZE - 4 as the upper bound, as this is the
   largest value we will actually see
 - return early in the write case, as we do in the read case

Coverity CID: 1663687
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Message-id: 20260709104802.1989086-1-peter.maydell@linaro.org
---
 hw/misc/allwinner-r40-ccu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/allwinner-r40-ccu.c b/hw/misc/allwinner-r40-ccu.c
index 8ba4e7aa429..00840e98507 100644
--- a/hw/misc/allwinner-r40-ccu.c
+++ b/hw/misc/allwinner-r40-ccu.c
@@ -71,7 +71,7 @@ static uint64_t allwinner_r40_ccu_read(void *opaque, hwaddr offset,
     const uint32_t idx = REG_INDEX(offset);
 
     switch (offset) {
-    case 0x324 ... AW_R40_CCU_IOSIZE:
+    case 0x324 ... AW_R40_CCU_IOSIZE - 4:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
                       __func__, (uint32_t)offset);
         return 0;
@@ -113,10 +113,10 @@ static void allwinner_r40_ccu_write(void *opaque, hwaddr offset,
             val |= REG_PLL_LOCK;
         }
         break;
-    case 0x324 ... AW_R40_CCU_IOSIZE:
+    case 0x324 ... AW_R40_CCU_IOSIZE - 4:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
                       __func__, (uint32_t)offset);
-        break;
+        return;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented write offset 0x%04x\n",
                       __func__, (uint32_t)offset);
-- 
2.43.0


