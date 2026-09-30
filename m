Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989E7CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBw0J-0002TG-Of; Wed, 30 Sep 2026 11:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0G-0002Sg-93
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:13:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0D-0000gI-C6
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790781227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6DEtQueVTL9GRePCjHNXzB2G5NhDX+jqoyarvqYJo4s=;
 b=F9YZlU9avY/O6yaBlsZ3RIuRsykJdiLuu2xm1MGsExQqAXxTZdw6XaWRXGRQGOVIowZ/KU
 6szW4+bplERgYyhiFVGXcXIxmnt8GRYV43xngDie+N184VoQapGRW63RXQ0Ex/8rX0Dr9N
 o+ZyjPzrFi/RyOMZ5gbYaQ3XVyr77rg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-m0yWPftgPiqWnkl9gXHZmA-1; Wed, 30 Sep 2026 11:13:44 -0400
X-MC-Unique: m0yWPftgPiqWnkl9gXHZmA-1
X-Mimecast-MFC-AGG-ID: m0yWPftgPiqWnkl9gXHZmA_1790781222
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-530f65ddee1so124343161cf.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 08:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790781222; x=1791386022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6DEtQueVTL9GRePCjHNXzB2G5NhDX+jqoyarvqYJo4s=;
 b=XmGqIE7BtIqRfn3wTtAdHGCAChLUHqwGUvSZMkY8tLgOoO2KKwJ5PuuwcotHPpIHQx
 m07sSndf16h8R4mIihz2fswQTScgUQz4dawK8HPCjn/9zIXuOkiaMvkcDK9EcAC/baJT
 1GOOTjAh58yPOFPHx43HFLItt/Z65TTTWNtIYGsjiKEDEnu49UrG3XDPCB9f2oDDGuxq
 3/DX0/Xz4m2aflBTEluUp1qChDFGB5Lzd9Jku3loEGcNa4Na37rd7hnVIoFzszYu01M1
 eF8vgWjX9+gu/xRwugCmv3VduDiSJpC1TZc9XzvxTJ/KHd6XOejOyHOkeIJwjOW/VtcB
 jURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790781222; x=1791386022;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6DEtQueVTL9GRePCjHNXzB2G5NhDX+jqoyarvqYJo4s=;
 b=fq3K+2dhr6WrtO5n1MajF1u4YehB9DwLsWjH7hF7xVfFYIEMe7O4g7vcrU6LTdSlOV
 5JFUacUMizPP+S3sBjvYVmxWeCvEVBINtO0AHb+qp+/ty3DQW7IEVrNEoDQ2Vem5KvC2
 ovptipZFBXl/3uSn4C0OhkM8W6zN5f3SnvMxxaVUT531SwapYwecMyr1DjYnK5LMuu3W
 K+nHbeDoa1u6JWz22wHPgE80jcmzwq+kFRoz+tjU+K1liewsDPCRzYgN7aJK39ZZgfgB
 d2+QpJLa8RgXysSLmxASBcJwZlPpdQaQb63teVSq9WFKhiJCygyDgAp9cD3sFxV/Be4f
 gBNw==
X-Gm-Message-State: AFuF++n/hDOE/WJELZBlB46s8D48MptLkQ+uN50RFW2wkHdjUNyyLxU5
 ebFE1rn/VztuJX0FJNzCW260xJN/CL9Wh011pHByigtzi+77aq8qLrYK3fHaO8zCuwWm5kMkXqG
 NfxIX1i0pJKM4gy7tkIXUjWGObsxzSnG1u2/vsbIGJBdoAAYyi9G+gcKHdrW3TCA74fHQp08phl
 9iAV4LrcB0MzpUhB1KJIw25TuvqF+gwbBHw0UeaWMg
X-Gm-Gg: AYBFou0oAUzdbjfxJ2nDLr4uVsWsb5L+i1+/5tpCGXmepr5JYo9/Rd0+DEW1viqF9hP
 alo9HoFDfQEPsjSIjT5hFQw9KMst+MP8Xg6G0Uf/8JAYWrB+BLDP3+8L5DzDbS2yEdBpGgATjH2
 O/jF7u+UkkQjvJh6L2oK9fBxR9xmmNm9I+OA0FmyZnKxFq+DYCu8VKPLblA7BMPkT2IlufgeVkJ
 tKjwug02MROPYOjTZunGeVT2j3VgXAP4wq8j4JeA1cJ5H5mYcwcAIYNp1F7njizZK3dSssgbyqj
 ft7mwYrDlM9vKfIQbp2F4PpucwTZRri40n9Jv1JA6khxW/aZSq63dri1H1dIyptVeD4gdMw=
