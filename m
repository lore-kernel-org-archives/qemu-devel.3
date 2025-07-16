Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525E3C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzdj-00007X-HD; Wed, 16 Jul 2025 06:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzbk-0005O0-Qv
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:43:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzbi-00009T-2R
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sU6dm31VUtBoN1BrqnEnYeRPJpgSbOisDSllHGz16mQ=;
 b=HVUpz6eR0TdfUGM610MdssdWMH+FDoLB/y2H1QmF10xxJRhDbViVEaG96gK4DRbUyWTDTo
 7g7D3+jP/5kTrV38EyEEC3PUXKyRLZ9cH2PApyu8SsN2XyBMyjNIzMYOMGgViPhhswMG/n
 U6t+ITaHWoy9Fagtj+dlI4G3XjaihnY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-vDv-dKQ4O0iJcWF3-eBCLw-1; Wed, 16 Jul 2025 06:43:22 -0400
X-MC-Unique: vDv-dKQ4O0iJcWF3-eBCLw-1
X-Mimecast-MFC-AGG-ID: vDv-dKQ4O0iJcWF3-eBCLw_1752662602
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-237f8d64263so67585205ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662602; x=1753267402;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sU6dm31VUtBoN1BrqnEnYeRPJpgSbOisDSllHGz16mQ=;
 b=kZCoSSfG2f8JQhKgEUI3bWHpAUzgHQqE3LLlOIa6ocmxXer114J8wgAv9M2AM1xZXV
 pK7F8JIx3rY8CP7jVTxmdcobUHaV/45bVZssEYTYVGxTB7MjQ3ZvVlcj0SqxUrgeUUUo
 Z31gnvb+vsPEsIoDgePUzxPSXw2hgpA4iXwXhBnX+Lt2jRLoR3eJtsnpepe9qNCwG34z
 sxcMCzT5C/eIvy1dhK8gzFEmiPuGH32h7Weje53DrBR4WoAlo5ZGNjSR11dqdJt4QnEY
 LqtK1wVxWxuzyFdimCc1oTMWCbsZy/73cJP5fUcLjrU/nRPA52TTIO37Fj3E9HJRX3DY
 hoGg==
X-Gm-Message-State: AOJu0YwDpeTgpCr2duSbWBGWviu2FWLfFTxsH6EH01Z9YzvAeMQST0ib
 PP63jXxO2+Z2+nbMp69CES0SE5Y1tyRPQps3SF87a/ABlAK61xJWtk1oiCinW567hIlt1mZXDB1
 S0FwnMS4FFRRJ8sAawdzj4kYorkPAFr1aIVwRR09V7La4YpLRTZC/1ALD
X-Gm-Gg: ASbGnctQugS1qYu311cGW0vjvc1WhTRpXWFuxdMr3ezAYyKJex0oIci/UGjvQn2Rmam
 rKtQ6FTBTTyC/3a65PzIxwAOIOmAP97oYuNeS5jhedc2iogYil9ACM95YFyOABvm7nHaZelQfTl
 YKqWGKzmE/EVA6uOY39cAZzetmgh5f2EAtYFIwG4wTWS3pCZBiX6IjisPpuEKn/GTMsTVK5cfHO
 8QhUNYVCmyCEEvhipEL+GbABpJ0+0YiiXRhj2rYUASNJl28l960NSLpNc52pnF0kKjB8kzL+cUA
 V2tVquTX0JXWXebDqO/2x7oNJSPu+seGUh+eQdwBb24eVr0FSA==
X-Received: by 2002:a17:902:cf11:b0:234:ba37:87ae with SMTP id
 d9443c01a7336-23e24f3648dmr30097355ad.4.1752662601560; 
 Wed, 16 Jul 2025 03:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOujTnf2XxIvgQUnfsHwS6wmz0q7WHx82c1A4XWx/H2IvQmy31LoWU73BUHWsMuA135Ura7A==
X-Received: by 2002:a17:902:cf11:b0:234:ba37:87ae with SMTP id
 d9443c01a7336-23e24f3648dmr30096975ad.4.1752662601068; 
 Wed, 16 Jul 2025 03:43:21 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:43:20 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Subject: [PATCH v4 00/23] migration: propagate vTPM errors using Error objects
