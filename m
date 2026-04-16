Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B579AF8A149
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIrp-0006Pv-Qj; Thu, 16 Apr 2026 05:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqX-0005Eg-DO
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:14 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqV-0007ll-Nf
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:13 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488b00ed86fso78446525e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331030; x=1776935830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zV2uiR7SfVRL077nitikNiDqS4eL+l9e6twA4037I2s=;
 b=EK7Wd0eOoTJAieFoz/7rmCpb7ZyG0+O1yCLWloYM3mFABGRE4S/Qz32f+IYvGlMOqG
 ps0Ttxi0bSAr148TVKTyqIUhbz1m8LpYzbteCiSZ7ATBdwqyeAmHDAqvD5uiGYL2pSuy
 a9eCWt3OBShOhqIklQqFDokgssYgRBrDSTf8ooaqn9GNJb3QwxHieqHlShxJrn3N2VBH
 Nqee17Lo/Z/2l5TbQQHakZxyHUiQ4iGIBglUPFinMsi52Vztx0rI6U520LuqeN1ZPh8R
 zdWF7Bb9EDDKA352gO4DdWLSZFmpaxhf7eKR2/BSx0B++i/HOE6GUAti2JesVA0n5v7g
 CdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331030; x=1776935830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zV2uiR7SfVRL077nitikNiDqS4eL+l9e6twA4037I2s=;
 b=o8aAUi1ibQCddRMWh6GzjcJpj4043pCR6+3pwCmHnIsEZPfVJ46/wFxRKwCuKKPWq6
 a6lM/IpD9SZo9SEkj23fgMzm5mZfIudt9Lg+ffeTQWCOFrxZA7uoHdM6rLvcVNcAuEkw
 02oC/o/bttObvUCbf7Urmeqv+TTjul6H7dUSo8EVhmbFOPjI78NfB6uzDgaRWFyyQOAU
 4qdCi91hBPkZo9+w9y8Z8lvu7IkT2313YDMybPH/sdFqTatI1HDn7eZ4t7FbmK6qjNrK
 KCWtl/7V1VNFcIPyn9XFUz+RnVEwy4g2XdoJHMt8qjbfGOC3pNQyPRC6AAtcFavK9bWS
 HDCw==
X-Gm-Message-State: AOJu0YzAxtTcFbDUEY9lvJ6rwD7QXXEZGntdyN0L2f0//z2BB8IePKxr
 wQGUrmze0JuN5EbO8GxjWzWidbIk/SiNwwuHhsklIpjclMRKFQxipAqz/bvzsZhnI7Ult9Zxx5l
 B7Nq3osM=
X-Gm-Gg: AeBDievp68jCqSFsMGTbFBgvRK++0mz2p0XAdO0BHjNzydmodfKYOYQmeMtzhFJbl/N
 y2aA5wcWA8rZtRz2kY25fTHUbP6oldNeJ8Ojwa14+S+V1aLcMVf3SXjbIHQHKlM+tP8/0oqECy3
 f4XGYgZDCVfe6cAjaq5x0Hhu/A4Fgjp3gHiLQiBB3apQHWpD+s8BjFyloYUirq6DcUYFzigpfrm
 FHqubiXpBs/ntWeUC7Fd6W7qP7Ho8n080pZo5a0lRdEoFaeBrRgaKrKTg63p1+xg/Pgg9+psTtJ
 ZpioA1Bp19INnnDOM/FfGeKHNa01Eo2A/R5j14dN9lbr0RCpJptMZ2Lcn1Kbh7Rkuj1ACii0Trc
 F4w/89vFmTOJ8878y/KEbzmokO2UfmPY2xgKTAqVBZbUuDu4cCTOWljdbWaAX6+R24jHlCMdUIo
 vdeCO1bvh/m5hobFY0RaR/JARTh/+m/z15TsxTRIJe/w9cWU4MayityGnebFGVnHpT0PZRGLkmU
 2FItc4nWi/IWlFvRIVNMD6D0ybj0+5YQ5+uQEvltA==
X-Received: by 2002:a05:600c:8b6d:b0:485:9a50:3384 with SMTP id
 5b1f17b1804b1-488d688209dmr322164715e9.25.1776331029749; 
 Thu, 16 Apr 2026 02:17:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/28] MAINTAINERS: Remove Magnus Damm
Date: Thu, 16 Apr 2026 10:16:39 +0100
Message-ID: <20260416091654.316158-14-peter.maydell@linaro.org>
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

Magnus Damm has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f5cfeeb239..86e07415d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1780,7 +1780,6 @@ SH4 Machines
 ------------
 R2D
 R: Yoshinori Sato <yoshinori.sato@nifty.com>
-R: Magnus Damm <magnus.damm@gmail.com>
 S: Odd Fixes
 F: hw/char/sh_serial.c
 F: hw/sh4/r2d.c
@@ -2879,7 +2878,6 @@ F: docs/*/*xive*
 
 Renesas peripherals
 R: Yoshinori Sato <yoshinori.sato@nifty.com>
-R: Magnus Damm <magnus.damm@gmail.com>
 S: Odd Fixes
 F: hw/char/renesas_sci.c
 F: hw/char/sh_serial.c
-- 
2.43.0


