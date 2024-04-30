Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0358BC19F4F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qfS-00033o-3c; Tue, 30 Apr 2024 12:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf7-0002Rd-So
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:49:03 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qey-0005d5-IH
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:49:01 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41b79451145so35704275e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495731; x=1715100531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jqDoG7XrOPhSpsms6wDOW1hCXTqugMMNRvD8wRtJzzA=;
 b=GuRtOwTRPJlOI8EkIp8Ov2Q7yv8ACDH7dk4ERljOxi4z2Zcv0pduUmm4GJj629lv4K
 c9sAkrtUAqj145UQzBAZydH3oK7StgoK0VTT17WxoQhEoP4mhC60UaWY5Ax7jcmejSyn
 Uyw2cHyvUgDtOV5RcPkTYd2I0CiS++g5tsFmo9EUU2ZZLjT2ahsQVQU97YqkEpnGPtDn
 NLoz+2uV5W9e8WCA/N/GNtt9tyPPQYeXfTACzEBHUYqRqx3Z8Nn+zWfDAD1nDkw1A/PX
 CQsLpCW2IGmNZwlfKzsQW//U4JQ44Dx6azTFtBVD8ARzIlZguceDB2rw9fmQXjMU9a+3
 Wy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495731; x=1715100531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jqDoG7XrOPhSpsms6wDOW1hCXTqugMMNRvD8wRtJzzA=;
 b=wQhRtg14zJ5eE8ueJnVjMir6kGttSHE8DLl1ZUyxwD3qTHotoy7ue6+tu1c96BMzMV
 Kgxl14YNK3fjCvhOp26Hgv1bj4Zc60/Xm3Vu94qlncCu6eGn52eTp00FCafRCxQDycwt
 G6AaCfS8baCxqCg8yFImV+f1QnkQVBOMtz1Sy1elMzfJJrbuR8MrmIjZqxx2z3EgSchv
 jtgzftM+TpxBjvUIg/x6FIb5+Re4b1QarLLlOdY8kMHhxyOiM6/XCsF4b5xRgqXgbaZ2
 eh0puDvMXMogGzRbpUd5drkqqJ6754Tr3Vf3YWfD7FHtGNymelXH3vZXVtJOuzKq8Sl+
 nxvw==
X-Gm-Message-State: AOJu0YziLTQC4mFj03C774hGg6TFqdIgzzp7/1SSCdSDxGE29PL30n3C
 c3HwTZ2WB5xdveSqpIwDTlGvkghSX6resekKxniWo/lawUhFYJGqp+kvGw3/wyQMFmbkd8/taLY
 m
X-Google-Smtp-Source: AGHT+IFqNWHsXw205B8I3zYj/jPb0BkaF2tGgGAkZfoeauGXAreM6CmpwGcYG3NsUyA2Kp5TiylpCg==
X-Received: by 2002:a05:600c:5486:b0:419:f31e:267c with SMTP id
 iv6-20020a05600c548600b00419f31e267cmr74325wmb.7.1714495731091; 
 Tue, 30 Apr 2024 09:48:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/21] hw/dmax/xlnx_dpdma: fix handling of address_extension
 descriptor fields
Date: Tue, 30 Apr 2024 17:48:35 +0100
Message-Id: <20240430164842.4074734-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Alexandra Diupina <adiupina@astralinux.ru>

The DMA descriptor structures for this device have
a set of "address extension" fields which extend the 32
bit source addresses with an extra 16 bits to give a
48 bit address:
 https://docs.amd.com/r/en-US/ug1085-zynq-ultrascale-trm/ADDR_EXT-Field

However, we misimplemented this address extension in several ways:
 * we only extracted 12 bits of the extension fields, not 16
 * we didn't shift the extension field up far enough
 * we accidentally did the shift as 32-bit arithmetic, which
   meant that we would have an overflow instead of setting
   bits [47:32] of the resulting 64-bit address

Add a type cast and use extract64() instead of extract32()
to avoid integer overflow on addition. Fix bit fields
extraction according to documentation.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: qemu-stable@nongnu.org
Fixes: d3c6369a96 ("introduce xlnx-dpdma")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
Message-id: 20240428181131.23801-1-adiupina@astralinux.ru
[PMM: adjusted commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/xlnx_dpdma.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index 1f5cd64ed10..530717d1885 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -175,24 +175,24 @@ static uint64_t xlnx_dpdma_desc_get_source_address(DPDMADescriptor *desc,
 
     switch (frag) {
     case 0:
-        addr = desc->source_address
-            + (extract32(desc->address_extension, 16, 12) << 20);
+        addr = (uint64_t)desc->source_address
+            + (extract64(desc->address_extension, 16, 16) << 32);
         break;
     case 1:
-        addr = desc->source_address2
-            + (extract32(desc->address_extension_23, 0, 12) << 8);
+        addr = (uint64_t)desc->source_address2
+            + (extract64(desc->address_extension_23, 0, 16) << 32);
         break;
     case 2:
-        addr = desc->source_address3
-            + (extract32(desc->address_extension_23, 16, 12) << 20);
+        addr = (uint64_t)desc->source_address3
+            + (extract64(desc->address_extension_23, 16, 16) << 32);
         break;
     case 3:
-        addr = desc->source_address4
-            + (extract32(desc->address_extension_45, 0, 12) << 8);
+        addr = (uint64_t)desc->source_address4
+            + (extract64(desc->address_extension_45, 0, 16) << 32);
         break;
     case 4:
-        addr = desc->source_address5
-            + (extract32(desc->address_extension_45, 16, 12) << 20);
+        addr = (uint64_t)desc->source_address5
+            + (extract64(desc->address_extension_45, 16, 16) << 32);
         break;
     default:
         addr = 0;
-- 
2.34.1


