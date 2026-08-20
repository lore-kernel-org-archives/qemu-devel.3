Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0CCC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzhj-0006o5-Ns; Thu, 20 Aug 2026 06:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhf-0006mc-LR
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:08:55 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwzhd-0008Ic-1Y
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:08:54 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-47f92e3c14bso1750932f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787220531; x=1787825331; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ECnellqgMAbl6SZxzQGStRCLGwm1ul45YxxJVtjnZwg=;
 b=ii77kPOAK61pFz28ucPfHGj1XU1WF2EITrtOusxTm4f92YDFpa8VP6Y/QShx6YMdVE
 /Y/molAXRSPA9uJTRMKxi0L5+DHtL1Eyau01mfJpwuuU6a2Ib3rRCmabAnYyc4mtlKI2
 oX4qhVr1jY0NS80I6Q8Fzj0opThPbi0TCrgTmABCnH6pPHh0PwuTKRTNq3YQ9Zi7/PVK
 eeN+MW957le4UUiIHJxvJRyKW2au142GgWcCIv7Zrb7nEWeMTB1BjhXv4w9Dsv1p7f0P
 g0yWZ4t4U5TMQauW+EB+HwillPsHQo40GxrkiQTrzRRXnlonWgUWoqIAFyh6WkunWG1h
 WHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220531; x=1787825331;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ECnellqgMAbl6SZxzQGStRCLGwm1ul45YxxJVtjnZwg=;
 b=kkbK3T5nasOrm/riw5lTWv0O9FBEPjD61gZlFLiR1WKoc6pHAhdkurvyOsL9/2sMbO
 7zjCQMIXH2KEARY53Hmd6f7NJgRza4YP5He2TPnALyyEJUWiWpx5E1+0NJs9YHLLeNPe
 fEDSxKCgTYvlg0i1bQVakGc7rldQvVecnHd+dVhLisRko61Uq3cgbH0YwGrwoSnpA5Yb
 cYwaK3IwGnx+L80p+ydEyrBpJWxK9GaVGw1Mjl542Pp2UzN1SPKRC6ha3EDBnbz1j9SA
 MtP0kV1ApA3C4MFPBzjeuu0gdK4kzxXtQOBGWzrXLYYTeSktXCTrAwbP+e6W+IkKYk8S
 1jPA==
X-Gm-Message-State: AFuF++llilpeXmbV3llnepQ9th6dDmI+cIPXOMUkVhbIvZLyRS/9f+5Y
 Dw3x3vFCFxM+hBREa64fsIyBt20TaVnnbCxy7aFTtn/RqfmcTZDSEiLX5kcPyBXI+y1z6e/OucG
 MyHnd
X-Gm-Gg: AR+sD12wNpNshnBfmr4PAk+evqnW8f4JzyrFvmGMMWkN3gZYU0SbTHbP73BfuBRIuIR
 2bkBRnXI8cG9jH4xlkiVs07zDnMsa9vwLlMMvNbPjpx6JbpBOxoqLjozaW1y3iTUco1MWvKVPOQ
 05q0uQMZ7Udz1WItvEibXS9lp3eKsu4BcBblShDNAT0ywEoPN9Bv4scvcdgUlDO9eCImXv8Uv0v
 y6GSXaJh9kquMgB1bAm+2m3FmBSbuIeYkT9WRiDrTTzucSsCTxikca30jgitE8tXPlHANGuju8y
 BNmknZHpEaC7PuTjSUS31KrHo1I23KFiaVdDPa3kuB0DC4n14iaFNzeWjZ8y1qZ0t7GArGt7yed
 4r/6P18w+kx/pcKBMKKLhziDqPoV1UBdEUoixvRkUNp25lejwJlm3lqrUeiL7eI1nkv3/XRlEfs
 lFxfdrs87FO7g5kKxebpjstTxTslk0AjKWx5AbKnJ89eSPhgqQC477haI6tQ==
X-Received: by 2002:a05:6000:70d:b0:482:552f:ef68 with SMTP id
 ffacd0b85a97d-482b1ff5862mr21855803f8f.19.1787220530941; 
 Thu, 20 Aug 2026 03:08:50 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441b0fsm11678929f8f.4.2026.08.20.03.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:08:50 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 00/17] hw/ide: fix the logical CHS translation a guest
 selects
Date: Thu, 20 Aug 2026 12:08:27 +0200
Message-ID: <20260820100844.411717-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=den@openvz.org; helo=mail-wr1-x429.google.com
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

