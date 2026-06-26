Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79DBC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6ib-0004Mn-C3; Fri, 26 Jun 2026 09:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wd6iZ-0004MY-23
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:35:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wd6iW-0006l7-RW
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782480933;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q0hhE7Pq2hM9NxLS5N0QKeUdQIeUbKrqY11OufozFwc=;
 b=ckBNOzanr6+TEaoeJmnMQyvxOG0nLmMOoWjfF+rndj3iudabZ3E4jLxZFrySl7tMqLe5ea
 /yH785EyKK9dgwpKa/uUfA6zDUy0WexwdhPI5oitrFEWFQCfJy+DPJ/C4mzlG4sF6ac8Vl
 RIJT4r/rmx/EkLg5IkAkE27bkdZaNBI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-FOI3BWk9M3uqKxftAzH0bg-1; Fri,
 26 Jun 2026 09:35:29 -0400
X-MC-Unique: FOI3BWk9M3uqKxftAzH0bg-1
X-Mimecast-MFC-AGG-ID: FOI3BWk9M3uqKxftAzH0bg_1782480926
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3792718004D4; Fri, 26 Jun 2026 13:35:26 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB511195608A; Fri, 26 Jun 2026 13:35:22 +0000 (UTC)
Date: Fri, 26 Jun 2026 14:35:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: devel@lists.libvirt.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v5 00/35] monitor: turn QMP and HMP into QOM objects
Message-ID: <aj6AFxvD7xTPZIrV@redhat.com>
References: <20260624173752.2928717-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624173752.2928717-1-berrange@redhat.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Markus,

This series is fully reviewed now by multiple people.

Do you have any plans to do reviews and/or queue this as maintainer,
or will you ack it for me to send a pull request.

I would like to get this merged before soft freeze which is fast
approaching.

