Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05980CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrID-0006cR-5N; Wed, 17 Jun 2026 10:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIA-0006bm-GL
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrI7-0007Zw-VF
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781706652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kb/Tf9i6HrFnd8vAP84awwmSaLb4ttb8MaDU/LbTJcc=;
 b=D3UXzp7kFL20Lvztr4YFoRqd6kXdVYkff1Em5/ypXRszQZFIVjTpixWqXlD9kbwb9731d0
 bhIZokg1J0HfJrZcsrbAxFvx07SwWmDb5y7bg6iKJYvrAzWvgIF1FEQ5NQgYlEj8zTXB+1
 NLHBI1v0q0+lNqvxBGDVUH9ZUODHk34=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-v0-Gi9Z9Odipbdjsev82_g-1; Wed, 17 Jun 2026 10:30:51 -0400
X-MC-Unique: v0-Gi9Z9Odipbdjsev82_g-1
X-Mimecast-MFC-AGG-ID: v0-Gi9Z9Odipbdjsev82_g_1781706650
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-68d2339febdso7274841a12.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781706650; x=1782311450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=kb/Tf9i6HrFnd8vAP84awwmSaLb4ttb8MaDU/LbTJcc=;
 b=lNtzE+d7HOIxLonnh6EdifmN+GrMsXhLIhFjkHVVvZ6AdTdwLAazMgjcvCeVfYFPDZ
 +iAQaPEIf5e2Husal6+P76KwNwDKwFFqkPuAZzck6lvBsuAEqfXQzVe52ITjsvEiO1Ag
 CfrB1kMh3Pb+tc43lEDGO9vTetEOsJthnjDiVQxHU7om/DvA+lwLn918jVCX+v/+VkMx
 QG38Y/KigrIJo3XPsAuqz5fsppg+iGdmxhcRG14f85J1zZZLROnCuQh350THFAw/kxlf
 anjZ5RqcPV77ymFNBBMJebYi/ihU/0czBiFEQ+rogFIRjxKD4aGaZkl2/eEfJO8qba2c
 L2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781706650; x=1782311450;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kb/Tf9i6HrFnd8vAP84awwmSaLb4ttb8MaDU/LbTJcc=;
 b=cgIettxu39LqyD0R48UkJk4E/b1lrKdLoKuiPvC/fRomSWCsBMnBVSInVFsvBIRlZv
 rWR0eWaRhda9oBu+cBahto7ebe8JsnaPtbbHXwiQ+iUwLRTMn5QXv7Fv63S6ubLoGcYr
 3bjSaeT8nAzpyB0GuP2DjX1BGxIiLZYquVF5V42YiMkWIeEv1NoDVRVsI+Jy+g51eeYe
 Bb1TOcKrJREG8xlgHLnsqHu8l4DT+buOPIz6QC2HVG+8f8zXKBDgfdsWINE3hSzbbj4i
 Fw3w9M/c8pzpGU2uP9Ouh1x/Wcm1e78Mop4ODao2irfIcA5K7QZNzlwoJCnzJIGpwm9i
 Ugzg==
X-Gm-Message-State: AOJu0YzznXrLBG95v5EnLqpjSt3e5trtpi2JIovyD8M5wQzF9kPzA1qV
 gYD1avuTnR3FHhfh/MfK3o5YHH95iudUv5YtrnKVSUeG9N2A91q4WlZSHgoQi5UZVF1GJli6nRy
 71pVQwYqlRoyDXMxPZmwrthrGdYCmt5yrhdnw1IQTzK2uvBTrJ5Fzlj6745E51fgTXkO3EQAV7K
 SmPXkIDpUbSDTn/AkTrVBOLQoWTJcXrs5iHfT9O7wY
