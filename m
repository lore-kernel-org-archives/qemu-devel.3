Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AFFFCB605
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWei-0003o5-8m; Fri, 06 Mar 2026 09:59:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWeg-0003iJ-11
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:54 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWee-0002JS-Bs
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:53 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48336a6e932so60108915e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 06:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809191; x=1773413991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WmH46hjbMjuCGuK64rW1+BKahR52hA+ENLPSQFUcPqw=;
 b=hKBORA+I0SI9/uGNXAjcL07VxF6w4p83BIZTyo3sX5HQ/0YffBLZ6pCOr6D6e1vt+4
 NghcrtPEUNtkxESjWMSeNw/gJncr6wGS+/GspbJJXEmhHB0F99hc+9auESgLpatb8qPs
 73XtrJyirYVeXbV23pySi2tFGbIKGYEa2KWAIUzlu2GoFz1PSp4OmumHKS3+NClDMASb
 V3FSQF3OxgT0E3/vO1lgqBG+FjPHlzaONESKmv3t957uqSuHgLef8swr5tcAOMnOjvef
 DfT02c9+wgQWEzV+w90JOdGWMPaijQhRugcO0PHF9OkSCd3+6veS4+ymOHdfHyozYXWe
 XujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809191; x=1773413991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WmH46hjbMjuCGuK64rW1+BKahR52hA+ENLPSQFUcPqw=;
 b=XnlbsJp8V2/vM62tnoFvT20IACVZNUPxLRFHe/L6ok6yUbEVH0clubmhJhcbvmNQC0
 Z9gDu/Xfx4oksUo8AtS8RWdxM82uuzCWPeKZXZomNdOy/X4EgvMlgenyhQijvMwDmAqT
 TuIwEgn4OvLxHIubPc2ueWwn+e0JrFSaMBgAe5LhxQ6cJH4Hy3uUrS6pqVoMAWcCVZ4I
 z27lZOBujVcJELc7yJRZ3nsUTAHbsukDI7EtLkTndvH994ltak5jL8S9Q9MxEuEnkAB8
 d/usvd98hsIbq0rsmnIg4YlVEUF4i/rGYbEtY5lRjKzx77J6qyfmt4pifjsENs+fqUDD
 GH0A==
X-Gm-Message-State: AOJu0YzIWGZp5u3fDeGVGHSyqMfnLhUN2FVU904TOtrS/ALdqrjDi8W/
 ltIPZE+kz/gjj776UaP71wTQSD1qoCBn7+t6VjPkNw+VJl6hu4huHUEYatamQN3XBZ+Uh5YeV+2
 IofPa
X-Gm-Gg: ATEYQzxBNue9IQ4LYQMJ0Sf2tN2cqcdpx6gwop62OgeMCzJlLciFDvxin58INrgtVug
 gvdCn0639mcJJAR3Jg8NaOvZk5FfEJSoHRvbsHz6s7ZZ9T3S7sF/1xKkNbxA4gfvq5Ma2i5BxLR
 67tAOq8Nv2voWrSDaSRaC2XvjdcyKwhBNLLt+3py/LGMtNSexwWXK5elAZqphURmNksLqn0m/Nj
 q7HWj3PBGjSCyIJ+1K2jBd/5WgiEIYAqnZj+azNZh/FxqSgOHphRToHChOmB1a8q+bUDMSTtA6s
 GiJP9ID7kBYd15M3zQewzwtOmVUofAUuP3opqqzSpp0Pc4jzdoS46DMl/V4rwDbtyskjTTK/B/F
 8LQqvWRpnUBEerEfQmqhp4ssCp1dk5e2QM7/snLWtcqyqvJnAH2eWEBV4P+gkeea/mbAlepwpXW
 gACThOS1VOn0L7S4K5onPKMprrPfIi0aY6Zpizle0n0AKa+5E3fE8iER39hyupw8+a8TYfoJ8o5
 r72bzEmGhzoCRaH2bNxtPA7cxzSQGY=
X-Received: by 2002:a05:600c:3b8d:b0:47e:e946:3a72 with SMTP id
 5b1f17b1804b1-485269692e2mr41331145e9.27.1772809190848; 
 Fri, 06 Mar 2026 06:59:50 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.06.59.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 06:59:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/49] MAINTAINERS: Update Clement Mathieu--Drif's email address
Date: Fri,  6 Mar 2026 14:59:00 +0000
Message-ID: <20260306145939.2162189-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>

Switch to bull.com email address following a company split.
The previous eviden.com address will remain active for a few months.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Message-id: 20260302143403.1778326-1-clement.mathieu--drif@bull.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57524906fd..4e428dca49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4003,7 +4003,7 @@ VT-d Emulation
 M: Michael S. Tsirkin <mst@redhat.com>
 R: Jason Wang <jasowang@redhat.com>
 R: Yi Liu <yi.l.liu@intel.com>
-R: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
+R: Clément Mathieu--Drif <clement.mathieu--drif@bull.com>
 S: Supported
 F: hw/i386/intel_iommu.c
 F: hw/i386/intel_iommu_internal.h
-- 
2.43.0


