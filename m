Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7705C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 13:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rppPR-0008Ll-0v; Thu, 28 Mar 2024 09:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rppPO-0008LE-6j
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 09:03:06 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rppPL-00085J-JB
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 09:03:05 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-515a86daf09so1149899e87.3
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 06:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711630980; x=1712235780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n58xQeN/GzfLvjM7BrwvwqSKY8ac/mk8J4blUOIGKpg=;
 b=d2bhfNocsmGyoyCwJoXbA//NHQg8v1N84W9MTcnJwiFis4+Q5dVp/piI6dF77ouktn
 kFRTsKvC5QBJ4Mo9toZKWZDG8iM6U5iGja6uPhVCMBiCCno2mRQmgMprjnbPV2ZzVnVX
 /9zTrEC0RHWA4mVZ+ryNxANG7jeKF/uCkX9rp4A1dITx4p/XC1kDBm4+8CtP0PZmD6wf
 GYnSQRWTR36paNxzqJD/ddXxTin9pv33/gSrhfuw0UD4//ApKJfHR01YPDI3y3RCBX34
 XWMrtFf0i7x7XiF+q7yDptFPA+LNML22PXsPJ+PRgmvf6Si0/272mqK/UhKKQfopkgzo
 erfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711630980; x=1712235780;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n58xQeN/GzfLvjM7BrwvwqSKY8ac/mk8J4blUOIGKpg=;
 b=pbNZwcos+zNxxaD/bYi62wmf0MBI8F9bXBgT82Gz2PuKpuPxF0igPdDl/NSxvG81pq
 jFZFEtKbShZ3siwC0bpv8VO2lkQuCfBWHq9ny+sbuDi39nLi1K820hpaHErtC5qM23Sp
 HjZX67Y6kJM8plBzbqIMnPC3puZiuDrDnpNclG1d2oLRmQgzyhHHdoQwgdvm9Vu42P2i
 +0t/yHzmkSp9zcX/qVP9ZFcTQZYyou4TmKoCEph54NRPnrOsOUe8GZrqV/8ptKUBLGIC
 Qz9BIk2+qREXdJBB1DufrSmoRM0yatvgfVR1fj2aI8VWl4wqThEa6UqLxE5jWn3rHQqm
 ARmg==
X-Gm-Message-State: AOJu0YwMfEeazAneFNhf7xdmE/qj0qFWSZnQYxZnDQM5DQWAMkGq8SU2
 G39rQkfoT1bU3Eo3fGWI46jvsdXOznW5gIRTdn7imKZjXTLLw33u4eknkAgAyQgge2eUJ2hIrMP
 k
X-Google-Smtp-Source: AGHT+IETHWgZQkoYEEC7OX5uqGraRTeihrl8QzOlr0IxjzBolA/9gzn9B94PD+6lyACtCDg2FzRLmg==
X-Received: by 2002:a05:6512:2210:b0:515:c7c9:b150 with SMTP id
 h16-20020a056512221000b00515c7c9b150mr1972648lfu.0.1711630979905; 
 Thu, 28 Mar 2024 06:02:59 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 dn21-20020a17090794d500b00a4588098c5esm719964ejc.132.2024.03.28.06.02.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 06:02:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 Peter Xu <peterx@redhat.com>, integration@gluster.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2 0/3] rdma: Remove RDMA subsystem and pvrdma device
Date: Thu, 28 Mar 2024 14:02:52 +0100
Message-ID: <20240328130255.52257-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since v1:
- split in 3 (Thomas)
- justify gluster removal

