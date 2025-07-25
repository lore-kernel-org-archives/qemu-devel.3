Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D55C87FCF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHOb-00029b-AP; Fri, 25 Jul 2025 08:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHOJ-0001cH-D4
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHOF-0008Ft-Os
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753445945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yKCvgGVLpMjtrCICB97K1Wl9IoyRIIta8CTeFwBs4NY=;
 b=TevtsYFbp6IOiDLs1VvIHbbNbi5QZxp+mt6JRoRQQlEK1MHDms2i0awXAqEYeokNt8N1N2
 0ZL4Dj9yLCBIECa89XZXSamCL9KSiLXR68Wtvx7FZ40a/IKreo9wTvlmnP1MzXFLczHWb8
 cc89Xgp3SnEIuHSvhlX22IHpFXDzrhI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-DPrY_gKlN5SWAtr-fPT3QQ-1; Fri, 25 Jul 2025 08:19:04 -0400
X-MC-Unique: DPrY_gKlN5SWAtr-fPT3QQ-1
X-Mimecast-MFC-AGG-ID: DPrY_gKlN5SWAtr-fPT3QQ_1753445943
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3138e64b3f1so3311956a91.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753445943; x=1754050743;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yKCvgGVLpMjtrCICB97K1Wl9IoyRIIta8CTeFwBs4NY=;
 b=PJdSz64UIgn6s07VVHiA+nLJtPmxDxv9xp6jvdzjoP0F3QTZC+hwF3q7uwLgP3D5YX
 q51eYH+Y5A0RYkTHVxvt56Sfc6YCWBSR1WDY9hDl81WGoz6B4ik6SQ4uP2EvNkUXh4eb
 vRK6dvji/yo6evmsf5GL0R+6buKfEWfm0jNTlNSF98+P1toIQmcSMX4j4CT2xVHQ/wxI
 fp3Wu1A268PcZ+rfaZSV/4sgcyRW84c1hhP0esZ8/+BhafSscrOWYGlXIVVEl3Ak6LoL
 gCF0iNH3Q94zIZ9AGMYE2lLkgEdo52HOH1c7EME1PFTyGuEDwl2PpcfQ71pZ+MHzBVVg
 4rJw==
X-Gm-Message-State: AOJu0YzOnzCmk/6mrAREFJkP8FJD28crf2IpDjmksl1dFZ3jm90hekK3
 hBqW2w7H7WncP2res8Mbc6wk158GqxQ3qJLjDXqBd2/+TACQQ7sAeghgd3xXVldV/XJS09r8hZl
 m0Yrq0Jd5GZ/7aW0axbhDUTDUsKuF05r/86z2Wb6SDEMLPQabx8YQvJ/U
X-Gm-Gg: ASbGncvl+YmJKzR7UWJ3QJFIWs+b+OKZ2q0QBIM1gKEIyd9QfMh6UlOdRvDDUrvt0Hl
 ueZyVrdnCKmQ0wsVfCiXYhfO9rEGQQwJqZ/PaKk9Dggf/cBNrAFxFOYrhys4w3zASMrmuNgBhaU
 VI7B3GMlAq/Q9lVO3hu6z1onhdNj30J3eSRmXz2wm5se7+dMmd4keqsbAem5f5M6ETcKTsKO9C5
 BoyHnXukCy17AruwNNv7l9qJSKDvK60IJOQGbMC5Nnp5cdKSP0rJpeNGFPyqd+9WBphp6x6hbQ8
 Ue0EnlCDN9fTKk2CQ7MbfFTvlV2pwPjsDWfX4j6wNKYEDbAENDZbvQ==
X-Received: by 2002:a17:90b:554d:b0:31e:3848:c9ee with SMTP id
 98e67ed59e1d1-31e77a2f69emr2761987a91.9.1753445943073; 
 Fri, 25 Jul 2025 05:19:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXmoIlDMNvrhySWCGQTM0Euf2t3IpJvE0cOEhfZekB85HNLIdfi193vYwRkAHSrnuW8tpKEw==
X-Received: by 2002:a17:90b:554d:b0:31e:3848:c9ee with SMTP id
 98e67ed59e1d1-31e77a2f69emr2761911a91.9.1753445942486; 
 Fri, 25 Jul 2025 05:19:02 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:19:01 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Subject: [PATCH v7 00/24] migration: propagate vTPM errors using Error objects
