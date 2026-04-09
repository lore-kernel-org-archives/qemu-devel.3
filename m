Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAB1F364B5
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 19:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAvID-0001KD-TN; Thu, 09 Apr 2026 15:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wAvIB-0001Il-FS
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 15:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wAvI7-0006Cv-M3
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 15:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775763830;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uEnhudJQ3oNQZ1voyRXp7aWKstzR2pQLbxEvkrSU60k=;
 b=a4vBEl2x7XBZFoap2WalvJJtmnjl9bM7Wqn03W+bvmZXhdwgoJECLVz8QKIZZTeYPOcCxU
 8nT/xpkVrMUi6I2rRc9J/boifp/xvA1PGggyK1NWpEt72zLqCRI4AqvyR2EVbyfpN9VFDq
 7Tv5uBDvSspJtc4J4OLpeyX3c/nWltE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-Ty8jXh2zN_SNx6tJU0P38g-1; Thu,
 09 Apr 2026 15:43:47 -0400
X-MC-Unique: Ty8jXh2zN_SNx6tJU0P38g-1
X-Mimecast-MFC-AGG-ID: Ty8jXh2zN_SNx6tJU0P38g_1775763826
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3807E1956056; Thu,  9 Apr 2026 19:43:46 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7CFA180036E; Thu,  9 Apr 2026 19:43:43 +0000 (UTC)
Date: Thu, 9 Apr 2026 20:43:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 0/5] monitor: add dynamic QMP monitor hotplug support
Message-ID: <adgBbHDDcEhh9LpQ@redhat.com>
References: <20260409-work-qmp-monitor-hotplug-v4-0-89c4fdf69df1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260409-work-qmp-monitor-hotplug-v4-0-89c4fdf69df1@kernel.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 09, 2026 at 09:18:17AM +0200, Christian Brauner wrote:
> QEMU supports runtime hotplug for chardevs, devices, block backends,
> and netdevs. Monitors are the only major subsystem that lacks this --
> all QMP monitors must be configured at launch via -mon or -qmp CLI
> options.
> 
> This series adds monitor-add, monitor-remove, and query-monitors QMP
> commands so that management tools can create independent QMP sessions
> on demand at runtime.

There's nothing inherently wrong with your proposal. It is following
the standard historical design practice we've taken for enabling
hotplug/unplug of all the other backend types. Conceptually though
our historical practice is more of an accident of evolution rather
than an ideal state.

By this I mean we have a general purpose object framework
internally and commands '-object', and 'object_add' / 'object_del'
for hotplug/unplug in QMP and HMP. Conceptually these could handle
all of our objects, devices, netdev chardevs, monitors, etc, etc,
removing the need for the specialized add/remove QMP commands for
each backend type, and the specialized CLI argsf. 

The blocker has been lack of time to convert everything/anything,
since while the conversions are not especially difficult they are
certainly time consuming due to the sheer number of types that
exist in many cases.


I'm thinking the monitor, however, is a decent opportunity to
"do the right thing" from a design POV. We only have three classes
needed in QOM, the monitor generic base class, a HMP subclass and
a QMP subclass.

If we convert QMP/HMP into QOM objects, we could then use the
pre-existing object_add/object_del commands in both HMP and QMP.

I'm not asking you to do that conversion work though. I've
been doing some experimentation myself today to test the
viability of this idea and it looks promising.

Given we've got an entire 4 month dev cycle before these
proposed monitor-add/remove commands could get into a QEMU
release, I think it is worth trialling the QOM conversion
for a short while.

> I've implemented a QMP-to-Varlink bridge in systemd. This allows
> systemd-vmspawn to control virtual machines and containers through a
> unified Varlink interface. Varlink allows protocol upgrades. For
> example, it is possible to switch from Varlink to say http. I'm
> allowing Varlink clients to upgrade from the Varlink interface to the
> native QMP interface. Such clients get a new monitor assigned that
> allows them to manage the virtual machine directly via QMP. The main
> monitor remains unaffected and tied to the generic Varlink interface. We
> can't pre-allocate monitors as we have no control over how many protocol
> upgrades we actually get but it won't just be one. And having unused
> monitors around really isn't ideal either.
> 
> Having the ability to hotplug monitors would really be helpful. I'm not
> yet super well-versed in qemu internals so this might be done wrong but
> testing works so far.
> 
> My systemd patch that triggered this is at
> https://github.com/systemd/systemd/pull/41449.
> 
> The usage pattern mirrors chardev hotplug:
> 
>   -> chardev-add id=qmp-extra backend=socket,...
>   -> monitor-add id=extra-qmp chardev=qmp-extra
>   [client connects to socket, gets QMP greeting, negotiates, sends commands]
>   -> monitor-remove id=extra-qmp
>   -> chardev-remove id=qmp-extra