INITIALIZE DEVICE PARAMETERS lets a guest replace the logical CHS
translation that turns the CHS registers into an LBA. cmd_specify() has
implemented it since 176e4961bb33, released in v7.2, and the geometry it
stores is mishandled four ways.

It is not validated: zero sectors per logical track kills QEMU with SIGFPE
in ide_set_sector(), which is issue 2399, and since handle_cmd() takes the
count from a 16 bit field of the register FIS, an AHCI guest can drive
ide_get_sector() into an int overflow as well. It is not reported:
IDENTIFY DEVICE is built once and cached, so both the words describing the
default geometry and the words describing the current one go wrong. It
does not travel, leaving a migrated guest addressing the disk in a
translation the destination does not have. And it does not revert on a
hardware reset, which ATA-5 9.1 requires, so it outlives the reset of the
machine it was selected on.

The two subsections patches 10 and 11 add are the only change to the
migration stream, and both are sent only when the guest replaced the
default geometry. An unaffected guest migrates to an older QEMU as before;
an affected one now fails the load on the unknown subsection instead of
silently addressing the wrong sectors.

Tested with ide-test (25 cases), ahci-test (74), a full make check, a
clang build, and real guests on both controllers: FreeDOS reading a FAT16
disk through INT 13h CHS, Red Hat Linux 9 whose 2.4 IDE driver prints the
geometry it read, and Ubuntu 26.04 over libata, each with a CD and a disk,
plus a machine reset in the middle.

v1:
https://lore.kernel.org/qemu-devel/20260817205242.1199851-1-den@openvz.org/

Changes in v2
-------------

 - patch 1, patch 5: Cc qemu-stable. (Philippe)
 - patch 6: new, the "XXX: retired, remove ?" on IDENTIFY DEVICE words 4,
   5 and 20 is answered rather than carried. ATA-5 3.2.3.6 keeps the
   ATA-1 meaning of a retired word that a device still fills in, so the
   comments name that meaning; word 21 is a buffer size, not a cache
   size. (Philippe)
 - patch 7: new, splits the extraction of ide_identify_chs() out of what
   is now patch 8, leaving that one with the two call sites that keep the
   words in sync. (Philippe)

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Denis V. Lunev (17):
  hw/ide: reject an unsupported CHS translation
  tests/qtest/ide-test: cover a CHS translation with zero sectors
  tests/qtest/libqos/ahci: allow a count and an expected error
  tests/qtest/ahci: cover the sector count of INITIALIZE DEVICE
    PARAMETERS
  hw/ide: report the default CHS translation in IDENTIFY DEVICE
  hw/ide: name the retired IDENTIFY DEVICE words the device fills in
  hw/ide: factor out the IDENTIFY DEVICE current geometry words
  hw/ide: keep the IDENTIFY DEVICE current geometry in sync
  hw/ide: restore the power-on device state before loading
  hw/ide: migrate the logical CHS translation
  hw/ide: migrate the power-on defaults revert flag
  tests/qtest/ide-test: cover the CHS translation across migration
  tests/qtest/ide-test: cover a rejected CHS translation in the stream
  tests/qtest/ide-test: cover the IDENTIFY DEVICE geometry words
  hw/ide: revert the CHS translation on a hardware reset
  tests/qtest/ide-test: cover the CHS translation across resets
  hw/ide: drop a redundant interrupt from INITIALIZE DEVICE PARAMETERS

 hw/ide/ahci.c             |  12 +-
 hw/ide/cmd646.c           |   2 +-
 hw/ide/core.c             | 147 ++++++++---
 hw/ide/ide-internal.h     |   7 +-
 hw/ide/isa.c              |   2 +-
 hw/ide/macio.c            |   2 +-
 hw/ide/mmio.c             |   2 +-
 hw/ide/piix.c             |   2 +-
 hw/ide/sii3112.c          |   6 +-
 hw/ide/via.c              |   2 +-
 tests/qtest/ahci-test.c   |  40 +++
 tests/qtest/ide-test.c    | 499 ++++++++++++++++++++++++++++++++++++++
 tests/qtest/libqos/ahci.c |  14 ++
 tests/qtest/libqos/ahci.h |   6 +
 14 files changed, 690 insertions(+), 53 deletions(-)


base-commit: ae4f3443209ab154b48b706a146e5f557ab147cb
-- 
2.53.0


