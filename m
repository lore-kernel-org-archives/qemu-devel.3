Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F43ECCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8l2W-0001ZO-J5; Tue, 14 Oct 2025 15:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8l2S-0001YV-9B
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:50:28 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8l2N-0003P0-JE
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:50:27 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-789fb76b466so5285456b3a.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760471420; x=1761076220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=do8UyzUEIJB+DfTfzX+BbBSeJfF0ti7mnfUYjckiW1o=;
 b=zJrEYPNTyKbAqxHTlwLe1zOMC4l1q2qNmnCRr0nP83MIxORx4Civl12X560Z8FchdX
 FVB33hEZmiTEnwh7DLHwApEanGeheKexhLBgjidjyAp8tyIbJxD5yo+LB1IBh6JlE60o
 R+2xaT2ZabNsBqISjEmz0649IxAemO5YpO1e4QAalXdnLHkXFrWTnILq0giUZmILhs3w
 GgWwlmpCLRb+o4vxeSWn2kOH06yXvIIiWExndPCtKi6+/dtcAV2q0jFvK/aqJTCtLRpr
 qidUNFNIG/dVaieJrqXCivN9joMWdbZIdKm9cSMmMwid3eHf17dSpizAUjZaeNQNhPCD
 QfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760471420; x=1761076220;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=do8UyzUEIJB+DfTfzX+BbBSeJfF0ti7mnfUYjckiW1o=;
 b=dU+R+ixzFe3BD/x8QliLdkRK+S1e/Z6nj7827fc+qYwy2yUJlHgJWCLyVa9kRkLGE6
 8o8qQ+14kDZXbkTqHP2jTMv6jOkGdC+MxE2Xe1xpS5d5fySmYOC3R3A6a+NZdjvHNqYX
 4+SG9Cvoj6WbnIlYunDJejeKHKxFzaP6c5lsI5OzqN/ZvnUFT7n8uFtofDGZlQfd6qAR
 jhmZkkXHI02rpb+THJu1nIekBzp4sGs8ysO/Nn6AyJNMSbDlUS3XYh+quhMPeEzz0Akl
 mZaysL29F2DkPjcLk4e8z2zV6xmmtKjpKADbr2YD3fRFzddVZckSLsBh8gNdx8I+vBxA
 CEHg==
X-Gm-Message-State: AOJu0YzAgeU1hUY/pcHkLwSTqLTaBDSPKl5cDr2+WOKdg7+iYi1RNBoT
 YYCiJsT3vkwdibrvkc8jHk4OhONySGVCtgkIlWOGaFLqsbpSH/zC2bMyZQGqr7UkDPDStKY6Uzf
 dgxp6dOw=
X-Gm-Gg: ASbGnctHJgnHaibfHtnowcPWVTjRpxtjucjd4Pxl+UPH8egusdvh2TrhefjPYldCS8Z
 P4gn+3eB8wAW/8uI8nacnPFbcjC4AFhRbFouO6OHeoNZ66a9dIun1Ki3Mxyj/MicHgXfhcml7N6
 GnYqcn6yADRJcdCiuZfLO9j614ta9vycR7D+OM5fH5zUiqp2FFOxlY1lCZqVZaQFku3uASaeXS4
 ig0G9ilmMcyGfIflRXYczdfWraPFc40NkPfS0GXrYSGBn9SZJAspa5qyjmajpKHetDGfwFU9kYA
 BqUjNU2854z+FwBLdaqMMSiQSJ6CigI5g0NimL2L7RbEh8vbMVZ+fPO/t6xWSfV4wQyKtdU6UOm
 cjHaTS5/k6LZQtT3DRVh3o8nd+du1T/2Qj+VDoQeL2GgxLjsymog=
X-Google-Smtp-Source: AGHT+IFW97LMW9V0NOc4l+AXq2rKKJkXevrHjU1WMDP3gfvoq9KfQ/jFPPPUC4LrK3d7DuLiXnRtQg==
X-Received: by 2002:a05:6a00:b84:b0:781:1481:897d with SMTP id
 d2e1a72fcca58-7938763169cmr33795152b3a.17.1760471420348; 
 Tue, 14 Oct 2025 12:50:20 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992b63a03dsm15918727b3a.19.2025.10.14.12.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 12:50:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 0/7] target/arm: Implement FEAT_AIE
Date: Tue, 14 Oct 2025 12:50:10 -0700
Message-ID: <20251014195017.421681-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

This feature adds new registers so that we can support 16 attribute
indirection indexes.  It is a pre-requisite for FEAT_D128.

Changes for v2:
  - Update arm_emulate_firmware_reset.

r~

Richard Henderson (7):
  target/arm: Add isar feature test for FEAT_AIE
  target/arm: Implement MAIR2_ELx and AMAIR2_ELx
  target/arm: Add AIE to ARMVAParameters
  target/arm: Drop trivial assert vs attrindx
  target/arm: Use el local indexing mair_el
  target/arm: Honor param.aie in get_phys_addr_lpae
  target/arm: Enable FEAT_AIE for -cpu max

 target/arm/cpregs.h           |  2 +
 target/arm/cpu-features.h     |  5 ++
 target/arm/cpu.h              |  5 +-
 target/arm/internals.h        |  1 +
 target/arm/cpu.c              |  3 ++
 target/arm/helper.c           | 92 +++++++++++++++++++++++++++++++----
 target/arm/ptw.c              |  5 +-
 target/arm/tcg/cpu64.c        |  1 +
 docs/system/arm/emulation.rst |  1 +
 9 files changed, 103 insertions(+), 12 deletions(-)

-- 
2.43.0


