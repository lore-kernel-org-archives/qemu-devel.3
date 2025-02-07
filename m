Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A6EC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 16:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgR6N-0000qR-Bc; Fri, 07 Feb 2025 11:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tgR6G-0000pR-IC
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:21:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tgR6D-00076D-6w
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738945258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ohvlEteI3jtf0H3Qqpkn2gnO3TL6f+HepYux7RRP+bo=;
 b=fGDiHmxypHk9PL/F8oGu/mbVk86Z+bPdYLOVFRkQjWJ28yLxN7uwkU2hL60XwQBqMuj3fm
 kR+F0JKf4VByl6BDRd2AwbhKCGUeU0nGIySohXEkzX20BTZPGqq2hRXqAyiMSTXsj4YdZu
 lX3atn9Gm8vZDRe3Zey/ttB8MrLn7LM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-OjjG_34FMb6tNtrrcz9sHw-1; Fri,
 07 Feb 2025 11:20:54 -0500
X-MC-Unique: OjjG_34FMb6tNtrrcz9sHw-1
X-Mimecast-MFC-AGG-ID: OjjG_34FMb6tNtrrcz9sHw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65F7F19560AD; Fri,  7 Feb 2025 16:20:53 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C86FF18004A7; Fri,  7 Feb 2025 16:20:51 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 00/10] accel: Only include qdev-realized vCPUs in global
 &cpus_queue
Date: Fri,  7 Feb 2025 17:20:38 +0100
Message-ID: <20250207162048.1890669-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Changelog:
  * drop wire/unwire hooks patches
  * drop unrealize related patches
  * include fixed up patches from
       [PATCH 0/6] tcg: fix qemu crash when add assert_cpu_is_self() is enabled
        and cleanups related to cpu->created check
        https://patchew.org/QEMU/20250129134436.1240740-1-imammedo@redhat.com/
    as it's related to the topic (well, modulo bsd cleanup)
  * CI mostly green modulo rust failure on Ubuntu
     https://gitlab.com/imammedo/qemu/-/pipelines/1660855467

The goal of this series is to expose vCPUs in a stable state
to the accelerators, in particular the QDev 'REALIZED' step.

To do this we split out cpu_index assignment into a separate step,
and move call cpu_list_add() to the end of CPU realize stage.

I expect these changes to allow CPUState::cpu_index clarifications
and simplifications, but this will be addressed (and commented) in
a separate series.

As result, the series also
 * fix regression intoroduced by
      30933c4fb4f3d ("tcg/cputlb: remove other-cpu capability from TLB flushing")
   for deatials see 'tcg:tlb: use tcg_debug_assert() in assert_cpu_is_self()'
 * drops no longer needed workaround 'cpu->check' due to vCPU being exposed
   too early in cpus_queue.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Richard Henderson <richard.henderson@linaro.org>
CC: "Philippe Mathieu-Daudé" <philmd@linaro.org>
CC: Alex Bennée <alex.bennee@linaro.org>

Igor Mammedov (7):
  bsd-user: drop not longer used target_reset_cpu()
  loongarch: reset vcpu after it's created
  m68k: reset vcpu after it's created
  tcg:tlb: use tcg_debug_assert() in assert_cpu_is_self()
  Revert "tcg/cputlb: remove other-cpu capability from TLB flushing"
  tcg: drop cpu->created check
  cpus: expose only realized vCPUs to global &cpus_queue

Philippe Mathieu-Daudé (3):
  accel/tcg: Simplify use of &first_cpu in rr_cpu_thread_fn()
  accel/kvm: Assert vCPU is created when calling kvm_dirty_ring_reap*()
  accel/kvm: Remove unreachable assertion in kvm_dirty_ring_reap*()

 bsd-user/aarch64/target_arch_cpu.h |  5 ---
 bsd-user/arm/target_arch_cpu.h     |  4 ---
 bsd-user/i386/target_arch_cpu.h    |  5 ---
 bsd-user/riscv/target_arch_cpu.h   |  4 ---
 bsd-user/x86_64/target_arch_cpu.h  |  5 ---
 include/hw/core/cpu.h              |  6 ++++
 accel/kvm/kvm-all.c                |  9 ------
 accel/tcg/cputlb.c                 | 49 +++++++++++++++++++++---------
 accel/tcg/tcg-accel-ops-rr.c       | 13 +++++---
 cpu-common.c                       | 23 ++++++++------
 cpu-target.c                       |  2 +-
 hw/core/cpu-common.c               |  2 ++
 target/loongarch/cpu.c             |  2 +-
 target/m68k/cpu.c                  |  2 +-
 14 files changed, 68 insertions(+), 63 deletions(-)

-- 
2.43.0


