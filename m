Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51D2C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVEx-0001qZ-3c; Tue, 05 Mar 2024 08:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVE0-0000xO-9L
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:53:07 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDr-0005yE-Gy
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:52:54 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33d146737e6so4410407f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646766; x=1710251566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wRXrQVhloM+AHj0Ylfddl3Ax3AHnB24xciIaK6golUE=;
 b=EbVoc12S37NzYfJ5YNBFTxoGekvHII/FmDhKVsrVxE7CucYK9eaX41uoh3RAy/xDbI
 kd/FhZ2xhAjH860zIMPU5WSq1mKoTvDrIRy5rUPMQ7Ti4z9Yfx2B3Jw5gw3OBd1lZn5W
 lOnAaOJi2/dgLDDH8uK9UQIqNm2gE52+uEeqBrb0OxtIDrvRyOdHvi+Qg3rezx8JrQVO
 ha1Gr6vkJGBhpsDSg81csl5aBu1SH5KCOwI8sMPa6RhikFSYbyvKAplTSZi3dO3ZPiDs
 bTbwCDtkei78XaX5d3TJ108miVqnleGwi1Xyrkp4CcEeYvAN/pB2VJdFKDvOeBHbOFrA
 J8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646766; x=1710251566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wRXrQVhloM+AHj0Ylfddl3Ax3AHnB24xciIaK6golUE=;
 b=FFe4Q2NM1JQ14ZMO24dQq4eBRv7bZrZsU7H2uPxxmI/OiaB1/ldYuYOkuJ/anJmtk3
 /inmI1/pneF3HSvFBdA/ou8t5MIQtxoTpzbYvoJDh2nK5YmU9B416WQJ7HbqBnHBSiRY
 sF4pLbKC7FLwxHZEUFG2lVe3Qf4PLhFu/jeFpo45qN73n0YO6YC+q97kf98EkRNAoJ2d
 jf0QtQqkK8mreG2FAip7f6vR/2/meFV0T4Cc9XQuD3QzDY9c94tXnwjM7DAR76ttt/q4
 98i6Ci62lQn8RjhO7aYRuNovlbblg22WledEA1plcCIx8ZOGYnE/r8SIS7qlNFcnPK+e
 z+9w==
X-Gm-Message-State: AOJu0Yy1K5ZWsNDomT7jAVpEzcpndlqCH3SDtfxYbyOLV86FkfJ3VLof
 s4r95DmWAAMs5cQU0c5AGFQoH2DDRxZp0lv9ISB/wDUTHkMhq1DCm6svrDE53ffQ7x0cFUEPngf
 0
X-Google-Smtp-Source: AGHT+IGyKh10ll3bg+lQKB76wb6N3uzN8pqSyxohAwgPbLwxizHku9+3rQl1w2MaL7t8OYoHEZUzmA==
X-Received: by 2002:a05:6000:110c:b0:33d:22f4:179b with SMTP id
 z12-20020a056000110c00b0033d22f4179bmr8537054wrw.21.1709646766009; 
 Tue, 05 Mar 2024 05:52:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d6503000000b0033e206a0a7asm11797532wru.26.2024.03.05.05.52.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:52:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/20] exec/memattrs: Remove target_tlb_bit*
Date: Tue,  5 Mar 2024 13:52:31 +0000
Message-Id: <20240305135237.3111642-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305135237.3111642-1-peter.maydell@linaro.org>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

These fields are no longer used since 937f224559.
Target specific extensions to the page tables should be done
with TARGET_PAGE_ENTRY_EXTRA.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240301204110.656742-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memattrs.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index d04170aa27a..afa885f9830 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -54,16 +54,6 @@ typedef struct MemTxAttrs {
     unsigned int requester_id:16;
     /* Invert endianness for this page */
     unsigned int byte_swap:1;
-    /*
-     * The following are target-specific page-table bits.  These are not
-     * related to actual memory transactions at all.  However, this structure
-     * is part of the tlb_fill interface, cached in the cputlb structure,
-     * and has unused bits.  These fields will be read by target-specific
-     * helpers using env->iotlb[mmu_idx][tlb_index()].attrs.target_tlb_bitN.
-     */
-    unsigned int target_tlb_bit0 : 1;
-    unsigned int target_tlb_bit1 : 1;
-    unsigned int target_tlb_bit2 : 1;
 } MemTxAttrs;
 
 /* Bus masters which don't specify any attributes will get this,
-- 
2.34.1


