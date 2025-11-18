Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F0ACED60E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 11:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLJR6-00057O-MK; Tue, 18 Nov 2025 05:59:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vLJR4-00055Y-St
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:59:47 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vLJR3-00009T-7x
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:59:46 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7b9387df58cso1598156b3a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 02:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1763463583; x=1764068383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Is3BbcfmauA71t6fvcSpUGDXXuuhKoITYqwGWhnwxuk=;
 b=gpc3O3NfgoD3Pjqd9DBUw15ul6zjrXY88p6g3EjEkFKnWXfpKAGXW2cW0X/2TCTB+Y
 1ayO76SGGp0S73gXQ41FM1LK28kLrE0YlcSFI6bVspI75kfeGgNJlo1IiF+zAacWoTnF
 27/U3iwYLLKTJWkHKrlaYMq8QrotvSiXZUm7AoXz6MDLR/z21B0aGaB2mKO+EiaWWpKs
 JOjSLvqHuZRVbCJ2Bj0mLMxGdYi5s6zYpjMhphcudKPKP+mB3BjQ4hnHhuNZMOTeLwvU
 iENtTo31yvNwnNlhmiBtRWPdwqU8gkz7yzsFUjPlXdBkzjxhCS7YjuUH8aMIXV1xn2fA
 9xGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763463583; x=1764068383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Is3BbcfmauA71t6fvcSpUGDXXuuhKoITYqwGWhnwxuk=;
 b=RRCgkoKAIWhMX1sfp4Xnp1M5GrtcAmXCUzIGL+SKvh5vLwlvO4DSXXvljV5Z1i3cmc
 sVI2A9MClIHiFSVBh+V3cbUkYg/U07FNz+PfZoewDdoEMV7rbL2TdHd6/KTrslgcVdyK
 D7YdAGpG2rLjjq56qsjcGz5uvqgti5Lz4/J568PkYhkP7qbesa8pdlOtrAq2y1HApule
 DZKBvqvDUrDh4zJykWMapVwVL9PxVSNLYN0/gB6cvgHcgTQnhhYy/GICYSTG/yPPzjWf
 FNFdWqaKuaRmMTYknukqQ/MEMe8qSzIok38p2pmCz+4nm0VDe8t/U09CqukUiRazFvYp
 dT7Q==
X-Gm-Message-State: AOJu0YzMGGwgIVpVe7ckkCXUhu7GsOgFx1JWGEW7JqmT4F7IkKG5KKp8
 wl0tX1muVAQOcV/svxAXuJDhYxQv7ztXJKXMW/zHKvIxQgSIKPIF3N0/kR7uAD2eVbfoNk2s/aY
 +ejOn82w07xWQ6IiKCPtfgbU8jenMjhQSP14nbR9RMcIE4y/MmwfXhYF0kK1F/YFHL+0CpM262/
 n/fFB56xUYkpM1XZIpHStodTWt3lYQnLBK9YPPMecXTrc=
X-Gm-Gg: ASbGncuZ9xcBn4sCNb90UzTOR7GEWYBoe6LY4JkYLLfjQ7v+Wear8gAjnNw9GHtXZqT
 ZJMoNqVzTQRBbY1aFrMjl6amx5V8hNHenoTXEyHasFkqpEXpOxxhFl24tzOqEXykpaymGZkpeVQ
 t376kyKaB1VMiTD9n+rSswcBXoAF+U5vI5h1pblEFrDLQTg92ftGyYp9eHIVVjVPx7akOAYE6wn
 U/Umkfah/1MJRsNgAXqubuJpYFljQfOStkVRDnvAe5uHn5yiF9whKtoduCod3b8FFC+aA0OSxTH
 L/7fGIltAJfcwNwU6jfoL4tjfrTjY+xlvwH23TmigjavqHuY9o0PzNfaq+5paUfLnSNq+r2ppXI
 RmZNSGbUtLKk2S2EwDPVGOngR1Gg5r3bntQ1XX4v75uCU84D3oyA819o6ULdsq/81cmqVHz1lIv
 pE/3QaEPD7/1Ye9YIJ+2g5KQ670AZjaCTnUBflWupbn1UJ6V/b
X-Google-Smtp-Source: AGHT+IFLea9ZvxKN0VmTFnwklXclNlNZD3sp+zhRfu/ROzmfWHLbucPjb4tPVJrGb9HA+xjW93+dkQ==
X-Received: by 2002:a05:7022:f30e:b0:11b:9386:7ed2 with SMTP id
 a92af1059eb24-11b93868332mr4049518c88.47.1763463582499; 
 Tue, 18 Nov 2025 02:59:42 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49db4a36asm43989903eec.5.2025.11.18.02.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:59:42 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH 0/3] Fix Zjpm implementation
Date: Tue, 18 Nov 2025 18:59:33 +0800
Message-ID: <20251118105936.2839054-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x435.google.com
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

From: Frank Chang <frank.chang@sifive.com>

The current Zjpm implementation has two issues:

1. The address is shifted before obtaining the correct PMLEN value.
2. riscv_pm_get_pmm() does not handle VS/VU modes correctly.

This patchset fixes the above issues and also renames
riscv_pm_get_virt_pmm() to riscv_pm_get_vm_ldst_pmm(), as the helper
is only used when checking the PMM configuration for virtual-machine
load/store instructions (HLV.* and HSV.*), rather than for VS/VU modes.

Frank Chang (2):
  target/riscv: Fix pointer masking PMM field selection logic
  target/riscv: Rename riscv_pm_get_virt_pmm() to
    riscv_pm_get_vm_ldst_pmm()

Yong-Xuan Wang (1):
  target/riscv: fix address masking

 target/riscv/cpu.h        |  2 +-
 target/riscv/cpu_helper.c | 24 ++++++++++++++++--------
 target/riscv/internals.h  |  4 ++--
 3 files changed, 19 insertions(+), 11 deletions(-)

--
2.43.0


