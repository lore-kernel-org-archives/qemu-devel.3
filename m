Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECBEC77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 12:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU2iW-0001KD-Qc; Tue, 24 Jun 2025 08:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uU2iH-0001El-JO
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 08:25:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uU2i2-0001sf-E3
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 08:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750767902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7syJswP69mqCnfQoubwYg8vQI+yyE1F8nyW5Ba91ksc=;
 b=eRODnmLqqloW6ZVU9u7clOHX78fZQ+mIzZUEzFdSHFvWt24tc1KEWEsMGdbyS3qUpa0LjN
 4Lqk3RpkALxMlNq+915xzllbbQ0CZ4fX547k8TBLgwlx9toAiuCqwuz+uUmbiM9SXU/iIJ
 fncZmA4EZRHeO1+ixaT+gxFwiPs8I8o=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-Sb-1m7WvPMmAeky51khRoA-1; Tue, 24 Jun 2025 08:23:35 -0400
X-MC-Unique: Sb-1m7WvPMmAeky51khRoA-1
X-Mimecast-MFC-AGG-ID: Sb-1m7WvPMmAeky51khRoA_1750767814
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7391d68617cso4503188b3a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 05:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750767814; x=1751372614;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7syJswP69mqCnfQoubwYg8vQI+yyE1F8nyW5Ba91ksc=;
 b=Ovj4TQrL934kvSGijWtMnMcFkQB9Ntcls4TLKc+sD1BIb+tZttLGpLaQUihzNWxikf
 DG09CPoQZziE7ms+j9w81cDQrYYv87JQbcKqlt33qvcLZcjr0lKRIweAYbh/D7XmweYW
 Hsn0tYaoPTjaCXryPDnjx+27RLqDf+obD7relFrucr5TlhYBCRhOowWySbW51hIibKfD
 5JWHf1VW5AwCKxCKYbPaRTXSD5PVBO+ZhXsuIJ10lyGtXvT2JW2eDFUN8vJER2H7gVTa
 Af3kWoYoO7vB11J37GsrL1INL17Lwc+4jqtgPIkyNRqu2XmbzDqxI913gdskenhsCJfb
 MnLQ==
X-Gm-Message-State: AOJu0Yz/0hNW+Npgu32aj8uZnSsmaOzNlfQzG8LuOjamB0ubJvL86KgM
 qJdi5ms2MIFXcgIeJs66/ok5CkM8Eh7iZxXo3znxlJjKp3ozEe77GzwRDMn+Zmk4p/a7JfiXuyr
 GPnHNmhPsaUrHvCGF3TgcRS7KZ5KTfo/RoD1+xIFPv+4X7gwsDL/qeAaZ
X-Gm-Gg: ASbGncswuczTxyaVSr5NwouDQb7hnIiKUlYyB6a1gOX6JYwskRZetyIGQJKe3C5fq+h
 ku+iy9TCrRDUbS7vToXEzKzJ7DCpOspgmN+E1Ktfo65oWnhmxxP8SKF9wFc9QlIPaV9iz7sYqXk
 pyAAml561LemsJut+/QFhHAwQlwmDAw3GG/Qf/BPbwKL1iMy7+FUW1bi5VaoxNUR8e/e0FmMBmK
 FSTA7dwbEWzlgiZtyJQLJ1DqPSTl9408xqawfbg7LKy09ujBmTwvVz2mQWCOBC7URLFJbQlJT0o
 rNLITgvxceU2OVxjqF+ZnN3p9dX6tx4RVha+
X-Received: by 2002:a05:6a20:9192:b0:220:1843:3b7b with SMTP id
 adf61e73a8af0-2206a019006mr6338504637.4.1750767814296; 
 Tue, 24 Jun 2025 05:23:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy4FYJpxcPQgZ8BeS0nZUjjIrP97p9XehK6tnUx6TnHHXH64pgpUcsKgEyGL6I+1g4uq3cIw==
X-Received: by 2002:a05:6a20:9192:b0:220:1843:3b7b with SMTP id
 adf61e73a8af0-2206a019006mr6338440637.4.1750767813743; 
 Tue, 24 Jun 2025 05:23:33 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.251])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749c882cc5fsm1772091b3a.73.2025.06.24.05.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 05:23:33 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Subject: [PATCH 0/3] migration: propagate vTPM errors using Error objects
Date: Tue, 24 Jun 2025 17:53:03 +0530
Message-Id: <20250624-propagate_tpm_error-v1-0-2171487a593d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKeYWmgC/x3MQQqAIBBA0avErBPMykVXiQjL0WaRyhgRhHdPW
 r7F/y9kZMIMU/MC402ZYqjo2gb2wwSPgmw1KKlGqdUgEsdkvLlwvdK5InNksbnBoN5Vb3sJtUy
 Mjp7/Oi+lfLh92gBlAAAA
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
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2929; i=armenon@redhat.com;
 h=from:subject:message-id; bh=4mLA1NFU+PyTe6GUtafXdkG5oB1sdebMKg07gZUA5zE=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0bUjH0TXv88XfvhQGGn5xLW6ZLMq6ZMtr9u79e6LFKlN
 avE3tmlo5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwESKvjH8FRG5d7Y9a/4sI9kW
 u7mafmFvtjDItpg+ulTwOjX5a65CHiPD/a7sDWJmvxboPZP2mC8R0q3wRPaE6ZMyxVVi3Dnudj/
 ZAA==
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Arun Menon (3):
      migration: Pass error object to report it to the caller
      migration: Use error_setg instead of error_report
      backends/tpm: Propagate vTPM error on migration failure

 backends/tpm/tpm_emulator.c |  39 ++++++++--------
 hw/display/virtio-gpu.c     |   2 +-
 hw/pci/pci.c                |   2 +-
 hw/s390x/virtio-ccw.c       |   2 +-
 hw/scsi/spapr_vscsi.c       |   2 +-
 hw/vfio/pci.c               |   2 +-
 hw/virtio/virtio-mmio.c     |   2 +-
 hw/virtio/virtio-pci.c      |   2 +-
 hw/virtio/virtio.c          |   4 +-
 include/migration/vmstate.h |   3 +-
 migration/colo.c            |   4 +-
 migration/cpr.c             |   2 +-
 migration/migration.c       |  10 +++-
 migration/savevm.c          | 108 +++++++++++++++++++++++++-------------------
 migration/savevm.h          |   7 +--
 migration/vmstate-types.c   |  10 ++--
 migration/vmstate.c         |  40 ++++++++--------
 tests/unit/test-vmstate.c   |  18 ++++----
 18 files changed, 144 insertions(+), 115 deletions(-)
---
base-commit: 43ba160cb4bbb193560eb0d2d7decc4b5fc599fe
change-id: 20250624-propagate_tpm_error-bf4ae6c23d30

Best regards,
-- 
Arun Menon <armenon@redhat.com>


