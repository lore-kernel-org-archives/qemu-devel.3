Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F8FFF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwry-0003f7-H3; Wed, 29 Apr 2026 00:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwrx-0003Zg-8U
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:53 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwrv-00005x-Ml
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:52 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ad9f316d68so53644195ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438190; x=1778042990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQxi5/VkCKc9ZyyGXjIgaYB2jZ9JIHmdH6v/FJVMUb0=;
 b=j4p4qg/Khzix8+j25HsR5fofscR/bzf/ieBTkZe7M1H8yY7EIzi69Z3kOT7S8pLxvU
 t1dwQbKJ2MjklH7gnRTfzKfOgpPiYnw7ggztuZm/G+0wN3yDZwA0WZqrAMqjCdsn59ic
 2uFVfuMzeu3WNaRQmYnQ7fKsN610zQZtDMQS9p/Vtk6mzpcqax7GwIiywth/TGPVYHMf
 hTqL1fFp/b8HGabbk12DomeR6gCYkOeTEHF59BGjlhvLM/tfaTV1tuaUn1Mj36CuaNoB
 ZUOUCe6BPO0LuAHc7RVgolYkf1v5TRMB9fN5g7m7uLam/2FYW5j2l515Lpu5sWtRRvxP
 rjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438190; x=1778042990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wQxi5/VkCKc9ZyyGXjIgaYB2jZ9JIHmdH6v/FJVMUb0=;
 b=P3kSXY8pEw52GJKTOCB553qy21rsA1Ip0gfQFyJ31Y5IF+/laMZssvqvkKyhDQC20r
 y4QRW6jkLx02D5n2d2AJhb0+aGi83GB2ucFvEK5UfmXphjvxwI3MMExUii+6pxJnKCIk
 FMJoqdhoMsZKxnAWiXw6xoHwL2uQaqzr7t4ZyHoxo4ZO13qbW5jhOjdsociTNcoUqOpG
 7mtg0utLJM+nYieJVYnZcY0f68k/NO28N7nUaZGQ7avd6324vEQ87T1L/dnGqlnVKohX
 vMFQbWpqo2vZXbSnF93iUKddyoPXaDpSWm99RfDQAVOI3BmthmuDcq+Rg2Ny60vQ1K+D
 VJmQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UwAjIE1WeqtZtjXl9Auge1o3eJALgoU3W10FtPHEUtXxONJQmym3jGbhacPGOGQ2KwHmVkhssQNb0@nongnu.org
X-Gm-Message-State: AOJu0YyWXWYBPmDrDDSl8Md9iyxQ8SU2GUtU7uL2R4cpfZH7iWkJkoSE
 iARzGBkd4+q19+cQWS9LLG2MuI+Z33BVTouaaOGefAnorKEupNkp8xbnbUA4kw==
X-Gm-Gg: AeBDiesD/CMzO3U/WrfA5E1fZ4JOXEMFuxh5/ya5zS33iHdHWRBaSqhOHIEM2LaohdC
 pCwp1k5EQ6jUwsQ7O3muIv26DOpk5CJNcoeIDcw9DUx1pBoBCv/Tka0huAPn59fUxPFKPlebEGF
 AVPRWLgmAhqhsmIKgWQs5MD+4YKBEDTgN49njUsAQ4sUkuPvVBRS0yDGIe/Eice4AZKjXt6onB/
 3HPsSV1EI/QMkqgMOivA6EliSL7U0J+yzbg5FVNCqOQ4zVWopiR+u/TaChu79lCH60fXZcwna5y
 djAgmUn9tUlDxwccMLLfRCpx0TKSOPYAv8fuapIiO+wUqomS43J2baNCQZfkw+4gKgyXT7mDeFe
 nAcUoPF4q2nOblt0MVh+xpqKRM6ICCtOv7GRbFcHx0gBBPnaf7+ZeMJN1QPDJ41JT3fLU379J+n
 4/3nLCFbhPGDB9IMgb6LKOjifDxzxHSC3/A+l1Cjy5S/72Sb+6QHCd
X-Received: by 2002:a17:902:7b85:b0:2b0:4aeb:dedc with SMTP id
 d9443c01a7336-2b98740952cmr15129055ad.26.1777438190275; 
 Tue, 28 Apr 2026 21:49:50 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:49:49 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/51] hw/riscv/riscv-iommu-hpm: Fix irq_overflow_left residual
 value bug
Date: Wed, 29 Apr 2026 14:47:21 +1000
Message-ID: <20260429044752.4176397-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jay Chang <jay.chang@sifive.com>

Reset irq_overflow_left to 0 before setting up a new timer. Without
this fix, a stale irq_overflow_left value from a previous timer setup
could cause incorrect timer behavior.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260325050011.66722-2-jay.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-hpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
index c5034bff79..e8d284ac8b 100644
--- a/hw/riscv/riscv-iommu-hpm.c
+++ b/hw/riscv/riscv-iommu-hpm.c
@@ -228,6 +228,7 @@ static void hpm_setup_timer(RISCVIOMMUState *s, uint64_t value)
     }
 
     overflow_at = (uint64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + overflow_ns;
+    s->irq_overflow_left = 0;
 
     if (overflow_at > INT64_MAX) {
         s->irq_overflow_left = overflow_at - INT64_MAX;
-- 
2.53.0


