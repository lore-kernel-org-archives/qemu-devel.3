Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F045DC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXddU-0001S0-Om; Fri, 04 Jul 2025 06:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXddP-0001Qo-1Y
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:27:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXddM-0005LB-0N
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:27:10 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4530921461aso5410315e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624825; x=1752229625; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E/938aAPfcB5Hz3Ak8QnPLvUK7R3dnxf+pxiiteksMQ=;
 b=n8gOaDSqGdmiWmOqyO+XBUIEO8BKyKgH+JfvDgSLQZ9DY2cllU8fbs5AabEBQ5LqKy
 FCt41fBsAUNApaPtZQtZ3fSC/iPeJb50INgbVL2VrQC6esbiqP3UBfRmbq17nBF4DLhy
 agbf3+Y4usT/QGEwZAW8VOM7+dLPMWBngfo3o05kxCEHBoeHm0KpDlaKyEtxX1AMd+iY
 hKt2lQwEK2RU5mtKdI7KcLNDP8IdTWRpQE32v6WitOkt1ycmT0Gcxz2RqWBb0Z2Q9876
 QZAjpcxcaPDV7s29B399hA18AdAHuN/MzCf/n8B4UtcEfZpm6eQJd5D3iaQY2TzWWgkd
 jJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624825; x=1752229625;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E/938aAPfcB5Hz3Ak8QnPLvUK7R3dnxf+pxiiteksMQ=;
 b=OUgkVC3jXN3PXqg1YYhRcueCrYTpmSbmqK2t+l/kmx7IKbbOYR0QEUSo5Fihcbulmz
 X792BYNC3BN3Qa6Lj52c+DOjJZEiRmkFzdfjNIgrSq01bvWY3zFYkoBX12nMx/+8jhmc
 p2/4E+/iaOTBL1rPo34FBlrxLsD5Ig7V0tK+TfEUibn5K0STvvPmGpmea4JS02aX90r5
 JqqeVF1KnjvZQ+5T+IMln0SdREU/86w7v8+2WzBNS1CVvpQGjhXuQAtBu/ckExsE3DsC
 0jwYad8HNFENSrVvbRx9xGKhTSchQ9a+bwsj9RxC6+dTzogi8cTx+PB4j5WvTEft7w4c
 NiaQ==
X-Gm-Message-State: AOJu0YyO9F+CU5WEV2vuKkj5UeN4hYPGVTR0XTtCHG0NPdqD1C3TZzg4
 aGbuGQ7zf/t0PfDN3/TXNBS9hj3UjXpZAPGOBEms9eq3Dv1/9AjgHwqMK5N3Xcx/7S0=
X-Gm-Gg: ASbGncvebSWPTqntNBaaqLFCtK1AjoqouIqC03x2OhqP4TtGEKL+ISzEXGt43XnZjrl
 dlfYYqfFwS6oT1G7+u1puCDdGYV3kqTzLDc0Tjzab+J4WnnRhqfAZaqy8aNMs1zOIwJeHme23Mq
 y86jCNh6NkWxZHBCwTsZC3eWzqWKGcX7064+usBKsDReAWZlbUEmMOV02pyIbjXH8g6aHVxZ9Xh
 wJFoHyDMZdSxmnzBvrW+gwPDVaNIl3JRrUaLpoQG2KI4mQYUiPMEVK+FkCW7OMxcvarD/0GPxD+
 i7xNxusrGvseOXJEnKBp6Gn4OYVb9iyzuyoHeWfwK63ikybTWy2o4VGpKMOtJui6NH7DMmzEa0f
 WtIL0MFftl+bJiXfPpkz24F4FEw6kjIU=
X-Google-Smtp-Source: AGHT+IG8IiezuaxyO7qs8SMhiVpXeXczOlvR+B7KAOEz2xE8FI8G8D5Xpem6GS9GiNtkwDoqhr4Kow==
X-Received: by 2002:a05:600c:c0dc:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-454b32084damr17338205e9.16.1751624824556; 
 Fri, 04 Jul 2025 03:27:04 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-212-125.home.otenet.gr. [2.86.212.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bead7csm51037475e9.39.2025.07.04.03.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 03:27:04 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 0/2] rust: add Derive macro unit tests
