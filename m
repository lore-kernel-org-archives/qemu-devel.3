Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C79FC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCHru-0004DT-JT; Tue, 06 May 2025 08:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrY-0003XP-QP
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:34 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrS-0003sX-8C
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:31 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-acb2faa9f55so746822266b.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 05:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746536244; x=1747141044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uuMngEWgGAO0nBl3buL5NTmX355UjBOo6woNVhHbqxY=;
 b=opVi1yZQLAMAQoHaOtTH3WSahSVMQaH6z0upy+2mjcMSwAoVmds9CfMm3Mc1+oMu/t
 E61dAdY88SaCX9JVIOptzVDH5u0GlZ1KZ/wixAJb5KTkbVpvTc1l0puYCrWx49+sGBxv
 7gTw/p9TsBL4//D+Vhy3pMqmYd+XPqYBa+nMjEZC/2N0L4lSqMkzAB28yBhhvNLd0tVV
 mb2vhJDHVgB0s3sCTEwy6dsdENv/XrUloMqjWsqbQgrlzTD2cSiueQy/J1QmistLuNHq
 Om2b1J4iI8dsB5x0WqQlbH1XO63TAH+oIO9o6j1fLoyk7pmQfzuYmJdAuzKwV+rak9Zj
 pOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746536244; x=1747141044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uuMngEWgGAO0nBl3buL5NTmX355UjBOo6woNVhHbqxY=;
 b=bfjElUQHtcYDdx47+9LWlKRMSqJ6pQschShKKVOlXHjlENrMSBYPYptNA6P6daQiKI
 oPT+rNtxmklBZ8ZJwW74h2/+uLASEXFeGpPSGeFkmkz7l18iYeK/hHmw3NK7n7DXHBM2
 XaJ1ByD/NAQ0Ig5iEdV4BpwJaPeh3qxv5dVXqa0h78LUL/cML7zQ/TzJxFihpptt/ITz
 LPYzrXRJieLE02b59MxRaCFZvP5c5Xwbu6HrVoE5RoQ+q3+XCf43eefA6lEab0hCoRfv
 +6f5ebLGth8nwIoYJKWFZkYg/ihu6y+w5xQpgPCf6nCWD3a8kA3JbP4Jk14WqTbYvowk
 rELA==
X-Gm-Message-State: AOJu0Ywo9znt44aYOyCJWIoX8AOX4ZGuLuySpAYdmwQPitKqPTXUisFr
 lg0aM07ECuRvWQT4f/ghQFDrGgxaoRcsFW5iaKl8mXoeK0vOL83sKnHNFDvQcKM=
X-Gm-Gg: ASbGncs4jtTnfz5ZFHadax5xBz+3ucT+0mhrzVcycFqCGlkcey1jLhKwkGrdm4yrT8P
 UJRhh9hqvbB/XcVUhBlXKHtW6BRR6f2+5Idyiu5N37DHDjp3fJWP5A9Z0p/1dUba4VuhXZ1XWGJ
 2aa5imba2gIpZ7eAeUvnx9YjKJEjmFolOp9bugMeMXxPou0/qlhjjzpajX3cGHv6shl4tg3xUv1
 BdxxhFGxKT89sTJA/tChUB3mrDCZVdp2xcR1DZ5BiDosApmC85zPoHHTXm1Y0htnnENENDT2rj3
 TJiS3oKTNZWxSePayzCYBVZZlbnYKRSUEezCIom5T1g=
X-Google-Smtp-Source: AGHT+IEHCiRBKeONHiNPNedSY86780JBTXkQftBLfDPEU662kAdIv4j+4JTNhXimcdKd73gl/0mzLA==
X-Received: by 2002:a17:907:a2c8:b0:ac1:e6bd:a568 with SMTP id
 a640c23a62f3a-ad1d355c7fcmr285773166b.37.1746536244393; 
 Tue, 06 May 2025 05:57:24 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1895095d7sm697433266b.151.2025.05.06.05.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 05:57:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 598C25FADE;
 Tue,  6 May 2025 13:57:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 13/14] docs: Create a uniquelabel Sphinx extension
Date: Tue,  6 May 2025 13:57:14 +0100
Message-Id: <20250506125715.232872-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506125715.232872-1-alex.bennee@linaro.org>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Message-Id: <20250429163212.618953-2-peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/conf.py               |  1 +
 docs/sphinx/uniquelabel.py | 74 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 docs/sphinx/uniquelabel.py

diff --git a/docs/conf.py b/docs/conf.py
index 7b5712e122..562db95bbf 100644
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
index 0000000000..cc4ab7f31c
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
2.39.5


