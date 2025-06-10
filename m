Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FD5C61DB2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 20:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP5TS-0008W3-Of; Tue, 10 Jun 2025 16:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uP5TK-0008VI-TT; Tue, 10 Jun 2025 16:21:27 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uP5TH-0001J4-KJ; Tue, 10 Jun 2025 16:21:26 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-adb2bb25105so950351966b.0; 
 Tue, 10 Jun 2025 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749586881; x=1750191681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Po4Fh5QWGjtOuuGoRmn0XWgAY6D2JGafa5rf7p1sJ4I=;
 b=CelFNfAtTNw0mH0DB/nNBPIXiASd89s98bEIf4zsxI5XxzZ4Iui1isOT0juJ+LE1N1
 1a6hhERpO5pvmxBo3aAwXjhLSlAujqEBZsm/VLortDp54+zQzGQI0iUGQCnRBn9ZfHOC
 vbkpDaM8Uq18+O6+eSdy2GnY37ZhC0WdaIMV/e6LDjKsMgsysHdW70YxX4CYvke+/3gk
 TwTPtKOqPbwj1erCmWINWfhkrRMB+xzO1CX8QHNi1epXjiI42ZUu+IX6k5AKXKXjCW+X
 MtnB3QGdRkPDbxe35xMU6wIjjUiS8WOQnlL/0h9kZUCeWGkguQvVBadEzv8OkDbhD1Js
 dqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749586881; x=1750191681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Po4Fh5QWGjtOuuGoRmn0XWgAY6D2JGafa5rf7p1sJ4I=;
 b=Rwmx1EoSUSO2V/wbqiBtJu8uEjSAu9M1gg0//Q/+JNNnUQmHOW14BLZDXJvC2cV7sa
 1+5oIfl2IqDbrURjYh1SJbFT9utlduAL1U/lMuJugC7K32oGN9QvtKIRpJpo6DT2RXV/
 mYWdVIM52Ra/+J8bEKDugDR1cHraT+Yj8dlcqvStd7zasQ1rxj7wsawLV6CYEQ3ClXqU
 uOGH1K+9NuTLhQAW2c1Zj8wzGXtkKu9HjIE65rhWk9sky6roNKS8o2Ll0TEG0FgV5tPS
 jnDEPMAjl/czZY6xVGuFHDk6MmGELrvgw4JlUxyCmzJ4HO//70ugT6LEAEC8rJINZQ65
 AwJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5bpaWtGftdL0mxorinHzO6YDCNxJhpJWi9te7MFkbdnwQyHPRiNKRqSDcjHVcTWP2zo4wX4hMC04=@nongnu.org
X-Gm-Message-State: AOJu0YyQTRSrsQG8pxDdNf9xyJML+vCvbf1rt4+/g/ugW8MlMxEBGTC7
 VOQf/jjA5xuNNV5ydKQcGnSNLFYraY865tiwqMJK5HFEkB/gnzsFnOrIMxvfDw==
X-Gm-Gg: ASbGncvzw89oAy/jBxbvjv17rNb984xnAZgUUZrS6Idccr98TRdoEF3uPMR2zsvIR++
 z/CMNLJmMX4m6sNxus45iZm/kAOAxbvOXmkBAijL6VMpTTfB3O/2DwJZtrdcWToQY0kOGsJ7+pX
 WogFJm8AOaSY7j4diU4C9ED8SS285D3NnHE1Lj1FSoepgVTq4AWUUyi4mA0qn7LIkB449aMnUD/
 OzNmtRuugRdfCBaOYIiiHnPO3TewFqW9R1khZl/l8CAnhsKV+14ixxU30ScT2xcungNZV6mPhAD
 zFjz4ewftgf0FM8f49FUVHcH1Op9RicYZOD9ST5dUwhGlSUy8jYHDSemqvCVYuCM1BQ/4HilH42
 T6wxoInljPl2qhEuf2WzyMM/2KgnNAbqJNXkeUWWS4poeDrpz8KhNOkrF3MpBlDK9Fb8ySA2JPC
 P4zwzybJMlRuFOBpLu
X-Google-Smtp-Source: AGHT+IGbl+YH3N0uxZZ4aVVhkAB8BSUtBDUCUgE9w0kDF/6Pm7eoqsv189G7ccdAIwdM3fQxHXcBaw==
X-Received: by 2002:a17:907:60d6:b0:adb:e08:5e71 with SMTP id
 a640c23a62f3a-ade8c769374mr21547566b.17.1749586880763; 
 Tue, 10 Jun 2025 13:21:20 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2cbf-5d00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2cbf:5d00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc7c786sm793135166b.172.2025.06.10.13.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 13:21:20 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 0/2] Initial logging support for Rust
Date: Tue, 10 Jun 2025 22:21:08 +0200
Message-ID: <20250610202110.2243-1-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
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

This series introduces a log_mask! macro which is inspired by the C version
and is just a thin wrapper around qemu_log(). It caters to Rust expectations by
accepting an enum for logging categories and working like the format! macro. The
macro then gets used in the pl011 device which either had its logging commented
out or relied on eprintln!() which can't be silenced by users.

Note that this is my first Rust contribution, so please check if the usage of
`unsafe` is sound.

v2:
* Drop the qemu_ prefix from the macro name (Paolo)
* Use an enum for the logging categories in PascalCase as suggested by Paolo

Bernhard Beschow (2):
  rust/qemu-api: Add initial logging support based on C API
  rust/hw/char/pl011/src/device: Implement logging

 docs/devel/rust.rst              |  1 +
 rust/wrapper.h                   |  2 +
 rust/hw/char/pl011/src/device.rs | 12 +++--
 rust/qemu-api/meson.build        |  1 +
 rust/qemu-api/src/lib.rs         |  1 +
 rust/qemu-api/src/log.rs         | 76 ++++++++++++++++++++++++++++++++
 6 files changed, 89 insertions(+), 4 deletions(-)
 create mode 100644 rust/qemu-api/src/log.rs

-- 
2.49.0