Date: Fri, 25 Jul 2025 17:48:39 +0530
Message-Id: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB92g2gC/33PTWrDMBAF4KsErasyGv131XuUEFRrFGuRyMjGN
 ATfvUo2dbHb5RuY7/HubKSaaWRvhzurNOcxl2sL9uXAuj5cz8RzbJkhoAaDig+1DOEcJjpNw+V
 EtZbKP5MKZDqUUQJrn0OllL+e6sex5T6PU6m3Z8ksHtf/vVlw4CisUM4G7WV8rxT7ML125cIe4
 IxrxO4j2BCnvYfO+RjQbxD5g1jAfUQ2xDsTvdIKNLoNolaIMPuIakgbIzwgWNvBBtFr5I85uiE
 iKTDJOSKjN4hZISj2EdOQRMkqIKFJ2F/IsizfsiE1kxACAAA=
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
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8077; i=armenon@redhat.com;
 h=from:subject:message-id; bh=R6DDvNEZhRDavCndFBnlYLSAW5fCNmhnP6HMm1cE2ww=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Zzmfb6Z2c1/5gHTzXa84tTRULgsO+sExKXC7hOtB4pX
 HXz9hzzjlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABNpfszwV/z/ffl7xbt3nKwy
 UzmTn31v4erDfVL+HM+fhPlefceceZThv/PKOWZPD9xZdvHYai89j0+3r+cdPb1rjYVxwdLnE8Q
 ur+QBAA==
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
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
Changes in v7:
- Fix propagating errors in post_save_errp. The latest error encountered is
  propagated.
- user-strings in error_prepend() calls now end with a ': ' so that the print is pretty.
- Change the order of one of the patches.
- Link to v6: https://lore.kernel.org/qemu-devel/20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com

Changes in v6:
- Incorporated review comments from Daniel and Akihiko, related to few
  semantic errors and improve error logging.
- Add one more patch that removes NULL checks after calling 
  qemu_file_get_return_path() because it does not fail.
- Link to v5: https://lore.kernel.org/qemu-devel/20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com

Changes in v5:
- Solve a bug that set errp even though it was not NULL, pointed out by Fabiano in v4.
- Link to v4: https://lore.kernel.org/qemu-devel/20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com

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
Arun Menon (24):
      migration: push Error **errp into vmstate_subsection_load()
      migration: push Error **errp into vmstate_load_state()
      migration: push Error **errp into qemu_loadvm_state_header()
      migration: push Error **errp into vmstate_load()
      migration: push Error **errp into qemu_loadvm_section_start_full()
      migration: push Error **errp into qemu_loadvm_section_part_end()
      migration: Update qemu_file_get_return_path() docs and remove dead checks
      migration: make loadvm_postcopy_handle_resume() void
      migration: push Error **errp into loadvm_process_command()
      migration: push Error **errp into loadvm_handle_cmd_packaged()
      migration: push Error **errp into ram_postcopy_incoming_init()
      migration: push Error **errp into loadvm_postcopy_handle_advise()
      migration: push Error **errp into loadvm_postcopy_handle_listen()
      migration: push Error **errp into loadvm_postcopy_handle_run()
      migration: push Error **errp into loadvm_postcopy_ram_handle_discard()
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
 migration/colo.c            |  12 +-
 migration/cpr.c             |   4 +-
 migration/migration.c       |  31 ++---
 migration/postcopy-ram.c    |   9 +-
 migration/postcopy-ram.h    |   2 +-
 migration/qemu-file.c       |   1 -
 migration/ram.c             |  12 +-
 migration/ram.h             |   4 +-
 migration/savevm.c          | 316 +++++++++++++++++++++++++-------------------
 migration/savevm.h          |   7 +-
 migration/vmstate-types.c   |  10 +-
 migration/vmstate.c         | 114 ++++++++++++----
 tests/unit/test-vmstate.c   |  18 +--
 ui/vdagent.c                |   2 +-
 25 files changed, 365 insertions(+), 249 deletions(-)
---
base-commit: 9e601684dc24a521bb1d23215a63e5c6e79ea0bb
change-id: 20250624-propagate_tpm_error-bf4ae6c23d30

Best regards,
-- 
Arun Menon <armenon@redhat.com>


