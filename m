Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81841C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 14:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVJu-0005dj-Kk; Thu, 01 May 2025 10:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVJt-0005dR-H2
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:25 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVJr-0005QL-D2
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:25 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-224019ad9edso16152175ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 07:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746111321; x=1746716121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6ERfDcpD0q610+HtPkmuutwyCXat3qEAtdpeWLrgOMg=;
 b=sQ2lYBJefnKhkey6q4f4e3GqNOS8W4QmeWUSCrD2J1Hq7sX/dbKZa8go2IU0WG1TbM
 Wfx13Oy/cKw0BYWYC3EtszE1bn8qjiYbPzaECsl+v+w3siyj5YCIOAmNcK1lmL9dI0Gh
 yzRK+VRmZJ0u/Bha5n3FbQgrxoNl2FJ6Lsp8R+6UPo4LR1TQJLNLVECec8ETN7jJMqyl
 nc2hs2qyEP/Qs0xZyNfR6i/RAYbGKkex0wmQTIkV1w8eusYgdpfcW1x3GJEwWN+toJAa
 iGFRCzp39Xqg0PkdIMiRxTUPsPa3Fv1BKONtqvqbtOmSYwnsOKo9iSwCqX5ZsuPMY3PV
 eYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746111321; x=1746716121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6ERfDcpD0q610+HtPkmuutwyCXat3qEAtdpeWLrgOMg=;
 b=i3HpmT48V+tB2NRaPKE3zlNnP9Ij1odwLsjjT81hulmoug99MYuNG6von+b6pXFu1j
 kE53VRB/MxGEq50LyEPTntonOxOx4GHYhaCiMrBYqqz8enRocdr27cZk/KXwLNxYUryb
 fKw2WS3D+fAPN3ZmydWi86T6D+Kjp5EWy+qIW0p/6iwrVRMPbeWTrsH6UPM1BVNagq3x
 mQfC+FDFs3eboR22fWBvDwLytaf6VMfjFLlxSw5lT00M5FGUOiJV89atEWAIvqCH1xI9
 kI0l5U2KJFUJyGyFc8n1UMeZlLo+5b03JBFPYtgtxUGDnw+B8+S8Tp6SSz3OX70dTpWf
 UpRg==
X-Gm-Message-State: AOJu0YwFemFehzy9fyfkXqh0Tri3GdA88wDcpwL2tp2fptgqvDqpu1v2
 mbA52RWwAfZI3LktsSMulIh1ECS2Zp3DiOovz5feyY05uHg+qYhIryR9GVU73zS0AaVU92Yqyah
 W
X-Gm-Gg: ASbGncty3D6xSCyxiMxhsRlXMEEKgsxcpdn7sFEJdMvaIQjli4aL3IDikWsD4CZ2tKa
 rOw+/+cKXukwUj0cpDtcPyUdG5m4IVDjMkQGfId25nMpLozWlXKXaD8qW9uflq+lFe8JSWl2cN0
 rrNLpOXCfO4d/qiHJl3JiBaun4x9ynwjPqHLOc0cMbV9aIOFgovPFJVobE3wfqQGyxdZLExtBQk
 iqdehLIdBU0OfujNoJ2VXFdjX5Er9+uaKyUJ5o6ArcByqxE+b7WRnXfntco0mKG4rEYPqpx/Fpr
 PUsWxPOHhtFqxTkDMJtHdNqzDuskrXZFmmexNg/T2b5LaCiLScH8HGihk2Ii55wYrte0/RHALCI
 =
X-Google-Smtp-Source: AGHT+IHESq5aOD9v+3FVmBN/WemxdCRWcXRywvBPpxEtRgPzcXTxfJp/fJWC/orYMWXSYnJ3ded0cA==
X-Received: by 2002:a17:902:ced2:b0:21b:d105:26b8 with SMTP id
 d9443c01a7336-22e040a3212mr47724025ad.7.1746111321101; 
 Thu, 01 May 2025 07:55:21 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bb0e770sm7644415ad.92.2025.05.01.07.55.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 07:55:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/11] accel/tcg: Finish building once
Date: Thu,  1 May 2025 07:55:08 -0700
Message-ID: <20250501145520.2695073-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Based-on: 20250430230631.2571291-1-richard.henderson@linaro.org
("[PATCH 0/6] accel/tcg: Build translate-all, tcg-all twice")

Adjust the final two files in accel/tcg/ to build once.


r~


Richard Henderson (11):
  accel/tcg: Move user-only tlb_vaddr_to_host out of line
  accel/tcg: Move tlb_vaddr_to_host declaration to probe.h
  accel/tcg: Use target_long_bits() in cputlb.c
  accel/tcg: Use vaddr for plugin_{load,store}_cb
  accel/tcg: Build cputlb.c once
  include/user: Convert GUEST_ADDR_MAX to a variable
  include/user: Use vaddr in guest-host.h
  accel/tcg: Move TARGET_TAGGED_ADDRESSES to TCGCPUOps.untagged_addr
  accel/tcg: Remove TARGET_PAGE_DATA_SIZE
  accel/tcg: Avoid abi_ptr in user-exec.c
  accel/tcg: Build user-exec.c once

 include/accel/tcg/cpu-ldst.h   | 24 -------------
 include/accel/tcg/cpu-ops.h    |  7 ++++
 include/accel/tcg/probe.h      | 16 +++++++++
 include/user/guest-host.h      | 49 ++++++++++----------------
 include/user/page-protection.h |  8 +++--
 target/arm/cpu-param.h         |  7 +---
 target/arm/cpu.h               | 36 +------------------
 accel/tcg/cputlb.c             | 28 ++++++++-------
 accel/tcg/user-exec.c          | 63 ++++++++++++++++++++++------------
 bsd-user/main.c                |  8 +++++
 linux-user/main.c              |  8 +++++
 target/arm/cpu.c               | 27 ++++++++++++++-
 target/arm/tcg/mte_helper.c    |  4 +--
 accel/tcg/ldst_common.c.inc    |  4 +--
 accel/tcg/meson.build          | 10 ++----
 15 files changed, 154 insertions(+), 145 deletions(-)

-- 
2.43.0


