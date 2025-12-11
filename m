Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88312D41C24
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 18:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTkz1-0000eJ-0p; Thu, 11 Dec 2025 13:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTkyz-0000dO-6I
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:01:41 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTkyw-000607-1k
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:01:39 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so3919235e9.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 10:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765476096; x=1766080896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+y4zgoD+f0fN2QJ3KEy8mPHZuzX+JykDpAucVMG5uT4=;
 b=z5cMY8nEZntFyiZX/U+ZN1TUcVLvmdRweuWpIlAKYFKDzx452EKsr/jcy7Ak/AzIXE
 0KWskxujoTBu3zKjLDxp612YjtjmTtDmkl0DVZhSJwgbV5KAecInpehv0tFz4trJ1Ex7
 IVN7VyZz31NWzZE5Q6A8GDGr2QrMDTzpa8dtbM9109sgczzAMgX5rhI3oAqxb7VwjqPF
 hYblx690y0jc+9aN9NlTfVLpgYFl+9BOUvCaFUB5w9x3K5q6hkDiSwX6YvI2ZoSZJxXX
 VvUG/Frp7T5yCW5nNQirXyeoTAdur+uNN3diCpPBfTXDL+MDKVjx5xchPA2WSPqSuukx
 48jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765476096; x=1766080896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+y4zgoD+f0fN2QJ3KEy8mPHZuzX+JykDpAucVMG5uT4=;
 b=cn7sbTH/wMrHdYiKP1EJzCGrER7A1w72xKt1ErDYxNl9HOeGsf62zCta59PEL8tSZM
 yFeCLfUw/OGLcpXMEcYk9P7xD38vDoKchJe2Jj47H939m563Wl7+hBDMKnq/azsqsV8/
 JPYYCVmChAPid8Tw1B0NQxLivLH+HOlzpRCUTtENfsg6zRsbYNCd9/IVWkHJMzTKiwP2
 jyIHaNUUr7VnV19EX42xTFtAARMgac6d1u4tELASrQhRddZeEzSJZDDus9tgfvZkzJ8d
 9hoxRvqVbE8BgwW6/s9VKLqhrzZCLMUbJUinind3GmU0MUnqakOt57K7k/RDGOAESNNL
 +wVQ==
X-Gm-Message-State: AOJu0YyE+r//PxagVKUs8HhAiPuloG5ipYkZKYHm6CRQsADGyb8AXljk
 0Fdgzge/4c0hwHHuwwDDz/TDzjLvOHX6MNJ7tLt6WRlvEHW1mPLRF3Xq5ZVRWr6AONI=
X-Gm-Gg: AY/fxX4obCbtjA9w0b2B0QPxvsX37FNJvtJJ3IkCRDWUcD2SMqrJ6T86B6RnOe3MVsO
 ec7reitT3uIFsppcXLyhboqlSEaQXmmkYcuDAVxsK9Xp9Bp51kAfCN3+HKyCMvfww9UYdf5DvNp
 Sb23L8wAZ609J6AJM1RpWBZTl/b//k1tKkljjAaLgHhgPIO1Yps698nzNVWWiJ1zAmZZxtn/3Cq
 sXrkM8yMF2xsROy5X+qNS1YkhFlEHgtEaZ7AZny6Q5xn9LCVUVo3ZfaxzPGq4KYB3WD30BWOt/e
 2+8kxSl3Hr3Qg/ERwvGWXCIzstLagxXnK/Q4Eh+EVeN/9tP+V4mkGbqTXZgTuMrTwRXrMjZQQTi
 cX+st4U5oqdLMj1zohBcFW9wxTgmJNx0J2/+FEWdUOQvTVTnhEB/tPd8TAEbPEhM/9J6LfMUE6S
 Mr9UkcqcaSFcM=
X-Google-Smtp-Source: AGHT+IFId4bZZeZ1h79bDzQ61jLcGMeqhkkS+WyOENeIoltQe5dm8T2cTtmw0/KNkqKLBkZy7c0Egw==
X-Received: by 2002:a05:600c:3b88:b0:46f:d682:3c3d with SMTP id
 5b1f17b1804b1-47a8aef793dmr31249715e9.13.1765476096292; 
 Thu, 11 Dec 2025 10:01:36 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a89ef88d6sm18559145e9.8.2025.12.11.10.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 10:01:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EBFD45F898;
 Thu, 11 Dec 2025 18:01:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [RFC PATCH 4/9] scripts/get_maintainer.py: minimal argument parsing
Date: Thu, 11 Dec 2025 18:01:27 +0000
Message-ID: <20251211180132.3186564-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211180132.3186564-1-alex.bennee@linaro.org>
References: <20251211180132.3186564-1-alex.bennee@linaro.org>
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/get_maintainer.py | 44 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100755 scripts/get_maintainer.py

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
new file mode 100755
index 00000000000..2b8fc7ae9ee
--- /dev/null
+++ b/scripts/get_maintainer.py
@@ -0,0 +1,44 @@
+#!/usr/bin/env python
+#
+# get_maintainer.py: Print selected MAINTAINERS information
+#
+# usage: scripts/get_maintainer.py [OPTIONS] <patch>
+#        scripts/get_maintainer.py [OPTIONS] -f <file>
+#
+# (c) 2025, Alex Bennée <alex.bennee@linaro.org>
+#           based on get_maintainers.pl
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from argparse import ArgumentParser, ArgumentTypeError
+from os import path
+from pathlib import Path
+
+
+def valid_file_path(arg):
+    """
+    Checks if arg exists and is a regular file or raises ArgumentTypeError.
+    """
+    if not path.exists(arg):
+        raise ArgumentTypeError(f"File '{arg}' does not exist.")
+    if not path.isfile(arg):
+        raise ArgumentTypeError(f"Path '{arg}' is not a regular file.")
+    return Path(path.abspath(arg))
+
+
+def main():
+    parser = ArgumentParser(description='Extract maintainer information. ')
+
+    # We can either specify patches or an individual file
+    group = parser.add_mutually_exclusive_group()
+    group.add_argument('patch', nargs='*', type=valid_file_path,
+                       help='path to patch file')
+    group.add_argument('-f', '--file', type=valid_file_path,
+                       help='path to source file')
+
+    args = parser.parse_args()
+
+
+
+if __name__ == '__main__':
+    main()
-- 
2.47.3


