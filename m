Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15B6C02182
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 21:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyun-0001rj-Gf; Mon, 20 Jan 2025 16:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tZyua-0001cM-9R
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:02:22 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tZyuX-0002wX-He
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:02:19 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ab2b29dfc65so732267266b.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 13:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737406936; x=1738011736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tLu0rGl+J06PZUR5LsaS3cXdzyCcNICroK1QJ5nx9oM=;
 b=R5vu3SB3NKu5zflkKQRE0A7up1K8L9mZa49AvbMLEiHvLwqm6XG2cVKShlDrxzclJU
 9oNNMhtNDGJzNUJYF2xvlEGSlLB1fBTav/HnA86j1g5loRHlTb26KkGSkMXOAeLyAhDC
 eBs+IHY55EeGYtVsNhLCxSpPoMRYnYaoG1Si2u9DAqRuKbxniYcT/8NtPJXzgYEoVpLD
 hDjY7iAXROH+api9YpjtEVwEkjGATzsl0aUxtT2Tpw4Ddqm2eDrRr53InWDdTdFAwots
 AH5ka+hErAPKyJEB2Bx9AAeHgMK2FJ0eoGZ4u3cTZcCdTv3W2pKL45uBZmW3Q8FmYN05
 3GGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737406936; x=1738011736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tLu0rGl+J06PZUR5LsaS3cXdzyCcNICroK1QJ5nx9oM=;
 b=tyuKPikRq6O6rwylAtVYrlkJ/f+0S1+eNiyT+XN0bo5h0ux2aFyBaG9xDuCrQLfxRi
 zn3zKqrlVAk+JaKSaXTLxF4v9IR+fYaSmK6BrH44xRQZMKnlqXic6xEmU7MslgC3CosU
 kP6HmTRa9/ha3vFHEVr7mZj603q/v4q9K5+aEq9iIU6iKHgGGzqTi0KMqQe7GoOe3R5z
 qKewBZ2KpYNvOC1AUYIG1Geho6/LP9h2dEYDGIbeDx+6r5ETa+Zb2rKIyw9FJJjEhCk+
 kB6HG/18y50MVeU4tRGLweeTHJ4f9k+M1u4JPZRQ+74ol9jWv6Y3w8Nalrgjwxi0IADA
 Vv9A==
X-Gm-Message-State: AOJu0YzOk3ukXd4+m6cRUoq1dCVEpSJkqpQqHQALVfrIaANb2O2DnrTD
 YxtqCVl4IxQjLuQfIUO/qpYrYgC0GvjxTbYKXZKlOgZij5bNTDi16xj9GNJgUpQ=
X-Gm-Gg: ASbGncsq5sLbCO4/C8wZnui5m6p8OFRLztVnMrs86gQoMJBOy7MVJg+dBBaVN1VB/sq
 uiqQloGkwkLe0t76wluoVztwvZXfd9NothSeUDKl2Pq1xDwMLl3JsEnEB9HOq/J2uAWmc/N+Dp6
 IbvBCee2zM+74AtrzKtsABZDEFh10ApZUEXWbOEdB7rz1fWdc74iy+z+n8zoTHwXKe+rRcq8vd7
 k2V1VbR4t8cfY5MOnS8uzF7+VqImuOosdDsxOm3bhppaIz4opnat80hsSjmOTZD4s41
X-Google-Smtp-Source: AGHT+IG7pmekI4QEUTaPfZzML9BXu9Y/MmPsTAsQWPeEzIZm9iSJRBT8sPVgffAOd4DiBsyLDEyZvA==
X-Received: by 2002:a17:907:969f:b0:ab2:c9b8:aaa7 with SMTP id
 a640c23a62f3a-ab38b36b7f6mr1377104766b.44.1737406935643; 
 Mon, 20 Jan 2025 13:02:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f23007sm668940166b.96.2025.01.20.13.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:02:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F0FE85F864;
 Mon, 20 Jan 2025 21:02:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/7] tests/docker: replicate the check-rust-tools-nightly CI
 job
Date: Mon, 20 Jan 2025 21:02:06 +0000
Message-Id: <20250120210212.3890255-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250120210212.3890255-1-alex.bennee@linaro.org>
References: <20250120210212.3890255-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

This allows people to run the test locally:

  make docker-test-rust@fedora-rust-nightly

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include |  3 +++
 tests/docker/test-rust        | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100755 tests/docker/test-rust

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


