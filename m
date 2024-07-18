Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35191C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMUc-0005XT-Rk; Thu, 18 Jul 2024 04:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUMUa-0005HT-76
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:28:00 -0400
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUMUX-0002WA-LR
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:27:59 -0400
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1721291263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mFM3l1eUu/WcHcOp7Na38DizY22j3DTfaDgt7jRMp7M=;
 b=pKENvFKALzqTs55Rd9NgcDrLmk1MOyEwUxhV79+mTFlPLwQadvXRadrdAiUQqytREAl7Ts
 Cs9dyQ7dvYGuDk+1HkOSy/jaExxQu9yjOJfldOnHWaJaMzK/UgxiXkyTuXpcu3ltJGZ5s5
 a+ADN3denNBUW2WJ9BFhrCfkw0N4ahQINKmVrlbZyB2T0oynAGDae4sdHXzG1+WeGHkbH0
 pUC474QkJPB2AkY4oOzvEZsFzK2URmrMKuP8JUifhuWTIOAXKzMuaqF6S3Uhfe/FY2jCjE
 GzhCAIYQCwEpyNvVgs1WKW4jkZRNmdBUOalR+RXIoj6OiSYygYEFanNy+n2wgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1721291263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mFM3l1eUu/WcHcOp7Na38DizY22j3DTfaDgt7jRMp7M=;
 b=OMsb+wivgTYlIN5/vKQqkMyjrSemr0A6oSzsIq9YIg6sILeIo9dTgGwSoHLtHcceJYwnqm
 EValQ3UOgTbsJmCQ==
Subject: [PATCH v4 0/3] docs/interop/firmware.json: scripts/qapi-gen.py
 compatibility
Date: Thu, 18 Jul 2024 10:27:37 +0200
Message-Id: <20240718-qapi-firmware-json-v4-0-449ce672db5c@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPnRmGYC/33NQQ6CMBCF4auQrq2hUyypK+9hXLQwyBgt2CJiC
 He3sCKRuPxfMt+MLKAnDOyYjMxjT4EaFyPbJayojbsipzI2gxSyVKaKP01LvCL/eBuP/BYax1V
 lBQippSpLFg9bjxUNC3q+xK4pdI3/LD96Ma9/uV7wlCuhq1wAGMj06U7u1fnG0bAvkc1kD2sm3
 2QgMtKCRmOtttpsMXLFCLHJyMgUiEahPKDNfphpmr5W5jr9RgEAAA==
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721291263; l=1682;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=A0Qx8XmSpdnT3mzOZEW0LX47Wq9DUmBKtKR2vvnUnZA=;
 b=8h4YrAiUiNlrXKMQEYqmH9+lK7CPQfasPLslta8eFEVdKPZ2LuU0e8tZB3D/+SL6tWbXe1Pr4
 mteICuzz+B4CXmh2vfTQqJzEA5g7+sELlR7wFOuoIeFeDF70xdTlqdn
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Received-SPF: pass client-ip=2a0a:51c0:0:12e:550::1;
 envelope-from=t-8ch@linutronix.de; helo=galois.linutronix.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

docs/interop/firmware.json is currently not usable with qapi-gen.py due
to various non-functional issues.
Fix those issue to provide compatibility.

In v3 there was an open question about @file vs. @raw,
but given that the existing descriptors in pc-bios/descriptors/ are
already using @raw it seems clear the we have to keep it.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v4:
- Update "since" to 9.1
- Add comment to 'member-name-exceptions'
- Document enum members and drop 'documentation-exceptions'
- Link to v3: https://lore.kernel.org/r/20240311-qapi-firmware-json-v3-0-ceea6e35eb4a@linutronix.de

Changes in v3:
- Drop already picked up patches
- Drop include of pragma.json
- Introduce new enums FirmwareFormat and FirmwareArchitecture
- Link to v2: https://lore.kernel.org/r/20240307-qapi-firmware-json-v2-0-3b29eabb9b9a@linutronix.de

Changes in v2:
- Add review tag from Philippe
- Add Fixes tag (Philippe)
- Add testcase (Philippe)
- Link to v1: https://lore.kernel.org/r/20240306-qapi-firmware-json-v1-0-619f7122a249@linutronix.de

---
Thomas Weißschuh (3):
      docs/interop/firmware.json: add new enum FirmwareFormat
      docs/interop/firmware.json: add new enum FirmwareArchitecture
      docs: add test for firmware.json QAPI

 docs/interop/firmware.json | 46 ++++++++++++++++++++++++++++++++++++++++++----
 docs/meson.build           |  5 +++++
 2 files changed, 47 insertions(+), 4 deletions(-)
---
base-commit: 58ee924b97d1c0898555647a31820c5a20d55a73
change-id: 20240306-qapi-firmware-json-6fb1213936dd

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


