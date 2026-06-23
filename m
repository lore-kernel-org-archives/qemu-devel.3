Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07C0CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc6BJ-0003BR-TT; Tue, 23 Jun 2026 14:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wc6Ax-00038W-Az
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:48:50 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wc6Ao-0001sT-17
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 14:48:41 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4627adcf4d6so169492f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782240513; x=1782845313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iwjPBnEanvucx0LKFWUCIgX0npst1/28MxvbIx7YUu4=;
 b=XLVuF5CxeUT4J/cC/ImalZSAMdguc8FIFHWox6/dJ6g1339edCQRFO13IRoF0NS2ih
 iKF2OpLnEXMCTX2m+y2BMQ+f3oef9A3RqTqi8o2UCJ+kc5O6YlFRYtPftZazjk8nICdG
 O35GP48JvW6VYcUeIA6+auKp8QRdB8OnyS0mVL6Ffwp3aTcSW74kfworUnOjxSfmUXhB
 7O7PnKd3HNERXXix0WMlMbihkmrheB8hlDcyrvq58qBOoJxktrL6kAsfbF9dnGYT6/f2
 Se/OgUB8EWLbyd1ttH+SSqv8Cdibnazsum8CdV0dW69TxfP2n9xY/S63NY0mk2ols/4a
 EvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782240513; x=1782845313;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iwjPBnEanvucx0LKFWUCIgX0npst1/28MxvbIx7YUu4=;
 b=mkwmSi7H855Ssn613VpeRk8p71RKz9kGn72gAgKmfHA1vM8QsYQMgv/vphsXLerQzV
 f76LFAsnYlDmgrDydAirY9ebooYL000QVuVBWMfsvTKZJhnHMfaPRiHtJx/ZMS5+vGI/
 zluMKeQxTsFv64cbW3rIC1X2DEjF6vcXwg929hbHk8kSX6hSw0FgwodjqEEoG1d7rZhn
 9Fja6tCUAp2SHep9i8uuDRgJjC/rhYPzFNEXOoX2qYo90hmraKy8IAdDJJLGMyj9We71
 Ql/gW7PLdUe21sWWPWZcAb+9MUvmekWKqmDkpGbybJIbjY6+E5shyLEJbyvYai36GrMz
 NhfA==
X-Gm-Message-State: AOJu0YyhjtxMj4sPhtvEnIT+hnaVZzeNpcrQFEaJpIWqN0cQRujnQ9v/
 hfYocCY5YlaO2VmIkjGaG4uVa1MLMUL+0rlXPAETE8uRza3MB31a7pBQvE9E9w==
X-Gm-Gg: AfdE7clGrWD4Dpl5khW/xXyLa9NhBf2Ij0mdKT88/gQcMeZgAsPyNgv4p3UGtxHkx/X
 VuWN1fporDzxd8Wq9QPuIKQ8SwEYwQRKejOfqXFMWGHJFGxM22lw5GY9XYV6U9cOecy/dfXhLd9
 O1xBaUphSYoDr7nQCfPyuh2bIQCy1hT4yU5SPPo7fl5opL2TVph/G2eGTGHEKvZQ7Fl4iZpcg/q
 sB/ESK15K/cJy4xeNFlCsur/B2tjpPZjVsx/e4zISFNgC6x45ZSFFnWe6Nn6nyA8VpgEeJlOnqz
 E5LthCQXNSvCZw3QejjtxXtsR2b30ZprLc9u0hilvWXEZZDDt2gry5xNKIEJ4tuJDWkeX4Jg/nE
 WsPziiucDk+VqJZbPBqvtzOS3yzTHbFmUjY84JWyda9nUeyswq3SjJrQj/xYPJcB16WnTt9nrPw
 ki71AKa2Faf4HSuRRLm484x20TabJDwW+DUVQuzWM3TpCSpQ==
X-Received: by 2002:a05:6000:4382:b0:461:946f:9bb4 with SMTP id
 ffacd0b85a97d-46c0bd7cb6fmr64008f8f.23.1782240513063; 
 Tue, 23 Jun 2026 11:48:33 -0700 (PDT)
