Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA642C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIec-0000Fr-4U; Mon, 13 Jul 2026 11:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeC-0008QQ-60
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:46 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIe7-00016T-Uc
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:42 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493e8d4f4dcso26321285e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956758; x=1784561558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RylEd29WcoS/OyUEgnd0qftfI8x/CGruWSkN5SctWWY=;
 b=y7G8XLPaM3IbMi7AVcgugCNVXTdum0gpHkByaZhpJ9XzlL1azGPLzbO0AVJz/8Qp6E
 hu7ZBZZVeK9uaNIa0Z+HsT+8W5fQirqFVrKgOpIpXWBgUZ6xowp7cuTJE3xkBdTPoVbb
 KwGnBauYiWqNPF08w1v9oK4QhVWOkCxDIeeeCY4zzULQkprItrlm6Fvw5ETX4zw19OnD
 e6Y2DKOhcbq5p90xeWBaC2lh1KNvHuBKRD0/zZnc+CTtDCRcjDPtZG1n7mv8FvDdPvK7
 ksUZFiH4zu0/v4lpc9E43U5jaWolcxD8Bj7oUW8p8uDD/d5ILEU+bvk0MfILTEd/w/8M
 ubbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956758; x=1784561558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RylEd29WcoS/OyUEgnd0qftfI8x/CGruWSkN5SctWWY=;
 b=XhlR/W7cK6PFd93ikOQwQvEXUnKclRmsZm+jajpNd0YcOjNVhPbNdfubUHiKwUTuHs
 /tJolPlFtW6JPMgY5R20B53Zk/FK0Q9j08XsDCZ1UZdj9nOI+VBNWjtF4TvgvLAQWx87
 v07TPfIdzVdh8ycUFumRxr02U4Eu05oR3yu0AKReClGCtrH9vRZdCWp2NS7sdGb31Xh6
 GexYxxQxBQF6B1vslafU3z41ASil9xqYOOUZ8U2NEOHdCpWCc8eYsdaUo1XcYjf2KtGr
 lSKfa99Btnelqh5UwHUosg7WXoPyFrh55MFonxloqhK5d8OFE0EV+mhbG8vU/jTRFduC
 Kanw==
X-Gm-Message-State: AOJu0Yw6a3n/aoQyf5qbt9JhLogv3TaSEWyPoOyPX/EoLxUEFdnjYa0A
 hV2Zgt51aLgw7NGSQcqE2Sh8gCfhKPT3RKl05HquEhM6yYmbDCMovY00aV8fcSceWEQz0mklJyV
 ZJXgQivDe4w==
X-Gm-Gg: AfdE7ck8bQXlzRb/pk7pZA/PSDfonL/Hnt1ErsPGp/Rp8g1SDJgQAKTcv/y1NtoHLx4
 AAw3m2NS6eD+HhoPOd0mvgAZNaeWxZiETN3c5vFrrTHPBC45D+84sWznn0xhlTQZW7vFurNsKS7
 MxiAIxnMxy87NftJXoz0J1N7D1mOOswlnvfTEzeW3LW7Gpe9v/27EvahFsrteI8bnurwzkCYeNf
 a9Z5zQ67r6M1Spig5kjTif+S6MOlxpsmihal2Pw+3Z+fO/QntneVPKFY4STdf/Of1ScjAkagB1v
 lMr0T4exdp1OQtMnKrW3M6E0ThasmMbBJNYuXYIjLwAmIdosz1MrZOK9JoXtZIYoCYMYpJuSOw+
 1PkE976A3lv5J8gtzndvUyojAxNef8ZFiCHMVwPFSRv3M3435xbSRD8H3gHb5bFBrYG70Je49rV
 FQWxUFoRUrSYTQDUocz/LIc8NJQMi1BnU3BtRRISBeD4BUUtA3WyDuI16k5r3Oe2uYTWKHUm4Px
 qYTw/BnepmGs69t1lOI9w==
X-Received: by 2002:a05:600c:828d:b0:493:b307:6777 with SMTP id
 5b1f17b1804b1-493f8824389mr86992825e9.22.1783956758226; 
 Mon, 13 Jul 2026 08:32:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/26] hw/arm/smmuv3: Fix off-by-one bug in alignment strtab
 mask
Date: Mon, 13 Jul 2026 16:32:10 +0100
Message-ID: <20260713153233.3391818-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

The stream table base address needs to be aligned to its size.

With FMT == 0 (linear stream table), the table size is log2size *
STE_SIZE (2^6). So the spec says the base address
must have ADDR[LOG2SIZE + 5:0] = 0.

With FMT == 1 (2 level stream table), the table size is
(log2size - split) * L1STD_SIZE (2^3) So the spec days
the effective base address is aligned by the SMMU to the larger of
64 bytes or the first-level table size:
ADDR[MAX(5, (LOG2SIZE - SPLIT - 1 + 3)):0] = 0.

MAKE_64BIT_MASK() second argument is a size and not a shift, so
fix this off-by-one computation.

Subsequent patches will fix the risk of overflow in MAKE_64BIT_MASK()

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260707085028.165557-2-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-internal.h |  3 +++
 hw/arm/smmuv3.c          | 10 +++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index eb482c7000f..0819a4b2e8d 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -359,6 +359,9 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *event);
 void smmuv3_propagate_event(SMMUv3State *s, Evt *evt);
 int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event);
 
+#define STE_SIZE 6
+#define L1STD_SIZE 3
+
 static inline int oas2bits(int oas_field)
 {
     switch (oas_field) {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 5e5a6a960c9..10c67645a57 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -664,7 +664,7 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
 {
     dma_addr_t addr, strtab_base;
     uint32_t log2size;
-    int strtab_size_shift;
+    int strtab_size;
     int ret;
 
     trace_smmuv3_find_ste(sid, s->features, s->sid_split);
@@ -685,9 +685,9 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
          * Align strtab base address to table size. For this purpose, assume it
          * is not bounded by SMMU_IDR1_SIDSIZE.
          */
-        strtab_size_shift = MAX(5, (int)log2size - s->sid_split - 1 + 3);
+        strtab_size = MAX(6, (int)log2size - s->sid_split + L1STD_SIZE);
         strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
-                      ~MAKE_64BIT_MASK(0, strtab_size_shift);
+                      ~MAKE_64BIT_MASK(0, strtab_size);
         l1_ste_offset = sid >> s->sid_split;
         l2_ste_offset = sid & ((1 << s->sid_split) - 1);
         l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1std));
@@ -729,9 +729,9 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
         }
         addr = l2ptr + l2_ste_offset * sizeof(*ste);
     } else {
-        strtab_size_shift = log2size + 5;
+        strtab_size = log2size + STE_SIZE;
         strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
-                      ~MAKE_64BIT_MASK(0, strtab_size_shift);
+                      ~MAKE_64BIT_MASK(0, strtab_size);
         addr = strtab_base + sid * sizeof(*ste);
     }
 
-- 
2.43.0


