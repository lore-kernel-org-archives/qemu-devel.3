Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C811D6E2D2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 18:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWIah-0006Oc-Fl; Thu, 18 Dec 2025 13:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWIa2-0006NT-5L
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:18:28 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWIZw-0002xV-LF
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:18:23 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4775ae5684fso4102665e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 10:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766081894; x=1766686694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dw4q2naf2RC86eEOqnqVmtV2ZylVV7dCJMCaQlNiUTI=;
 b=WTElRp1LJ+wUfftgpajnndb1Q6hyDi8gXhatIXsV4Xxr53xuIVdQasX/d9TILlf6DG
 RD3MrauZP04VUvyLANb2NxacKZocnLeYfQ4eCfEH3SYA77S0ShTWuSQw0/iAE+z1CK6l
 k9TlGbNxGJlw++IfuMsx+f9kbQPwpsyuU5Qxi4wgPjcU5eF1UYxnccpxWs1+p2/H4RoJ
 MC0KvVrkXZMmpWuJCtWeQacES5SJ4hm6p6hWJt2L/dCteREO0RsvnFyI0g1zcVo61tYY
 b3FRAO6zIeHcgiFEFDqR70yxePbvE5buZoKHN4iB/6zIDzLg8gEkRAPckJXAUvcXAs1V
 M0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766081894; x=1766686694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dw4q2naf2RC86eEOqnqVmtV2ZylVV7dCJMCaQlNiUTI=;
 b=dNEf+l3DWPTtYHtl66ohC3VjDYAqpTw47dPLGzL7MuPEFa7XrGByqCKoOKuZuP4oU6
 i6SHnqWmbi8tw0p8nNySggpvt9W/IEgBV+3Yj1IT5sF2VbD53nVbeEpUeXe6rGdN8qUv
 AjHk2FnkB2CFm9Gu7cW+arjZvgugcRf2eJ9A54xmz9955WQKWuPbHzcdN+/SqIwZe4ln
 sNbDPIhamShoXZwdsHQnnMKERtn96zZAh73YfuGjh4L7OnyL/xYz5pnpeMg9kLPN8rle
 6AegIHNYImYe9Qoc5LJ/i1F7HiL5c0ZFx/DYQXcNXXBwHAwaPooomoUgPhT3CisVFAsC
 MMjg==
X-Gm-Message-State: AOJu0YyHt8nMZ6D7XyTeAsO0JcOxbs/yHMtAebEiCod9FTB6HmpLH416
 lqZ2y7YUc5wll40+3i0iRhUlYf4hN9msNpwb+KC5t43xo8XBj2Bu38LTrL0bVED4SHpU4le5TQf
 dBp7emWw=
X-Gm-Gg: AY/fxX7TUqr6eNN8L813X9L9Tk0m1cRbU1ZcI6Ql1ueJyPFWdLkGIVH6SqE7Ahq8D+q
 EQs9yku0gBXO1CdR2iTSz0rHQx8bIWAF1CTJ2s1IbhP+L1SJMNjNe//TO4Yp/RccugwJ7/MtUFO
 Ll1YLSc1n5bnzQtXOuodLu1QmoczoCA+wKmBPzf+rCcIOXkQr3/gbKJnPzRJphZZKzszzVDYv8N
 GY1VVF3RtNhJFhAleU5FMss1u7X7cC3Vk798VNbdRR7eB2SRF3ePcFa3i+GLM8bXZ1Fzm9sNYQ4
 cXryjug+VdXsG+WFTpS6ctOkf03FUwk+p56TV4FeFuOeKcC8wuNOe+3G6BKy/1471TMehQnXUsh
 NrmvREMn1oVIyFjCjCEFYTyjwPtjgh6sCr1Wu9VstVbKpUD/XNtEkIPcAh1WDV57oRQC2hfcvIO
 QxbKfDBkmiAmLJmxzoOKMOXRQfVyUq7KybPcuFqxUnmQm/KmFvxq5yys4XEASv
X-Google-Smtp-Source: AGHT+IFt3I/PPxUr2BEmKrZ7ygpqyt2KZOxFv9uczbyIybgLHrJfKrapY8KpeMlDkyMUJ89/CJOvFA==
X-Received: by 2002:a05:600c:3b9d:b0:459:db7b:988e with SMTP id
 5b1f17b1804b1-47d19555e07mr1067575e9.13.1766081894494; 
 Thu, 18 Dec 2025 10:18:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa64cesm200859f8f.35.2025.12.18.10.18.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 10:18:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/6] hw: Preparatory cleanups previous to remove
 DEVICE_NATIVE_ENDIAN
Date: Thu, 18 Dec 2025 19:18:05 +0100
Message-ID: <20251218181812.58363-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

We want to remove the bogus DEVICE_NATIVE_ENDIAN definition,
by making it explicit (either big or little).

I'll follow with one series for each architecture. These
devices seem used by more than one, so I took them apart.

Also remove from rust API ASAP.

Philippe Mathieu-Daudé (6):
  hw/char/serial: Let compiler pick serial_mm_ops[] array length
  hw/net/opencores: Clarify MMIO read/write handlers expect 32-bit
    access
  hw/display/ati: Access host memory as little-endian
  hw/timer/hpet: Mark implementation as being little-endian
  hw/char/pl011: Mark implementation as being little-endian
  rust/system: Stop exposing bogus DEVICE_NATIVE_ENDIAN symbol

 hw/char/pl011.c                  |  2 +-
 hw/char/serial-mm.c              |  2 +-
 hw/display/ati_2d.c              |  2 +-
 hw/net/opencores_eth.c           | 15 +++++++++------
 hw/timer/hpet.c                  |  2 +-
 rust/hw/char/pl011/src/device.rs |  2 +-
 rust/hw/timer/hpet/src/device.rs |  2 +-
 rust/system/src/memory.rs        |  6 ------
 8 files changed, 15 insertions(+), 18 deletions(-)

-- 
2.52.0


