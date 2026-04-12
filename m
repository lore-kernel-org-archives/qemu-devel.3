Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B20E937EA
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 15:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBwmw-0008Qx-3h; Sun, 12 Apr 2026 11:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paulian@marinca.net>)
 id 1wBwZ7-0005wC-Jj
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 11:17:37 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paulian@marinca.net>)
 id 1wBwZ4-0001sd-Uy
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 11:17:37 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-38dfb789d7fso28839431fa.2
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 08:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776007051; cv=none;
 d=google.com; s=arc-20240605;
 b=UuMeHfk8TdjykAKiE32sawV/PtTuSzaV4ZzApY8IJpvH5wCJUy1e5tjNyl/7dKs70v
 6w/iysYDgUlr1UlXAYmHaideOZPWdhRw2iZBpeYK1V7veEHEdiJg4wepIzEHXuuHMDSt
 1INwsh9xtRLrCY7WQqMTO2Xx8V09vFqNhcoeEDLjlUM2XxY0nn1qxzh7ani9qWGy46Nr
 0jJSQ0WDjZweNFY1W14jYWWVjrI3AhZrh17pR/c7hR/LO/Oq5lSKCdr6CyuEmFjObLAF
 R01inLfW7xtgAmxX4ptXlpncNiFqt9PzKZoMLyTNW0cCDUBQXupNmBEqjJOEo1Uyi6XI
 N2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=Rd27kwtRTRUH+8A4yfGOIwrcYZq65QZACpHIU62afQ0=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=FYz5FN4TPTH96NqtIxDqQfw6s2GOnjxk8TTUzRzyvnHiZ/Grbvhim2sfNx4CTAX5tc
 kV/3tPSv8XvIDbgcBpN/rnfG9hb/HFDuY9T/wRCeEmdJGm+DsbOFz5TOv+IuGKxjesi/
 L6aTOPfqBisqeNNf6ewn/gud0XL58yWbrAUTMbqmEL1qQV1uS3CyeVQLeO0wCkTTdzO3
 a10i+7coHxSjSdMFJ6D6JnbU3hx8MAbSpg0YP3VzDuN1CRxoqoOsEM5UyGnBUvxQge8V
 wxb538uUDFDz8WMYcuMmS6BnC6B7r9Y+06rtmraqiyw2iBCmSANPTa+ezIHmFlb1d6Qo
 /QXA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marinca-net.20251104.gappssmtp.com; s=20251104; t=1776007051; x=1776611851;
 darn=nongnu.org; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Rd27kwtRTRUH+8A4yfGOIwrcYZq65QZACpHIU62afQ0=;
 b=lHMpku0jd/3l0+kSkNsFtkJo/E82844xgDpE/2uHSV/pRNg9bPdgwe5b85eeU0qwRG
 exW+HTc5v5pWkohMvGc0yloBAxNn9DJq1RKcym/JUUVeQYYjGE+THWQUGJKFD5tbQ733
 KFY3sgismhUI5Go1SkYaVHNzYk3QBwEI3JGpI5KPVhZ5/tq/42PfxTVVUkjqCe1d+HAd
 Nixj8tc2BWpZbqL6CRcrgC0Tv9aNwVQJxMimLa8/to25Yt7zTG4s82BoQFw+wGjVvV6r
 hHkt80IRD2DcO/i83rwgaMZLm+NUm4qRY9lBasnJbT29xc6zDmTz3l26CTC84qeDhhfM
 mKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776007051; x=1776611851;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rd27kwtRTRUH+8A4yfGOIwrcYZq65QZACpHIU62afQ0=;
 b=Xcwucrl4DS/BtOJesg5g4ZnCTOZOHw1w5EphF0vA/wzjMQu9Y5uCOk3/E5e80EKTU8
 e/OprJ7N9omqkjZbWpTw23a9Qjsu43kE2w/MpCcSJ2DD0RDwSzVeuPZTLvdcLsQqkQ9/
 iL8hwBeaP2dN85h8n9ZdOQuE80ZGCWqEC6kKrQJke9DVQGr066EI1CWBqIzfY0bvWb2+
 00kXcqvOCYeSnhmoD2FfiKmrpkfEWWk1EaVCIlJTFd+5BbemOLuBN6F8FqcMCQpvFJ74
 y2RDVtuhQRtf+UthzWEU/6aryoQUslrdLzoijrPHK1V2YOZYrLzN+7Pl3tDeyRPsqIdW
 oFAQ==
