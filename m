Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C6AC83F05
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 11:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWvn5-0002dc-7P; Wed, 02 Jul 2025 07:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uWvn2-0002dA-8f
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 07:38:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uWvmw-0006D4-HN
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 07:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751456281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YSVL4tzq3SkmfoDBAjhF7SUVftx6gH2S8cjCod9qR/0=;
 b=ivGkzM1sEoYvu/dnhfsxlm2GPoSgBUQ5Oq8mGeZX+Og74d2U84rDiPeMIk3vstj4PSuKW2
 6mwIhYEM+TdVi13QFSirkh99qR1TGTXEj3XkSPTQxGESrk0mPiEGx6lnK453Zz4zJDY4SI
 NUWdyaxz3TqJaRVaL4NsYyoqzLiSdh4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-C4mFxUlsPUOveDJZCUFB1A-1; Wed, 02 Jul 2025 07:38:00 -0400
X-MC-Unique: C4mFxUlsPUOveDJZCUFB1A-1
X-Mimecast-MFC-AGG-ID: C4mFxUlsPUOveDJZCUFB1A_1751456279
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-234a102faa3so49926885ad.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 04:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751456279; x=1752061079;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YSVL4tzq3SkmfoDBAjhF7SUVftx6gH2S8cjCod9qR/0=;
 b=cgE4u3wsMhgS1F8U10xborJfR6OwwbMtB3gXb7dYzkAyS+MSeQ7EhjEdH6I8pC8mtA
 gWQEJ/I6077oBbP+RkCXiikdzeJCEaBJkGeGxe2qPqdWK45GkZ3tKzQvuWYVjErBmwv+
 guvnUhj/PPzxOKKq0oMmsS8sA/fRodsjIKTeefTPd9KQup5+XUYtXRHZN5ELC02zqdzq
 bTjJCP2Ttpg2J4WczB+nTS9ffR6oQqxONvF7sVg2FCMUVVWXGYSkuVHJK59HreC1/wSX
 RnC/SkZWJLfZy+xolFqUBZAHsqjVhJB1LjSNvqBNFp2EZ/kfXMmZgTAVL8UsueJp/bsX
 Ek6A==
X-Gm-Message-State: AOJu0YwCjCxfOe9OzPmkm2U6FhqOL961/tKc4knuMWX37O4AF7FHk3sD
 AbAwA0NtRO2TBfBgDmaMSTjoTUoy4tzO6zPA4ZByZ+yVeAGxHd9Oa3o+HaVV6mwcfkMF8bHizbr
 rDuThtek5az1bGp2JnXDKP1N9CF2LIaMwaAcIw92apIJ3IleeSaMMUGwt
X-Gm-Gg: ASbGncsrtg9a/2nQDmEHES2G11YLczM+7va5AkQxlZJ7nLVrYVpiPhiGe60vSyvlsvS
 8TMAoDniNNU/Ymi+CRw3EwNZOHst2ivyfkr9wFjf4WiFhwSf20fgyWBgkcqN1r3qZZS7ydBJVZE
 kzu9RG43k0MKxvj3CxgZKFZDYnzAOt0Fiisk2eT+OHP6VpAnnajc2X3oyMJBf+jnSt0fHcC/6Hv
 jMx8ne6eS/Kx13/ofrJbO06Euonh30TmD9xPp5WxwOOdoXKmqZ2J062i81Ho4nLK3OcBobSO2nq
 kmuiL0JRN94SdiTsqaY2dgLZrkGASox9mRU=
X-Received: by 2002:a17:903:1ac4:b0:234:c549:da13 with SMTP id
 d9443c01a7336-23c6e5023camr36135685ad.17.1751456279009; 
 Wed, 02 Jul 2025 04:37:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYLGc1oU+mXugm+q3SjoZAT3a4rTH4he0XChSzHu5eVMCZJzFUNMrXs6xBDcXP3RK9vROFBg==
