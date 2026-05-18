Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D27BCD4F48
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsJR-0005p5-E2; Mon, 18 May 2026 03:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wOsJL-0005oV-VR
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:22:48 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wOsJK-0004dl-Fp
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:22:47 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-83ec36a13e9so706709b3a.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779088964; x=1779693764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6obqPcSb39jzxm5ZYblMkJKYYFSierbRL5kUqmcxeDM=;
 b=AIHoMhf+FnjGsjx8mx6rVLdtrkWrhh5dpU1k4T4U5uhqU/jDiipQKqvgfFiqCyUXD9
 TARx+x33wYxZjohFqsvnjxyDXhZD9m8oI4LdcDC99NudV73A2Pp1COQt/PXFawup24ZM
 DJYpQ09rtdA1HkZjP8pjUYpbKT+/8e9FWjaHrJMVqrDhOXqzYO8VNp7/ygR7QdxNSIr3
 HflbwRFEdDV4SC7fqHKZ1SA0rHtg6iN8Egw4mPc33CFnmA1/liSLJmt8rEokD+8scG8P
 RjIaAxIdXtZzxp3zROAJwQ0yHOyEwa39fnXfbZh9iddd+vWIFbljlmp+uyFLE9nB6a1c
 MUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779088964; x=1779693764;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6obqPcSb39jzxm5ZYblMkJKYYFSierbRL5kUqmcxeDM=;
 b=Z4ds8DI7rW2mfIl5M9GrO/nN/LXrn/VTNOC4BFGjYSVTr6GcFdBTjmEek1cRttHL1K
 BStFwrXYm86B7/hhsv14lEj8acElzvtAAzvOesh3S2H/fJxEy767qVolQAEZ8QEEysa2
 1QMMIHZJAHIwONllKdYWzN56/W23BSzL+l4Dh2ICsA4dYFLl1eXOL3Es/nFam/OmiqDq
 vEPxN2qur/vhJ/C/9asRJ3S4ujoD+WHYuY1Hyq/0Jep3ZksECnlO7xB6522/bEJTQuNJ
 hXbOgEO3D+qre6HgD6Vfx+KbSvLEsVhtw2XGkYg9xNKBXcGXhox3gYXqFjby1yuC0u+y
 DW7w==
X-Gm-Message-State: AOJu0Yz/0ii7xvEYjV44GATrwaUPLJNQKn4BV3pYnk54FyN2tno3XVAp
 pMgc1153euhND01TjUCD2SDZkOQkXIEMymjhp4fTSoTIja+F9cRExYyhwxp3vTP4tfRQXVi2B1A
 9cKPv60Fr4ZKx3lRtyHdEXQZF96sMIpd5nhFQM7ZW6iBm49ABu4gZzOWAvC0flF3q1YZjXXG3JN
 nefnk2csKjdce58krsOuBmmQAXQs+7j2bPWu0Lxtv2eT8=
X-Gm-Gg: Acq92OHmKqcmEGPKsMUClo4+4IxSg/AGqeV/qjDwQ/CgQfqMs8DNKPckOmd0rXSP/g/
 YrXc/Iy/AT9mYjveLkOB7EEWVzIOgivJ1r1cWgQMIexckUsSEsls5EPxEjYvidJfvbLkkxVy2/B
 9+KGdQonbB9doAT282tQ6QiCZDxDCB/mjHI77IvL62deWyDIsQE5qEL8qI4ulGHYQHHLJjLscXL
 dmcnCFnxIJ1sNAVs/ICvBbZG//lyqZKgdfC1Do/HzusepiHt4RzopOWJl7lfzGfyGzV+b3oJoHk
 u59vzlVQ1X4YrVWFX//pmez+7/MXuiOJ+KUs1yOFe7c4EMFGkwqFtTkLsc/zOsCBzuZPpB7rX9b
 MpNfOFG+7lXqQWJ88Aum7lTHNShlnS6O2FLi0sJfkJpE4SiFcsb3l5T6KfKmbjfBCBYgWkj73Sp
 F7AEiDh2wPVQmtQpCkCAwqDui2Y7atjTUGIgWIH7uwq0e4e/MPKu/WX/PcIv/Uakn+19uqCZ5G
X-Received: by 2002:a05:6a00:ad06:b0:831:7f71:c810 with SMTP id
 d2e1a72fcca58-83f33cc397fmr14347734b3a.35.1779088963789; 
 Mon, 18 May 2026 00:22:43 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5c045sm16502348b3a.37.2026.05.18.00.22.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 May 2026 00:22:43 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jay Chang <jay.chang@sifive.com>
Subject: [PATCH v2 0/2] Don't insert DDT cache in Bare mode 
Date: Mon, 18 May 2026 15:22:37 +0800
Message-ID: <20260518072239.16293-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=jay.chang@sifive.com; helo=mail-pf1-x436.google.com
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

When IOMMU is in Bare mode, DDT (Device Directory Table) lookup is not
performed. This series fixes two issues:

1. Avoid inserting unnecessary DDT cache entries in Bare mode
2. Properly free Bare mode contexts to prevent memory leaks

Change V2
  Rebase riscv-to-apply.next

Jay Chang (2):
  hw/riscv: Don't insert DDT cache in Bare mode
  hw/riscv: Refactor riscv_iommu_ctx_put() for Bare mode handling

 hw/riscv/riscv-iommu.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

-- 
2.48.1