Philippe Mathieu-Daudé (3):
  hw/rdma: Remove pvrdma device and rdmacm-mux helper
  migration: Remove RDMA protocol handling
  block/gluster: Remove RDMA protocol handling

 MAINTAINERS                                   |   17 -
 docs/about/deprecated.rst                     |    9 -
 docs/about/removed-features.rst               |    4 +
 docs/devel/migration/main.rst                 |    6 -
 docs/pvrdma.txt                               |  345 --
 docs/rdma.txt                                 |  420 --
 docs/system/device-url-syntax.rst.inc         |    4 +-
 docs/system/loongarch/virt.rst                |    2 +-
 docs/system/qemu-block-drivers.rst.inc        |    1 -
 meson.build                                   |   59 -
 qapi/machine.json                             |   17 -
 qapi/migration.json                           |   31 +-
 qapi/qapi-schema.json                         |    1 -
 qapi/rdma.json                                |   38 -
 contrib/rdmacm-mux/rdmacm-mux.h               |   61 -
 hw/rdma/rdma_backend.h                        |  129 -
 hw/rdma/rdma_backend_defs.h                   |   76 -
 hw/rdma/rdma_rm.h                             |   97 -
 hw/rdma/rdma_rm_defs.h                        |  146 -
 hw/rdma/rdma_utils.h                          |   63 -
 hw/rdma/trace.h                               |    1 -
 hw/rdma/vmw/pvrdma.h                          |  144 -
 hw/rdma/vmw/pvrdma_dev_ring.h                 |   46 -
 hw/rdma/vmw/pvrdma_qp_ops.h                   |   28 -
 hw/rdma/vmw/trace.h                           |    1 -
 include/hw/rdma/rdma.h                        |   37 -
 include/monitor/hmp.h                         |    1 -
 .../infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h |  685 ---
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  348 --
 .../standard-headers/rdma/vmw_pvrdma-abi.h    |  310 --
 migration/migration-stats.h                   |    6 +-
 migration/migration.h                         |    9 -
 migration/options.h                           |    2 -
 migration/rdma.h                              |   69 -
 block/gluster.c                               |   39 -
 contrib/rdmacm-mux/main.c                     |  831 ----
 hw/core/machine-qmp-cmds.c                    |   32 -
 hw/rdma/rdma.c                                |   30 -
 hw/rdma/rdma_backend.c                        | 1401 ------
 hw/rdma/rdma_rm.c                             |  812 ----
 hw/rdma/rdma_utils.c                          |  126 -
 hw/rdma/vmw/pvrdma_cmd.c                      |  815 ----
 hw/rdma/vmw/pvrdma_dev_ring.c                 |  141 -
 hw/rdma/vmw/pvrdma_main.c                     |  735 ---
 hw/rdma/vmw/pvrdma_qp_ops.c                   |  298 --
 migration/migration-stats.c                   |    5 +-
 migration/migration.c                         |   31 -
 migration/options.c                           |   16 -
 migration/qemu-file.c                         |    1 -
 migration/ram.c                               |   86 +-
 migration/rdma.c                              | 4184 -----------------
 migration/savevm.c                            |    2 +-
 monitor/qmp-cmds.c                            |    1 -
 Kconfig.host                                  |    3 -
 contrib/rdmacm-mux/meson.build                |    7 -
 hmp-commands-info.hx                          |   13 -
 hw/Kconfig                                    |    1 -
 hw/meson.build                                |    1 -
 hw/rdma/Kconfig                               |    3 -
 hw/rdma/meson.build                           |   12 -
 hw/rdma/trace-events                          |   31 -
 hw/rdma/vmw/trace-events                      |   17 -
 meson_options.txt                             |    4 -
 migration/meson.build                         |    1 -
 migration/trace-events                        |   68 +-
 qapi/meson.build                              |    1 -
 qemu-options.hx                               |    6 -
 .../org.centos/stream/8/build-environment.yml |    1 -
 .../ci/org.centos/stream/8/x86_64/configure   |    3 -
 scripts/ci/setup/build-environment.yml        |    4 -
 scripts/coverity-scan/run-coverity-scan       |    2 +-
 scripts/meson-buildoptions.sh                 |    6 -
 scripts/update-linux-headers.sh               |   27 -
 tests/lcitool/projects/qemu.yml               |    3 -
 tests/migration/guestperf/engine.py           |    4 +-
 75 files changed, 20 insertions(+), 12997 deletions(-)
 delete mode 100644 docs/pvrdma.txt
 delete mode 100644 docs/rdma.txt
 delete mode 100644 qapi/rdma.json
 delete mode 100644 contrib/rdmacm-mux/rdmacm-mux.h
 delete mode 100644 hw/rdma/rdma_backend.h
 delete mode 100644 hw/rdma/rdma_backend_defs.h
 delete mode 100644 hw/rdma/rdma_rm.h
 delete mode 100644 hw/rdma/rdma_rm_defs.h
 delete mode 100644 hw/rdma/rdma_utils.h
 delete mode 100644 hw/rdma/trace.h
 delete mode 100644 hw/rdma/vmw/pvrdma.h
 delete mode 100644 hw/rdma/vmw/pvrdma_dev_ring.h
 delete mode 100644 hw/rdma/vmw/pvrdma_qp_ops.h
 delete mode 100644 hw/rdma/vmw/trace.h
 delete mode 100644 include/hw/rdma/rdma.h
 delete mode 100644 include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h
 delete mode 100644 include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h
 delete mode 100644 include/standard-headers/rdma/vmw_pvrdma-abi.h
 delete mode 100644 migration/rdma.h
 delete mode 100644 contrib/rdmacm-mux/main.c
 delete mode 100644 hw/rdma/rdma.c
 delete mode 100644 hw/rdma/rdma_backend.c
 delete mode 100644 hw/rdma/rdma_rm.c
 delete mode 100644 hw/rdma/rdma_utils.c
 delete mode 100644 hw/rdma/vmw/pvrdma_cmd.c
 delete mode 100644 hw/rdma/vmw/pvrdma_dev_ring.c
 delete mode 100644 hw/rdma/vmw/pvrdma_main.c
 delete mode 100644 hw/rdma/vmw/pvrdma_qp_ops.c
 delete mode 100644 migration/rdma.c
 delete mode 100644 contrib/rdmacm-mux/meson.build
 delete mode 100644 hw/rdma/Kconfig
 delete mode 100644 hw/rdma/meson.build
 delete mode 100644 hw/rdma/trace-events
 delete mode 100644 hw/rdma/vmw/trace-events

-- 
2.41.0


