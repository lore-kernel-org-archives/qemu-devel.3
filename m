Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FA6CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3s64-0000X6-Ud; Wed, 01 Oct 2025 04:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s62-0000WN-TC
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:21:58 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s5l-0005E9-QD
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:21:58 -0400
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-3f0308469a4so3883486f8f.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759306890; x=1759911690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UYQLfS3wHinTh/qC50pdHFAAD2+v7Vtk7mze5MUxp5E=;
 b=m8DBcgSqy5iKPr0jgb08yr1FAKc89RUTK2Se0PZI/BgV7swMhx36gscid2tE5E2BJ3
 /Q4GHI7Csc69lmt2My4dY9helUQ81MqZp3CGimyPyTL6BHjsheWPtCGLnWTnTddzhpgZ
 ODGHNgicG0mEXe8iTYf2vLM1IAUBBNNMq5T7JEcLqNXJM8aFempU/wgOwk5hrRvpTJew
 azfHRJkgPEIxydhTW9Plov2FY9OX+5WpMsaiMfLkLaoWABMgJaevDld8RbNp05PKbTAs
 e18eGdKQunAx0eQuLMmHNGBYtmTRXAQ4O9MC2hABtb9BVvlcEwe/dqcem5nKiLem97bA
 UOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759306890; x=1759911690;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UYQLfS3wHinTh/qC50pdHFAAD2+v7Vtk7mze5MUxp5E=;
 b=nDO006wcF/cHfWGn9kuZAXJH2wQg1DPQTJ5HrSaP2RF0pfTSXwi+A0WXFmc8ykKUbG
 yZhT6TFJVmrn+/aCU3eplXV4DKevM/vtkEme4W7JivASOgdd57v0m8QlCtcyBRNpJlJ2
 1/M769nnc5V8Ek3RBdk0iKcBhxUfOxU7DaPBjrgM7N2ILq41DswFIyGsIxxHmsAufXvF
 gjuwleGCEe9jKiEMgtWzfI4dkywT33gTWplQusYX20rSDoV6zhP4GXETz2vn/5c2wI9u
 Y4znyfJVRHg7Zdd31OA2VJMzxZ6UhUZtzpewpum1caX2WbKWdzDUSCiJucjZzmhyLl9M
 ANbg==
X-Gm-Message-State: AOJu0Ywrlf5KdtNPHAlmepDKlcEQmhyLPB/FRpTldybhaOp3mDYccpxT
 Pabwc3pN76kljYm419kJZ5h/cGd9VXD1nNdwupz2tPMhLV6yi2AD0kFWt5BHusozce7Kb6du10R
 t9dyBsrzjALWX
X-Gm-Gg: ASbGncun3W0J6Y4G3ExijxcU7vxPL7qY487PTV1o/mFrxRmrxdbNeZW+iw0DRzy1YNq
 kTWp5Hv+7sumSiO6iWmuaoqrRypwZk42eJNI3g4NxUDxJews/wz4Z6JitQvBUsusN9vAygO270x
 jlbRHU6MoPtQbs90JyUfDlY2QQW3hBoBZug9VDP3MNmOPeQYl3CIgLS+ZZZlBDXgcNNcDG/xVAT
 oTbyF5VkJTx1U9mEe/BDKprQZBaZUqhDleB8T+rLix107OiPMfzoFxZ9kPYZQiMyJslowZq3GJs
 gbrgdtehqYKFHjxkUclxYaAImYlWfu1E1OT9jfZblhp9wjKALi5jP735/0mMW65eivFYga+qs/b
 +VkF9vHhk0PNlenCOmUoK4rbP99RVu4tk5m9FfyWSNUZQhhP1qd7K1AclrjfXhrR8I5Ubz94czL
 6ww0g2znvayOyNxEjJNhAy
X-Google-Smtp-Source: AGHT+IHKt/ivTsoC6PZcZTjZzL5LDs95xiGR88ZSKusdRALPX64xSrvTFt9lt4nGAnJGd8G2pFxftQ==
X-Received: by 2002:a05:6000:310d:b0:3ee:af89:a68 with SMTP id
 ffacd0b85a97d-425577f321dmr1791557f8f.22.1759306889640; 
 Wed, 01 Oct 2025 01:21:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc8aa0078sm25842872f8f.59.2025.10.01.01.21.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 01:21:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-arm@nongnu.org,
 Jagannathan Raman <jag.raman@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 00/25] system/physmem: Extract API out of 'system/ram_addr.h'
 header
