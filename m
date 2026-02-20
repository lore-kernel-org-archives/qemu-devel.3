Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DDFC56207
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 15:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtS7q-0005nz-V2; Fri, 20 Feb 2026 10:09:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS22-00085I-UL; Fri, 20 Feb 2026 10:03:03 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS1z-0002HY-TH; Fri, 20 Feb 2026 10:03:02 -0500
DKIM-Signature: a=rsa-sha256; bh=L0ZuRgvAL6p2z3dc80eHicCmDpyu0nLQtCVQJxt0qzc=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1771599767; v=1;
 b=iCs2MP5RHV0KGY+Zhg1JDr2iurnENzM/+g3FNPG8bXeZ2aIf+SBC4LuTN6mRZYgYdEfI7MxZ
 GGlS5vqUZFj/G5EeDqbyCjyql6BMriD394HLqWVrHmbvlunrlYkXjiYk19UryBe7WtvASu4rLSS
 7GQrmSKdtQ/q2LZfM6OxxXKiJbXDAQP3s6Jt5Cie5UuD6n6rg+t1U92lWO3KVP0cqY+8OsvEdRv
 RF14BoxO/noN/lTv7f1UoZl5JXHmdNCTLmcwAVDLEXzj3Mim3IqVYYgvcjzopminiOJpRTbFrFG
 aa6yipTRMUNBkJbxxL/86Y3MM13tHDU3hHbBuIl7uRGQw==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 4ADC025014;
 Fri, 20 Feb 2026 15:02:47 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Fri, 20 Feb 2026 15:02:47 +0000
MIME-Version: 1.0
Subject: [PATCH qemu 00/11] Introduce ot-earlgrey machine, and one peripheral
 for it (alert handler)
Message-ID: <177159976712.8279.7732381632410882915-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Daniel =?utf-8?q?P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 lowRISC <qemu-maintainers@lowrisc.org>, nabihestefan@google.com,
 Amit Kumar-Hermosillo <amitkh@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Feb 2026 10:09:01 -0500
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
Reply-To: ~lexbaileylowrisc <lex.bailey@lowrisc.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is the start of efforts to contribute code from the lowRISC fork of
QEMU to bring the QEMU support for OpenTitan machines in line with Earl
Grey
1.0 by adding a new machine called ot-earlgrey. This work was done by
Emmanuel Blot and Lo=C3=AFc Lefort from Rivos, and various people at lowRISC.
This patch set in particular adds the basic machine definition, Ibex-
related changes, and one of the peripherals required for it: the alert
handler device.

I previously emailed asking for advice on how to test our changes in a
way that is acceptable upstream, and how best to submit such a large set
of changes,
if anyone has more thoughts on that, please do reply to that email.
(https://lists.nongnu.org/archive/html/qemu-riscv/2026-02/msg00139.html)
There's lots more commits to come, I don't want to dump too much on the
mailing list all at once. For now this is a small first step.

This patch set should give a flavour of the style of what's to come, and
I'm expecting there will be some changes required. We'd just like to
understand what will be needed to make this acceptable as soon as we can
before we try to upstream lots more of these changes.

In particular, most of our new peripheral blocks are currently in the
directory called hw/opentitan. In our fork we have about 60 blocks in
this directory, we have put them there to keep them organised as
opentitan-specific blocks. Is this a suitable place for them? would you
prefer a different structure?

Thanks!

Emmanuel Blot (10):
  [ot] target/riscv: rename ibex hart as lowrisc-ibex
  [ot] hw/char, hw/timer, hw/ssi: fix device definitions
  [ot] hw/riscv: add helper for Ibex platforms
  [ot] target/riscv: implement custom LowRisc Ibex CSRs
  [ot] target/riscv: add custom mtvec CSR management
  [ot] target/riscv, hw/riscv: add basic OpenTitan EarlGrey machine
  [ot] target/riscv: add support for impl-defined initial PMP config
  [ot] hw/riscv: ot_earlgrey: add HW PMP configuration
  [ot] hw/riscv: add an IRQ wrapper
  [ot] hw/riscv, hw/opentitan: add Opentitan Alert handler device

Lo=C3=AFc Lefort (1):
  [ot] hw/opentitan: add OpenTitan shadow register helpers

 MAINTAINERS                       |  21 +-
 hmp-commands-info.hx              |  12 +
 hw/Kconfig                        |   3 +
 hw/char/Kconfig                   |   3 +
 hw/char/meson.build               |   2 +-
 hw/meson.build                    |   1 +
 hw/opentitan/Kconfig              |   4 +
 hw/opentitan/meson.build          |   3 +
 hw/opentitan/ot_alert.c           | 668 +++++++++++++++++++++++
 hw/opentitan/trace-events         |   6 +
 hw/opentitan/trace.h              |   2 +
 hw/riscv/Kconfig                  |  14 +
 hw/riscv/ibex_common.c            | 316 +++++++++++
 hw/riscv/meson.build              |   2 +
 hw/riscv/opentitan.c              |  30 +-
 hw/riscv/ot_earlgrey.c            | 851 ++++++++++++++++++++++++++++++
 hw/ssi/Kconfig                    |   4 +
 hw/ssi/meson.build                |   2 +-
 hw/timer/Kconfig                  |   3 +
 hw/timer/ibex_timer.c             |   2 +-
 hw/timer/meson.build              |   2 +-
 include/hw/opentitan/ot_alert.h   |  23 +
 include/hw/opentitan/ot_common.h  |  93 ++++
 include/hw/riscv/ibex_common.h    | 322 +++++++++++
 include/hw/riscv/ibex_irq.h       |  69 +++
 include/hw/riscv/opentitan.h      |   4 +-
 include/hw/riscv/ot_earlgrey.h    |  27 +
 meson.build                       |   1 +
 target/riscv/cpu-qom.h            |   4 +-
 target/riscv/cpu.c                |  40 +-
 target/riscv/cpu.h                |   7 +
 target/riscv/cpu_cfg_fields.h.inc |   7 +
 target/riscv/ibex_csr.c           | 115 ++++
 target/riscv/meson.build          |   1 +
 34 files changed, 2641 insertions(+), 23 deletions(-)
 create mode 100644 hw/opentitan/Kconfig
 create mode 100644 hw/opentitan/meson.build
 create mode 100644 hw/opentitan/ot_alert.c
 create mode 100644 hw/opentitan/trace-events
 create mode 100644 hw/opentitan/trace.h
 create mode 100644 hw/riscv/ibex_common.c
 create mode 100644 hw/riscv/ot_earlgrey.c
 create mode 100644 include/hw/opentitan/ot_alert.h
 create mode 100644 include/hw/opentitan/ot_common.h
 create mode 100644 include/hw/riscv/ibex_common.h
 create mode 100644 include/hw/riscv/ibex_irq.h
 create mode 100644 include/hw/riscv/ot_earlgrey.h
 create mode 100644 target/riscv/ibex_csr.c

--=20
2.49.1

