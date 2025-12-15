Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD76D5B868
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 20:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVFYE-00064P-Dw; Mon, 15 Dec 2025 15:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYC-00062r-8K
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYA-0005f7-2I
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765831928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1JbrGQJvmaHzzS/pyTM2cKS7blM92SxL8uj+45k4ggU=;
 b=MiliSHkRXDkPIFyMxAxGjtDIM60QP/QDfANcjOfYwgX5ut54mwKuC33e4b9op1ZrmZbziy
 a7DwafIaYGq4HSA1DjuHEV9lMygFue6MWOuVsHIV6XMHxWSaUtmuuk4zo62HcH0s7SShKk
 Vl+sMuxHSZE276+MIIYJS6goW3X5tdw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-EC5ydvdMOkihOdIXKWbBWQ-1; Mon, 15 Dec 2025 15:52:07 -0500
X-MC-Unique: EC5ydvdMOkihOdIXKWbBWQ-1
X-Mimecast-MFC-AGG-ID: EC5ydvdMOkihOdIXKWbBWQ_1765831927
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4f183e4cc7bso77998131cf.0
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 12:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765831926; x=1766436726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1JbrGQJvmaHzzS/pyTM2cKS7blM92SxL8uj+45k4ggU=;
 b=D1EAx+6yOthyVLU5R9AgOcmVkds3dB/Gwcgj7vKV/87K/+j2+K8vFFrvIoBdCJ7taq
 EXVvEZVzeU1ztOrvL4QZQdPikfvuE8yELWqMYeokw+VHysOfSkbtziwHTceoju3LL2kQ
 2C23E2w1irRx9Nh3uSh5M8P2HaBhwLGAdK+XGZGKBBwcAnJkbxQeo8HzFpsqVvDHkUKy
 ZF74/2sRfhoPRgip0f9++IIU1wCCVnF1xGvSmbb0cfxZCMEsmB1QhhwLs5SyQxa96Zq2
 8/SFGfgRMoiITy9VTmZSUvQtrxGTqM4pdL6+r7CJD+D6GfvCxEzxWAgqgTwJoj3I1MS7
 pvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765831926; x=1766436726;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1JbrGQJvmaHzzS/pyTM2cKS7blM92SxL8uj+45k4ggU=;
 b=kI56H0XQCeNPfRhJsjnxs5FfuphvpZl1/FoUxtRde1TIUyDOghFNtbPcVMgYT/yI4r
 GKQhVaGFA3FiMyj3+n+Ch5LYVFEqYT5AtRehItuwe+RFwY0JGzzx1Quz5VNfI0v6Npnd
 W6XaOOUawknR9miCALxPAPSj7dETd6OI27V8SawXnlLQAgUc5+tr6wlZGBZd+lo8eqCG
 c3vmSTl6qYxfUBaZihyVZRSgox0GVGM1z/Tia3JtbFxpr1XXu6iRa9cDoqZUnjWoixlp
 rbFK6cRkmHunBLlbq3soBhlKoemVr4hFC8gR+XudLrrYYvr46ruq4bW6F6JY0U/MDIPj
 oA0A==
X-Gm-Message-State: AOJu0YzR5p0PEjy/tfQeQbI3BYJPo8owgRef3MUBeetGAtAlatxnrml/
 ynR53hgU6DYb7sDpuRMvCapvFMcRF6yGJ9UonPJyyyFL8S+LY7QfGVqwGdy5i1tu2JFQVlFBECy
 3tDiCcde2Z0T4VK5wP37eWZJPPWAyBfHqJ9kjFGnEBR9Ml6A6f6q98sbGREcFjP7ddWL+Rgr7Lv
 hg3FETE3ymjqsX09sW5PThA/pYE8+rZUH+0ZanxA==
X-Gm-Gg: AY/fxX7WHNi+AtFSytg7zoHGrfo8/trzYmdFZAm6IDjTKpY+aJwGB0qFlg0zlgVKqnU
 HU4C9Sa/mAGSyQ2/I/WYjolDEq7ub+DzSYo6LO9Jye6EFbxXyNF6EXsjDe+khwmrdfpMUuXO4lb
 BZ6PUy+Kv0bz9O39Bb5+hEKjdTHdcqPmwcEs+Aka1O470ONec1xC0U6kHxSiHB7segVIbqctelP
 NAOUS1MmyQfIjBmXcs8G5UjaJW5GTGbqfOJqIF8qhkLMH9o6B23ZTvljKogSXQke4CfhIwF0RPT
 VgFdc4BSlXFwbLo093SDHlgtZTpplkwPYExP7pxLKRgI8UB3X7cNnSW3wsOjR36hg8ulZZeRzDU
 z
X-Received: by 2002:ac8:7f8c:0:b0:4ee:2721:9ec5 with SMTP id
 d75a77b69052e-4f1d05d6647mr152885151cf.42.1765831926452; 
 Mon, 15 Dec 2025 12:52:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE37NqoJuXcgdfC79bfcBE66Y4YeFQPebduHoUogBTkVLlZGSSZMpo6yH9FR6Ez2c/7CBdT5Q==
