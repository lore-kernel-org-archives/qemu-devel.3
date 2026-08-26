Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC198C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBbV-0007o8-V5; Wed, 26 Aug 2026 07:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBbR-0007kE-4P
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:15:33 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBbO-0004Eb-ON
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:15:32 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a17cb94b26so1453038a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787742928; x=1788347728; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZvlcBzbv4P6JHFlvlxuJ9uFIQ4h7jCgOCygmVoGMpsg=;
 b=Q7B5VwbDNzsJhrWslY6/2A8rbnUZ8wm8TH2lHPSUcVozV8QOuTyxr50MNNkmQZCszc
 8tl4Mmx2efg9NEZ+OQooF2TyJmjlGUC442vdVNFz1oUW2c37DdcAEK9yns7fNy+ZlN0s
 QPik7NOLDyJ3tWu/7Dii00TCQiOZkp0gBWvOX9eS917nt2WdJncRHw5rr4j4s93sRd+l
 MertvMXk/60IWG0eluEJ9oZzc0IPQcYfU1j1nNGsDzCrOKUYPWnLMKKAPMGvvuyb6Mfb
 Gk5m+6N2lIG0zdLgj1Jv6ICtr16py/YEiAxMh5fzG7/qMN4w3KdVHsV67Nghd3YuGL48
 5uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787742928; x=1788347728;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZvlcBzbv4P6JHFlvlxuJ9uFIQ4h7jCgOCygmVoGMpsg=;
 b=N1xeLE6h+qy1psVyPbyPy6q8UirBLPOCX41GJthTe42knUNeZYOxebqn68oxSEqabC
 qVMJqN24ESBluB4jS3C0dSCDvXx2m5SRDkAKcnv1MDstNyGV3unGfezInO5+hmbdf3EN
 hwCQ2u3tThZI63QNtcS5UYVg4x4coA1dBNiF57+tr1lfdaLUslIP1of6LTyydXLWHCh5
 2fX3G1sGuTnaD3j+LFeqYQZjAWmY64dnoHmWAzxrXDEI3OJ/FsBSpbvugaR8WFpysg6q
 U1r6QTUF4SqYlurgikaqIE4BgzALHRzjMaDsIUNw49ElMkGJr8zHPyhNSdU7IQyQ9OD2
 xwEA==
X-Gm-Message-State: AFuF++lI92SAWLD5HS6x8/vCb7BKyASvwP/H7utVEmWXWkJM5zwW25gr
 rcW2YjbvBr7CftUk+vJUmpkWOZyCEuv/PQeZEqsSZq5S9TsExT56VPDPKpLoHklywA3hB7Q940v
 S1Uth
X-Gm-Gg: AR+sD13euMjQj1fDpqIxO2fwdcyyxSIYAww7TPBu1W5Zv698pGIHdd9RG6UopRx1PZr
 Apn047gEb/DEQQRFxLv7wXDESLipfn8k5kZmP7GfxRiFelTC/TmOhB9sw2dVTxJbrco5E2y+n7g
 5SBBQlqkpCy6RCSp5JPLGKT4rCDMLqqQgGGmEAmrAkN7K2Wg68wBrA8ni2ZwW5m0xcFQaQHOPoe
 X1S1LBQOgdCB6NuJSDsO+FmIJoHDZnLyu4Krwj8Xb2x2aq0Hh50dhlI7c6/Qy+5SXteM/QRJesm
 YWlLhp9cklXQhMT4un4qvjmR03iwehtWlF21PkQz/QJ4uToyVDvYcPm/MSxzsT5fnZFG5gVZxhP
 WfjJ6zYzUofDsFpr85SIREfpcjgWsz1WRBAmjNkTEDNyxIYN92nCRVWHnIrqT9IiR3iKKjVnaWE
 4lQ69zWT8L0aIX42MF7c7jvAU2w0hTDuDFXNLnBqjiu5a7klu4
