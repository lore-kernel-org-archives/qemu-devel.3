Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CADFD1CDC6
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Dec 2025 04:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vS6TG-0001bW-K9; Sat, 06 Dec 2025 23:34:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao.ku@gmail.com>)
 id 1vS5X5-0002r5-Ot
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 22:34:00 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao.ku@gmail.com>)
 id 1vS5X3-0002Tb-EE
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 22:33:59 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7b86e0d9615so5905211b3a.0
 for <qemu-devel@nongnu.org>; Sat, 06 Dec 2025 19:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765078422; x=1765683222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sVSIaBHHB4I/cKA4IxMpB61FxEaOsUyCl0g7ZJyx4/Y=;
 b=cTBVWrA1WPKRSFCc47C2dXM4yrLxY6bS5oJQsearisa8qce5IChFgIdcmGo6SR1YSB
 HApObMH8cgWQgwVHYroTkOb/8n8IUcTtD63hLHEdydIsW0243SszTyWhLUwQRvNg5PQE
 n61T8GcVsNtQUdlQDIxzqGjagyyyg7Oa1OnaH8IkhxG3mPowkZrcXbvgJ8hJQg/RaYGB
 7+oS/kzD4793wxFGEKH3TP5Ys99i6RYO/7U2/3NmUxXybbgMpWuMaRrihvVb2H6B6eVb
 TxR905ITfjSkpuh1DOGH3JsE9BNkUnYMQr52i7cry7AYkwFTXrf5fmma0IPfUhnuzvol
 DYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765078422; x=1765683222;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sVSIaBHHB4I/cKA4IxMpB61FxEaOsUyCl0g7ZJyx4/Y=;
 b=ptpd8F4C3N+aVFl0h4RAbTxFnlk5RTOAk6XlHLf04qXsgbMWSIz5dyszxVlEaRA1xe
 +L5/O8QLVH/Glp0MCv1/LyGJKyqXzZtUjFG4sE2LYLAo35quQ07VuCLmFOyrF8fGypyh
 m5Lm7XRwfMvrh8tqloKwA1PENxV+c0UEoIh49auZ4YZtZeSTifXJCAz+1JOydA/Vig/V
 Vj84WJn7lGZn5mOykY5oFKAMawYOg3mr/Ok+ndiQ4Op6jO7gvK/RrNoS7wLq5C+6B4Af
 79BB9/KSr8CDkJYoDAWAefjvikTJbTOerWZxWkDkzl70zJhvdohBzUf1HPQufmbpWidL
 yBEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmhVHRWdPf7N5zTeym6ntH6ACiKOk2PXKHHyD7yLsqcBIekdeXFdVO5wmFdgVp5+hDmh4epGDMoBpc@nongnu.org
X-Gm-Message-State: AOJu0YwlvMXJU0HWg6vNgG/VlGpbsxLrCruQWRYmdC/rDr4unX94+6kp
 AsaEFfaKpYIDECMzJOcwsfOrGCDoM40U2u5lAmE9uzzi15+CgsUSSc55EQTrx5jLM6i6DA==
X-Gm-Gg: ASbGnctdKk2NySMgSHbaiDDz7QgLpKk9kXHRo+31ntoG8hjlj5KcoEFJjoZONBsHt+I
 Um1JnmhDabu+UQquaJuNzbepIYigOxcfKNiLAKZEmoJOJXdh/s+9uhFE32Fx6fbNMSz8AabBbUj
 c1UdV4rH1Y1Ei45g+Ku3IaLzXVAYavv+FJFJJqrn0w3BrzCPYPLkt9+EoxZ1uBjFSMtpM4MRcmn
 d3eu5zBVECKuKRM4utD/lwzGMsNyxFeNzx2x6Lg+C65nXf1TdxYdEb2pXrIZweWY5lww5mIeGkv
 sbTROEFY5jquT3XdI21u60KlAXLeKLLL3MtqI0aVy8rCtwf17reHJCVXB/qIcSTbizX5OGUugUI
 uXonCujziELIx9O3TaQkwb2rVdiZTD5L9aGPP/BftsrINqOEypDDEagtzQf/wigD0sMdAiupZrv
 CqhSOYeAD1WBJN/NyjSWPKd2wI80Di/Ew7SN1kf8nW7Yqr+Q==
