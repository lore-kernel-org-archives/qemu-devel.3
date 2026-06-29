Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9FCC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 00:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weMS6-0001hK-2q; Mon, 29 Jun 2026 20:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <randy.schifflin@gmail.com>)
 id 1weJri-00053o-8X
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 17:50:07 -0400
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <randy.schifflin@gmail.com>)
 id 1weJre-0000IY-0F
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 17:50:05 -0400
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-139a5f4ca15so4616376c88.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 14:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782769799; x=1783374599; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WGTlCMTaNmjWL+c82D+GAHssal/es5ANEIcHqlDLGYE=;
 b=PXSpP5xP3ov4w/K6oXPtTen5oF1Sup3LXwRf9dIrZkY88W9+PkjFB/fVxoiRR9WtzO
 1v6LKdMg+C1U33EwijZGxt7rO9v6hOib9wHq4meU7CtKweFoICVjzc2/Yy3SvGjgHgqp
 ulVe+9uQ/c1urI7YBKn4pjl1GGE1SdPoT5liPFQqToi57yQAtaCauclE8Fgo/5BJiSD2
 ARHUayaIkyxfhcNma3aAB7Nd1ip0We2bdSB+XGCYKKMu+rW3POKzWofDpxmcKGn2hCLm
 Xcj8DhCqPs4YNksHri4cM37ca1f598/9MIhqdtulyvVuQrwm5Y3lUL+81Bgtii6wtPqo
 l0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782769799; x=1783374599;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WGTlCMTaNmjWL+c82D+GAHssal/es5ANEIcHqlDLGYE=;
 b=EfgZgos8Wdz8QV/mC0XQlIoja78CctQLqyPl75g/MXOyD1rk9tV+RMgjtpPRwsv2Fq
 UYuCXbSY/owMsGBmwFShyK3MD7I268m0J23He1xeaadBNUhfAM7AYnZjA8pRwLIcZNO7
 UVAFEtdPZtdrIN1Y8Jsme/hWxI60jibVZd3TwvdnN+zA17a+3q9UNwl59mPIX6hR7zKY
 6i0FUHh3K62+IQnQGttUD1L+BiWtceOpL1Wb1zO7R7C3GnhBwl/xFoVS0NRIGf5pMtvm
 EJ8GcYx7rtalTXMS7DCNFgCeRSFjDaFx2kFAP/lPGRlxrHFLjishycgoFpxfGIdDkRXO
 cYQA==
X-Gm-Message-State: AOJu0YyuF6IFHjSufFixx8hJVl/4pMpfO3Qklblga0CoWGva52WEYvdm
 T1qgQUIFpYfHUYrMaHsK128D65wEZUL6trAiLrxCo5uR3c3ZV+8HIVE2
X-Gm-Gg: AfdE7clXyhQeTgHbeV4kslCYVIFERST7+ZoQFOodPLuGGLvnSPm1NeTZTPBV3LO9weI
 TBDIozKyq6y7rjh6T2bY6W0cL0fg9lkp06hGryfHmv/6QKXMtGVQ7WCq20++TQPbDSl9NIaM0Ri
 SV/bBkN7qkJmiBTJqdmWuCI9/7w4bPZBJrpzThXt99Wg43vSSqmkL9hyLwa1/rFGw/CdjHXwyNY
 8gcy7593MYFvYICVRhjowutdUQdE3U7Ii6nLkb9C5yMCjjihkLxUMOHUwPNAKaRxODoS1wgCIBn
 wmtuRdMIgnz9+SkHWh05yzKsqq5z1iQVF2reJ3Q2bV1uROiOh5k1+6rzV2AQ5C2abRfUOtIrEga
 to+wkKVPozst6oIafeF+CZV7rteyV8K3W4AAQdSI04qw+QH5evjghmold8TCiN8KmcJ83dShHY8
 /Rhin8lOklRh5W6ol2hSoFZ88nPm9gsKqdfqs=
X-Received: by 2002:a05:7022:672a:b0:138:6ef:45c6 with SMTP id
 a92af1059eb24-13b2a1572d6mr698101c88.11.1782769798664; 
 Mon, 29 Jun 2026 14:49:58 -0700 (PDT)