X-Gm-Gg: AfdE7clTUZnGaPi5tbxBAJDmaNHsvPeiqhAh73jXZrRDy1DFRNKwjkGpDiM8V43qoR9
 3lWv2XibQPcpOUJXpXsHrxWP8+GgARJuIbgKQhD/CPDq8U6hvCDQK9T9DEWn27k/t8EcatYpPfc
 daWvsPy+5O+FnFVsxeJmlpSHCv/wqumtYKQK78s2is0quc3feAVTya18oKrbhfw5jTOtfWm8MlB
 Ib0Bukoen3D8Xm9CpkvLacFVKmpe3e3mto9V67iS59/96CMdz9eYWwsogXGxufr80m1TIX0GOVn
 JYPSVamwk+UK3F9QOw/OGdGkv7iRiwUGTuxmq36ySjPEfMyB8iMEplAmAVjHRCY8nHWHXXJspW8
 a4fYjpu/wgz8bxwz7OlKlKF9iz+islqbn5/1uGJUAJ6GFJl8ha5CwelcH1p+0N3KQOmmzSD0UV+
 LwPEveaDiDD4HUIugG
X-Received: by 2002:a05:6402:a516:10b0:695:816f:43f1 with SMTP id
 4fb4d7f45d1cf-695816f44ffmr946030a12.22.1781706649787; 
 Wed, 17 Jun 2026 07:30:49 -0700 (PDT)
X-Received: by 2002:a05:6402:a516:10b0:695:816f:43f1 with SMTP id
 4fb4d7f45d1cf-695816f44ffmr946000a12.22.1781706648925; 
 Wed, 17 Jun 2026 07:30:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6937919b54asm6633071a12.3.2026.06.17.07.30.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:30:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] Miscellaneous patches for 2026-06-17
Date: Wed, 17 Jun 2026 16:30:30 +0200
Message-ID: <20260617143046.445322-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit b0df6e2f2c6c45df8d4d286933799c623e124d98:

  Merge tag 'pull-riscv-to-apply-20260616' of https://github.com/alistair23/qemu into staging (2026-06-16 10:41:47 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to fe487bc5a79e0a6f1824ea52b10bc806c69cc0c1:

  qga/vss: Drop unused define uuid(x) (2026-06-17 15:15:43 +0200)

----------------------------------------------------------------
* GNU/Hurd support
* More patches to support qemu-ga builds with clang-cl
* gdbstub: Update x86 control register bits
* rust: fix incorrect dependency in Cargo.toml
* target/i386: apply mod to immediate count of an RCL/RCR operation

----------------------------------------------------------------
Damien Zammit (4):
      Add GNU/Hurd host_os=gnu
      tpm: Add conditional to not compile ioctls on GNU/Hurd
      block/file-posix: Clean up sys/ioctl import
      Make copy_file_range non-static on GNU/Hurd

Kostiantyn Kostiuk (7):
      qga/win: Use swprintf instead of snwprintf
      qga/meson: Remove unused lib stdc++
      qga/meson: Use windows.compile_resources instead of custom_target
      qga/meson: Allow to use MSVC message compiler 'mc'
      qga/vss: Use MAX_PATH instead of PATH_MAX
      qga/vss: Remove unused undefs
      qga/vss: Drop unused define uuid(x)

Manolo de Medici (1):
      Include new arbitrary limits if not already defined

Mathias Krause (1):
      gdbstub: Update x86 control register bits

Paolo Bonzini (3):
      rust: fix incorrect dependency in Cargo.toml
      target/i386: apply mod to immediate count of an RCL/RCR operation
      target/i386: add more easy cases to gen_eflags_adcox

 configure                           |  2 +
 backends/tpm/tpm_ioctl.h            |  2 +-
 include/qemu/osdep.h                | 15 ++++++--
 qga/vss-win32/vss-common.h          | 15 --------
 block/file-posix.c                  | 17 +++------
 qga/commands-win32.c                |  2 +-
 target/i386/tcg/emit.c.inc          | 74 +++++++++++++++++++++----------------
 gdbstub/gdb-xml/i386-32bit.xml      | 47 +++++++++++++----------
 gdbstub/gdb-xml/i386-64bit.xml      |  7 ++++
 qga/meson.build                     | 12 +++---
 qga/vss-win32/requester.cpp         |  2 +-
 rust/bindings/hwcore-sys/Cargo.toml |  1 -
 rust/bindings/system-sys/Cargo.toml |  1 +
 13 files changed, 103 insertions(+), 94 deletions(-)
-- 
2.54.0


