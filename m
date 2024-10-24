Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4724ACE8E7A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 14:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3yQy-00076r-EY; Thu, 24 Oct 2024 10:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yQu-000758-I1
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:03:27 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3yQs-0003sQ-M8
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:03:24 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2fb5fa911aaso12769871fa.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 07:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729778600; x=1730383400; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DUx6k1Bde8kvzj6RF5KlasgT1EWln2KLnDYjeI9zPqc=;
 b=HK/rTKJCJ8KuTm74h4DX2Lsrw0FrD+RSH7h0dZSUvApeWXU6oBOzKDDNICwmYCVqxz
 GadmpmZaUryDSXm+ydANcAMtwuPNYg416FH2mvomccfdY71KtbnJU0HoxAVox16pvNwZ
 VSTxwelJFIggMw0P4Xl4KSBf1q026KXwPiTSM7Pj3MyR+MsGTZrebb/rlyLaWy7TlR7z
 Vw//yK2CwEjW1278c5aChNw5+wRL6vcemLZo5oMOptn2Zxg0hZWE0+9q9+L+D9SLX2Ml
 KInoclz6Ap+LiBOaN17ei/gzkPbkYOHk/iDQWUgwrW6yRJOX6NG9hAWRsIB8GPYLxDkh
 gDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729778600; x=1730383400;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DUx6k1Bde8kvzj6RF5KlasgT1EWln2KLnDYjeI9zPqc=;
 b=ANpeIcTjXjxnOefZVKtTdkhC8zMOe07uHSwC0AdI87EoUXCQJpqQyFeMyUs7+Ig8GE
 ZzUYhpVBe8JD4QoGUCs/fLM/Z/pJ7oMy8iaCrw9ufwy4OtVcfzqGonuq5oadqnWwyo+x
 CgHi6DSVWyci2o0MZ7I7BtUykITxaQOTXYXFVcoiaaMtKxiL+JKXdKOr9tGc+ot2bI67
 8ONToqSfnVvf+jWwsRi7GTy/gCjgCmX/5QpXEbvSexteCbiT6ckEFZ1sBIEjc7zoRh6U
 lp8Dhd5kgZzHuQ1eZZWCbuWyKl1ly4S62NHf0WRxx6QawQOsamKy5nLBpcSon9rAasyQ
 Pb9Q==
X-Gm-Message-State: AOJu0YwdhkvFC+gujDpi5s8xH4j5YZkHIraauSOHoJQWpt+tH42gcRFd
 YX4diGNAUKkLXbVXWTFzxtC8pydC/dTqOyRDcGEnDR5ROy62GLAGTuOsaceqnqI=
X-Google-Smtp-Source: AGHT+IGF0fKHc69oics2mZQuw7swSqpilJbB2Qw7cGV8n2lg3Jh0YCBhluhfwsRLrhXS+dFGtB+bVQ==
X-Received: by 2002:a2e:a593:0:b0:2fb:8c9a:fe3f with SMTP id
 38308e7fff4ca-2fc9d3460a3mr58926641fa.22.1729778599324; 
 Thu, 24 Oct 2024 07:03:19 -0700 (PDT)
Received: from [127.0.1.1] (adsl-113.37.6.2.tellas.gr. [37.6.2.113])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6878sm621407566b.86.2024.10.24.07.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 07:03:19 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 00/11] Rust device model patches and misc cleanups
Date: Thu, 24 Oct 2024 17:02:58 +0300
Message-Id: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJJTGmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDINYtKi0u0S3KL81L0TXSNbNMSzQ0SLZMBGIloJaCotS0zAqwcdGxtbU
 At+RDMV4AAAA=
X-Change-ID: 20241024-rust-round-2-69fa10c9a0c9
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>, 
 Junjie Mao <junjie.mao@intel.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
