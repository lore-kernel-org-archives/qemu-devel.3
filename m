Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10978C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogyH-0005SP-7s; Tue, 28 Jul 2026 08:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyE-0005Pk-0d
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:42 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyC-00034m-By
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:41 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47f9ab7ee38so2015123f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241899; x=1785846699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0uyvWvhf2PkGp8LEN9Yz1w34qwzlXkF8Nfzq654Qzu4=;
 b=Xe+8WsSYvcHZnhUY+3/eTn/7KL2rLszOEK1US+PCbof+OYAluytqGjDDV9zX0zGoIU
 IRi3Ar4PHgptvQhoH3E3i7Pn2JXmIBbz0Kw/4EUT/FJ2gAJVJg1p6LEj4oJ72q7eiyU8
 6Bv7pZb2cVHhZdDrt6jZtelllYd9y5JcZeo5eUdyAYLcGYmbNoM0tNZz0RORJSU/2DrM
 eeZitnhKpipeiqmNSKYi9RyBVTFNWmhM8qZZIw43ZGXFaKJ5T9GAfaOv+2BZNNJgPYcW
 4FBr4nI/uxqe06+Leh2WEvH8YzxHV/IS5AYyX/m3Y9psEUBp2p4KYclUpn4a6Z7+aL8j
 2uNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241899; x=1785846699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0uyvWvhf2PkGp8LEN9Yz1w34qwzlXkF8Nfzq654Qzu4=;
 b=Oz6XqQMf6jdBsMvgiNFEIWYuxkFJdedWygiiJHryNdOrbgE6arhLcdL9etLjPgJmnS
 DHFJvvuHbXGocuAhMIpbQeN6by8HZlLfVBZx59qgfWcl7K63/KSR6SOdShOob1iTmnXQ
 x8BcKCZoeOdzSthd8D5pEQUuNXHqNskQnP44I8r6M84cPOuW7KbuNzZ1oMVDnbqCSQAx
 MStjXLTNg7o47WFGwWlHfnJqJ0cz0UHggh65WEWAlXPkAZtqCDLdKG2bw6ljn8dq4rLs
 5LsSIqMgm8rxCP+RGVYox82eaO9m9vkUD0YVLPvbJJ61ET+PW5nrxn6eWifwQLTSAuGj
 /6Qw==
X-Gm-Message-State: AOJu0Yyjq23yiBCUA9Ja9M8+GLBBvoeq66PdrU9gDxPWuhU5M6eV0RJf
 NCSo20BszYvdhWL69BI8OAbydmnJetj0br45Elmm/qElacV/z6VS2Cthrbo8wmpYl+VOv/ENWgi
 LS7Lx
X-Gm-Gg: AR+sD13SYqwaqckIgOlDl4KPlrdfv9FmKYWFaF0fVrxQB0al58+Gj18mJPfukt8LA7j
 qkiCTIRnYdY27fePFT0RwHmSxXpD0RX/9uAfu+2GhYWVpgNiBXH66sXnFDc0rRNIJlGXxPilTXe
 iGGM9njjtLzUyV2JzQPtRvs+dvDMMThsJ0bB0HLAPuYgBUvgoH3bY8txnQLETxM68/AL/pQyYFx
 dzzTFCn4giZyzMjY8U0THnzRh7A3QoTMp1TQpkzAhYqROu9b45r9ZfTw/HYVnTDrRbjHF92bBM9
 gq31TfuQZX+N6sCWvmF+MIzqsyRHD4K5gPjcvNoqDMMDMSd6h5H6bVP+q01wiaX00A45Bixq1QD
 9fWTrjgDyxlUl/ekRr/uhoPBtYKiswU69j1Qt1zgnDFcTJNHBubOkVbwILl3KHaVFFyzU46jL70
 QkS+m8eQkysJZQiebKvxEiYlu/ORCJS0oRjnkHHDsIIg4BhhVLhizPcW8NoJ5G2kgr0m9tSrLCm
 p0/SlXAQgI=
X-Received: by 2002:a05:6000:2c02:b0:47f:943a:a7f4 with SMTP id
 ffacd0b85a97d-47fb1f394f0mr2562067f8f.61.1785241898700; 
 Tue, 28 Jul 2026 05:31:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm58499039f8f.34.2026.07.28.05.31.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:31:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/20] hw/net/can/flexcan: Fix mailbox index calculation in
 flexcan_mem_read()
Date: Tue, 28 Jul 2026 13:31:16 +0100
Message-ID: <20260728123127.1711653-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728123127.1711653-1-peter.maydell@linaro.org>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Calculate mailbox indices from the `mbs[]` array layout instead of the
oversized raw `mb[]` view. This prevents accessing mailbox entries beyond
the valid array range and fixes Coverity CID 1662974.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260723070059.6332-6-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/can/flexcan.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
index 651904fa379..8d680f1832e 100644
--- a/hw/net/can/flexcan.c
+++ b/hw/net/can/flexcan.c
@@ -1239,14 +1239,12 @@ static void flexcan_mem_write(void *opaque, hwaddr addr, uint64_t val,
 static uint64_t flexcan_mem_read(void *opqaue, hwaddr addr, unsigned size)
 {
     FlexcanState *s = opqaue;
+    const int mbid = (addr - offsetof(FlexcanRegs, mbs)) /
+        sizeof(s->regs.mbs[0]);
     uint32_t rv = s->regs_raw[addr >> 2];
 
-    if (addr >= offsetof(FlexcanRegs, mb) &&
-        addr < offsetof(FlexcanRegs, _reserved4)) {
+    if (0 <= mbid && mbid < ARRAY_SIZE(s->regs.mbs)) {
         /* reading from mailbox */
-        hwaddr offset = addr - offsetof(FlexcanRegs, mb);
-        int mbid = offset / sizeof(FlexcanRegsMessageBuffer);
-
         if (addr % 16 == 0 && s->locked_mbidx != mbid) {
             /* reading control word locks the mailbox */
             flexcan_mb_unlock(s);
-- 
2.43.0