On Wed, Jun 24, 2026 at 06:37:16PM +0100, Daniel P. Berrangé wrote:
> Conceptually -object and object_add/object_del should be sufficient
> for essentially all QEMU configuration....if only we ported all our
> internal custom backends/devices/etc to QOM. That is of course a big
> job which is why it hasn't happened.
> 
> This series started with the premise that the monitor is one of the
> easier areas to convert since we have no more than three classes,
> a common base, and QMP and HMP subclasses[1]. So why not give it a
> go and thus unlock the ability to dynamically create/delete monitors
> in QMP/HMP.
> 
> This series does the conversion in a great many small steps to better
> understand the implications at each stage.
> 
> The high level outcome of this series is
> 
>  * HMP and QMP monitors are QOM objects, 'monitor-hmp' and
>    'monitor-qmp' respectively
> 
>  * Both can be cold plugged and hot plugged. QMP only, can
>    also be hot unplugged.
> 
>  * '-mon' is obsolete, deprecated and replaced by '-object',
>    but -monitor, -qmp and kept  as high level syntax sugar
> 
>  * QMP gains a concept of "close-action" which makes it
>    possible to mark a monitor for auto-delete.
> 
> The monitor hot-unplug code and the qtest and functional testing
> code is heavily derived from a series sent by Christian Brauner
> which proposed new monitor_add/monitor_del commands:
> 
>   https://lists.nongnu.org/archive/html/qemu-devel/2026-04/msg01349.html
> 
> I left Christian's authorship & SoB on the patches which were
> derived from his code, though the code has been refactored quite
> a bit in places, so bugs are quite possibly my own.
> 
> Note that Christian's series allowed the use of "monitor_del"
> commands against the current monitor session. ie a client could
> delete the very monitor it was using. This is an awkward concept
> as it needs special casing to delay the deletion to happen in
> the background, such that that the QMP response to 'monitor_del'
> could still be sent back. This also left the chardev was orphaned
> as there's no way to run 'chardev_dev' in that usage pattern.
> 
> To provide an alternative mechanism to address the same use case,
> this series introduces the 'close-action' concept mentioned above,
> that allows hotplugging a monitor to service a specific task,
> with the monitor being purged when the script closes its connection.
> This avoids the special casing that an explicit "self deletion"
> paradigm required.
> 
> While supporting hotplug of HMP was trivial, I didn't do any work
> to think about hotunplug of HMP, since IMHO it is of limited value
> given HMP's typical use cases.
> 
> [1] ~~~ we did all this not because it was easy,
>         but because we thought it would be easy ~~~
> 
> Changed in v5:
> 
>  - Address another race when looking up monitor by ID
>  - Refer to "line editting" when talking about HMP
>    readline feature
>  - Misc typos
>  - Fix mis-placed setting of 'delete_pending'
>  - Add test case to validate reconnecting to QMP
> 
> Changed in v4:
> 
>  - Hold reference into BH to avoid race with auto-delete
> 
> Changed in v3:
> 
>  - Removed unused 'dead' struct field
>  - Make use of 'setup_pending' struct field across BH
>  - Add missing free of chardev_id
>  - Add missnig ERRP_GUARD in monitor_new_qmp
>  - Misc docs typos / rephrasing
>  - Moved docs patch to the end
>  - Fixed docs about the default QOM ID naming for legacy
>    monitor syntax
>  - Fixed random sleep time calculation in tests
> 
> Christian Brauner (6):
>   monitor: convert from oneshot BH to persistent BH
>   monitor: reject attempts to delete the current monitor
>   monitor: protect qemu_chr_fe_accept_input with monitor lock
>   monitor: implement support for deleting QMP objects
>   tests/qtest: add tests for dynamic monitor add/remove
>   tests/functional: add e2e test for dynamic QMP monitor hotplug
> 
> Daniel P. Berrangé (29):
>   qom: replace 'can_be_deleted' with 'prepare_delete'
>   monitor: replace 'common' with 'parent_obj' in MonitorHMP
>   monitor: replace 'common' with 'parent_obj' in MonitorQMP
>   monitor: rename monitor_init* to monitor_new*
>   monitor: minimal conversion of monitors to QOM
>   monitor: add 'chardev' property to Monitor base class
>   monitor: add 'readline' property to HMP Monitor class
>   monitor: add 'pretty' property to QMP Monitor class
>   monitor: remove 'skip_flush' field
>   monitor: move monitor_data_(init|destroy) into QOM init/finalize
>   monitor: use class methods for monitor_vprintf
>   monitor: use class methods for monitor_qapi_event_emit
>   monitor: use class methods for monitor_accept_input
>   monitor: use class method for I/O thread request
>   monitor: use dynamic cast in monitor_qmp_requests_pop_any_with_lock
>   util: use dynamic cast in error vreport
>   monitor: drop unused monitor_cur_is_qmp
>   monitor: use dynamic cast in QMP commands
>   monitor: use dynamic cast in monitor_is_hmp_non_interactive
>   monitor: drop unused monitor_is_qmp method
>   monitor: eliminate monitor_is_hmp_non_interactive method
>   monitor: implement "user creatable" interface for adding monitors
>   tests/functional: add a stress test for monitor hot unplug
>   qom: add method for getting the "id" of a QOM object
>   qom: add trace events for user creatable create/delete APIs
>   monitor: add support for auto-deleting monitors upon close
>   tests: switch from -mon to -object monitor-qmp
>   qemu-options: document new monitor-hmp and monitor-qmp objects
>   docs: mark '-mon' as deprecated in favour of -object
> 
>  MAINTAINERS                                   |   1 +
>  backends/cryptodev.c                          |  10 +-
>  backends/hostmem.c                            |   5 +-
>  backends/iommufd.c                            |  10 +-
>  block/throttle-groups.c                       |  10 +-
>  chardev/char.c                                |   3 +-
>  docs/about/deprecated.rst                     |  10 +
>  docs/devel/writing-monitor-commands.rst       |   4 +-
>  docs/system/arm/xenpvh.rst                    |   4 +-
>  docs/system/i386/xen.rst                      |   3 +-
>  docs/system/i386/xenpvh.rst                   |   4 +-
>  event-loop-base.c                             |   8 +-
>  gdbstub/system.c                              |   4 +-
>  include/monitor/monitor.h                     |  23 +-
>  include/qom/object.h                          |  10 +
>  include/qom/object_interfaces.h               |  26 +-
>  include/system/event-loop-base.h              |   2 +-
>  migration/migration-hmp-cmds.c                |   5 +-
>  monitor/hmp-cmds.c                            |   7 +-
>  monitor/hmp.c                                 | 181 ++++++++--
>  monitor/monitor-internal.h                    |  73 ++--
>  monitor/monitor.c                             | 262 +++++++-------
>  monitor/qmp-cmds-control.c                    |  12 +-
>  monitor/qmp-cmds.c                            |  14 +-
>  monitor/qmp.c                                 | 319 +++++++++++++++---
>  net/can/can_core.c                            |   5 +-
>  python/qemu/machine/machine.py                |   4 +-
>  qapi/qom.json                                 |  62 ++++
>  qemu-options.hx                               |  56 ++-
>  qom/object.c                                  |  17 +
>  qom/object_interfaces.c                       |  20 +-
>  qom/trace-events                              |   5 +
>  storage-daemon/qemu-storage-daemon.c          |   2 +-
>  stubs/monitor-core.c                          |   5 -
>  stubs/monitor-internal.c                      |   3 +-
>  system/vl.c                                   |  12 +-
>  tests/functional/generic/meson.build          |   1 +
>  .../generic/test_monitor_hotplug.py           | 305 +++++++++++++++++
>  tests/qemu-iotests/245                        |   4 +-
>  tests/qtest/libqtest.c                        |   2 +-
>  tests/qtest/qmp-test.c                        | 174 ++++++++++
>  tests/unit/test-util-sockets.c                |   1 -
>  tools/qemu-vnc/stubs.c                        |   5 -
>  ui/ui-hmp-cmds.c                              |   2 +-
>  util/error-report.c                           |  13 +-
>  util/main-loop.c                              |   5 +-
>  46 files changed, 1386 insertions(+), 327 deletions(-)
>  create mode 100755 tests/functional/generic/test_monitor_hotplug.py
> 
> -- 
> 2.54.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