With my idea the usage pattern would be basically the same
flow:

  -> chardev-add id=qmp-extra backend=socket,...
  -> object-add qom-type=monitor-qmp id=extra-qmp chardev=qmp-extra
  [client connects to socket, gets QMP greeting, negotiates, sends commands]
  -> object-del id=extra-qmp
  -> chardev-remove id=qmp-extra

> Patches 1-2 add the data model (id field in Monitor) and the
> infrastructure for safe per-monitor destruction without shutting down
> the shared dispatcher coroutine.
> 
> Patch 3 adds the QAPI schema and command handlers.
> 
> Patches 4-5 add qtest unit tests and a functional e2e test that
> performs a full hotplug -> connect -> handshake -> unplug cycle.

Patches 2, 4 and 5 would still be desirable even with the QOM
conversion I'm thinking about.

Patch 1 would be redundant since QOM would give us an ID facility
as standard.

Patch 3 would be redundant since we'd use object_add/object_del
instead.

> 
> > meson test "qtest-x86_64/qmp-test" "func-x86_64-monitor_hotplug" -v
> ninja: Entering directory `/home/brauner/src/git/qemu/build'
> [45/45] Linking target qemu-img
> 1/2 qemu:func-quick+func-x86_64 / func-x86_64-monitor_hotplug        RUNNING
> >>> QEMU_TEST_QEMU_IMG=/home/brauner/src/git/qemu/build/qemu-img ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 MESON_BUILD_ROOT=/home/brauner/src/git/qemu/build LD_LIBRARY_PATH=/home/brauner/src/git/qemu/build/tests/tcg/plugins:/home/brauner/src/git/qemu/build/contrib/plugins:/home/brauner/src/go/deps/raft/.libs/:/home/brauner/src/go/deps/cowsql/.libs/ MALLOC_PERTURB_=165 PYTHONPATH=/home/brauner/src/git/qemu/python:/home/brauner/src/git/qemu/tests/functional QEMU_TEST_GDB=/usr/bin/gdb QEMU_TEST_QEMU_BINARY=/home/brauner/src/git/qemu/build/qemu-system-x86_64 MESON_TEST_ITERATION=1 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 RUST_BACKTRACE=1 /home/brauner/src/git/qemu/build/pyvenv/bin/python3 /home/brauner/src/git/qemu/tests/functional/generic/test_monitor_hotplug.py
> 2/2 qemu:qtest+qtest-x86_64 / qtest-x86_64/qmp-test                  RUNNING
> >>> ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 MALLOC_PERTURB_=244 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 PYTHON=/home/brauner/src/git/qemu/build/pyvenv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon QTEST_QEMU_IMG=./qemu-img G_TEST_DBUS_DAEMON=/home/brauner/src/git/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_BINARY=./qemu-system-x86_64 MESON_TEST_ITERATION=1 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 RUST_BACKTRACE=1 /home/brauner/src/git/qemu/build/tests/qtest/qmp-test --tap -k
> ▶ 1/2 test_monitor_hotplug.MonitorHotplug.test_events_after_negotiation OK
> ▶ 2/2 /x86_64/qmp/protocol                                           OK
> ▶ 1/2 test_monitor_hotplug.MonitorHotplug.test_hotplug_cycle         OK
> ▶ 1/2 test_monitor_hotplug.MonitorHotplug.test_large_response        OK
> ▶ 2/2 /x86_64/qmp/oob                                                OK
> ▶ 1/2 test_monitor_hotplug.MonitorHotplug.test_self_removal          OK
> 1/2 qemu:func-quick+func-x86_64 / func-x86_64-monitor_hotplug        OK              0.30s   4 subtests passed
> 
> ▶ 2/2 /x86_64/qmp/preconfig                                          OK
> ▶ 2/2 /x86_64/qmp/missing-any-arg                                    OK
> ▶ 2/2 /x86_64/qmp/monitor-add-remove                                 OK
> ▶ 2/2 /x86_64/qmp/monitor-error-paths                                OK
> ▶ 2/2 /x86_64/qmp/monitor-chardev-in-use                             OK
> ▶ 2/2 /x86_64/qmp/monitor-remove-cli                                 OK
> ▶ 2/2 /x86_64/qmp/monitor-remove-hmp                                 OK
> 2/2 qemu:qtest+qtest-x86_64 / qtest-x86_64/qmp-test                  OK              1.09s   9 subtests passed
> 
> Ok:                 2
> Expected Fail:      0
> Fail:               0
> Unexpected Pass:    0
> Skipped:            0
> Timeout:            0
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Changes in v4:
> - Move 'dead' field from patch 1 to patch 2 where it is first used.
> - Allow removal of any QMP monitor, drop the 'dynamic' gate in
>   qmp_monitor_remove(). Drop the 'dynamic' field from struct Monitor
>   and from MonitorInfo entirely since it no longer serves a purpose.
> - Auto-generate monitor ids ("mon0", "mon1", ...) for QMP monitors
>   created via CLI without an explicit id, so every QMP monitor is
>   addressable by monitor-remove and always appears with an id in
>   query-monitors output.
> - Change Since: 11.0 to Since: 11.1 throughout the QAPI schema.
> - Drop "GenericError" from QAPI error descriptions.
> - Update monitor-remove QAPI doc to reflect that any QMP monitor can
>   be removed, not just dynamically added ones.
> - Update qtest: test_qmp_monitor_remove_cli now expects success
>   instead of error.
> - Link to v3: https://patch.msgid.link/20260407-work-qmp-monitor-hotplug-v3-0-cb259800fffb@kernel.org
> 
> Changes in v3:
> - Use SPDX license identifier in functional test.
> - Use framework's socket_dir() helper instead of manual tempfile
>   handling for socket paths in the functional test, drop tearDown().
> - Tighten struct field comments in monitor-internal.h.
> - Wrap long qtest_add_func() registration line.
> - Link to v2: https://patch.msgid.link/20260405-work-qmp-monitor-hotplug-v2-0-ad5bedd2917a@kernel.org
> 
> Changes in v2:
> - Fix use-after-free in self-removal path: skip monitor_resume() when
>   the monitor is dead to avoid scheduling a BH against a monitor that
>   is about to be freed by monitor_qmp_destroy().
> - Hold monitor_lock in monitor_find_by_id() to prevent races with
>   the I/O thread BH that appends to mon_list.
> - Deduplicate monitor-remove commit message: trim the gcontext/out_watch
>   explanation that repeated the infrastructure commit, reference
>   monitor_cancel_out_watch() instead.
> - Add missing test descriptions to patch 4 (chardev-in-use, CLI monitor
>   rejection, HMP monitor rejection) and patch 5 (self-removal, large
>   response, events).
> - Fix cover letter wording.
> - Link to v1: https://patch.msgid.link/20260402-work-qmp-monitor-hotplug-v1-0-6313a5cdd574@kernel.org
> 
> ---
> Christian Brauner (5):
>       monitor: store monitor id in Monitor struct
>       monitor/qmp: add infrastructure for safe dynamic monitor removal
>       qapi: add monitor-add, monitor-remove, query-monitors commands
>       tests/qtest: add tests for dynamic monitor add/remove
>       tests/functional: add e2e test for dynamic QMP monitor hotplug
> 
>  include/monitor/monitor.h                        |   3 +-
>  monitor/monitor-internal.h                       |  10 ++
>  monitor/monitor.c                                |  70 ++++++--
>  monitor/qmp-cmds-control.c                       | 105 ++++++++++++
>  monitor/qmp.c                                    |  81 +++++++++-
>  qapi/control.json                                |  97 ++++++++++++
>  tests/functional/generic/meson.build             |   1 +
>  tests/functional/generic/test_monitor_hotplug.py | 170 ++++++++++++++++++++
>  tests/qtest/qmp-test.c                           | 193 +++++++++++++++++++++++
>  9 files changed, 714 insertions(+), 16 deletions(-)
> ---
> base-commit: 6d3e9dddefdd2e8e6a4942ba9399df0e47df21ed
> change-id: 20260402-work-qmp-monitor-hotplug-fba7c618e3db
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


