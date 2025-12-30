Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B059AEE01F6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagyR-00085k-Ke; Tue, 30 Dec 2025 16:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagyG-00070k-9x
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:09:40 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagyC-0002LB-Ju
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:09:34 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42b3b0d76fcso5904531f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767128971; x=1767733771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mJcdNi7cESlpTXpcLSi0wl3ojZ5ipv+IdVxBLAwJeR8=;
 b=vYVEv5KCPXwJ9ZlH5yTvnpoHT++KQa7WYPR112pzGq/+DZlqHBhDVb9bpWezrzmewJ
 6OlTJD6sphvi9KiLM6qORnT6Ft13BsCz3TYGiNrYMofsxVNxsjXWFq3kR5atB21bSRym
 90unBmp1QenGwKA0eBXJgMPo3V0zccIOugTLc0ZjMTilVOuWJGQzbO2YmqfFMhcw1wxE
 FX8qzXwXIus89Z9HWU/EOB3+xinq/xmZnFIHjuy4ARcbwvc4npSJ8iR39AKaQpPZ7SFg
 dMU+Qz3WX8g7wVVWskFgxiyx/ZvcQS+1BhdLQaPVK3UTYQX01DI83EKz352YfY/vCmND
 g+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128971; x=1767733771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mJcdNi7cESlpTXpcLSi0wl3ojZ5ipv+IdVxBLAwJeR8=;
 b=MNCjWY3KwwIf9DPymNYK1fdBm+w401oljJ+2tY4ijGDfEzQJC14fPW67yiVfs4pArl
 Fw7x/Ek6bVh5bNUaOBDyWqBf9RwtK2vp2Ig8rnihmp7JTFsBHxdRx/WukDW7rmXL1oV3
 oW4o45mBFXRbpEIuDkQtiNBcgW4ezigZMBjAzB4tyWFSdM5gK5FX5WH0vfymnAG6oVJb
 9aWmCwdZuQCBG5fMiW0IC3PKiyoM0uRlHjEjxLtR5PXYCZhHfJLsQ61tcOzJp762m4oE
 GpoSpoXIQrMAM2HRZXaOtNXEsDT1Ll5U+LMEdR63hW8bnasPxmSlIO4YtAPCnRyRhaFV
 mTPA==
X-Gm-Message-State: AOJu0YyUVhVI3tysHUbQlbga4+DsIxK49Aj9OmPwS23frgiVfoNVhrne
 jtbjybgqDbr0wGktDXp6+TAGjMm4tf955Z97L8q/2xDV+O9XjYgB4QMkY2nadYKjO0Ccc2f++iY
 T79jmC38=
X-Gm-Gg: AY/fxX6lkdFIJy3Hl9wQSoUVK23qTiSe69DcgWOMmUhWGKYfqjmbDfamSRUNqY/fBoN
 7Z+JqG5hMLqbJycr4tCPaaOEsCwejonG41l7xUJcuO6MiHj00dN4JC5TieI7xVLOET9ZHfQDz+w
 DdDGUw4SOtQaQ5hHIYWsPXB8nE0T1oQwVSH2wv4eCckcuQJ0Ecv7/hhIDTBhWX8qbEesEJiPKIK
 YkMi+dqZOHlRPQJawTp+AyYPUSvG3wtmIPPUFmoAE9mz+6tTq649YVhPu/FKO2YPQ8vjSUxawp2
 Y86V4y4cCKh7ZhwZoB7kF9z6rLiS8p+HkchFsAoYXVwwTn5DtUiP6Pi/bcduCbPrkriasl0qfb5
 A53LOM47sIQLN6JypVDkluABtZkaphquQQPy9Pxs1xCKFzRHDpp+Tc/7ag2kd4jVBwYl7Dm1RMV
 d/cOHITnNlDNL/6esjD16q0SL0ZawacSx/D7wKPD2EX1/no72YKrJ25iOgtYiQ
X-Google-Smtp-Source: AGHT+IE3Tp52NTXgfyzTAuLHeHcKPhMhAKpArIzI4SA60Exwe7ML8nk7xXTWUGybBbXSM9+B1eelFg==
X-Received: by 2002:a05:6000:2002:b0:430:fdfc:7dd0 with SMTP id
 ffacd0b85a97d-4324e714856mr39491042f8f.63.1767128970756; 
 Tue, 30 Dec 2025 13:09:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1b1bdsm69743829f8f.8.2025.12.30.13.09.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:09:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/34] hw/char/serial: Let compiler pick serial_mm_ops[] array
 length
Date: Tue, 30 Dec 2025 22:07:36 +0100
Message-ID: <20251230210757.13803-15-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

No need to enforce the MemoryRegionOps array length.
We index by device_endian enum, the compiler will easily
pick the correct length. Besides, this allow further
adjustments in the device_endian enum itself.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251224134644.85582-4-philmd@linaro.org>
---
 hw/char/serial-mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/serial-mm.c b/hw/char/serial-mm.c
index 6e963e581f9..0e0be26fa9f 100644
--- a/hw/char/serial-mm.c
+++ b/hw/char/serial-mm.c
@@ -44,7 +44,7 @@ static void serial_mm_write(void *opaque, hwaddr addr,
     serial_io_ops.write(&s->serial, addr >> s->regshift, value, 1);
 }
 
-static const MemoryRegionOps serial_mm_ops[3] = {
+static const MemoryRegionOps serial_mm_ops[] = {
     [DEVICE_NATIVE_ENDIAN] = {
         .read = serial_mm_read,
         .write = serial_mm_write,
-- 
2.52.0


