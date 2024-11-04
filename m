Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83407D132B5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 12:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7wMI-0005vb-Pp; Mon, 04 Nov 2024 07:39:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t7wM8-0005uN-Hd
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:38:53 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t7wM4-0001oA-Qo
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:38:50 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e3fce4a60so3245693b3a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 04:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730723925; x=1731328725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LPKbgvLMfho968esCntrdWI7jJaHDR7RVGOpPWZCRYo=;
 b=GlRLQtw+zwBWgqHW9tzlfz/50TMSPMy2frhIRdO+M/K6QnhR8OAHcwB4sBFFuD8wcc
 R7DRMZtY4Iw6R0RV6rk6DlvdvTAWlnKwplOk3jNhit+1sFcAvRaXpz/z4PXhN5GN/eDh
 rjjSfIoXpU9KXqr/uPqH3gqQ+RKD8Evuiv+4CT2u5qUW0GgrcWs8SNln/iQMjvP1faAe
 3yCCPUTCRWPiTc+CHCn8qmAXLjyOrygk2XE6suH4/Ewlfg+OQJkTEwk3U48af90HCdI1
 XQ2OtQv4yfcugtebpk112S0z8QGGrfLVBhp58MugbfiFZV8KCymJy+SCMuu1K/3QihbV
 SQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730723925; x=1731328725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LPKbgvLMfho968esCntrdWI7jJaHDR7RVGOpPWZCRYo=;
 b=HlG9F8N/ljK5CwHwfN52vQbxq0NTwDVx3nA6lDU+WEbKICs4h/gaBdlFdhMq0IG4oQ
 jWxhOcRjzRNrbnd14CqknrRvxrbWKFKQPipS+vsm+hkjjm5X7NlMeC3wqvvKwE4/Qk5B
 W0YufHEkceematsMBjoIGdb2/oh8FTfztR8jZtUBDMRZzHBPggEUwZai2OGXtIPkkOsK
 5VpAuKPW9OLsl5LB7f9gcSqjD9zcK+KeGAshqe7rrOCT+YT+1LfFeFLUS9qpkdE1nGLY
 unsWr17WXqQNHFdLLs89d8PAU6qu5dWpQzWY4tVyVvh8usC87eiOuDAa94qqZsBAjfUA
 bRhg==
X-Gm-Message-State: AOJu0YwuinTgpPIeRNLevPzUhVJ/8Blip3cnnR13726lBk4O2Mo857Jv
 cU1OY4tfV+oJbjYbJVVJ5W62mUQMFANToHWMZLttO/H1bFVRd7V5yUZ0rYISGVJvkZXxOd0d/vl
 z
X-Google-Smtp-Source: AGHT+IHo7Afk6Q5Ei4TOnCly94b3l71h9PEK2PTrZmmwxXz/lRNpdVJ8PVuuGxsEBu/627nsI7MzVg==
X-Received: by 2002:a05:6a00:4606:b0:71e:68ae:aae1 with SMTP id
 d2e1a72fcca58-72063028d99mr44037246b3a.19.1730723925194; 
 Mon, 04 Nov 2024 04:38:45 -0800 (PST)
Received: from grind.. ([152.234.121.56]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc20e4c2sm7550953b3a.91.2024.11.04.04.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 04:38:44 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 peter.maydell@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/2] hw/riscv/riscv-iommu: Coverity fixes
Date: Mon,  4 Nov 2024 09:38:37 -0300
Message-ID: <20241104123839.533442-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
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

This series fixes two issues detected by Coverity in the riscv-iommu
code that just went upstream.

Peter, 

I'm fixing only 2 CIDs because the third one is a false positive:

*** CID 1564781:  Integer handling issues  (INTEGER_OVERFLOW)
/builds/qemu-project/qemu/hw/riscv/riscv-iommu-pci.c: 97 in riscv_iommu_pci_realize()
91     
92         /* Set device id for trace / debug */
93         DEVICE(iommu)->id = g_strdup_printf("%02x:%02x.%01x",
94             pci_dev_bus_num(dev), PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
95         qdev_realize(DEVICE(iommu), NULL, errp);
96     
>>>     CID 1564781:  Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "memory_region_size(&iommu->regs_mr) + 4096UL", which is equal to 4095, where "memory_region_size(&iommu->regs_mr)" is known to be equal to 18446744073709551615, overflows the type that receives it, an unsigned integer 64 bits wide.
97         memory_region_init(&s->bar0, OBJECT(s), "riscv-iommu-bar0",
98             QEMU_ALIGN_UP(memory_region_size(&iommu->regs_mr), TARGET_PAGE_SIZE));
99         memory_region_add_subregion(&s->bar0, 0, &iommu->regs_mr);
100     
101         pcie_endpoint_cap_init(dev, 0);
102     
----------

The reason is that is that iommu->regs_mr is being initialized in riscv_iommu_realize()
with 'RISCV_IOMMU_REG_SIZE':

    memory_region_init_io(&s->regs_mr, OBJECT(dev), &riscv_iommu_mmio_ops, s,
        "riscv-iommu-regs", RISCV_IOMMU_REG_SIZE);

And we're doing "qdev_realize(DEVICE(iommu), NULL, errp);" right before
the snippet Coverity found as problematic so it's guaranteed to be
initialized. I ran it with a debugger and verified that
QEMU_ALIGN_UP(memory_region_size(&iommu->regs_mr), TARGET_PAGE_SIZE) is
in fact equal to 'RISCV_IOMMU_REG_SIZE' at that point, as intended.

I was going to set it as false positive in Coverity but decided to
verify with you first. If you agree I'll update the ticket.



Daniel Henrique Barboza (2):
  hw/riscv/riscv-iommu: change 'depth' to int
  hw/riscv/riscv-iommu: fix riscv_iommu_validate_process_ctx() check

 hw/riscv/riscv-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.45.2


