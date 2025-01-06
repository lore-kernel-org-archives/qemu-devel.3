Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5977DE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 17:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUr2w-0001RQ-Qo; Mon, 06 Jan 2025 12:37:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tUr2u-0001R9-RJ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 12:37:44 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tUr2t-00059D-89
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 12:37:44 -0500
Received: by mail-pj1-x1041.google.com with SMTP id
 98e67ed59e1d1-2f4409fc8fdso18149859a91.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 09:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736185061; x=1736789861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uU/YiahdvIaDUDARTqJu/LOVqfpOebOBtBqz9ipuMrI=;
 b=JRtRvXgo7FFtnEW0xJuGhdDYKfU4zY9qSBheaSrxkvdrb9r7+vDAstnNoe5YnxCUZM
 ovCznh8I1ls7FyTi5Q2fk5fwmTb4WKsOc4nrBKS14k9BWmWHNs0UQ1CvZLUOA1OPm+Fy
 rjv4gec6b6sQ4vgITK0JkClBIZwgNJsTHOn82qiqjEzxcGgSsNCTWCXjpx+5N7+MpXRy
 gcFZ32MyNaOizB74c2A10K6rjQavl/vAU0vdsf5RNBtbwdUOHMZ5dP6Y5QeE/zB+7dd/
 YOuG0IyDrBrMS65hNYvdWvfbsX8IrKuzP7gohVlPg+fsdXbOCgk4sqdLaMZ33jXrf6BO
 Zx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736185061; x=1736789861;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uU/YiahdvIaDUDARTqJu/LOVqfpOebOBtBqz9ipuMrI=;
 b=EqgbKSARixuhn8BNWVc3FyCU4hJ9xazT7bhbbuIsO/xEg3UNug583oH9iwv/mM6SLg
 VR02gcxSYUmj3BqlbmRxZOL5Oix89+NyjAR33sFJV5A4VICUnL+rm3q0zKg54EviJ/QC
 hXURTiZMO1urbndFc9UCuJIj7gxzGgFVhUE4dCj5M8Ofd4gSFWM7C9/f3E9+bwulUfIF
 vB1cne9yRce3AbwuzCSfJoqn50reIPg9Hs3AgYRyKCZ7StviAqEap0UoQR3VTRl7t26C
 xAshbI8Ibr3g05YxwKMVPrfygsbGOBrsYBu4nRqM+73j7JAa+QuHJMi3kApou1u0Q428
 PymA==
X-Gm-Message-State: AOJu0YyEq0DfSFHEuqbfASxy7PePPLhypVUStki1JuXod6khDDEZGUe9
 VFFsdaS9A5Jgj3hzLHQje871Y0zhr7dbeuN/Wm3mzqkMH+VyfBUkh3TGf3Oj67cjzydEghvApfk
 8yMzngg==
X-Gm-Gg: ASbGncsW0C3o0H1sg9kxgkEE5Lv2MdtaVcqno26UDjW/gB230KxNIL+noMbCipA6y7v
 f+dNG25vq1lBcK8saqOhnK3r0QT/IXY4/Bz43GSOBjC2luV2/yWaQ9fXkoR5FDQxLWP0Jhow5U3
 EvCWc9qSfYT3RVnlIbVoZWj2xIEJDBlub9fQnAE8Hd0AeJNoW60qMaxfLRHMPCp3Nf6i4eUVvmp
 DlgPzW0zaE+Dq2NlFWSnzpgBxVHKvsKkGvxon46RmlnDWufxdNCu4bPo2NSOLBVFMO6L3s5+/bI
 JiGpRaO/5w==
X-Google-Smtp-Source: AGHT+IFQ9i4Mj3ErRuhn6VWM5O9kLcM0NINpOCPuqpQrDSVXeFRRD5vwMOo4GG/6Yi6F8v0m1JoOhw==
X-Received: by 2002:a17:90a:e18b:b0:2ef:ad27:7c1a with SMTP id
 98e67ed59e1d1-2f53cb7abc3mr225657a91.2.1736185060868; 
 Mon, 06 Jan 2025 09:37:40 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([189.110.107.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f4478ac7dbsm34139317a91.50.2025.01.06.09.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 09:37:40 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/2] target/riscv: add traces for exceptions
Date: Mon,  6 Jan 2025 14:37:32 -0300
Message-ID: <20250106173734.412353-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1041.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

This new version is a re-sent of v1, rebased on top of
alistair/riscv-to-apply.next, with acks/r-bs added.

No other changes made.

Changes from v1:
- rebased on top of alistair/riscv-to-apply.next
- v1 link: https://lore.kernel.org/qemu-riscv/20241219174657.1988767-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (2):
  target/riscv: use RISCVException enum in exception helpers
  target/riscv: add trace in riscv_raise_exception()

 target/riscv/cpu.h        | 3 ++-
 target/riscv/op_helper.c  | 9 ++++++++-
 target/riscv/trace-events | 3 +++
 target/riscv/translate.c  | 2 +-
 4 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.47.1


