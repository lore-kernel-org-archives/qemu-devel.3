Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2D1C71151
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Jun 2025 11:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQlQM-0003eM-Dm; Sun, 15 Jun 2025 07:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uQlQK-0003dn-CJ; Sun, 15 Jun 2025 07:21:16 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uQlQH-0007xo-EN; Sun, 15 Jun 2025 07:21:14 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so655900f8f.0; 
 Sun, 15 Jun 2025 04:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749986470; x=1750591270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hutb4ji51xb3Yw07pXHv6w3iBGw3zwwmaYb3nUMWfCo=;
 b=eCrv7q/DrFEIfkavy5LGdpJj04pLWT9cisOVuIDeKg8cnQfwW2W+3EXj08QiwQrma4
 M8vEisyLCyji0f2vDK7tiF3HtNTBv8U440/7jZUajsDIMHhROkgaAlTYxB/D+kp7Ryk2
 gs+wUov6NysH2a/9Tcaar3KMNN+xsNLgplBBEsfUE8ks2OpplmfSOIOQoJcYiG1WTb03
 Et2F1jsngI/fPUed2/IaPmbXgmeJPfjJKCBtW+3v8Iq+N4trD6px4UE+X4jQIGNCr38r
 nz7YKmNry8lgVWAAsY4oDV3hPmhxn7/by/aKMabYN3B+zzbQJH2X+6hgF5ZpMYmaEZhz
 mLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749986470; x=1750591270;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hutb4ji51xb3Yw07pXHv6w3iBGw3zwwmaYb3nUMWfCo=;
 b=KDlv0Oa0Rwo4xnYmJDfsvgYbVvetek3AVOr30AyO3BCJeP6U8yMCbxr9GNyDKI2Msg
 rnSWwEG/2IcqADaWpnIeVCmCRrt/2kU3Sskt6GC8olm1A85R7sD+YB24ch+IetYohqYe
 QfP1uA1dXy1tQJkJPoUrWYPUPyhVZlWhGJ4JtYHY/qL2/hJgT0zxDtxdKfirGGfwtBhh
 pIY0UQBJ3YhTfSnC7WnX6fhA85YR+QH+PqPzfJm+ksnOhP2dB0x0Z6Mqm+ZXB/CN9Jof
 EFYOCDxOcA7MEGD1PjZCbO6xpkuhGEw2xNOZIPmMwSmIHz3niAMfRHoSzwNu/UsBHQjc
 Qyrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX69bIn4A6GfCcHepNLJziJXfe68LToeODlHc69KIAIWAEWB5nZqnmQ6BokvgprKH4u4SejWrLf9n0=@nongnu.org
X-Gm-Message-State: AOJu0YxjOG23oG1RV39grx6KvvfrEy9eg2wJucJDfkPnHipSelYvVoof
 PKulqc4fR+MhGcaxZ6jdpH1ic8G/T79YW4dl3zKpE6yhGvjcgVSi/fFKc0ewAg==
X-Gm-Gg: ASbGncsiJmsLgVGDtnx+lM0mkQxwAiHMQR78RLCpADjc4KAA8bR9DyFLpMMZKaaHh9j
 H+E5Pxry8sf7DxVyywVV1+pYSKhDSXXrKDFDLOtY+lfljVAUFIyR+a8Zr6Yev9l5N2TqgnYgt7m
 3cJOjtOmqH+eF6jVbCRXlKvdHutp4nbZaUzHxgCba/GZCnSjCrbojVfwgbzBC6b5ayKvkx8Jctd
 7/EIXOWAjQ7jssQleCJ3fU9XXmzqi5PjeyPGohdql8h9HAxuwT/5UhyfpIkwALLE058Ad4WMwQ5
 RwbTtZ1H2H5q3WDyPZ45j7xsqAwzv7QePwG4ZwTV6DM5Aa5tp2TNw22aysqgDdLxCOiRVWheViX
 4qxt8ppZgdcWHky3dZ9HvE47fXOSJv1kPpdJaySaO07Eb4N/SU7OrSmCqQ28p132XCQL4prKLr6
 +lP8n2IQ==
X-Google-Smtp-Source: AGHT+IEFB2YPqR+A59N5lh65OHm5NgptfSZMbIdCGXVgX9QK6jvYZ7FCLSyStDFJUfIGyyg3vQPhRA==
X-Received: by 2002:a5d:64cb:0:b0:3a4:d274:1d9b with SMTP id
 ffacd0b85a97d-3a5723ad5eamr5086294f8f.25.1749986469963; 
 Sun, 15 Jun 2025 04:21:09 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-231b-9b00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:231b:9b00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b5c372sm7327099f8f.89.2025.06.15.04.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Jun 2025 04:21:09 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 0/4] Initial logging support for Rust
Date: Sun, 15 Jun 2025 13:20:33 +0200
Message-ID: <20250615112037.11992-1-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42f.google.com
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

This series introduces a log_mask_ln! macro which is inspired by the C version
and is just a thin wrapper around qemu_log(). It caters to Rust expectations by
accepting an enum for logging categories and working like the format! macro. The
macro then gets used in the pl011 device which either had its logging commented
out or relied on eprintln!() which can't be silenced by users.

Testing done:
* Run `make clippy`
* Purposefully trigger warnings with varying number of arguments

v3:
* Add macro to prelude (Manos)
* Have log_mask_ln! rather than log_mask! macro (Manos, Paolo)
* rustdoc improvements (Paolo)
* Fix logged function names (Manos)
* Add missing logging to pl011 to match C version (Paolo)
* Add patch to make clippy happier (which still complains about "PrimeCell" in
  rustdoc comment)

v2:
* Drop the qemu_ prefix from the macro name (Paolo)
* Use an enum for the logging categories in PascalCase as suggested by Paolo

Bernhard Beschow (4):
  rust/qemu-api: Add initial logging support based on C API
  rust/hw/char/pl011/src/device: Implement logging
  rust/hw/char/pl011/src/device: Add missing logging to match C version
  rust/qemu-api: Fix clippy lint `missing_const_for_fn`

 docs/devel/rust.rst              |  1 +
 rust/wrapper.h                   |  2 +
 rust/hw/char/pl011/src/device.rs | 18 ++++++--
 rust/qemu-api/meson.build        |  1 +
 rust/qemu-api/src/cell.rs        |  2 +-
 rust/qemu-api/src/lib.rs         |  1 +
 rust/qemu-api/src/log.rs         | 78 ++++++++++++++++++++++++++++++++
 rust/qemu-api/src/prelude.rs     |  2 +
 rust/qemu-api/src/qom.rs         |  2 +-
 9 files changed, 101 insertions(+), 6 deletions(-)
 create mode 100644 rust/qemu-api/src/log.rs

-- 
2.49.0


