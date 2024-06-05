Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E21C27C5E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 11:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEomu-0005QT-DC; Wed, 05 Jun 2024 07:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sEome-0005MT-Pu
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:26:28 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sEomY-00030m-0y
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:26:20 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52962423ed8so2300967e87.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 04:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1717586775; x=1718191575;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F/35RdLoTiYpCSxnDjbZ8KaDHx/8zQ0xEsfE7QqiyHo=;
 b=b7575HGvEbOvI1Px+eDSErB5lvvduOevMXXahCHXufAquzfgW0qvshXYQJOt0E53cf
 g5BW0UccQ63gsjJs9PKDKGaZsjmMgPC8TxNFe/Vp6T3w7JuywxPa4omOnRUM3XRQehuV
 PB9GNqX2R5UDfJY2FuHf/IRceSPGnFJNKCzrzwyOSV8ryq3QQn+LTd5R4zV3EHq7y5yU
 wXhkn5wz3Ur2Z7a/wiyn/XWBzBVkRRVT0WNEgQnjHNWHYWMFKo+F7n4i2fFNnAkaAdcE
 ILkJuurBYrGc/ouxUI2dRpiFyPLEsqH4TyiXVXq7OCMoQgAzk3Jis3i0VwtAknB5ExBA
 snEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717586775; x=1718191575;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F/35RdLoTiYpCSxnDjbZ8KaDHx/8zQ0xEsfE7QqiyHo=;
 b=Uo5CUxVUtvduEKNgh080VXW3ZOh2G1l9h5uTjfTpaaO6W0bKL8ffuSHNuSDUHwLFOL
 A90i1Ebp1pQ1xk7f8lA8f3uXQVc4SqYLm7jaZerqEmf/y1MBwPYmfpF734LO7Q5kjVVb
 46HO3xy2WVe+1/FrmVw89wHsedate6A95O34MOJnBW8qwzy0g+FK1FMCX8WyZVRyWJzC
 DSqXAHB22m2Qb3yZ3aIj09oEa3vxqp9oiTOlmR9X0rBifQsH/VZO+EX3yX8LUBOM/AZc
 wNVYwlN3m+XG/3VBS7VlsTBgabB9Z6WMAOgDy0MKylhccwZh9l64ddG1/9BEcuOLwE2b
 Edcg==
X-Gm-Message-State: AOJu0Yw2CS6o+rODrPDWo4cnQB3UdoVd3WdFed7XiIJJFjXZuLWbPG89
 j4OSv72/Df/vyOylIQ24ImwX+6xHs2tH4ZtAt8oB50nn/V9p3sa8VA264QZRjYyJhREn/sUgaAw
 =
X-Google-Smtp-Source: AGHT+IFU5cEhVzxOy7wjRN1bxSXVea55xsJVAG1R/TA7kIcB/uIRpUYEeKrTnpi3b0j2+bVnsPlA/w==
X-Received: by 2002:a05:6512:3ee:b0:522:4062:6e79 with SMTP id
 2adb3069b0e04-52bab4e3e74mr1182929e87.31.1717586774718; 
 Wed, 05 Jun 2024 04:26:14 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-249.customer.bnet.at.
 [89.104.8.249]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a51023af4sm7111335a12.29.2024.06.05.04.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 04:26:14 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, lists@philjordan.eu,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v3 0/7] hvf x86 correctness and efficiency improvements
Date: Wed,  5 Jun 2024 13:25:49 +0200
Message-Id: <20240605112556.43193-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::12a;
 envelope-from=phil@philjordan.eu; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This is a series of semi-related patches for the x86 macOS Hypervisor.framework
(hvf) accelerator backend. The intention is to (1) fix bugs and (2) move the
hvf backend to use more modern and efficient APIs in Hypervisor.framework.

The goal is to replace the main hv_vcpu_run() call with hv_vcpu_run_until().
On the one hand, doing so noticeably improves performance in itself. On the
other hand, using the new API is a prerequisite for enabling hvf's in-kernel
virtual APIC implementation, which provides a further, even more drastic
performance improvement on many workloads. Integrating the APIC requires
a bunch of large commits which still need some compatibility bugfixing, and
which I hope to submit as a later patch set.

Compared to v2 of the patch set, I've re-added the kick and hv_vcpu_run_until
patches after analysing hv_vcpu_interrupt in more detail and finding it safe.
Plus, there's an ergonomic improvement to the assert_hvf_ok macro.

In this series:

Patch 1 enables the INVTSC CPUID bit when running with hvf. This can enable
some optimisations in the guest OS, and I've not found any reason it shouldn't
be allowed for hvf based hosts. It now also includes setting a migration
blocker when the feature is active.

Patch 2 fixes a bunch of compile warnings that kept littering my build logs,
so I finally caved and fixed them. As far as I can tell, these were all
ancient typos.

