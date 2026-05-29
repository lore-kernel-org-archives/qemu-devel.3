Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF8ECD6E50
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSyKI-0006Lw-S0; Fri, 29 May 2026 10:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSyK8-0006Hi-6C
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:36:33 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSyK4-0007SC-9N
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:36:30 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bdd1986cc86so1171894966b.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 07:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780065386; x=1780670186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xNjQ8ATolvxkQnQXFaFGJLRrymYi+CqagUpkaiZh+jg=;
 b=j2ziEQL8Jo5TBMvZE35oYdcJJ4stscusWjlL+j5aYwLrGnONhY50ESwXX+iMsz4ipt
 VdMEhIfrPSch12aouhc97jZnXHiG5i2+o4kaGARp+RYtzDxxdjTGel1jluDIchHRdR0W
 7Pk0AcUyI63xDU9hGUhfo8UqvGLDgli7gNwkgt/SzPoQlpzIAx4fURPTYPl2bkgtfSm1
 8hsG6SR2/v1JG99yOsaZ/Fl4eVoABtoyJXd6dx+iBd+ZjQa903OXxX4726vd+L7HqNCu
 u+096eE2f8l1hBxnK1tQhTgW2HNpHimCfFQBEtr7hcAm3FAbCj5rIddl4HHbPHcMaB7J
 QXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780065386; x=1780670186;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xNjQ8ATolvxkQnQXFaFGJLRrymYi+CqagUpkaiZh+jg=;
 b=H+4yBCAT3/Yby3eF9eeIiQiebDJn0tCtru+2Zrj6ZUZS3t6i+TPKPuALWCHsMUty1K
 WLRoHYbDJxSSctAUC7zK9cPpr+nXQlWIcPl3qkbixw8XUapzq9U44L8mT2rsNHcAVLyL
 8ptyAdZuYnUM/F5wa3nF2oXeBpFANfHiC6MvrOZSvcBTGoE6VOcJoZSToijJ7UzEhtfc
 RVAg9oxnD0xwJJ4/aUcc+W4tCls6buC+GW4wICulGBZtMfm1qyhozYwHzt0uOzV3eSfR
 dFPyLFz9k4INhZqQ+iCInBA/ZCKfKMHH2prcTeHHIY0spzvCiB6Afae5uQTRe43casTI
 G5zA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8imfTKaDu/GtnPdH5sU01moQZ3LfCV5+qaTInbMFzjM9PLNej6CUuIH8wVmRz3IrY+070WOEm1278g@nongnu.org
X-Gm-Message-State: AOJu0Yy4AHXae0XOa9VIPMJ8QjOTfE0BPd3a1cSfzJYV2zgqxwKjIlbz
 xZKmplYDtYtd9eRRlTCwqVcz1re0wVyl9WjKX8OMJksqGhgGSqNMhfHZPuVDotQ95vDSPfrGUx1
 J8sRk
X-Gm-Gg: Acq92OEudauJe6r8cdKvkjfnlwpq+zFyrLeyvtNobvsbc+UHPxsG5UnVV+i5StREfyK
 ygqD/LWOgSc094+H9DJ8gkH7ROpriv2qvGiRBWiHJL+dEriMmpJ+X8FH54lM2UCMsGgMyEUT44n
 D+kEeiR9xTUoVyBnvFv2xUxUT+k633BAxGPmMuioqwg2wPc2jyNt5HHLescyZvz0C4IefY01ely
 rP0/HXEdfz1D29Hurcnc5Nd3KrOqfNpjxexl0mJAE7WvaKlVi9K57hT1E7ximCcU+zwy0ZVUm+9
 ZNyN4igHyXJvhw94wvMYdrFSk3vEfmbBK4Ab0YsbqV/T3Y3Zs4BE7ECSYlicLGkYBzykZrsH+uT
 uzlhKpoNMFK1rhPZLRrLFculJVntonROYVmCAyl8GTcB6UY2tUuQXJie4Wo8Le7NGDxvXdZRSvN
 ojF0AISEWQ9NUba4qAde+MJLyFVohVJAOU4wGyr7XlIktaxG47oHyrK6hppr3N3R3PECNw4eV3m
 NqOtz/tGMaNufVc1g35tdzLnuuoYXKSo9ZE2UR12FU=
X-Received: by 2002:a17:907:2675:b0:bdb:2fad:4811 with SMTP id
 a640c23a62f3a-be9cab1bceamr139303666b.28.1780065386091; 
 Fri, 29 May 2026 07:36:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef356a4c4sm4180675f8f.31.2026.05.29.07.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 07:36:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw: arm: use logging rather than hw_error
Date: Fri, 29 May 2026 15:36:22 +0100
Message-ID: <20260529143624.158935-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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

These patches switch a couple of older devices away from hw_error()
for "guest can do something wrong" or "guest uses some feature
QEMU doesn't implement" cases, replacing it with qemu_log_mask().

These aren't really very important, but I was at a loose end this
afternoon and they do let us close out a couple of gitlab issues.

-- PMM


Peter Maydell (2):
  hw/intc/exynos4210_combiner: Avoid hw_error for guest errors
  hw/dma/pl080: Don't use hw_error() for unimplemented features

 hw/dma/pl080.c                |  6 +++---
 hw/intc/exynos4210_combiner.c | 29 ++++++++++++++++++-----------
 2 files changed, 21 insertions(+), 14 deletions(-)

-- 
2.43.0


