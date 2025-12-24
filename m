Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71049E75453
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 13:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYPD3-0006GG-Hr; Wed, 24 Dec 2025 08:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYPCn-0006Bo-Pz
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:47:10 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYPCl-0003gI-2D
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:47:09 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47d3ba3a4deso5406665e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 05:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766584025; x=1767188825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=shYbRzGh4HeszhizU55hQ7lgJiMr3GPlgmdmv3H0HN8=;
 b=b6PZUvik0LmIw6/ONyrVP+VUzAqGPz+K3sXMrBdyrzGb8A7YOmzF4/nl9DuGXFobts
 5snFjeyGK2J+Adr6U8fTiXByxsPzsMJBLFgFnY/ubAvPHDO+7pFrnuwPwTrcHvcz1C9B
 xDiuVzPFLyMxtu++aHUpIXCMGYKCLKyEk9LKcIkdmqabDj8Nfnf9q+pJiHmgCvXEyBmj
 NT1YjffhEVcRt8G0qouXMPsQulhHQV4aRg6T4ONqn9P8q4V2pe/pkp0cxg3T5Yl1G3JK
 X+jbiElWKa4QYH6Ue41g5dSY2Ijb73zsmBDTcpCozHOfDS+2+Ot+y8TLxLoIwbMBEIkP
 WeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766584025; x=1767188825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=shYbRzGh4HeszhizU55hQ7lgJiMr3GPlgmdmv3H0HN8=;
 b=fYn2hddVBGz0xRLxZqS+xmLDTvz/7Dz1rtkHQs0/Cr4TwVjZPmBDW+Vgc26UhvsEi4
 VGU0xJ8f0jqSMJ8CRGCwlqfPyFMuB6IJzPxfiflQeejj97Y8P9M3ecuDVQ2SM/1KlqFh
 j5fFD7igCH5AFyQCVWYRS5z5EEAZ0tHvS4Hs06HFdREJouF8weQYC/ZwFaDiWcVm8qiG
 /sOq2toy0YSuxJ8skyA+xJAsWH6yaTH7F1SKXkLgyoG5EjhBoV8fO7mxPFfNo9cik2rH
 BOmDFW755R4s7K39spYueXzzyqo8BWDQT0/81cSLP9ih/jaSVDuf1JLBwhTLEGNMhyHg
 D2Dw==
X-Gm-Message-State: AOJu0Yw69aJHGQ47pvizLPa9hbNfV/V2zTx5Om9898rmrSt351+es71t
 XoK9c4TLcXVR7/WNxhZvShjlhiE/VczK1pct8y/ZzLqkNNIM1XCvq+sNYt3Y1qY+NbqH0ULPn4U
 WJUAkMXmtBg==
X-Gm-Gg: AY/fxX5WgyFMhRtYD7Hajcmo21EpxlD1XWqZQMAXZ0zoTl4P+hyc/yFYlVuB9mkqCIm
 ionG5fvpO8+ktMEAH8IzdcsAHAZMj/j510e8BscZBycqbq65ynzBO70uz2Zn3kO9dFBEMGtXzJ5
 6Z+Rct0lNm0UkXOGk13YniSCcx4lTO+Uft7Da+xR/gT3aAqfqkOmUS5/+Ufzw9CRpv1A92jU/4m
 9WRoaCO3uUIo1Ig+B8zXoqWIU+j1vuyhSs1Fg+mWPKQv0OHsAabUoa0QOYe+rbo0w6nLIyx/k+v
 ZkPl1Mckp53W2DBVWH6SCxNQgQhH1ndUU4SxY4WvduRvIWX8okq0JXr0M+xQKECdnSNx5TtOBTh
 oPWFVwteUyVmmaMzHAuDoJpTwJMefsnN48spcalK7jR094GzNtmhWZ3X6BawGVjyO/hcPzbDVfP
 477HQ0Z0Heaz+mWLacRCQE8XplSLGhY7UMEMbHAYHZlOMwqY1QrwrmHwQm28uOHQ2MuExiTSM=
X-Google-Smtp-Source: AGHT+IG7/tDrxlL+g7K6TNhz0Uhw+nty/m6CTU7wnXp0QM+lfW92jSz33OPGh4QmDAoNuzxKGRobXw==
X-Received: by 2002:a05:600c:8b6d:b0:475:dd8d:2f52 with SMTP id
 5b1f17b1804b1-47d1959d1d8mr188420915e9.32.1766584024910; 
 Wed, 24 Dec 2025 05:47:04 -0800 (PST)
Received: from localhost.localdomain (218.170.88.92.rev.sfr.net.
 [92.88.170.218]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3964226sm150434825e9.0.2025.12.24.05.47.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 05:47:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-rust@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Max Filippov <jcmvbkbc@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 2/8] hw/net/opencores: Clarify MMIO read/write handlers
 expect 32-bit access
Date: Wed, 24 Dec 2025 14:46:38 +0100
Message-ID: <20251224134644.85582-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224134644.85582-1-philmd@linaro.org>
References: <20251224134644.85582-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The read/write handlers access array of 32-bit register by index:

 277 struct OpenEthState {
  ..
 287     uint32_t regs[REG_MAX];
  ..
 291 };

 546 static uint64_t open_eth_reg_read(void *opaque,
 547                                   hwaddr addr, unsigned int size)
 548 {
  ..
 551     OpenEthState *s = opaque;
 552     unsigned idx = addr / 4;
  ..
 559             v = s->regs[idx];
  ..
 563     return v;
 564 }

This is a 32-bit implementation. Make that explicit in the
MemoryRegionOps structure (this doesn't change the maximum
access size, which -- being unset -- is 64-bit).

Move the structure just after the handlers to ease code review.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/net/opencores_eth.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index 7e955c01322..bc4565a9a49 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -682,6 +682,15 @@ static void open_eth_reg_write(void *opaque,
     }
 }
 
+static const MemoryRegionOps open_eth_reg_ops = {
+    .read = open_eth_reg_read,
+    .write = open_eth_reg_write,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
 static uint64_t open_eth_desc_read(void *opaque,
         hwaddr addr, unsigned int size)
 {
@@ -705,12 +714,6 @@ static void open_eth_desc_write(void *opaque,
     open_eth_check_start_xmit(s);
 }
 
-
-static const MemoryRegionOps open_eth_reg_ops = {
-    .read = open_eth_reg_read,
-    .write = open_eth_reg_write,
-};
-
 static const MemoryRegionOps open_eth_desc_ops = {
     .read = open_eth_desc_read,
     .write = open_eth_desc_write,
-- 
2.52.0


