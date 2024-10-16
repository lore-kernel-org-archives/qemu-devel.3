Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED7FD2A543
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 19:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t19kI-0002cH-BQ; Wed, 16 Oct 2024 15:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t19kG-0002by-VK
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:31:44 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t19kF-0003nA-2s
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:31:44 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20c6f492d2dso2154205ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 12:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729107101; x=1729711901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jvIR58QCYBZMdE3s9ffnpI9HyypOXKW1og1THMmS8H4=;
 b=sczu2XQRktIWGXsR/C41ysMqwPqaagx3wrv7+2w5+xNhUeBEvUc/n7anFEhnQrmtBu
 49mUvtf3sDVcYBSlZGR2IkpPgyWu+e/hVzUT1L8qiXAHcfZj4CzmAgbzPrZT2wiepVd8
 A1w4hbt/vLtUMPxHREdPLDQSb7tMztB3PmfTSssRfbdR28nk/p0Gcxu5PQ97wFbJIyYB
 /Na/78JT0CNPyHckDJoBgA8jN77/dD2kE2m04BD4APQ6raLMLbjO/hopsgY52tFDUw1c
 plt5ZpQ2Fdfpwsh8NGJhmqqXMcnkeezXnpKNMJd2lRR17uHS/H8DqRT/1Je5n6YVcksL
 V+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729107101; x=1729711901;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jvIR58QCYBZMdE3s9ffnpI9HyypOXKW1og1THMmS8H4=;
 b=MH+1/rRy58Ds5gCzWzVFrGzRABFfm5CCl1XGA6gQdm0ISgXggWVM+6+Mk3+jAg9Jve
 4L+NiJlIvs7KP/v1Xa7xQzuYRAcEquyR0EafvPm1C9SH3/JbW6cbUcvX19wBUW3IG9yA
 YbAe8L6suZAMRfUzLH9+4wBRg3Zm7Zi+9tqaSDUc0xv/+Grdaglja5ILsKExHAVsYteI
 K3gW2QooyDA5UVRS6iwWERBEwrq2ezH1L0g/t6+0dDKMbH+AoQEqeNLfSiroUO020WwW
 KqW6qbPgUbLoLjS8eOBv4PTo6Us+R0m4InCPM3J2QzLL8P6J9jqNL62L+1NbRgUIOx9r
 QEMg==
X-Gm-Message-State: AOJu0YxYFRKPPvOYQOto7AGOivzEV2+IOe8ejKdQiaxQKAOs4edXGUSY
 km7SQVg8d5DMfG4KRcbZ1Vtufm3ooZSlgHy46h0wGQoG9plHiCneDlY89LWPKG9VbDMz3+EKKKh
 O
X-Google-Smtp-Source: AGHT+IEa9223NNXktfkxq0Z5eqB9S6GT6hutGy0qNFA+BErBbqacWWwUDuYtv32o8zvGxYNjyj6DCw==
X-Received: by 2002:a17:903:22c7:b0:20c:9062:fb88 with SMTP id
 d9443c01a7336-20cbb1a983dmr235631805ad.1.1729107101463; 
 Wed, 16 Oct 2024 12:31:41 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1804b6b1sm32323945ad.189.2024.10.16.12.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 12:31:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 zhiwei_liu@linux.alibaba.com
Subject: [PATCH v6 00/14] tcg/riscv: Add support for vector
Date: Wed, 16 Oct 2024 12:31:26 -0700
Message-ID: <20241016193140.2206352-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Introduce support for the RISC-V vector extension in the TCG backend.

v5: https://lore.kernel.org/qemu-devel/20241007025700.47259-1-zhiwei_liu@linux.alibaba.com/

Changes for v6:
  - Fix problem with TB overflow restart wrt the constant pool.
  - Fix vsetivli disassembly.
  - Change set_vtype to precompute all instructions.
  - Extract one element before comparison in tcg_out_dupi_vec.
  - Extract one element before comparison in tcg_target_const_match.
  - Drop 'vm' parameter from most tcg_out_opc_* functions.
  - Add tcg_out_opc_vv_vi and accept K constants for operations
    which have .v.i instructions.
  - Do not expand cmp_vec early.
  - Fix expansion of rotls_vec.

I've tested this on cfarm95, a banana pi bpi-f3 with 256-bit rvv-1.0,
with qemu-aarch64 and some vectorized test cases.

Barring further comment, I plan to include this in a PR at the
end of the week.


r~


Huang Shiyuan (1):
  tcg/riscv: Add basic support for vector

Richard Henderson (3):
  tcg: Reset data_gen_ptr correctly
  disas/riscv: Fix vsetivli disassembly
  tcg/riscv: Accept constant first argument to sub_vec

TANG Tiancheng (10):
  util: Add RISC-V vector extension probe in cpuinfo
  tcg/riscv: Implement vector mov/dup{m/i}
  tcg/riscv: Add support for basic vector opcodes
  tcg/riscv: Implement vector cmp/cmpsel ops
  tcg/riscv: Implement vector neg ops
  tcg/riscv: Implement vector sat/mul ops
  tcg/riscv: Implement vector min/max ops
  tcg/riscv: Implement vector shi/s/v ops
  tcg/riscv: Implement vector roti/v/x ops
  tcg/riscv: Enable native vector support for TCG host

 disas/riscv.h                     |   2 +-
 host/include/riscv/host/cpuinfo.h |   2 +
 include/tcg/tcg.h                 |   6 +
 tcg/riscv/tcg-target-con-set.h    |   9 +
 tcg/riscv/tcg-target-con-str.h    |   3 +
 tcg/riscv/tcg-target.h            |  78 ++-
 tcg/riscv/tcg-target.opc.h        |  12 +
 disas/riscv.c                     |   2 +-
 tcg/tcg.c                         |   2 +-
 util/cpuinfo-riscv.c              |  24 +-
 tcg/riscv/tcg-target.c.inc        | 994 +++++++++++++++++++++++++++---
 11 files changed, 1011 insertions(+), 123 deletions(-)
 create mode 100644 tcg/riscv/tcg-target.opc.h

-- 
2.43.0


