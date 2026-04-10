Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D6EF459F9
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBEMB-0003ua-1q; Fri, 10 Apr 2026 12:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEM4-0003pJ-Tz
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:05:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEM2-0006Lb-BR
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775837109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JtP4WTryhH9guBAN2A7tyUb+cg0JFkESkEjp9nk3qS4=;
 b=Xp7Sqf6pqswSGn4Tt0zmuet7Hh/+PHu9lTeXeHe6w3j4GeP+thO84BhsHrn2z7styHNwk1
 oQwt9nfaVZ7KmhK0jNUspOCRoDJWMjANx7GR5WVs3F5dDiHtScQO83tvEiL5wCkoUX6P5M
 fzH4c2rfEWv1iSROS9rLzcR/L5I83s8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-ke4vb9EDMc2uaEa0zHTE4w-1; Fri,
 10 Apr 2026 12:05:06 -0400
X-MC-Unique: ke4vb9EDMc2uaEa0zHTE4w-1
X-Mimecast-MFC-AGG-ID: ke4vb9EDMc2uaEa0zHTE4w_1775837104
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16B411955DB9; Fri, 10 Apr 2026 16:05:04 +0000 (UTC)
Received: from toolbx.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A38F195608E; Fri, 10 Apr 2026 16:05:00 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH RFC 00/17] monitor: turn QMP and HMP into QOM objects
Date: Fri, 10 Apr 2026 17:04:41 +0100
Message-ID: <20260410160458.3778874-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Conceptually -object and object_add/object_del should be sufficient
for essentially all QEMU configuration....if only we ported all our
internal custom backends/devices/etc to QOM. That is of course a big
job which is why it hasn't happened.

This series started with the premise that the monitor is one of the
easier areas to convert since we have no more than three classes,
a common base, and QMP and HMP subclasses. So why not give it a go
and thus unlock the ability to dynamically create/delete monitors
in QMP/HMP.

This series does the conversion in as many small steps as I could
achieve. At the end it is possible to create HMP and QMP monitors
with -object and object_add.

In theory object_del is possible but is unsafe since there's no
synchronization wrt "in use" monitors. Christian Brauner sent
a proposal for monitor_add/monitor_del commands that address the
safety/synchronization issues, but I've not yet integrated the
relevent bits of that series with this proposal:

  https://lists.nongnu.org/archive/html/qemu-devel/2026-04/msg01349.html

My overall feeling is that we're better off turning monitors
into QOM classes, rather than inventing more type specific
QMP commands.

What's missing:

 - Integration of code for safe deletion of monitors
 - The existing -mon/-qmp/-monitor args should be turned
   into syntax sugar around -object & -chardev
 - The new approach must be documented
 - Functional tests are needed for the hot add/remove of
   monitors and new -object syntax. (The pre-existing
   test suites cover the static config with the traditional
   args).

Daniel P. Berrangé (17):
  monitor: replace 'common' with 'parent' in MonitorHMP
  monitor: replace 'common' with 'parent' in MonitorQMP
  monitor: rename monitor_init* to monitor_new*
  monitor: minimal conversion of monitors to QOM
  monitor: remove 'skip_flush' field
  monitor: move monitor_data_(init|destroy) into QOM init/finalize
  monitor: use class methods for monitor_vprintf
  monitor: use class methods for monitor_qapi_event_emit
  monitor: use class methods for monitor_accept_input
  monitor: use dynamic cast in monitor_qmp_requests_pop_any_with_lock
  util: use dynamic cast in error vreport
  monitor: drop unused monitor_cur_is_qmp
  monitor: use dynamic cast in QMP commands
  monitor: use dynamic cast in monitor_is_hmp_non_interactive
  monitor: drop unused monitor_is_qmp method
  monitor: eliminate monitor_is_hmp_non_interactive method
  FIXME: monitor: implement "user creatable" interface

 chardev/char.c                       |  10 +-
 gdbstub/system.c                     |  10 +-
 include/monitor/monitor.h            |  21 ++-
 migration/migration-hmp-cmds.c       |   5 +-
 monitor/hmp-cmds.c                   |   7 +-
 monitor/hmp.c                        | 159 ++++++++++++++-----
 monitor/monitor-internal.h           |  44 +++---
 monitor/monitor.c                    | 222 +++++++++++++--------------
 monitor/qmp-cmds-control.c           |  12 +-
 monitor/qmp-cmds.c                   |  14 +-
 monitor/qmp.c                        | 138 ++++++++++++-----
 qapi/qom.json                        |  43 ++++++
 storage-daemon/qemu-storage-daemon.c |   2 +-
 stubs/monitor-core.c                 |   5 -
 stubs/monitor-internal.c             |   4 -
 system/vl.c                          |  10 +-
 tests/unit/test-util-sockets.c       |   1 -
 ui/ui-hmp-cmds.c                     |   2 +-
 util/error-report.c                  |  13 +-
 19 files changed, 465 insertions(+), 257 deletions(-)

-- 
2.53.0


