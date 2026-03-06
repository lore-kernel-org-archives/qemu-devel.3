Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56969FCB61C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXs6-0008IE-43; Fri, 06 Mar 2026 11:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vyXru-0007Kn-OA
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:17:42 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vyXrq-0007ji-MB
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:17:38 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so108186735e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 08:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772813853; x=1773418653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vllX98KGLiZLLrBT8HEqhhUqOqA+FrnDnUy3NTzv/l0=;
 b=YeCXZtqFDHDCAaHNjRUbYeQYZK+0+Ea2oA7dmM/04Dp6aDZTVqCSvpJUnarfDlS4S6
 4rupG8FVo6aF+eC5gmQ6bPM8OiUa1Gn8Snc8e6dJVyhcHOxPV/kIMvy1dvrPhY7fGKqn
 zY36HbsRIGjl166CXuvEDoLtHgRjDDM0TeUn4HyoqTKcKhIz/KKhGrKf7Z6XShFXCWc6
 qk+6sTZR6WKHWAckJvppnmkMIgtmrstJnAVZUYW5GnHPClR5TcWo+CENXKiEe2qIhPGp
 GndeS1eHJ8aKl/vgRLFfJbyR9kcN8Yo+VZTPFR39SYDpEtMgAw1F7xCva51wz/LGGcx0
 S+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772813853; x=1773418653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vllX98KGLiZLLrBT8HEqhhUqOqA+FrnDnUy3NTzv/l0=;
 b=rohEd8DJ9QGbRld/O9zIL55Gz4ERvWBLSKYtgAeSkeCfjhO3sE4G3Gfh/OUHm2fPcG
 lNguQ+PT8Ax46I4Y94N0bKFkhpZhpN1IYuv/vAxkSIpZVcMpuMfZj0Eb1gToh8XodpQG
 7+LkwrKsDQBqaCGu6OagTZBXArRd47PMferD5ngcky5SO1BQPTF7HNbiyufmrVs3g8Mg
 qPKVJvJgaVFdGR5uX2n1YkyJmTtl6d2A9mYzrGD0b+yBRcrueVpVM4dkm+tn7CFCX63V
 A6MTcBpfNkWpGAqCmCo4+1gtC9GU4ZePSVdI5k7m4JVAc9CsMjzQBcfbFg/AoSIu2xdg
 QZ1g==
X-Gm-Message-State: AOJu0YycoAhYmiR6nIHvirwidUao4P1cV4Zemn0iT+Kw+Gyv7PZyzlkT
 yS3mJNC1QITJfAmSqViRlTF9+lcZGahAo1Dg7Kgs7wO2nUEviTS5+4gy7pxGTwESNEw=
X-Gm-Gg: ATEYQzwBoFJ0admuXhD4mCWKr5rzVADm2nmazwmijwmyT7gzha5RGvNxIT54g5/eVvn
 YX6dFndKEutAR7MC04Vn5Xo09RYOiwsiiA7RZRmoiCss55u8SHieUzztj/THNoD13fAlrp4G6Zc
 Btxjg/uxJduj7aVS7TwSEGZyXfEW0VUjwWjj7cM8vVKcf9quKMFxnp/xIeJHkio6TxOPhzS37eK
 K2/BksDH9RTF6duaSiQRFzm8x7Nb2McOTML0nshHZOPRXVwWZWwRm0aVyRTxy56k549OGqIxKtB
 jYYp6u2izuYqFWeK5ZVbSM3szqy5GWikept5p7vuVyLJO1ot/mjHzRyYIoICbV648Pffnzq5glP
 CL6XKAfoGao4jzftrmZAL7ROzWKhm8cFzrISPKK2Lg8vRyKsZ7GKGvJyKYtmKea6ZYvDOjXBRQb
 DnH445jtb+u1P+J6BdIqoRHIM=
X-Received: by 2002:a05:600c:c491:b0:480:20f1:7aa6 with SMTP id
 5b1f17b1804b1-4852695880emr47085425e9.21.1772813853014; 
 Fri, 06 Mar 2026 08:17:33 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fad2812sm207962975e9.1.2026.03.06.08.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:17:30 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3D204689D3;
 Fri, 06 Mar 2026 16:17:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 4/7] tests/functional: teach uncompress about zip files
Date: Fri,  6 Mar 2026 16:17:25 +0000
Message-ID: <20260306161728.2657486-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306161728.2657486-1-alex.bennee@linaro.org>
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Yes people still use them.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/qemu_test/uncompress.py | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/functional/qemu_test/uncompress.py b/tests/functional/qemu_test/uncompress.py
index 5bbdf8fe323..f1a0e583a5b 100644
--- a/tests/functional/qemu_test/uncompress.py
+++ b/tests/functional/qemu_test/uncompress.py
@@ -12,6 +12,7 @@
 import os
 import stat
 import shutil
+import zipfile
 from urllib.parse import urlparse
 from subprocess import run, CalledProcessError
 
@@ -58,6 +59,26 @@ def zstd_uncompress(zstd_path, output_path):
     os.chmod(output_path, stat.S_IRUSR | stat.S_IWUSR)
 
 
+def zip_uncompress(zip_path, output_path):
+    if os.path.exists(output_path):
+        return
+    with zipfile.ZipFile(zip_path, 'r') as zip_in:
+        try:
+            # Get the first file from the archive
+            names = zip_in.namelist()
+            if len(names) != 1:
+                raise Exception(
+                    f"Zip file {zip_path} should contain exactly one file, "
+                    f"but contains {len(names)}")
+            with zip_in.open(names[0], 'r') as archived_file:
+                with open(output_path, 'wb') as raw_out:
+                    shutil.copyfileobj(archived_file, raw_out)
+        except:
+            if os.path.exists(output_path):
+                os.remove(output_path)
+            raise
+
+
 def uncompress(compressed, uncompressed, format=None):
     '''
     @params compressed: filename, Asset, or file-like object to uncompress
@@ -81,6 +102,8 @@ def uncompress(compressed, uncompressed, format=None):
         gzip_uncompress(str(compressed), uncompressed)
     elif format == "zstd":
         zstd_uncompress(str(compressed), uncompressed)
+    elif format == "zip":
+        zip_uncompress(str(compressed), uncompressed)
     else:
         raise Exception(f"Unknown compression format {format}")
 
@@ -103,5 +126,7 @@ def guess_uncompress_format(compressed):
         return "gz"
     elif ext in [".zstd", ".zst"]:
         return 'zstd'
+    elif ext == ".zip":
+        return 'zip'
     else:
         raise Exception(f"Unknown compression format for {compressed}")
-- 
2.47.3