X-Received: by 2002:a05:622a:2605:b0:532:c057:9564 with SMTP id
 d75a77b69052e-5337454c980mr35662111cf.23.1790781222095; 
 Wed, 30 Sep 2026 08:13:42 -0700 (PDT)
X-Received: by 2002:a05:622a:2605:b0:532:c057:9564 with SMTP id
 d75a77b69052e-5337454c980mr35661351cf.23.1790781221455; 
 Wed, 30 Sep 2026 08:13:41 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-533824da256sm1372361cf.21.2026.09.30.08.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:13:40 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 00/12] Next patches
Date: Wed, 30 Sep 2026 11:13:28 -0400
Message-ID: <20260930151340.2817042-1-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 9c88811b81a935a172c5c873b2ada2d9b38a5f74:

  Merge tag 'pull-target-arm-20260929' of https://gitlab.com/pm215/qemu into staging (2026-09-30 06:25:37 +0100)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/next-pull-request

for you to fetch changes up to 8ada579a562873780bfcce7795b9cd0bb0f9bca3:

  tests/migration-test: Add a precopy test for guest-memfd (2026-09-30 08:51:04 -0400)

----------------------------------------------------------------
Mem pull

- Michael's series to support kvm guest-memfd init-shared

----------------------------------------------------------------

Peter Xu (11):
  kvm: Detect guest-memfd flags supported
  kvm: Provide explicit error for kvm_create_guest_memfd()
  ramblock: Rename guest_memfd to guest_memfd_private
  memory: Rename RAM_GUEST_MEMFD to RAM_GUEST_MEMFD_PRIVATE
  memory: Rename memory_region_has_guest_memfd() to *_private()
  hostmem: Rename guest_memfd to guest_memfd_private
  machine: Rename machine_require_guest_memfd() to *_private()
  memory: Rename memory_region_init_ram_guest_memfd() to *_private()
  hostmem: Support fully shared guest memfd to back a VM
  tests/migration-test: Support guest-memfd init shared mem type
  tests/migration-test: Add a precopy test for guest-memfd

Xiaoyao Li (1):
  kvm: Decouple memory attribute check from kvm_guest_memfd_supported

 docs/system/confidential-guest-support.rst |  2 +
 docs/system/guest-memfd.rst                | 60 +++++++++++++++++++
 docs/system/index.rst                      |  1 +
 qapi/qom.json                              | 15 ++++-
 include/hw/core/boards.h                   |  2 +-
 include/system/hostmem.h                   |  2 +-
 include/system/kvm.h                       |  1 +
 include/system/memory.h                    | 27 +++++----
 include/system/ramblock.h                  |  9 ++-
 tests/qtest/migration/framework.h          |  4 ++
 accel/kvm/kvm-all.c                        | 37 ++++++++++--
 accel/stubs/kvm-stub.c                     |  6 ++
 backends/hostmem-file.c                    |  2 +-
 backends/hostmem-memfd.c                   | 69 ++++++++++++++++++++--
 backends/hostmem-ram.c                     |  2 +-
 backends/hostmem-shm.c                     |  2 +-
 backends/hostmem.c                         |  2 +-
 backends/igvm.c                            |  4 +-
 hw/core/machine.c                          |  2 +-
 hw/i386/pc.c                               |  6 +-
 hw/i386/pc_sysfw.c                         |  8 +--
 hw/i386/x86-common.c                       |  8 +--
 system/memory.c                            | 14 +++--
 system/physmem.c                           | 52 +++++++++-------
 target/i386/kvm/kvm.c                      |  3 +-
 tests/qtest/migration/framework.c          | 60 +++++++++++++++++++
 tests/qtest/migration/precopy-tests.c      |  9 +++
 27 files changed, 333 insertions(+), 76 deletions(-)
 create mode 100644 docs/system/guest-memfd.rst

-- 
2.55.0


