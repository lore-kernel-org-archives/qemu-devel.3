Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09077F8A14B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIrx-0007Qp-9s; Thu, 16 Apr 2026 05:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqc-0005F8-L8
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:19 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqa-0007mV-FL
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:17 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488a041eae5so57672865e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331033; x=1776935833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2dJ19r2IfmxCT2paequ891P8+GxLMo/EW6WWdMo/Wrg=;
 b=qLFzbzxnbqvMjJnOrLLBSWQbuK5wwD95r4aNJ6BQ6ITFmNAtXobwL8LD5DUg5culkU
 0SdCpykj1YHWdozYb87U+H+0wdAmSG8wrm0/Ma89c8+wYpbfzXcjCRI0iZ7G3szVT+Yy
 c32bvZBOKg11YcLllwyFP93tO5j+evPoJBivUhFl3vI4AL/vGaXuvYWFuCCSSFJ+lAxB
 r3IbCOSIUhyAGqvR1jKOI2NIhYpYQ3/zAfASq42A76ffNnEQuLKF1FQM0bgY/He7K4Av
 a9YIFxMLfvTtYhCDsYFHrBIM9+dEs4biSUNRCN+dJGkF8PNriMVGO02B9h6omnTozHuq
 TE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331033; x=1776935833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2dJ19r2IfmxCT2paequ891P8+GxLMo/EW6WWdMo/Wrg=;
 b=BBwruR9D4bCmjjADuSCI9Ncf76MZYiGsU1HJX4Usj5ghO681QFskcrSeqbNWEftDCg
 5L7kB4Afjl2zVc5LJHYf9Jxoon3UPXURCE2AG5ob1x1ezS4N7iyK8KvhOrroAAw4a7xc
 hkO8MBH+WrFABS1oaDskFr/GZXusWAlPr7t7ocVzKJDhPmZQzqCwujj94P7rlHwhlXY+
 +YhcD1z9h9hb18d0YWarK7UHPMGJZ7ftzaG4uWWNtiqmagC+qbabGK+aGklMozU+iRoV
 c2NGoq5Bh4b3P89f+6CPspAf10Er/oX32oYDczwgj0i42dVXoS1JIS9jwm/9L46zwBWZ
 cFcQ==
X-Gm-Message-State: AOJu0Yy3rs/jOI51rFIztJ4fXtLdewb9HKEVEqi1/ufjsxkbDgyRU5qO
 aRAvD7WGgmUibMSD4OXjH5iawpp4C1hBvzHE9Cf384GPkaVaFDOtjVGtyhcMZ7LCeHJ7VCpDwIn
 jFzOkKak=
X-Gm-Gg: AeBDieuVGtMXRm+FBrK5QeiQREiTx/BK1UD03/G7ezryFiLaL98YWInymtz9+29LF0U
 KggV6VDoFT3G7ZvUAc4Jvf0NNhS7j55ewnZZTvg6LiIgo9FH8DUmrEkgb44/eC5vcuCsgETV8uN
 ucBA9OHPTIa2uGQ83KmFMb0AG+X4l+MBBM+bh0uHz6fFCoeT1ZTj5HieYc1f02XfwUEwlEG7NEz
 vyYAmA6DipbRwdgZ18h9H57A5Os3xZxITdqIbqs5ge8DtL8K6A3EVNEt/smuK5XVP45t2myQMan
 S9+nM66o0Hdf2Pn5TW/db/D/SlqEl/VGD7NU14Uz47J/8HpGZqDI0oFF8c5IUNY8/6c5+BYnAdK
 0jKd5FXt0+xFrIIqlou9IveuVoFSICXFV10Xw5qcKBoyTaGbbSruHn9hwDTYGlQTpHLNUnLPi/G
 Wwp5uO+tcqM6N/HGjK0/PDEygQNOhLC9BDe+tmPluTW0JHIC8uGwrm4nNKkBBTV0Fn1NsWlQ+RG
 dg1bvKTgsm0ZugufZ1659oZWAZUCzb2Rk+sD3MZdQ==
X-Received: by 2002:a05:600c:c0c8:b0:488:af14:f1de with SMTP id
 5b1f17b1804b1-488d67b8de8mr258714985e9.4.1776331032795; 
 Thu, 16 Apr 2026 02:17:12 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/28] MAINTAINERS: Remove Paul Burton
Date: Thu, 16 Apr 2026 10:16:42 +0100
Message-ID: <20260416091654.316158-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
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

Paul Burton has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6cbb1e049a..a7a345c514 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1486,7 +1486,6 @@ F: include/hw/intc/loongson_liointc.h
 F: tests/functional/mips64el/test_loongson3v.py
 
 Boston
-M: Paul Burton <paulburton@kernel.org>
 R: Aleksandar Rikalo <arikalo@gmail.com>
 S: Odd Fixes
 F: hw/core/loader-fit.c
-- 
2.43.0


