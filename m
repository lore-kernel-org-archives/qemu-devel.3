Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09670E99049
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB6Pb-0005vQ-R1; Fri, 10 Apr 2026 03:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1wB6Pa-0005vH-IJ
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 03:36:18 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1wB6PY-0008D9-02
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 03:36:18 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9000760125;
 Fri, 10 Apr 2026 07:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B53C19421;
 Fri, 10 Apr 2026 07:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775806567;
 bh=sMideR0bB8PUkl/2I9TpfAIKACkXq5AAs7uYqqkYmPs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=my1gnUEoHE4T0p3baj3gCczn7jbIrQQgu5MSSz5kufs15ea5MDbrB/j1K26LcehF8
 3h+IBjnHuMhEmvnTU1z6o+xXDx/z3DKGG2lLEnbdF2fUy9EvjlkKoqGvfaAj36KVue
 VjJkL6dXVfIwNkAizmPFZcp7DWNK5seW3JQbNeMQPoB5tXqA8c1Gx0x7g9hhRhLNSP
 wStNgtiXM14/Rj/doTNcfc0dhhKJ0ehTNOezC+Y5G3ZQo/6YIFJ1JI1hSZnsKt6/1X
 j9F6qw79PxLo9Rogpa0oCakF6eqqZsAMZDmBX/kT/pWjthOtsEXbDDvFb9NLyiiGXw
 LrKn9yD4F8cVQ==
Date: Fri, 10 Apr 2026 09:36:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 0/5] monitor: add dynamic QMP monitor hotplug support
Message-ID: <20260410-kupfer-rosten-9d08af140e1a@brauner>
References: <20260409-work-qmp-monitor-hotplug-v4-0-89c4fdf69df1@kernel.org>
 <adgBbHDDcEhh9LpQ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adgBbHDDcEhh9LpQ@redhat.com>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=brauner@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 09, 2026 at 08:43:40PM +0100, Daniel P. Berrangé wrote:
> On Thu, Apr 09, 2026 at 09:18:17AM +0200, Christian Brauner wrote:
> > QEMU supports runtime hotplug for chardevs, devices, block backends,
> > and netdevs. Monitors are the only major subsystem that lacks this --
> > all QMP monitors must be configured at launch via -mon or -qmp CLI
> > options.
> > 
> > This series adds monitor-add, monitor-remove, and query-monitors QMP
> > commands so that management tools can create independent QMP sessions
> > on demand at runtime.
> 
> There's nothing inherently wrong with your proposal. It is following
> the standard historical design practice we've taken for enabling
> hotplug/unplug of all the other backend types. Conceptually though
> our historical practice is more of an accident of evolution rather
> than an ideal state.
> 
> By this I mean we have a general purpose object framework
> internally and commands '-object', and 'object_add' / 'object_del'
> for hotplug/unplug in QMP and HMP. Conceptually these could handle
> all of our objects, devices, netdev chardevs, monitors, etc, etc,
> removing the need for the specialized add/remove QMP commands for
> each backend type, and the specialized CLI argsf. 

If you actually plan on converting old types you're now left with two
ways of adding objects. And if you plan on ultimately deprecating the
old format it's going to be very annoying to fade those out.

Or you're not going to convert and then you have blockdev-add and then
the new object pattern.

I'm not sure that I see the value in that. Imho, that's just pain for
new users. Just providing my opinion here.

> The blocker has been lack of time to convert everything/anything,
> since while the conversions are not especially difficult they are
> certainly time consuming due to the sheer number of types that
> exist in many cases.
> 
> 
> I'm thinking the monitor, however, is a decent opportunity to
> "do the right thing" from a design POV. We only have three classes
> needed in QOM, the monitor generic base class, a HMP subclass and
> a QMP subclass.
> 
> If we convert QMP/HMP into QOM objects, we could then use the
> pre-existing object_add/object_del commands in both HMP and QMP.
> 
> I'm not asking you to do that conversion work though. I've
> been doing some experimentation myself today to test the
> viability of this idea and it looks promising.

How difficult is this to do? I've had bad experiences with projects
promising to do it all very differently and taking the patch away from
me and then not following through or like 2 years later or the feature
just vanished into nothing. I'm not saying this is the case here but I'm
a bit weary of not having any way to move this forward myself other than
"any news on this?" mails. It's frustrating for both sides.

So if this is doable just give me what you got and let me see whether I
can take it over the finish line.

Also, I really dislike spending a lot of time understanding something
and it all working and then being told "actually, let me do this". I
avoid this like the plague doing this to developers in the kernel.

> Given we've got an entire 4 month dev cycle before these
> proposed monitor-add/remove commands could get into a QEMU
> release, I think it is worth trialling the QOM conversion
> for a short while.

I'm not sure what your governance model is so I'm just going to ask: Is
this just a review or is this a project level decision?