X-Received: by 2002:ac8:7f8c:0:b0:4ee:2721:9ec5 with SMTP id
 d75a77b69052e-4f1d05d6647mr152884651cf.42.1765831925838; 
 Mon, 15 Dec 2025 12:52:05 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8899ea3621bsm58726236d6.36.2025.12.15.12.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:52:05 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Alexey Kardashevskiy <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v3 00/12] KVM/hostmem: Support init-shared guest-memfd as VM
 backends
Date: Mon, 15 Dec 2025 15:51:51 -0500
Message-ID: <20251215205203.1185099-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

v1: https://lore.kernel.org/r/20251023185913.2923322-1-peterx@redhat.com
v2: https://lore.kernel.org/r/20251119172913.577392-1-peterx@redhat.com

v3:
- Collect R-bs from Xiaoyao
- Rebased to 10.2-rc3; no dependency needed now, as those got merged
- Reorder patches, touch up commit messages or comments on in-place misuse
- Added patch "kvm: Provide explicit error for kvm_create_guest_memfd()" [Xiaoyao]
- Added one patch for renaming machine_require_guest_memfd() [Xiaoyao]
- Added one patch for renaming memory_region_init_ram_guest_memfd() [Xiaoyao]

=========8<===========

This series allows QEMU to consume init-shared guest-memfd to be a common
memory backend. Before this series, guest-memfd was only used in CoCo and
the fds will be created implicitly whenever CoCo environment is detected.
When used in init-shared mode, the guest-memfd will be specified in the
command lines directly just like other types of memory backends.

In the current patchset, I reused the memory-backend-memfd object, rather
than creating a new type of object.  After all, guest-memfd (at least from
userspace POV) works similarly like a memfd, except that it was tailored
for VM's use case.

This approach so far also does not involve gmem bindings to KVM instances,
hence it is not prone to issues when the same chunk of RAM will be attached
to more than one KVM memslots.

Now, instead of using a normal memfd backend using:

  -object memory-backend-memfd,id=ID,size=SIZE,share=on

One can also boot a VM with guest-memfd:

  -object memory-backend-memfd,id=ID,size=SIZE,share=on,guest-memfd=on

The init-shared guest-memfd relies on almost the latest linux, as the
mmap() support just landed v6.18-rc2.  When run it on an older qemu, we'll
see errors like:

  qemu-system-x86_64: KVM does not support guest_memfd

One thing to mention is live migration is by default supported, however
postcopy is still currently not supported.  The postcopy support will have
some kernel dependency work to be merged in Linux first.

Thanks,

Peter Xu (11):
  kvm: Detect guest-memfd flags supported
  kvm: Provide explicit error for kvm_create_guest_memfd()
  ramblock: Rename guest_memfd to guest_memfd_private
  memory: Rename RAM_GUEST_MEMFD to RAM_GUEST_MEMFD_PRIVATE
  memory: Rename memory_region_has_guest_memfd() to *_private()
  hostmem: Rename guest_memfd to guest_memfd_private
  hostmem: Support fully shared guest memfd to back a VM
  machine: Rename machine_require_guest_memfd() to *_private()
  memory: Rename memory_region_init_ram_guest_memfd() to *_private()
  tests/migration-test: Support guest-memfd init shared mem type
  tests/migration-test: Add a precopy test for guest-memfd

Xiaoyao Li (1):
  kvm: Decouple memory attribute check from kvm_guest_memfd_supported

 qapi/qom.json                         |  6 ++-
 include/hw/boards.h                   |  2 +-
 include/system/hostmem.h              |  2 +-
 include/system/kvm.h                  |  1 +
 include/system/memory.h               | 27 ++++++------
 include/system/ram_addr.h             |  2 +-
 include/system/ramblock.h             |  7 +++-
 tests/qtest/migration/framework.h     |  4 ++
 accel/kvm/kvm-all.c                   | 33 ++++++++++++---
 accel/stubs/kvm-stub.c                |  6 +++
 backends/hostmem-file.c               |  2 +-
 backends/hostmem-memfd.c              | 55 +++++++++++++++++++++---
 backends/hostmem-ram.c                |  2 +-
 backends/hostmem-shm.c                |  2 +-
 backends/hostmem.c                    |  2 +-
 backends/igvm.c                       |  4 +-
 hw/core/machine.c                     |  2 +-
 hw/i386/pc.c                          |  6 +--
 hw/i386/pc_sysfw.c                    |  8 ++--
 hw/i386/x86-common.c                  |  8 ++--
 system/memory.c                       | 17 ++++----
 system/physmem.c                      | 37 ++++++++++-------
 target/i386/kvm/kvm.c                 |  3 +-
 tests/qtest/migration/framework.c     | 60 +++++++++++++++++++++++++++
 tests/qtest/migration/precopy-tests.c | 12 ++++++
 25 files changed, 239 insertions(+), 71 deletions(-)

-- 
2.50.1


