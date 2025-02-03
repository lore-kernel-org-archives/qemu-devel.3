Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0227AC02194
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texdH-0003am-M7; Mon, 03 Feb 2025 09:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texdB-0003TH-OE
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:40:58 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texd6-0002LR-Ri
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:40:57 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aaf57c2e0beso918674066b.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 06:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738593651; x=1739198451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTDOVYxM0E7wRyBsbgpa8GUo5K0fruAd8IIEzTdI9Ns=;
 b=bfIx4/ddsM9UzAGhPaKwjAeWyH7jl7felKe4s7x/7JvXmAIMVZJmbOPi1i2UWg5bPF
 0PK1WBIjYq0OxgHNdHhzPXTfoVt0aRImjga26zJ6DN47jHq8VK6//GTWcISDzld6OwsP
 KI75O5Z6nz81HF+i+TVNBGOdIXcWgB3mf5nYTCSkVI+JmdLpRM8GmOUZtqW3ozAvq5BA
 MuvOEO8ZjQRMODGhuI1cgIDAdEJoqN+SDshyrisrVLno7YfZbMo+qsihmU/pIIaNXdJW
 QjFeXybFllhSJxNpKsjUl9qpxlzdl7yGHGSU8IbCrPxQ5V/gaNGcpixsDNimX2CxdxAX
 vhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738593651; x=1739198451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QTDOVYxM0E7wRyBsbgpa8GUo5K0fruAd8IIEzTdI9Ns=;
 b=GykgsdW0xDhke757xZWf4Jg2Uxg5Q1rEBjZflXgM4AxQS2cGuGyPP0uCs5HO07O13V
 pPgmcLp5PQ11dPOr+/YNvEHOk/ue3lcNcpbkESK+2Tqjdzou31nb2XMMZO+w9L5+xHnn
 iuwezV2RKw3LSbhqvxe2EV2aYhOcd/sIB41cqABw9VMUz1zQUsNht+jweUR1t+GBMoSs
 XAVhrYnleAaVeSBcnncL33XySm/Kmef9Oi1TT0eHxvSZY2zHLye34BG+VXcmB9VDgw8b
 QE8hF4tNRfDwgqbVP9VhwQ/RQnn+MdfDsfdT14NT8hrbKqnhtKVuFwew/qnNcJFl/Dyg
 se6w==
X-Gm-Message-State: AOJu0YwJT0TD5MoVCM13udTvBEbLgmO48bgMUhMPjO5j0SuJaGxE71Yi
 CXSaNChDisiYg+KEFoPMtWZ7spRlY72t22kGz887j8ru+3ae6BqG4sB/75hfsow=
X-Gm-Gg: ASbGncu6aSOjxsi+svcwELtA2rYlLFlcn0PWyGSBfmRhM40GlqHCaKEIE9OdcBlckwB
 90xRIE5MMkVURbMEhaq4DdDgalzc2m6Ooz1EBNfz6L23C0u5KnLcIf571ga5+I5rNuEb1rNM9of
 t7dchLpWCzbl2j+TvK86wyCmIaMbZlXBmCKTNlDL+YBMKD/azl0edqmyXZdGqi0DooAuMX62yks
 xTaN0vcUEDceu5OV28WKKFkAIooBH1QYk0H9A7D7qNv/xPHcFssRFZPUiZnGRGjfsYH11bZB+f0
 vGuqgvogG2AMiQwPfw==
X-Google-Smtp-Source: AGHT+IH/qleD9HY2aVbeknEfPVUsDluqxOpdMDkbIEC7YUJxy/b/vW3wRfGPVg1o5VF1/ZRyzF+I4Q==
X-Received: by 2002:a17:906:6a24:b0:aa6:aa8e:c89c with SMTP id
 a640c23a62f3a-ab6cfda42fbmr2842139766b.39.1738593650836; 
 Mon, 03 Feb 2025 06:40:50 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47a827esm773718766b.15.2025.02.03.06.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 06:40:49 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AAED45F906;
 Mon,  3 Feb 2025 14:40:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Hao Wu <wuhaotsh@google.com>, Peter Xu <peterx@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-rust@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Tyrone Ting <kfting@nuvoton.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 01/18] tests/docker: replicate the check-rust-tools-nightly CI
 job
Date: Mon,  3 Feb 2025 14:40:31 +0000
Message-Id: <20250203144048.2131117-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250203144048.2131117-1-alex.bennee@linaro.org>
References: <20250203144048.2131117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

This allows people to run the test locally:

  make docker-test-rust@fedora-rust-nightly

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - update MAINTAINERS
---
 MAINTAINERS                   |  1 +
 tests/docker/Makefile.include |  3 +++
 tests/docker/test-rust        | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+)
 create mode 100755 tests/docker/test-rust

diff --git a/MAINTAINERS b/MAINTAINERS
index bf737eb6db..8008db18ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3384,6 +3384,7 @@ F: rust/rustfmt.toml
 
 Rust-related patches CC here
 L: qemu-rust@nongnu.org
+F: tests/docker/test-rust
 F: rust/
 
 SLIRP
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index fead7d3abe..fa1cbb6726 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -236,3 +236,6 @@ docker-image: ${DOCKER_IMAGES:%=docker-image-%}
 
 docker-clean:
 	$(call quiet-command, $(DOCKER_SCRIPT) clean)
+
+# Overrides
+docker-test-rust%: NETWORK=1
diff --git a/tests/docker/test-rust b/tests/docker/test-rust
new file mode 100755
index 0000000000..e7e3e94a55
--- /dev/null
+++ b/tests/docker/test-rust
@@ -0,0 +1,21 @@
+#!/bin/bash -e
+#
+# Run the rust code checks (a.k.a. check-rust-tools-nightly)
+#
+# Copyright (c) 2025 Linaro Ltd
+#
+# Authors:
+#  Alex Bennée <alex.bennee@linaro.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2
+# or (at your option) any later version. See the COPYING file in
+# the top-level directory.
+
+. common.rc
+
+cd "$BUILD_DIR"
+
+configure_qemu --disable-user --disable-docs --enable-rust
+pyvenv/bin/meson devenv -w $QEMU_SRC/rust ${CARGO-cargo} fmt --check
+make clippy
+make rustdoc
-- 
2.39.5


