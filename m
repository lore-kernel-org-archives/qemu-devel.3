Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA81BC021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQcj-0006ps-CC; Tue, 18 Feb 2025 11:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tkQch-0006pZ-LW
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:39:03 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tkQcf-0002Kl-TA
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:39:03 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2fc6272259cso3657052a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1739896740; x=1740501540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fl0Tqxaz2PzXbJb4Af+tTD/1mJfnRKKhXco3/bT6eew=;
 b=XZjgaGbSxwHa3BQ4+RurtXz7UeGxaVYKiICFK4tKleBo7EJjd9Tz6QSb5Hk68xeIMC
 P6bydfHOBivy/mT2GPryuwbGZTz6Y4B6pk6ZNyKBX9AF84cUsfEcOdF/Ex+lUyQ+9eP+
 z1ZHG24DZ2pIUQipjnYOltXwxS7hbOCjOY+kZrfIsIIY3LIAB6TfzaEfygV0aaoy5TKZ
 3vTGtfAd1yQg0FtbSzPgLsYDjcE24csEy3jRlFMKQrX8dYrVOiMrg8LBL1BcRCh2fdZS
 XsbgyoQAkoNi7IwvGZ9heCCXQ+yas7n0vdRQ0SijYa4gSvmwG5A42wL1f7zY8RV9UGL4
 t8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739896740; x=1740501540;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fl0Tqxaz2PzXbJb4Af+tTD/1mJfnRKKhXco3/bT6eew=;
 b=tJ9lhHg0IThvCZ6kymIc92dT/+Tggd7jBkKQssWvDDlassmwA9yeBIelfWqNIHxWx6
 RGQKZa0m/y0C3cealnKBEx7MS+KSlUgeJPzNYA+ez/brTt+cw4UV4FV236PrJjcFBpjB
 awts7Y0uyLS3yGCI2Kfiy4LfcKAkyh8hBQyvGppm4V5PJlkBp2y96Kb0PGCLcq1YjnV8
 LUWEgog0tA1mhX2WChz3zW72gugjhtIAWeTMnRlCnW/BDeqzPzd8baGe5pudkCc54QQt
 EKfN4a+UE2X9eHgDaJCufnC41hxOxTLAqieb26v+sWi+IKwfBwNxmIcLi5pJn7WjWqHA
 Gj5w==
X-Gm-Message-State: AOJu0YzJdB468sLWoqYDo7OPmLe4hnRxh4QuOAe93w/po43cxEkvlGhV
 LhEVoCQ5wvijesUnucv4iRUpJZzSHTPyUudMkmmJZCp7n7gXQkiPpNf6yHo0sv3FoaFQImiVvi2
 M
X-Gm-Gg: ASbGnctuGdIeoToDBjGezvWuALhuI1eRT+u32TnS5TKc7v0iE6sFuMSc3JLGwXgbAIV
 oYUAGkoQ5pZquCvCKk3ekG3UdPWqVJOg1ZdkM0/yetn89rS/UuMNafygqYUDg5Du/on14wTd9b6
 pTITJsMQZWx1MaIRKgKFZZ+JtB58M262sdzymFMy4JQi99iGEDIsabdYOfq1EjuvbVhGqRz4hpo
 RbbddcRjUCsmBNd+nfHwKbaAWXZA4DFBuU81ouTVhlbadVQ3Czs4yOlYOc4BDInIh6iwEY8i2LA
 PKb4MCvMmJgA4nydBWLt6w+Lf5yNs6VlvVJwW5vW/YNa7OT74E+k
X-Google-Smtp-Source: AGHT+IHh3YcraYbvA5G21lrqSIFtbb1CCWYTmRYBZgcHd+isrt09zo8zmW4gZfKOccAPag8L7jfTDw==
X-Received: by 2002:a05:6a00:3a07:b0:732:5b10:572b with SMTP id
 d2e1a72fcca58-732617bd3c5mr21617989b3a.10.1739896739947; 
 Tue, 18 Feb 2025 08:38:59 -0800 (PST)
Received: from grind.. (201-68-240-180.dsl.telesp.net.br. [201.68.240.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73278d09228sm4595533b3a.117.2025.02.18.08.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:38:59 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/3] target/riscv/kvm: update to Linux 6.14-rc3
Date: Tue, 18 Feb 2025 13:38:51 -0300
Message-ID: <20250218163854.425607-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1032.google.com
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

Hi,

I'm sending our usual KVM capabilities update, following an update on
linux-headers.

This time I had to include an extra patch (patch 2) because KVM is
exporting ziccrse to be enabled/disabled by users, while our current
implementation treats the ext as always enabled in TCG.

Daniel Henrique Barboza (3):
  linux-headers: Update to Linux v6.14-rc3
  target/riscv/cpu.c: create flag for ziccrse
  target/riscv/kvm: add extensions after 6.14-rc3 update

 include/standard-headers/linux/ethtool.h      |  4 +
 include/standard-headers/linux/fuse.h         | 76 ++++++++++++++++++-
 .../linux/input-event-codes.h                 |  1 +
 include/standard-headers/linux/pci_regs.h     | 16 ++--
 include/standard-headers/linux/virtio_pci.h   | 14 ++++
 linux-headers/asm-arm64/kvm.h                 |  3 -
 linux-headers/asm-loongarch/kvm_para.h        |  1 +
 linux-headers/asm-riscv/kvm.h                 |  7 +-
 linux-headers/asm-x86/kvm.h                   |  1 +
 linux-headers/linux/iommufd.h                 | 35 ++++++---
 linux-headers/linux/kvm.h                     |  8 +-
 linux-headers/linux/stddef.h                  | 13 +++-
 linux-headers/linux/vduse.h                   |  2 +-
 target/riscv/cpu.c                            |  5 ++
 target/riscv/cpu_cfg.h                        |  3 +
 target/riscv/kvm/kvm-cpu.c                    |  3 +
 16 files changed, 157 insertions(+), 35 deletions(-)

-- 
2.48.1