Received: from devone.local ([2600:8801:100:1910:7665:6164:2268:839e])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2a9b425asm1755523c88.0.2026.06.29.14.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 14:49:58 -0700 (PDT)
From: Randy Schifflin <randy.schifflin@gmail.com>
Subject: [PATCH 0/2] Fixup TCG for SH-4 FPU instructions fipr and ftrv
Date: Mon, 29 Jun 2026 14:49:11 -0700
Message-Id: <20260629-fixup-sh4-tcg-fpu-instructions-b4-v1-0-4356b305f971@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFfoQmoC/x2NQQqEMAwAvyI5G9BWCu5XFg/apppLLU0rC+LfN
 3icw8zcIFSYBD7dDYUuFj6Twth34I817YQclMEMxg3OzBj51zLKMWH1O8bckJPU0nxVU3CbcHb
 WhzUGa7cI2smFVHof3+V5/ogmpS9zAAAA
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-trivial@nongnu.org, 
 Randy Schifflin <randy.schifflin@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1782769797; l=1543;
 i=randy.schifflin@gmail.com; s=id_rsa; h=from:subject:message-id;
 bh=e0pxemvG3paHBZEiGC0nBQq/kZztsz8Ft2VWtI8gfiE=;
 b=U1NIU0lHAAAAAQAAAZcAAAAHc3NoLXJzYQAAAAMBAAEAAAGBALXHj1ozDvr3TmWcPoueK1kIy
 Q3yQ7HL5bbiu8J+P0QBzcchmw5nwN0avQmreXhYuMhz40g0dhCJPnJqNHg1FBflQPz2cgY7Utm3
 9lQrK/CQqWsjRwXMinMR7LrmtMFp9+up7MzdXoxmTLgPsKJ/dQmx0rUHx++mUSl8zl7lHO50YVD
 hsw1RHrkrXlxnUjRi+jtjgErRHvoRwSZpKc44yR62wV8chkTMnHtrn8hgL0Hh+jhHteNn4JTQB/
 wme8MghhliXR5oh9xirpeLlS9S4TBY3Vdk6ccgvncSS4uF/y2ZAAV5sNiLZ97OFkBhIQ0bXhVx9
 w1LPMkho650Iu9da5/0koNheHS2KAVC2FdPTyaxvqeFAsAB8fCprfh4lpShdcVpyChdd2KXFS53
 s9MAUQmZjG0pQvS/dqGCCDWqo7cY3J3VTMXwVtdzYkgZt5eMajL7z8VljXQ08ZgAStdizC/rHNg
 wy+fIL+6kgxvL/NhJwoiAWhC4D+xQY7SXjJGTvwAAAAZwYXRhdHQAAAAAAAAABnNoYTUxMgAAAZ
 QAAAAMcnNhLXNoYTItNTEyAAABgE/yhCozj36e122Elqm6r6fMgSclLZWoB/jciYEFYiQdsxV1b
 h5s3kTY5exAKIFzv+VI0dpLCTBhgYhYo6iujgjOlou3nJnY2RJ0yufC+TumFePxKzEqUg+m3DO7
 44igrRPIRq8UbtHHXQDA92cBF7rHUqsK6etYZWQhpt/78TrN4pHkAaqz0F6EKhJJTz08QFYxIwk
 QI1qnLkz57EIDDMf7dJvGtcpNmAlI5fE9EqrG4nFyyhYdGhPQ2gvqanAFLvUBknj+E4S8JLAyyT
 ljrqul7ZSlOKKxjsTKElZp9FPCSRWVxi1cKYRwTbTaDudg+PktaeNcjcRTMVUmcc1CKZoZWRIT8
 jpgw5lJ5c9HbkaHj7DkTNMm6w1cgZJKS/+rJSNJkgXRAK7cDwNh9dkvQk/O+0mz3gi1yK4QU37I
 /puHbeBQhGhzUFjvjQsu98yvmliazFlnGHOHSfxxQtjR5ySWowoeSYfH+oG3Xi4MQaV754Hykzx
 kau4F+reJk+172Q==
X-Developer-Key: i=randy.schifflin@gmail.com; a=openssh;
 fpr=SHA256:7gww1tlDoVPb7symWGdTNhRWcHyTORA23OcjS8eyd8Y
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=randy.schifflin@gmail.com; helo=mail-dl1-x1233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 29 Jun 2026 20:35:48 -0400
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

SH-4 manual for reference: 
https://0x04.net/~mwk/doc/sh/e602156_sh4.pdf

There are two issues with the current TCG code generation
for the `fipr` and `ftrv` instructions. Firstly, they incorrectly
check that the PR flag of the FPSCR register is high. The manual
states these instructions are only defined when that flag is 0.
Secondly, they take as operands a vector index 0-3, but treat
them as offsets into the floating point register list. Vectors
span four floating point registers, and thus each index needs to be
multiplied by 4 to translate to the correct register offset.

This PR adds simple TCG tests for the `fipr` and `ftrv` instructions,
and fixes the issues above by ensuring the PR flag of FPSCR is 0 and
properly translating the vector index operand to its register offset.

Signed-off-by: Randy Schifflin <randy.schifflin@gmail.com>
---
Randy Schifflin (2):
      target/sh4: add tests for sh4 fipr and ftrv instructions
      target/sh4: fixup tcg for sh4 fipr/ftrv instructions

 target/sh4/op_helper.c        |  2 +-
 target/sh4/translate.c        | 15 +++----
 tests/tcg/sh4/Makefile.target |  7 +++
 tests/tcg/sh4/test-fpu-fipr.c | 64 ++++++++++++++++++++++++++++
 tests/tcg/sh4/test-fpu-ftrv.c | 99 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 176 insertions(+), 11 deletions(-)
---
base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0
change-id: 20260629-fixup-sh4-tcg-fpu-instructions-b4-963cdafd33bf

Best regards,
-- 
Randy Schifflin <randy.schifflin@gmail.com>


