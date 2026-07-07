Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3748C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3a5-0002Jn-Ir; Tue, 07 Jul 2026 07:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a0-0002I2-Qd
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3Zz-0007zp-2T
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783422185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wlb2CbxwsdCOlzzK9WvfwVqg0kHJV0o/Wgs6oUuGkoI=;
 b=RxRIul8DNSjZWH1UR96S50Wb1d323VGsdQfLp1mw6jfDjNIH7ZT2ZIyUT5gaV7aWCLgLEf
 qcLxsa2XjfIPTi9A9BAdWaarRoK1u8Jmj+F/spg+vb9lsuASW1DS5DR5embgU5tr065shl
 YIDHAI5k/6e5o/yVsFuAzuGFYHoRsKo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-ViEj8ApnOraD7InXefRNBQ-1; Tue,
 07 Jul 2026 07:03:04 -0400
X-MC-Unique: ViEj8ApnOraD7InXefRNBQ-1
X-Mimecast-MFC-AGG-ID: ViEj8ApnOraD7InXefRNBQ_1783422184
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9068195411D
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2068C1800749
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 11:03:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 954A521E6920; Tue, 07 Jul 2026 13:03:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 00/35] Monitor patches for 2026-07-07
Date: Tue,  7 Jul 2026 13:02:25 +0200
Message-ID: <20260707110300.1918153-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

The following changes since commit 94826ec1370328375c3b6d1e80fdc94c8f46c348:

  Merge tag 'accel-20260706' of https://github.com/philmd/qemu into staging (2026-07-06 18:38:14 +0200)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-monitor-2026-07-07

for you to fetch changes up to 58b70f21ba6364be4f79d9f9c56b334341051bfd:

  docs: mark '-mon' as deprecated in favour of -object (2026-07-07 11:16:27 +0200)

----------------------------------------------------------------
Monitor patches for 2026-07-07

----------------------------------------------------------------
Christian Brauner (6):
      monitor: convert from oneshot BH to persistent BH
      monitor: reject attempts to delete the current monitor
      monitor: protect qemu_chr_fe_accept_input with monitor lock
      monitor: implement support for deleting QMP objects
      tests/qtest: add tests for dynamic monitor add/remove
      tests/functional: add e2e test for dynamic QMP monitor hotplug

Daniel P. Berrangé (29):
      qom: replace 'can_be_deleted' with 'prepare_delete'
      monitor: replace 'common' with 'parent_obj' in MonitorHMP
      monitor: replace 'common' with 'parent_obj' in MonitorQMP
      monitor: rename monitor_init* to monitor_new*
      monitor: minimal conversion of monitors to QOM
      monitor: pass chardev ID into monitor constructor instead of object
      monitor: add 'chardev' property to Monitor base class
      monitor: add 'readline' property to HMP Monitor class
      monitor: add 'pretty' property to QMP Monitor class
      monitor: remove 'skip_flush' field
      monitor: move monitor_data_(init|destroy) into QOM init/finalize
      monitor: use class methods for monitor_vprintf
      monitor: use class methods for monitor_qapi_event_emit
      monitor: use class methods for monitor_accept_input
      monitor: use class method for I/O thread request
      monitor: use dynamic cast in monitor_qmp_requests_pop_any_with_lock
      util: use dynamic cast in error vreport
      monitor: drop unused monitor_cur_is_qmp
      monitor: use dynamic cast in QMP commands
      monitor: use dynamic cast in monitor_is_hmp_non_interactive
      monitor: drop unused monitor_is_qmp method
      monitor: eliminate monitor_is_hmp_non_interactive method
      monitor: implement "user creatable" interface for adding monitors
      tests/functional: add a stress test for monitor hot unplug
      qom: add trace events for user creatable create/delete APIs
      monitor: add support for auto-deleting monitors upon close
      tests: switch from -mon to -object monitor-qmp
      qemu-options: document new monitor-hmp and monitor-qmp objects
      docs: mark '-mon' as deprecated in favour of -object

 MAINTAINERS                                      |   1 +
 docs/about/deprecated.rst                        |  10 +
 docs/devel/writing-monitor-commands.rst          |   4 +-
 docs/system/arm/xenpvh.rst                       |   4 +-
 docs/system/i386/xen.rst                         |   3 +-
 docs/system/i386/xenpvh.rst                      |   4 +-
 qapi/qom.json                                    |  63 +++++
 include/monitor/monitor.h                        |  26 +-
 include/qom/object_interfaces.h                  |  26 +-
 include/system/event-loop-base.h                 |   2 +-
 monitor/monitor-internal.h                       |  73 +++--
 backends/cryptodev.c                             |  12 +-
 backends/hostmem.c                               |   7 +-
 backends/iommufd.c                               |  11 +-
 block/throttle-groups.c                          |  12 +-
 chardev/char.c                                   |   3 +-
 event-loop-base.c                                |   8 +-
 gdbstub/system.c                                 |   2 +-
 migration/migration-hmp-cmds.c                   |   5 +-
 monitor/hmp-cmds.c                               |   7 +-
 monitor/hmp.c                                    | 181 ++++++++++---
 monitor/monitor.c                                | 273 ++++++++++---------
 monitor/qmp-cmds-control.c                       |  12 +-
 monitor/qmp-cmds.c                               |  14 +-
 monitor/qmp.c                                    | 323 ++++++++++++++++++++---
 net/can/can_core.c                               |   6 +-
 qom/object_interfaces.c                          |  20 +-
 storage-daemon/qemu-storage-daemon.c             |   2 +-
 stubs/monitor-core.c                             |   5 -
 stubs/monitor-internal.c                         |   4 +-
 system/vl.c                                      |  19 +-
 tests/qtest/libqtest.c                           |   2 +-
 tests/qtest/qmp-test.c                           | 174 ++++++++++++
 tests/unit/test-util-sockets.c                   |   1 -
 tools/qemu-vnc/stubs.c                           |   5 -
 ui/ui-hmp-cmds.c                                 |   2 +-
 util/error-report.c                              |  13 +-
 util/main-loop.c                                 |   6 +-
 python/qemu/machine/machine.py                   |   4 +-
 qemu-options.hx                                  |  64 ++++-
 qom/trace-events                                 |   5 +
 tests/functional/generic/meson.build             |   1 +
 tests/functional/generic/test_monitor_hotplug.py | 305 +++++++++++++++++++++
 tests/qemu-iotests/245                           |   4 +-
 44 files changed, 1395 insertions(+), 333 deletions(-)
 create mode 100755 tests/functional/generic/test_monitor_hotplug.py

-- 
2.54.0


