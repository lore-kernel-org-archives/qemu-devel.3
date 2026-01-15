Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030EAD4660D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSW1-0002Fo-EY; Thu, 15 Jan 2026 13:56:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVE-0000fu-Nc
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:30 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV7-0005tt-Tx
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:23 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-432755545fcso788121f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503320; x=1769108120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t1p81LYxQD9tgjtY4PEPaGrAv8vSY3A/eQhUlZgUjX8=;
 b=JFPZ91arEhIrKMtCm2GBxBNleHnd+vc0eqYZ0Qz3KlszENxrg6KhGmTk/Oq0q/0Olz
 95uiUwtI4Php2KWimuMKgI7tiYcCSP/Ie6IYNqMZBChI3RBv3LJ013dNXUB0FM0F4Zxw
 sUV1WmOfEPbDfmWnh3mgw5sBVaeScHAzDVm26478iq4YmhP18EJIvE4eFGVDqZuBdVeN
 QYV/o67wuB5bzfI+6uaueRnmNAvYBN1psUoKcuUEH/dRIhkHUcNFy5tATjc1aVjqDpfw
 N1iPOgIdWw6E74riyj2N0IIkYCiKatiH8wYdl9IWPBqAB32rw77mmNd60RGxpwQ3Bp78
 sCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503320; x=1769108120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t1p81LYxQD9tgjtY4PEPaGrAv8vSY3A/eQhUlZgUjX8=;
 b=lA/5LbUg0IewidF/iVZ9dZKN3QNiQL/vdcPmjUqTDiYyXdY3ERi3PzfzF21SdvvNLP
 /jV7GzxcSP5d514SChrYXmjocqlYKRB1W2YanxamBq7y1uR53lTDtPwqmiJoCkO/Od62
 Fn8YJyIZafXDJomAH/Wf6/mgU5iyAALUUX8gT//x3gZmrRigY3Z0FnSPhwUrEpDg57mo
 8YnjC40Qp3/8XkjNgdOxNk+/xIRWeav/BGLrTjeZ05ffKjJL/2I0npSrgfoZTli/3fU8
 +atl6KmEibWkwpBr7OiYoty0umLMw2ClM3vvlDgheD6MJMIzYee2siO7p7RN+0zGBj+S
 dfyg==
X-Gm-Message-State: AOJu0YxZq4Nka7ee5xIEY0KAHlKr0rLPF7P3MGGvHnWf/2CvcrN/4LS6
 X4nJOvWMT2f6Sla79acGeCRPtzbbZ7nrJ/oK6HCEQnQ4fnOj4LK8V1/80P/K3+cKDv3Whr1NGcy
 H0xZb
X-Gm-Gg: AY/fxX4l44duW3zKfQ/SyjZ2352Vn4wUOgJ64Y4WHHCU1TSl0kTvQuj+/wL0UGPfV+q
 Df9v8zzHyGX55YXnJGtGiTruhaM9ZWRwX/tUQYvzMsBGk1au7Ob4tMbY+d3gDMOZAs/OwQDZv3T
 PrEl8BMPLoMcoxhL+IzVJdzmFQcUka3BrR3Yf1lGvn8OZvjZ0YN54wtfoTMLQbWfYccgr/Qy/38
 xqsCOjx+s/nsjKXPRM9H0LQQ5xc/blhDZxht0ml/tDcG3Dk/bhE3Tdir1kJDwjoChCdIX9j6uE1
 E0gn5NnfA2SBbDi7ujCPXkBSyRU98wQWTi6VBdf17fjj0BkLABd2YHoe7Kmk4uX2fhmukdKPpVI
 OWPzhVDPjJ+95dfP7YHJ4ErzWLr2Rljll1PafElyIWsliAhbNkvSvOHE7p3RmGMpX78Pkne/ome
 1B9sV0nbPhxvhZHwgwnec9a7oKB8IuRv+T52cctY0ADmEzS9yhfFjusCW29qZukKtscUeS44UGh
 AVVP5nLZmL8QjgnIhA/GCGlmMlT4hjPyvX0y+G1i2bkng==
X-Received: by 2002:a05:6000:4287:b0:432:84ef:756c with SMTP id
 ffacd0b85a97d-43569bc7422mr418068f8f.50.1768503319835; 
 Thu, 15 Jan 2026 10:55:19 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/25] hw/i2c/omap_i2c: Remove omap_badwidth_* calls
Date: Thu, 15 Jan 2026 18:54:53 +0000
Message-ID: <20260115185508.786428-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i2c/omap_i2c.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index e0798f2c8a..d6e28a1a89 100644
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
2.47.3


