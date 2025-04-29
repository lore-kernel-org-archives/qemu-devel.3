Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9FBC3ABAB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 16:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9nsf-0004IN-DD; Tue, 29 Apr 2025 12:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9nsZ-0004CJ-Mn
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 12:32:19 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9nsX-0004f0-3u
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 12:32:18 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c1ef4acf2so4725042f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745944335; x=1746549135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0W4rjS2ztSb/BLdpUMpJKYaRm/fmkPTpxWrZeMfG94=;
 b=YDApYYNng/YnsKWN7AwXVS0AQIvpldONnjPRRljxtn7Ge83Ghj7klSqfV6mKANbFD7
 OHDzd0OhKFh1h0VxhECYKLsizHto+0RfekO3+pYYCU7EfK+7NIsqOrnu15LWeMgRiyHq
 TKXbigEF13i4oWt1zTnRt2OOVOasz3IdnAhIUpue7Y1+lQ6Avhgw4MmOi0bYiCVBAbTz
 GGBqLM+IqSgImnBCpJJLc7AkS1N5sr9QfJ3cf/nqrmmnvF/9/g9SnwiExsnyLqz4p2bj
 3esTMZ7kwQQzqewTOfwqxV3B40uMlQYJiRvpWhI0L+1DAqUCIHBJS1xMkwrRx1pr3dci
 /nLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745944335; x=1746549135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S0W4rjS2ztSb/BLdpUMpJKYaRm/fmkPTpxWrZeMfG94=;
 b=FiTbFMmGNfZHtIl0jPzQuZbn61utbQOHuUQZHtdpyWElCebaU1s9WTbPYZNbQ0lKlJ
 nsZWL17dNMKbvmYx5N8UIQkEZ6aYjbKYMyTMAQ1y1DAf4rnsFr7KS9lNDhEmAcol2v3v
 jqEyLVigKQgIc/UN6UKco1Zm4JI1AJ2IHYAK34kPjbu1es+OPb0Bws2UAoQAWv+AOIEO
 GSqEJeB3HcwlDALcfXcdqdqaEc405XzB9pZfJxZF536WdexmN6M+qo2zv4/zO99Kd1Dw
 avlR/MzrR0Tz40pVBlWztDU/iVLFASVEMcFLenwvXAAoowxD60+1Yni1EuZiG1hn50Z1
 oZEw==
X-Gm-Message-State: AOJu0YycevTT8EOCffXW1ngUmkXsTyOKj43dYDZc9U1XsIDFaLBz+MAi
 BJoieS54RLuaP89tC6Nu2MJKgoPAIW//pVrSGXy1MHAaTaRnLRuX85FAPqYipKTuoiJgZq84xYZ
 U
X-Gm-Gg: ASbGncs8/BAABNaHj3uEPw/yLRFb+7YrHoyKbl2qBb5vTpjh+9cWVf0C4yxxdGIhzyQ
 lhd/QYU/X/iSLDPRALH5RF9wSbMC2Th+9+wRnz2CAgdwcvDRFcf/n8DmhOzQvnBw0K2LzvECfI7
 Zy6IH0vSCWrwjckPaG5qJQlVXxYfZSHottVRxafOyW1+kkR6CnV/jQbq55yFatuRugPPTwlA/m7
 MoblE3GoFmM+V+fKMze/ojgkBTgy8G8fJr1YWrvbwAudMlSoJHGhVplr+ySyECSx0anc5pUdFw6
 D/UnAdMUffZtfhCsBdembU3KVlNOeULRomQHrEzpSy/DE9s=
X-Google-Smtp-Source: AGHT+IGHzrDKjo4Jwq74ZfCA2MdpBeNFsw+T51/o7ZYv6C6fi8FyXxBW6wu5dGXBh5hEI69OvZHHkg==
X-Received: by 2002:a05:6000:4382:b0:3a0:7a8f:fc73 with SMTP id
 ffacd0b85a97d-3a08f79dc65mr23172f8f.14.1745944335481; 
 Tue, 29 Apr 2025 09:32:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca4cbcsm14176326f8f.25.2025.04.29.09.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 09:32:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/2] docs: Create a uniquelabel Sphinx extension
Date: Tue, 29 Apr 2025 17:32:11 +0100
Message-ID: <20250429163212.618953-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429163212.618953-1-peter.maydell@linaro.org>
References: <20250429163212.618953-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

