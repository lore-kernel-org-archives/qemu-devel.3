Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B2CCD37BE
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 17:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM8J5-0000LO-Vb; Sun, 10 May 2026 13:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wM8J2-0000Ju-ES
 for qemu-devel@nongnu.org; Sun, 10 May 2026 13:51:08 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wM8Iy-0001hN-SH
 for qemu-devel@nongnu.org; Sun, 10 May 2026 13:51:08 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so34993655e9.2
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 10:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778435462; x=1779040262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/v7wQeFI5NHR314AC4XvVaa4v6m4FST8/h6ygyTOiwE=;
 b=ckB5o0+qgK7UWeIqUCCWfeO2VS+xHKcvlbZGi0kDR8iaClRqqLqTRObs1u/g8YSf+6
 8JvVY3Ws2KGhMqr1jKPdzRR8Qn1hQniAsNV1wKq8fxgRmiToIFpogluXJ3yOW/OK3gGo
 8BznssimjFbSjTdA/rYKyrcjI1uJFAhrPYDmAfDfqTD+B/RrXL7YdvVYfaKGYfi/hdtS
 yurZxOiE53wyUoGYYCU+YX2ivxPlcUVeKndv9XlVYmG/cacJZ+CnzfFkXM/yP5CIzfpf
 DVZ9RgOmWUlYfH/tkA5b/kBJKWPdvFi9K8kwUCdq5OCHN4ZxAxMakzeGk5RUzkw6f/t6
 l0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778435462; x=1779040262;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/v7wQeFI5NHR314AC4XvVaa4v6m4FST8/h6ygyTOiwE=;
 b=eTwWPfZ05hVa/whRNFomHeeTJOzMvhsyN/W7UCZECdCo0AIQbyUqAY7Q2bRi29VrcV
 gXLaUoak9J/03h6t+CR5QmV5p5demK2gtF9cjXR4dFiU28yi/BhbceTB2s3a6DL5r6qM
 02Bw4gmgZu56FSkDntvfUG+T8xUbfaV2JwqB/kvfyFZ5Yt4m9hUz8EiPymRz8QlE9OH8
 UkdjpzzfqyiAmt0coReCoZb64gRKsZj+73T4+pUgRcCPaKfZn2HkMXF60ISY6FlRh3Qx
 2D8sKSNsRGtt8ZkE+0SALmhM2WVJgunqMiV6u7wWCGvLMX7Sf1bk6nn4pEuajRisuOZ5
 P8DQ==
X-Gm-Message-State: AOJu0Yz6Mi46x2r3d/GPVwpVIrRdv0TNUCAc9dS9dryPOsx1+ckZ4ZOU
 xe57M1h4u265bwCJ/lTpmv4k1zAoAMmJdQK8vQPOQigr6JoCcz5J1ZCymFW8Hw==
X-Gm-Gg: Acq92OEgLkI0zQJXvm7J3VsofgUdHut8HE9AiAvvQrhmAUH49UbLJRaJE1L483h+gLS
 Oun7P3A3TSQqI5J1rOjXL3sWEnwD7/MmXDWsqSBvPuXc8nmqFfx5cit1QZAHKM3rkrQ9E2BlN+x
 abAfz+VHZCqdsL0If6+Fqq9+HR/Wy0dQEyVELFyfNMHBRsTMbBusQu7c+GCfHN/qQfe6yCc/3VN
 nSB3I+uCyzUbb0JvOhdlSUEWruiVhp5PzdUe/h7K1sv9R0XJJQoAaN7chrkTuCadyej58TjZZb1
 wZuklUeyLGvglau/IbJ4B5yxrtMHctVxrwaAk7+3gWw6ikwwtDJJuli4u06bVFNDanYruZ9cx6T
 56BDK/yMzfnvDIA+GzoEkpE2Go9mpD7WDhak0CBE7CqTKQpYak8hGKULDLUM1VlyMkM0Z2H5Ra7
 pBiS3x7tXhLXl55zeCaJEFfK3rIQI/QI8LvViVAl33yHVhG6rXC1h3
X-Received: by 2002:a05:600c:a117:b0:485:2a85:e5ec with SMTP id
 5b1f17b1804b1-48e6748a677mr131339035e9.2.1778435461547; 
 Sun, 10 May 2026 10:51:01 -0700 (PDT)