Patch 3 sorts out the minor mess of hvf vCPU IDs/handles. The aarch64 and
x86-64 versions of Hypervisor.framework's APIs use different integral types
(uint64_t vs unsigned int) when referencing vCPUs, so this changes the code
to use the correct one depending on build arch instead of awkward pointer
casts. (There's currently only one instance of such a cast, but patches
5 and 6 would have added more, so I'm fixing this preemptively.)

Patch 4 fixes dirty page tracking for the x86 hvf backend. This has
previously only accidentally worked because hv_vcpu_run() makes spurious EPT
fault exits. Switching to hv_vcpu_run_until() surfaces this issue when using
an emulated VGA adapter for example, as those use dirty page tracking to do
partial screen updates. This issue was causing problems on previous attempts
of switching to the newer HVF APIs as it was masked by the inefficiency of
the older APIs.

Patch 5 implements a "real" vCPU kick using hv_vcpu_interrupt(). So far, the
x86 hvf backend's external interrupt injection has relied on hv_vcpu_run()'s
behaviour of exiting the VM very frequently without host action to handle
external interrupts. This is not a great state of affairs in itself, but
fails entirely when switching to hv_vcpu_run_until() which returns only when
there is actual work to be done by the VMM.
In previous attempts to introduce this improved 'kick', there has been doubt
about hv_vcpu_interrupt()'s reliability in edge cases, particularly when an
interrupt is issued when the vCPU thread is either not running
hv_vcpu_run_until() at all, or either entering or exiting VMX mode.
I believe this concern is unfounded for three reasons:
1) The patches have been in use in a fleet of hundreds of production systems
running CI workloads for over two years. No symptoms of a missed interrupt
(or indeed any other issues) have been encountered.
2) I have tried to provoke such an edge case and failed. To do this, I
hacked up Michael Steil's toy "hvdos" VMM to run some bare-metal assembly
code, then hit the running VM with a barrage of hv_vcpu_interrupt calls
at randomly spaced intervals. Any hv_vcpu_interrupt call is followed shortly
by a VM exit, regardless of what state the vCPU thread was in. Multiple
interrupts in short succession are coalesced, but only before a VM exit. If
an interrupt is issued after the VM has already exited, a further exit is
triggered as soon as the vCPU thread attempts to re-enter the VM.
The code for this is here: https://gitlab.com/pmdj/hvf-edge-cases
3) The doubts about hv_vcpu_interrupt edge cases seem to originate in
observed behaviour that was actually caused by the dirty memory tracking
bug fixed in patch 4 of this series. That bug had nothing to do with
hv_vcpu_interrupt as such, it was surfaced by hv_vcpu_run_until()'s change
in EPT fault exit behaviour compared to hv_vcpu_run().
Of course, this is not PROOF of absence of defects, but I'm not aware of
any formal proofs covering other Qemu code or dependencies. I have also
asked Apple's DTS to officially clarify hv_vcpu_interrupt()'s behaviour in
edge cases but unfortunately received no reply. 

Patch 6 switches from hv_vcpu_run() to hv_vcpu_run_until() where supported.
This was of course the goal, and the previous patches fix all the bugs that
caused this patch to surface them.

Patch 7 provides a small improvement to error messages if and when an hvf
call fails. assert_hvf_ok() would previously only tell you the error code
of the failing call, not which call was failing, nor the call site.
The change makes it behave more like a classic assertion, reporting the
expression as well as the source code location along with the error.

changelog:
v3:
 - Back to one patch series with all the changes.
 - Detailed investigation into edge case behaviour of hv_vcpu_interrupt.
   Determined it was behaving fine, no race condition workarounds needed,
   so the kick and hv_vcpu_run_until patches have actually stayed essentially
   the same as in v1.
 - Added the assert_hvf_ok patch because I kept using it when debugging.

v2:
 - Migration blocker when INVTSC is set (Thanks Paolo for pointing that out!)
 - Dirty page tracking fix (Thanks Roman for noticing the regression in
   observed behaviour on certain VMs, which led me to debugging this issue.)
 - vCPU handle type cleanup (Based on discussion with Paolo)
 - Added fixes for existing compile warnings.
 - Split patch series into 2 parts.

This work has been sponsored by Sauce Labs Inc.

Phil Dennis-Jordan (7):
  i386/hvf: Adds support for INVTSC cpuid bit
  i386/hvf: Fixes some compilation warnings
  hvf: Consistent types for vCPU handles
  i386/hvf: Fixes dirty memory tracking by page granularity RX->RWX
    change
  i386/hvf: In kick_vcpu use hv_vcpu_interrupt to force exit
  i386/hvf: Updates API usage to use modern vCPU run function
  hvf: Makes assert_hvf_ok report failed expression

 accel/hvf/hvf-accel-ops.c    |  2 +-
 accel/hvf/hvf-all.c          | 49 ++++++++++++++++--------------------
 include/sysemu/hvf_int.h     |  9 +++++--
 target/i386/hvf/hvf.c        | 47 +++++++++++++++++++++++++++++++---
 target/i386/hvf/vmx.h        |  3 +--
 target/i386/hvf/x86_cpuid.c  |  4 +++
 target/i386/hvf/x86_decode.c |  2 +-
 target/i386/hvf/x86_emu.c    |  4 +--
 8 files changed, 81 insertions(+), 39 deletions(-)

-- 
2.36.1