Date: Fri, 04 Jul 2025 13:26:56 +0300
Message-Id: <20250704-rust_add_derive_macro_unit_tests-v1-0-ebd47fa7f78f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHCsZ2gC/x2NywqDMBAAf0X23EAaX7S/UsoS3FX3YCy7UQriv
 xs8zmFmDjBWYYN3dYDyLiZrKvB8VDDMMU3shApD8KH1vW+cbpYxEiEVcWdc4qArbkkyZrZsrua
 e4vjyLXUBSuanPMr/Xny+53kBb1wYoXIAAAA=
X-Change-ID: 20250704-rust_add_derive_macro_unit_tests-3e7daf905d62
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1308;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=VlQ2jwmeDrL7jiy1icuoWhk/A0/PanUGx+cIiUaydpM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9aNngyckJYTmhvRkxqeG42c0lkenVISDBjZllqCjdIankxSGFMOVNCOUxTcHVC
 aktKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUdlc2RnQUt
 DUkIzS2Nkd2YzNEowTzRFRC80K2hlNEx6dGR2cWFUdDdYOUtUL1haNStieW5uMWo1WGI4RHZrOQ
 oycnlINXYrY1RUVWlxcklJQ2c4U2VDd05pMUhwSUhycFVBMStrVHBzZU1LK2FMaVB4NjFGMXVSQ
 003aDJHMVFjCmZWcDdqbkhaOXArZHM0NzhORGMvdnlSYkNxZDRURko4dXVnM1ZGZmt3Qk13OGNV
 UHBWandlMGRLeW03cVoyVzYKVks2MzA3Zk1MWXhSVkF3dit6T0lCLzM4WDN0czVBbmFzV2lPcjR
 OQjg0dzNVZi9qUjNaZ1paWFZkUnJlNDAwQgozTzN6WHdIVkhJRGN6dE9rc0tHNHFySnphckhpYm
 UwcEpkcXJPb0ZxWG9GVi9MMmFPUlgva3JBMEUwclRibm1BCmRsVWVEZVRkMzVaZWR0WlhLcDJxM
 HlpSk5YT1BudkM4MFYvUVF5YUU4S3U4OXFGcmhkd2N4QWJBT0lDZ3p2ZDQKdE9nNkJQQXRjcVR4
 L1hMVTlydEFoV3g0OUZxMVdCUUtOZG5mamR6d3dYaS9PcWtaTVltcFM1OXZiMzNRbUVLRwpqc1B
 SRGpHSTJKdEs2SGpiWW1vRGVCTS9sLzhIdWRXTW5YZ0hiRVlHeDU4SjZDZHRFektmdXZnM0plY1
 U3WWZDCnhnMCtDRXhmbTNvVmtnMk5HR2g4eUFDZ1lpSDNodndLbEtFQndYZnM0YkVMV0ZMUHpxM
 GRUT2xRK2xtd3VCZUoKS0Q3eHVXdUF1ektjMTNFR09wWHB0MFlETko1TVJYU1d2cmxSZkZBY2Fx
 cmphNG94NDF3SE5Cd0FGTDlSR0htVQpGa2k4TGFNSXF5Z3hEY1pWbEk2dytaZnJnazYyOHVXZ0l
 QdHI3bVJLSU83dzIxTktWRS9jWXVadUJUN3p3WkpRCk9MSzRTUT09Cj11RTVWCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
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

We don't currently test our proc macros and it'd be nice to do so.

Usually this would be done with something like
https://crates.io/crates/trybuild which runs cargo and tries to compile
a test input, and checks for success/failure. However we cannot use it
with meson directly, plus it would drag in a lot of dependencies anyway.

Instead of compiling, we can easily just expand test input into token
streams since we already split macro implementation into separate
functions, allowing us to either get a TokenStream back or a compile
error message.

You can run the added tests directly with this meson command:

  meson test rust-qemu-api-macros-tests

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Manos Pitsidianakis (2):
      rust/qemu-api-macros: normalize TryInto output
      rust/qemu-api-macros: add unit tests

 rust/qemu-api-macros/meson.build  |   3 +
 rust/qemu-api-macros/src/lib.rs   |   7 +-
 rust/qemu-api-macros/src/tests.rs | 135 ++++++++++++++++++++++++++++++++++++++
 rust/qemu-api-macros/src/utils.rs |   1 +
 4 files changed, 144 insertions(+), 2 deletions(-)
---
base-commit: c77283dd5d79149f4e7e9edd00f65416c648ee59
change-id: 20250704-rust_add_derive_macro_unit_tests-3e7daf905d62

--
γαῖα πυρί μιχθήτω


