Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E625CCD98E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 05:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZj1d-0007MB-I0; Wed, 17 Jun 2026 01:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wZj1b-0007Le-OI
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 01:41:19 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wZj1a-0003wE-C9
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 01:41:19 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2c0b9328c4aso39842245ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 22:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781674877; x=1782279677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sH/6co8o4Sx4ydjWdvE8FaqBd8Mma9TOL81HqBgwXvY=;
 b=AFY/01DPcDshAfnfx/LmKAq+Jvc2dDPp3ukYRFQnQXb65JJLGV/Kea32V/36rDHlEF
 Ro0B/WZrXhjPVHRoAHYAPT9gxxJ0NnHzw6vAJtsF/gyoEeePiKIrNu0ebX85OZkTXDYL
 C4IZzA68DHbFaiTUBNiBjitHmTfaGaH2/gfZEG1aNm2stGR0Ns3Pz3uAp98zSfwVVRZ+
 aMMJ+bBehA0XtygyI+jGTFzv9pLe3bC/5vKlTOFEJU72L3WoTcCCjv+zws5XOH9Mkbp6
 TIGYatfduqFAfltR9FslCfZq3hK1VIjCpprU3ECsdOpsIscZZkIbtaf105X3ChpYOQ6J
 bGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781674877; x=1782279677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sH/6co8o4Sx4ydjWdvE8FaqBd8Mma9TOL81HqBgwXvY=;
 b=fYorXqfZrYruoVhzXalJjI6YhGn7SvA98EBPZNMhOLT9tQ4g8C6Whhnm6RQlj+A+dG
 dGPZbJQon0J3zWsGOsgLqTClkcVWQSC94MgPS2cZHycS2zzVQQM56059zpdxP3D/vrqt
 yFfhIVk9YOrzHi8BoaljMcrtkO5JVW8a2iK68eh+DsHCqHUAgvdMC57LRuiCOkL2mnox
 SoslTgKuI6ktOYFNpHmSYVSFG8bh8x5ZEA6DS3OhXERlw97hoy9jyEJ/eQ1X/Rm/8Upg
 oKdD/UMs23+GuAda/0fhkz1wF0z6I90o+i8mUcvdfmQTOud5z1GHs3/Wl28yizGli3mh
 i3WA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/QPClBU4jgFx+ADuhiHhk9w0dVHil7252nPur/PiGubTmArWpkPgpUGKrWua4nJoeYkxLnhm+bMmHn@nongnu.org
X-Gm-Message-State: AOJu0YyOWywLJGe/Hu+AdjHljLsIMwgyhkqZHG+agmk6ischWe+z7ns0
 YBQ7D5wEIrsEiS/de4fFkrwsom4LtTVJgPYXjZEsIkzQ+cSQ9/vGG9iPPEH34BYI
X-Gm-Gg: AfdE7cl7fJX006rkNJl2UKXhb6xdUYRTozbsl7hbMr8wNWmNwdTZVR7HyyaoZRpgNjV
 SCWv34e4n1fkPaS8pzAdtxI4onU7TgmzsVhVKFYUxTex/WIaPaJS7/KdLJI5ksdVZsnD0fxDLKo
 FXIJuNeM+ft1ec1WZmrWPQRArS/EWrGdxLRIko2z90G7piWvzBW5coPN6gJYK3khVoD7RBL/w6Q
 b+B3kUl5tbtPhduDil26JrXZCEA7jc9xVtMq9Co7pRtBhM3BUPViTAPy7eLFcryF1fNao7KPV2a
 AcfD5Emr7g19jGY3Mijy3v9GqT2esW+6ehfA0G2JUbZ2UFAfyfgTxPdwXKGtkHZO1JQACjxQ9mR
 VlqYpyBwVe8S32g+1MgeSlZBD8qj4kXNn5B09SBeMKvT9A0zOZNOYpHI48/mxQAmK/8kYdbDOjT
 SNt7zI7zrI31yo5hCRUh4EDBVnyaqI3Ugh0fokSPOOMmz8dk6zTCvYBKBng/JuGgXSnXG60cyqR
 7mcZ66ZIm2ZjWJNEI27fje3O/41nprwa/d5XrsBtag=
X-Received: by 2002:a17:902:e550:b0:2c6:6926:8968 with SMTP id
 d9443c01a7336-2c6bc208e20mr23353475ad.20.1781674875433; 
 Tue, 16 Jun 2026 22:41:15 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c433078264sm149294725ad.65.2026.06.16.22.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 22:41:15 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: alistair.francis@wdc.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/3] tests/functional/riscv64: Add virt machine AIA boot test
Date: Wed, 17 Jun 2026 15:09:28 +0930
Message-ID: <20260617054034.1020724-4-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617054034.1020724-1-joel@jms.id.au>
References: <20260617054034.1020724-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add coverage of the riscv64 virt machine's Advanced Interrupt
Architecture models. With this the APLIC and IMSIC models are used by
Linux, catching regressions.

This test requires a kernel >= 6.10, as AIA drivers were added to Linux
in 6.10.

Boot time is ~5s on a laptop.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 tests/functional/riscv64/test_tuxrun.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/functional/riscv64/test_tuxrun.py b/tests/functional/riscv64/test_tuxrun.py
index 43d1242be52b..6203a45060ce 100755
--- a/tests/functional/riscv64/test_tuxrun.py
+++ b/tests/functional/riscv64/test_tuxrun.py
@@ -41,6 +41,13 @@ def test_riscv64_maxcpu(self):
         self.common_tuxrun(kernel_asset=self.ASSET_RISCV64_KERNEL,
                            rootfs_asset=self.ASSET_RISCV64_ROOTFS)
 
+    def test_riscv64_aia(self):
+        self.set_machine('virt')
+        self.vm.set_machine('virt,aia=aplic-imsic')
+        self.cpu='max'
+        self.common_tuxrun(kernel_asset=self.ASSET_RISCV64_KERNEL,
+                           rootfs_asset=self.ASSET_RISCV64_ROOTFS)
+
     def test_riscv64_rv32(self):
         self.set_machine('virt')
         self.cpu='rv32'
-- 
2.47.3


