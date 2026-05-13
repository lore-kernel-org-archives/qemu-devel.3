Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1581ECD4F35
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 10:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN7Fr-0003DT-1Z; Wed, 13 May 2026 06:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wN7FX-00037t-7k
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:55:39 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wN7FO-0001Nu-Ih
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:55:31 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso42147915e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 03:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778669724; x=1779274524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGkrVLFS7cW0IKrQNJ4/JeWHeoQPDU3gaIf/fmkwr+c=;
 b=tCvm3JZhCWvrVP3kstQQZTpQL4KFEEeV9a67zkRz2+r7NJnOom+74W1ButUhCK3qjZ
 sMZL3CmrzDxSd5LqxVPFBJ//1V+rh8Gfz3crfIbY3lKYl4zQvkzAGdMDWzRWr2drCLPn
 qGMrdhb0kdup4jyMez12ulUdmxJVkuC02Mxa9PAhonuJjMrYNUxDVuqwTpMA5vZBo8J8
 uJBAcm6XYRmdb4FOnetGitlOAHwJEsfc4IlCcA7QY/Ne5tcut9wfLabJpIFGNEb7D96Z
 iBSsUjjC8QJ46sPy7QS8ZL2Vvp50NpXtzzuxCZRHrDF9EZB/04rJCPgiC1KWNZXEh7Hp
 e9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778669724; x=1779274524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QGkrVLFS7cW0IKrQNJ4/JeWHeoQPDU3gaIf/fmkwr+c=;
 b=KoowcNZ6FWjren9nTqXAtcw/O7MNOfZFUvM8byzpYwAEw4yjgozmbb5BAGeAbQp++n
 4SDfdANDnQO4vwASwByhcEybZhAeWIGPtzkaRFuhOkLFy72wPfBuIBoGpz76MVLlnj99
 SXqRRutxk9Q/Bexg34u4Lao/F+85Q900j+MSyG/UiNxkEa6et6aI8tjW8dat0bcu7kT8
 2pSF3H0XtsDbKkgGQ0xa67S/VK5maZRqe3XEWynMkA3q/CiNPPIbrDhqYTH6hjfKhKbD
 lduf9Gaul6v0zI9w60UwHLQ5U4eijg/ck1F/jM+hjEg8dITPVjW8yjMXx+CGVCqzdLWQ
 KqQw==
X-Gm-Message-State: AOJu0YyonLXqdYG2gUx7aJ4LbGFGevnKyBYgVnoxpD3L1a+uvCyhq76c
 lXat1EUmENdpzH38LgSzIryrT/bcXm1PJ7DNJRzjTCXF8e9FNoxGGVS8HVVuX9un
X-Gm-Gg: Acq92OFxlwZCbkAZMPyF16digLc8zuPZ6iwHPeNCvsth5+S0RFdDzr8A+BMUbRfHtug
 EFJC9a2XhIiUgWP8qtViMBOoDqM0VIo44hdXSu5N3Lch42aYjuFNhDbkNw2777/9RBspRj7BwOc
 vjzb8815Qxa92L9WId+oQCOIp0vUl5nXFP4+jQuczWcq6ocVUm5CVt/2qf7aicrTJ0mJqcirWx9
 CniBHyJN4wa2OQLJ8m24iqNVekei9/z8uIbtmuvChhIi0bkSbsByGwmki4heYW3QCRM81Dn1lBY
 Wz3H48v3GOdCTUdddlQ2/zyGoVIYlm4Mm6UDzpJJolP588ECI72P2smNIF5gy1d/xoSnzeOWQc0
 BYn8GkNjM/7cr1ue7V0xd4ONbWpvzPj//z+I1QoW4IZqhYO8BdJ2+pxLqR+IYJXDP4akgceZq+J
 Gu/vu0o/67fOy4/NEpqz0eNqb/KqjuPaWaKy5jaOX/N+Ik
X-Received: by 2002:a05:600c:8b57:b0:485:4eaf:eb53 with SMTP id
 5b1f17b1804b1-48fce9f71c5mr34992345e9.19.1778669724357; 
 Wed, 13 May 2026 03:55:24 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.196])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f410d9fsm56062295e9.6.2026.05.13.03.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 03:55:23 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 YannickV <Y.Vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v6 04/15] hw/arm/zynq-devcfg: Prevent unintended unlock during
 initialization
Date: Wed, 13 May 2026 12:55:06 +0200
Message-ID: <20260513105517.146706-5-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513105517.146706-1-corvin.koehne@gmail.com>
References: <20260513105517.146706-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: YannickV <Y.Vossen@beckhoff.com>

During the emulation startup, all registers are reset, which triggers the
`r_unlock_post_write` function with a value of 0. This led to an
unintended memory access disable, making the devcfg unusable.

During startup, the memory space no longer gets locked.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/dma/xlnx-zynq-devcfg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 9708200760..afe6ffd326 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -221,7 +221,9 @@ static void r_unlock_post_write(RegisterInfo *reg, uint64_t val)
 {
     XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(reg->opaque);
     const char *device_prefix = object_get_typename(OBJECT(s));
-
+    if (device_is_in_reset(DEVICE(s))) {
+        return;
+    }
     if (val == R_UNLOCK_MAGIC) {
         DB_PRINT("successful unlock\n");
         s->regs[R_CTRL] |= R_CTRL_PCAP_PR_MASK;
-- 
2.47.3


