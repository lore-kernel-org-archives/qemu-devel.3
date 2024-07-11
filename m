Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB20C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRthY-0002jw-2L; Thu, 11 Jul 2024 09:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRthP-0002ET-BX
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:19:03 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRth7-00063f-Ay
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:19:02 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4266ea6a412so6379265e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720703910; x=1721308710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hxdbg1E8swi6ftQgPkWvTdJfdBhoPoWAjPRagQtO7C8=;
 b=uFSr8PFoUzFX6126L2KP9zoIXRmXmZt8HVdyFDog4S6fUH3894BNqLvg52rzAtOF9H
 48SSoGb+pjVnFYf2rK9IpDs/gu+pF/z2N3hzRX7rAp00m3ET7MvnFUAgFQ7bsemXqLL4
 z8yGaqdyNvJyRnhxFe3e4d5ZJ9NUfV7tQiU10zvaTkieq0hxsadyQY5nN2x4KJ/HoDPl
 wnyYsiKAgk5J+ohe6oFVMOjsCMwg5/hT/5y2xCUbnLHGnpEdz9N8grpdyxvIT8Exee8p
 koKm9JodbbftfSP5BdyvWYaRZhmdl7HKWHzxGkoeJBwJGTjcRhUPaHGK/0OFEE0oe5p0
 Et5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703910; x=1721308710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hxdbg1E8swi6ftQgPkWvTdJfdBhoPoWAjPRagQtO7C8=;
 b=SkEwzUu+6Jt+ZOnzQBV3xSxxhrFeSgVK+uhOGCgneNWqoIQ+sWVANk1T5qAgZDyoxc
 MfzDqO4KX/oMW9zb9Wug/5YPO0971DxPTxMg+9q4l1kZX6bl2035wTfRTL8ZMX5ASyDe
 ARxTOa2/f1eN4rkmgL9g14gxNcTUikaFkh/zGA3Yspph6+e3vh+A3sfnLNZtRPCA9ZeM
 dYKhT6+83/0U7/9jDh9sduSMNde1O+LmY/bBpNxaaLaayPAWnvWbq84GfZ8sv2g14BPu
 e1ya9AonslkdMnwBucP58U0wSwhhDd83VGzwpCWgEJIlRAldM6RY/mTVXUaJRcVNEXAw
 0xEA==
X-Gm-Message-State: AOJu0YzX8GJRMDCMpK+jCV0nzPLslMiUFRL+K3g9fz3AwdonUURN7T/Y
 ySuGsBaWS+JjAHOeDH6F74+O6mWc1yvdCSamv+FiwgqH1eXdNDa+JNN6YqwlLscMEH5B1hK+zds
 Hu1s=
X-Google-Smtp-Source: AGHT+IF6ENQPeGJo9k5be7/Qc0icLZs8ScZUSQk7tlXLbfR/x19eASA53BOHqDQWF4vkit9nWbqyZA==
X-Received: by 2002:a05:600c:6a85:b0:427:9922:4526 with SMTP id
 5b1f17b1804b1-42799224cf5mr16598265e9.7.1720703910356; 
 Thu, 11 Jul 2024 06:18:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736939sm119412025e9.37.2024.07.11.06.18.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:18:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/24] hw/misc/bcm2835_thermal: Fix access size handling in
 bcm2835_thermal_ops
Date: Thu, 11 Jul 2024 14:18:09 +0100
Message-Id: <20240711131822.3909903-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711131822.3909903-1-peter.maydell@linaro.org>
References: <20240711131822.3909903-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Zheyu Ma <zheyuma97@gmail.com>

The current implementation of bcm2835_thermal_ops sets
impl.max_access_size and valid.min_access_size to 4, but leaves
impl.min_access_size and valid.max_access_size unset, defaulting to 1.
This causes issues when the memory system is presented with an access
of size 2 at an offset of 3, leading to an attempt to synthesize it as
a pair of byte accesses at offsets 3 and 4, which trips an assert.

Additionally, the lack of valid.max_access_size setting causes another
issue: the memory system tries to synthesize a read using a 4-byte
access at offset 3 even though the device doesn't allow unaligned
accesses.

This patch addresses these issues by explicitly setting both
impl.min_access_size and valid.max_access_size to 4, ensuring proper
handling of access sizes.

Error log:
ERROR:hw/misc/bcm2835_thermal.c:55:bcm2835_thermal_read: code should not be reached
Bail out! ERROR:hw/misc/bcm2835_thermal.c:55:bcm2835_thermal_read: code should not be reached
Aborted

Reproducer:
cat << EOF | qemu-system-aarch64 -display \
none -machine accel=qtest, -m 512M -machine raspi3b -m 1G -qtest stdio
readw 0x3f212003
EOF

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
Message-id: 20240702154042.3018932-1-zheyuma97@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/bcm2835_thermal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/misc/bcm2835_thermal.c b/hw/misc/bcm2835_thermal.c
index ee7816b8a5d..0c49c088a79 100644
--- a/hw/misc/bcm2835_thermal.c
+++ b/hw/misc/bcm2835_thermal.c
@@ -80,8 +80,10 @@ static void bcm2835_thermal_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps bcm2835_thermal_ops = {
     .read = bcm2835_thermal_read,
     .write = bcm2835_thermal_write,
+    .impl.min_access_size = 4,
     .impl.max_access_size = 4,
     .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.34.1


