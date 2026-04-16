Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4570CF8A14A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIqd-0005Gl-IG; Thu, 16 Apr 2026 05:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqR-0005Ad-BK
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:08 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqN-0007jt-Cm
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:05 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48374014a77so101748015e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331020; x=1776935820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4Eoo/HTrlv3qZsGgop5Gof5GWPdMqTSPcNcQojp6AjA=;
 b=EEDidTjlzDbnN1AUD9trFy4aQ9AFm5cbiLlEtYKURXp+R41MYMPJe3DlOb/d5pHvdP
 F59+9WQAa28hpM86GmefQEMy65yw4xx//OlhOx9m0aSFkQesz8y4xBUw5xWptSgdxWwb
 D4djUN4PxEvFF3InypEmFNN16k5N1Drd2EsTnk44R6rcNXR5IpCc33x5Rd1X6gZtEqcx
 sKvVWuHTLfrEUduvcd1zYW9TSasbYjh9BNAMMwxkVoEESqEnn859Sj4JQX7BH5yXTFTs
 6/kj+pQDwDjmZRJiEqljiCxwD8lmDS7a0krMAuidrKJWyViCleKPyakyXyvonMOQfy6U
 VRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331020; x=1776935820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4Eoo/HTrlv3qZsGgop5Gof5GWPdMqTSPcNcQojp6AjA=;
 b=C1bYXdHch3qFjaqTYf/f1Dh74Z5bsZRG+VOsWXX061rlZZDOOgDzMuyDSQ+5hjw/vM
 V90sWxQGUQzUYuAlK0qhB+1W4xXH79wxMZhkZyUMvsrKEX0E7SmQfcXRrt6Xtt0f52+p
 yBO1djskGonJAOTNaYn7fhnGnq1XLjlyElpMr3t0mjLosBRk5N/KxCl587vlr3So3k3z
 bgJ0tPJilsE6Wo1uwB+yjq/S+1i+jONYVQFwnZpEP146sGpaCV87rtzjUZmHtZdc9yKP
 48EtkI2xNpcOIbxeWcJ8wGoDBKz5vWv9omTJzdzz2ZapFTjkHnUS1Jh2PbKlG3TOb5l/
 5aEQ==
X-Gm-Message-State: AOJu0Yz3TGJRuXVGx5IMASaDNesM9U7baUTWUbGUGcC19xbLtSQ7szIO
 i/v9fODQMGYNDKysvJujE0MkP4xGBIgRH8BG1Q2GVlmIbQWHT67mFgGIKB/earDqwGwG3sMfb82
 Gf+eeXEw=
X-Gm-Gg: AeBDietodRkNZnINhx3YUMNLMi4w22UKcFuqetOU+DCAGNRTQiYhwSeZdi6Uymw9iAS
 m2btoESaDlyi0vtb+GjpA22cfY7ydq4RFhyZsOmMIgj/OUpyB3t7XwaShNSpmm3fyjk5700Qgmm
 uQVggupC12ayVVXgecWUPog7QxisMGSa4g47x48yBliBJaaCePNN1AJWUrEC6pxCpMSDpo1FZWF
 hST6LP2cAUrPShdqS7bS76IZ2wpH5zr8Y27pGhpKOtMTMWv1hy8cm/+Uml8ngVG2wE0vvQ92hkr
 LHCm9sfif6VHaPYHrQJGHrafSBwyfyXNf7B6tvBmdfeuiIyLFVsBl915XnZrUXtI0jy3xyyH8DT
 S/zEHjZ7EekCZ/QuIFc2t437mQ1qcEGd7+3sP4nw+sMcya7Ap7HbPZrY/SJ3vEFPC39qTylKIiz
 jcP0rbzqfMc8IY4dw9fnenZ4CqRNpM/uoWu3HEW281+K+0UWKJJRWDYTZeJ3QSJ8jcHGCN77gqG
 yqsuy+k8gK1hny26gmtyc7b0THJpncghaQEgYhsyYBa+4jxR+KU
X-Received: by 2002:a05:600c:30d2:b0:488:e192:6fb5 with SMTP id
 5b1f17b1804b1-488e19270cbmr192508475e9.24.1776331020122; 
 Thu, 16 Apr 2026 02:17:00 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.16.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:16:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/28] MAINTAINERS: Remove Jeff Cody
Date: Thu, 16 Apr 2026 10:16:30 +0100
Message-ID: <20260416091654.316158-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Jeff Cody has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes the "VHDX" block driver orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a5dc03b93..9c57ad7661 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4178,9 +4178,8 @@ S: Supported
 F: block/rbd.c
 
 VHDX
-M: Jeff Cody <codyprime@gmail.com>
 L: qemu-block@nongnu.org
-S: Odd Fixes
+S: Orphan
 F: block/vhdx*
 
 VDI
-- 
2.43.0


