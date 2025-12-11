Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA6ED41C24
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 18:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTkz6-0000fj-DJ; Thu, 11 Dec 2025 13:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTkz2-0000el-Rb
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:01:44 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTkyz-00060j-VO
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:01:44 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so4804935e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 10:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765476100; x=1766080900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fydy/wFOHMaXv3Q3vL3Fm5k0awg5d++ulTrLBQ4Tnf4=;
 b=tLfbr170GOi5QWQ2s+owDAuMuTRSsR4IYEpmshQ1H1Pzeq5oa3PXQ1uW3FxFp7vHag
 pDKwdQYICAQveDKe4fUJOPO9UJGLv0umoKcJNnPy6ZBWA+sxXFNFKtlgBm4vnzYp76E/
 1pFjn1kaSy/fkXX2vtEcrgGequGlug8RGrKOMHx90af+tAepwX4NkiRE1dZCiAHOy8cT
 Xbthdv6/6kJ9H5qCUWhroeoCj5ENSgZZd9pd48lyjPtDVzw6IHfSGMNF9zOJk4X5RlZG
 6SZ8p0MRkSqSP00Vnz8uzU+UJBOdr+9Gr+EnnaKXuuRt8ASLMwmaqFURxEoQzRW9vvYs
 1vpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765476100; x=1766080900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fydy/wFOHMaXv3Q3vL3Fm5k0awg5d++ulTrLBQ4Tnf4=;
 b=Wdq2SXLgePgmfZbCIWLISkYjbFEfsqGd0tepGgfZobWWhvIkek/5Z1UDiEfI9/PSor
 eKT9yQvNrxL2Tx7lEhR6Dr21yONZpKEsSrV5WnSm1W+6mzOtJpHecfYNGW6EeyNRtGsI
 zm7f+imxKRAdio+1zVEcgKaIh2lT6SqeLH22sccrfPlYA2veK2uqmIkUl1WTOqsxOLLA
 W2pKcjVzb4h7bmcn5iTXgZN90ObQ7oYDrja8H46G5aStFgPO+o6fNr3Xm+kagAoDscVM
 rpU6+1wdCYb0XmChcwVBrEykSOfCjM5NxQuHxO+8F/SSmLca9DzN5DF8j3INx6UbBcVI
 F5bg==
X-Gm-Message-State: AOJu0Yx8VEkpDy8QS66/KtQKifF34DMEEo9gkxRiRWy/PY7t6pOrECXD
 v8CWcPp27Iav0rTsHPIZLnEEx1DTzdZTWEeRQz7Eb2Aftp0CRslXEBro5YjnCsMszE4K4cJEnJj
 qEnB+
X-Gm-Gg: AY/fxX7vN9eqbK1khRvvULOz64Q/ftpSbn9dX1tlNxeUGI6eHk1mSrriHxs6t3hgTEX
 QdLGE0TCkjbKoLdg+PgQssUEih4JBeTk/w/atX7NxJ2vpt7UE53Udf+CWI8hvv+h0NRVXWeGzEk
 /NozY8aMcdlnk5p1xMXYf5vWckI4a+c9h3uoEKQ0jGojOnzHk97dqUba/bydG5UX8Nq3dWT7TcP
 qfxYKQM5C7cDm0wbEkAaeQiDTBqYzZONlZ3tb1BXjVFQkx3PA6tkGJN8WW+NoaXowNIPykuJaUW
 XY+UGQqbpeavzAZifOspzJPXEQOJ+FtipDo0nJenBhgALPugOIANurVNzJ8xarrEflsD9X1Jfw+
 sK/yomMPKgv0QQF6d7dKhZasFsjLqyDyNr+MAOMRT/OG43kZsA2CpA/YtuOE5RNk6hHTsbB7uKG
 aCbZQdlbo9MhI=
X-Google-Smtp-Source: AGHT+IEMcialEH4Jr7Ci6fpb2+K7C+llv6Tb6xNVnC2zOsMSe7BpTnL/7a6mvHspv2BA6STodu9isg==
X-Received: by 2002:a05:600c:6305:b0:477:561f:6fc8 with SMTP id
 5b1f17b1804b1-47a837fcba9mr63441345e9.5.1765476099824; 
 Thu, 11 Dec 2025 10:01:39 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a89f74291sm46025705e9.11.2025.12.11.10.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 10:01:36 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 25F3C5F8DF;
 Thu, 11 Dec 2025 18:01:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [RFC PATCH 6/9] scripts/get_maintainer.py: initial parsing of
 MAINTAINERS
Date: Thu, 11 Dec 2025 18:01:29 +0000
Message-ID: <20251211180132.3186564-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211180132.3186564-1-alex.bennee@linaro.org>
References: <20251211180132.3186564-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_ABUSE_SURBL=1.25, URIBL_PH_SURBL=0.61 autolearn=no autolearn_force=no
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

Add the basic infrastructure to parse MAINTAINERS and generate a list
of MaintainerSection objects we can use later.