X-Google-Smtp-Source: AGHT+IEGLGrbbVIQ+SP5A8d2M+t/bFTx23pF2qTCzw3x6GZOQL59th29qzBTmk5Yd9wZOanbyZVxow==
X-Received: by 2002:a05:6a20:4310:b0:35e:8b76:c94a with SMTP id
 adf61e73a8af0-36617ef423dmr3722713637.45.1765078422050; 
 Sat, 06 Dec 2025 19:33:42 -0800 (PST)
Received: from nyaos.localdomain ([166.0.199.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bf6a1caeea7sm8496390a12.24.2025.12.06.19.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 19:33:41 -0800 (PST)
From: ChenMiao <chenmiao.ku@gmail.com>
To: zhao1.liu@intel.com, pbonzini@redhat.com, manos.pitsidianakis@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org
Cc: chao.liu@openatom.club , dzm91@openatom.club , qemu-rust@nongnu.org,
 qemu-devel@nongnu.org, hust-os-kernel-patches@googlegroups.com,
 Chen Miao <chenmiao@openatom.club>
Subject: [PATCH v3 0/4] rust/hw: Add the I2C and the first GPIO device
Date: Sun,  7 Dec 2025 03:33:27 +0000
Message-ID: <cover.1765077679.git.chenmiao@openatom.club>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=chenmiao.ku@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 06 Dec 2025 23:34:04 -0500
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

From: Chen Miao <chenmiao@openatom.club>

We have implemented I2C and the first GPIO device in Rust for QEMU.
Additionally, in the respective patches, we have shared our insights and
experiences regarding the use of Rust for device modeling within QEMU.

1. The first patch implements the BusState for the I2CBus infrastructure.
2. The second patch implements the I2CBus and I2CSlave infrastructure, along
   with a discussion of the challenges encountered during the implementation.
3. The third patch provides a set of necessary helper functions for the PCF8574
   GPIO device.
4. The fourth patch implements the PCF8574 GPIO device, along with a discussion
   of the issues and considerations addressed during the implementation.

Signed-off-by: Chen Miao <chenmiao@openatom.club>
Signed-off-by: Chao Liu <chao.liu@openatom.club>

---

Due to issues with the email service provider, the previous PATCH series was not
properly displayed as a thread. Subsequently, the resent emails were
accidentally merged into a single thread, making the review process difficult.
Therefore, resending it and hope to receive review.

chenmiao (4):
  rust/hw/core: Add the BusState of rust version
  rust/hw/core: Add rust bindings/funcs for i2c bus
  rust/hw/core: Provide some interfaces for the GPIO device
  rust/hw/gpio: Add the the first gpio device pcf8574

 hw/gpio/Kconfig                  |   5 +
 hw/gpio/meson.build              |   2 +-
 rust/Cargo.lock                  |  18 +-
 rust/Cargo.toml                  |   1 +
 rust/hw/Kconfig                  |   1 +
 rust/hw/core/meson.build         |   2 +
 rust/hw/core/src/bus.rs          |  44 +++++
 rust/hw/core/src/i2c.rs          | 303 +++++++++++++++++++++++++++++++
 rust/hw/core/src/lib.rs          |   6 +
 rust/hw/core/src/qdev.rs         |  17 +-
 rust/hw/core/wrapper.h           |   1 +
 rust/hw/gpio/Kconfig             |   2 +
 rust/hw/gpio/meson.build         |   1 +
 rust/hw/gpio/pcf8574/Cargo.toml  |  28 +++
 rust/hw/gpio/pcf8574/meson.build |  37 ++++
 rust/hw/gpio/pcf8574/src/lib.rs  | 178 ++++++++++++++++++
 rust/hw/meson.build              |   1 +
 17 files changed, 642 insertions(+), 5 deletions(-)
 create mode 100644 rust/hw/core/src/bus.rs
 create mode 100644 rust/hw/core/src/i2c.rs
 create mode 100644 rust/hw/gpio/Kconfig
 create mode 100644 rust/hw/gpio/meson.build
 create mode 100644 rust/hw/gpio/pcf8574/Cargo.toml
 create mode 100644 rust/hw/gpio/pcf8574/meson.build
 create mode 100644 rust/hw/gpio/pcf8574/src/lib.rs

-- 
2.43.0


