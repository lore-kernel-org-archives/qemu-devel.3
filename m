Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D2EC83F34
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 16:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueckQ-0006dq-13; Wed, 23 Jul 2025 12:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ueckN-0006ZD-D0
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:55:15 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ueckL-0007CY-Al
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:55:15 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so293185e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 09:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753289711; x=1753894511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TSSqnF+/AnLbbiFDbwFnSXG1BHUKqc9hNcz56nYG9RU=;
 b=uWQhX9H7VkG2G5xOCBCwu4x4KBMLwUq9+WSNMqHEfGDHag5tP3vRfQqxlxVF3cYuP1
 ndJ6aH92sItIBYnQwbH7AQMaKrAfyqlyomCTldMmjVy0zvKuRFk3AuFNX+KrDZ6kdSsA
 g7QE4Zwq50TiTOaByIvt0DyMA6rZvbadO7OA3C9niZs9tO8ZhjY3DidT0I4B8Y+OygEo
 7q8JKthvAjSYCOhB0qYTleKI7WSz+nNSELCSdGp7UJGHAD0NveOETmbO64N3Uxu/YEhI
 sFw7FHeQ+14j2o1Fe2QwTngjElJWLSG59g4hIX+40c1bWM3bJoaLOfXMEJXqnwkVCNay
 B4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753289711; x=1753894511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TSSqnF+/AnLbbiFDbwFnSXG1BHUKqc9hNcz56nYG9RU=;
 b=OmDJkH2V+3s9dWuh85sm7Js6MGDKBr7mfesgQyUC0veFovcnqd+qywRAAJfmpCfKpx
 wb/G9OrXapO0DdVwnjEHnteDQqRbyw92+yXDh80KIBSCpeeIQN5VTybnvKmSMWnhIKKh
 luicVCX2vZWJO3Q6vqjME8ZjVlVmWRgdqJ7Tp0Wo+0RpwViDR+bI7Y37qkYtfel4fyF5
 jVr7qe8dwYqsPKk9rZe/zUuF4BPgUH7oh2AgpCH6aBablHUkvfO+5p9gQPnsTae2QLdx
 vR9n9BNcbuiNDAzUsf2kuRq/ocPS+IEfeEpVmFP63FoSo8TEz79IoGWN28DJx/NLzicq
 spAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7FuwuUB5pYjDQoYRUKMgK0jtqMnYXKxwL6NsKBlt6ikM8OBmI/04YmZB7IOHQpiKht8FPhXIgbDa/@nongnu.org
X-Gm-Message-State: AOJu0Ywk3cHNydAgkd/MRlcxw73j7zhyon9DnGz6F1AbbSeFHZQeNI6A
 LciV2g8KUbo5QSIlbafp56Y7vUGMfa5giCiZ3V08BVGcwplLSs+P3DJ9enJsFNF+X1N7KnMM/aD
 yjySj
X-Gm-Gg: ASbGncsGE7lgwryCPnJWW44zIJHG05l2Ql1ZxFF9umrBTAsuXXrEesr93TfqB3Opdtf
 2qzWGCji0YzPHAm9FCBVWrxQEJ+amPqR5TEFyXKIgGXlQ5t5ArpXMpQQo6XRuLvlEb4wtsHu2Sh
 G5s0wbThRGAemC3GyEDEW93pdwENagZigZQnD5vhUUOJnTni64pkImClBNqqmnpoVW2+6Z9ljzV
 sYIDgILilRnCmb83X+74PpxF1+IPR5TM9aQAx/V9hS8Qb3PbIJmPDJRK121jQv5i4vUg5LLPvAy
 opWZCG7cBAeurLlDxJZ3j+ztiIvjqldfc8apOzKuWT+BVCmJsgCqORAlYTKR8hkqa1FlWpU0mfK
 kDwRvLR+hvASMYrEt2qcoVpR4Dmkn72I7uENyCTc=
X-Google-Smtp-Source: AGHT+IGH7cxCrVcNJGmUuVExdHaGCE4xgRpV4YihEuNUy32SEWElQCbzk+28z/NwH/+QLbxcVvAniw==
X-Received: by 2002:a05:600c:4f05:b0:458:6733:fb59 with SMTP id
 5b1f17b1804b1-45868d4f124mr31899645e9.19.1753289711496; 
 Wed, 23 Jul 2025 09:55:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458693cd224sm28559825e9.21.2025.07.23.09.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 09:55:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-10.1 6/6] target/arm: Fix LD1W, LD1D to 128-bit elements
Date: Wed, 23 Jul 2025 17:54:58 +0100
Message-ID: <20250723165458.3509150-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723165458.3509150-1-peter.maydell@linaro.org>
References: <20250723165458.3509150-1-peter.maydell@linaro.org>
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

In our implementation of the SVE2p1 contiguous load to 128-bit
element insns such as LD1D (scalar plus scalar, single register), we
got the order of the arguments to the DO_LD1_2() macro wrong.  Here
the first argument is the element size and the second is the memory
size, and the element size is always the same size or larger than
the memory size.

For the 128-bit versions, we want to load either 32-bit or 64-bit
values from memory and extend them to the 128-bit vector element, but
were trying to load 128 bit values and then stuff them into 32-bit or
64-bit vector elements.  Correct the macro ordering.

Fixes: fc5f060bcb7b ("target/arm: Implement {LD1, ST1}{W, D} (128-bit element) for SVE2p1")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index c4aaf0cc45f..c442fcb540d 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -6439,8 +6439,8 @@ DO_LD1_2(ld1sds, MO_64, MO_32)
 
 DO_LD1_2(ld1dd,  MO_64, MO_64)
 
-DO_LD1_2(ld1squ, MO_32, MO_128)
-DO_LD1_2(ld1dqu, MO_64, MO_128)
+DO_LD1_2(ld1squ, MO_128, MO_32)
+DO_LD1_2(ld1dqu, MO_128, MO_64)
 
 #undef DO_LD1_1
 #undef DO_LD1_2
-- 
2.43.0


