Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AE4C282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaiP-0006nm-Pn; Tue, 04 Mar 2025 17:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpah2-0005PL-ES
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:52 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpah0-0006Vu-AP
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:52 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5dee07e51aaso11482476a12.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127088; x=1741731888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9yH45YV1KCpKu1ZOSaE/nQIrSLBn5v2U2clJ5yvvVg=;
 b=ULLKoIRzcNgiJp8IEqlVPn/vrTJSEfecY9pAKeP0eEDGh+c2ndkR7qUK5v7vp8K1eb
 +LPmfPSobez0G3SbkUlvM7B30sswjqlwuWn6QmOJP3BpEht6j0CpJS1I9F+/tqqdQn4O
 grrZ8MhoHVc3d3JmW8GuJrRKVOlwE4G7xq+yUtr6uLgkt+g46CRw3ZWhES05tiRwTid/
 VrZvWRpsSiDTEhAoeeZCCgEpRamdA7G9tH4UeyGufqJG4E7ASYJmzwBxRM6o5syhPRjj
 vpRFuyl6CuwnFWPA+QFWXm8W8rClqIXr5ZT6IwyjcTDUyVNQMEsricCoc6qMgwpa9aqc
 M33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127088; x=1741731888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g9yH45YV1KCpKu1ZOSaE/nQIrSLBn5v2U2clJ5yvvVg=;
 b=dYKzvr6uyVgtGWL3vujbIQTrIjc+sVIOOu5RdwDowlBTvmR1pb1Frf5jAn7mfXHlLr
 uJ1pEhPJ4jm2WUYmB8ytZek7Ud1YcdEFvFCUYTdrL9lmcaCXFtqP0bkb2zVyBNGx0kJu
 TpNSY1lOquJb3+gRCSF6TY0Sw4dTgBnlPFAuzeXjrEnqB/HXE2Pz7q5ThLBLDjrU1hex
 JgGg9+u2K6GwLXk04DEQDiAS2bwvQeLXxLTKosK6dudz4ZZxeFwa7ijm7SOFRO5Jld8t
 5JaHLWNhTjoOWXy70BgoLppAQE1BYICqlfVw/l5CQVxPJw8oq9SN1W6U8ygVHiI6sN6W
 0dAw==
X-Gm-Message-State: AOJu0YzzRTiasIbayRKXM26/muDhVr09qTv1bUi1QzD+83lXUocJQQqN
 SXvttuKIbou3wb8EYVuOAyKmwZFzoK3lMfXJZUvBwNbUEyImQ6uVtqZ1REC8lq0=
X-Gm-Gg: ASbGncv+HreKYhr3sbTsQo7a6I/xQk4SSFMpwYCuyP+8BAB+zwCpHUFpE8+JE3HREcH
 1Xq506FM9t7LMdg8BYdjPdpzJJ9NBIqP0eMuIK25G0m9Laz5Qr++iHq66u/Fb+nhj+NZUOpYJAq
 5DsYa5gGshHuw36C6GDcEbrwa95zxwH+rf57sWyClKIk7siGPUMndcmT6RdPgQ9/PAddagLjDzS
 wQ/mcCS39nMrAmHRHJvTyNSn3aIIG9KI7MbmcH4IKeNYQH+Do/DdZ0YgAEXSsufHj0NOM6Cvc8Q
 HmpV/VmK7f/zsqVkjsLfa6OUwgu1eZK9eoOjcRzjf1Uf1jo=
X-Google-Smtp-Source: AGHT+IHfK1wp/l86i7JC/HiWl9IP+umiIE/xWOvQp8Qdjg+npnU2ItuiZhAPvpEOgc7Mk7cRjHTTwQ==
X-Received: by 2002:a17:907:7f29:b0:abf:7a26:c485 with SMTP id
 a640c23a62f3a-ac20e1dce23mr79596566b.50.1741127088452; 
 Tue, 04 Mar 2025 14:24:48 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c6ee654sm1017650566b.118.2025.03.04.14.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:24:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 413395FD22;
 Tue,  4 Mar 2025 22:24:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 09/32] tests/functional: Introduce the dso_suffix() helper
Date: Tue,  4 Mar 2025 22:24:16 +0000
Message-Id: <20250304222439.2035603-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Introduce a helper to get the default shared library
suffix used on the host.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250226140343.3907080-7-alex.bennee@linaro.org>
Message-Id: <20250220080215.49165-3-philmd@linaro.org>
[AJB: dropped whitespace cmd.py damage]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use simple if ladder for test
---
 tests/functional/qemu_test/__init__.py |  2 +-
 tests/functional/qemu_test/config.py   | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 5c972843a6..45f7befa37 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -7,7 +7,7 @@
 
 
 from .asset import Asset
-from .config import BUILD_DIR
+from .config import BUILD_DIR, dso_suffix
 from .cmd import is_readable_executable_file, \
     interrupt_interactive_console_until_pattern, wait_for_console_pattern, \
     exec_command, exec_command_and_wait_for_pattern, get_qemu_img, which
diff --git a/tests/functional/qemu_test/config.py b/tests/functional/qemu_test/config.py
index edd75b7fd0..6d4c9c3ce1 100644
--- a/tests/functional/qemu_test/config.py
+++ b/tests/functional/qemu_test/config.py
@@ -13,6 +13,7 @@
 
 import os
 from pathlib import Path
+import platform
 
 
 def _source_dir():
@@ -34,3 +35,14 @@ def _build_dir():
     raise Exception("Cannot identify build dir, set QEMU_BUILD_ROOT")
 
 BUILD_DIR = _build_dir()
+
+def dso_suffix():
+    '''Return the dynamic libraries suffix for the current platform'''
+
+    if platform.system() == "Darwin":
+        return "dylib"
+
+    if platform.system() == "Windows":
+        return "dll"
+
+    return "so"
-- 
2.39.5