Date: Wed, 16 Jul 2025 16:12:50 +0530
Message-Id: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACqCd2gC/33NQQ6CMBCF4auQrq0p0xZaV97DGFLpCF1gyUCIh
 nB3Cxs1Gpf/S+abmQ1IAQd2yGZGOIUhxFsKtctY3bpbgzz41AwEaFGA4j3F3jVuxGrsuwqJIvH
 LVTksapBeCpYue8JruG/q6Zy6DcMY6bE9mfJ1/e9NORcc8jJXpnTaSn8k9K0b93Xs2ApO8I6Uv
 xFIiNHWitpY78B+IfKFlAJ+IzIh1hTeKq2EBvOBLMvyBNfPbuVBAQAA
X-Change-ID: 20250624-propagate_tpm_error-bf4ae6c23d30
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
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
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7025; i=armenon@redhat.com;
 h=from:subject:message-id; bh=LcduCkGRUboqGuPf9DZ+CiQRvNTRTJo249p8WPs7qVw=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5k93/Q2+rD4s6XJM1yTvp8tNVwGnh0unrFwsvbl1aO
 +Ul10nzjlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABMxSmJk+PZD1mRC6h6V6+57
 FN8yN+x9calz9quQH51Tl7iWBZSW5jH8Fby44Yb7Tc15Ewz/6x8JPOG3ekv7Dte3X1c1NPMI1v0
 xZgEA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

Currently, when a migration of a VM with an encrypted vTPM
fails on the destination host (e.g., due to a mismatch in secret values),
the error message displayed on the source host is generic and unhelpful.

For example, a typical error looks like this:
"operation failed: job 'migration out' failed: Sibling indicated error 1.
operation failed: job 'migration in' failed: load of migration failed:
Input/output error"

This message does not provide any specific indication of a vTPM failure.
Such generic errors are logged using error_report(), which prints to
the console/monitor but does not make the detailed error accessible via
the QMP query-migrate command.

This series addresses the issue, by ensuring that specific TPM error
messages are propagated via the QEMU Error object.
To make this possible,
- A set of functions in the call stack is changed
  to incorporate an Error object as an additional parameter.
- Also, the TPM backend makes use of a new hook called post_load_errp()
  that explicitly passes an Error object.

It is organized as follows,
 - Patches 1-21 focuses on pushing Error object into the functions
   that are important in the call stack where TPM errors are observed.
   We still need to make changes in rest of the functions in savevm.c
   such that they also incorporate the errp object for propagating errors.
 - Patch 22 introduces the new variants of the hooks in VMStateDescription
   structure. These hooks should be used in future implementations.
 - Patch 23 focuses on changing the TPM backend such that the errors are
   set in the Error object.

While this series focuses specifically on TPM error reporting during
live migration, it lays the groundwork for broader improvements.
A lot of methods in savevm.c that previously returned an integer now capture
errors in the Error object, enabling other modules to adopt the
post_load_errp hook in the future.

One such change previously attempted:
https://lists.gnu.org/archive/html/qemu-devel/2021-02/msg01727.html

Resolves: https://issues.redhat.com/browse/RHEL-82826

Signed-off-by: Arun Menon <armenon@redhat.com>
---
Changes in v4:
- Split the patches into smaller ones based on functions. Pass NULL in the
  caller until errp is made available. Every function that has an
  Error **errp object passed to it, ensures that it sets the errp object
  in case of failure.
- A few more functions within loadvm_process_command() now handle errors using
  the errp object. I've converted these for consistency, taking Daniel's
  patches (link above) as a reference.
- Along with the post_load_errp() hook, other duplicate hooks are also introduced.
  This will enable us to migrate to the newer versions eventually.
- Fix some semantic errors, like using error_propagate_prepend() in places where
  we need to preserve existing behaviour of accumulating the error in local_err
  and then propagating it to errp. This can be refactored in a later commit.
