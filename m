Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C396ACA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usxgr-0003CE-W3; Mon, 01 Sep 2025 02:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-20250901055629953005d432000207ff-ySyy34@rts-flowmailer.siemens.com>)
 id 1usxgj-0003Ag-7n
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:06:45 -0400
Received: from mta-64-228.siemens.flowmailer.net ([185.136.64.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-20250901055629953005d432000207ff-ySyy34@rts-flowmailer.siemens.com>)
 id 1usxgg-0001wx-OO
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:06:44 -0400
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20250901055629953005d432000207ff for <qemu-devel@nongnu.org>;
 Mon, 01 Sep 2025 07:56:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=QMU6p/1vgREUs/j47CKlv/zZ8l2qabDx5WbJ5tfLnKE=;
 b=gNjWRT35YTmgayUNjAU/UxTEotMrEU1yJl8FV03Cp5j1PP0EYQ4pgCLluYh0Hn7o0nm0bp
 yppuUeXK5b3lCTNrAo+6sNW2fjqQZAmFai3IFI34SDm499/J73l+gRV0nXcFPHzLF2DHgx5h
 tvG3ifmVbuQUkAdH2Z0PCASs7P+ZNHdxSZznu+398QXPobWiUm1sRd0W1FxMF4KOXQ7MZzKh
 7O903CsHWHJTdGSnv6IceFfstdQ75YverJd3gkYuZCK9oTyXJXBfme8UzUu2ZMD7gQc/algi
 9n9h0Vx43FTndvb4OkZojXN+8JMXgKKqQea+NArEc3p1rNKwCTZs5bzg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 0/8] sd: Add RPMB emulation to eMMC model
Date: Mon,  1 Sep 2025 07:56:20 +0200
Message-ID: <cover.1756706188.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.64.228;
 envelope-from=fm-294854-20250901055629953005d432000207ff-ySyy34@rts-flowmailer.siemens.com;
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

Changes in v2 [1]:
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

Cc: "Daniel P. Berrangé" <berrange@redhat.com>

Jan Kiszka (8):
  hw/sd/sdcard: Fix size check for backing block image
  hw/sd/sdcard: Add validation for boot-partition-size
  hw/sd/sdcard: Allow user-instantiated eMMC
  hw/sd/sdcard: Refactor sd_bootpart_offset
  hw/sd/sdcard: Add basic support for RPMB partition
  crypto/hmac: Allow to build hmac over multiple
    qcrypto_gnutls_hmac_bytes[v] calls
  hw/sd/sdcard: Handle RPMB MAC field
  scripts: Add helper script to generate eMMC block device images

 crypto/hmac-gcrypt.c   |   4 +-
 crypto/hmac-glib.c     |   4 +-
 crypto/hmac-gnutls.c   |   4 +-
 crypto/hmac-nettle.c   |   4 +-
 hw/sd/sd.c             | 314 ++++++++++++++++++++++++++++++++++++++---
 hw/sd/sdmmc-internal.h |  24 +++-
 hw/sd/trace-events     |   2 +
 include/crypto/hmac.h  |  12 ++
 scripts/mkemmc.sh      | 186 ++++++++++++++++++++++++
 9 files changed, 532 insertions(+), 22 deletions(-)
 create mode 100755 scripts/mkemmc.sh

-- 
2.43.0


