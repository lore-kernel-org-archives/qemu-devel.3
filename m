Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421E7D2445A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 18:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRDiq-0006Ae-LS; Thu, 04 Dec 2025 13:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRDij-00067L-R9
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:06:27 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRDig-0005Xo-3L
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:06:24 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so17646435e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 10:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764871580; x=1765476380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hk3E/G3TtM3kQeaAdUrGJUnqDzsbnBr4A1SrgJAYixM=;
 b=t1U84H48o3sU8u6nXx9o5IHNfUUmfVHaVXG7pwwdHjZT6UQXvjIIdJkyP+lpr6gyM8
 umUF+nl6OzzzYY4QLTHkTmxvUasD/HHYa99aiI/6039B7h+3r6m84pHrvasP6C0mZaPJ
 9f41gYTu1+zTwwB5ekNzJz/ZvcSrlAarkvfIfwjwePbL+Us0XDjydLGK3b2fiLemfxn4
 qNJu4TLfwE6kXSE0KkNwH0t+9rCxo1A29OvKC0glvt4c8pG8Z5gOPr8MZ/LN5XF0vW6c
 b0GmKcUYIqtlCbKzSHHP9RgwWh7YyPS6AbG+0gGrKM0UWKGoSYeHhXxFRkssSjCKdZxX
 cERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764871580; x=1765476380;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hk3E/G3TtM3kQeaAdUrGJUnqDzsbnBr4A1SrgJAYixM=;
 b=A+tVpQuBAxjviPuGs6d4SDdUeJBOcUPjqvlpx0yvDfOPJG6HntEK7pG6PgiBasDG0J
 4tuMjVKlUAtzlQWQplSPwh11w+1fMk44tXpZFchBblYvBivOfgBQSgtZJ6Z1pIZjtIS5
 EhvI6hW9s1Enqt3c2cHq6rp5bW1q24WTgSr/xwLJR7Ic0oGsOLqaGnJlO1s+Wv/ike9Z
 4Kg2lQNvHWT1uogbfGc1NNCxbQlTHbfdOqMRTb5pczV0Fp/41ztR2IeeOpt78EswisLy
 /GqhxOr52koRgMf13gxsLfg0Dk/uHeJHDe1bHMASS4l5ko+jBHMbFzpbodGiDO5640yN
 Ocuw==
X-Gm-Message-State: AOJu0YzhFOfEl0doj1Y7y9Ilz/VGq42ZjyRerKGJAX6cEs7BI/iQQegp
 LFhi6k+29lfUxy4ChKyq7mRDAn2gimOqiNg3nd4k+VJbVCFtbGV0arjEGnt3Q10sN/yfK3l+7HZ
 stMQe
X-Gm-Gg: ASbGnctxNAfC0Y1QoF7E4JhaHaAFoYGC5H+6NEJqp6dJ5S/dwpOg/C4T4BOKGfN7Mv9
 /wu3n0cfk1LGq+44d+LiVPPzC/Ysl9SHI/vZyZxskTzwCATX00H+1kCcCyN8eoUjssmDiGgYmR4
 RjptYVvue2zTmEEQapM7X1pPABARnv7BVDo83bAj4aiasJORjDJ/QboyEKRMtwIuhAPANWpy9qB
 FqAQdYbU5IsHBgc9b0wT+6QggsyFCKAvSX1iX1qlNiYrH6qtbygRi+nfmGfMDGP8dv0ll+HZ24a
 Hut8pg0j0uLQd6bjra8uxL4SRc94Kmgf7UFdY+O4X1qvuudQoPhpx86eQiXOYVbbY4bZG3SSDVi
 HaHQm0mWK/wq5WHu3iuS/2UKab5UzLT6MyI5mL/4tk2+A3BW19Yyd0uBhy2gLqjPaTGNxNW3aHy
 4grv+4DGvmLNzM
X-Google-Smtp-Source: AGHT+IGT6fBqmOZ2BIyTZ0zFe/DKRKQLX5UV6/tQ+qHSij8MJDs/FlgUCI7mTPrKqlUy4b2LgNyH2w==
X-Received: by 2002:a05:6000:2283:b0:42b:3b62:cd86 with SMTP id
 ffacd0b85a97d-42f7951494dmr3798111f8f.6.1764871579661; 
 Thu, 04 Dec 2025 10:06:19 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:d817:b2ba:2766:5b2a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331e29sm4589641f8f.32.2025.12.04.10.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 10:06:19 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH V5 0/4] Basic ASID2 support
Date: Thu,  4 Dec 2025 18:04:10 +0000
Message-ID: <20251204180617.1190660-1-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x331.google.com
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

Thanks to Gustavo Romero for reviews.

Changes in v5:
- Patch 2:
  - TLB flush when A2/FNG0/FNG1 could be written to.
- Patch 4:
  - SPDX License identifier moved to first line.

Jim MacArthur (4):
  target/arm: Enable ID_AA64MMFR4_EL1 register
  target/arm: Allow writes to FNG1, FNG0, A2
  target/arm/tcg/cpu64.c: Enable ASID2 for cpu_max
  tests: Add test for ASID2 and write/read of feature bits

 docs/system/arm/emulation.rst    |  1 +
 target/arm/cpu-features.h        |  7 +++
 target/arm/cpu-sysregs.h.inc     |  1 +
 target/arm/helper.c              | 22 ++++++++-
 target/arm/tcg/cpu64.c           |  4 ++
 tests/tcg/aarch64/system/asid2.c | 76 ++++++++++++++++++++++++++++++++
 6 files changed, 109 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/asid2.c

-- 
2.43.0


