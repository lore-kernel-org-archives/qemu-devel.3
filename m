Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FB0CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCNCs-0005tt-3Y; Fri, 24 Oct 2025 15:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNCp-0005ss-Iv
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:12:07 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNCm-0006EB-64
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:12:07 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47112edf9f7so13929155e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761333122; x=1761937922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khQ4f+JLpb7fh8Bk0A11QSSL3qpoF8Qk2ODQYUaP4ck=;
 b=ALG0TTGap+2fbqxReEqD73Rm+xljM/4kQC1p3bfSPq80OflGJXJ347XZdyByBrUCyP
 z8aYhOCh2SXFuI/FgMJfJOcQGqbg0VkECyL6VB+5yNba7NCDljv9UXxaUMV2M4x7SYLl
 0FYHMwJ4lSPXkDP4rxwO67puYTYdY1obr2QeWVbcKwyJHQXObrh2ORXEjzpVZLBAjKbT
 MWNNHvI6gMjsDrOdqsCmCGWtPckBcrUOxlMmzdMu/E4mXmKHhgrLxLj/SfqpMxCWPp8N
 mhL41+YwznCMK2VLTQhraOLd5xtRC4FASB0vorqvn4paTLVAGN7/YRHo88WldAT6ieio
 NknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761333122; x=1761937922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=khQ4f+JLpb7fh8Bk0A11QSSL3qpoF8Qk2ODQYUaP4ck=;
 b=flm1xVw8lxwmePByTPe1cMs75rNE6dzhUWucTR1w/Fd5onIdIRfFlNqwoK3oEKwT1l
 8bvrbnTKJXeOm+CmZJWIzw0+zrNO6ocThild5L2xhh2Up7FD+s14PSuhCUqcGXPcJH9a
 BN3DJyrKTqAkvWxi+0kgIL2xcnQ9EqcFex5vGAQUxh/z4tcPNsCz1Jm1kW54IN07C+YO
 D+DiseSvr8xu41CumoZKxwORCYUSqrQdihIy+3M5qAfXFzVhGUrWklLnye7/TogIlDHE
 KVoGB2Kj8rx79BcrEdFJ0n9RP8hrvdr36faPOH/YxeqSWB2lftYTp1Fkw0Ayn4Jl4s/w
 VctA==
X-Gm-Message-State: AOJu0YyjO2CsETP2/R19ARTg5ZXrrHx6E+cH7xoQRt00ilCYNCvq8lY4
 iK74NKzaP9hwCYDhV/naTe/WhTGmU8wt8LGPX2aiplDdhNwc3HHd9y3KUkV3WNeV9qc03ou784x
 ZPxZeaXI=
X-Gm-Gg: ASbGncvAnF2ZToA/X8WVsbecLZXMe7DYCpD4Lw+BOLCJTkflSh0csIR1xXI8ze4qxqS
 DAc/2+AdxDmuEX+pSF5GbmBzXXh+culCwCufSHMp/NSPgtgjLauU0yDMT4n8IeonEv9qrTr7Fjj
 99PAUQs2Rr6SUxGAVaDfLp3ezF3FNVD+hQRm6Wt0PVN8W1Oz//EZOAjRuUYEqJ602voDAR+wlfE
 n60wWVbfJRWs9+ygk8RarWw+0G43gy0dPqvpQfXmQ/2vFpkk3vzesV703tJgeZ93JoqzUkyktiE
 dgBk4QSc0jzUXybqNdGS5SedXNzcIFWuGLRHxfy8mfrfR3dHcxSdDdq7Do1LVh8PnrkxHqQYpDH
 KtZGZIIb2MFCGJ+kCRn34+pUn98Vq8PiAPJEFBU3i+OfR+t++hG0+Lp083Erf/ihvadpljkvUz+
 tBkgPpJkXlfW1BpytU3JhnrlTVb/0a5Nojwabw9mTZ4i4hmGE98cxASRZ095qMjrIshOU141o=
X-Google-Smtp-Source: AGHT+IHv4l1XosmJ+AbMe81Cl8qn4LTSeuXJyvjLUOdckWaUg/XuRfICJNFoWIyYFbUOLQVYHPdHwQ==
X-Received: by 2002:a05:600c:4f09:b0:471:a73:9c49 with SMTP id
 5b1f17b1804b1-475caf930dfmr70530855e9.2.1761333121675; 
 Fri, 24 Oct 2025 12:12:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475caf15b10sm123156845e9.11.2025.10.24.12.12.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Oct 2025 12:12:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 05/27] hw/timer/hpet: Use proper SysBus accessors
Date: Fri, 24 Oct 2025 21:03:52 +0200
Message-ID: <20251024190416.8803-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024190416.8803-1-philmd@linaro.org>
References: <20251024190416.8803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

SysBusDevice::mmio[] is kind of internal. Use the proper
sysbus_mmio_get_region() accessor.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/hpet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 1acba4fa9db..4ed79d72620 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -655,6 +655,7 @@ static void hpet_reset(DeviceState *d)
 {
     HPETState *s = HPET(d);
     SysBusDevice *sbd = SYS_BUS_DEVICE(d);
+    MemoryRegion *mr = sysbus_mmio_get_region(sbd, 0);
     int i;
 
     for (i = 0; i < s->num_timers; i++) {
@@ -677,7 +678,7 @@ static void hpet_reset(DeviceState *d)
     s->hpet_offset = 0ULL;
     s->config = 0ULL;
     hpet_fw_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
-    hpet_fw_cfg.hpet[s->hpet_id].address = sbd->mmio[0].addr;
+    hpet_fw_cfg.hpet[s->hpet_id].address = mr->addr;
 
     /* to document that the RTC lowers its output on reset as well */
     s->rtc_irq_level = 0;
-- 
2.51.0


