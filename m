Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB182606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bi3cNcVQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOueD-0001tP-6S; Thu, 05 Nov 2026 05:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOueB-0001tA-Nf
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:24:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOue9-0003r4-GD
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793874279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oVzIuAsDpk8MKvQv/28nvqFPfB1FIu+bXFrM3spZuzc=;
 b=bi3cNcVQLa2+0sbZBUu4hzuk2l6qPToS0g1UN4WTKMP0yyxqA5HiLN97JhRimjTOQJOfQh
 VP7RM9QTZDpoeKvrAlPXT01T0wO6eSfhyznyVEWzYsbU1OhAMkwhj/47VbvDuvqzJVBjsp
 60jc/D4XGwIhHxjV3Ao5gS1C9oeJSwM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-iqUjftg-OiWm1daMD9dHEA-1; Thu,
 05 Nov 2026 05:24:36 -0500
X-MC-Unique: iqUjftg-OiWm1daMD9dHEA-1
X-Mimecast-MFC-AGG-ID: iqUjftg-OiWm1daMD9dHEA_1793874275
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 680CA1801313; Thu,  5 Nov 2026 10:24:35 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 267AD187C372; Thu,  5 Nov 2026 10:24:33 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/4] hw: support machine filtering without is_available
Date: Thu,  5 Nov 2026 10:24:28 +0000
Message-ID: <20261105102432.1131493-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The 'is_available' callback on TypeInfo is based on a mistaken
notion that we should filter out classes at registration time
based on architecture.

This creates new problems however, some already present and
some which will impact a future multi-target binary

 * For introspection of the binaries' features, we have
   a dependancy on selecting a target before we can
   introspect features. It would require re-launching
   QEMU for each target, leading to lots of redundant
   introspection and a big time sink. It would also not
   be possible to introspect targets

 * It creates a circular dependancy on QOM initialization
   inside the QOM initialization code, since 'target_info()'
   itself uses QOM. This then requires further work to break
   by initializing QOM target info before the rest of QOM.

 * We have no means to introspect what targets a machine
   type can be used with, as this information is expressed
   as code (in target_XXXX() methods), instead of as data.

 * New fields in TypeInfo requires more changes to macros
   used for initializing machines.

There is no inherant conceptual reason why we must filter out
classes at type registration time. This is just a shortcut to
workaround historical technical debt where certain classes
have clashing names. This is an undesirable approach, as it
is trading one set of problems for a new set of problems.

This series proposes removal of the 'is_available' concept
from QOM, and illustrates handling machines with full introspection
support available from the MachineClass.

This implies fixing the root cause, of clashing class names,
but does not include patches since various series have already
been posted for machine class name fixes.

The machine changes are fairly simple

 * MachineClass gains a 'targets' field which is a bit mask
   of SysEmuTarget
 * machine_class_is_available() matches 'targets' against
   'target_info()'
 * -machine CLI enforces machine_class_is_available()
 * query-machines filters on machine_class_is_available
   by default
 * query-machines gains 'all-targets': 'bool' to opt-in
   to returning the unfiltered list, with a 'targets'
   list present

NB, this removes filtering from riscv CPUs with no
alternative proposed. I'm unclear what this was trying
to address to begin with, but utlimately it should be
possible to address it with runtime filtering/matching
of classes, instead of hiding TypeInfo registration.
If someone gives me info on the CPUs problem I can a
make a design suggestion.

Daniel P. Berrangé (4):
  hw/core: record permitted targets against MachineClass
  hw: replace 'is_available' with 'targets' in machines
  target/riscv: remove 'is_available' from riscv CPUs
  qom: drop the 'is_available' callback from TypeInfo

 hw/arm/aspeed_ast27x0-fc.c  |  3 ++-
 hw/arm/aspeed_ast27x0_evb.c |  5 +++--
 hw/arm/raspi.c              | 21 +++++++++++++--------
 hw/arm/raspi4b.c            |  3 ++-
 hw/arm/virt.c               |  5 +++--
 hw/core/machine-qmp-cmds.c  | 18 ++++++++++++++++++
 hw/core/machine.c           | 13 +++++++++++++
 hw/hexagon/virt.c           |  3 ++-
 hw/m68k/virt.c              |  4 ++--
 hw/or1k/virt.c              |  3 ++-
 hw/riscv/virt.c             |  4 +++-
 include/hw/core/boards.h    |  3 +++
 include/qom/object.h        |  3 ---
 qapi/machine.json           | 12 +++++++++++-
 qom/object.c                |  4 ----
 rust/qom/src/qom.rs         |  1 -
 system/vl.c                 |  9 +++++++++
 target/riscv/kvm/kvm-cpu.c  |  1 -
 target/riscv/tcg/tcg-cpu.c  |  1 -
 19 files changed, 86 insertions(+), 30 deletions(-)

-- 
2.56.0


