Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53696C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 22:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaMaN-0008Ms-8y; Fri, 11 Jul 2025 18:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaMYZ-0007P0-2W
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 18:49:39 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaMYU-0008Lg-B7
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 18:49:25 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-73afbe149afso1339791a34.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 15:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752274158; x=1752878958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YI3COkHr8iN6ZiZaBxW0Jd5c0UbnphQ3x2NypN3ngdg=;
 b=TBmsc+RcBJ4D0Vaao/543Ht96+847qobVBvPVd0gzjX+5IT1XFckJA1G6oQB66rzWO
 1AfPDxCHIH0d3kGfE6SKnkWXViYHGXzwnRNUTCCpq1UfFcUEwQlqG7NBNVLMXUlWQInq
 zIbJClYhIBhoBDTOEJEpo6K3sbyXw6+6FILoai8rDzvOwLDZMzNl3ZL33N2qdT1XS4na
 Galjws1xqPocDB1gGVH9M9jCPAkWRUOkRzXP2e7j645b40HrXhPF0gynwKYVe1SWvGjK
 3hWN4gqjpnWFO+ZqT8I/cYBsBK+19HjQiJQiju25AEGsvfD9hOpG6n79jO9/Givev9ab
 yBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752274158; x=1752878958;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YI3COkHr8iN6ZiZaBxW0Jd5c0UbnphQ3x2NypN3ngdg=;
 b=siOfL1cxmFNgJ7BnptLiyfX2kOtZ2bzt42f54Ika3VHlMLkKmnJr54P+kY4dFS+3hc
 mKFAKWe7zju6bGVDVJCEBIY+NermlT0zWcLaPyqfc72s3CyRMjp3mxFSzE9eQrdxfvh+
 HpNbBOhoyojwWKk6sXW0kZYWmVevJu/4ty+vpQGAez4T2npI435qEQILu0htDW74x7SL
 cf7FJfO8cnBUsH8BzxY/Bgrwpc1mGic0Tf3+0/mua3UDZFDcOFeolj66ybmTqCWZhpFS
 +31vf89M8Sbgiy8t+g6TSSx/eXdK5xUmAgHeeA2JaiNBoe9eSGLDzjNFZ3R8PFH9ZUJ7
 8fUg==
X-Gm-Message-State: AOJu0YytP/cYjrabsk2qQOzTbG4BoDnwb91rWcSGsa4VFTQgsqfGwGVD
 8NIAJrjZNOp8VklnDWOdKxxKql7kp0B9rjd4lv3kpvjmqcjjx9N9SLLA5pK+cW8On5eodLSE22v
 CtXEBhIk=
X-Gm-Gg: ASbGnctB0IOAuH3SFRuRCubmNecB0ic+TjleUvBbnGlSn4Ilg/mfsQFbLqQeWZDSPeP
 Cr6hKzpyLPnwAZ0JEv/hqXZGN+3F+w8inrhNvtLCQSAiMDPOAmK1x5t4fyDqos6ai56PYQbyH3s
 XXamxlCYbYkmD+/DEHI9CEwWDMD8HpWyFKSTxluHDSYfGR/L1O3y55Z36nG3x+1eLFgRTzjggO4
 CYO3qP2hmn2CHAazNnCkGQncBdThur4zuKvlcil9H6wJXSJdcGSqZHDKvIoaNBNtbSBz46/IBGw
 LdnzKtHny1snyDvTC8jXIvd/qYNaleGxoyhBK2tv1WSwDq3cHcm468Da7URfWGoSzgu1HdAGFxX
 V0F+qeM8wDanxie29rotVm5/Hug0W1AEVUb+WG5nm1NlTEVDK1GVpy5Q6b4LKObIGgIqwKrfyiD
 iW5PGEZUh+
X-Google-Smtp-Source: AGHT+IHiOk/nudTrx16YoB0mjKaGzpwBRRQcQDPOJ6CeDh1JpZAVD59V3kste1hWqwbc69XJyk+BfA==
X-Received: by 2002:a05:6808:3026:b0:406:72ad:bb6b with SMTP id
 5614622812f47-4153a1841bdmr3373191b6e.37.1752274158164; 
 Fri, 11 Jul 2025 15:49:18 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-414197c6064sm696638b6e.20.2025.07.11.15.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 15:49:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 0/9] target/arm: Implement FEAT_ATS1A
Date: Fri, 11 Jul 2025 16:49:06 -0600
Message-ID: <20250711224915.62369-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

Based-on: 20250711140828.1714666-1-gustavo.romero@linaro.org
("[PATCH-for-10.1 v7 0/6] target/arm: Add FEAT_MEC to max cpu")
which itself is based on the 20250711 target-arm.next pull request.

Changes for v2:
  - Rearrange the protection check patches: 
    - Do not drop access_type across all functions,
    - Replace access_prot with in_prot_check to S1Translate.

r~

Richard Henderson (9):
  target/arm: Add prot_check parameter to pmsav8_mpu_lookup
  target/arm: Add in_prot_check to S1Translate
  target/arm: Skip permission check from
    arm_cpu_get_phys_page_attrs_debug
  target/arm: Introduce get_phys_addr_for_at
  target/arm: Skip AF and DB updates for AccessType_AT
  target/arm: Convert do_ats_write to access_perm
  target/arm: Fill in HFG[RWI]TR_EL2 bits for Arm v9.5
  target/arm: Remove outdated comment for ZCR_EL12
  target/arm: Implement FEAT_ATS1A

 target/arm/cpregs.h           | 29 ++++++++++++++-
 target/arm/cpu-features.h     |  5 +++
 target/arm/internals.h        | 23 +++++-------
 target/arm/helper.c           |  5 ---
 target/arm/ptw.c              | 64 +++++++++++++++++++++++---------
 target/arm/tcg/cpregs-at.c    | 69 +++++++++++++++++++++++++++--------
 target/arm/tcg/cpu64.c        |  1 +
 target/arm/tcg/m_helper.c     |  4 +-
 docs/system/arm/emulation.rst |  1 +
 9 files changed, 146 insertions(+), 55 deletions(-)

-- 
2.43.0