Received: from groves.. ([95.90.240.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e702e0bf2sm225215565e9.4.2026.05.10.10.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 10:51:01 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 dmitry.fomichev@wdc.com, Kevin Wolf <kwolf@redhat.com>, cassel@kernel.org,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 dlemoal@kernel.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, hare@suse.de,
 Hanna Reitz <hreitz@redhat.com>, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v10 0/4] Add full zoned storage emulation to qcow2 driver
Date: Sun, 10 May 2026 19:50:55 +0200
Message-ID: <20260510175059.311814-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=faithilikerun@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patch series add a new extension - zoned format - to the
qcow2 driver thereby allowing full zoned storage emulation on
the qcow2 img file. Users can attach such a qcow2 file to the
guest as a zoned device.

Write pointer are preserved in the zoned metadata. It will be
recovered after power cycle. Meanwhile, any open (implicit or
explicit) zone will show up as closed.

Zone states are in memory. Read-only and offline states are
device-internal events, which are not considerred in qcow2
emulation for simplicity. The other zone states
(closed, empty, full) can be inferred from write poiner
values, presistent across QEMU reboots. The open states are
kept in memory using open zone lists.

To create a qcow2 file with zoned format, use command like this:

Then add it to the QEMU command line:
    -blockdev node-name=drive1,driver=qcow2,file.driver=file,file.filename=../qemu/test.qcow2 \
    -device virtio-blk-pci,drive=drive1 \

v9->v10:
- add cross-boundary constraint for merging writes on zoned devices
- extract call from assert() to fix image creation crash

v8->v9:
- fix compilation err after modifying types

v7->v8:
- sets default values for zoned img confurations [Markus, Damien]
- changes the type of zone_size, zone_capacity from uint32_t to uint64_t [Stefan]
- fix docs [Stefan]
- modify append writes to increase concurrency [Damien, Stefan]
- use tailqueue to track active zones [Stefan]
- fix undefined behavior of ranges_overlap()
- fix the iotest of case 2(1)

v6->v7:
- modify zone resource managemant (style) [Damien]
- fix accessing list with negative index err
- add some tests for zrm in iotests
- address review comments [Markus]

v5->v6:
- fix docs and specs [Eric, Markus, Stefan]
- add general sanity checks for zoned device configurations while creation and opening [Eric]
- fix LRU when implicitly open a zone for a long time [Stefan]

v4->v5:
- add incompatible bit for zoned format [Eric]
- fix and manage zone resources via LRU [Damien]
- renaming functions and fields, spec changes [Markus, Damien]
- add closed zone list
- make qemu iotests for zoned device consecutive [Stefan]

v3->v4:
- use QLIST for implicit, explicit open zones management [Stefan]
- keep zone states in memory and drop state bits in wp metadata structure [Damien, Stefan]
- change zone resource management and iotests accordingly
- add tracing for number of implicit zones
- address review comments [Stefan, Markus]:
  * documentation, config, style

v2->v3:
- drop zoned_profile option [Klaus]
- reformat doc comments of qcow2 [Markus]
- add input validation and checks for zoned information [Stefan]
- code style: format, comments, documentation, naming [Stefan]
- add tracing function for wp tracking [Stefan]
- reconstruct io path in check_zone_resources [Stefan]

v1->v2:
- add more tests to qemu-io zoned commands
- make zone append change state to full when wp reaches end
- add documentation to qcow2 zoned extension header
- address review comments (Stefan):
  * fix zoned_mata allocation size
  * use bitwise or than addition
  * fix wp index overflow and locking
  * cleanups: comments, naming

Sam Li (4):
  docs/qcow2: add the zoned format feature
  qcow2: add configurations for zoned format extension
  qcow2: add zoned emulation capability
  iotests: test the zoned format feature for qcow2 file

 block/file-posix.c                       |    2 +-
 block/qcow2.c                            | 1113 +++++++++++++++++++++-
 block/qcow2.h                            |   39 +-
 block/trace-events                       |    2 +
 docs/interop/qcow2.rst                   |  110 ++-
 docs/system/qemu-block-drivers.rst.inc   |   42 +
 hw/block/virtio-blk.c                    |   22 +-
 include/block/block_int-common.h         |   15 +-
 include/qemu/queue.h                     |    1 +
 include/qemu/range.h                     |    4 +
 qapi/block-core.json                     |   70 +-
 tests/qemu-iotests/tests/zoned-qcow2     |  150 +++
 tests/qemu-iotests/tests/zoned-qcow2.out |  173 ++++
 13 files changed, 1730 insertions(+), 13 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
 create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out

-- 
2.43.0


