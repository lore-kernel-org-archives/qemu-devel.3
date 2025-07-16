Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1218C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 19:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc8HR-0002zZ-ID; Wed, 16 Jul 2025 15:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uc8HO-0002xQ-Jw
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 15:59:02 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uc8HM-0007pt-Gl
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 15:59:02 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 272E121212;
 Wed, 16 Jul 2025 19:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752695936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cSq5eAdw2CYugbvWLY+MWGgtbHDHpYzY5yAnMyoffzQ=;
 b=aOyTJO8GeNEgDBwhpOJXQZRqDv9B70tP0pI/YzEDnWcs4Dg2efusWu1YZCdwQzbLNBzvVw
 LOBi76wBul/rBM6l6y2Zi8yiI073l1BtxLzfXsYvCcmTScIesSvLReijHs0ffeFksBXc6c
 wYMUVdNvwK2OqoghYeHSK1dtceAaOXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752695936;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cSq5eAdw2CYugbvWLY+MWGgtbHDHpYzY5yAnMyoffzQ=;
 b=KAQfezooCgpwGoCXtMf0AB2gmd/z2A/flDOqPXp14peEVGfuvc/+odhqekI02KrNm3RjP/
 HJgmk4VWixePiBAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752695936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cSq5eAdw2CYugbvWLY+MWGgtbHDHpYzY5yAnMyoffzQ=;
 b=aOyTJO8GeNEgDBwhpOJXQZRqDv9B70tP0pI/YzEDnWcs4Dg2efusWu1YZCdwQzbLNBzvVw
 LOBi76wBul/rBM6l6y2Zi8yiI073l1BtxLzfXsYvCcmTScIesSvLReijHs0ffeFksBXc6c
 wYMUVdNvwK2OqoghYeHSK1dtceAaOXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752695936;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cSq5eAdw2CYugbvWLY+MWGgtbHDHpYzY5yAnMyoffzQ=;
 b=KAQfezooCgpwGoCXtMf0AB2gmd/z2A/flDOqPXp14peEVGfuvc/+odhqekI02KrNm3RjP/
 HJgmk4VWixePiBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A8DE138D2;
 Wed, 16 Jul 2025 19:58:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qkLgEX8EeGjMcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 16 Jul 2025 19:58:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Halil
 Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Richard
 Henderson <richard.henderson@linaro.org>, David Hildenbrand
 <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth
 <thuth@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, Nicholas
 Piggin <npiggin@gmail.com>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Alex
 Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Peter Xu <peterx@redhat.com>, Hailiang Zhang
 <zhanghailiang@xfusion.com>, Steve Sistare <steven.sistare@oracle.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Stefan Berger
 <stefanb@linux.vnet.ibm.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Arun Menon <armenon@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 00/23] migration: propagate vTPM errors using Error
 objects
In-Reply-To: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
References: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
Date: Wed, 16 Jul 2025 16:58:52 -0300
Message-ID: <87zfd3lxfn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWELVE(0.00)[32];
 TAGGED_RCPT(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL96jwb13nk98k7j3ws9zhxhn8)];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,linux.ibm.com,linaro.org,euphon.net,xfusion.com,oracle.com,nongnu.org,linux.vnet.ibm.com,rsg.ci.i.u-tokyo.ac.jp,collabora.com];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
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

Arun Menon <armenon@redhat.com> writes:

