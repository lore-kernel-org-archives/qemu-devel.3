Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE14D3ABC2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 15:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAWmH-00047m-0n; Mon, 11 Nov 2024 10:56:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tAWm0-00045O-6v
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 10:56:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tAWlx-0000mf-Cy
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 10:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731340572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=o9yj5P6w1ZaEWEmYon8JCr5YpNkI/L2iZpt7H7KKBn0=;
 b=RW/WPRiZzP1Gx7yiHSmpjSDWdWhkSFjHLs5UR04QmzaqOmFXrGS8jPZ5im/oDnBDySezM9
 t0C88PYW3rPNSuBEYVYFtslvCSeLQDXEu7obWLsHeiqEkPLAuDDW24rHaUF8YoRCXS+tHX
 y/NdWfSteCWE0q5djqC9FUxtHH2SBzY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-z761nvmvPkGFz6CSetLMaQ-1; Mon,
 11 Nov 2024 10:56:06 -0500
X-MC-Unique: z761nvmvPkGFz6CSetLMaQ-1
X-Mimecast-MFC-AGG-ID: z761nvmvPkGFz6CSetLMaQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 890EE19541AE
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 15:55:59 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.238])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 31F1819560A3; Mon, 11 Nov 2024 15:55:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 0/8] Require error handling for dynamically created objects
Date: Mon, 11 Nov 2024 15:55:47 +0000
Message-ID: <20241111155555.90091-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.671,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

NB, this series is targetting 10.0, NOT for 9.2 freeze.

With code like

    Object *obj = object_new(TYPE_BLAH)

the caller can be pretty confident that they will successfully create
an object instance of TYPE_BLAH. They know exactly what type has been
requested, so it passing an abstract type for example, it is a clear
programmer error that they'll get an assertion failure.

Conversely with code like

   void somefunc(const char *typename) {
      Object * obj = object_new(typename)
      ...
   }

all bets are off, because the call of object_new() knows nothing
about what 'typename' resolves to. It could easily be an abstract
type. As a result, many code paths have added a manual check ahead
of time

   if (object_class_is_abstract(typename)) {
      error_setg(errp, ....)
   }

...except for where we forget to do this, such as qdev_new().

Overall 'object_new' is a bad design because it is inherantly
unsafe to call with unvalidated typenames.

This problem is made worse by the proposal to introduce the idea
of 'singleton' classes[1].

Thus, this series suggests a way to improve safety at build
time. The core idea is to allow 'object_new' to continue to be
used *if-and-only-if* given a static, const string, because that
scenario indicates the caller is aware of what type they are
creating at build time.

A new 'object_new_dynamic' method is proposed for cases where
the typename is dynamically chosen at runtime. This method has
an "Error **errp" parameter, which can report when an abstract
type is created, leaving the assert()s only for scenarios which
are unambiguous programmer errors.

With a little macro magic, we guarantee a compile error is
generated if 'object_new' is called with a dynamic type, forcing
all potentially unsafe code over to object_new_dynamic.

This is more tractable than adding 'Error **errp' to 'object_new'
as only a handful of places use a dynamic type name.

With this series, my objections to Peter Xu's singleton series[1]
would be largely nullified.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg05524.html

Changed in v2:

 * Removed "RFC" tag
 * Converted code in all non-x86_64 targets
 * Converted qdev_new to same pattern as object_new
 * Ensured test suites work now

Daniel P. Berrangé (8):
  qom: refactor checking abstract property when creating instances
  qom: allow failure of object_new_with_class
  qom: introduce object_new_dynamic()
  convert code to object_new_dynamic() where appropriate
  qom: enforce use of static, const string with object_new()
  qom: introduce qdev_new_dynamic()
  convert code to qdev_new_dynamic() where appropriate
  hw: enforce use of static, const string with qdev_new()

 accel/accel-user.c                    |  4 +-
 chardev/char.c                        |  6 ++-
 hw/arm/aspeed.c                       |  6 +--
 hw/arm/exynos4210.c                   |  3 +-
 hw/arm/highbank.c                     |  2 +-
 hw/arm/integratorcp.c                 |  2 +-
 hw/arm/mps3r.c                        |  3 +-
 hw/arm/npcm7xx_boards.c               |  2 +-
 hw/arm/realview.c                     |  3 +-
 hw/arm/sbsa-ref.c                     |  7 +--
 hw/arm/versatilepb.c                  |  2 +-
 hw/arm/vexpress.c                     |  4 +-
 hw/arm/virt.c                         | 10 ++--
 hw/arm/xilinx_zynq.c                  |  3 +-
 hw/audio/soundhw.c                    |  2 +-
 hw/block/xen-block.c                  |  7 ++-
 hw/core/bus.c                         |  2 +-
 hw/core/cpu-common.c                  |  2 +-
 hw/core/qdev.c                        | 24 +++++++--
 hw/core/sysbus.c                      |  2 +-
 hw/i2c/core.c                         |  2 +-
 hw/i386/x86-common.c                  |  5 +-
 hw/i386/xen/xen-pvh.c                 |  2 +-
 hw/intc/xics.c                        |  5 +-
 hw/isa/isa-bus.c                      |  4 +-
 hw/mips/cps.c                         |  3 +-
 hw/pci-host/pnv_phb.c                 |  5 +-
 hw/pci/pci.c                          |  2 +-
 hw/ppc/e500.c                         |  2 +-
 hw/ppc/pnv.c                          |  6 +--
 hw/ppc/pnv_core.c                     |  5 +-
 hw/ppc/spapr.c                        |  2 +-
 hw/ppc/spapr_cpu_core.c               |  5 +-
 hw/ppc/spapr_drc.c                    |  2 +-
 hw/s390x/s390-virtio-ccw.c            | 10 +++-
 hw/scsi/scsi-bus.c                    |  5 +-
 hw/sparc/leon3.c                      |  2 +-
 hw/sparc/sun4m.c                      |  2 +-
 hw/sparc64/sparc64.c                  |  2 +-
 hw/ssi/ssi.c                          |  2 +-
 hw/vfio/common.c                      |  6 ++-
 hw/vfio/container.c                   |  7 ++-
 include/hw/qdev-core.h                | 78 ++++++++++++++++++++++++++-
 include/hw/usb.h                      |  4 +-
 include/qom/object.h                  | 48 +++++++++++++++--
 net/net.c                             |  7 +--
 qom/object.c                          | 44 ++++++++++-----
 qom/object_interfaces.c               |  7 ++-
 qom/qom-qmp-cmds.c                    | 16 +++---
 system/qdev-monitor.c                 |  5 +-
 system/vl.c                           |  6 ++-
 target/arm/arm-qmp-cmds.c             |  5 +-
 target/i386/cpu-apic.c                |  8 ++-
 target/i386/cpu-sysemu.c              | 11 ++--
 target/i386/cpu.c                     |  4 +-
 target/loongarch/loongarch-qmp-cmds.c |  5 +-
 target/mips/cpu.c                     |  2 +-
 target/riscv/riscv-qmp-cmds.c         |  5 +-
 target/s390x/cpu_models_sysemu.c      |  7 ++-
 target/xtensa/cpu.c                   |  2 +-
 tests/unit/check-qom-interface.c      |  3 +-
 tests/unit/test-smp-parse.c           | 20 +++----
 62 files changed, 353 insertions(+), 116 deletions(-)

-- 
2.46.0


