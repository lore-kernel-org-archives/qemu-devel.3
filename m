Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35438C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 20:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdbQy-0006Gb-Nw; Thu, 30 Jan 2025 15:46:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdbQx-0006GR-0S
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 15:46:43 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdbQu-0008QM-JJ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 15:46:42 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 17CA42116F;
 Thu, 30 Jan 2025 20:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738269999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QHKlreXanfhypdecFTOnpqeH+RsHCXVsmDwkdoxtb/k=;
 b=JhhRdipFo6VJd6UirMJ7hnrrYd1JouImJAiS7ehw88SSvWxtH207BqVyAZxv0QzzsSkI5/
 AU8hT5bt1zn9X0msuwOOt27KBihNKm3rN6l+1xWYWqiiYi2aG871vGi8eO25LYTT6IAlrl
 857yt5hg2zpfHml2lRnuEfyfTBhsZnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738269999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QHKlreXanfhypdecFTOnpqeH+RsHCXVsmDwkdoxtb/k=;
 b=OJRR149xHhZoJHRjlBBfuBq3HnQu7IaH2OZwNmPweILRsSs7JAR0G646sd3SKFs2nRxy4R
 VkAZy5gYYxZr8tCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738269999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QHKlreXanfhypdecFTOnpqeH+RsHCXVsmDwkdoxtb/k=;
 b=JhhRdipFo6VJd6UirMJ7hnrrYd1JouImJAiS7ehw88SSvWxtH207BqVyAZxv0QzzsSkI5/
 AU8hT5bt1zn9X0msuwOOt27KBihNKm3rN6l+1xWYWqiiYi2aG871vGi8eO25LYTT6IAlrl
 857yt5hg2zpfHml2lRnuEfyfTBhsZnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738269999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QHKlreXanfhypdecFTOnpqeH+RsHCXVsmDwkdoxtb/k=;
 b=OJRR149xHhZoJHRjlBBfuBq3HnQu7IaH2OZwNmPweILRsSs7JAR0G646sd3SKFs2nRxy4R
 VkAZy5gYYxZr8tCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 755A11364B;
 Thu, 30 Jan 2025 20:46:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xiICDS7lm2emWwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 30 Jan 2025 20:46:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Dan?=
 =?utf-8?Q?iel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>, Joao
 Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 00/33] Multifd =?utf-8?Q?=F0=9F=94=80?= device state
 transfer support with VFIO consumer
In-Reply-To: <adc80094-f7ea-4a30-8d59-f4a9864392f6@maciej.szmigiero.name>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <87tt9gkqb6.fsf@suse.de>
 <adc80094-f7ea-4a30-8d59-f4a9864392f6@maciej.szmigiero.name>
