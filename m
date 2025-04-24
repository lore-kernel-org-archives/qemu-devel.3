Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03196C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kua-0007eh-Gj; Wed, 23 Apr 2025 20:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktk-000671-4B
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:57:05 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktg-000599-2n
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:57:03 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2243803b776so7566585ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456218; x=1746061018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fw918qmxQalPO99dinob5iJyGANUib3+dTX4jzZTubw=;
 b=GXDGiJZMthY7Q8O8FIjSL337DKfkq+iCVHLiRVkAl9MNsMsFVaduObFo4v+t7SdxEe
 Q7MZ/uAtBZ9W9w/uNb3XO+8WfQjsm0E5kpAev3g9fJ/xpLehmYKt3sz67GuamISAoGbn
 XngyG6ZIhMBo2alJALiW2XXqcQO8e10YJy/nLoq+3F4m45APln7LNLFFfn9a40qWIbE1
 5M54W3xpMP3DncnMZJ1hOmkiqG6OYKxgzXvn22iVLv/qRTBW7MiPLBAamJG/bRQ3dyWV
 dQ9n/Z1ZctOiF+QQ1YOonu9synbqBrbTm4J8zGoR6kls+f4LT2g2SwFzjZLGuXbuFYgD
 dAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456218; x=1746061018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fw918qmxQalPO99dinob5iJyGANUib3+dTX4jzZTubw=;
 b=C1LtXZLSkdlNzYIH4NRbE2sHHOeEqafVomMfKMpbn5LbB8Eikb25evXl9xFKmjpX3T
 QcG+C1xBWVVQfDEajfDS8b4KmlQbeRbsOs106zl1A4Co/eg52ZaAOZn7USDdACfSkSd4
 cHgzP0fa5RYnE2vIe9CWuGYm19JJVx6muXWuKnt17UZDxivrTMg1sxHm9zyk8bVYFtem
 BKJom72Q9z2z7KmJNhv3D0i+rs7VOhqoGidDn62OwGgVAnjoC/B/AFnQOtVJZEhFmIM6
 nu0DJJIVBZ1gwMtTqN0DbzABui/qUxBv+CragwGK8gdgvBRkuMsKStdA3X0S9/sNyQnu
 HqLg==
X-Gm-Message-State: AOJu0Yz3lUh+2HD3SfU3O2aM5DZuhv663emYNRujCd5dfeS+82aYFsrA
 Pv4owgpYR6iG0mECLzFm/PAQ8DJJokO0RRieRB35q+hH+HiJ5MHKNmEzcn8xGq+u1+p5Fm7auvn
 H
X-Gm-Gg: ASbGncta7G13NaCOd2PXj6GQf167lcc12VnYn+tJ3+eVsuu9bBmkq4TRnaA1IJVA7b0
 nFdhD6ZIg87ItA1B+7ek5bImArCHYDN8fZl+yrsoNsX1zoQ7g1N3hKazX8LDbIrh0pUJDbfKt3I
 XaJ3kQG4hXxdPCzgo2+GTiET5N2/Fg9m00gULmfK3l0hneBwb7EwiGr5mVukRd7NWHkhBZeTbZz
 QTWKh3VZiP+EppjpyVvd9iyBHGVR0HHYSr9asPORN/KfIc+xi6cVueBRcE56olDkwFFMgzCOr6O
 ZzMA/KKKsHWdfZiDsxXbr1oyxxOuxoyQbuxvf0h5fxaMfEZB42SX7LY7hLWWiSO8EI+ZNFLlLVQ
 =
X-Google-Smtp-Source: AGHT+IFqWRBBTSTRnKi1GgDcDjI1Ta4m3nZRTX5iM7luuC/yc84aJ38aBvJxNI9brHLUZaGwz9Rs6g==
X-Received: by 2002:a17:902:e846:b0:223:517a:d2a3 with SMTP id
 d9443c01a7336-22db3bdf635mr7970325ad.17.1745456218118; 
 Wed, 23 Apr 2025 17:56:58 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 115/148] target/arm/cpu: always define kvm related registers
Date: Wed, 23 Apr 2025 17:49:00 -0700
Message-ID: <20250424004934.598783-116-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This does not hurt, even if they are not used.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-20-pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a8a1a8faf6..ab7412772b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -971,7 +971,6 @@ struct ArchCPU {
      */
     uint32_t kvm_target;
 
-#ifdef CONFIG_KVM
     /* KVM init features for this CPU */
     uint32_t kvm_init_features[7];
 
@@ -984,7 +983,6 @@ struct ArchCPU {
 
     /* KVM steal time */
     OnOffAuto kvm_steal_time;
-#endif /* CONFIG_KVM */
 
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
-- 
2.43.0


