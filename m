Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F1CCFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 12:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQP5w-0006bl-9b; Tue, 02 Dec 2025 07:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vQP5t-0006a9-MF
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:02:57 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vQP5s-0006TI-4k
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:02:57 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso23427865e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 04:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764676972; x=1765281772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9e4uv5q1d2YaQMyM4szIP+QDbMQysyaRWjNYB1Z2/0Y=;
 b=Cu7QRGq87M4eiOwXYh3oc8eaa67mROl0CQ7Hlgyor+fPFQ4V9unEOiyE41499qM358
 69OyXgnQrzQZJ0zkdQOZpPQCPZ175+wFnKTtYyxsLgDcs3SCKz8QtpNzeIx31ME0KuuW
 CqiXtxSU8sVMoWsg4AUfksE2US7nawg+opD6oeJXf6pnDrKdYfBZRc8rCwvRfWlFd7qU
 1wC1gb/6Zc4vrBLV4Gg5LhD7EiOHCHZzn1sW97tHVT4kGC6IS4O1VwAcWMRcZcDs6EgC
 /G0Ow9tGUuuNywpszbFcMNJYdp06AyKdtoEsq3PfyCdOMunGSXg6P2ITfifkEczQIRBR
 Faig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764676972; x=1765281772;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9e4uv5q1d2YaQMyM4szIP+QDbMQysyaRWjNYB1Z2/0Y=;
 b=sh1kUOPWXYJcjNrzwdQe5A+4fVEL6LFXEIepblncOc2v4/TzK5HaY7a43y2J1kd8Sx
 52/VL03NzGJlneeMy0EgaXJYC2xckAUjuhjE2s471wK+zp6Bsig3F7NwHVEMJjA2jKJe
 qndGCjxua/OY8L0Nhs1k0W+c7kuuPdwvjPVBHTcEvIDmCTVXb2Q5zCF2oq31ORHxvRpU
 qBLOLeWr+CugLT4GQBqXbk/jVcKve0jSynVM6uQ2Id92M0ez1Hc86ilPq1J8JXz5rQY7
 nTbAx5pIemVz0+rjKD+KmDm2QQAKPSCIkYKIYaU/mGshz/DFEs1qNCGUIbVRtnnX5tRM
 Rm7A==
X-Gm-Message-State: AOJu0Yz2rhG9KQLAvxPTbyZCa0dpqsx1+EBq5tQo4Wd0egAMXfZAFJqH
 CzEVt+DsOWj0BnFATaT2hxpWl5dV4IFu41v/mDP+18Or679UoX3Y1cSnyHgthAAQRV6i+iMd2cM
 Q6CBT
X-Gm-Gg: ASbGncsTYjvcYntf4mEcVbDUt1id2LDh8VDzcX5Bq4kDODJrMW07XTIHLT7++dZWDqj
 w1iuTOBez9jyp5OtWTiaMtUtYLjw3NPBpLMuRqrj3mxhBOksTYAMGuztW88Md5mHkUiqQA29bKF
 UGF8dj5Lif0E9If9EY44mC2c2IMxMNjeeQGLvcadJjmbXrzz18mBblBm1/IY+K4Ms2OB7ZV442w
 7OtQROOIqaRwqOpbEEVMhzmiJhHOicQLjDFjbyiz64dR69NnG5kyfjZjAo4ea3Ew3yqMQxPB2Tf
 LxzpYaFfFuVicrI03+ek7Klj60QE5iTjPAVrsnMpjy2wBDJOlaLJmwBAN18+4evVf13CT06czHb
 RVKUEBaZOPxcSRvwuj1EBz7ajNwnFME8zv+9BifNMz7tZh8sS5iy93lLapyofrVoG/hQFr0zVX4
 ZghdXMP0/Hz/1w
X-Google-Smtp-Source: AGHT+IHYV/1aF6FIhNM7ifk56fH0Hg/vkEerFAyXsNKKFqC+d9DjiKpSCBcpSbySUNOkLU0YYpzIIg==
X-Received: by 2002:a05:600c:c8c:b0:471:d2f:7987 with SMTP id
 5b1f17b1804b1-47904b23c04mr271879375e9.26.1764676972164; 
 Tue, 02 Dec 2025 04:02:52 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:d0df:e484:1145:883f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790b0e21e8sm381169835e9.15.2025.12.02.04.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 04:02:51 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH V4 0/4] Basic ASID2 Support
Date: Tue,  2 Dec 2025 12:00:37 +0000
Message-ID: <20251202120250.763150-1-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x335.google.com
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

Added a line to the documentation mentioning that we can now support ASID2.

Changes in v4:
- Patch 3:
  - Added mention of ASID2 to docs/system/arm/emulation.rst.

Jim MacArthur (4):
  target/arm: Enable ID_AA64MMFR4_EL1 register.
  target/arm: Allow writes to FNG1, FNG0, A2
  target/arm/tcg/cpu64.c: Enable ASID2 for cpu_max
  tests: Add test for ASID2 and write/read of feature bits

 docs/system/arm/emulation.rst    |  1 +
 target/arm/cpu-features.h        |  7 +++
 target/arm/cpu-sysregs.h.inc     |  1 +
 target/arm/helper.c              | 10 ++++-
 target/arm/tcg/cpu64.c           |  4 ++
 tests/tcg/aarch64/system/asid2.c | 75 ++++++++++++++++++++++++++++++++
 6 files changed, 96 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/asid2.c

-- 
2.43.0


