Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD60C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgU-0007ng-K8; Mon, 29 Jun 2026 08:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfy-00072i-L0
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:24 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfw-0007aR-LO
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:21 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4720d22c94aso1281030f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734479; x=1783339279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lVp0MF5AxBtesKNoIwmmBsVx0j0PXCsXmpRHhAE5wSI=;
 b=LvjWsKNoQnMUMDdz9jxtJERndH5c7C6TjHO8UIgknyDhvmJhGFPnJLBOTrvidtpVUM
 IEWzqAgc99DKrahnMJEjDLVYSOPaGjh3ILONVLr/HauCqIThcasVB1MDLS/kIUhnb/J8
 A33wmBIum+VGgF9WJKO94PJCx2tlTJXEubh1pDm2frnnEhs/gvL2WAzRefjj+acb2PSC
 ghe4H0yxjVOSPARY9TOB4ssQpmj4tgBcu2qiVue+QHfEAsNKI/r7SouD7ZJog/7uaSTC
 oiHfpcQEIrF4Dl5lt0mdeI/QvGnAX3r06lPoDtylGTdxW2clGFAnXZ7ngxzm4JPM55uo
 50AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734479; x=1783339279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lVp0MF5AxBtesKNoIwmmBsVx0j0PXCsXmpRHhAE5wSI=;
 b=W9o8OTStEEeO0NjzfNmJHg43xGCPE5ZYRUVEae+rb9DqYuSU4t05YR4aPbCnTn+94i
 9fmU8erxkWpDanF37255AyMG+KxjVpd+/QxdRmhyJelXxdQ9GX/xRl24ugkX2r0R8Ue/
 x3ErXoFJEOkb1esPzaq2hiqx5vWrWBIGoNMJMMseuTJkTpYvP2nS4pZrAJaEQukjA5Qr
 fORrSbg7pOcVJ7gt/ms0ioWbNccA22uifoQcc1SE68eYnZ2Sje3VSYVrl88uMDA5yGUU
 J+Fd1LDHayIxrqbYpLsCrW1ii2DnZYK77PcT0qtEEtu34DGuz4+GCvh+AIvEpzzy0rYk
 c5Xg==
X-Gm-Message-State: AOJu0YxGWzaK7XiT+tksSmsmTjfjJpxVO3RXVtsYlh/tjEeGCRt7b9OW
 Lt+7fnSHPI6SJV5iX4OGBMBwyIhRbNfW5slDSmrZDk6Q/sgWSd1w8bE8MXu+9RZBhnpZPfE7Pt7
 tzVzK
X-Gm-Gg: AfdE7clLTNC6mpCE4vpzw9JEMcrCpfV1MVgWwy3vrAbFzKjOfUbNaQ5R8lKhy6BMXVT
 hV45CPUCTsgeQS7VehN4qtulm2xtLSqxoskWzTG/p/9gTuFQimS5mKmcwNMqBQbdDDK1vvO7DzS
 Ls54WB8q03eVxc+IyfsaoEkZdbSikGMkKp2LSQHZDlamQLrij3sLg9yMNnOa8eIpJTNqL9v2hRW
 HiT1xELOV/YeXsYkoB6e2WWjxILObtI/2b/NcRx238ToLpTlMRfcS+kG6F7A2xuGOyjlCluxkIk
 7DgXoGx9KFNJORxDn9Dcv/ZAwy+1+NAkWZdFjGiH3gu5eCbXLsPnXWu+FtbDAUF+GXuymhV9gqb
 cghoPpzarv7J+7A4DaOR9CPJi0BCL2AnEwRfx3BVeJgztRMd2N/j8Vmfs3A6kh85NEUwxjAS5WI
 UAvvSsc6WiovuZLyuX8gI6GXJMTBpqQpCBcSdljzj3f7fOBnPaVqEEqJ5G5DqSxvM3/DrnIOY1c
 wNzwxghBLAjl0P/lrusdqaEBTb0MtQX
X-Received: by 2002:adf:e188:0:b0:473:1ccc:15be with SMTP id
 ffacd0b85a97d-4731ccc1754mr7075416f8f.39.1782734478871; 
 Mon, 29 Jun 2026 05:01:18 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/54] docs/system: add FEAT_ECV_POFF to the emulation list
Date: Mon, 29 Jun 2026 13:00:21 +0100
Message-ID: <20260629120032.1645265-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

We already had this implemented since 2808d3b38a5 (target/arm:
Implement FEAT_ECV CNTPOFF_EL2 handling) but it has its own feature
name now. Add it to the list.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260624124527.1018912-7-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index a3a1607ff9..6b02bd829a 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -60,6 +60,7 @@ the following architecture extensions:
 - FEAT_E2H0 (Programming of HCR_EL2.E2H)
 - FEAT_EBF16 (AArch64 Extended BFloat16 instructions)
 - FEAT_ECV (Enhanced Counter Virtualization)
+- FEAT_ECV_POFF (Enhanced Counter Virtualization Physical Offset)
 - FEAT_EL0 (Support for execution at EL0)
 - FEAT_EL1 (Support for execution at EL1)
 - FEAT_EL2 (Support for execution at EL2)
-- 
2.43.0


