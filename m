Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008F5C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 16:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSJSv-0003We-C0; Tue, 23 Jan 2024 11:17:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rSJSp-0003Tc-3v
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:17:27 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rSJSm-0007TJ-2m
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:17:26 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2906bd9f2ebso2098728a91.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 08:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706026642; x=1706631442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o+uMzKgEdWxAfaTKc31QCrp/gGCfKuJesU8lsEew9OQ=;
 b=gplP29iVSScKTk34+wZ8YaVmjICPbnpENSyV7qfE9dBhm2L2dy1ADtJh8DyBrSpCbl
 q8HtzfWfsm2y8WOBhz7dKR/9LjqA04i4vtegq3ZtUGjp/OAZxHTCXv7CbaKpGSTkRNFE
 1LxoPNQo4p9PehvMU4xjHY2aaNVUNabdHQcHLHD0vAMchg/xXN8qIBbjOPmUX/av593W
 I+IwtVLmSqmMsGzOfHm22J+j3RmUUZr3m2YhSoPvhIYmlVdIph+kcn3NEK8gG2XCU8ZN
 uiU/oIl5Sk4gYEdW74r5V0ghpmtSFXfarFSpXlqd00Uox/CxdcY0BvyD4BWgbxdweQK4
 F0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706026642; x=1706631442;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o+uMzKgEdWxAfaTKc31QCrp/gGCfKuJesU8lsEew9OQ=;
 b=OjTcbypI2Vi2BzsRdDAys32gyrIWnr7MJQv91PKoE6WowyNGICLrBmYvdtQTxdnsIF
 BafYT/CMQFl3PmjT6lK0x3rUwCYBVt/4zDFzLJbR177yksxKBJqXgTWbNMzSZNtPUEkS
 OW99BoHJuQ9nr5JmKiYyuBFu8QQ77J88PFDHf1I/gpM2qN7cJ/FMJBe0YxSfvZnAMTh2
 pDWBVb35T567onjCGHFoyNgKuSrB2fJ6SPS8BINstoizKEc/ZBgumRAiK67A1acZwu9a
 faIRyUK9etouAzG+9tJDdael4u4lscp0kIXAGyTdRd7+y/Gvy0qdWcMHjZRBltzc8Ou5
 x7NA==
X-Gm-Message-State: AOJu0YydEZDKDYXBOfnu+mJ1qY00aylodhzY34Tx9Mt/ASYTBu8AZeYh
 c5I3ZW7InEpNamb/nevrSjlSmEOWDkHhzQH0mhp7zpeeh05C2rzuWRYTVNNU9+7hBQNFPVUR75t
 X
X-Google-Smtp-Source: AGHT+IHLlmK+3asEIWRwGkfIALuLSuka+7+zFVfUpIxr6eMhMnjtuu0bBVX3V8wotnnveIrNnetOzA==
X-Received: by 2002:a17:90b:3cf:b0:28e:3b7f:a2af with SMTP id
 go15-20020a17090b03cf00b0028e3b7fa2afmr7414350pjb.47.1706026641730; 
 Tue, 23 Jan 2024 08:17:21 -0800 (PST)
Received: from grind.. ([152.234.127.94]) by smtp.gmail.com with ESMTPSA id
 u14-20020a17090ac88e00b0028bcc2a47e9sm11755686pjt.38.2024.01.23.08.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 08:17:21 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/3] target/riscv/kvm: support 'vlenb' and vregs[]
Date: Tue, 23 Jan 2024 13:17:11 -0300
Message-ID: <20240123161714.160149-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This short series implements both 'vlenb' and 'vregs[]' in the KVM
driver.

The patches were done a couple of months ago but we were missing some
changes in Linux (support to 'vlenb' in KVM) that got upstreamed
recently with Linux 6.8.

Patches based on top of Alistair's riscv-to-apply.next that already has
the 'remove vlen, add vlenb' changes.

Daniel Henrique Barboza (3):
  target/riscv/kvm: change kvm_reg_id to uint64_t
  target/riscv/kvm: initialize 'vlenb' via get-reg-list
  target/riscv/kvm: get/set vector vregs[]

 target/riscv/kvm/kvm-cpu.c | 144 +++++++++++++++++++++++++++++++++++--
 1 file changed, 138 insertions(+), 6 deletions(-)

-- 
2.43.0


