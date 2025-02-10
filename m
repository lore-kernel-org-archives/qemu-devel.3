Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292EDC0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWRs-0005Py-4N; Mon, 10 Feb 2025 11:15:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR2-000487-6P
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:01 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWQy-0001UL-TR
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:14:59 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ab795ebaa02so518914866b.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204093; x=1739808893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+bgwk18lKdsHzokGpBgI91DaZBecMvO8llhyl5xsWo=;
 b=YDRaIuP6/zYmQI7dc+3k6pGxtQ+RjHPS81cJoG/oqi2KgPlOMoRHmccsv6PzZeauzK
 42QgrBLVoa0Xo+IPfhcXltX3qBU+uij1S3I/H/WsUYWInT2jOE8MoJBne4kQ3tv6y9ql
 NI4xUukilOCzIQ7dMjcwIiBGYMbtPsfP1C3G3kRw43lg6uL4O5Ka50/YohL1GUBRByU+
 dD6h6eJrGT3NeOZOYnjgyUpAJq4lY+4RbvlctLXZnqIYVCjf5zGa4Gmz/wI7dFGZ0DmO
 y/N7QwezSlULO/g6mxr109X6H696Reb9lYf5nnymOxPHtaPOw/GPBO9etG50u1CDa+XQ
 JamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204093; x=1739808893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s+bgwk18lKdsHzokGpBgI91DaZBecMvO8llhyl5xsWo=;
 b=gx0+tk7iADvzlIFssrsWLG13DnWZvyPpY++XdFlD12g0DDVKyeTa2w9cwC0FvnjaEx
 1NdM/bP8NDyVYLMGpQ9PREUTh/xmS0Xg2dkavGI5l+zPY+FNaOqb4c0Z6RyouWKsvT3U
 p5E3RBwSUjn+o8xIVP17IdTZUpITXNUh3w6AfbQDIm3WGRvJavrBvgk7qi6zkotOgv41
 fjeZkERw336WFYXzLuTMec/4TGATt/tvwVRXAPAIySYCCsdypO7W+oOVrTAI4sFnSXui
 5qoEBagdEFN8eTuAGppCRqMw1unx26HrkDp5GqY/SoVbcUb1Qqw7h9qxUMPZASOvNCcV
 xA6A==
X-Gm-Message-State: AOJu0Ywhne6JuKs8TCHnu4YTUuMFgMdS9rGVafkFWU/Vt6JVOY5B+pfZ
 Fvd+qc4Tp6McIoV8lglcvdkPwF1ZSDMhljpKr8YNdANm44gzLnxlUVeeUFsQiS4=
X-Gm-Gg: ASbGncuI6EaJaEtC0IS0QaRtpDmLIRQV3fG7fLrMEODUJ+Pjxqzn1VpyJdh53a6zpRz
 Qy/n8a1JVLJGZAAY+zr470wFEQZlpiEjcXMriRekrBcZ9UPLjhRpXByC60xdn4iAIxES+7H1CvI
 1PsdZvqqu5owXdUfADlCcu2mPQUU3nmp4U0z1I3fl6EC4WuLWl3effcQ04b9qckla+7nkXx58av
 oevnZ5N4F3zB7rI4XWy9GhwpkTYKPu6fBboVIqEDFqEMmkhDkFqm+/dpaKWz4JK6zSqf5HRJ4cX
 4AiYmikSE3H1EqALeA==
X-Google-Smtp-Source: AGHT+IFr2A58jx4kKR8nVUg6w6bivqW1VmnAzxHJV+dJtiq1/zgsS0YfJ7zBCGfSA/4mUNBRtLrTew==
X-Received: by 2002:a17:906:f59e:b0:ab7:1816:e8a with SMTP id
 a640c23a62f3a-ab789c47d9fmr1843499666b.36.1739204093555; 
 Mon, 10 Feb 2025 08:14:53 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab78ec15421sm715275266b.157.2025.02.10.08.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:14:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E05065F91D;
 Mon, 10 Feb 2025 16:14:51 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 qemu-rust@nongnu.org (open list:Rust-related patc...)
Subject: [PULL 01/17] tests/docker: replicate the check-rust-tools-nightly CI
 job
Date: Mon, 10 Feb 2025 16:14:35 +0000
Message-Id: <20250210161451.3273284-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210161451.3273284-1-alex.bennee@linaro.org>
References: <20250210161451.3273284-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250207153112.3939799-2-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 0091bd1a90..aac7404473 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3386,6 +3386,7 @@ F: rust/rustfmt.toml
 
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


