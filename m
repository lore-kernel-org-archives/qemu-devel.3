Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEBCD6C28B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 19:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDTj0-0002h4-8N; Tue, 19 Nov 2024 14:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tDTiw-0002g5-R4
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:17:19 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tDTis-0007a1-Q3
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:17:17 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-72487ebd2f5so2857505b3a.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 11:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1732043832; x=1732648632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cMPWnZPX4ZxNfmHx82bkv+aNMW82X7RFs3BZd4Z5FPg=;
 b=ed4ZXHOP6TqKRePMm3SjlUZEQWMbuLY5ztQyOUHLqeMeCnDoOx5gT3KLwaqhlAX8EN
 HaXzsuI237x6+iuz6Zgh5B4tyfAFYzbihfUofULHoLTHYd4CnCZ1WxC8cklkVC6qATeN
 rD/NhQn6OehKNvdUpPzeUUb63seR00lFHaqTtrEHAG+A5akejjGhsejzwc4U8q6SXwqb
 h2g5sfuP6PfgZfZ+xN6GagtnLSNOzkejB1PVwOmdq6TsfvP0Rt9xc+iGLU9J/A3sJRzM
 jtS/DlnrQjcESlSLiMPWW4FKSUD/QTSQryBtdpZUpOvf+qmy4M0AaZ27lKQfChSaLjas
 LdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732043832; x=1732648632;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cMPWnZPX4ZxNfmHx82bkv+aNMW82X7RFs3BZd4Z5FPg=;
 b=kbP3KIH6HWaaONqQSxRtdjHetEQLfpH6zQo0ksPA7nvKP+jMXpKdoqoydT2QX4xZdW
 K+tz3s/zHevd/1BBIOywuPtAcl1XEF6il5RMo7MgZGZe3k9wp3t9F2dnXX83UzqCqg9o
 NiLwEel6dVuOVGyOAVjrJWbXMn9eFv84BvLypprPTJrsXfU7vpb80sHxmVHyE3wlArUh
 hvM0Xu/qHXoKqC4hM/Ye8K0RlxSpbXkxlLwurWEK1PrLEOXP9vUaZmsUMyfxsOPZLpT3
 4fQJCFtHIHDqL0i4CnRk2I/8fvIdPV0Si4dM7GFA+WX6KZKrzURlHXrviTgAvuc/fZyG
 IWzA==
X-Gm-Message-State: AOJu0Yz02POwI+t81+HKayGwc/XpPrPnB5cV0Dd94dTq9ln/eLF+ODZ0
 J0KG7j8TYWiPOPXS0xUBLJAD08qNCCi78eR7rD2ajoDKWl6pkwE3IvZ5zJN0+15FshIcxbUtOsP
 p
X-Google-Smtp-Source: AGHT+IFkI3qa4wX17ELu0QE+UcH8/pd//WS8PaCel8N0BJ+BmOnk5s516ak9sROsXq2yrYJVIBHOqg==
X-Received: by 2002:a05:6a00:14c8:b0:710:6e83:cd5e with SMTP id
 d2e1a72fcca58-724be7d17d6mr194996b3a.0.1732043831620; 
 Tue, 19 Nov 2024 11:17:11 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724beeb82f2sm24271b3a.35.2024.11.19.11.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 11:17:11 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 v2 0/8] riscv: AIA userspace irqchip_split support
Date: Tue, 19 Nov 2024 16:16:58 -0300
Message-ID: <20241119191706.718860-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
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

This second version was rebased with 'master'. Alistair's acks were
included.

No other changes were made. All patches acked/reviewed.

Changes from v1:
- rebased with master @ af4c4fd128
- v1 link: https://lore.kernel.org/qemu-riscv/20241010190337.376987-1-dbarboza@ventanamicro.com/


Daniel Henrique Barboza (8):
  hw/intc/riscv_aplic: rename is_kvm_aia()
  hw/riscv/virt.c: reduce virt_use_kvm_aia() usage
  hw/riscv/virt.c: rename helper to virt_use_kvm_aia_aplic_imsic()
  target/riscv/kvm: consider irqchip_split() in aia_create()
  hw/riscv/virt.c, riscv_aplic.c: add 'emulated_aplic' helpers
  hw/intc/riscv_aplic: add kvm_msicfgaddr for split mode aplic-imsic
  target/riscv/kvm: remove irqchip_split() restriction
  docs: update riscv/virt.rst with kernel-irqchip=split support

 docs/specs/index.rst          |  1 +
 docs/specs/riscv-aia.rst      | 83 +++++++++++++++++++++++++++++++++++
 docs/system/riscv/virt.rst    |  7 +++
 hw/intc/riscv_aplic.c         | 68 ++++++++++++++++++++++------
 hw/riscv/virt.c               | 38 +++++++++++-----
 include/hw/intc/riscv_aplic.h |  8 ++++
 target/riscv/kvm/kvm-cpu.c    | 43 +++++++++---------
 7 files changed, 203 insertions(+), 45 deletions(-)
 create mode 100644 docs/specs/riscv-aia.rst

-- 
2.47.0


