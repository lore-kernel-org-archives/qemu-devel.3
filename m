Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8590C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDv3-0006vQ-KW; Fri, 11 Jul 2025 09:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDuD-0004av-AR
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:15 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDu9-0003R0-9z
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:12 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45526dec171so7656395e9.2
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240908; x=1752845708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lS2nIjGxU16dkA6C/AG8JGKbnfQy87F/qy82QXJuWeI=;
 b=RmS2mjg4XXtQp/wkepSh4OVXi1ia2ZrJ8cqLLbPjIsyax0gfOaJc0OMB8R+LbFWfha
 kiEEuy0MOHfsishew2VueGTrgak3hg9QLv1euTvflMrjtaT3ArQROt+GUw+IJQ4+R4Om
 VptVZ0iosYe/f1waTDHcUlSsq0UO+JKrpSZPrnU0+3/hIhOj/EPlJl/FCDzR4zQTIpzf
 ypAr+loXP3O7AtgEN7QR0AJvGukng1avnAT0a96RMavMI42n5ncfynin8R7hiwcOur9n
 JgowhXb3unXYyA3JyTA37f55mpZcrUi3G0KijdP97rY6HeJPk6Z1Kxx760ERBoTe5Kh0
 Ommw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240908; x=1752845708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lS2nIjGxU16dkA6C/AG8JGKbnfQy87F/qy82QXJuWeI=;
 b=lcxane7ZbNuO1G4N1pO5LhTDeUQ049DROrnLVttRp2/0z/1tks/VIo+0vqvViQv/kk
 wAQtA+rBYmdeoNHdoxzT+QxH7HwMDFCtaMzJwAt9o7mH3yGtuKqk5LHK8qXs6G9Girw2
 SP8RFqHztWXti7depL1KG6F+oInXDF+BiJAzmDsatGYZ3So0jQQPRylVf1FdEBw82ps9
 tMqyCeQuA4n/ZKCa7TzffoA9F21ZA1rd0d+7zIZb1QASy+48I86b09JyA5IApY64CLoB
 K1liOTpGF+6EN989+jq+S+CFhDE8MhRI6sFBJ3DRufcrbtkfqkqrOLmDNuh/nj/ef0UJ
 VXzA==
X-Gm-Message-State: AOJu0Yy/nHdEN6NJwWBSooFQvo8Hwp28ZHkBxIO20s7awJDhMhnIYA14
 WU0p6PeLkkpw+OcbYdYrG2oEgUcvotxPq3ZzzVrmch0MSHtF7g7yYEdh06ZjX9Hbq1/ipiqxyMw
 punyo
X-Gm-Gg: ASbGncslOTXygRPrj+aJgotEMVKbbS2ezG9MgvlFHZKFUfpCe++EBF7PhmQgTdJUAHB
 32jY97rq9L9Se5VuUiSLxB9QZeMAKtJ++mXPwxS0f6Q7F6aPOW5tC1L4ixdhC0ChexmQEYHbNtb
 FTklgZBiBfihSRJpyeR2HZ2jHi5FPQvXAUukdJuUq3ZFAoK7rhYvo99qp7ofaJDObTUzSGsUuj4
 qfNiEBLD3+PNdY5hj8HOeoHxMfwkoZYkOKg/5ZI+mfJd7Hy5nFg3Pqf8+jA3lyymHK371IBoKIj
 VLMTtqmNXo7DUGPoI7qswkXDf8TVXEiMYtLAId8BTNeftlBsAZZHGA5Cf6y58FaBmhylhs/3yBm
 kEWtPBgI/IMyt7XAoFz6A+umTWlOk
X-Google-Smtp-Source: AGHT+IG/AM6vOPTpmiMfZdzF53IbDJg5Dxxnzn8+C7pOxrv2IP4rI4ElJBf/TtspcI6XFxkYJ4bmJQ==
X-Received: by 2002:a05:600c:8b2a:b0:453:7b2b:ed2e with SMTP id
 5b1f17b1804b1-454ec2727dcmr28392355e9.24.1752240907667; 
 Fri, 11 Jul 2025 06:35:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.35.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:35:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/36] docs/system: arm: Add max78000 board description
Date: Fri, 11 Jul 2025 14:34:28 +0100
Message-ID: <20250711133429.1423030-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Jackson Donaldson <jackson88044@gmail.com>

This adds the target guide for the max78000FTHR

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Message-id: 20250711110626.624534-2-jcksn@duck.com
[PMM: Moved doc to correct place in index; made underlines correct
 length; added missing trailing newline; added SPDX]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/max78000.rst | 37 ++++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst   |  1 +
 2 files changed, 38 insertions(+)
 create mode 100644 docs/system/arm/max78000.rst

diff --git a/docs/system/arm/max78000.rst b/docs/system/arm/max78000.rst
new file mode 100644
index 00000000000..3d95011fefd
--- /dev/null
+++ b/docs/system/arm/max78000.rst
@@ -0,0 +1,37 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Analog Devices max78000 board (``max78000fthr``)
+================================================
+
+The max78000 is a Cortex-M4 based SOC with a RISC-V coprocessor. The RISC-V coprocessor is not supported.
+
+Supported devices
+-----------------
+
+ * Instruction Cache Controller
+ * UART
+ * Global Control Register
+ * True Random Number Generator
+ * AES
+
+Notable unsupported devices
+---------------------------
+
+ * I2C
+ * CNN
+ * CRC
+ * SPI
+
+Boot options
+------------
+
+The max78000 can be started using the ``-kernel`` option to load a
+firmware at address 0 as the ROM. As the ROM normally jumps to software loaded
+from the internal flash at address 0x10000000, loading your program there is
+generally advisable. If you don't have a copy of the ROM, the interrupt
+vector table from user firmware will do.
+Example:
+
+.. code-block:: bash
+
+  $ qemu-system-arm -machine max78000fthr -kernel max78000.bin -device loader,file=max78000.bin,addr=0x10000000
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index b96a05a9206..a96d1867df1 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -71,6 +71,7 @@ Board-specific documentation
 .. toctree::
    :maxdepth: 1
 
+   arm/max78000
    arm/integratorcp
    arm/mps2
    arm/musca
-- 
2.43.0


