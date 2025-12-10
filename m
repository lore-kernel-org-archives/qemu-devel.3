Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A11D3E771
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 18:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTP3n-00011Y-Mh; Wed, 10 Dec 2025 13:37:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vTP3l-0000zU-Uf
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:37:09 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vTP3j-0002QG-9w
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:37:09 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477bf34f5f5so1103675e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 10:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765391826; x=1765996626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fG/gu0LeD5v9nk/CxhJjrI+Pm2/1k+dVpVQVmGRBqxg=;
 b=O9htXtaeM+2NVyu+9C+1jBV0n8Rni0iQwr9LQqLgZluKIfkmltjwalwkN/hkJbKGb1
 b9Hs0ta93kRdIRX0SMt+jPjquhYANIjTE5L7VEKbrXT9lgyjquKOkD8ehp6Qdiy7tdIv
 ha7rN89t8bkX/ui5VlrLrvCt0VYmIIpq/tFHetoXO0o4cyaSZtSUJX6Jpm7bHLsK44iV
 Z4YwII4BMxrfVgkEz0RngvFabJsrxzLA2+i6jwKqhgaGSD3/ci6+G8jnIkvHu8JVw+by
 Kv7u2Cmvh0ExW1RAC98kWmZTuOpVM6760EOqXpDN0RrloSxId7aDw4ziZ3/RCewA/O9k
 41fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765391826; x=1765996626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fG/gu0LeD5v9nk/CxhJjrI+Pm2/1k+dVpVQVmGRBqxg=;
 b=rV4hz1MlZHJ/EJmFnFFFUigDTe71MfY3eTUcH0bF2Ta6zikGviMYb/VZC21seTG3U0
 Cysj/Mp8h6SSBXdgcvAZ6XLHmxQQll8UsfTETkJiXypkPEcgqys9bb5kUt1f2AFZ6scy
 iXx3z5XrN7uZoZuf6ZcCmaXSRaolOv4vy+tMAoG4DwxT8NZK+ykhfLMbyIeaC+UwoQkF
 V4LI29AjhtH4U00VKXRHhcOT3WHmQF95z1li7krcOOT4iI5vl/FtCd2NjYphh0Mfb3Fn
 4gr5835f3sD5XpJw8TDQIPF24coZXU+/hJrRxbQxtOl90QiEFK5JWNeNn40dNegYOvYY
 UYxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdlr6P9KXuqPU10RWw7NFLJkgzVc+HIcZiOGOhQsEqDSLN4vuFz37CzFqvAHXlmP62ZscQwZW0xkfM@nongnu.org
X-Gm-Message-State: AOJu0YxRFdqnX3ltCwB3iNMSU1QUwmJ/y2mDbb+da57GExKLktiKr2P2
 wkVT5S3ArCA4RaHJXDtpRAiHyDZ6GGRGX+0M7/Nj6A0fsobbqMXhQRxQLQH8GIRycIiOG4PwTaO
 VQydx
X-Gm-Gg: AY/fxX5nV4YyTNIY+odxsmpvsfUXSa4PGU3BKIaZFDud8lUVFuZM73NEVb3p96Ma0Y1
 uMHly2ZPcVbSgsOQ8pt4y7DrCLRSNyD8aU8WB/Z3e3ciIoFjjzdq0NXtIgqHKwDEKX2kzfDrzbE
 0NtkHqAnZjx8QMibxQ78wGa+U+zZhLRUa6XAI3ud+T9QBQPxVMIybnPfjdzn9rOshzkhr1ZnHsm
 XgOrDC6Lajf51jq4bmw8NqlsuNutYYfglZCddYsa0UNs1JbdcG0VfSo8S4Ba0messpTHbrmb3Yf
 Jt2lFYzTdzfJ9Qnhd+wqT/CJqz5mb7EE91kX17OR0DR2hfNVa1Y6vPfTMDSz0RJYad3BvbKMQ9j
 MkTnBzm91K3Av2pD4Q/6MnRh2cBAcCIR/SR+bx0+wu/J+rV/Cl4DTg6O/pc3qocDKms8XHUG0XN
 n/jZdggmjiY+aDH5BfDAcbXA7GBUg=
X-Google-Smtp-Source: AGHT+IFIuPNseeW6DRMEtziMjvkY+W7bylAb8pcQkbEvEsTd6oJmlwC279VLSyepHX4q7A5rTqks8w==
X-Received: by 2002:a05:6000:26cd:b0:429:cd3f:f45f with SMTP id
 ffacd0b85a97d-42fa39cc91dmr3402890f8f.7.1765391825564; 
 Wed, 10 Dec 2025 10:37:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a7044csm477702f8f.15.2025.12.10.10.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 10:37:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-11.0 2/7] hw/i2c/omap_i2c: Remove omap_badwidth_* calls
Date: Wed, 10 Dec 2025 18:36:55 +0000
Message-ID: <20251210183700.3446237-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210183700.3446237-1-peter.maydell@linaro.org>
References: <20251210183700.3446237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The omap_badwidth_read* and omap_badwidth_write* functions are
used by various OMAP devices when the guest makes an access
to registers with an invalid width; they do two things:
 - log a GUEST_ERROR for the access
 - call cpu_physical_memory_read() or cpu_physical_memory_write()
   with the offset they are passed in

The first of these produces an unhelpful log message because the
function name that is printed is that of the omap-badwidth_*
function, not that of the read or write function of the device that
called it; this means you can't tell what device is involved.

The second is wrong because the offset is an offset into the device
but we use it as an absolute physical address, so we will access
whatever is at low memory.  That happens to be the boot ROM, so we
will ignore a write and return random garbage on a read.  This bug
has been present since 2011, when we did the conversions to the
MemoryRegion APIs, which involved changing all devices from working
with absolute physical addresses to working with offsets within their
MemoryRegions.  We must have missed updating these functions.

Replace the uses of these functions in omap_i2c.c with an
open-coded call to qemu_log_mask() and RAZ/WI behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i2c/omap_i2c.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index 751bf748fd9..be2b7eb5306 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -441,7 +441,9 @@ static uint64_t omap_i2c_readfn(void *opaque, hwaddr addr,
     case 2:
         return omap_i2c_read(opaque, addr);
     default:
-        return omap_badwidth_read16(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 }
 
@@ -457,7 +459,8 @@ static void omap_i2c_writefn(void *opaque, hwaddr addr,
         omap_i2c_write(opaque, addr, value);
         break;
     default:
-        omap_badwidth_write16(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         break;
     }
 }
-- 
2.43.0


