Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B014AD74EDB
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIc9-0004OS-9I; Fri, 23 Jan 2026 09:58:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIby-0004I0-2f
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:11 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbv-0007np-NG
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:09 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42fbc544b09so1781190f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 06:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180286; x=1769785086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1kjsB9PiIZhYgHWuhuM2nVSoa5jRfZPNm2SrsMSgiY=;
 b=N233cQQQh2ZJeDT8/h+RHxwQyitzcpBtoDuR5TQUFrF1Qkg/8ploAJReBnycZmcO/T
 NQ8OjNhwmnpEjzXke3BwoWOb5zsqq/DD5BvEEW+Gx1hU/xLkvrgNh1leAFnM7UEFZi1S
 +LVksxuoElbzZa3JlpHigNgQr+drjXX9CMpnXco4uMh5DU5HT5ymPmbk7k3vfEVcgwr3
 NOdSneYbbdIx+qgXvrNz+ec0rzYM0YDU1NYoU4Q7/wM1s+o9w7nF+/XXEFzbQIqZMEXy
 d/4p66zHpuMihTueciQJsQQZUQsiP7vnB9l7MN1uBTEHIbTMxPvPFUcfDtRVZTnQECWr
 qskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180286; x=1769785086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q1kjsB9PiIZhYgHWuhuM2nVSoa5jRfZPNm2SrsMSgiY=;
 b=oIk8uPZd7FY2/fBYDPVbvBEFo5RC5zkWUui506wPcuuuM5rz9EhXRT6xfmLi0FQi/M
 r1dhvQheoBrM0ukvHm9s/xnaOXFMzRsDOua2pfjk9+ypIHfJVtXxu9jt/8x7CRdGB+9E
 +Z3ByHabOm+AKisWUFYDyx/pgq4TRZzc9YvJGSRVxOTmgEuOTehNIxx91qzAT40HkAF7
 pVNPUjkRHDLrnx+MpKUrZ3JGsSFRINA9k0Wz3aBweFmDrKozq/YAGkEn421jW+0zZffn
 YeW3clj8skrdpyV10qLci31kOvYLf2NEd17bU8925MPMnH+3YPjTMBt8qWp9iB9N4GIF
 mZ1w==
X-Gm-Message-State: AOJu0Yy/JzlNDXivuYGCYyHosfGUsCwblDuUt/MCcmCHTkBbQ3atuMDb
 tdpbUmzFa8iLwu0IX/XX9oIZfX1k7fe1NwVkUBqAA7T3g//0N07MvSIGz/OGhz2+sh0=
X-Gm-Gg: AZuq6aL7he3WIMxCSPQ0Tq/MSHZqeuKEYtFNDaaOw6JEzA8Ou/KN2LLgO0v3ecfBy5p
 wiJK52aSEoZKtvxO0hBk+PC9l6n9nPCrrIG148t2bZ7gQzjfV0gHJGiA8EIdftEGWgrzO1+md2P
 ONIq0ME/pDvmakIfH+/xDUVk8tcTKOsqy7xjt3HlWXfF+ZIdUSxfWyupdp6fv7wb6bzQmga18xD
 6g3YEeAuQJVk+wM8+zxLG/BaKiGwlC7HAeaT9Sgzer843TKHnUPViC40D138u9kvWr9ER70GiHc
 Y3q24FzjM8WS7reklknxMNSGYLqPwSgDQYxaVE8IuYTbKjJ8z5OGdyRqrI6fmPXbNlyzx6OCl8b
 XvteS8Ixvx4woDJng8DaimXK3wLAcFBNP8S28dg6c2e/vhVPEXnolh8z7phzhHRWd36voHPjOTl
 Mp+pn29Z3Sl3MD
X-Received: by 2002:a05:6000:4287:b0:431:35a:4a7d with SMTP id
 ffacd0b85a97d-435b161fd66mr6132122f8f.58.1769180286049; 
 Fri, 23 Jan 2026 06:58:06 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1b6e2besm7470341f8f.0.2026.01.23.06.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:58:04 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 96B8C5FA43;
 Fri, 23 Jan 2026 14:57:51 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 13/16] scripts/get_maintainer.py: add support reading
 patch files
Date: Fri, 23 Jan 2026 14:57:46 +0000
Message-ID: <20260123145750.1200879-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123145750.1200879-1-alex.bennee@linaro.org>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Not so different from individual files, we just need to parse the
patch looking for the files and add them to the list. As we can parse
multiple patches we also need to ensure the final list of sections is
unique so we don't repeat ourselves.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/get_maintainer.py | 47 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index 96875255b11..f46d8f6e073 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -15,6 +15,7 @@
 from pathlib import Path
 from enum import StrEnum, auto
 from re import compile as re_compile
+from re import sub as re_sub
 
 #
 # Subsystem MAINTAINER entries
@@ -190,6 +191,29 @@ def read_maintainers(src):
 
     return entries
 
+#
+# Helper functions for dealing with patch files
+#
+patchfile_re = re_compile(r"\+\+\+\s+(\S+)")
+
+#TODO: also return a list of keyword hits for K:?
+def extract_filenames_from_patch(patchfile):
+    """
+    Read a patchfile and return a list of files which are modified by
+    the patch.
+    """
+    file_list = []
+
+    with open(patchfile, 'r', encoding='utf-8') as f:
+        for line in f:
+            m = patchfile_re.match(line)
+            if m:
+                # strip leading [ab]/
+                stripped = re_sub(r'^[^/]*/', '', m.group(1))
+                as_path = Path(path.abspath(stripped))
+                file_list.append(as_path)
+
+    return file_list
 
 #
 # Helper functions for dealing with the source path
@@ -305,14 +329,27 @@ def main():
         print(f"loaded {len(maint_sections)} from MAINTAINERS")
         exit(0)
 
-    relevent_maintainers = None
+    # Build array of Path objects representing the files
+    files = []
 
     if args.file:
-        relevent_maintainers = [ms for ms in maint_sections if
-                                ms.is_file_covered(args.file)]
+        files.append(args.file)
+
+    if args.patch:
+        for p in args.patch:
+            pfiles = extract_filenames_from_patch(p)
+            files.extend(pfiles)
+
+    # unique set of maintainer sections
+    maintained: set[MaintainerSection] = set()
+
+    for f in files:
+        fmaint = [ms for ms in maint_sections if ms.is_file_covered(f)]
+        for m in fmaint:
+            maintained.add(m)
 
-    for rm in relevent_maintainers:
-        print(rm)
+    for rm in maintained:
+        print(str(rm))
 
 
 if __name__ == '__main__':
-- 
2.47.3


