Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5BEC369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J1O-0006B2-C8; Mon, 28 Apr 2025 03:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J0w-0005UE-LP
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J0u-0000vd-Gz
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=B99/og5rMuCkodv4MIhThbXa/C68v7OicONbccI/XSk=;
 b=e6mLZCt9Qd0I135+5WCCOqYzm8n2pJ3eG9zU6xaIBoeSjDv8XWH2pecDBWjXW+IS9uurlY
 AUmr87UqHE18+WUgfrhDUyOqQeHX9rNAWZYuhqDX3eXEr1sbpRzcN1n5u+Bvy1ztlmjGUf
 xSZzYi4MK1VwhYlL6IY3i5AmoTjXdpQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-FQKtcKgPPZKB9zY20FHHMg-1; Mon, 28 Apr 2025 03:34:46 -0400
X-MC-Unique: FQKtcKgPPZKB9zY20FHHMg-1
X-Mimecast-MFC-AGG-ID: FQKtcKgPPZKB9zY20FHHMg_1745825686
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39d8e5ca9c2so2241464f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825684; x=1746430484;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B99/og5rMuCkodv4MIhThbXa/C68v7OicONbccI/XSk=;
 b=GUpIyH0vepdiBOfS0v858MMqPVpMmd8Ix2dHlvzR9hMTdH0CkaantVIfZMdc33xj79
 Qft0JsIJr9/BET0pLexkDdkrqXO8NwVJP+YOZANJHL5P5PcOh9b4eOUxXFhXfZfXcNV+
 +roe7xD5IzxykkjCs79x/uNrpp9CpbUutEVZ69zWM6/fJj4Mq5eJozqJG5HqLqOJpcoU
 iYxb6pdj95KiwGdTXWq9vZk87/D3ouezGf2TfWk85vE0C0gGLmv5tvTi3/rfbPJ9M8Q6
 v/H5Mv2mUEL8BeyRDcTiQYz/8UZIkDtbwizeMEmHvgnQiG5qGPa7VljdcjQ2aQzsGJaX
 pt/g==
X-Gm-Message-State: AOJu0Yy27FQEwFsC/4u5fySlartINWWvbM8s1nO9DqIZGaztrGp1n2sn
 BH6A3G4F05AhGj00ltGMPlQ8cEMGw2XlpZuvBVXqdtVN3tfMymPfM4yRdMhX76qh57sFeHLHSSl
 ANXWPWr3scOU2RylIFjSsEStNkRLIcC2nWEDBzUybE+vNsoUTavNBe758FemAZtzN+3kxyhZO2U
 xjNkLOyLO+PMACIqWgNkZW2zx6eY/ZEzbcqwDG
X-Gm-Gg: ASbGncuTvXPWqNq6DV4tlKUAAALe4KULHh5z2B15mhmiYdQ5QgTtLMuuENnldy/+IiC
 4hZk14h0MHl8vrUs9MDLAPNrfe9Cguc8UnlOEoM6Jz/vmgHfkeDFYL1wJzPaxyboYqbVeEzYdpE
 JIiKzEtVlATtb6R8pMd2yYMajltdRzCXYtXnfdZLgX9N6gtmxbhxfclE6vatabSghbwcjJSQIqX
 8r72GODXkvBxEs/TaZt1aDIkhUPnN7PCflKkTyhN53QCzBPEOyvABkzDQ7AE1hRfqX/7UJYlKKa
 tPG9gIdpJeSEvHA=
X-Received: by 2002:a05:6000:144c:b0:3a0:830d:ec58 with SMTP id
 ffacd0b85a97d-3a0830dec71mr2224144f8f.28.1745825684447; 
 Mon, 28 Apr 2025 00:34:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcQ4DtFhS0dYWhwOkt0RKWG19LnC22i6e2UuEDh54TWh2cF4dqZ9Xe8sMWyjf5CS0QZ8qKCg==
X-Received: by 2002:a05:6000:144c:b0:3a0:830d:ec58 with SMTP id
 ffacd0b85a97d-3a0830dec71mr2224129f8f.28.1745825684045; 
 Mon, 28 Apr 2025 00:34:44 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a536a1d1sm116822955e9.26.2025.04.28.00.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:34:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH v4 00/26] target/riscv: SATP mode and CPU definition overhaul
Date: Mon, 28 Apr 2025 09:34:15 +0200
Message-ID: <20250428073442.315770-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is just a rebase of v3 on top of all pending pull requests.  One patch
(target/riscv: do not make RISCVCPUConfig fields conditional) went away
because the field was already made unconditional by commit e4610f38095
("target/riscv: Remove ifndef CONFIG_USER_ONLY from cpu_cfg.h", 2025-04-23).

Paolo


Paolo Bonzini (26):
  hw/riscv: acpi: only create RHCT MMU entry for supported types
  target/riscv: assert argument to set_satp_mode_max_supported is valid
  target/riscv: cpu: store max SATP mode as a single integer
  target/riscv: update max_satp_mode based on QOM properties
  target/riscv: remove supported from RISCVSATPMap
  target/riscv: move satp_mode.{map,init} out of CPUConfig
  target/riscv: introduce RISCVCPUDef
  target/riscv: store RISCVCPUDef struct directly in the class
  target/riscv: merge riscv_cpu_class_init with the class_base function
  target/riscv: move RISCVCPUConfig fields to a header file
  target/riscv: include default value in cpu_cfg_fields.h.inc
  target/riscv: add more RISCVCPUDef fields
  target/riscv: convert abstract CPU classes to RISCVCPUDef
  target/riscv: convert profile CPU models to RISCVCPUDef
  target/riscv: convert bare CPU models to RISCVCPUDef
  target/riscv: convert dynamic CPU models to RISCVCPUDef
  target/riscv: convert SiFive E CPU models to RISCVCPUDef
  target/riscv: convert ibex CPU models to RISCVCPUDef
  target/riscv: convert SiFive U models to RISCVCPUDef
  target/riscv: th: make CSR insertion test a bit more intuitive
  target/riscv: generalize custom CSR functionality
  target/riscv: convert TT C906 to RISCVCPUDef
  target/riscv: convert TT Ascalon to RISCVCPUDef
  target/riscv: convert Ventana V1 to RISCVCPUDef
  target/riscv: convert Xiangshan Nanhu to RISCVCPUDef
  target/riscv: remove .instance_post_init

 target/riscv/cpu-qom.h            |    2 +
 target/riscv/cpu.h                |   42 +-
 target/riscv/cpu_cfg.h            |  178 +----
 target/riscv/cpu_cfg_fields.h.inc |  170 +++++
 hw/riscv/boot.c                   |    2 +-
 hw/riscv/virt-acpi-build.c        |   15 +-
 hw/riscv/virt.c                   |    5 +-
 target/riscv/cpu.c                | 1014 +++++++++++++----------------
 target/riscv/csr.c                |   11 +-
 target/riscv/gdbstub.c            |    6 +-
 target/riscv/kvm/kvm-cpu.c        |   27 +-
 target/riscv/machine.c            |    2 +-
 target/riscv/tcg/tcg-cpu.c        |   13 +-
 target/riscv/th_csr.c             |   30 +-
 target/riscv/translate.c          |    2 +-
 15 files changed, 730 insertions(+), 789 deletions(-)
 create mode 100644 target/riscv/cpu_cfg_fields.h.inc

-- 
2.49.0


