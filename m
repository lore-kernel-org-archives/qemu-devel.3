Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB2AC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 17:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgnCI-0007E0-Sv; Mon, 06 Jul 2026 13:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgnCF-0007DW-Cb
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 13:33:31 -0400
Received: from mail-wm2-x00.google.com ([2a00:1450:4864:31::])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgnCC-00045c-Sr
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 13:33:30 -0400
Received: by mail-wm2-x00.google.com with SMTP id
 5b1f17b1804b1-4926d058720so2380645e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 10:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783359206; x=1783964006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zevrqYQwxxyNIsO9ojLtWVYCmIAFc95qDtBjQPwzzUA=;
 b=CIcIMnrWYVlsICnZeM2U2eMXVG7viSyS/O87FBYh2clTa0uWNcoe15/RDQ7kOzyl0C
 v5PtVKx2WpK/3Is4wdR436FoIPXo3byEIiVVbA/FU391C5MkRwlu6dbl+GHDYEwr4Q/Q
 8HXm5KyRuNP+krs0RvibCi9BB1NtbYRoG+Qasuj+W/VTItpnIVZf1iRDEho8wBvnjw9L
 yFt4BvrGYHt4ZmPkGDVV8xbej5Byalhnl6QYwT93ZdO1eix3L3HNUTNezCAY8wJuVBhx
 VZosi7KZw44yUrujvk+2b+ensCFeLdyssXaeNnDG2H5lfwhEEzzTMXsWNhW8YaTnVBKA
 +D0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783359206; x=1783964006;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zevrqYQwxxyNIsO9ojLtWVYCmIAFc95qDtBjQPwzzUA=;
 b=R0era3YUTlgby6098p/gMrVZ030Unk1bwjx4nH1OGKk1v9ZCv8SO+vM1cZpwHPyk+H
 tW+NSv6N7Ls1n0l3RNOI79W7WJJfQSCFTRui8sPMCQ6LL130sSfwCQa30A9/LeQceCTn
 Z3SX91QvukqpRzAiyTkkHZ3cpLXqWxhDus/zv6QLFDvmZs26RxynrkjvDUebbZ/JBlEJ
 g7HRDlC+LoRT0oxTvXdZ/Ju/iPs9wbarG2OXzrAjhDiRop1yBJ0Dpx+MmAyqUguBhEvR
 6RWwSww2tOncgXKcjpayiDuwBlfDOrzWxyyoFefViNoLDFSMWv53grVnDlXTvNpZiej8
 zTrw==
X-Forwarded-Encrypted: i=1;
 AHgh+RouR54pXN7jthAi4qS7MkBm5QzjgnTDD9++Ab8XSnnVCV6fkPriZCu2T0P0pIWQFFynHKsKMRS8evUu@nongnu.org
X-Gm-Message-State: AOJu0YzCHDQUQYbOAChEFc2DFDUcdmbzwEdAZBBQSo30EaebadRWUW6P
 5PVDmv9Dq87M/n8h/6KoiN9zVOud/tpQshLHN2Ct1F3ugtiIpkylUCCL6FfjvxIAJZM=
X-Gm-Gg: AfdE7ckjtp8P4BpdzUSDgXq+FJ42K+dUK9l5DajQpCcC9p9SNnMDDIvc4D6ImscS/D3
 phKY0Kygt6DANTUdVYX87c+HENCBPP8+aXGMvJ2ffLZiX7vGRxUOr/D6Ae2XvFOo2rWrvy0ISQ4
 9iEMy3p1mjKy0BBuql10Obw9GAM7W2V7pMcTQEm8NER2ihBztIXPU5MpS1g280KFk63BGbYDWPD
 YtQRPAXXaoMKs5ssoimVKUGwhIbSnw8zS0s0SRtKILGB5jOIRh1MrXxcNwMWpqLh1IC7RLW0ugH
 s8d+/CoGD/dKG5FSxhTT3kmylhkInXWtlTF5GhBH7EIXkhLIr6FY8eKAeEQJ898aVXzUrK3dSUq
 SMgDvPycpM+Uxhx16+zTouzu1jBpMXjRA94DoxcMUNPm+emVihKcwkcGIaYoeWAfjWwV8IHwQQJ
 U2ikH7InTq4GVd1y+XoA9GCqtHuSaXJxaSb9MEaPRW7zIbIkd9C+HftoRiZtkzlTWbGB0jfeOpc
 GnzW4CIxAfjApIF7fFuRg==
X-Received: by 2002:a05:600c:821a:b0:493:c432:f48f with SMTP id
 5b1f17b1804b1-493df03d458mr17599245e9.0.1783359206093; 
 Mon, 06 Jul 2026 10:33:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e006b6besm467365e9.2.2026.07.06.10.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 10:33:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/3] hw/display/exynos4210_find: Clamp windows to screen
Date: Mon,  6 Jul 2026 18:33:21 +0100
Message-ID: <20260706173324.804340-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x00.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The exynos4210_fimd device has a setup where the guest can program
both the overall size of the LCD screen and also the corners of
"windows" that define where the guest memory should appear on that
screen. The current code assumes that the guest is sensible and
puts the corners of windows inside the overall screen. If it doesn't
then we will try to copy data to an address that is outside the
interfal framebuffer memory that we allocate to be the size of the
screen.

This patchset clamps the window coordinates to be within the screen
size. Patches 1 and 2 are simple refactorings to make the third
patch easier to read.

This fixes https://gitlab.com/qemu-project/qemu/-/work_items/3795

thanks
-- PMM

Peter Maydell (3):
  hw/display/exynos4210_fimd: Factor out finding screen width/height
  hw/display/exynos4210_fimd: Pass width to draw_line functions
  hw/display/exynos4210_fimd: Clamp windows to screen size

 hw/display/exynos4210_fimd.c | 54 ++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 15 deletions(-)

-- 
2.43.0


