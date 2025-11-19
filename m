Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8406CF3979
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 17:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLlzy-00033q-Ds; Wed, 19 Nov 2025 12:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLlzk-000316-11
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:29:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLlzf-0004Nl-7X
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763573361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8nP0d5IOtnXzEI8CONRKrnrb1qyZ4MkyviAvMdYvPqc=;
 b=C638Zt/5QwrYEG6p4qBnXFEe9g7VdR1EPpitXGuCLcCK/LEbz7oNOjRPstYo9ouXmp4mEF
 y0yis91GLI507txYIPMDStmoSjxSRGymdfi6YEzokGY6LA9Rx+lkhKqrTJ0SmxRGU5vTpr
 4ualeYQCFYMd30YXwtYGRQHwrmInmlE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-WUp-imaAM5SkwEQ2FfSgnQ-1; Wed, 19 Nov 2025 12:29:17 -0500
X-MC-Unique: WUp-imaAM5SkwEQ2FfSgnQ-1
X-Mimecast-MFC-AGG-ID: WUp-imaAM5SkwEQ2FfSgnQ_1763573357
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b286006ffaso2183499085a.2
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 09:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763573357; x=1764178157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8nP0d5IOtnXzEI8CONRKrnrb1qyZ4MkyviAvMdYvPqc=;
 b=KZp7ypWcFtfUApZXBv1K1GwDSAQzoeCVvVbdz+D6YVNpGDCGKO12j+ET5PA5paUI3A
 rpN4mVZVqP4BymXh/Lo5dZom40YnO5F7SxD/+ZoOnOpmpin+lwFzvcm8OszZjXTX9f5I
 JbnIRUWGPOIqHdqw0itzPg7h3ozgAWsKNL2dZkZZzyGRUkhbVCYJWNIrvXsJmL9Y4usA
 xshR4DyY2s+I3/nlWz+zY2x0/mlMasEf/SbjcW3grOODTJ3rMs1ISzkqB0dfF03PHNR9
 8lF2u6t2PJHRjBPEC4KaUGlVqU9lll6nR3KGZYbBDpBWAQieiz0BztnesCLS3e/Ou+BN
 jlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763573357; x=1764178157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8nP0d5IOtnXzEI8CONRKrnrb1qyZ4MkyviAvMdYvPqc=;
 b=bS4awhubR2BnQVjwdC4XSy2LR7v/OAYZaRvBalP3kX7IHf57pCr7EXsTraiKknSuGD
 7ZX9fE0i9VHqHyAdoMlwWUiXq8UHazYKXIVKJ4wo4cQWxdbGXb14ZN+E6FXadPZd8Opj
 JT7hvNaBublvZhecr0gl0zxywQmzsuxvMea4/3+TbaEylw2iB2zCXGSonnVPoU5/4T26
 E/z/jBrAvfSnmXULSm+U94nlEmWPZouAl6x3Jgxfz1+1heggvJvuZfTTdTlGAVDYk/3l
 XXm+urpkNNzRblZvi0IQm9I3NKpLPg+dYyZ8dGrfq5UcBoKP55liCu1e3unPlthKN3Bn
 vBIw==
X-Gm-Message-State: AOJu0YzmcdsDKx9DqTD4bRGGJ2bpgy+ucsF0EgSN193Zg37ywFxM9CZD
 xgAFaOzcCIIxK7KOUwC7v5046XQUvL025WE/mh0kAGHm2LQ6eorzUcO/43C7p1Hnv3WTtNP+lg4
 8ZpxkzM7Fch4cVQEXWHjPs1JS4GnRhVuvo+6SkBrgIAvGz7dUAt/6u9Dt8utyDx7DR5ji0QyDEI
 gbprvZVTl73QSVV060dbpHvmKbqMlfG3/knEFkYg==
