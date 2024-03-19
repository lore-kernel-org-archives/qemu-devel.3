Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4198DC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 05:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmRk5-0005YK-CX; Tue, 19 Mar 2024 01:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmRk3-0005Xd-6Z
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 01:10:27 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmRk1-0008G8-Iq
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 01:10:26 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4140aadfe2eso16746875e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 22:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710825023; x=1711429823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ucpFIq95XGQD+XTDk/kf76iNWRMaho6XDtchMvg0EnA=;
 b=F9OubvCBiDMZG8SHLxvjjVtS1188T2Dv+5Yverz5zKoSJwlSyFkWk0DvbprSnOmtpF
 LnMRlIGhAycpI+mfUKpUY6mdsgoppci+KOcgP5L9UUSpKfFVUWW2P2fK7W8FbnjzsLVi
 ufYXV/pvy1L2icMSCYO08VMKoq3+1cIc4FT95K5NpUVHOzuEtS0TVRQxIMbEqOrCLPgu
 rr37/UvPu431crYTFwjqYs4jABYf3b9Ek3X4oBTu86v4pkQj7MomQla8fJJiysuBtjkv
 KdfHVuhA9YKMOXf/71yYf7mNSn3OMWs3o4OtVatm3gtMbToyvgVQMvrWHP9TiEdR+e/E
 J7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710825023; x=1711429823;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ucpFIq95XGQD+XTDk/kf76iNWRMaho6XDtchMvg0EnA=;
 b=bH/Obg3GsIxOnAYuA3k+bCK89YbelUV0v5P+RmROPRLkNh4jCV9wWiHeotvDvu6Lxv
 Z6PfWVp+OBQG0ayNTsMkM5TNU6lNLmGd3I7dpQucMtEhjiq41Ph3xKy3K2Isp2cdjlrl
 m4aWqNJ+OyFOnyhX8H9XAIoAAiKpB6ZTl2WvN13RwQnodUdrXLAafQ5W8aTK46Hl0o0G
 DaJ0B+xNWnxsZiqcWzNPdXbf1117xSnKGIvlGLHoTEpQB2HFOBBaLtjytlwdPiMNejOr
 CN1E4RdGkdz0qcrp+a07RZpVrIriWKlPRiUd+OFvxo/OiPclEuIZHKg/pRVG3j9ZI2os
 1CWQ==
X-Gm-Message-State: AOJu0YyR2gr41NVjOYRVrsWAk2yx6ZdT7Bl063xzyZ1YtIhun2eydH0B
 eb2YcnN5AhwV4zapsAEO1J/jsJceq69nxOSbjagYjEGpOEqjxsmDJVmxfZeGq3auqjOl2AYCM9g
 t
X-Google-Smtp-Source: AGHT+IEKZWNOlEt10auwO3wQqNvgo9wTSgMIPunJ4TiKpMgRIx1o0Iw87XQWaglYvYxSURjWwnLLyQ==
X-Received: by 2002:a05:600c:450e:b0:414:653f:26cd with SMTP id
 t14-20020a05600c450e00b00414653f26cdmr362003wmo.18.1710825023511; 
 Mon, 18 Mar 2024 22:10:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 jg24-20020a05600ca01800b0041408d77ae8sm9368279wmb.20.2024.03.18.22.10.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Mar 2024 22:10:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Leandro Lupori <leandro.lupori@eldorado.org.br>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/ppc/mmu-radix64: Use correct string format in
 walk_tree()
Date: Tue, 19 Mar 2024 06:10:20 +0100
Message-ID: <20240319051021.6752-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

'mask', 'nlb' and 'base_addr' are all uin64_t types.
Use the corresponding PRIx64 format.

Fixes: d2066bc50d ("target/ppc: Check page dir/table base alignment")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/mmu-radix64.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 5823e039e6..690dff7a49 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -300,8 +300,8 @@ static int ppc_radix64_next_level(AddressSpace *as, vaddr eaddr,
 
         if (nlb & mask) {
             qemu_log_mask(LOG_GUEST_ERROR,
-                "%s: misaligned page dir/table base: 0x"TARGET_FMT_lx
-                " page dir size: 0x"TARGET_FMT_lx"\n",
+                "%s: misaligned page dir/table base: 0x%" PRIx64
+                " page dir size: 0x%" PRIx64 "\n",
                 __func__, nlb, mask + 1);
             nlb &= ~mask;
         }
@@ -324,8 +324,8 @@ static int ppc_radix64_walk_tree(AddressSpace *as, vaddr eaddr,
 
     if (base_addr & mask) {
         qemu_log_mask(LOG_GUEST_ERROR,
-            "%s: misaligned page dir base: 0x"TARGET_FMT_lx
-            " page dir size: 0x"TARGET_FMT_lx"\n",
+            "%s: misaligned page dir base: 0x%" PRIx64
+            " page dir size: 0x%" PRIx64 "\n",
             __func__, base_addr, mask + 1);
         base_addr &= ~mask;
     }
-- 
2.41.0


