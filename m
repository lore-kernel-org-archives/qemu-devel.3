Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6CFC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogys-0005hN-03; Tue, 28 Jul 2026 08:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyM-0005Tp-LC
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:50 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogyK-00038P-D9
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:49 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-472326ca506so2590514f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241907; x=1785846707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cXg53sAdYMTmjJCoT+c7TGT3C0eDImHJg6z6/cONmAA=;
 b=pnjsvkJlWhwKDs/S7vo6IzrW6KaiILC7EhgU4jAP/P7RlxAFr+cTEP7cVVfSE4UxED
 Ti8il48WGdCOqDecKvt2ipwwJwrws+rwuLbiKSM3L5g6rgjPOvOPLOPJqrbEVUO8cIge
 hwzJ5IJoVnSSMg3tNCvNCwNUe0htBqRtzplZCKio2B4IiIBNcbeWgZkgiPqkqfzMp1sw
 TF/XsKKinzwMY6aBpm+sFzScEhKn2lFbSfQDcO7E72SzjILll4wgiMSNomZj8MEcv1ce
 HB2w2f+dPCuvSP7fu3hGzGPIEjVaax+FMu62ob3WYENRtGKanxzk3yCjXqzxTAkttasW
 /M0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241907; x=1785846707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cXg53sAdYMTmjJCoT+c7TGT3C0eDImHJg6z6/cONmAA=;
 b=QrZqeWhzYywXjeokXYz92PMmRg31lkE511CYSAHJ8kABIrlUHOv85zYV0bcvama240
 C81yqH4746SLE0j6sZTnTmmKx4RQM37EWTN8UbZ4V4YMaNuDGNbZz2BGyvtsFAUJF9Te
 /nOcgbCxeJpkrnl1o8coUX57y91cnZ/BdR5OA2mYQbnCnkWd9IMax6c8ij7TOjn96unf
 SXVgahj59BY01/ktQo4WsJPWKYC/Cu4qMDIcFTow6E+Y0r4E9A461hgTQyjO911W/VpS
 eHQn5uR1aNyiNIYBO045TBG6v7XOYHGyIerHvyZZ/1tAzDdhCda8vPt4/VaoKM5Xvh4I
 o7dA==
X-Gm-Message-State: AOJu0YwjeI99DqkxebiEWj8JI9RQ8LFmlgJjGIKtFFFbrEyp5IDnMY7K
 nQ11Ulkh44SPKgeHZvHXuJVnxCkNevbpWReZZUcnqeBplZk3O68+12fWUkbjfZJFv15ltu4wrhj
 HU9d4
X-Gm-Gg: AR+sD10faJw7OrzfJx/R9vNgyydgs6Vwc9D76sB/iMCumWrQuDEofB8sA/ZafiuC7Kr
 t6tm1EJQZjGEEC4+zTbyRKoxD/vpHaH2147XZSaaQZC98QXoG0fVONuQoC5gAmmTnfwvdXbeWi4
 j0a2VrDaxn4PIBStrBNZ6czSGpbfYn7jtgzlYvdAz3PkEtVUDQiKnTzCRjUWzhZO2rin0j5AzZe
 UdCmRM+e3DiRnlXJeI04LHai5Bth3jwKfXlhPoFvaoWrtfwuXfAJJMDE3FKgCW/p3710bZCcxO/
 uOSXJGgG+Vv0bPwmB51lYby2wYVqOcLBAHkOKMWgCKmFhWpfYg5P2qjPICaLwL+jl7hRgydRlSj
 xsSpp5CaqVtUyYvQXYCDDFQsu6ztJiZtud7debtUVfdb9zggLiN4nw8+8VmufwIEbviWffBzCxZ
 cUxJTM5IMbmqO+UBprBVvpQnkFtR6mLBilyG1yudlRWGrDXesjdtub4XTJ0yB54oZN4UckaFz+1
 /uWYUj9iDJjtQBc08QGGoR2aWz4K3We
X-Received: by 2002:a5d:5c8a:0:b0:47f:9720:473f with SMTP id
 ffacd0b85a97d-47fb1f1287fmr2411026f8f.36.1785241906914; 
 Tue, 28 Jul 2026 05:31:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm58499039f8f.34.2026.07.28.05.31.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:31:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/20] hw/i2c/bcm2835_i2c: Correct CLKT register offset
Date: Tue, 28 Jul 2026 13:31:24 +0100
Message-ID: <20260728123127.1711653-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728123127.1711653-1-peter.maydell@linaro.org>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: botszhuang <huang.botsz@gmail.com>

The Clock Stretch Timeout (CLKT) register for the BCM2835 I2C
controller is actually located at offset 0x1c, not 0x20.

Update the BCM2835_I2C_CLKT macro to match the hardware
specification.

Since QEMU's implementation ignores whatever value the guest
writes to this register, and Linux only writes to CLKT and
doesn't read it back, the main effect of this fix is to
avoid an incorrect GUEST_ERROR log.

Cc: qemu-stable@nongnu.org
Fixes: 9cf3bc65afdb63 ("hw/i2c: Implement Broadcom Serial Controller (BSC)")
Signed-off-by: botszhuang <botszhuang@gmail.com>
Tested-by: Nick Huang <sef1548@gmail.com>
Message-id: 20260724124220.24152-1-22925483+botszhuang@users.noreply.github.com
[PMM: removed commit message paragraph about effects which I think
 is incorrect, substituted a different one]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/i2c/bcm2835_i2c.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/i2c/bcm2835_i2c.h b/include/hw/i2c/bcm2835_i2c.h
index 45f876df224..519c65f7652 100644
--- a/include/hw/i2c/bcm2835_i2c.h
+++ b/include/hw/i2c/bcm2835_i2c.h
@@ -38,7 +38,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2835I2CState, BCM2835_I2C)
 #define BCM2835_I2C_FIFO    0x10                  /* FIFO */
 #define BCM2835_I2C_DIV     0x14                  /* Clock Divider */
 #define BCM2835_I2C_DEL     0x18                  /* Data Delay */
-#define BCM2835_I2C_CLKT    0x20                  /* Clock Stretch Timeout */
+#define BCM2835_I2C_CLKT    0x1c                  /* Clock Stretch Timeout */
 
 #define BCM2835_I2C_C_I2CEN     BIT(15)           /* I2C enable */
 #define BCM2835_I2C_C_INTR      BIT(10)           /* Interrupt on RXR */
-- 
2.43.0


