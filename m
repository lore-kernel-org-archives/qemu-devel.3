Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FE1CA0EC0
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 19:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukSJH-0006Ds-8N; Fri, 08 Aug 2025 14:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukSJA-0006C7-VK
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukSJ8-0006fO-ON
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754679551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JDu00ELTMtEPeyMflQbZH6kjUPa2X2Q87W7TmgDPB6o=;
 b=HKZyuDFh1fSYYgR5xoVU2NFfW9qLRLNs+uqXYprVezO/VRSa6aE/obUqvNFf26DqAAbYm5
 LXXr0lXl9ikQiFk/IYQZ0McGMVCgX0AEPzxyQii8LP45KDX59ylPBUzlFFoKvA5jiD2d6o
 r+5sZztj1kiqxurOle2LN8el3LRvpz0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-4ffDlLqYMgymvkUhoMT3pA-1; Fri, 08 Aug 2025 14:59:10 -0400
X-MC-Unique: 4ffDlLqYMgymvkUhoMT3pA-1
X-Mimecast-MFC-AGG-ID: 4ffDlLqYMgymvkUhoMT3pA_1754679549
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3b20f50da27so1324921f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 11:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754679548; x=1755284348;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JDu00ELTMtEPeyMflQbZH6kjUPa2X2Q87W7TmgDPB6o=;
 b=xGxvOj+gmHBAtZ1OFaT6C08s7Bx5PAIHyy3aA8EjAlWTPKcA5skn271AbyIOYyYEb4
 SMQJ8GNE/ohEv5fstIHspbIvyqKXXs6Ef3bdeHw4YO5gLMH+nXeuH/Cg7HWmdlGoyco/
 oehp+dBAoNjJo/rvmFFOvkXyG2Nl57Kqg2D+1eE7ATXAe/sHA0UPjGjuY2PykPuuyK+T
 OQzPoWoWFTM2JGxgWnQQCvQYwyiqXxOvgfB0bEl0tO7WEsgQ4qW8/ijJQFEmaTbEeyt7
 n5Ve7CKUsaOSqw4aurHXeDo39TgzdNwwl4594sBwBmn7vvC2243b6tNV83ffoRVdBs6r
 jZlg==
X-Gm-Message-State: AOJu0YxOObD4E8b6338JMANubpfwBgFASzp3Wh9UjGXHH++EP85g97C7
 8/j2ewwQGx98OLCqGWDwYvNDVYcK7sdtVoyl+GhiWlao8hqeirQyfsJ0H0xzcY/Xfi7pHmv2Qiy
 PzHm20m3L8uPcZCi7hA1UGBZ0ErsfQ7vzhjFvmncHsFkpZfKzjALO/k+1blljlDtS4OGJeok6Ot
 VlF88H4axZdXj0x81PXtCmYKRtyaWA+nQl7SIcJ/Vk
X-Gm-Gg: ASbGnctgnX4CSpGnwRD1583gQFXW7sJI3ERRRrPb2ngrkf7mMgjYXJArcjYYaQ9W7km
 ri8WWvn6Je8S0l2fWwkB2MSlKXHOV/izcEAhovt0j0SRfnnbkAqi3aGm4vh3jZZXd79VthYoQ/w
 lOKGw0oEUOk/J2+aFcbJ5L4QziU1OfDFFTOXpeGu/JOuwJYvLv2UnECvpSVXvw9qHEtJsdMsrR7
 JK9eJyXmQ7igH9q7KY3Wx8LSq+nfccxMLSuqRfIqzs/V9u7irjX6DYD9/GTL5z8JQu3ml2SLxYs
 RBt8xmtwE4Hrd6DyKRW/mflyGeTqGGALyFZ+lT6XxXrr
X-Received: by 2002:adf:e004:0:b0:3b7:6e64:bed8 with SMTP id
 ffacd0b85a97d-3b8f97f507bmr5654992f8f.28.1754679548345; 
 Fri, 08 Aug 2025 11:59:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKaMotEfGoJvnWbhPDR92+Ma+g/Xj/mihkpYVUykqp3Ye7AzsZecGkvHNL3cMyCBDxHZ0r6Q==