X-Received: by 2002:a17:903:1ac4:b0:234:c549:da13 with SMTP id
 d9443c01a7336-23c6e5023camr36135325ad.17.1751456278564; 
 Wed, 02 Jul 2025 04:37:58 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23b0b3bc0f1sm84265205ad.171.2025.07.02.04.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 04:37:58 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Subject: [PATCH v3 0/3] migration: propagate vTPM errors using Error
 objects
Date: Wed, 02 Jul 2025 17:06:49 +0530
Message-Id: <20250702-propagate_tpm_error-v3-0-986d94540528@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANEZZWgC/33NywrCMBCF4VcpWRvJpbe48j1ESmymbRZtwiQEp
 fTdTbtSEJf/gflmJQHQQiCXYiUIyQbrlhzyVJB+0ssI1JrcRDBRsVqU1KPzetQRuujnDhAd0sd
 Qaqh7IY1kJF96hME+D/V2zz3ZEB2+jieJ7+t/L3HKqOANL9tGV0qaK4KZdDz3biY7mMQn0vxGR
 EbaSinWt8poob6QbdvebjAuH/wAAAA=
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
 Arun Menon <armenon@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3952; i=armenon@redhat.com;
 h=from:subject:message-id; bh=Zpa06NjrIp/4bUyBxo7jmkm2sHqYjAxQS2ts9QgIbjk=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aqFJ/p7HXP3s7X6ebX3tr2agGjj0Fa6jtXS3VrkePXg
 vMnaU7qKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMBEvIUaG5wGLjq1hf3b15bXl
 +zYwuizsnHFsaXNbz/bX7+vXWjZwZTP8M8je9Opl3Nw7/9cv3Z/7bUnevg8WJ372/d+toiVeFsn
 NyA0A
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
- Also, the TPM backend makes use of a new hook called post_load_with_error()
  that explicitly passes an Error object.

While this series focuses specifically on TPM error reporting during
live migration, it lays the groundwork for broader improvements.
Most methods in savevm.c that previously returned an integer now capture
errors in the Error object, enabling other modules to adopt the
post_load_with_error hook in the future.

One such change previously attempted:
https://lists.gnu.org/archive/html/qemu-devel/2021-02/msg01727.html

The series does not necessarily have to be applied in 1 go. Each patch
can be compiled and tested separately.

Resolves: https://issues.redhat.com/browse/RHEL-82826

Signed-off-by: Arun Menon <armenon@redhat.com>
---
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
Arun Menon (3):
      migration: Pass Error object errp into vm state loading functions
      migration: Introduce a post_load_with_error hook
      backends/tpm: Propagate vTPM error on migration failure

 backends/tpm/tpm_emulator.c |  39 +++++++------
 hw/display/virtio-gpu.c     |   2 +-
 hw/pci/pci.c                |   2 +-
 hw/s390x/virtio-ccw.c       |   2 +-
 hw/scsi/spapr_vscsi.c       |   2 +-
 hw/vfio/pci.c               |   2 +-
 hw/virtio/virtio-mmio.c     |   2 +-
 hw/virtio/virtio-pci.c      |   2 +-
 hw/virtio/virtio.c          |   4 +-
 include/migration/vmstate.h |   3 +-
 migration/colo.c            |  13 +++--
 migration/cpr.c             |   2 +-
 migration/migration.c       |  19 ++++--
 migration/savevm.c          | 137 +++++++++++++++++++++++++++-----------------
 migration/savevm.h          |   7 ++-
 migration/vmstate-types.c   |  10 ++--
 migration/vmstate.c         |  44 ++++++++------
 tests/unit/test-vmstate.c   |  18 +++---
 18 files changed, 182 insertions(+), 128 deletions(-)
---
base-commit: 43ba160cb4bbb193560eb0d2d7decc4b5fc599fe
change-id: 20250624-propagate_tpm_error-bf4ae6c23d30

Best regards,
-- 
Arun Menon <armenon@redhat.com>


