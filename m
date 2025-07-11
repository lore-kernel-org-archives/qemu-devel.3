Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D9BC83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 02:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua37O-0004R0-Ss; Thu, 10 Jul 2025 22:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ua373-0004OO-9e
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 22:03:45 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ua370-0001yE-JK
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 22:03:44 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4a77ea7ed49so32301421cf.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 19:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752199420; x=1752804220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mYMArfT2TZNV6/lCHlfgq979YuvRsldWu/WXj8vzR5Q=;
 b=Z7ZmP4Evzb6tyS8O45wpvr46EY+6f3tF2peTCjGDMPXsnifvrA9r7AsI9GipD0V9ev
 gOvBB7C/X2dH8GrIUqemWVLPEmuM1J0mnqy3UNo/hAtBPaee/s0GJw8Rc83ytwnETR2d
 D73TvDl4MDO3vLjtKvjiuRkUut0nauWN1GPh21Oq/xP1F8VgyVcmHOl/5YGdxZ8IKUE9
 Qmg6mXQExMZ06CcvZcctPovhYhpQYP5X0NwYO8HtSeVVmlQ0X1CWZEP8yrx+mvLT0+aA
 ag3+NkFivllmD/6zE2e63CutCCnwIl5LkLKbouukN8h6Yt5IiTxjo7Y1hHd9c1Rdo66N
 f28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752199420; x=1752804220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mYMArfT2TZNV6/lCHlfgq979YuvRsldWu/WXj8vzR5Q=;
 b=dSBAxDt2O7MDfhEchcrCnvd9GhTKnPZwiqDJ//NdkCOW/7jTkR6BdVmcGic3ml2Z5z
 RAQniTu57OGka5HgCGxREJVyd1jt6OJEvR6ebHJAf3wcId5K6PyVh+mMC//u6qMz5HZI
 Fw1RILoGJdVa3L5h6MmT8ME97GssHekg8CEgV699he/D36IummZODQlBeBtFTNKEhnAQ
 Zo8RulL04HwgTrvFYed9kmXoOeHp7DW4aZvrnfUoA/8geigDjTUQAdzPiJ1YMsXoNaWj
 O4ThGvRdWGBwUsDFc8Rj+TqdA3gecQjd0bNo1HEQuFuptNCyHhKZBEh0NDKDtG8zY52k
 Uykw==
X-Gm-Message-State: AOJu0YwC/oseqKIrM/vksyJf2vm1USsPBMZulH+kyOCZBjXGObi5ujoA
 mofdwdnfSZ66JnZU8cwQCYGeiS+DU6tz+36lOh/eTZdpEEe6Ug//v5F4IVphzw==
X-Gm-Gg: ASbGncsGURGWKpcwdODtCHL9T32d7QVdwgMW5Lo6W0sb0F+0qGZKx6q2ABLlV+YoqKL
 sdJjsq2wzBuDdKcgYCYYRyPOtfWIBl+ICc3VFivszZjjA9O2A5Wnu54Cf1DcRoun75lIuAgrvuq
 vGAZN9luhDhpjrIfhydJYIW5fn8hAmmKQr7RBmSxmRvoupJjLIV8m7LbW7dgxwLHUYmHMJFCaRJ
 KaofId3vs3SOAyTIt5PJca8CEDLk0yWsViure0k5TxG6kLdJTR50F1P8GoYmeFRJPm550vz71Ov
 2U/sjTc8TfoGhlCfpDE5P9WTPEYrmG6yDWq9BRVjbO5+HKuGd/2fW1/rWAGONYCgVSr6oKKfn57
 opa5T2i/GAGmee1uKirItngdvJxjAxCVHrzHpqoTvsRVuhYU=
X-Google-Smtp-Source: AGHT+IHAvehnIn2mPObDhgl9DErdfZOWStmdDQdL6/gv6CJ4LNTTt5zp51LiJYZNAwRoO5ZWWMaeWQ==
X-Received: by 2002:a05:622a:230b:b0:4a4:2fd6:90b7 with SMTP id
 d75a77b69052e-4a9e9cd8589mr94085811cf.17.1752199420287; 
 Thu, 10 Jul 2025 19:03:40 -0700 (PDT)
Received: from user-jcksn.mynetworksettings.com
 ([2600:4040:b51f:a700:7eb2:b315:2597:18f1])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a9ede76d41sm16125761cf.48.2025.07.10.19.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 19:03:39 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 1/2] docs/system: arm: Add max78000 board description
Date: Thu, 10 Jul 2025 22:03:37 -0400
Message-Id: <20250711020338.586222-2-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711020338.586222-1-jcksn@duck.com>
References: <20250711020338.586222-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=jackson88044@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This adds the target guide for the max78000FTHR

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
---
 docs/system/arm/max78000.rst | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 docs/system/arm/max78000.rst

diff --git a/docs/system/arm/max78000.rst b/docs/system/arm/max78000.rst
new file mode 100644
index 0000000000..d07d8b8a36
--- /dev/null
+++ b/docs/system/arm/max78000.rst
@@ -0,0 +1,35 @@
+Analog Devices max78000 board (``max78000fthr``)
+===============================================================================================================
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
+-----------------
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
\ No newline at end of file
-- 
2.34.1