X-Gm-Message-State: AOJu0YxbcB9ndbCVyneth4Yn8MI0UDDkdfiwfYYKryztijusHP2T+xuL
 dM4I4Rz6ykChhwp5ZHYli/kqtGbke2mfdl8S43CkqBbCjHhyLkAoYpZb8jwy7pZorzs+uHeCmTM
 QBKsi1seTdgyCSqpdEhSEsbbgdKCRYvnC/1Jtj/oovgfEUzgXLWJL+zED
X-Gm-Gg: AeBDiesSQwS2CKQmS3ZLjxIzVxmk57nZR5fmhqr6aXBCzqknRVA+p+EWg5Sx74wSnXI
 F+Bs1EVGwQFSG84ruwx4EJNo+xWyH1q3nuR3vruFeih+V+8/+D8GepdUeS5rX0AXoNQGJR0ezPG
 wUgMkLUFYtKdqZuq10aBeM5ppz4SBt7ozRBoPMGAsq5s7ReT1Q8MbDyONZcJ5BxbiQXVLJMrjje
 yFziNphFs1hUi9UyXUhE4n5nksQ1XAXayxeha6whzUjYmClcP0YsKO/oHYf7FqDSo49iL49CYH8
 rfYUew==
X-Received: by 2002:a05:651c:f1c:b0:38b:50c7:8239 with SMTP id
 38308e7fff4ca-38e4befac2dmr33682361fa.21.1776007050680; Sun, 12 Apr 2026
 08:17:30 -0700 (PDT)
MIME-Version: 1.0
From: Paulian Bogdan Marinca <paulian@marinca.net>
Date: Sun, 12 Apr 2026 18:17:19 +0300
X-Gm-Features: AQROBzAtQHK-VTX8ZbGeVtHt7kxPfbs0qQUnCXVoy1ILI6u83lt_ZPvtMt2s17g
Message-ID: <CAFFE2avrHDKZd5m7j3E3x5=F=pzn-3c9vzGWP3+9-AVPwQng7w@mail.gmail.com>
Subject: [PATCH] hw/i386/intel_iommu: advertise PT in ECAP, not CAP
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::235;
 envelope-from=paulian@marinca.net; helo=mail-lj1-x235.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 12 Apr 2026 11:31:50 -0400
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

commit acf7e2c93cb3efda0add6fd5f3b5b447e63d6367 (HEAD -> master)
Author: paulian <paulian@marinca.net>
Date:   Sun Apr 12 18:08:45 2026 +0300

    hw/i386/intel_iommu: advertise PT in ECAP, not CAP

    Commit c7b2e22bd957 ("hw/i386/x86-iommu: Remove X86IOMMUState::pt_supported
    field") made pass-through translation type always supported, but moved
    VTD_ECAP_PT into s->cap in vtd_cap_init().

    VTD_ECAP_PT is an ECAP bit, not a CAP bit, and the rest of the VT-d code
    checks it via s->ecap. Advertise PT in s->ecap and stop setting the bit in
    s->cap.

    Fixes: c7b2e22bd957 ("hw/i386/x86-iommu: Remove
X86IOMMUState::pt_supported field")
    Signed-off-by: Paulian Marinca <paulian@marinca.net>

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f395fa248c..7b2cead8f8 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4998,7 +4998,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);

-    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | VTD_ECAP_PT |
+    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
              VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SSLPS | VTD_CAP_DRAIN |
              VTD_CAP_ESRTPS | VTD_CAP_MGAW(s->aw_bits);
     if (x86_iommu->dma_translation) {
@@ -5009,7 +5009,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
                     s->cap |= VTD_CAP_SAGAW_48bit;
             }
     }
-    s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;
+    s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO | VTD_ECAP_PT;

     if (x86_iommu_ir_supported(x86_iommu)) {
         s->ecap |= VTD_ECAP_IR | VTD_ECAP_MHMV;

