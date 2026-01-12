Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84236C9EC8D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJKC-0008LH-Bw; Mon, 12 Jan 2026 09:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJr-0007qp-79
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:55:01 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJl-0001dP-Sm
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:54:58 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-65089cebdb4so8640663a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768229692; x=1768834492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vae9tFKipWcRHp6Pwi3fV7Q94asRnHBvfdec3wvV7X0=;
 b=VSLnl5zWu8g0+7bqphvX/i8TFE3e8n0Xh91Hrz1SRYL5m0Z1LIyN7MdLusBTB0sllW
 jnNgKVzGamopC/BXzPvkiKO5YoGzUV3yZDUyeLPjhjl9dUF8vHN8absKh8cmlT2uRV2I
 tfGZjgy0pvMplacU/jNxEzKpPJ9hvT+dVEv8/yMNofHobUEhOCgJ7oJ5l3BRwBtpw1my
 yDZmOpmIZP9jad89EOietJE2HMRLZlMG10ISTn/jQldHJIcX2ycD97G6bfVCFQo29uh9
 TcMxeoC0TXNLcFyUk+UnTDUqRZRy8Bfwx0KEx8TIMPN/sDBQ3Mq4pUP/0+4ueRb+oWR8
 rXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768229692; x=1768834492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vae9tFKipWcRHp6Pwi3fV7Q94asRnHBvfdec3wvV7X0=;
 b=q+oKfdILbydfBSXWasGgL1OeVgNV57ii5YQC8AGsH4Ambdfukcu4RwrhPiW/keKP/r
 hW9we90lkHN/4wDUD1QzitAUQ3IEnofEeIS96a6J+Kk14JolSKUGmnLidxHpbWS+2ytx
 x4RRx2YENKV/lZGEcRAv3gKCHp9FKXbRvxTLFbdUaR/Q1iNg1OBqVYmizMGcSmL9y/Vw
 WmRTmZaUMwswwWyNqCShtC7hKYo7zS4jEIQpdLooxvF+N/Q8pe1q5WGNPodQGHp7CX/E
 7t8XuATXtoIDt96CdbYfBBgq2IVrGH3wkrvlHW39S2fKngtMW4ePgVMEOkEevZqqrk6o
 cBug==
X-Gm-Message-State: AOJu0Ywh0v9dzN2umemA+FfnxCXxhcBO/k2r7UAk+qoi9iLCAMXJDld9
 uETcIAldvtThvBxoW7UwDu9LhkmPV4Xq4U7I+LK+jefHLon5wIyxG+OA2RuWEBbi
X-Gm-Gg: AY/fxX5vUFyNZH6UzRPjywt7X49dNKqactR3Q5jqr9eAWeKieFWVC9ikeOSPM2R6bg3
 HAC6cLGGOcOSgW5oNXSgrrxU7/boTa9Qv0CsGpAggmOOfBD1BfDraFgV0gL98ZJcvCNy8i6dBEm
 SR1/xu6Ea1Hoke8efGcCAWgyH29hcfpksNude8nnMsy7GyF6K3cvRsmAiCRmzYvwIYxxz4BXRpK
 G+CvbU45ERn9osHcq4rv6wVm/A4uf662QQZYve0lg/lvoqVxu7dNA+kJnGqnpZkBXGxxq8dBehP
 mXnOiLQ4xIohigdqfIHVYVl42B9NMw1gJV5NfNQxV2kIwc8VHgvEjAfO6Yn390yGSHQRlH1z7F8
 BIZgZkOEH9pmdui8HKZ2kgYQCBWHWNy15lMhhUO46oJgp7f3uu7RJ8PnGKEVSrl0Dq0JpCrjXpE
 hVnrr8ThmpNkYbLyFVt31UyWsfv2xfWeX0Yb66iiLFd+DU7VMi7+CA6D1Qyp6yDGf+OpkIWqcA
X-Google-Smtp-Source: AGHT+IGyuG3YbVzCEJjBV8WcMWIzeNjwbNjEW1diFhtb9EUGoLtMrPtxrUUIbIsBg8ur63ED4UY2Lw==
X-Received: by 2002:a17:907:d1d:b0:b84:2075:b902 with SMTP id
 a640c23a62f3a-b844534526emr1714653566b.36.1768229692047; 
 Mon, 12 Jan 2026 06:54:52 -0800 (PST)
Received: from archlinux (dynamic-077-188-226-222.77.188.pool.telefonica.de.
 [77.188.226.222]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8731f0718asm37387966b.67.2026.01.12.06.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 06:54:51 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 Bin Meng <bmeng.cn@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH 14/14] hw/sd/trace-events: Remove redundant "SWITCH " command
 name
Date: Mon, 12 Jan 2026 15:54:18 +0100
Message-ID: <20260112145418.220506-15-shentey@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112145418.220506-1-shentey@gmail.com>
References: <20260112145418.220506-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

"switch" is already part of the function name. No need to repeat it.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/sd/trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index d30daa2143..4ec52d2a81 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -58,7 +58,7 @@ sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t
 sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint64_t size, uint32_t blklen) "%s %20s/ CMD%02d ofs %"PRIu32" size %"PRIu64" blklen %" PRIu32
 sdcard_set_voltage(uint16_t millivolts) "%u mV"
 sdcard_ext_csd_update(unsigned index, uint8_t oval, uint8_t nval) "index %u: 0x%02x -> 0x%02x"
-sdcard_switch(unsigned access, unsigned index, unsigned value, unsigned set) "SWITCH acc:%u idx:%u val:%u set:%u"
+sdcard_switch(unsigned access, unsigned index, unsigned value, unsigned set) "acc:%u idx:%u val:%u set:%u"
 sdcard_rpmb_read_block(uint16_t resp, uint16_t read_addr, uint16_t result) "resp 0x%x read_addr 0x%x result 0x%x"
 sdcard_rpmb_write_block(uint16_t req, uint16_t result) "req 0x%x result 0x%x"
 
-- 
2.52.0


