Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7500BCAC594
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Sep 2025 13:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxmIG-0004XN-Gw; Sun, 14 Sep 2025 08:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-202509141246476b3651640d0002078a-KMrcSM@rts-flowmailer.siemens.com>)
 id 1uxmI6-0004UR-P8
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 08:57:15 -0400
Received: from mta-64-228.siemens.flowmailer.net ([185.136.64.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-202509141246476b3651640d0002078a-KMrcSM@rts-flowmailer.siemens.com>)
 id 1uxmHw-0002N1-6P
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 08:57:14 -0400
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 202509141246476b3651640d0002078a for <qemu-devel@nongnu.org>;
 Sun, 14 Sep 2025 14:46:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=S1DjM5+Hfez3lL/UO35wzcCHxLRyx3TYwnC6aX/NwE0=;
 b=QK5s41omyGt5xHcyP5cL+jDLy5jNTFE+ODvgjud7NV0L/JACfgaDb9haFNYtVpSEyFwjJ3
 x2j7vboPo8sq/jK+Jziakmt/uxvzVmOOMHLNWRyU1c6rTL9jduMNCzAnO6y4aKW6R4O4Cwgp
 Sn7jWMB8NGv4UCciTuB0kLJ7mMaeZS5LmdoEV+Iss5eNV97n1vpXG3g+eZxsO+GoBI0h5fed
 LkZO2MUkX0JWE7kM/yzMQIfCJuJlMZtgiZC0lcPL/mWTMv+sct4QuEYKC4y3l4ptodsJsESV
 2VOU6ANSbJkM4noasVQF1fuI204gDx6g5jL+ymGRCMoUsNWfB8pX6qyw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Jan=20L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Warner Losh <imp@bsdimp.com>
Subject: [PATCH v4 0/6] sd: Add RPMB emulation to eMMC model
Date: Sun, 14 Sep 2025 14:46:40 +0200
Message-ID: <cover.1757854006.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.64.228;
 envelope-from=fm-294854-202509141246476b3651640d0002078a-KMrcSM@rts-flowmailer.siemens.com;
 helo=mta-64-228.siemens.flowmailer.net
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Changes in v4 [1]:
 - add truncation warning to mkemmc.sh
 - fix typos in doc and mkemmc.sh

Changes in v3:
 - rebased, dropping merged patches
 - rework image alignment rules to match hardware
 - improve/fix mkemmc script
 - add emmc documentation

Changes in v2:
 - handle write counter expiry
 - assert() availability of QCRYPTO_HASH_ALGO_SHA256
 - add missing SPDX-License-Identifier

This closes an old gap in system integration testing for the very
complex ARM firmware stacks by adding fairly advanced Replay Protected
Memory Block (RPMB) emulation to the eMMC device model. Key programming
and message authentication are working, so is the write counter. Known
users are happy with the result. What is missing, but not only for RPMB-
related registers, is state persistence across QEMU restarts. This is OK
at this stage for most test scenarios, though, and could still be added
later on.

What can already be done with it is demonstrated in the WIP branch of
isar-cip-core at [2]: TF-A + OP-TEE + StandaloneMM TA + fTPM TA, used by
U-Boot and Linux for UEFI variable storage and TPM scenarios. If you
want to try: build qemu-arm64 target for trixie with 6.12-cip *head*
kernel, enable secure boot and disk encryption, then run

$ QEMU_PATH=/path/to/qemu-build/ ./start-qemu.sh

Deploy snakeoil keys into PK, KEK and db after first boot to enable
secure booting:

root@demo:~# cert-to-efi-sig-list PkKek-1-snakeoil.pem PK.esl
root@demo:~# sign-efi-sig-list -k PkKek-1-snakeoil.key -c PkKek-1-snakeoil.pem PK PK.esl PK.auth
root@demo:~# efi-updatevar -f PK.auth db
root@demo:~# efi-updatevar -f PK.auth KEK
root@demo:~# efi-updatevar -f PK.auth PK

Note that emulation is a bit slow in general, and specifically the
partition encryption on first boot is taking 20 min. - we should
probably reduce its size or understand if there is still something to
optimize.

Jan

[1] https://github.com/siemens/qemu/commits/queues/emmc/
[2] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/wip/qemu-rpmb

CC: Alexander Bulekov <alxndr@bu.edu>
CC: Alistair Francis <alistair@alistair23.me>
CC: Cédric Le Goater <clg@kaod.org>
CC: Joel Stanley <joel@jms.id.au>
CC: Warner Losh <imp@bsdimp.com>

Jan Kiszka (6):
  hw/sd/sdcard: Fix size check for backing block image
  hw/sd/sdcard: Allow user-instantiated eMMC
  hw/sd/sdcard: Add basic support for RPMB partition
  hw/sd/sdcard: Handle RPMB MAC field
  scripts: Add helper script to generate eMMC block device images
  docs: Add eMMC device model description

 docs/system/device-emulation.rst |   1 +
 docs/system/devices/emmc.rst     |  52 +++++
 hw/sd/sd.c                       | 349 ++++++++++++++++++++++++++++---
 hw/sd/sdmmc-internal.h           |  21 ++
 hw/sd/trace-events               |   2 +
 scripts/mkemmc.sh                | 218 +++++++++++++++++++
 6 files changed, 615 insertions(+), 28 deletions(-)
 create mode 100644 docs/system/devices/emmc.rst
 create mode 100755 scripts/mkemmc.sh

-- 
2.51.0


