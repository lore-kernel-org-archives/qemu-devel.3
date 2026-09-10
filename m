Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1E6C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4c93-00032l-PR; Thu, 10 Sep 2026 06:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x4c92-00032L-AT
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x4c90-0007MZ-9e
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789036597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jNk2TovWQfu5ea9D2/ytii6MIW2uJoI44taSiSslwYE=;
 b=a6NjLiwEc8zwyvz+OniWPHZh/kl4Kyd9W+ogvR8tQUZdFfzRCv61jb4eyOrXCRcagpxwPp
 e3OYrJikHiEQWNvTuxSKfnDmhP5PFIg/1Gltgm4tvzJqxiKRemqR8quJ4FHSwaavttrEB6
 2hXDYC0X5a3JHwYYzcBOs/KSS1sE2Yg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-FaxiM2GjOCec-2LItVvBUA-1; Thu,
 10 Sep 2026 06:36:34 -0400
X-MC-Unique: FaxiM2GjOCec-2LItVvBUA-1
X-Mimecast-MFC-AGG-ID: FaxiM2GjOCec-2LItVvBUA_1789036593
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFDD7195423E; Thu, 10 Sep 2026 10:36:32 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A8D7630001BE; Thu, 10 Sep 2026 10:36:29 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 00/14] Encode object type security status in code
Date: Thu, 10 Sep 2026 11:36:14 +0100
Message-ID: <20260910103628.2326622-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Our docs/system/security.rst file loosely classifies code into that
applicable for 'virtualization' vs 'non-virtualization' use cases.
Only code relevant to the former group is eligible for security
bug handling. It is difficult for any contributors to know what
devices are in scope for 'virtualization' when reporting bugs,
and even maintainers can have a hard time agreeing.

It is well overdue to declare this information the code and present
it to end users at runtime. This series starts the effort by defining
the internal infrastructure, command line args and QMP extensions to
handle the security status recording and reporting.

A previous posting included classifications for many devices. That
is dropped this v3 series so we can focus on getting the core infra
included. Device classifications will follow afterwards in a separate
series.

The base concept is that the QOM  TypeInfo struct gains a new field
"bool secure". This enables querying any ObjectClass to ask whether
or not it is declared secure.

By only using a single boolean flag, at runtime we are unable to
distinguish between "marked insecure" and "no decision, implicitly
insecure". As such, all our existing code is initially considered
insecure, once this series is applied. Code we want to provide a
security boundary for will explicitly opt-in with '.secure = true'.

Previously it was intended to add '.secure = false' to each file
too as it gets evaluated, however, this is now considered to be
overkill. It is easy enough to build a list of everything that
should be treated as secure by perusing "-device help" output.

Classification for non-user creatable types can be left to a 2nd
phase of work.

In terms of user interface, the "-compat" argument gains a new
parameter

  * insecure-types=accept|reject|warn

    The default 'accept' preserves historical behaviour of
    anything being permissible. The other two options both
    identify use of types that are not explicitly marked
    as secure.

The code annotations are useful immediately, but the -compat
-compat switch is unusable unless a minimum viable set of
secure devices are defined in a follow series. Some conceptual
examples though...

Example: TCG is explicitly insecure, KVM is explicitly secure:

  $ qemu-system-x86_64 -display none -compat insecure-types=reject -accel tcg
  qemu-system-x86_64: -accel tcg: Type 'tcg-accel' does not provide a security boundary to protect against untrusted workloads
  $ qemu-system-x86_64 -display none -compat insecure-types=reject -accel kvm
  ^C

Example: isapc machine type is explicitly insecure

  $ qemu-system-x86_64 -display none -compat insecure-types=reject -machine isapc
  qemu-system-x86_64: Type 'isapc-machine' does not provide a security boundary to protect against untrusted workloads

