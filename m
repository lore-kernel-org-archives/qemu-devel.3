Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17502CD1292
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 10:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrbP7-0008NE-7l; Tue, 02 Apr 2024 06:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrbP3-0008Kw-Lt
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:30:05 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrbOy-0003eR-Im
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:30:05 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41569865b2fso11091535e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 03:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712053794; x=1712658594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QuZfSUVScjt9n5vrw27PPdIk4irfQ7o3hh1IbZPVDZ4=;
 b=eUKuQhJyhlzuHQHnOz9ENoU8qCx2fi/cgIZ/9uTvRs6G4lauSJgT8Hp+uJV7+0BnXU
 FAzhfHaZ5YHIERwHns/7TuqcOpMrvb3lo6oRXgALPt4bymGxmBoa0h8SDrhDS5f9x7lU
 Nm/fFse7uO5iaah6uzEZAEg79lNUpTTy2/fVnzrpoSwjOlIn/O++LeykA5TjGL29Fv2h
 6GyGNgubo4EA5WRb23Ktuapv/y6FFmO5QvYll8jDIHTxwRmNaE0JtW6qiuI/c1SjQChr
 4X4vpNcZUqVZOgEus19GGbmb8xg2WHVhuSW5tlaZSOIdhQWz+SDWANeOq5o8z0lghtJf
 F3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712053794; x=1712658594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QuZfSUVScjt9n5vrw27PPdIk4irfQ7o3hh1IbZPVDZ4=;
 b=ie/5bHyKdovHHtPa6BIwwqk/N1TqS5L0aGTfjTcYoUQS8gLYgo7wDOAFSmg67U6YXz
 tC3VdrNZTnCk5R1Lqs425DPAtYtpd8z4dPJ7AFe+D5hN00QeSkXLFTNlClfF8RvNKVol
 jneE10kkF6mwH+bM6bNxuEgobcH9cPkxh4RQy4rktLY7GCoV6+45f6+/uslBrPs2mBAX
 z7BoFkY5N5mw9JUglwzjQWLFAt8XHJO9o7aZz+6s1g5ZUBN0gJ1p7Kq1Rh4jTMCXPRgu
 AabaWeK9dwVf46Lvdj1+IanyyUTVqxHPfvMIW/8qX3X44qVYHmn8qsSoB4/zKiPh7OCo
 99HA==
X-Gm-Message-State: AOJu0Yw9M7PspV6Jm1cWCOkwxiQhgZyeen6PXcKGCZ5xNW5w7REnC1pE
 NfwDwFDY3Me05UHb302OBcrEhSpCmEyE9S06UQA7diUEKs47914Pwx3wx5LiEZa7yKFXvt1M9pu
 t
X-Google-Smtp-Source: AGHT+IF1WVMJqBX8wKcJrjD1tw6r0+MIztUnpOj0+YUY0EPDy6FWPV0smRK0y/FwEhhuv1V0fpIkQQ==
X-Received: by 2002:a05:600c:a4b:b0:414:887f:617a with SMTP id
 c11-20020a05600c0a4b00b00414887f617amr9308484wmq.38.1712053794410; 
 Tue, 02 Apr 2024 03:29:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a05600c4fcf00b0041488895a37sm20586175wmq.33.2024.04.02.03.29.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 03:29:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] docs: sbsa: update specs, add dt note
Date: Tue,  2 Apr 2024 11:29:48 +0100
Message-Id: <20240402102951.3099078-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402102951.3099078-1-peter.maydell@linaro.org>
References: <20240402102951.3099078-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Hardware of sbsa-ref board is nowadays defined by both BSA and SBSA
specifications. Then BBR defines firmware interface.

Added note about DeviceTree data passed from QEMU to firmware. It is
very minimal and provides only data we use in firmware.

Added NUMA information to list of things reported by DeviceTree.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-id: 20240328163851.1386176-1-marcin.juszkiewicz@linaro.org
Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/sbsa.rst | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
index bca61608ff8..2bf22a1d0b0 100644
--- a/docs/system/arm/sbsa.rst
+++ b/docs/system/arm/sbsa.rst
@@ -1,12 +1,16 @@
 Arm Server Base System Architecture Reference board (``sbsa-ref``)
 ==================================================================
 
-While the ``virt`` board is a generic board platform that doesn't match
-any real hardware the ``sbsa-ref`` board intends to look like real
-hardware. The `Server Base System Architecture
-<https://developer.arm.com/documentation/den0029/latest>`_ defines a
-minimum base line of hardware support and importantly how the firmware
-reports that to any operating system.
+The ``sbsa-ref`` board intends to look like real hardware (while the ``virt``
+board is a generic board platform that doesn't match any real hardware).
+
+The hardware part is defined by two specifications:
+
+  - `Base System Architecture <https://developer.arm.com/documentation/den0094/>`__ (BSA)
+  - `Server Base System Architecture <https://developer.arm.com/documentation/den0029/>`__ (SBSA)
+
+The `Arm Base Boot Requirements <https://developer.arm.com/documentation/den0044/>`__ (BBR)
+specification defines how the firmware reports that to any operating system.
 
 It is intended to be a machine for developing firmware and testing
 standards compliance with operating systems.
@@ -35,16 +39,29 @@ includes both internal hardware and parts affected by the qemu command line
 (i.e. CPUs and memory). As a result it must have a firmware specifically built
 to expect a certain hardware layout (as you would in a real machine).
 
+Note
+''''
+
+QEMU provides the guest EL3 firmware with minimal information about hardware
+platform using minimalistic devicetree. This is not a Linux devicetree. It is
+not even a firmware devicetree.
+
+It is information passed from QEMU to describe the information a hardware
+platform would have other mechanisms to discover at runtime, that are affected
+by the QEMU command line.
+
+Ultimately this devicetree may be replaced by IPC calls to an emulated SCP.
+
 DeviceTree information
 ''''''''''''''''''''''
 
-The devicetree provided by the board model to the firmware is not intended
-to be a complete compliant DT. It currently reports:
+The devicetree reports:
 
    - CPUs
    - memory
    - platform version
    - GIC addresses
+   - NUMA node id for CPUs and memory
 
 Platform version
 ''''''''''''''''
@@ -70,4 +87,4 @@ Platform version changes:
   GIC ITS information is present in devicetree.
 
 0.3
-  The USB controller is an XHCI device, not EHCI
+  The USB controller is an XHCI device, not EHCI.
-- 
2.34.1


