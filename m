Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D61C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 04:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuOx3-0001xo-TN; Tue, 18 Mar 2025 00:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvb-0001Es-9t
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:50 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvX-0008TT-6A
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:46 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-225477548e1so89195245ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 21:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742273499; x=1742878299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FSHS1XcppE5ZPP6nkhpeNl/9mIWtetza6WviZOkY9i8=;
 b=X9VkslHAv5ETXYPuKPXk/N2vU7upsoRkNAoC9EykVv44DanNuOHy8NwG9ukf+JMC3f
 dVxlSoVrlelk/s2AUrP0ATbz9FspP+WPdSaAOSu/B393myIuYZS8/r57/UoDSaSnBSGg
 QIAmR7tUpUpvIu2rOFwiT9y7bLZiloPTIc2FhnVwWvyhDJq++SBiRj8vthmUI4TTQDXI
 GwZH40wkxT0V5+w/oZx9MgBNIXMwiywvYZbBs4Q0AAFRivLgo1ubxaffMk0geKVefVWR
 hzzETPrEzDr7607lPnyHFh2lFGOCzQiUnofjN3COtPhR3InIOqCRdocKo+nII/FM4MHJ
 J9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742273499; x=1742878299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FSHS1XcppE5ZPP6nkhpeNl/9mIWtetza6WviZOkY9i8=;
 b=nWBvMGMaOcJn4hnEzHgi9F+vlvFWNBfCRr1P7jKBZEGcnRQgHoWbHyjcsRbkbJr5aM
 6uKt9w5OrT4L/S7btTHFS0Gd/PcxQeMvHzzIMeFo9wgIMIqJfM92vK+AYTutGN79tKiY
 EWWnZYSuRlS1fd6cfC+NkJuB7fAm0KdjwMCT8Zt4SJoV1jh+BfaASrSfsguH96fgJ296
 Ge1brwPX1K0kW8SVZOM07NiFXKv4LMRKzlzYBbXKGtB6IMPNGKMOf1gP86FMylb3rr8I
 L+gGVFpHB8figecWEEn/JfJw+0z1ihidrYpgZzqoDc+dmWb+22MbyPltFld2mUVSqQ5v
 lViA==
X-Gm-Message-State: AOJu0Yy3OD+wQZIYf9pk94MKmm3kh7bArz8Lz/ssOORZEFPj6TYGJabe
 6nbpCrAAy8yaKOUyaFvjMay/K7HdzA7SLXEagaD02wDegIYcFkrdpnHL6xreVLpDeUr9eu3qKa3
 r
X-Gm-Gg: ASbGncunEg2STYc6brwSx3lGGMzgcEWXv+f640hmoKGw4dWjxFXnWX0K/Pwb4ffEuJj
 wnL6mHsqxa86w7UoOin/IvtpRkAwygj1fJEEqRErhx4tCaxkRQF4DIn/Kxi6ypwGouw2Bgphttt
 92un5SURyMKdQ8xG6VA7wCdoGiAnyZZfsj3QKQjXP2Yxihox/KwFgkXGEPvZPAP6hIeyTUGFVxp
 ZVlstp0e095ryp8jWzTYD3VGc1c2L49EH4GYfbsVg7Rqn8o20BghdhdXJrwiqDrpeQBvodNWC3I
 LBRWyAA4IxeqnCsMAfzTrOKZ15KpEsbBiPATH2spB1+k
X-Google-Smtp-Source: AGHT+IGLHGqHmqYs4ezZCOm2c2SvTDjQRRs33WUEidalhqMBp81xlxxvFOnPgr1sAs0uuf26mtAqeA==
X-Received: by 2002:a05:6a00:4649:b0:728:e2cc:bfd6 with SMTP id
 d2e1a72fcca58-7372240beeemr19161977b3a.18.1742273498760; 
 Mon, 17 Mar 2025 21:51:38 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711694b2csm8519195b3a.129.2025.03.17.21.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 21:51:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 06/13] exec/poison: KVM_HAVE_MCE_INJECTION can now be poisoned
Date: Mon, 17 Mar 2025 21:51:18 -0700
Message-Id: <20250318045125.759259-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

We prevent common code to use this define by mistake.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/poison.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index 8ed04b31083..816f6f99d16 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -67,4 +67,6 @@
 #pragma GCC poison CONFIG_WHPX
 #pragma GCC poison CONFIG_XEN
 
+#pragma GCC poison KVM_HAVE_MCE_INJECTION
+
 #endif
-- 
2.39.5


