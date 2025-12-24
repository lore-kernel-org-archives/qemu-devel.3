Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AE9E7545E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 13:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYPCi-00069T-Fk; Wed, 24 Dec 2025 08:47:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYPCX-00068R-Ga
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:46:58 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYPCT-0003eg-To
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:46:53 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so37579465e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 05:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766584008; x=1767188808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z+IZBuNOPG+QboaWGHnTrlcDHIdmkeZi0kJXKjiO6xU=;
 b=UmS+yrEDAZPC5HAIXikNfQCIYPIAoln7SCf7w/kxA/WYB8OC3muMSUR+ioNiuSk7Y7
 tWxODfWMrs89RTTTQc4FrKYIrFj4AKiA2CL7mb1UTQ5Z/DucQOUKptrefqubroFugil7
 gmiGwHaDYbKa1M2LZlNYZI4irxVKRuzjLgW6RXng63gnrWvHW/yTrsBo+prTlsJ8TCtE
 Urq5HJR5tys0i8qp778CrwqbbAGLtaIoMrKDs9kYd1RkZPiYifuy2ogXxq7yDCLqgybW
 X6zh/kQQEVODByyqKEsnghRH1l33E/7hkUs9M6z/1LQTeXMcfB/DPU8wwZSC4GXOsSwR
 y+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766584008; x=1767188808;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z+IZBuNOPG+QboaWGHnTrlcDHIdmkeZi0kJXKjiO6xU=;
 b=ZCjVnx9xAmyB6tSvrPgjBuYFU3kFVWFqPILoWyLtiY1alkDGQ/4lFF5groO7ElxZ6O
 akkm6IvVNxlCHF98nobV3CJiPD70hOESHOeutkFR9UFCk/g/aoqEQIYb2Q+iD025DcFV
 o3otvKzKOR7RwhHsDTR190ogBrA0bwbxTyVQ5Zc/CGbLFUs14XfIO/Rh1qYcC9i+sOkK
 t/gIcsO8+daDQFc38WaCWdBtpED0nFhTZpA/wbyRYdahj7GEZ2GeQ8vzrdGazkUBeZQZ
 5VY+sEf3Le3wZSEVZsufwY66ZzA6TLv9Ri1Qr2CnqIQQ5g+5yqz+B1AWa/SPKOpHLDfI
 bdhg==
X-Gm-Message-State: AOJu0YzXrgQe5X7uZ7pnGFllkji1hOWrpEe5RbXLq7L+Q6skVm6u4xnV
 YQ4a+LsdIXHUnex5tb3XffYdlskUHN7x7OwtnWu+EMM5lCU/z+27pqqyrJmqedIHAfQoBw/n/VK
 7gXgDQLY=
X-Gm-Gg: AY/fxX6I6Vq4rl8pAXgL3UeydujOh5sPq1QTTE8jpGqXgcr3abyRjDJBWkvOGaW/0WK
 7eE+HCqQVe8xZGKmdnH1DEkZSSQLMPA5UYvd6FW4WsauJ1oNl5Xb2RV0/xIHEnf+54yMIDovG8h
 R56uRVUU/+lR8Vb7bxyvif+PKD2N6QRfXTGIsDaEI6deCLSf7UVWIe+7UKck1KV+n3oZ2gzYNUV
 PgkmrUINVQg5rECnb2nIszDWeIyO/tTs+nGDuVCrbVK/XFxT6LGCcT4PhhpUK7MO2eKmjumfmx/
 5TOMI5Z618pvopqI33a9dul57suw4BdJcEGeuBNtMRDG1u3gcLaiUh3QaMKWoNDJZDtMh94KJ7L
 WrwFp+FtJGK29WizOc1a1qFQ+ItO4piuoJAIKMFLkI25v+R4+vshh6xCb7jlg8IqUNCjHVs+rhJ
 uGQ5ByN8CHut0uol0Go6ozLXt5QWacD4wkDfLFy/aTq0eC9ykbcyCTtFCgpm1x
X-Google-Smtp-Source: AGHT+IHM+vUQObUj/5StdfKnJBQzSGRM8rTbcqLoEvJX4N0w704JX1WR+jpj/IkFQ2QzF7GPPp/WqA==
X-Received: by 2002:a05:600c:5489:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-47d18bd5651mr181550305e9.11.1766584007905; 
 Wed, 24 Dec 2025 05:46:47 -0800 (PST)
Received: from localhost.localdomain (218.170.88.92.rev.sfr.net.
 [92.88.170.218]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19346e48sm289240525e9.2.2025.12.24.05.46.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 05:46:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-rust@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Max Filippov <jcmvbkbc@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/8] hw: Preparatory cleanups previous to remove
 DEVICE_NATIVE_ENDIAN
Date: Wed, 24 Dec 2025 14:46:36 +0100
Message-ID: <20251224134644.85582-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

tag: https://gitlab.com/philmd/qemu/-/tags/endian_misc_hw-v2
CI: https://gitlab.com/philmd/qemu/-/pipelines/2231223066

Philippe Mathieu-Daudé (8):
  hw/arm/Kconfig: Have FSL_IMX6UL SoC select IMX_USBPHY
  hw/net/opencores: Clarify MMIO read/write handlers expect 32-bit
    access
  hw/char/serial: Let compiler pick serial_mm_ops[] array length
  hw/misc/pvpanic: Expose MMIO interface as little-endian
  hw/timer/hpet: Mark implementation as being little-endian
  hw/char/pl011: Mark implementation as being little-endian
  rust/system: Stop exposing bogus DEVICE_NATIVE_ENDIAN symbol
  target/hexagon: Include missing 'cpu.h' header in 'internal.h'

 target/hexagon/internal.h        |  2 +-
 hw/char/pl011.c                  |  2 +-
 hw/char/serial-mm.c              |  2 +-
 hw/misc/pvpanic.c                |  1 +
 hw/net/opencores_eth.c           | 15 +++++++++------
 hw/timer/hpet.c                  |  2 +-
 hw/arm/Kconfig                   |  1 +
 hw/usb/Kconfig                   |  1 -
 rust/hw/char/pl011/src/device.rs |  2 +-
 rust/hw/timer/hpet/src/device.rs |  2 +-
 rust/system/src/memory.rs        |  6 ------
 11 files changed, 17 insertions(+), 19 deletions(-)

-- 
2.52.0