> > I've implemented a QMP-to-Varlink bridge in systemd. This allows
> > systemd-vmspawn to control virtual machines and containers through a
> > unified Varlink interface. Varlink allows protocol upgrades. For
> > example, it is possible to switch from Varlink to say http. I'm
> > allowing Varlink clients to upgrade from the Varlink interface to the
> > native QMP interface. Such clients get a new monitor assigned that
> > allows them to manage the virtual machine directly via QMP. The main
> > monitor remains unaffected and tied to the generic Varlink interface. We
> > can't pre-allocate monitors as we have no control over how many protocol
> > upgrades we actually get but it won't just be one. And having unused
> > monitors around really isn't ideal either.
> > 
> > Having the ability to hotplug monitors would really be helpful. I'm not
> > yet super well-versed in qemu internals so this might be done wrong but
> > testing works so far.
> > 
> > My systemd patch that triggered this is at
> > https://github.com/systemd/systemd/pull/41449.
> > 
> > The usage pattern mirrors chardev hotplug:
> > 
> >   -> chardev-add id=qmp-extra backend=socket,...
> >   -> monitor-add id=extra-qmp chardev=qmp-extra
> >   [client connects to socket, gets QMP greeting, negotiates, sends commands]
> >   -> monitor-remove id=extra-qmp
> >   -> chardev-remove id=qmp-extra
> 
> With my idea the usage pattern would be basically the same
> flow:
> 
>   -> chardev-add id=qmp-extra backend=socket,...
>   -> object-add qom-type=monitor-qmp id=extra-qmp chardev=qmp-extra
>   [client connects to socket, gets QMP greeting, negotiates, sends commands]
>   -> object-del id=extra-qmp
>   -> chardev-remove id=qmp-extra
> 
> > Patches 1-2 add the data model (id field in Monitor) and the
> > infrastructure for safe per-monitor destruction without shutting down
> > the shared dispatcher coroutine.
> > 
> > Patch 3 adds the QAPI schema and command handlers.
> > 
> > Patches 4-5 add qtest unit tests and a functional e2e test that
> > performs a full hotplug -> connect -> handshake -> unplug cycle.
> 
> Patches 2, 4 and 5 would still be desirable even with the QOM
> conversion I'm thinking about.
> 
> Patch 1 would be redundant since QOM would give us an ID facility
> as standard.
> 
> Patch 3 would be redundant since we'd use object_add/object_del
> instead.
> 
> > 
> > > meson test "qtest-x86_64/qmp-test" "func-x86_64-monitor_hotplug" -v
> > ninja: Entering directory `/home/brauner/src/git/qemu/build'
> > [45/45] Linking target qemu-img
> > 1/2 qemu:func-quick+func-x86_64 / func-x86_64-monitor_hotplug        RUNNING
> > >>> QEMU_TEST_QEMU_IMG=/home/brauner/src/git/qemu/build/qemu-img ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 MESON_BUILD_ROOT=/home/brauner/src/git/qemu/build LD_LIBRARY_PATH=/home/brauner/src/git/qemu/build/tests/tcg/plugins:/home/brauner/src/git/qemu/build/contrib/plugins:/home/brauner/src/go/deps/raft/.libs/:/home/brauner/src/go/deps/cowsql/.libs/ MALLOC_PERTURB_=165 PYTHONPATH=/home/brauner/src/git/qemu/python:/home/brauner/src/git/qemu/tests/functional QEMU_TEST_GDB=/usr/bin/gdb QEMU_TEST_QEMU_BINARY=/home/brauner/src/git/qemu/build/qemu-system-x86_64 MESON_TEST_ITERATION=1 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 RUST_BACKTRACE=1 /home/brauner/src/git/qemu/build/pyvenv/bin/python3 /home/brauner/src/git/qemu/tests/functional/generic/test_monitor_hotplug.py
> > 2/2 qemu:qtest+qtest-x86_64 / qtest-x86_64/qmp-test                  RUNNING
> > >>> ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 MALLOC_PERTURB_=244 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 PYTHON=/home/brauner/src/git/qemu/build/pyvenv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon QTEST_QEMU_IMG=./qemu-img G_TEST_DBUS_DAEMON=/home/brauner/src/git/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_BINARY=./qemu-system-x86_64 MESON_TEST_ITERATION=1 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 RUST_BACKTRACE=1 /home/brauner/src/git/qemu/build/tests/qtest/qmp-test --tap -k
> > ▶ 1/2 test_monitor_hotplug.MonitorHotplug.test_events_after_negotiation OK
> > ▶ 2/2 /x86_64/qmp/protocol                                           OK
> > ▶ 1/2 test_monitor_hotplug.MonitorHotplug.test_hotplug_cycle         OK
> > ▶ 1/2 test_monitor_hotplug.MonitorHotplug.test_large_response        OK
> > ▶ 2/2 /x86_64/qmp/oob                                                OK
> > ▶ 1/2 test_monitor_hotplug.MonitorHotplug.test_self_removal          OK
> > 1/2 qemu:func-quick+func-x86_64 / func-x86_64-monitor_hotplug        OK              0.30s   4 subtests passed
> > 
> > ▶ 2/2 /x86_64/qmp/preconfig                                          OK
> > ▶ 2/2 /x86_64/qmp/missing-any-arg                                    OK
> > ▶ 2/2 /x86_64/qmp/monitor-add-remove                                 OK
> > ▶ 2/2 /x86_64/qmp/monitor-error-paths                                OK
> > ▶ 2/2 /x86_64/qmp/monitor-chardev-in-use                             OK
> > ▶ 2/2 /x86_64/qmp/monitor-remove-cli                                 OK
> > ▶ 2/2 /x86_64/qmp/monitor-remove-hmp                                 OK
> > 2/2 qemu:qtest+qtest-x86_64 / qtest-x86_64/qmp-test                  OK              1.09s   9 subtests passed
> > 
> > Ok:                 2
> > Expected Fail:      0
> > Fail:               0
> > Unexpected Pass:    0
> > Skipped:            0
> > Timeout:            0
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> > Changes in v4:
> > - Move 'dead' field from patch 1 to patch 2 where it is first used.
> > - Allow removal of any QMP monitor, drop the 'dynamic' gate in
> >   qmp_monitor_remove(). Drop the 'dynamic' field from struct Monitor
> >   and from MonitorInfo entirely since it no longer serves a purpose.
> > - Auto-generate monitor ids ("mon0", "mon1", ...) for QMP monitors
> >   created via CLI without an explicit id, so every QMP monitor is
> >   addressable by monitor-remove and always appears with an id in
> >   query-monitors output.
> > - Change Since: 11.0 to Since: 11.1 throughout the QAPI schema.
> > - Drop "GenericError" from QAPI error descriptions.
> > - Update monitor-remove QAPI doc to reflect that any QMP monitor can
> >   be removed, not just dynamically added ones.
> > - Update qtest: test_qmp_monitor_remove_cli now expects success
> >   instead of error.
> > - Link to v3: https://patch.msgid.link/20260407-work-qmp-monitor-hotplug-v3-0-cb259800fffb@kernel.org
> > 
> > Changes in v3:
> > - Use SPDX license identifier in functional test.
> > - Use framework's socket_dir() helper instead of manual tempfile
> >   handling for socket paths in the functional test, drop tearDown().
> > - Tighten struct field comments in monitor-internal.h.
> > - Wrap long qtest_add_func() registration line.
> > - Link to v2: https://patch.msgid.link/20260405-work-qmp-monitor-hotplug-v2-0-ad5bedd2917a@kernel.org
> > 
> > Changes in v2:
> > - Fix use-after-free in self-removal path: skip monitor_resume() when
> >   the monitor is dead to avoid scheduling a BH against a monitor that
> >   is about to be freed by monitor_qmp_destroy().
> > - Hold monitor_lock in monitor_find_by_id() to prevent races with
> >   the I/O thread BH that appends to mon_list.
> > - Deduplicate monitor-remove commit message: trim the gcontext/out_watch
> >   explanation that repeated the infrastructure commit, reference
> >   monitor_cancel_out_watch() instead.
> > - Add missing test descriptions to patch 4 (chardev-in-use, CLI monitor
> >   rejection, HMP monitor rejection) and patch 5 (self-removal, large
> >   response, events).
> > - Fix cover letter wording.
> > - Link to v1: https://patch.msgid.link/20260402-work-qmp-monitor-hotplug-v1-0-6313a5cdd574@kernel.org
> > 
> > ---
> > Christian Brauner (5):
> >       monitor: store monitor id in Monitor struct
> >       monitor/qmp: add infrastructure for safe dynamic monitor removal
> >       qapi: add monitor-add, monitor-remove, query-monitors commands
> >       tests/qtest: add tests for dynamic monitor add/remove
> >       tests/functional: add e2e test for dynamic QMP monitor hotplug
> > 
> >  include/monitor/monitor.h                        |   3 +-
> >  monitor/monitor-internal.h                       |  10 ++
> >  monitor/monitor.c                                |  70 ++++++--
> >  monitor/qmp-cmds-control.c                       | 105 ++++++++++++
> >  monitor/qmp.c                                    |  81 +++++++++-
> >  qapi/control.json                                |  97 ++++++++++++
> >  tests/functional/generic/meson.build             |   1 +
> >  tests/functional/generic/test_monitor_hotplug.py | 170 ++++++++++++++++++++
> >  tests/qtest/qmp-test.c                           | 193 +++++++++++++++++++++++
> >  9 files changed, 714 insertions(+), 16 deletions(-)
> > ---
> > base-commit: 6d3e9dddefdd2e8e6a4942ba9399df0e47df21ed
> > change-id: 20260402-work-qmp-monitor-hotplug-fba7c618e3db
> > 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
> 
> 