Sphinx requires that labels within documents are unique across the
whole manual.  This is because the "create a hyperlink" directive
specifies only the name of the label, not a filename+label.  Some
Sphinx versions will warn about duplicate labels, but even if there
is no warning there is still an ambiguity and no guarantee that the
hyperlink will be created to the right target.

For QEMU this is awkward, because we have various .rst.inc fragments
which we include into multiple .rst files.  If you define a label in
the .rst.inc file then it will be a duplicate label.  We have mostly
worked around this by not putting labels into those .rst.inc files,
or by adding "insert a label" functionality into the hxtool extension
(see commit 1eeb432a953b0 "doc/sphinx/hxtool.py: add optional label
argument to SRST directive").

This Sphinx extension adds a "uniquelabel" directive, which creates a
label which is made unique by adding the name of the document to the
label.  The name of the generated label is "dir/file-labelname"; this
is patterned on the generated label names that the hxtool SRST(label)
directive creates.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/conf.py               |  1 +
 docs/sphinx/uniquelabel.py | 74 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 docs/sphinx/uniquelabel.py

diff --git a/docs/conf.py b/docs/conf.py
index 7b5712e122f..562db95bbf8 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -67,6 +67,7 @@
     'qapi_domain',
     'qapidoc',
     'qmp_lexer',
+    'uniquelabel',
 ]
 
 if sphinx.version_info[:3] > (4, 0, 0):
diff --git a/docs/sphinx/uniquelabel.py b/docs/sphinx/uniquelabel.py
new file mode 100644
index 00000000000..cc4ab7f31c0
--- /dev/null
+++ b/docs/sphinx/uniquelabel.py
@@ -0,0 +1,74 @@
+# coding=utf-8
+#
+# Copyright (c) 2025 Linaro
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Sphinx extension to create a unique label by concatenating
+# the name of the origin document with the label text.
+#
+# Sphinx requires that labels within documents are unique across
+# the whole manual. This is because the "create a hyperlink" directive
+# specifies only the name of the label, not a filename+label.
+# Some Sphinx versions will warn about duplicate labels, but
+# even if there is no warning there is still an ambiguity and no
+# guarantee that the hyperlink will be created to the right target.
+#
+# For QEMU this is awkward, because we have various .rst.inc fragments
+# which we include into multiple .rst files. If you define a label in
+# the .rst.inc file then it will be a duplicate label.
+#
+# The uniquelabel directive is our fix for this: it creates a label
+# whose name includes the name of the top level .rst file. This is then
+# unique even if the .rst.inc file is included in multiple places, and
+# when we create a hyperlink we can explicitly specify which label we
+# are targeting.
+#
+# Concretely, if you have a foo/bar.rst and a foo/baz.rst that
+# both include wat.rst.inc, then in wat.rst.inc you can write
+# .. uniquelabel:: mylabel
+# and it will be as if you had written a reference label:
+# .. _foo/bar-mylabel
+# or
+# .. _foo/baz-mylabel
+# depending on which file included wat.rst.inc, and you can link to
+# whichever one you intend via any of the usual markup, e.g.
+# `documentation of the thing in bar <foo/bar-mylabel>`.
+
+"""uniquelabel is a Sphinx extension that implements the uniquelabel directive"""
+
+from docutils import nodes
+from docutils.statemachine import ViewList
+from docutils.parsers.rst import directives, Directive
+import sphinx
+
+__version__ = '1.0'
+
+class UniqueLabelDocDirective(Directive):
+    """Create a unique label by including the docname"""
+    required_arguments = 1
+    optional_arguments = 0
+    has_content = False
+
+    def run(self):
+        env = self.state.document.settings.env
+        label = self.arguments[0]
+
+        refline = ".. _" + env.docname + "-" + label + ":"
+
+        rstlist = ViewList()
+        rstlist.append(refline, "generated text", 0)
+
+        node = nodes.paragraph()
+        self.state.nested_parse(rstlist, 0, node)
+        return node.children
+
+def setup(app):
+    """ Register uniquelabel directive with Sphinx"""
+    app.add_directive('uniquelabel', UniqueLabelDocDirective)
+
+    return dict(
+        version = __version__,
+        parallel_read_safe = True,
+        parallel_write_safe = True
+    )
-- 
2.43.0


