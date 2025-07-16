Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EFAC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 22:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucAmc-0000rR-36; Wed, 16 Jul 2025 18:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucAmU-0000hj-Uy
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 18:39:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucAmM-0000uW-Lc
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 18:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752705548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SUNykp01qfoFzHo6JMb5Mp48RIno/hh6amLy8D715Yw=;
 b=gwuh2W/DTYA/7XIoX8fqwvycJkypGWdfLDTIMdVkaEIbTI+WIOl91QI/K9z/+yG8Cw/Cbl
 ngO5ts8LGuzXKXmCxNVBa3EVsT2k5ZOk68USB77GHKdO3xuxpFWdoVmZhN58g2vYTlSvhG
 UEL74y03Y9IuNfd82Z86UMvxGWTpjZ4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-3uDapxcANeW2hd-kRBP8Ug-1; Wed, 16 Jul 2025 18:39:06 -0400
X-MC-Unique: 3uDapxcANeW2hd-kRBP8Ug-1
X-Mimecast-MFC-AGG-ID: 3uDapxcANeW2hd-kRBP8Ug_1752705545
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-23638e1605dso2200265ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 15:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752705545; x=1753310345;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUNykp01qfoFzHo6JMb5Mp48RIno/hh6amLy8D715Yw=;
 b=qRqaFhYDmca/PbK9kl+Lyk4gEvUbZ5PsorjyzH+8baZ+agBTA1knIakz4zJLJGnwjR
 jeJ3djHUS5Hb87D1nBIxgh8fcpkFOIApkZsUT61/Cy4GHIRFzUeGaDn2iN8+ie475qsa
 OJhB9Jc5XRxIjMrVz20EjlTErSLuJbAsYrECwSiDnUOiwjwW1j3v9ltmgvUJKAnc+Nce
 4/sAQE81HUJ9mLEqi2Txw+Y2loSDA9rKa0jANoTyW79oLzexbnmsuShicdtqzS5CAd8Y
 CMi/8pth3B0rt42VfWUCQPT9/WioYnpkTuwBR1zYTIdJJX7VZTCAMschTCIIonov76CC
 kBtQ==
X-Gm-Message-State: AOJu0YwY/Lm032OGbrBgInkoL5sUVFXY/Mwob8MbadYpRKmy+JUsuK6c
 Y9lz6kJCg8zxL8N/n3VjwDRq3gvY4nLGUwxyFQ3eMnyKv4bDy9sQ0T34Z5JgE9lXGN2pxhuKduL
 QC1P90bdKr9lwLMbyz5j646P+PL7XrPGqdIcaq7jHd/HQYqHvZOIdxYWw
X-Gm-Gg: ASbGnct7WomVUmgyzHGEaEJYdPS6Kon7qPjJ6uNlK8FsgMmlOcRjfKhNbowOVDBpC4+
 76M2SBTslnXX1DwMcmzN3WePXvyrZFGMlA8Yec+tLGWDPuei8r6KGTZ6GnEQH84Kzip38YL7nBT
 0N5KSnr433D9jinGS0rukR2lTUbv5Otdb4eC0zUriwqGfPwEehPsYBu9Li258Ai9KdlM2nc3+WO
 IbyHkmOKf0xg2mF2IRxd5YBkAYz2NRa+y0ppeK8RSSqvOH0WiRZoAdmWSD4b9WjoUfzZH2hy2L9
 8ZzE7j2pkjzPjOx61kiwiIYj+yRORO+6h7T3PPDNx+PyXFBcOJjz
X-Received: by 2002:a17:902:ea04:b0:234:c8ec:51b5 with SMTP id
 d9443c01a7336-23e2578f517mr68322355ad.53.1752705545323; 
 Wed, 16 Jul 2025 15:39:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG73YbEQvrpKqiyX1USCTf6ePG1qGLkUgJ4r0obq064ZtWrVjd7i5a4WL57juTHURj2eCxc9Q==
X-Received: by 2002:a17:902:ea04:b0:234:c8ec:51b5 with SMTP id
 d9443c01a7336-23e2578f517mr68321855ad.53.1752705544831; 
 Wed, 16 Jul 2025 15:39:04 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435f262sm129897635ad.236.2025.07.16.15.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 15:39:04 -0700 (PDT)