Add a --validate argument so we can use the script to ensure
MAINTAINERS is always parse-able in our CI.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/get_maintainer.py | 165 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 164 insertions(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index c713f290cc7..7b8ce2b65e3 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -10,9 +10,156 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from argparse import ArgumentParser, ArgumentTypeError
+from argparse import ArgumentParser, ArgumentTypeError, BooleanOptionalAction
 from os import path
 from pathlib import Path
+from enum import StrEnum, auto
+from re import compile as re_compile
+
+#
+# Subsystem MAINTAINER entries
+#
+# The MAINTAINERS file is an unstructured text file where the
+# important information is in lines that follow the form:
+#
+# X: some data
+#
+# where X is a documented tag and the data is variously an email,
+# path, regex or link. Other lines should be ignored except the
+# preceding non-blank or underlined line which represents the name of
+# the "subsystem" or general area of the project.
+#
+# A blank line denominates the end of a section.
+#
+
+tag_re = re_compile(r"^([A-Z]):")
+
+
+class UnhandledTag(Exception):
+    "Exception for unhandled tags"
+
+
+class BadStatus(Exception):
+    "Exception for unknown status"
+
+
+class Status(StrEnum):
+    "Maintenance status"
+
+    UNKNOWN = auto()
+    SUPPORTED = 'Supported'
+    MAINTAINED = 'Maintained'
+    ODD_FIXES = 'Odd Fixes'
+    ORPHAN = 'Orphan'
+    OBSOLETE = 'Obsolete'
+
+    @classmethod
+    def _missing_(cls, value):
+        # _missing_ is only invoked by the enum machinery if 'value' does not
+        # match any existing enum member's value.
+        # So, if we reach this point, 'value' is inherently invalid for this enum.
+        raise BadStatus(f"'{value}' is not a valid maintenance status.")
+
+
+person_re = re_compile(r"^(?P<name>[^<]+?)\s*<(?P<email>[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})>\s*(?:@(?P<handle>\w+))?$")
+
+
+class BadPerson(Exception):
+    "Exception for un-parsable person"
+
+
+class Person:
+    "Class representing a maintainer or reviewer and their details"
+
+    def __init__(self, info):
+        match = person_re.search(info)
+
+        if match is None:
+            raise BadPerson(f"Failed to parse {info}")
+
+        self.name = match.group('name')
+        self.email = match.group('email')
+
+
+class MaintainerSection:
+    "Class representing a section of MAINTAINERS"
+
+    def _expand(self, pattern):
+        if pattern.endswith("/"):
+            return f"{pattern}*"
+        return pattern
+
+    def __init__(self, section, entries):
+        self.section = section
+        self.status = Status.UNKNOWN
+        self.maintainers = []
+        self.reviewers = []
+        self.files = []
+        self.files_exclude = []
+        self.trees = []
+        self.lists = []
+        self.web = []
+        self.keywords = []
+
+        for e in entries:
+            (tag, data) = e.split(": ", 2)
+
+            if tag == "M":
+                person = Person(data)
+                self.maintainers.append(person)
+            elif tag == "R":
+                person = Person(data)
+                self.reviewers.append(person)
+            elif tag == "S":
+                self.status = Status(data)
+            elif tag == "L":
+                self.lists.append(data)
+            elif tag == 'F':
+                pat = self._expand(data)
+                self.files.append(pat)
+            elif tag == 'W':
+                self.web.append(data)
+            elif tag == 'K':
+                self.keywords.append(data)
+            elif tag == 'T':
+                self.trees.append(data)
+            elif tag == 'X':
+                pat = self._expand(data)
+                self.files_exclude.append(pat)
+            else:
+                raise UnhandledTag(f"'{tag}' is not understood.")
+
+
+
+def read_maintainers(src):
+    """
+    Read the MAINTAINERS file, return a list of MaintainerSection objects.
+    """
+
+    mfile = path.join(src, 'MAINTAINERS')
+    entries = []
+
+    section = None
+    fields = []
+
+    with open(mfile, 'r', encoding='utf-8') as f:
+        for line in f:
+            if not line.strip():  # Blank line found, potential end of a section
+                if section:
+                    new_section = MaintainerSection(section, fields)
+                    entries.append(new_section)
+                    # reset for next section
+                    section = None
+                    fields = []
+            elif tag_re.match(line):
+                fields.append(line.strip())
+            else:
+                if line.startswith("-") or line.startswith("="):
+                    continue
+
+                section = line.strip()
+
+    return entries
 
 
 #
@@ -103,6 +250,12 @@ def main():
     group.add_argument('-f', '--file', type=valid_file_path,
                        help='path to source file')
 
+    # Validate MAINTAINERS
+    parser.add_argument('--validate',
+                        action=BooleanOptionalAction,
+                        default=None,
+                        help="Just validate MAINTAINERS file")
+
     # We need to know or be told where the root of the source tree is
     src = find_src_root()
 
@@ -115,6 +268,16 @@ def main():
 
     args = parser.parse_args()
 
+    try:
+        # Now we start by reading the MAINTAINERS file
+        maint_sections = read_maintainers(args.src)
+    except Exception as e:
+        print(f"Error: {e}")
+        exit(-1)
+
+    if args.validate:
+        print(f"loaded {len(maint_sections)} from MAINTAINERS")
+        exit(0)
 
 
 if __name__ == '__main__':
-- 
2.47.3