X-Mailer: b4 0.15-dev-12fc5
X-Developer-Signature: v=1; a=openpgp-sha256; l=3938;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=B9hd9jIQu4jPW9jqJoF1leZCt6iMYL9SD7oKZZSv1mk=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm5HbE9pY2lyVE53WXF2NEJweE95b0twb1Z6WFViCjJhLzVvWEdMWWYyVHNIbmFZ
 L0dKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnhwVG9nQUt
 DUkIzS2Nkd2YzNEowR2p4RC80bXpqUkdvd1NJWW9KL0N2TVVsTGh2NUYwVTNpQ1RFd0Z6S2VJVA
 paSE9hY1ZUeTVwZTlSOStVV1ZReWJvbm4yMWd4QndqOHpUL0djSXg1RVJlc2FoZE5MMFpwQ3BCR
 TdCb24vcEhyCjB4TC9tUCt6K05SMlppbTdFMTdhVmpFVXdrNGp1YUtCamxsNlc2VTY3MkF6MUc1
 b1Q0VnprK3ZJNmdmSVFpbDkKbVBYNDZ0d2s2RGw5V2tTdTFmOEhlZ25sN0lIcGRUcGwxTUVySGx
 mSk1LVnF1MWxURjNvUEpSV1dkcnVKdEczSApmSVlEMWI0WmJvZjNDcDJLTHk4dEdQaksyM01JcU
 U2MGUwTVg3QlBnWWZkZzNmVmxDN2tvclRyUkkrVzh1bVF4CkJsUTRKZElrYjk1RGM5RkExOUY2L
 zhaUDdqSDFRT243SXVBUmx0VGJJczAzd2EwN2h6V09QbXUydWc1OWlNMTEKUlB4YlR2V0VyNFZo
 ZGtjNlpNM3l3L1B3Y3pDRHBoODZzUlNsNmdDdmwzajBiMXdyZWFKay80Kys0and1RFRRQwp2MVF
 URFJlR3hVenBTeTlxd1FKdHlPRXY1YVRaR0xNY05FenhWWEdWZDJpbTBqd01OdVg4MHJJdyt1aG
 0xMDFuCmpvRTFHbWlxV1VHOU95eDlJbURlZVFHYWs5Tkx0cHFEUlg2aFJxNHUrVzE4dmpUNk0ra
 3ZMS2ZtWld1VzUzZlYKam5IRlRxSXNCeVZtSXlrOVJUaDQyQlJvZFZsTndzMXdudktDc284M0Jh
 TXpSd0IyMDVtVW5vQjR5UytJekh6MgpZS0pNZlcyb0o4cE1OZ21ONFFkUXZwWGZhM3VCTlVKZ2h
 RNzBrZDRVSmZoY3U2OTZtVDNQb3FvQjJkazNNS0FMCnNDa0VKUT09Cj1hUGRRCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x231.google.com
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

Hello everyone, the pathological corrosion of QEMU code continues.

This series expands the device model harness work performed in the
initial Rust work from the previous month. In particular:

- A new derive proc macro, Device, is introduced and the Object derive
  macro is heavily expanded upon. Many hack-like macros and fixups to
  declare FFI code for QEMU to consume were removed and now everything
  is generated by macros in the qemu-api-macros procmacro crate.
- Add support for device migration by allowing device models to declare
  their VMState description, fields, subsections like in C code. This
  should also allow new qemu versions to transparently migrate any VMs
  that used C device models that were afterwards ported to Rust.
- Add a small logging interface in qemu-api crate to allow calling
  qemu_log() and qemu_log_mask() from Rust code.
- Some minor code cleanups in the Rust pl011 device, and also port of
  one fix patch and one log prints addition patch that was added in the
  C pl011.

  In the future if we go forward with rewriting device models in Rust,
  and keep having both of them in-tree while Rust is not required for
  building QEMU, we could alter checkpatch.pl to produce a warning if a
  C device model has changes but the corresponding Rust implementation
  doesn't.

  Code and functionality duplication is not fun, and pl011 was mostly
  done as a proof of concept for a Rust device because of its small
  complexity. As of this moment we have not decided on a policy for how
  to handle these things and it is not in **scope for this patch series
  anyway**.

In the meantime there are lots of TODOs written in my personal notes, my
personal repos, in the QEMU wiki, in mailing list threads. I plan on
consolidating them all in gitlab issues to streamline things and
who-does-what to avoid duplicating work.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Manos Pitsidianakis (11):
      Revert "rust: add PL011 device model"
      rust: add PL011 device model
      rust/qemu-api-macros: introduce Device proc macro
      rust: add support for migration in device models
      rust/pl011: move CLK_NAME static to function scope
      rust/pl011: add TYPE_PL011_LUMINARY device
      rust/pl011: move pub callback decl to local scope
      rust/pl011: remove commented out C code
      rust/pl011: Use correct masks for IBRD and FBRD
      rust/qemu-api: add log module
      rust/pl011: log guest/unimp errors

 rust/wrapper.h                                |   1 +
 rust/hw/char/pl011/src/device.rs              | 419 +++++++++++++++++---------
 rust/hw/char/pl011/src/device_class.rs        |  70 -----
 rust/hw/char/pl011/src/lib.rs                 |   2 +-
 rust/qemu-api-macros/src/device.rs            | 370 +++++++++++++++++++++++
 rust/qemu-api-macros/src/lib.rs               |  46 +--
 rust/qemu-api-macros/src/object.rs            | 107 +++++++
 rust/qemu-api-macros/src/symbols.rs           |  57 ++++
 rust/qemu-api-macros/src/utilities.rs         | 152 ++++++++++
 rust/qemu-api-macros/src/vmstate.rs           | 113 +++++++
 rust/qemu-api/meson.build                     |   5 +-
 rust/qemu-api/src/definitions.rs              |  97 ------
 rust/qemu-api/src/device_class.rs             | 128 --------
 rust/qemu-api/src/lib.rs                      |  10 +-
 rust/qemu-api/src/log.rs                      | 140 +++++++++
 rust/qemu-api/src/objects.rs                  |  90 ++++++
 rust/qemu-api/src/tests.rs                    |  49 ---
 rust/qemu-api/src/vmstate.rs                  | 403 +++++++++++++++++++++++++
 subprojects/packagefiles/syn-2-rs/meson.build |   1 +
 19 files changed, 1726 insertions(+), 534 deletions(-)
---
base-commit: 55522f72149fbf95ee3b057f1419da0cad46d0dd
change-id: 20241024-rust-round-2-69fa10c9a0c9

--
γαῖα πυρί μιχθήτω


