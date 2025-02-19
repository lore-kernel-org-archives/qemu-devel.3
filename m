Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F867C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 19:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkpfn-0003ys-4L; Wed, 19 Feb 2025 14:23:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkpfj-0003ya-K6
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 14:23:51 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkpfh-0002Oy-Lg
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 14:23:51 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38f26a82d1dso80569f8f.2
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 11:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739993028; x=1740597828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAdS2AzhgVB27ZZVS2e2BP8pQ8iWHjSm4H3O9eLeBHQ=;
 b=K3oylEzZlb0UGpcvR0VlbzuOBRt3R0zRUHd2FaHXLBMuXX8DDQjsDWzpe7hw2TU5cF
 FD6P8JIrxqtMYHTo+WyAARq3ig3TFjsn/YPN1NGZzu26jsz127LBCQUv17E03CbOLb/d
 NtI5ogp7cKI2tcpY0a1BDiSaTJOR31symlYbUJhXbHagh6sMCZXZ9ACzoSxCuQbbOg/z
 gSA7YhlzosBn0Z5X0YnR2glQa6LIst0n2kr33/LZOVilcslSgSKYXDRNSCsxSS6Xj0U3
 9M4lsP337SUCWhPlVSJj54fvE8n5XqYQL3ICWoM+0NJjVPpHAzv4zKKmvvzM5wcthos1
 lViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739993028; x=1740597828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XAdS2AzhgVB27ZZVS2e2BP8pQ8iWHjSm4H3O9eLeBHQ=;
 b=JE8FolBOLjQC9HxVGvbG13p8H+EwkfySAWpfxyjZ3tDFIDZvfmH9pU8AmWoPNQB5tE
 RJevIX+zo9+CPRCagDNVCWw1XcPH890/L+ISCSINW7tOKGiq1WS39t3Ng93wtGAZ8m/P
 dXdYnsfVid6S+iJtcYkQS+zMRqrzkaEadObPQ3l9sBU7Ke0VV3TUzxsQ41/5ur6t5R0S
 AWqcXI/pQMkab8gZVXb0eoEor55tFSCMN7nI+K74ZjMgGEL8Qb6zRC6VSjr9N8wStRAv
 1PDvirrrq9+yj1yfoWsSzLmx5jWpc60esbvlDhY2M0CxNIQSpZPiDCWQI2xWMdHdU8Qd
 CntQ==
X-Gm-Message-State: AOJu0Yy7s6AN/+KE1DkypltovYhQwFpCUNSKb4+p06WQhglmj49Ih23C
 teGvzG0Y1FKiK3+CKX6D3DfegQp8gGMjecWMkMNXuaVm5RTb9QO+3JDYRKtLXqRrXGOKsrKfSay
 syRA=
X-Gm-Gg: ASbGncu+hubCb3pzx7Rqnc0BRwyLaXZjJ5DV2vsPfLv3dB8gDqfFEwcXJqyRL+kMa8t
 rdaFrJqmngdwJxU8YnlGMQykL2DufaZKr0TAmlJFKgTQRe4SmgdsGbIFf78I5tcMSad1pYnQQbM
 sHskS3rr2t4NVyS/PWHUoYqgUB0cilgcOPLK+tO/8Ae2rwbQh4NvDL512oBKbrk3NeZzCJwc58u
 2vbOAVlPD+J0xXv60WoApFOotYsNkEnq6cAUiAcxFj5pqaryJsv4q11d/6/sEx5lx0lF3v5iQt1
 m5NE1jj9+b9QRWodn25V5MzM92lmR07O8SH5xPS9jkzOIuXaqhpzsc1yx0cxNkG46w==
X-Google-Smtp-Source: AGHT+IFNYnrEvvll2UxSpI9/it6v8PvHdIZ0Nu2EmybWDmy++W5Ubn126MBCp86ws93tNnkqhhxrRA==
X-Received: by 2002:a5d:4cc7:0:b0:38f:2bd2:45d0 with SMTP id
 ffacd0b85a97d-38f33f58d98mr15577888f8f.51.1739993027694; 
 Wed, 19 Feb 2025 11:23:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f7df2sm18610709f8f.84.2025.02.19.11.23.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Feb 2025 11:23:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH 1/2] tests/functional: Introduce the dso_suffix() helper
Date: Wed, 19 Feb 2025 20:23:39 +0100
Message-ID: <20250219192340.92240-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250219192340.92240-1-philmd@linaro.org>
References: <20250219192340.92240-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Introduce a helper to get the default shared library
suffix used on the host.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/qemu_test/__init__.py | 2 +-
 tests/functional/qemu_test/cmd.py      | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 5c972843a6d..e253288ee7f 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -8,7 +8,7 @@
 
 from .asset import Asset
 from .config import BUILD_DIR
-from .cmd import is_readable_executable_file, \
+from .cmd import is_readable_executable_file, dso_suffix, \
     interrupt_interactive_console_until_pattern, wait_for_console_pattern, \
     exec_command, exec_command_and_wait_for_pattern, get_qemu_img, which
 from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTest
diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index dc5f422b77d..c4704dfb7bc 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -14,6 +14,12 @@
 import logging
 import os
 import os.path
+import platform
+
+def dso_suffix():
+    '''Return the dynamic libraries suffix for the current platform'''
+    DSO_SUFFIXES = { 'Linux': 'so', 'Darwin': 'dylib', 'Windows': 'dll' }
+    return DSO_SUFFIXES[platform.system()]
 
 
 def which(tool):
-- 
2.47.1


