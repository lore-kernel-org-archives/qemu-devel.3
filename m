Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0F0F8A145
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIrv-0007EO-Th; Thu, 16 Apr 2026 05:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqW-0005EU-1s
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:12 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqT-0007lG-5b
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:11 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488b0046078so75184315e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331027; x=1776935827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zk2oBkFeQmDacXaWJvXyO4dUP0LfA/9Xb17MaMH0S48=;
 b=KWI3gYnYqG8njfsH4/YHQtxefNkUcr6G/iWQpPvBoKswatohzAS/oMAIo1Wi3HOwUk
 SX4taUVGOKrkb650+67vtQHekCIm4VtdAh3JONcBsEp22+XSJ5ioDIzeh1izhIdtn5Dt
 EaBxqB9IynzeDIkq8qLA8/5csLWsABhq7H7MnFHm8G1WC4MFf2hvHz2lBuwj15ReUs9n
 cAZfCZj+sCXYeytAKAyOt5gisn/QviuvcN5WF7j2BDue2no0KdD9yU2Za/tHGFSSsX+B
 3JnEEX520n0oXT2SZIdPNd470DNURmH/oWIhbHRzhRd4vDUk3CjpahVdUbageWlGqMCf
 MtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331027; x=1776935827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Zk2oBkFeQmDacXaWJvXyO4dUP0LfA/9Xb17MaMH0S48=;
 b=n/u2hK6TOXPjwoyawvMlkRYW9/pNz6393mSEh6mc3pcyUtiKmbJxGHjQhhKMYyaMH0
 B2gxRVg0AbBH1K4SaGURDaI5CYmatAew+x3l4huruJDd5aDI8YZG55lLp+T9GiTDt3bs
 zCMrH/ZAlmAMZuMLjRd/CXexUfDIPF5B5aTAa4MBODDcN5tLun+qgNykswqQ0VKGkWrk
 sYxsK+oWCmLt60c5mQ0+vjHqautrcTn52qBshwjxoTF82grpNF170jsEEbLC6WeJLPs0
 QrgYu2ZhXkBR20p0i2pkGbPOTjQ9O5CsS7MX35YZKchZhiGt+CQUb+fT6LhYTLO28S3X
 8W/g==
X-Gm-Message-State: AOJu0YwrScXt+o1Q4F0m+L2FPyk8UZXsFvky6On6PR/tRPUcmX8QjnZx
 3YD/c+g3r/xfZ7H/QDsPxezyI6+Ltk37JKOABZ3PC1jvCYuRUUWXF4y9Arwu3I1o4i2/LWicS6D
 GdncULW8=
X-Gm-Gg: AeBDieu0y19C4FQQakiEiCjTBNAHeShfoWG7LJPDRo0XAVyHRCE6JB3UIZGYAfAaHCX
 phEFCGZJ8FfOk7UD8RVpdLLyOhk0vwdnSGdqMFPJJluqS0wpj8nQJMmLQGbIl+zbwq3fOBp++KW
 yZe3iUDLahkFUcjTDAfy2Wk/dvqCVHLSdmqpkPkQcbxezJL9eNNYKYKHI46PN58z6P90RPE0374
 Gh25qgQLE0Nr0kr0FoS3XlDfFR19F7NURtmhAkj3COoa6mupKru95mm5ARZA3GPutaDCeSHB1BW
 PbamjEWPqdwAOfGqXrablcxvzyYb4BI2FWff1NoxxfBP/6McoUzzLkhAYUiibDwG2+IWhvyujpk
 vn/bNZh7JysMUlu4eT64JVfkpQsaYwGwpHtc2lIyNgFa/3aDWsZWBluOt+h9cEK8BPFJFdKOUoF
 04MY2uThzl1E/SP3cIL2/YD+NOcqoZ8wtrZf+TyxFpzsb+oBmGSj1bglO2Sb/XFo+W3RPzqizO3
 uLnPnxBUGV53EjagApKno7T3gwJcjck8BjHwL1z8g==
X-Received: by 2002:a05:600c:19cd:b0:485:17a7:b9c7 with SMTP id
 5b1f17b1804b1-488d67e3671mr344661185e9.10.1776331027492; 
 Thu, 16 Apr 2026 02:17:07 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/28] MAINTAINERS: Remove Bastian Koppelmann
Date: Thu, 16 Apr 2026 10:16:37 +0100
Message-ID: <20260416091654.316158-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Bastian Koppelmann has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes the Tricore TCG CPUs orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bc7c9b61da..7817a1c97d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -446,8 +446,7 @@ F: include/hw/xtensa/xtensa-isa.h
 F: configs/devices/xtensa*/default.mak
 
 TriCore TCG CPUs
-M: Bastian Koppelmann <kbastian@rumtueddeln.de>
-S: Odd Fixes
+S: Orphan
 F: target/tricore/
 F: hw/tricore/
 F: include/hw/tricore/
-- 
2.43.0


