Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22513FF8876
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 14:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHizg-0003yi-Jf; Tue, 28 Apr 2026 10:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wHiq9-0002Ss-1W
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:51:05 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wHiq7-0005ja-Ge
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:51:04 -0400
Received: from laptop.localdomain (unknown [86.121.140.248])
 by linux.microsoft.com (Postfix) with ESMTPSA id C446D20B716C;
 Tue, 28 Apr 2026 06:50:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C446D20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777384261;
 bh=lWFKO/4N7bNP6xaYO1XrGPYlQpmwKgGrR6emuANYzJY=;
 h=From:To:Cc:Subject:Date:From;
 b=UQ0mwcmqh2UH6w0bzqEUS8Ss/aVKCexD0YiW0QnlJEaYVoz3q3bVYpD269872Y8gk
 o5nbFnopOwRI0p5sotKEWjlz9jzPpDInIPFN1rcLYIZtVgjhuxHzntolLFIVNh+8rq
 NUNtS5OApBrrrjlgUUUIkmj/jH9mf154bMeIvHg4=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/6] target/i386/mshv: use hv_vp_register_page for fast
 register access
Date: Tue, 28 Apr 2026 16:50:47 +0300
Message-ID: <20260428135053.251200-1-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 28 Apr 2026 10:00:19 -0400
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

This series adds support for using the hypervisor's vp register page
in the mshv accelerator to optimize vcpu register access on mmio and pio
exits.

Currently, all register reads and write go through hypercalls (ioctls),
which adds overhead on every VM exit. The VP register page is a shared
memory page that the hypervisor populates with vcpu register state,
allowing Qemu to read and write registers directly without hypercalls.

The series is structured as follows:
1. Remove the duplicate `fetch_guest_state` function, consolidating
  register loading into `mshv_load_regs`.
2. Move `mshv_arch_init_vcpu` after vcpu creation so the vcpu fd is
  valid when we need it for mmap.
3. Define the `hv_vp_register_page` structure in `hvgdk_mini.h`, matching
  the layout used by the Linux kernel's mshv driver.
4. Set up the register page by mmapping the vcpu fd at init time. If the
  mmap fails, we fall back gracefully to the existing hypercall path.
5. Use the register page to read registers on VM exit. General purpose
  registers, RIP, RFLAGS, segment registers, and control registers
  (CR0, CR4, CR4, CR8, EFER) are read directly from the page. Registers
  not present on the page (TR, LDTR, GDTR, IDTR, CR2, APIC_BASE) are still
  fetched via hypercall.
6. Use register page to write registers on vmentry. GP registers,
  RIP, and RFLAGS are written to the page with the appropriate dirty
  bits set, avoiding the hypercall for the standard register store.

The register page is only used when it has been successfully mmapped and
the hypervisor has marked it as valid (`isvalid != 0`). Otherwise, the
existing hypercall-based path is used as a fallback.

Doru Blânzeanu (6):
  target/i386/mshv: remove duplicate function for reading vcpu registers
  accel/mshv: move vcpu arch specific initialization after vcpu creation
  include/hw/hyperv: add hv_vp_register_page struct definition
  target/i386/mshv: hv_vp_register_page setup for the vcpu
  target/i386/mshv: use the register page to get registers
  target/i386/mshv: use the register page to set registers

 accel/mshv/mshv-all.c          |   3 +-
 include/hw/hyperv/hvgdk_mini.h | 103 +++++++++++++++
 target/i386/cpu.h              |   3 +
 target/i386/mshv/mshv-cpu.c    | 221 ++++++++++++++++++++++++++++-----
 4 files changed, 296 insertions(+), 34 deletions(-)

-- 
2.53.0