Date: Thu, 17 Jul 2025 04:08:53 +0530
From: Arun Menon <armenon@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v4 00/23] migration: propagate vTPM errors using Error
 objects
Message-ID: <aHgp_eBPq6v1FRLi@armenon-kvm.bengluru.csb>
References: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
 <87zfd3lxfn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfd3lxfn.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


Hi Fabiano, 

Thanks for the quick review and for catching the make check failure. 
My apologies for that oversight, it's definitely an embarrassing miss on my part.
I see what happened there. I ran make check without sudo, therefore the postcopy tests
were missed ; because it requires userfaultfd(). Only 62 out of the total 79 migration
tests were run.

In any case, I have identified the cause and rectified it in my next version.
I will be sending out a new version of the patch shortly, making sure I run all the tests
alongside manual testing.

On Wed, Jul 16, 2025 at 04:58:52PM -0300, Fabiano Rosas wrote:
> Arun Menon <armenon@redhat.com> writes:
> 
> > Hello,
> >
> > Currently, when a migration of a VM with an encrypted vTPM
> > fails on the destination host (e.g., due to a mismatch in secret values),
> > the error message displayed on the source host is generic and unhelpful.
> >
> > For example, a typical error looks like this:
> > "operation failed: job 'migration out' failed: Sibling indicated error 1.
> > operation failed: job 'migration in' failed: load of migration failed:
> > Input/output error"
> >
> > This message does not provide any specific indication of a vTPM failure.
> > Such generic errors are logged using error_report(), which prints to
> > the console/monitor but does not make the detailed error accessible via
> > the QMP query-migrate command.
> >
> > This series addresses the issue, by ensuring that specific TPM error
> > messages are propagated via the QEMU Error object.
> > To make this possible,
> > - A set of functions in the call stack is changed
> >   to incorporate an Error object as an additional parameter.
> > - Also, the TPM backend makes use of a new hook called post_load_errp()
> >   that explicitly passes an Error object.
> >
> > It is organized as follows,
> >  - Patches 1-21 focuses on pushing Error object into the functions
> >    that are important in the call stack where TPM errors are observed.
> >    We still need to make changes in rest of the functions in savevm.c
> >    such that they also incorporate the errp object for propagating errors.
> >  - Patch 22 introduces the new variants of the hooks in VMStateDescription
> >    structure. These hooks should be used in future implementations.
> >  - Patch 23 focuses on changing the TPM backend such that the errors are
> >    set in the Error object.
> >
> > While this series focuses specifically on TPM error reporting during
> > live migration, it lays the groundwork for broader improvements.
> > A lot of methods in savevm.c that previously returned an integer now capture
> > errors in the Error object, enabling other modules to adopt the
> > post_load_errp hook in the future.
> >
> > One such change previously attempted:
> > https://lists.gnu.org/archive/html/qemu-devel/2021-02/msg01727.html
> >
> > Resolves: https://issues.redhat.com/browse/RHEL-82826
> >
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> > Changes in v4:
> > - Split the patches into smaller ones based on functions. Pass NULL in the
> >   caller until errp is made available. Every function that has an
> >   Error **errp object passed to it, ensures that it sets the errp object
> >   in case of failure.
> > - A few more functions within loadvm_process_command() now handle errors using
> >   the errp object. I've converted these for consistency, taking Daniel's
> >   patches (link above) as a reference.
> > - Along with the post_load_errp() hook, other duplicate hooks are also introduced.
> >   This will enable us to migrate to the newer versions eventually.
> > - Fix some semantic errors, like using error_propagate_prepend() in places where
> >   we need to preserve existing behaviour of accumulating the error in local_err
> >   and then propagating it to errp. This can be refactored in a later commit.
> > - Add more information in commit messages explaining the changes.
> > - Link to v3: https://lore.kernel.org/qemu-devel/20250702-propagate_tpm_error-v3-0-986d94540528@redhat.com
> >
> > Changes in v3:
> > - Split the 2nd patch into 2. Introducing post_load_with_error() hook
> >   has been separated from using it in the backends TPM module. This is
> >   so that it can be acknowledged.
> > - Link to v2: https://lore.kernel.org/qemu-devel/20250627-propagate_tpm_error-v2-0-85990c89da29@redhat.com
> >
> > Changes in v2:
> > - Combine the first two changes into one, focusing on passing the
> >   Error object (errp) consistently through functions involved in
> >   loading the VM's state. Other functions are not yet changed.
> > - As suggested in the review comment, add null checks for errp
> >   before adding error messages, preventing crashes.
> >   We also now correctly set errors when post-copy migration fails.
> > - In process_incoming_migration_co(), switch to error_prepend
> >   instead of error_setg. This means we now null-check local_err in
> >   the "fail" section before using it, preventing dereferencing issues.
> > - Link to v1: https://lore.kernel.org/qemu-devel/20250624-propagate_tpm_error-v1-0-2171487a593d@redhat.com
> >
> > ---
> > Arun Menon (23):
> >       migration: push Error **errp into vmstate_subsection_load()
> >       migration: push Error **errp into vmstate_load_state()
> >       migration: push Error **errp into qemu_loadvm_state_header()
> >       migration: push Error **errp into vmstate_load()
> >       migration: push Error **errp into qemu_loadvm_section_start_full()
> >       migration: push Error **errp into qemu_loadvm_section_part_end()
> >       migration: push Error **errp into loadvm_process_command()
> >       migration: push Error **errp into loadvm_handle_cmd_packaged()
> >       migration: push Error **errp into ram_postcopy_incoming_init()
> >       migration: push Error **errp into loadvm_postcopy_handle_advise()
> >       migration: push Error **errp into loadvm_postcopy_handle_listen()
> >       migration: push Error **errp into loadvm_postcopy_handle_run()
> >       migration: push Error **errp into loadvm_postcopy_ram_handle_discard()
> >       migration: make loadvm_postcopy_handle_resume() void
> >       migration: push Error **errp into loadvm_handle_recv_bitmap()
> >       migration: push Error **errp into loadvm_process_enable_colo()
> >       migration: push Error **errp into loadvm_postcopy_handle_switchover_start()
> >       migration: push Error **errp into qemu_loadvm_state_main()
> >       migration: push Error **errp into qemu_loadvm_state()
> >       migration: push Error **errp into qemu_load_device_state()
> >       migration: Capture error in postcopy_ram_listen_thread()
> >       migration: Add error-parameterized function variants in VMSD struct
> >       backends/tpm: Propagate vTPM error on migration failure
> >
> >  backends/tpm/tpm_emulator.c |  39 +++---
> >  hw/display/virtio-gpu.c     |   2 +-
> >  hw/pci/pci.c                |   2 +-
> >  hw/s390x/virtio-ccw.c       |   2 +-
> >  hw/scsi/spapr_vscsi.c       |   2 +-
> >  hw/vfio/pci.c               |   2 +-
> >  hw/virtio/virtio-mmio.c     |   2 +-
> >  hw/virtio/virtio-pci.c      |   2 +-
> >  hw/virtio/virtio.c          |   4 +-
> >  include/migration/colo.h    |   2 +-
> >  include/migration/vmstate.h |  13 +-
> >  migration/colo.c            |  10 +-
> >  migration/cpr.c             |   4 +-
> >  migration/migration.c       |  19 +--
> >  migration/postcopy-ram.c    |   9 +-
> >  migration/postcopy-ram.h    |   2 +-
> >  migration/ram.c             |  14 +--
> >  migration/ram.h             |   4 +-
> >  migration/savevm.c          | 299 +++++++++++++++++++++++++-------------------
> >  migration/savevm.h          |   7 +-
> >  migration/vmstate-types.c   |  10 +-
> >  migration/vmstate.c         |  83 ++++++++----
> >  tests/unit/test-vmstate.c   |  18 +--
> >  ui/vdagent.c                |   2 +-
> >  24 files changed, 325 insertions(+), 228 deletions(-)
> > ---
> > base-commit: 9a4e273ddec3927920c5958d2226c6b38b543336
> > change-id: 20250624-propagate_tpm_error-bf4ae6c23d30
> >
> > Best regards,
> 
> Hi Arun, make check is failing, please take a look:
> 
> QTEST_LOG=1 QTEST_QEMU_BINARY=./qemu-system-x86_64 \
> ./tests/qtest/migration-test \
> --full -p /x86_64/migration/postcopy/recovery/double-failures/handshake
> ...
> qemu-system-x86_64: ../util/error.c:65: error_setv: Assertion `*errp ==
> NULL' failed.
> 

Regards,
Arun