Received: from dobby ([2a02:8109:a394:4800:75bc:d765:f335:35fc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f563dsm34644603f8f.3.2026.06.23.11.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 11:48:32 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, cassel@kernel.org, dlemoal@kernel.org,
 qemu-block@nongnu.org, dmitry.fomichev@wdc.com,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v12 0/5] Add full zoned storage emulation to the qcow2 driver
Date: Tue, 23 Jun 2026 20:48:25 +0200
Message-ID: <20260623184830.373232-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=faithilikerun@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
qcow2 driver, allowing full zoned storage emulation on a qcow2
image file. A user can attach such an image to a guest and have
it appear as a host-managed zoned block device.

The zoned format is opt-in through a new qcow2 header extension
that pins the zone geometry. Behind the extension is a dedicated
zoned metadata region that stores one 8-byte write pointer (WP)
per zone. The extension is gated by an incompatible bit, so an
older qcow2 implementation cannot accidentally open the image.

Each write pointer is routed through the write pointer cache,
a Qcow2Cache object. The write pointer cache is written to disk
after the qcow2 metadata is written, thus guaranteeing that
the write pointer is updated after the corresponding data is
written.

Zone states are in memory. Read-only and offline states are
device-internal events, which are not modelled in qcow2
emulation for simplicity. The other zone states
(closed, empty, full) can be inferred from write poiner
values, presistent across QEMU reboots. The open states are
kept in memory using open zone lists.

To create a qcow2 file with the zoned format:

    qemu-img create -f qcow2 zbc.qcow2 \
        -o size=768M \
        -o zone.size=64M \
        -o zone.capacity=64M \
        -o zone.conventional_zones=0 \
        -o zone.max_append_bytes=4096 \
        -o zone.max_open_zones=6 \
        -o zone.max_active_zones=8 \
        -o zone.mode=host-managed

Then attach it to a guest via the QEMU command line:
    -blockdev node-name=drive1,driver=qcow2,\
              file.driver=file,file.filename=zbc.qcow2 \
    -device virtio-blk-pci,drive=drive1 \

v11->v12:
- validate the zoned header extension before allocating any zoned metadata
- fix the zoned locking discipline: hold the qcow2 state lock (s->lock)
  across all zone-state list updates [Stefan]
- reject, instead of aborting on an assertion, a write that reaches the
  open-zone limit while every open zone is explicitly open
- fix reduced-capacity (zone_capacity < zone_size) handling:
    * transition a zone to FULL when the write pointer reaches the zone
      capacity
    * report the zone capacity, not the zone size, in zone_report
- return -EIO rather than -EINVAL for zone write-rule violations
- use int64_t for the zoned-metadata cluster offset and zone_size to
  avoid truncation on large images
- simplify qcow2_cache_set_dependency() [Stefan]
- virtio-blk: read the zone size through a new blk_get_zone_size() [Stefan]
- docs/QAPI: clarify the max_open_zones / max_active_zones /
  max_append_bytes descriptions; use warn_report() for recoverable zoned
  configuration values in qcow2_check_zone_options() [Niklas, Stefan]
- iotests: add qcow2 check updates (303, qcow2-encryption) [Stefan]
- coding style: function opening braces, DEBUG_EXT format specifier

v10->v11:
- add write ordering through write pointer cache [Stefan]
- add new test cases to iotests for zone append write
- add zoned image info to qemu-img --info
- move virtio-blk cross-zone-boundary merge fix into its own patch [Stefan]
- fix specs and docs:
    * document bit 59 conventional-zone marker in qcow2.rst [Stefan]
    * spell out write ordering for crash consistency [Stefan]
    * QAPI: rephrase comments, bump version [Markus]
- fix review comments [Stefan]

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

Sam Li (5):
  docs/qcow2: add the zoned format feature
  qcow2: add configurations for zoned format extension
  virtio-blk: do not merge writes across a zone boundary
  qcow2: add zoned emulation capability
  iotests: test the zoned format feature for qcow2 file

 block/block-backend.c                         |   11 +
 block/file-posix.c                            |    2 +-
 block/qcow2-cache.c                           |   11 +-
 block/qcow2-refcount.c                        |    7 +
 block/qcow2.c                                 | 1585 ++++++++++++++++-
 block/qcow2.h                                 |   83 +-
 block/trace-events                            |    2 +
 docs/interop/qcow2.rst                        |  120 +-
 docs/system/qemu-block-drivers.rst.inc        |   47 +
 hw/block/virtio-blk.c                         |   22 +-
 include/block/block_int-common.h              |   15 +-
 include/system/block-backend-io.h             |    1 +
 qapi/block-core.json                          |   91 +-
 tests/qemu-iotests/082.out                    |  126 ++
 tests/qemu-iotests/303.out                    |    4 +-
 tests/qemu-iotests/tests/qcow2-encryption.out |    4 +-
 tests/qemu-iotests/tests/zoned-qcow2          |  209 +++
 tests/qemu-iotests/tests/zoned-qcow2.out      |  191 ++
 18 files changed, 2484 insertions(+), 47 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
 create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out

-- 
2.53.0


