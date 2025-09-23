Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0973CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 21:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Axz-0006HT-Ts; Tue, 23 Sep 2025 17:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Axy-0006H9-MP
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:30 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Axw-0003hz-Jm
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:30 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b551350adfaso4959005a12.3
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 14:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758664467; x=1759269267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=tYlZ2X+dGVCznkgZex2JEgm90i7M9pJE9RNGkKab5OQ=;
 b=VL+imANN9Z+vCPzHJXfgPK736ZfpyldeIo+pNe3KMyHU9WrMjWQRVKgIDb0Qik3bo3
 Kj09K6tOTgt1wqzzLHxKmJ9SPexvp/RbX/aj3ZZwhNxzrYXWxBzkBmFlagtlnshfxFdc
 EuefLnqON02oyTndgMxICcYLoDMTXQBdY0iShKihM/BRWLGqMRPALjqcYqBjMLvxRLaX
 yMpooPSj+0tZtEyjEZmisA4gUft4f6JgGRWQN8NenXLeCLlvflSLDlbVckORH/59m8LO
 69ceStNXI7lDsTyHDHOqkTZ+1avyRSBysrFQRER8hnbU4cmnktiBAQnqoI4Ryv77YB6G
 +B8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758664467; x=1759269267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tYlZ2X+dGVCznkgZex2JEgm90i7M9pJE9RNGkKab5OQ=;
 b=MVzJ6SChkmcsu4JOyPcyX99T3NVjrDjHPM5YCg8o/5wIPxHeFVhEfu141hnzqwEeRr
 90+iNyntailhP9VPSypUyNt8T9WNCiX+XKNvbC3cMtGkAbUJ9Wwp7+GHRZzg32mBCcD/
 cHzETrsGFngSKIrGjVTmIUzr3kubwcZTX3e9LdD5rsCrs+5ZxLa+w+ntu5obeaidZu5B
 gq/1/1qvTmTN7dDosrf5Jnu2PNr70SP278y8PYcTzdZhvnhldQgkZPxNqdAQQudazhDd
 EzIVCx5YgcwLeW6DdrACzNRj1NoAJEA+rpj7btefmzZ0Vttz9kErvWwWp9cevh8P/HlN
 JTXg==
X-Gm-Message-State: AOJu0YzGabGDja4nfJe9PJ4/gzPcxurZbZrxN2ujyS0dHp3jVtJ0nN27
 fHS4qQTTUoaZGfFjzaauP3juzx0eh96IPtXotuqCN5WWs7TeKBome47GA+9sahmic7q7G538S36
 x8VCL
X-Gm-Gg: ASbGnctHoy3DkimIWCLSsDJd4mhZlO/4zDUdfksESXXj7AYOb7st/uHM2WJ6Dua0BOZ
 3OuMJ+VmzpG2LVO16u+Uw0dNUt9RWe61LX4yFrVK5+xTR0AT8fGBDBllAUA5YRVPD5kIRNj8vyU
 WFsznNbJ8h+AmisQu1gCaGNmipQfV29zih4phCa31Tzd0b7yTL+6FyUMWgPuVylmYqCqRORHj/K
 8fpZwjLQEhOs9/KKydUc42BguHa78kWRMKgMt/jQjQhBF/79P9mlixcmMNTnWyCp5MdqqmatIb0
 zUYrI8pYK0c78r9v7CNFF5PJmqXI/Z2ixTtCQ+3ETIrflj3NAuJXbW1wUhKUPxU8LQUvCzyeDZ5
 XQJ6K0wPfx/bs8cCYPb8e5rJJojMjUVWebfHRQhs=
X-Google-Smtp-Source: AGHT+IHCbxhHLnwBq/GwRhn6IC9o0rmGESa4ZQ5z/UazIqLQchx2Sf7+QUJYagXdD+DoSeHnJkVZ3A==
X-Received: by 2002:a17:903:3550:b0:24b:bbf2:4791 with SMTP id
 d9443c01a7336-27cc7402d1fmr49514555ad.39.1758664466572; 
 Tue, 23 Sep 2025 14:54:26 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-269802e14f1sm168294035ad.71.2025.09.23.14.54.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 14:54:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/10] accel/tcg: Improve tb_flush usage
Date: Tue, 23 Sep 2025 14:54:14 -0700
Message-ID: <20250923215425.3685950-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

It is too easy to mis-use tb_flush().  For instance, because of
the cpu argument, some parts assumed that it needed to call the
global flush function for every cpu.  It is easy to forget that
the flush is not complete when the call returns: we have merely
queued work to the cpu run loop.  So: remove tb_flush and expose
only the core as tb_flush__exclusive, to be used only when we
are already within an exclusive context.

In some cases (gdbstub, alpha, riscv, ppc spapr),
we can eliminate the need for tb_flush completely.

Changes for v3:
  - Rename to tb_flush__exclusive_or_serial; retain the serial
    check within, not updating to exclusive only.
  - Rename the existing tb_flush to queue_tb_flush; retain the
    sequence number check for duplicated flushes.
  - Drop EXCP_TB_FLUSH.
  - Improve buffer overflow flush when we're already serial.
  - Other minor comment/review updates.


r~


Richard Henderson (10):
  gdbstub: Remove tb_flush uses
  target/alpha: Simplify call_pal implementation
  target/riscv: Record misa_ext in TCGTBCPUState.cs_base
  hw/ppc/spapr: Use tb_invalidate_phys_range in h_page_init
  accel/tcg: Split out tb_flush__exclusive_or_serial
  accel/tcg: Move post-load tb_flush to vm_change_state hook
  plugins: Use tb_flush__exclusive_or_serial
  linux-user: Split out begin_parallel_context
  accel/tcg: Create queue_tb_flush from tb_flush
  accel/tcg: Improve buffer overflow in tb_gen_code

 include/exec/tb-flush.h     | 30 ++++++++++++++--------
 linux-user/user-internals.h | 16 ++++++++++++
 target/alpha/helper.h       |  1 -
 accel/tcg/plugin-gen.c      |  4 +--
 accel/tcg/tb-maint.c        | 50 +++++++++++++++++++++----------------
 accel/tcg/tcg-all.c         | 21 ++++++++++++++++
 accel/tcg/translate-all.c   |  6 ++++-
 gdbstub/system.c            |  5 ----
 gdbstub/user.c              |  3 ---
 hw/core/cpu-system.c        |  9 -------
 hw/ppc/spapr_hcall.c        |  4 +--
 linux-user/alpha/cpu_loop.c |  5 ----
 linux-user/mmap.c           | 13 ++--------
 linux-user/syscall.c        |  7 +-----
 plugins/core.c              |  6 ++---
 plugins/loader.c            |  3 +--
 target/alpha/sys_helper.c   |  6 -----
 target/alpha/translate.c    | 21 +++++-----------
 target/riscv/csr.c          |  3 ---
 target/riscv/tcg/tcg-cpu.c  |  3 ++-
 20 files changed, 108 insertions(+), 108 deletions(-)

-- 
2.43.0


