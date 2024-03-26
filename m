Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9D0CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp6dC-0003Nk-EA; Tue, 26 Mar 2024 09:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp6d9-0003NU-As
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:14:19 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp6d6-0008Co-UW
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:14:18 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-513cf9bacf1so7438477e87.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 06:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711458854; x=1712063654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IBArclXLgBtGIQsug37uXb6juwwdgaFEKEzp1NzqfYA=;
 b=mVlXtdD4/Yat5n5KcwksZTrKO4MFcAjUImiIbD1lKZGugqjwgRe9wsCuqoVb11YzcK
 h3sALBi4yG6pvJkr4CQ1gKU5n3fYtGNU46ty2y00dIIzIH7wTXkYb1/Eo+FcwRAIXtnb
 L2p2gx2tSe7wFH0Epe9uFKcDvGAHsO94qRygvRRT5RQqeicFFEcjomwaWjdcmbjqjDtU
 XkwXndDC3Dcs2nD65x1Vf4I1TkKjgmDLC8SdVwsfy3MNzSd4ih9pHwnstNl1HgRaRJaS
 jThRPQKxChzaQ4dVz4IfiWNAIc3Q1VJxdd5fuqvH3Sl0Dfn4q3Vx2o/hK8BVhZHa519y
 +4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711458854; x=1712063654;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IBArclXLgBtGIQsug37uXb6juwwdgaFEKEzp1NzqfYA=;
 b=dkrm2VNHGvb6sXGi3dVZhVW0G3a3aCU5IZHSTk4cY8JyojsJ5mg3eNwDOl6fPvKFbT
 1HrVDvPiXcHYgtR0pEXtG7BSQwEF2CHMblH9D7u4xwDYYBl/7+xosnjla4/soz78az17
 CrXb7X1w4BhRLOTSJX0hRKOIq/CrGL7j9CneWryiwPsN9JlGVFg3QteqAZJHQMyhKBBC
 +qNJKa20iyYH6hqN4sJmWz7imGq/oO2nDcNI79RbJp3EJhfq42aGpqVxPUJc4IEcytYZ
 /nqNbBlyifqtqLEJibyfaBw3lB4iRfahUdu8CcypPBWghzBsTg/7Cwar4HNx97iJyWty
 W5Mw==
X-Gm-Message-State: AOJu0Yw9NuZ9bwUoQfV9xLcGCBuop3OEVl8aeyvJI1G4jptFaGcI6tZf
 rhnLr7dx0r+PUKDxPzBx5Gl0kJahic+lJz8WGlm/Ifq2ghQoORLVhsWaOg90P3sA1FN6GLr6LTy
 g
X-Google-Smtp-Source: AGHT+IEGsXoW+PPpOhv5ihVPPM0jrHIOfW3HEhzUvTreGanWDwY3bSe0A8Xy/R1lkXdyDcV73lBb6g==
X-Received: by 2002:a2e:a0c5:0:b0:2d6:bd60:1c17 with SMTP id
 f5-20020a2ea0c5000000b002d6bd601c17mr6581350ljm.28.1711458853565; 
 Tue, 26 Mar 2024 06:14:13 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 s19-20020a05600c45d300b00414112a6159sm11482143wmo.44.2024.03.26.06.14.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Mar 2024 06:14:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: mst@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1] hw/i386: Add a config to only build the microvm
 machine
Date: Tue, 26 Mar 2024 14:14:10 +0100
Message-ID: <20240326131410.93866-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

Add a config file to build a binary only containing the
microvm machine, inspired by a discussion on the list:
https://lore.kernel.org/qemu-devel/604bf457-23a7-4d06-b59f-a7b46945c626@tls.msk.ru/

As suggested in commit d1d5e9eefd ("configure: allow the
selection of alternate config in the build"), it can be
built using:

  $ ../configure --without-default-features \
                 --target-list=x86_64-softmmu \
                 --with-devices-x86_64=microvm

Inspired-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/devices/x86_64-softmmu/microvm.mak | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 configs/devices/x86_64-softmmu/microvm.mak

diff --git a/configs/devices/x86_64-softmmu/microvm.mak b/configs/devices/x86_64-softmmu/microvm.mak
new file mode 100644
index 0000000000..fe48b5b4a7
--- /dev/null
+++ b/configs/devices/x86_64-softmmu/microvm.mak
@@ -0,0 +1,20 @@
+# SPDX-FileCopyrightText: 2024 Linaro Ltd.
+#
+# Config that only supports the 64-bit microvm machine.
+# This avoids bringing in any of numerous legacy features from
+# the legacy machines or the 32bit platform.
+#
+
+CONFIG_MICROVM=y
+CONFIG_PCI_DEVICES=n
+CONFIG_SMBIOS=y
+CONFIG_SMBIOS_LEGACY=n
+CONFIG_VIRTIO_BALLOON=y
+CONFIG_VIRTIO_BLK=y
+CONFIG_VIRTIO_CRYPTO=y
+CONFIG_VIRTIO_GPU=y
+CONFIG_VIRTIO_INPUT=y
+CONFIG_VIRTIO_NET=y
+CONFIG_VIRTIO_RNG=y
+CONFIG_VIRTIO_SCSI=y
+CONFIG_VIRTIO_SERIAL=y
-- 
2.41.0


