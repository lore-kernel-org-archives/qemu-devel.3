Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1563C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi8Gp-0006ki-1V; Fri, 10 Jul 2026 06:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wi8Gn-0006kB-1E
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:15:45 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wi8Gl-00069M-9X
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:15:44 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (p3e9c0c70.dip0.t-ipconnect.de
 [62.156.12.112])
 by linux.microsoft.com (Postfix) with ESMTPSA id 228DF20B716E;
 Fri, 10 Jul 2026 03:15:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 228DF20B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783678534;
 bh=+CQKi6yxQfuSeKkTSIyIyIdfrM4eZat9lRORyMmTy9s=;
 h=From:To:Cc:Subject:Date:From;
 b=SPnbitVpLIQkgr9N6kS/rbVs6pAMCL+AuEJ8PQshUEvZEVcuPossqWojOCknBdjH5
 mX+FV6GwLRuHmMOfywbprJdwJfZFj4rc4iFpjNlKEjqVFmAOMwwg0tsNuFrNtVci/y
 25rPJ5bSxfisfXEmGmo5hNGOxpKPQD/tGqiVYONE=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>
Subject: [PATCH 00/12] Add migration support to MSHV accelerator, Part 2
Date: Fri, 10 Jul 2026 12:15:22 +0200
Message-Id: <20260710101534.664604-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

Hey all,

this is a follow up to a previous series "Add migration support to the
MSHV accelerator".

There were 2 contested changes that have been reworked in this series

- target/i386/mshv: migrate LAPIC state
- accel/mshv: introduce SaveVMHandler

"Introduce SaveVMHandler" was adding lifecycle hooks that froze the
timer at the start of the migration on the source, which effectively
paused any workload that would depend on timer progress (like an os)
during the migration window. This is undesired for live migration and
has been split out into a dedicated clock device that has its own
migration lifecycle in "hw/i386/mshv: migrate REFERENCE_TIME".

"Migrate LAPIC state" changed in 2 ways: 1) for mshv-specific fields
there is now an "MshvAPICState" object that captures auxiliary fields
that exist in the MSHV LAPIC state. Initially we also shadowed the
lvt[APIC_LVT_LINT0/1] fields, since a write to those fields was
triggering a userpace PIC delivery path that MSHV doesn't support.
2) We add a guard in "pic_irq_request()" to short-circuit the userland
delivery for MSHV for PIC interrupts, that means can use the LINT0/1
fields from the CommonAPICState.

The other migration steps have been carried over more or less
verbatim from the first patch series.

3 drive-by fixes:

- disable AMX TILE features: this is required on because we do not
  not support XSAVE buffers beyond 4k in the accelerator yet
- drop initial msi vector 0: this has produced a warning at launch,
  after tracing the source we can drop it silently with confidence.
- toggle fpu/xsave migration: a subtle bug where fpu state would be
  clobbered by xsave legacy space when applied in the wrong order.

best regards,

magnus

Magnus Kulke (12):
  target/i386/mshv: disable AMX TILE features
  accel/mshv: introduce SaveVMHandler
  hw/i386/mshv: migrate REFERENCE_TIME
  accel/mshv: install dummy handler for SIG_IPI
  target/i386/mshv: migrate LAPIC state
  target/i386/mshv: migrate Synic SINT MSRs
  target/i386/mshv: migrate SIMP and SIEFP state
  target/i386/mshv: migrate STIMER state
  accel/mshv: write synthetic MSRs after migration
  target/i386/mshv: migrate MP_STATE
  target/i386/mshv: toggle fpu/xsave migration
  hw/i386/mshv: drop initial msi vector 0

 MAINTAINERS                    |   1 +
 accel/mshv/mshv-all.c          |  98 ++++----
 accel/mshv/trace-events        |   1 +
 hw/i386/meson.build            |   1 +
 hw/i386/mshv/apic.c            | 405 +++++++++++++++++++++++++++++++++
 hw/i386/mshv/clock.c           | 189 +++++++++++++++
 hw/i386/mshv/meson.build       |   5 +
 hw/i386/x86-cpu.c              |   6 +
 include/hw/hyperv/hvgdk_mini.h |   5 +
 include/hw/i386/apic-msidef.h  |   1 +
 include/system/mshv.h          |   5 +
 include/system/mshv_int.h      |  19 +-
 target/i386/cpu-apic.c         |   3 +
 target/i386/cpu.h              |  10 +
 target/i386/machine.c          |  46 ++++
 target/i386/mshv/meson.build   |   1 +
 target/i386/mshv/mshv-cpu.c    | 305 +++++++++++++++++--------
 target/i386/mshv/msr.c         |  40 ++++
 target/i386/mshv/synic.c       | 206 +++++++++++++++++
 19 files changed, 1196 insertions(+), 151 deletions(-)
 create mode 100644 hw/i386/mshv/apic.c
 create mode 100644 hw/i386/mshv/clock.c
 create mode 100644 hw/i386/mshv/meson.build
 create mode 100644 target/i386/mshv/synic.c

-- 
2.34.1


