Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AB7D74EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIbv-0004Fq-N8; Fri, 23 Jan 2026 09:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbt-0004Ed-KZ
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:06 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbs-0007mc-1m
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:05 -0500
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-430f2ee2f00so1442897f8f.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 06:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180282; x=1769785082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+y4zgoD+f0fN2QJ3KEy8mPHZuzX+JykDpAucVMG5uT4=;
 b=iofirigK3gY9wOn3lPafn4QXC16BjhXckwdskO8b4x5yDOixmYSPdqfl9XHW/PVQFG
 5e+UYqtfNcBu6sDCKvkCP+sRsztwGXwl7jbld4yqCC/au2TuZM5BNvN5Eqoj7QTmtpCD
 +oLaDsTCjwZKqFG3N0D0IHKUBv5D5IDuNr0tAr0dDuIGy7jMZT6XZeG7QNsRlRcZTHTC
 U3cRSquFPIZzwvAnJj5wFo5JNNZsldggA5vib5776D1yBxcFU/+R6Ka8HezxixMEKLjk
 Afqths040aMKIJNr6hsipTbmoGxXMEuROoEZsmkAUAccgQZIGMHdT6HPTDJqJmWZazoz
 f5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180282; x=1769785082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+y4zgoD+f0fN2QJ3KEy8mPHZuzX+JykDpAucVMG5uT4=;
 b=eyPJK03Nugp76uBZL32Q/s5kDVB4BeJltMZHN2/1MwtkdIJeQK1CK/+u4mUenjzoIY
 aLEnkvo/CXVF7iB1HmZnQ/p3X3bIwGUoPYL3s2dQwibxq8LYeC/XFyr8EDdewkbBsu+g
 h2HkF3ezn2+5EqVsOytT4Mnkc/mFZYQswuxBhobUwHmBvCw9Yi0uSQkfxR8Pmk3S2aIr
 yoq6/tYYZ/eYMimSSYF9Hu7VT8Soi3YvvdPuvBMgbvd33ZrD0+BAcgklfJUt6zNorMHW
 zIqbx8nV7jwtmsUir5OO2eLiyCrDlp/g/2PczsJol3exifxZHcqGfbceg/uGvqsu82B3
 +GqA==
X-Gm-Message-State: AOJu0Yyu5Ag9x9nNA9cxNxz9srsCC46EIrV3GEZghs0zzQtpHOeZVnjM
 hV3d9L45cucuGmj9CAdLMC46Dzd/DiSEGncjIAT19OuNMImWpZyeFEB08i4NzOPRrlU=
X-Gm-Gg: AZuq6aKJ8e8MnP99Uxh0ix9JQY7p7TZoBHvKq3perD38wEPKR+dW3jciO/J2bT3STuM
 0/LPt6BXgAfmyn7V0fkl5GgGDu5kyWon1mUjSupvdB1D1uOOTI9/Tz1/EuWXnrMu/gVXbLrfinC
 pJSwTaId4t2u+1FgjtYThzjfwCpMWOD508ieIESkKvmy88qnYX+M+JtqakvTqNPOiWkp6nV+oCR
 Q/L2YeK7BKjlBkP6cHw2iDlXn0JAE/x7OAKLFBuOLgWYr7aV5D63loHO8R/Z3aXl/SUbWNA3mye
 FwiYSL8d45d7kPAAe+Oa//fc6PwNMwBpagVzfAHQGaWMmBkLkuLQia7Tu7xO5GPZIosMGwc55cC
 TC3VhX848xidQtrqlbDLelEzkxHUia9BMvG0I0VO8jiiQfFpzfKMslaKLudKwWwMK931DzJhU8J
 ZBhsU0u/B3qUm/
X-Received: by 2002:a05:6000:1861:b0:432:851d:35ef with SMTP id
 ffacd0b85a97d-435b163ecb2mr5832145f8f.42.1769180282436; 
 Fri, 23 Jan 2026 06:58:02 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm7663882f8f.26.2026.01.23.06.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:57:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3EB475F91C;
 Fri, 23 Jan 2026 14:57:51 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 09/16] scripts/get_maintainer.py: minimal argument
 parsing
Date: Fri, 23 Jan 2026 14:57:42 +0000
Message-ID: <20260123145750.1200879-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123145750.1200879-1-alex.bennee@linaro.org>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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