X-Received: by 2002:adf:e004:0:b0:3b7:6e64:bed8 with SMTP id
 ffacd0b85a97d-3b8f97f507bmr5654977f8f.28.1754679547834; 
 Fri, 08 Aug 2025 11:59:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.234.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5887b7fsm145302935e9.30.2025.08.08.11.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 11:59:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com,
	richard.henderson@linaro.org,
	peterx@redhat.com
Subject: [PATCH 0/8] accel, cpus: clean up cpu->exit_request
Date: Fri,  8 Aug 2025 20:58:57 +0200
Message-ID: <20250808185905.62776-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

cpu->exit_request is used to kick vCPU threads into qemu_wait_io_event().
The code that handles the signaling of cpu->exit_request is messy, mostly
due to no one ever taking a look at it as a whole.  In fact already in commit
4b8523ee896 ("kvm: First step to push iothread lock out of inner run loop",
2015-07-01), the read of cpu->exit_request was placed outside the BQL
critical section without much attention to ordering; and it only got
worse from that point, in no small part due to a young and naive me.

This series is complementary to the cpu->interrupt_request cleanups
that Igor did in "memory: reintroduce BQL-free fine-grained PIO/MMIO"
(https://lore.kernel.org/qemu-devel/20250808120137.2208800-1-imammedo@redhat.com/T/),
and is organized like this:

- patches 1-3 clean up accesses to the variable to properly use
  qatomic_* accessors

- patches 4-6 makes it possible to use cpu_exit() for all accelerators

- patch 7 removes from user-mode emulation a hack that is only needed
  by system emulation

- patch 8 cleans up the way in which exit_request is cleared.

Paolo


Paolo Bonzini (8):
  accel: use store_release/load_acquire for cross-thread exit_request
  accel/hvf: check exit_request before running the vCPU
  accel: use atomic accesses for exit_request
  accel/tcg: introduce tcg_kick_vcpu_thread
  cpus: remove TCG-ism from cpu_exit()
  cpus: properly kick CPUs out of inner execution loop
  tcg/user: do not set exit_request gratuitously
  accel: make all calls to qemu_wait_io_event look the same

 docs/devel/tcg-icount.rst         |  2 +-
 accel/tcg/tcg-accel-ops-mttcg.h   |  3 ---
 include/exec/cpu-common.h         |  1 +
 accel/dummy-cpus.c                |  2 +-
 accel/hvf/hvf-accel-ops.c         |  2 +-
 accel/kvm/kvm-accel-ops.c         |  3 ++-
 accel/kvm/kvm-all.c               | 21 +++++++---------
 accel/tcg/cpu-exec.c              | 27 +++++++++++++++++---
 accel/tcg/tcg-accel-ops-mttcg.c   | 12 ++-------
 accel/tcg/tcg-accel-ops-rr.c      | 42 ++++++++++++++++---------------
 accel/tcg/tcg-accel-ops.c         |  4 +--
 bsd-user/main.c                   |  2 +-
 cpu-common.c                      |  3 ++-
 hw/core/cpu-common.c              |  7 +++---
 hw/ppc/ppc.c                      |  2 ++
 hw/ppc/spapr_hcall.c              |  7 +++---
 hw/ppc/spapr_rtas.c               |  2 +-
 linux-user/main.c                 |  2 +-
 replay/replay-events.c            |  3 ++-
 system/cpu-timers.c               |  6 ++---
 system/cpus.c                     |  6 +++--
 target/arm/hvf/hvf.c              |  3 +++
 target/arm/tcg/mte_helper.c       |  2 +-
 target/i386/hvf/hvf.c             |  3 +++
 target/i386/kvm/hyperv.c          |  1 -
 target/i386/kvm/kvm.c             |  2 +-
 target/i386/nvmm/nvmm-accel-ops.c |  8 +++---
 target/i386/nvmm/nvmm-all.c       |  9 +++----
 target/i386/whpx/whpx-accel-ops.c |  6 ++---
 target/i386/whpx/whpx-all.c       | 11 ++++----
 30 files changed, 106 insertions(+), 98 deletions(-)

-- 
2.50.1


