Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282D0C021B6
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTrl-0002NA-Gd; Fri, 21 Feb 2025 09:18:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlTrb-0002Jf-Ia
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 09:18:49 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlTrX-000711-GC
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 09:18:46 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220bfdfb3f4so47500475ad.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 06:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740147521; x=1740752321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k/VJn4+bfvAbzxvfJCsuHgylQKpUn02K8uANEqSAyTk=;
 b=TXGsR6fXxsPXBVOEBMDV+r2lU4Y1YBToa2bBJQXXbOA/vlmVcp85IWOzBe5CHFayuU
 HAr0Re7NawuY4rIl7Vca8jySQkYLt4lj9VVfUUx350CmMVBAqWCbKdLGCjgdX57z5AeS
 34QeUN6gBTAZ3RKWDp01GkEJgSm+mD0drP696KbsCWXLTIAxilar1PAxVi+92tqNpyF7
 johRgtfOtBh1859ESR7gOe6PgEuoHcv3yUBvf2Fwd4MKROM6gynA3cYFAEp+ACMVSoG3
 HWZdeLVh/HBPIBFticXwSQD7FZLv+KaCiq/Ny9IceeA9pAxrmQiO7pzLJNcYqGWPXBaX
 0M/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740147521; x=1740752321;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k/VJn4+bfvAbzxvfJCsuHgylQKpUn02K8uANEqSAyTk=;
 b=urgjQ+tw1qocCd8UJ7HhB55yTdrrBxyhXrSo8n6D0XB+TeUsuT6vrU98xt/AAoVrSb
 HkFJbHDqV6FHQZAxrjprijfQ3jA8nCuEmw8kBx75zcEbmFOCXcag8IyVe1YZEUD6aqkP
 ksfyVI/L9jj7u28InLnNJsfwDv70DLLFTsLb+HWhMfsW5O6WNbTkC0kKJlWl/AS1gej/
 M7f5DvNQW2ERvHC4C9lIIH2SL2wNh/C5rzfu6nyuRB1nt6G6ssG/sXS/7TnzjHKo5tvO
 uC9sXmfGqRAgYMDVEWsfT2xVoYU45Shi3BcbuE7j0zcDupj/rzil93IrVsxQXiXvk45W
 PZ+g==
X-Gm-Message-State: AOJu0YwXHrybJYlkOnvGssCDY8w9s1vdp+/8qm10YzAattjPUdUJlv1g
 OwEn/YVuNTxUz0VzK3WUlRNSg5p/J1s9ze2Pexh2kOY4TBXA6G42RIGuIZxcXrEPQ7+qK3kqUYk
 c
X-Gm-Gg: ASbGncsTkbk5C5gvBhGUye4EtGAJ+N9IZdWVEgx7fkbx6HA+FCP9m3qw+qRwrQO+MYb
 97nX3DA/vdAQMBIHfY7A6ysvH7vnW/TK3hjheKOZFJCt73s31Al8wTVqrdRbwd48/K2rfb8A+8t
 5euaU69IpUTJvAl5gQNyw3TsFwo1kX2csgQQ0LJ3QwdkRy2Z2ZYIQnx5q6FLnscet2Z3YQgheCG
 wmXEqBgen35ZL95gbM1OQHJokiZw8z+N/8nqr85QCOnzro5juEMGU6pQRuJnnuPiNKLMzUWxFlw
 GJ/FZFnhhICPgkHSr84AFdV8jWWmkcHoHPFe1dX54DjAkR9tCAl8OA==
X-Google-Smtp-Source: AGHT+IETohLqpIXjndlQWbgdmEUlVjq2knDwlKRHVUUH6Fnbmx6UXNpezJsiEPcDy23d2/codRaw4g==
X-Received: by 2002:a05:6a00:928d:b0:72f:f872:30a7 with SMTP id
 d2e1a72fcca58-73426ca8313mr5048857b3a.6.1740147521307; 
 Fri, 21 Feb 2025 06:18:41 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.11.154.120])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734300da098sm1150290b3a.129.2025.02.21.06.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 06:18:40 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/3] target/riscv/kvm: update to Linux 6.14-rc3
Date: Fri, 21 Feb 2025 11:18:31 -0300
Message-ID: <20250221141834.626722-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
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

In this version all changes were made in patch 2. In the first posting I
forgot to update how riscv,isa was going to be calculated when
ext_ziccrse is set by KVM.

A change was made in isa_edata_arr[] to use ext_ziccrse, instead of
'has_priv_1_11', and TCG code were changed to set ext_ziccrse
accordingly. 

No other changes made. Patches based on alistair/riscv-to-apply.next.

Changes from v1:
- patch 2:
  - use 'ext_ziccrse' instead of 'has_priv_1_11' in isa_edata_arr[]
- v1 link: https://lore.kernel.org/qemu-riscv/20250218163854.425607-1-dbarboza@ventanamicro.com/

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
 target/riscv/cpu.c                            |  3 +-
 target/riscv/cpu_cfg.h                        |  3 +
 target/riscv/kvm/kvm-cpu.c                    |  3 +
 target/riscv/tcg/tcg-cpu.c                    |  2 +
 17 files changed, 156 insertions(+), 36 deletions(-)

-- 
2.48.1