> Hello,
>
> Currently, when a migration of a VM with an encrypted vTPM
> fails on the destination host (e.g., due to a mismatch in secret values),
> the error message displayed on the source host is generic and unhelpful.
>
> For example, a typical error looks like this:
> "operation failed: job 'migration out' failed: Sibling indicated error 1.
> operation failed: job 'migration in' failed: load of migration failed:
> Input/output error"
>
> This message does not provide any specific indication of a vTPM failure.
> Such generic errors are logged using error_report(), which prints to
> the console/monitor but does not make the detailed error accessible via
> the QMP query-migrate command.
>
> This series addresses the issue, by ensuring that specific TPM error
> messages are propagated via the QEMU Error object.
> To make this possible,
> - A set of functions in the call stack is changed
>   to incorporate an Error object as an additional parameter.
> - Also, the TPM backend makes use of a new hook called post_load_errp()
>   that explicitly passes an Error object.
>
> It is organized as follows,
>  - Patches 1-21 focuses on pushing Error object into the functions
>    that are important in the call stack where TPM errors are observed.
>    We still need to make changes in rest of the functions in savevm.c
>    such that they also incorporate the errp object for propagating errors.
>  - Patch 22 introduces the new variants of the hooks in VMStateDescription
>    structure. These hooks should be used in future implementations.
>  - Patch 23 focuses on changing the TPM backend such that the errors are
>    set in the Error object.
>
> While this series focuses specifically on TPM error reporting during
> live migration, it lays the groundwork for broader improvements.
> A lot of methods in savevm.c that previously returned an integer now capture
> errors in the Error object, enabling other modules to adopt the
> post_load_errp hook in the future.
>
> One such change previously attempted:
> https://lists.gnu.org/archive/html/qemu-devel/2021-02/msg01727.html
>
> Resolves: https://issues.redhat.com/browse/RHEL-82826
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
> Changes in v4:
> - Split the patches into smaller ones based on functions. Pass NULL in the
>   caller until errp is made available. Every function that has an
>   Error **errp object passed to it, ensures that it sets the errp object
>   in case of failure.
> - A few more functions within loadvm_process_command() now handle errors using
>   the errp object. I've converted these for consistency, taking Daniel's
>   patches (link above) as a reference.
> - Along with the post_load_errp() hook, other duplicate hooks are also introduced.
>   This will enable us to migrate to the newer versions eventually.
> - Fix some semantic errors, like using error_propagate_prepend() in places where
>   we need to preserve existing behaviour of accumulating the error in local_err
>   and then propagating it to errp. This can be refactored in a later commit.
> - Add more information in commit messages explaining the changes.
> - Link to v3: https://lore.kernel.org/qemu-devel/20250702-propagate_tpm_error-v3-0-986d94540528@redhat.com
>
> Changes in v3:
> - Split the 2nd patch into 2. Introducing post_load_with_error() hook
>   has been separated from using it in the backends TPM module. This is
>   so that it can be acknowledged.
> - Link to v2: https://lore.kernel.org/qemu-devel/20250627-propagate_tpm_error-v2-0-85990c89da29@redhat.com
>
> Changes in v2:
> - Combine the first two changes into one, focusing on passing the
>   Error object (errp) consistently through functions involved in
>   loading the VM's state. Other functions are not yet changed.
> - As suggested in the review comment, add null checks for errp
>   before adding error messages, preventing crashes.
>   We also now correctly set errors when post-copy migration fails.
> - In process_incoming_migration_co(), switch to error_prepend
>   instead of error_setg. This means we now null-check local_err in
>   the "fail" section before using it, preventing dereferencing issues.
> - Link to v1: https://lore.kernel.org/qemu-devel/20250624-propagate_tpm_error-v1-0-2171487a593d@redhat.com
>
> ---
> Arun Menon (23):
>       migration: push Error **errp into vmstate_subsection_load()
>       migration: push Error **errp into vmstate_load_state()
>       migration: push Error **errp into qemu_loadvm_state_header()
>       migration: push Error **errp into vmstate_load()
>       migration: push Error **errp into qemu_loadvm_section_start_full()
>       migration: push Error **errp into qemu_loadvm_section_part_end()
>       migration: push Error **errp into loadvm_process_command()
>       migration: push Error **errp into loadvm_handle_cmd_packaged()
>       migration: push Error **errp into ram_postcopy_incoming_init()
>       migration: push Error **errp into loadvm_postcopy_handle_advise()
>       migration: push Error **errp into loadvm_postcopy_handle_listen()
>       migration: push Error **errp into loadvm_postcopy_handle_run()
>       migration: push Error **errp into loadvm_postcopy_ram_handle_discard()
>       migration: make loadvm_postcopy_handle_resume() void
>       migration: push Error **errp into loadvm_handle_recv_bitmap()
>       migration: push Error **errp into loadvm_process_enable_colo()
>       migration: push Error **errp into loadvm_postcopy_handle_switchover_start()
>       migration: push Error **errp into qemu_loadvm_state_main()
>       migration: push Error **errp into qemu_loadvm_state()
>       migration: push Error **errp into qemu_load_device_state()
>       migration: Capture error in postcopy_ram_listen_thread()
>       migration: Add error-parameterized function variants in VMSD struct
>       backends/tpm: Propagate vTPM error on migration failure
>
>  backends/tpm/tpm_emulator.c |  39 +++---
>  hw/display/virtio-gpu.c     |   2 +-
>  hw/pci/pci.c                |   2 +-
>  hw/s390x/virtio-ccw.c       |   2 +-
>  hw/scsi/spapr_vscsi.c       |   2 +-
>  hw/vfio/pci.c               |   2 +-
>  hw/virtio/virtio-mmio.c     |   2 +-
>  hw/virtio/virtio-pci.c      |   2 +-
>  hw/virtio/virtio.c          |   4 +-
>  include/migration/colo.h    |   2 +-
>  include/migration/vmstate.h |  13 +-
>  migration/colo.c            |  10 +-
>  migration/cpr.c             |   4 +-
>  migration/migration.c       |  19 +--
>  migration/postcopy-ram.c    |   9 +-
>  migration/postcopy-ram.h    |   2 +-
>  migration/ram.c             |  14 +--
>  migration/ram.h             |   4 +-
>  migration/savevm.c          | 299 +++++++++++++++++++++++++-------------------
>  migration/savevm.h          |   7 +-
>  migration/vmstate-types.c   |  10 +-
>  migration/vmstate.c         |  83 ++++++++----
>  tests/unit/test-vmstate.c   |  18 +--
>  ui/vdagent.c                |   2 +-
>  24 files changed, 325 insertions(+), 228 deletions(-)
> ---
> base-commit: 9a4e273ddec3927920c5958d2226c6b38b543336
> change-id: 20250624-propagate_tpm_error-bf4ae6c23d30
>
> Best regards,

Hi Arun, make check is failing, please take a look:

QTEST_LOG=1 QTEST_QEMU_BINARY=./qemu-system-x86_64 \
./tests/qtest/migration-test \
--full -p /x86_64/migration/postcopy/recovery/double-failures/handshake
...
qemu-system-x86_64: ../util/error.c:65: error_setv: Assertion `*errp ==
NULL' failed.

