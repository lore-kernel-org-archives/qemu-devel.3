Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764BAD116F1
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Nov 2025 16:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPNy4-0001P3-WF; Sat, 29 Nov 2025 11:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao.ku@gmail.com>)
 id 1vPN6i-0001ig-RZ
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 10:43:32 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao.ku@gmail.com>)
 id 1vPN6h-0007Zb-3u
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 10:43:32 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-343806688c5so2004205a91.0
 for <qemu-devel@nongnu.org>; Sat, 29 Nov 2025 07:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764431009; x=1765035809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5nSftTRhbYPZyAHoOCrUDgyrMu/ocklATRbEjkcpSxo=;
 b=HUr7n9QPC6BsjAgzzFu3swjZBZeL6kL0R2+0BmOIxACS0abVY5q1dlNX9rpeRPgTQL
 bM7tN/bWapDzT76PktAAJotE/dFLJ7uyGZYQjlS7stMwxhaTPln6HlNG+x0xH2Vy+Lh5
 TalXg2FmU57sHxFsrvOU17JERtCBl6qklZO9yBEqUNQCLeZ8p8rWi9OZr/GXOj5XfN/I
 Q9sZNx3Uui0YofL+BVXSs5RDdsyi48vUciSMlOAXwfqN7a1ZmDNTvFLnC304Ell4Nwg3
 u31qtDBM8EN1rXBOuIcDQATwlXRptVv+EcRkmwg7l+1+VwiZ9Dafo3EulEnc9CFCOjOD
 bfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764431009; x=1765035809;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5nSftTRhbYPZyAHoOCrUDgyrMu/ocklATRbEjkcpSxo=;
 b=JtKhvVO1QEb3zKxdgMVzeNXTAu2SmKDjXTrcuei3itPhzGGj8213W8pF410s7iPkeE
 CEQmuoAh4Uy6/66NMkW6j9RslI+JaFSJqa8wr3X12QOHLYsuy537vmCniUhEkpRMem0g
 7YEVRo91zU5eeJiOhlrMLFSYOyuMrnqnR+RrBEu63hXpgK5uWAD2+0Kr3wwXFW31AQlp
 Y4SUo/bxMQVX9qVtQCX8UJMwLd+xtoMJU01zI5haEM9+TRW3szy4asedWcoJrVsZs0m0
 z9ibYAVG2rGNzc7U63SL5v4nU+vPGVB8J5YOBmSzFUIsH+iNujqZAq9kZPTQAIPQV6AA
 veJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEAPrluTqyROJRI5eB0zUigbLy4dnP0QlZ6j03vQYark/T928K9XV25oIBKoBGr7/sKiswSNGCGh5X@nongnu.org
X-Gm-Message-State: AOJu0YxGBnEcH2t8HH1yyw5kyEPQZIanBhrK1h3OopqgVTvS66kO7gz4
 k7bbVP447bHDKCEy8u7U/UpXuvd439Ke6ycAzoIoSRzu4w3OfTFCrHD3
X-Gm-Gg: ASbGncsoWVHed29kATMhfVID2wpB8peOBcadXmJ6UXC2uXi/EBKM4txZxky1ysq0Em7
 MujLSlHAfG6mEKk4EUKTzX99c3S0/TtvY+hrlsPQImyu8KSO5fzAeM78j/WKks6THh0NdN8P5MK
 DwG1HZo0u4QYQSRq32cFxfLhoF/Cn8cJqndGIsJtTozYRVJyboccHWVlpnNqu/RhyuuyISWf+5C
 6sq4OPGu3ol3gOEL9JvLvIFVQtCAQ/nLKHdrVeYI5nlOc5pGIXpBhe6P+RaKIRSRoTLE5uUDcsf
 aM9rCmGdzIpzmoi2LAqtE+zL14VZnhik5KIu90LUchs6TbihCj7H+37EN1Z28netxXJlI8EnFLH
 eI3PNgScUyEd4e1zk4UiuyWa4NgFQIbirJOAMUArzvJ4wc8VBJV3bke4z2KYgfemFFmRrWlny9z
 lWPmQ6UJ76fWQdr1KqAwQzwh5Xqt3N5LGip8rqZgWQUgFCo5ub8V2tICvb
X-Google-Smtp-Source: AGHT+IHHL5ZmRNp1NMFjTfm3b3TSsb9Qi0gL+rxXqSijfgsmhnkf7D+JxcxyxSMqUfK/XAPpyeK2Lg==
X-Received: by 2002:a17:90b:54cd:b0:32e:3552:8c79 with SMTP id
 98e67ed59e1d1-3475ed6a4f9mr20375585a91.29.1764431009115; 
 Sat, 29 Nov 2025 07:43:29 -0800 (PST)
Received: from nyaos.localdomain ([166.0.199.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3476a546ed0sm11799767a91.3.2025.11.29.07.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Nov 2025 07:43:28 -0800 (PST)
From: ChenMiao <chenmiao.ku@gmail.com>
To: zhao1.liu@intel.com, pbonzini@redhat.com, manos.pitsidianakis@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org
Cc: chao.liu@openatom.club , dzm91@openatom.club , qemu-rust@nongnu.org,
 qemu-devel@nongnu.org, hust-os-kernel-patches@googlegroups.com,
 Chen Miao <chenmiao@openatom.club>
Subject: [RESEND RFC PATCH V3 0/4] rust/hw: Add the I2C and the first GPIO
 device
Date: Sat, 29 Nov 2025 15:43:17 +0000
Message-ID: <cover.1764426204.git.chenmiao@openatom.club>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=chenmiao.ku@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 29 Nov 2025 11:38:35 -0500
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
Message-ID: <20251129154317.Y3Ltw-zSfrhheY2s6yShR8I4H3a2sqbSg50IHDBsPOc@z>

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