Date: Wed,  1 Oct 2025 10:21:00 +0200
Message-ID: <20251001082127.65741-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Following a previous comment from Richard in [*],
reduce "system/ram_addr.h" size by un-inlining a
lot of huge functions that aren't really justified,
and extract the API to the hew "system/physmem.h"
header, after renaming the functions (removing the
confusing 'cpu_' prefix).

(I plan to eventually merge this myself due to the
likelyness of conflicts).

[*] https://lore.kernel.org/qemu-devel/9151205a-13d3-401e-b403-f9195cdb1a45@linaro.org/

Philippe Mathieu-Daudé (25):
  system/ram_addr: Remove unnecessary 'exec/cpu-common.h' header
  accel/kvm: Include missing 'exec/target_page.h' header
  hw/s390x/s390-stattrib: Include missing 'exec/target_page.h' header
  hw/vfio/listener: Include missing 'exec/target_page.h' header
  target/arm/tcg/mte: Include missing 'exec/target_page.h' header
  hw: Remove unnecessary 'system/ram_addr.h' header
  accel/tcg: Document rcu_read_lock is held when calling
    tlb_reset_dirty()
  accel/tcg: Rename @start argument of tlb_reset_dirty*()
  system/physmem: Rename @start argument of physical_memory_get_dirty()
  system/physmem: Un-inline cpu_physical_memory_get_dirty_flag()
  system/physmem: Un-inline cpu_physical_memory_is_clean()
  system/physmem: Rename @start argument of physical_memory_all_dirty()
  system/physmem: Rename @start argument of physical_memory_range*()
  system/physmem: Un-inline cpu_physical_memory_range_includes_clean()
  system/physmem: Un-inline cpu_physical_memory_set_dirty_flag()
  system/physmem: Rename @start argument of physical_memory_*range()
  system/physmem: Un-inline cpu_physical_memory_set_dirty_range()
  system/physmem: Un-inline cpu_physical_memory_set_dirty_lebitmap()
  system/physmem: Rename @start argument of physmem_dirty_bits_cleared()
  system/physmem: Un-inline cpu_physical_memory_dirty_bits_cleared()
  system/physmem: Rename @start argument of
    physmem_test_and_clear_dirty()
  system/physmem: Reduce cpu_physical_memory_clear_dirty_range() scope
  system/physmem: Reduce cpu_physical_memory_sync_dirty_bitmap() scope
  system/physmem: Drop 'cpu_' prefix in Physical Memory API
  system/physmem: Extract API out of 'system/ram_addr.h' header

 MAINTAINERS                       |   1 +
 include/exec/cputlb.h             |   5 +-
 include/system/physmem.h          |  56 ++++
 include/system/ram_addr.h         | 413 ------------------------------
 accel/kvm/kvm-all.c               |   5 +-
 accel/tcg/cputlb.c                |  19 +-
 hw/ppc/spapr.c                    |   1 -
 hw/ppc/spapr_caps.c               |   1 -
 hw/ppc/spapr_pci.c                |   1 -
 hw/remote/memory.c                |   1 -
 hw/remote/proxy-memory-listener.c |   1 -
 hw/s390x/s390-stattrib-kvm.c      |   2 +-
 hw/s390x/s390-stattrib.c          |   2 +-
 hw/s390x/s390-virtio-ccw.c        |   1 -
 hw/vfio/container-legacy.c        |  10 +-
 hw/vfio/container.c               |   5 +-
 hw/vfio/listener.c                |   2 +-
 hw/vfio/spapr.c                   |   1 -
 hw/virtio/virtio-mem.c            |   1 -
 migration/ram.c                   |  79 +++++-
 system/memory.c                   |   9 +-
 system/physmem.c                  | 342 +++++++++++++++++++++++--
 target/arm/tcg/mte_helper.c       |   5 +-
 system/memory_ldst.c.inc          |   2 +-
 tests/tsan/ignore.tsan            |   4 +-
 25 files changed, 495 insertions(+), 474 deletions(-)
 create mode 100644 include/system/physmem.h

-- 
2.51.0