Example: checks also apply in HMP, ne2k_pci is insecure

  $ ./build/qemu-system-x86_64 -display none -compat insecure-types=reject -monitor stdio -accel kvm
  QEMU 10.1.50 monitor - type 'help' for more information
  (qemu) device_add ne2k_pci
  Error: Type 'ne2k_pci' does not provide a security boundary to protect against untrusted workloads

Example: checks also apply in QMP:

  $ ./scripts/qmp/qmp-shell-wrap qemu-system-x86_64 -display none -compat insecure-types=reject -accel kvm
  Welcome to the QMP low-level shell!
  Connected
  (QEMU) device_add driver=ne2k_oci
  {"error": {"class": "GenericError", "desc": "Type 'ne2k_pci' does not provide a security boundary to protect against untrusted workloads"}}
  (QEMU) device_add driver=virtio-net
  {"return": {}}

This series is available at

  https://gitlab.com/berrange/qemu/-/commits/docs-security-status

The WIP patches that add tagging of devices (which I will post separately
in future) are at

  https://gitlab.com/berrange/qemu/-/commits/docs-security-devices

Changed in v4:

 * Drop object_check_security, as only checks against the
   class are needed
 * Fix QAPI "since" versions

Changes in v3:

 * Dropped all device classification, to be re-posted as
   a separate series
 * Reworded the docs based on previous feedback
 * Improved commit messages
 * Reformatted QAPI docs per feedback
 * Split commit adding QMP device list filtering
   into two
 * Make CompatPolicy parameters 'const'
 * Add helper APIs in QOM for querying security
   status to reduce duplicate code pattern
 * Fix placement of security check for accelerator
   types

Changes in v2:

 * Report security status in qom-list-types
 * Allow qom-list-types to filter on secure types
 * Remove 'bool insecure' on TypeInfo, assume that no specified
   data is equivalent to '.secure = false'
 * Annotate a massive number of object types

Daniel P. Berrangé (14):
  qom: add tracking of security state of object types
  qapi: add 'insecure-types' option for -compat argument
  qom: add helper API for checking object class security policy
    compliance
  system: check security for accelerator types
  system: report acclerator security status in help output
  system: check security for machine types
  system: report machine security status in help output
  system: check security of device types
  system: report device security status in help output
  hw/core: report security status in query-machines
  qom: refactor data passing for QOM list filtering
  qom: report & filter on security status in qom-list-types
  docs: expand security docs with info about security status
  machine: add helpers for declaring secure/insecure machine types

 docs/system/security.rst     | 36 ++++++++++++++++++++++++++++++++++++
 hw/arm/bananapi_m2u.c        |  2 +-
 hw/arm/cubieboard.c          |  2 +-
 hw/arm/imx8mm-evk.c          |  2 +-
 hw/arm/integratorcp.c        |  2 +-
 hw/arm/mcimx7d-sabre.c       |  2 +-
 hw/arm/orangepi.c            |  2 +-
 hw/core/machine-qmp-cmds.c   |  1 +
 hw/ppc/pegasos.c             |  3 ++-
 include/hw/core/boards.h     | 25 ++++++++++++++++++++-----
 include/hw/i386/pc.h         | 11 ++++++++++-
 include/qapi/compat-policy.h |  5 +++++
 include/qom/object.h         | 26 ++++++++++++++++++++++++++
 qapi/compat.json             | 23 ++++++++++++++++++++++-
 qapi/machine.json            |  8 +++++++-
 qapi/qapi-util.c             | 30 ++++++++++++++++++++++++++++++
 qapi/qom.json                | 13 +++++++++++--
 qom/object.c                 | 16 ++++++++++++++++
 qom/qom-qmp-cmds.c           | 30 ++++++++++++++++++++++++------
 system/qdev-monitor.c        |  7 +++++++
 system/vl.c                  | 30 +++++++++++++++++++++++++-----
 21 files changed, 248 insertions(+), 28 deletions(-)

-- 
2.55.0


