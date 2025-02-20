Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83566C021AD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 08:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl1W0-0005mf-AT; Thu, 20 Feb 2025 03:02:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl1Vw-0005mK-Fw
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 03:02:32 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl1Vu-00050s-T0
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 03:02:32 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38f3913569fso1022223f8f.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 00:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740038549; x=1740643349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TlxCO3OP4jHOxjhIDriULZskStv3lHgU44Xm50YhQ6s=;
 b=ezRh1XB2EME+0KMfL19cuQSvMmbOfp9JiJsNr08arOYlDDg9p1dfYWaAVauVkPWhSr
 5dl9073nVCIoDpOJFRz2KBwlf4HC34zcBMBUjoH3KjNEx5PsbHVA2w+TEYqzDIHy1M/M
 K1Ttl3HxusVGn7D5itat+kBMvM4yyww1lunD99l28XGEd5vhcGWc0NHzz2veSNZy/64O
 5rfuQglW8jyEJdLwYxJShLq2fPQPcPs6/6fEs85b+DZKtLAxt522tMuIqSCI0rG2y7ra
 4h6CDbBLPdmBC5gZHE23FeKutysftN9q2d12MASSCmeZsfnA8sPt7nvSACI1CxTHJ2qJ
 pQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740038549; x=1740643349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TlxCO3OP4jHOxjhIDriULZskStv3lHgU44Xm50YhQ6s=;
 b=FofKus7aDI3xpfkGopEy4ldGRj6g3oDqcXWqLo8p1gVJKLwDcWN2hp7pOA82iqxsvu
 3TETsuTIm0ipsOoXYSCiSuSeFXrAn86woEqx/pohL7Cn5ndNXPZWbX92aDfcxNs6xFD7
 kBMp93BkRee+d6N09IFl3nB56/Fmf3zlgZYeoYPqkr+1dg5/4LygdgSXfwQq2BI2grIw
 N0AMlVXJKmv8C0nmbjwwTFJJ2BzDigbXItV5wnbf0AqTo7+E7bP5Vw5jAuG6Ynlf9VvJ
 9nkdnGbX5dsUxXtZUFVmLU7wFc0R1Z0P3sCCR+bpb5yZccd2iNomVtO4uRbSlQ3Ukt2G
 f11Q==
X-Gm-Message-State: AOJu0Yy/+L7lXVOkY5Lhk01r/ZXb2c1k9ESDDAEZKIAtYUsf1ZwiNJ5C
 1k9qVxeVdoDJIm9MQ9Jhxl1MMK0eyJ0q1vVAI9Iyo2Zeayb0r74q1OQGGIqXHE8Qr2ZQKbcrgou
 vCxc=
X-Gm-Gg: ASbGncv6J5YrqzUso9Bb6SjDJDQ6+J6agaXTRV+bN1axOd/IqQr+6ctd6AU49v7UWHH
 eWWfM5gTNgdas5Z0djnOUVzI0n4ctGCpaPhRz3jcf53kicPuVvz4BeJjR7eTZv82kep04x+kGTG
 1yif+w94Nqnfg3q+YPZ5ncXh+EGewDNNdfv/qztxx49jGxLfEgLYsLdzskgc5NUwwTLh6QVyWfD
 RLrw1dBz9rZiWTCKtGtuuU2+uSPxJQra8ZPafASbQ6Tr02nDTHojGkVv1lAgpALV3DhtZ1zNJ6z
 YrJpu+Mj+2omdqJtPL091cCS25X4e/L09atpCKkvRB1X6Cn7blfSG1P15ov56G5zkQ==
X-Google-Smtp-Source: AGHT+IG+fH2x+g2bhs2juytWEwHo2meZpdDj6qZpaz/kF6HAaaZdHCLfrXn8Ct0HMxOcIWz5Ns9SKQ==
X-Received: by 2002:a5d:47c3:0:b0:38d:d59c:c9d6 with SMTP id
 ffacd0b85a97d-38f61611400mr1853120f8f.21.1740038548901; 
 Thu, 20 Feb 2025 00:02:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a055910sm233020165e9.9.2025.02.20.00.02.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Feb 2025 00:02:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 2/3] tests/functional: Introduce the dso_suffix() helper
Date: Thu, 20 Feb 2025 09:02:14 +0100
Message-ID: <20250220080215.49165-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220080215.49165-1-philmd@linaro.org>
References: <20250220080215.49165-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/functional/qemu_test/__init__.py | 2 +-
 tests/functional/qemu_test/cmd.py      | 1 -
 tests/functional/qemu_test/config.py   | 6 ++++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 5c972843a6d..45f7befa374 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -7,7 +7,7 @@
 
 
 from .asset import Asset
-from .config import BUILD_DIR
+from .config import BUILD_DIR, dso_suffix
 from .cmd import is_readable_executable_file, \
     interrupt_interactive_console_until_pattern, wait_for_console_pattern, \
     exec_command, exec_command_and_wait_for_pattern, get_qemu_img, which
diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index dc5f422b77d..254e23ef748 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -15,7 +15,6 @@
 import os
 import os.path
 
-
 def which(tool):
     """ looks up the full path for @tool, returns None if not found
         or if @tool does not have executable permissions.
diff --git a/tests/functional/qemu_test/config.py b/tests/functional/qemu_test/config.py
index edd75b7fd06..0eab1baa541 100644
--- a/tests/functional/qemu_test/config.py
+++ b/tests/functional/qemu_test/config.py
@@ -13,6 +13,7 @@
 
 import os
 from pathlib import Path
+import platform
 
 
 def _source_dir():
@@ -34,3 +35,8 @@ def _build_dir():
     raise Exception("Cannot identify build dir, set QEMU_BUILD_ROOT")
 
 BUILD_DIR = _build_dir()
+
+def dso_suffix():
+    '''Return the dynamic libraries suffix for the current platform'''
+    DSO_SUFFIXES = { 'Linux': 'so', 'Darwin': 'dylib', 'Windows': 'dll' }
+    return DSO_SUFFIXES[platform.system()]
-- 
2.47.1