X-Received: by 2002:a05:6402:190e:b0:6a3:f63a:4978 with SMTP id
 4fb4d7f45d1cf-6a5df5d768dmr7970633a12.8.1787742927523; 
 Wed, 26 Aug 2026 04:15:27 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8ea655sm3951724a12.12.2026.08.26.04.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:15:26 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 00/28] IDE patches
Date: Wed, 26 Aug 2026 13:15:15 +0200
Message-ID: <20260826111524.3383479-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=den@openvz.org; helo=mail-ed1-x52e.google.com
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

The following changes since commit fe11f459f640cd08f35c21f9d403517951bfd671:

  Merge tag 'fixes-pr-v1' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-08-25 06:48:55 -0700)

are available in the Git repository at:

  https://gitlab.com/dlunev/qemu.git tags/pull-ide-2026-08-26

for you to fetch changes up to dd90d3cd73b9b2b0f27a9e51bfe542b3a510545b:

  tests/qtest/ide-test: cover the UDMA5 identify words (2026-08-26 12:59:19 +0200)

----------------------------------------------------------------
IDE patches

- fix the logical CHS translation a guest selects with INITIALIZE
  DEVICE PARAMETERS: reject a translation the device may not accept
  instead of dying on a division by zero, report the default
  translation in IDENTIFY DEVICE words 1, 3 and 6 and the one in
  effect in words 54 to 58, keep those words in sync when the
  translation changes, migrate both the translation and the SET
  FEATURES 0xCC revert flag, and return the power-on defaults on a
  hardware reset rather than on every reset
- harden the IDE and AHCI state a guest or an incoming migration
  stream can reach: reject an out-of-range PIO transfer window on
  load, refuse a PIO transfer with no command header, clear cur_cmd
  when the command list is unmapped, treat a failed PRDT walk as a
  transfer failure, reject a command header with an invalid FIS
  length, and drain the ports on teardown so that a request cannot
  outlive an unplug
- report ATAPI UDMA5 with a matching standard and cable
- extend the IDE/AHCI qtest coverage for all of the above

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: John Snow <jsnow@redhat.com>
CC: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

----------------------------------------------------------------
Denis V. Lunev (28):
      hw/ide: reject an unsupported CHS translation
      tests/qtest/ide-test: cover a CHS translation with zero sectors
      tests/qtest/libqos/ahci: allow a count and an expected error
      tests/qtest/ahci: cover the sector count of INITIALIZE DEVICE PARAMETERS
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
      hw/ide: reject an out-of-range PIO transfer window on load
      tests/qtest/ide-test: cover the migrated PIO transfer window
      hw/ide/ahci: refuse a PIO transfer with no command header
      hw/ide/ahci: clear cur_cmd when the command list is unmapped
      tests/qtest/ahci: regression test for a PIO write vs. engine stop
      hw/ide/ahci: treat a failed PRDT walk as a PIO transfer failure
      hw/ide/ahci: reject a command header with an invalid FIS length
      hw/ide/ahci: drain the ports on teardown
      tests/qtest/ahci: regression test for a request outliving an unplug
      hw/ide: report ATAPI UDMA5 with a matching standard and cable
      tests/qtest/ide-test: cover the UDMA5 identify words

 hw/ide/ahci.c             | 148 ++++++++---
 hw/ide/cmd646.c           |   2 +-
 hw/ide/core.c             | 170 +++++++++---
 hw/ide/ide-internal.h     |   7 +-
 hw/ide/isa.c              |   2 +-
 hw/ide/macio.c            |   2 +-
 hw/ide/mmio.c             |   2 +-
 hw/ide/piix.c             |   2 +-
 hw/ide/sii3112.c          |   6 +-
 hw/ide/trace-events       |   3 +
 hw/ide/via.c              |   2 +-
 include/hw/ide/ide-dma.h  |   3 +-
 tests/qtest/ahci-test.c   | 187 ++++++++++++++
 tests/qtest/ide-test.c    | 647 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/libqos/ahci.c |  14 +
 tests/qtest/libqos/ahci.h |   6 +
 16 files changed, 1113 insertions(+), 90 deletions(-)

-- 
2.53.0