Date: Thu, 30 Jan 2025 17:46:35 -0300
Message-ID: <87r04kkp1w.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,oracle.com:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> On 30.01.2025 21:19, Fabiano Rosas wrote:
>> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
>>=20
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> This is an updated v4 patch series of the v3 series located here:
>>> https://lore.kernel.org/qemu-devel/cover.1731773021.git.maciej.szmigier=
o@oracle.com/
>>>
>>> Changes from v3:
>>> * MigrationLoadThread now returns bool and an Error complex error type
>>> instead of just an int.
>>>
>>> * qemu_loadvm_load_thread_pool now reports error via migrate_set_error()
>>> instead of dedicated load_threads_ret variable.
>>>
>>> * Since the change above uncovered an issue with respect to multifd send
>>> channels not terminating TLS session properly QIOChannelTLS now allows
>>> gracefully handling this situation.
>>>
>>> * qemu_loadvm_load_thread_pool state is now part of MigrationIncomingSt=
ate
>>> instead of being stored in global variables.
>>> This state now also has its own init/cleanup helpers.
>>>
>>> * qemu_loadvm_load_thread_pool code is now moved into a separate section
>>> of the savevm.c file, marked by an appropriate comment.
>>>
>>> * thread_pool_free() is now documented to have wait-before-free semanti=
c,
>>> which allowed removal of explicit waits from thread pool cleanup paths.
>>>
>>> * thread_pool_submit_immediate() method was added since this functional=
ity
>>> is used by both generic thread pool users in this patch set.
>>>
>>> * postcopy_ram_listen_thread() now takes BQL around function calls that
>>> ultimately call migration methods requiring BQL.
>>> This fixes one of QEMU tests failing when explicitly BQL-sensitive code
>>> is added later to these methods.
>>>
>>> * qemu_loadvm_load_state_buffer() now returns a bool value instead of i=
nt.
>>>
>>> * "Send final SYNC only after device state is complete" patch was
>>> dropped since Peter implemented equivalent functionality upstream.
>>>
>>> * "Document the BQL behavior of load SaveVMHandlers" patch was dropped
>>> since that's something better done later, separately from this patch se=
t.
>>>
>>> * Header size is now added to mig_stats.multifd_bytes where it is actua=
lly
>>> sent in the zero copy case - in multifd_nocomp_send_prepare().
>>>
>>> * Spurious wakeups from qemu_cond_wait() are now handled properly as
>>> pointed out by Avihai.
>>>
>>> * VFIO migration FD now allows partial write() completion as pointed out
>>> by Avihai.
>>>
>>> * Patch "vfio/migration: Don't run load cleanup if load setup didn't ru=
n"
>>> was dropped, instead all objects related to multifd load are now locate=
d in
>>> their own VFIOMultifd struct which is allocated only if multifd device =
state
>>> transfer is actually in use.
>>>
>>> * Intermediate VFIOStateBuffers API as suggested by Avihai is now intro=
duced
>>> to simplify vfio_load_state_buffer() and vfio_load_bufs_thread().
>>>
>>> * Optional VFIO device config state loading interlocking with loading
>>> other iterables is now possible due to ARM64 platform VFIO dependency on
>>> interrupt controller being loaded first as pointed out by Avihai.
>>>
>>> * Patch "Multifd device state transfer support - receive side" was split
>>> into a few smaller patches as suggested by C=C3=A9dric.
>>>
>>> * x-migration-multifd-transfer VFIO property compat changes were moved
>>> into a separate patch as suggested by C=C3=A9dric.
>>>
>>> * Other small changes, like renamed functions and variables/members, ad=
ded
>>> review tags, code formatting, moved QEMU_LOCK_GUARD() instances closer =
to
>>> actual protected blocks, etc.
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> This patch set is targeting QEMU 10.0.
>>>
>>> What's not yet present is documentation update under docs/devel/migrati=
on
>>> but I didn't want to delay posting the code any longer.
>>> Such doc can still be merged later when the design is 100% finalized.
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> Maciej S. Szmigiero (32):
>>>    migration: Clarify that {load,save}_cleanup handlers can run without
>>>      setup
>>>    thread-pool: Remove thread_pool_submit() function
>>>    thread-pool: Rename AIO pool functions to *_aio() and data types to
>>>      *Aio
>>>    thread-pool: Implement generic (non-AIO) pool support
>>>    migration: Add MIG_CMD_SWITCHOVER_START and its load handler
>>>    migration: Add qemu_loadvm_load_state_buffer() and its handler
>>>    io: tls: Allow terminating the TLS session gracefully with EOF
>>>    migration/multifd: Allow premature EOF on TLS incoming channels
>>>    migration: postcopy_ram_listen_thread() needs to take BQL for some
>>>      calls
>>>    error: define g_autoptr() cleanup function for the Error type
>>>    migration: Add thread pool of optional load threads
>>>    migration/multifd: Split packet into header and RAM data
>>>    migration/multifd: Device state transfer support - receive side
>>>    migration/multifd: Make multifd_send() thread safe
>>>    migration/multifd: Add an explicit MultiFDSendData destructor
>>>    migration/multifd: Device state transfer support - send side
>>>    migration/multifd: Add multifd_device_state_supported()
>>>    migration: Add save_live_complete_precopy_thread handler
>>>    vfio/migration: Add x-migration-load-config-after-iter VFIO property
>>>    vfio/migration: Add load_device_config_state_start trace event
>>>    vfio/migration: Convert bytes_transferred counter to atomic
>>>    vfio/migration: Multifd device state transfer support - basic types
>>>    vfio/migration: Multifd device state transfer support -
>>>      VFIOStateBuffer(s)
>>>    vfio/migration: Multifd device state transfer - add support checking
>>>      function
>>>    vfio/migration: Multifd device state transfer support - receive
>>>      init/cleanup
>>>    vfio/migration: Multifd device state transfer support - received
>>>      buffers queuing
>>>    vfio/migration: Multifd device state transfer support - load thread
>>>    vfio/migration: Multifd device state transfer support - config loadi=
ng
>>>      support
>>>    migration/qemu-file: Define g_autoptr() cleanup function for QEMUFile
>>>    vfio/migration: Multifd device state transfer support - send side
>>>    vfio/migration: Add x-migration-multifd-transfer VFIO property
>>>    hw/core/machine: Add compat for x-migration-multifd-transfer VFIO
>>>      property
>>>
>>> Peter Xu (1):
>>>    migration/multifd: Make MultiFDSendData a struct
>>>
>>>   hw/core/machine.c                  |   2 +
>>>   hw/vfio/migration.c                | 754 ++++++++++++++++++++++++++++-
>>>   hw/vfio/pci.c                      |  14 +
>>>   hw/vfio/trace-events               |  11 +-
>>>   include/block/aio.h                |   8 +-
>>>   include/block/thread-pool.h        |  62 ++-
>>>   include/hw/vfio/vfio-common.h      |   7 +
>>>   include/io/channel-tls.h           |  11 +
>>>   include/migration/client-options.h |   4 +
>>>   include/migration/misc.h           |  16 +
>>>   include/migration/register.h       |  54 ++-
>>>   include/qapi/error.h               |   2 +
>>>   include/qemu/typedefs.h            |   6 +
>>>   io/channel-tls.c                   |   6 +
>>>   migration/colo.c                   |   3 +
>>>   migration/meson.build              |   1 +
>>>   migration/migration-hmp-cmds.c     |   2 +
>>>   migration/migration.c              |   6 +-
>>>   migration/migration.h              |   7 +
>>>   migration/multifd-device-state.c   | 192 ++++++++
>>>   migration/multifd-nocomp.c         |  30 +-
>>>   migration/multifd.c                | 248 ++++++++--
>>>   migration/multifd.h                |  74 ++-
>>>   migration/options.c                |   9 +
>>>   migration/qemu-file.h              |   2 +
>>>   migration/savevm.c                 | 195 +++++++-
>>>   migration/savevm.h                 |   6 +-
>>>   migration/trace-events             |   1 +
>>>   scripts/analyze-migration.py       |  11 +
>>>   tests/unit/test-thread-pool.c      |   6 +-
>>>   util/async.c                       |   6 +-
>>>   util/thread-pool.c                 | 184 +++++--
>>>   util/trace-events                  |   6 +-
>>>   33 files changed, 1814 insertions(+), 132 deletions(-)
>>>   create mode 100644 migration/multifd-device-state.c
>>=20
>> Hi!
>>=20
>> We have build issues:
>>=20
>> https://gitlab.com/farosas/qemu/-/pipelines/1649146958
>>=20
>
> Looks like that's an issue that qatomics on 64-bit
> VFIO bytes transferred counters aren't available on
> 32-bit host platforms.
>
> The easiest way would be probably to change these to
> 32-bit counters on 32-bit platforms since they can't
> realistically address more memory anyway.
>
>> And the postcopy/recovery test is failing. It seems the migration
>> finishes before the test can issue migrate-pause:
>>=20
>> QTEST_QEMU_BINARY=3D./qemu-system-x86_64  ./tests/qtest/migration-test -p
>> /x86_64/migration/postcopy/recovery/plain
>> ...
>> {"execute": "migrate-start-postcopy"}
>> {"return": {}}
>> {"secs": 1738267018, "usecs": 860991}, "event": "MIGRATION", "data": {"s=
tatus": "postcopy-active"}
>> {"secs": 1738267018, "usecs": 861284}, "event": "STOP"
>> {"secs": 1738267017, "usecs": 960322}, "event": "MIGRATION", "data": {"s=
tatus": "active"}
>> {"secs": 1738267018, "usecs": 865589}, "event": "MIGRATION", "data": {"s=
tatus": "postcopy-active"}
>> {"secs": 1738267099, "usecs": 120971}, "event": "MIGRATION", "data": {"s=
tatus": "completed"}
>> {"secs": 1738267099, "usecs": 121154}, "event": "RESUME"
>> {"execute": "query-migrate"}
>>=20
>> ERROR:../tests/qtest/migration/migration-qmp.c:172:check_migration_statu=
s:
>> assertion failed (current_status !=3D "completed"): ("completed" !=3D
>> "completed")
>>=20
>
> Hmm, it looks like this failure wasn't showing
> in my tests because the test was skipped due to
> missing userfaultfd support:
>
> $ QTEST_QEMU_BINARY=3D./qemu-system-x86_64 ./tests/qtest/migration-test -=
p /x86_64/migration/postcopy/recovery/plain
> TAP version 14
> # random seed: R02Sc99a7d93274064bb87f3e0789fbf8326
> # Skipping test: userfaultfd not available
> # Start of x86_64 tests
> # Start of migration tests
> # End of migration tests
> # End of x86_64 tests
> 1..0
>
> Will try to make this test run and investigate the reason for
> failure.

This will probably help:

sysctl -w vm.unprivileged_userfaultfd=3D1

I also had broken userfaultfd detection in the tests a while back. But
it's fixed now.

>
> Thanks,
> Maciej