X-Gm-Gg: ASbGncv2hAFQUulgjmn00CcFkv2Ytdx4JsyEnXnNvWRvUzlvNuth9urlzKDCcpVDFoY
 3flGU1pNoMUst9VWW3c/XQ+xw1nOGAKdumwDUi200TMO9nL1yLowPmU7RPcX/9DtavQE0M88GF1
 maEVqGneZzy2NUq+lxPjqzwlMHEI0AilOgfLhAkV8P+/+MqGrMqcKkB94T26UdEHtAh8u/0CYJ1
 fv/dS9oIrjj0Q7HymMEZPnDEMaycWzelx5TywSj4AkRRRkY9lvscMU44+QnALyvcmsaTkV9EiZ6
 i5XHFi3MvcZ+19jbs7BfuIo9veYlbF3lhnItFHlWWqBmOIF7+q3wk83UVtvxziOUVSQ2Qct8Spm
 i
X-Received: by 2002:a05:620a:4606:b0:8a6:e2b4:ba73 with SMTP id
 af79cd13be357-8b3274882fdmr19319285a.51.1763573356770; 
 Wed, 19 Nov 2025 09:29:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhNKgwlKQRz1zzFPvr3WArMYAILFQ3/nb7PZXumpsPhBxpr9xsOPlrL7XZfOWnIQMCF2R5Kw==
X-Received: by 2002:a05:620a:4606:b0:8a6:e2b4:ba73 with SMTP id
 af79cd13be357-8b3274882fdmr19313385a.51.1763573356113; 
 Wed, 19 Nov 2025 09:29:16 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2af042c9csm1444759485a.46.2025.11.19.09.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 09:29:15 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, peterx@redhat.com,
 Chenyi Qiang <chenyi.qiang@intel.com>, Juraj Marcin <jmarcin@redhat.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 0/9] KVM/hostmem: Support init-shared guest-memfd as VM
 backends
Date: Wed, 19 Nov 2025 12:29:04 -0500
Message-ID: <20251119172913.577392-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

NOTE: The test cases of this series needs a dependency small series:

Based-on: <20251117223908.415965-1-peterx@redhat.com>

[PATCH 0/4] tests/migration-test: Introduce mem_type
https://lore.kernel.org/r/20251117223908.415965-1-peterx@redhat.com

v2 changelog:
- Linux-header update patch dropped because a similar version has landed
- Replaced old patch 2 with a similar but better one from Xiaoyao Li
- Target this series for QEMU 11.0 (hence, update in qapi/ "Since:")
- Added a qtest covering guest-memfd boot and basic precopy migration
- Fix checkpatch issues

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

Peter Xu (8):
  kvm: Detect guest-memfd flags supported
  memory: Rename RAM_GUEST_MEMFD to RAM_GUEST_MEMFD_PRIVATE
  memory: Rename memory_region_has_guest_memfd() to *_private()
  ramblock: Rename guest_memfd to guest_memfd_private
  hostmem: Rename guest_memfd to guest_memfd_private
  hostmem: Support in-place guest memfd to back a VM
  tests/migration-test: Support guest-memfd init shared mem type
  tests/migration-test: Add a precopy test for guest-memfd

Xiaoyao Li (1):
  kvm: Decouple memory attribute check from kvm_guest_memfd_supported

 qapi/qom.json                         |  6 ++-
 include/system/hostmem.h              |  2 +-
 include/system/kvm.h                  |  1 +
 include/system/memory.h               | 17 +++----
 include/system/ram_addr.h             |  2 +-
 include/system/ramblock.h             |  7 ++-
 tests/qtest/migration/framework.h     |  4 ++
 accel/kvm/kvm-all.c                   | 27 ++++++++---
 accel/stubs/kvm-stub.c                |  5 ++
 backends/hostmem-file.c               |  2 +-
 backends/hostmem-memfd.c              | 68 +++++++++++++++++++++++++--
 backends/hostmem-ram.c                |  2 +-
 backends/hostmem-shm.c                |  2 +-
 backends/hostmem.c                    |  2 +-
 system/memory.c                       |  7 +--
 system/physmem.c                      | 37 +++++++++------
 tests/qtest/migration/framework.c     | 60 +++++++++++++++++++++++
 tests/qtest/migration/precopy-tests.c | 12 +++++
 18 files changed, 219 insertions(+), 44 deletions(-)

-- 
2.50.1