- Add more information in commit messages explaining the changes.
- Link to v3: https://lore.kernel.org/qemu-devel/20250702-propagate_tpm_error-v3-0-986d94540528@redhat.com

Changes in v3:
- Split the 2nd patch into 2. Introducing post_load_with_error() hook
  has been separated from using it in the backends TPM module. This is
  so that it can be acknowledged.
- Link to v2: https://lore.kernel.org/qemu-devel/20250627-propagate_tpm_error-v2-0-85990c89da29@redhat.com

Changes in v2:
- Combine the first two changes into one, focusing on passing the
  Error object (errp) consistently through functions involved in
  loading the VM's state. Other functions are not yet changed.
- As suggested in the review comment, add null checks for errp
  before adding error messages, preventing crashes.
  We also now correctly set errors when post-copy migration fails.
- In process_incoming_migration_co(), switch to error_prepend
  instead of error_setg. This means we now null-check local_err in
  the "fail" section before using it, preventing dereferencing issues.
- Link to v1: https://lore.kernel.org/qemu-devel/20250624-propagate_tpm_error-v1-0-2171487a593d@redhat.com

---
Arun Menon (23):
      migration: push Error **errp into vmstate_subsection_load()
      migration: push Error **errp into vmstate_load_state()
      migration: push Error **errp into qemu_loadvm_state_header()
      migration: push Error **errp into vmstate_load()
      migration: push Error **errp into qemu_loadvm_section_start_full()
      migration: push Error **errp into qemu_loadvm_section_part_end()
      migration: push Error **errp into loadvm_process_command()
      migration: push Error **errp into loadvm_handle_cmd_packaged()
      migration: push Error **errp into ram_postcopy_incoming_init()
      migration: push Error **errp into loadvm_postcopy_handle_advise()
      migration: push Error **errp into loadvm_postcopy_handle_listen()
      migration: push Error **errp into loadvm_postcopy_handle_run()
      migration: push Error **errp into loadvm_postcopy_ram_handle_discard()
      migration: make loadvm_postcopy_handle_resume() void
      migration: push Error **errp into loadvm_handle_recv_bitmap()
      migration: push Error **errp into loadvm_process_enable_colo()
      migration: push Error **errp into loadvm_postcopy_handle_switchover_start()
      migration: push Error **errp into qemu_loadvm_state_main()
      migration: push Error **errp into qemu_loadvm_state()
      migration: push Error **errp into qemu_load_device_state()
      migration: Capture error in postcopy_ram_listen_thread()
      migration: Add error-parameterized function variants in VMSD struct
      backends/tpm: Propagate vTPM error on migration failure

 backends/tpm/tpm_emulator.c |  39 +++---
 hw/display/virtio-gpu.c     |   2 +-
 hw/pci/pci.c                |   2 +-
 hw/s390x/virtio-ccw.c       |   2 +-
 hw/scsi/spapr_vscsi.c       |   2 +-
 hw/vfio/pci.c               |   2 +-
 hw/virtio/virtio-mmio.c     |   2 +-
 hw/virtio/virtio-pci.c      |   2 +-
 hw/virtio/virtio.c          |   4 +-
 include/migration/colo.h    |   2 +-
 include/migration/vmstate.h |  13 +-
 migration/colo.c            |  10 +-
 migration/cpr.c             |   4 +-
 migration/migration.c       |  19 +--
 migration/postcopy-ram.c    |   9 +-
 migration/postcopy-ram.h    |   2 +-
 migration/ram.c             |  14 +--
 migration/ram.h             |   4 +-
 migration/savevm.c          | 299 +++++++++++++++++++++++++-------------------
 migration/savevm.h          |   7 +-
 migration/vmstate-types.c   |  10 +-
 migration/vmstate.c         |  83 ++++++++----
 tests/unit/test-vmstate.c   |  18 +--
 ui/vdagent.c                |   2 +-
 24 files changed, 325 insertions(+), 228 deletions(-)
---
base-commit: 9a4e273ddec3927920c5958d2226c6b38b543336
change-id: 20250624-propagate_tpm_error-bf4ae6c23d30

Best regards,
-- 
Arun Menon <armenon@redhat.com>


