Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8A7CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 17:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v412k-0001hW-Ui; Wed, 01 Oct 2025 13:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v412f-0001bw-Ek
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:55:05 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v412a-0000lq-DW
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:55:04 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so1074605e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759341291; x=1759946091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MnPdbQAPiABKPnqv3H2yK8f0ztbp+cDIPhAAjXtVdbI=;
 b=DXsk6k0iKF6mJGj1zqThbJf0HFsi9yIxbXOO//AbFhdXhkm/TTgyXiziLQt+0VlpE8
 rUAbO4SaLCeb5b4YxrJ6PLJhsoFlt0Ck0EyZiGqkiderreM0r/P/BaCsCKvNziP+VSdG
 FqrXVYcC61sV2VfX01+hMQ+9zVK5qKfJj+s9/MWFo/YFVNLpcC2W3k5tYcoxeqZU30rI
 yvEzyd2QB3srB053x1Rfiqjx4o/+OEqm17/nNKC0pmq3hHPN8lJmqfSfiDew2mYqBq83
 pDytc/VqQ7g/27NBv4itzI+uQlg9B9+AX+uP/JA/lxQ5NnjAPEse3tUXpQmf4cFbJERO
 72eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759341291; x=1759946091;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MnPdbQAPiABKPnqv3H2yK8f0ztbp+cDIPhAAjXtVdbI=;
 b=qnwaKp42GycmOdFlRZzkWEhRvdNAN3knNehuwjf9gPPKC4XpzteBRHYjbUkvhJsJ2a
 8NOrzNwsFYtk/BOCexKz2BCp0LMv29U1znjwRWU4o/KkHR+dnPrdSdntVr7sA8C6DIt7
 KS5Rhly0N6iX368tV1POOPPKeHJetoAddYCwZMg+PU+Eb06yyFxyOeiD4tQgHWTOGLPZ
 xd8Jx9dfCjexMevnEr4s5+Uo8AWd/eiYT5t8kMV7mxO1b8GRs1IVYOkEK7F1wraZYckG
 +PWa09quaQ3UwFfR3ISpkbh0I209xJ9It3+vYkq+20A5IzsPQnp6YrkV9edTKUKV4sp9
 HxxA==
X-Gm-Message-State: AOJu0Yw9+s2QExuwrekrjfd3oJY5LweA3Ov5rScnJPb/4LhB6jjw2Lbd
 5VQxcGBgW1lSnM1UZzxrRn4CzGT35RS3TiNItor7yrzMO/J3vwH4dSQEWuZkx6bJlNEGBlzA5j2
 rJcZtZPTQaJga
X-Gm-Gg: ASbGncso5iuF3Q+qDXFbGFNsEIcT8mblnF4eNAqAqnRNgB9wMhj0bXNw/SCJXxeaAVS
 gd4Chrvi8RXdT+opdReCAmpBwP0Ou015xz8NGKoA1SK+p/bZhzEF+I0JcReRjZvrk/15y/TsxKe
 OCBEm0Z3uWPnw9fVT7y3bmalQrLN1hv8UEPT7d9eVGfiQitLrgRBTQpntg7GrFzONrwAP41m3KQ
 db8rz0Y4My0Eqzy5Kg9yKeYCJaCwpoA0qZhnVCkxoLbQxnlPFIoMnpx+oFiHut4t2QgK32Wu0V/
 mnIY6hwNChX/3ethQDc/tlA6lFnEcpx+g+JqznyC8tEVAErgcgmGNAs8QlcQ9bUy1ZYyakaxG48
 HXfS9uj4XL218do8TgpYQflAI56Y4cM8Stv1v9WSIbMcUtDyXDGNxVu1Jj61YK9I1iyj8bm4QEA
 MsELqgQXUcz4ObUx/b+VwnbvCAeQ==
X-Google-Smtp-Source: AGHT+IEY+a8HI+AAlq63W8TJ12+BAD5/mJQ/zQWjsLUB6yTTngVUWSOFC3iLDhJTDi6PvB23sT2xjw==
X-Received: by 2002:a05:600c:468f:b0:46e:447d:858e with SMTP id
 5b1f17b1804b1-46e612dce3dmr39375945e9.28.1759341291132; 
 Wed, 01 Oct 2025 10:54:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e675b557fsm23898265e9.0.2025.10.01.10.54.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 10:54:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jason Herne <jjherne@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Farman <farman@linux.ibm.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 00/18] system/physmem: Extract API out of
 'system/ram_addr.h' header
Date: Wed,  1 Oct 2025 19:54:29 +0200
Message-ID: <20251001175448.18933-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Missing review: #12 (new)

Since v2:
- Dropped few patches
- Do not rename @start -> @addr (rth)

Following a previous comment from Richard in [*],
reduce "system/ram_addr.h" size by un-inlining a
lot of huge functions that aren't really justified,
and extract the API to the hew "system/physmem.h"
header, after renaming the functions (removing the
confusing 'cpu_' prefix).

(I plan to eventually merge this myself due to the
likelyness of conflicts).

[*] https://lore.kernel.org/qemu-devel/9151205a-13d3-401e-b403-f9195cdb1a45@linaro.org/

Philippe Mathieu-Daudé (18):
  system/ram_addr: Remove unnecessary 'exec/cpu-common.h' header
  accel/kvm: Include missing 'exec/target_page.h' header
  hw/s390x/s390-stattrib: Include missing 'exec/target_page.h' header
  hw/vfio/listener: Include missing 'exec/target_page.h' header
  target/arm/tcg/mte: Include missing 'exec/target_page.h' header
  hw: Remove unnecessary 'system/ram_addr.h' header
  system/physmem: Un-inline cpu_physical_memory_get_dirty_flag()
  system/physmem: Un-inline cpu_physical_memory_is_clean()
  system/physmem: Un-inline cpu_physical_memory_range_includes_clean()
  system/physmem: Un-inline cpu_physical_memory_set_dirty_flag()
  system/physmem: Un-inline cpu_physical_memory_set_dirty_range()
  system/physmem: Remove _WIN32 #ifdef'ry
  system/physmem: Un-inline cpu_physical_memory_set_dirty_lebitmap()
  system/physmem: Un-inline cpu_physical_memory_dirty_bits_cleared()
  system/physmem: Reduce cpu_physical_memory_clear_dirty_range() scope
  system/physmem: Reduce cpu_physical_memory_sync_dirty_bitmap() scope
  system/physmem: Drop 'cpu_' prefix in Physical Memory API
  system/physmem: Extract API out of 'system/ram_addr.h' header

 MAINTAINERS                       |   1 +
 include/system/physmem.h          |  54 ++++
 include/system/ram_addr.h         | 413 ------------------------------
 accel/kvm/kvm-all.c               |   5 +-
 accel/tcg/cputlb.c                |  13 +-
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
 migration/ram.c                   |  78 +++++-
 system/memory.c                   |   9 +-
 system/physmem.c                  | 322 ++++++++++++++++++++++-
 target/arm/tcg/mte_helper.c       |   5 +-
 system/memory_ldst.c.inc          |   2 +-
 tests/tsan/ignore.tsan            |   4 +-
 24 files changed, 475 insertions(+), 460 deletions(-)
 create mode 100644 include/system/physmem.h

-- 
2.51.0


