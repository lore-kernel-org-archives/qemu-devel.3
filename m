Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15104C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1lf-00023c-Ln; Thu, 08 May 2025 09:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD1ld-0001wZ-O0
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:58:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD1lb-000788-LJ
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746712705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pEO6zrNDP8JVAnGZkkv/e2DEANggGBh/C8i5DqPIgH4=;
 b=hhYe3zcTOB2Xb80hQOFdd71Dq3HLs0xI2h2YdVRW8vule03Gaeo0tP+q5EwIfwKErWinQ1
 sTq/l6U/VF6n2MjU8iYIJqHaJXWxhno3Tyg4QR78E2dgw7MeWYniLdSby9V5SAkku7Y9Gm
 qgFm+GAV1bWM8pnapcJ3efhQH5O+Dok=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-fHIyjQC3MlqLWUH0ZgNitQ-1; Thu,
 08 May 2025 09:58:22 -0400
X-MC-Unique: fHIyjQC3MlqLWUH0ZgNitQ-1
X-Mimecast-MFC-AGG-ID: fHIyjQC3MlqLWUH0ZgNitQ_1746712701
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D48C919560AA; Thu,  8 May 2025 13:58:20 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.138])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 14AF0180049D; Thu,  8 May 2025 13:58:17 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH RFC 00/10] qapi: remove all TARGET_* conditionals from the
 schema
Date: Thu,  8 May 2025 14:58:06 +0100
Message-ID: <20250508135816.673087-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Pierrick has proposed a series that introduces a concept of runtime
conditionals to the QAPI schema, in order to adapt the TARGET_*
conditionals currently used at build time:

  https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg01699.html

For the sake of comparison & evaluation, this series illustrates the
alternative approach that we've discussed of entirely removing any
concept of TARGET_* conditionals.

With this the QAPI schema varies solely based on CONFIG_* conditionals,
and is thus invariant across different target emulators.

In this PoC I've taken the minimal effort approach to the problem.

The QAPI schema has removed the TARGET_* conditionals and in order to
make all the emulators then compile, the stubs/ directory is populated
with a bunch of files to provide dummy impls of the target specific QMP
commands.

This is sufficient to make the current QEMU binaries build successfully.

To make the "single binary" concept work, however, would require
additional followup work to eliminate the stubs.

Instead of having stubs we would need to de-couple the QMP command
impl from the machine internals. This would likely require greater
use of interfaces and/or virtual method dispatchers on the machine
class. This would enable the 'qmp_XXXXX' command impls to exist
once. Then they call out to virtual methods on the machine to provide
the real impl, and/or generate an error if the virtual method is not
implemented for the machine.

Daniel P. Berrangé (9):
  qapi: expose rtc-reset-reinjection command unconditionally
  qapi: expand docs for SEV commands
  qapi: make SEV commands unconditionally available
  qapi: expose query-gic-capability command unconditionally
  qapi: make SGX commands unconditionally available
  qapi: make Xen event commands unconditionally available
  qapi: remove the misc-target.json file
  qapi: make most CPU  commands unconditionally available
  qapi: make s390x specific CPU commands unconditionally available

Philippe Mathieu-Daudé (1):
  qapi: Make CpuModelExpansionInfo::deprecated-props optional and
    generic

 hw/i386/kvm/xen-stubs.c               |  13 -
 hw/i386/kvm/xen_evtchn.c              |   2 +-
 hw/i386/monitor.c                     |   2 +-
 hw/i386/sgx-stub.c                    |  13 -
 hw/i386/sgx.c                         |   2 +-
 hw/s390x/cpu-topology.c               |   4 +-
 hw/s390x/s390-skeys.c                 |   1 -
 include/hw/s390x/cpu-topology.h       |   2 +-
 qapi/machine-s390x.json               | 120 ++++++
 qapi/machine-target.json              | 523 --------------------------
 qapi/machine.json                     | 363 ++++++++++++++++++
 qapi/meson.build                      |   5 +-
 qapi/misc-arm.json                    |  49 +++
 qapi/misc-i386.json                   | 479 +++++++++++++++++++++++
 qapi/misc-target.json                 | 504 -------------------------
 qapi/qapi-schema.json                 |   5 +-
 stubs/meson.build                     |   8 +
 stubs/monitor-arm-gic.c               |  12 +
 stubs/monitor-cpu-s390x-kvm.c         |  22 ++
 stubs/monitor-cpu-s390x.c             |  23 ++
 stubs/monitor-cpu.c                   |  21 ++
 stubs/monitor-i386-rtc.c              |  10 +
 stubs/monitor-i386-sev.c              |  36 ++
 stubs/monitor-i386-sgx.c              |  17 +
 stubs/monitor-i386-xen.c              |  16 +
 target/arm/arm-qmp-cmds.c             |   4 +-
 target/i386/cpu-system.c              |   2 +-
 target/i386/cpu.c                     |   2 +-
 target/i386/monitor.c                 |   1 -
 target/i386/sev-system-stub.c         |  32 --
 target/i386/sev.c                     |   2 +-
 target/loongarch/loongarch-qmp-cmds.c |   2 +-
 target/mips/system/mips-qmp-cmds.c    |  12 +-
 target/ppc/ppc-qmp-cmds.c             |  12 +-
 target/riscv/riscv-qmp-cmds.c         |   2 +-
 target/s390x/cpu_models_system.c      |   2 +-
 tests/qtest/qmp-cmd-test.c            |   1 +
 37 files changed, 1219 insertions(+), 1107 deletions(-)
 create mode 100644 qapi/machine-s390x.json
 delete mode 100644 qapi/machine-target.json
 create mode 100644 qapi/misc-arm.json
 create mode 100644 qapi/misc-i386.json
 create mode 100644 stubs/monitor-arm-gic.c
 create mode 100644 stubs/monitor-cpu-s390x-kvm.c
 create mode 100644 stubs/monitor-cpu-s390x.c
 create mode 100644 stubs/monitor-cpu.c
 create mode 100644 stubs/monitor-i386-rtc.c
 create mode 100644 stubs/monitor-i386-sev.c
 create mode 100644 stubs/monitor-i386-sgx.c
 create mode 100644 stubs/monitor-i386-xen.c

-- 
2.49.0


