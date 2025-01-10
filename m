Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8310CE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEzg-0000kr-Eg; Fri, 10 Jan 2025 08:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEz9-0008P9-AJ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:36 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEz7-0005ed-Cr
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:34 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d122cf8e52so3246945a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515412; x=1737120212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VElp+3f5K/8aS805Hx1mlXPx4V+6pBsG4GTVS+w14T0=;
 b=VmXdpRuhTkQFXEOVE0w3KsTQFsKu1uBf4272OsrY6P/eZgsH93lKQG5Vdy5m503SWc
 ya7ax/Yz8piabZw87clW5c7v95HLRlOlWklZpfDOc2Sn+nB0/f/IDQ3dHD2qyWJ7nGpN
 4S70zCxesgLutVML6B1Vv+xITtVcXuu4oW+RgXKk8ap/nmV5UXh0z/jutxAzKsgXsG1A
 /dHYl+jNCH2GPCG6WzOaXkwdkaiDesmjbZlWs9X0CJI9mBldx8bc/tgRV+1ZVMjLmSKL
 S0bYvFe3wf5AdScBYesL0+C2zYgAIoNIPjJq/OhQoq3zQUvEDa636ZrCIYfojkzwJlbl
 iQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515412; x=1737120212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VElp+3f5K/8aS805Hx1mlXPx4V+6pBsG4GTVS+w14T0=;
 b=ZUCdF+xWueitY1JdPagF1RlIbxyd6rm19Ya5Pkrja2bi6URa5E4tyJ28PnGL0wmIXn
 Y6x6ytvxfvT1R+KOiGvxjJK4sknjUKOyA3NS73ktJCW2Dm1NfNuNOPA04Hrbi++rihdC
 d28nHBR/TfDVj6UclROVvr7VKR6p46eYk5EbPBChI/uA/Fyi+C6F4TmnJBbQFYjw0e8f
 w7OHIjFMZfyi4bB4W0bH8R6Jyqgrv/nis5uVGdGiaghe9+ZYtpDRzVIrQmoBeNyAKVWx
 0I+djEI+WEFI8cYUIxa/4QPuVw/qTIG32BAN73YGgxf3JrAYGXVPMTcP+JrLnOJD0zOi
 eDCw==
X-Gm-Message-State: AOJu0Yz/UDwiSto8T3/8+W8LWBLD5IYqJJPkn+IdIkvrYQI0/RH01vaB
 41go4//m3RTx8vYuSmk/hQK3e0Fvt4DRzstH4LvtFSAdanIWlWq99jk6Mz5pTrf/57QkqqsTem5
 0xXI=
X-Gm-Gg: ASbGnctFZ9q8sqJChk3PD/4WNmPY6C51bGbXjMrAnEs0l5lgRQzx3HAnPkLwiCCmwgx
 YvdjsLk4C2CIeR2RU7/Y6Ii1roeF+s3WocMm8tEYi3FNmrjvz2OCSpPQcoGYtIStm/XD7fLdOpu
 tYqI45UoDzygqMDPH52OwSWp3XEl/DCQ2BjQcuXUZAWuT2onGAQw8SCij5V95X5ny5QNWKP6m4G
 F0JeeWwmOIytj7Cwp+idijNzIrXsyTdH2ln5YQvJ3W696gDaaPQMkQ=
X-Google-Smtp-Source: AGHT+IE1JKnnC9DbgifFXv5CK0xc+ViGz4Tkj2G2pJwRwV6Vj97O3coXjiMYVv2T5KeyvTrjdUJnNw==
X-Received: by 2002:a05:6402:4415:b0:5d1:1f1:a283 with SMTP id
 4fb4d7f45d1cf-5d972df6fecmr9497530a12.4.1736515411881; 
 Fri, 10 Jan 2025 05:23:31 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9903c3333sm1713852a12.47.2025.01.10.05.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:23:26 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C693D6142C;
 Fri, 10 Jan 2025 13:17:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/32] tests/functional: add zstd support to uncompress utility
Date: Fri, 10 Jan 2025 13:17:41 +0000
Message-Id: <20250110131754.2769814-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

Rather than using the python library (which has a different API
anyway) lets just call the binary. zstdtools is already in out
qemu.yml so all test containers should have it around. Tests should
still use @skipIfMissingCommands('zstd') to gracefully handle when
only minimal dependencies have been installed.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-20-alex.bennee@linaro.org>

diff --git a/tests/functional/qemu_test/uncompress.py b/tests/functional/qemu_test/uncompress.py
index 6d02ded066..76dcf22385 100644
--- a/tests/functional/qemu_test/uncompress.py
+++ b/tests/functional/qemu_test/uncompress.py
@@ -10,8 +10,10 @@
 import gzip
 import lzma
 import os
+import stat
 import shutil
 from urllib.parse import urlparse
+from subprocess import check_call, CalledProcessError
 
 from .asset import Asset
 
@@ -38,6 +40,24 @@ def lzma_uncompress(xz_path, output_path):
             os.remove(output_path)
             raise
 
+
+def zstd_uncompress(zstd_path, output_path):
+    if os.path.exists(output_path):
+        return
+
+    try:
+        check_call(['zstd', "-f", "-d", zstd_path,
+                    "-o", output_path])
+    except CalledProcessError as e:
+        os.remove(output_path)
+        raise Exception(
+            f"Unable to decompress zstd file {zstd_path} with {e}") from e
+
+    # zstd copies source archive permissions for the output
+    # file, so must make this writable for QEMU
+    os.chmod(output_path, stat.S_IRUSR | stat.S_IWUSR)
+
+
 '''
 @params compressed: filename, Asset, or file-like object to uncompress
 @params uncompressed: filename to uncompress into
@@ -59,6 +79,8 @@ def uncompress(compressed, uncompressed, format=None):
         lzma_uncompress(str(compressed), uncompressed)
     elif format == "gz":
         gzip_uncompress(str(compressed), uncompressed)
+    elif format == "zstd":
+        zstd_uncompress(str(compressed), uncompressed)
     else:
         raise Exception(f"Unknown compression format {format}")
 
@@ -79,5 +101,7 @@ def guess_uncompress_format(compressed):
         return "xz"
     elif ext == ".gz":
         return "gz"
+    elif ext in [".zstd", ".zst"]:
+        return 'zstd'
     else:
         raise Exception(f"Unknown compression format for {compressed}")
-- 
2.39.5


