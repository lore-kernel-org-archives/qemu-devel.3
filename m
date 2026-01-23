Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDBCD74EDB
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIc0-0004I1-8Q; Fri, 23 Jan 2026 09:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbv-0004FT-EV
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:07 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbs-0007mm-Ir
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:06 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42fbc544b09so1781152f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 06:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180283; x=1769785083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YOI5elt6Aar3cBSUkuqN78QLlyhofCVDFs+1c8kJcJA=;
 b=LtPbl06RpP/qrRzduZdMZuiKiMPtaMUZEm9NkoQuxAMo5ViuQOJOfl9OsgFlkCt+If
 8VVVHTjjcwY8dltk10rUCBu+W1qmPmffT4dJwk6GxjR3XkLe2erLfwzp56wKqhGlj6nZ
 aHSCg3+L96aYPB2E7s9uIuc2krsW9km0O+4tVEHhi3oDJ1NDeZF8yG4K+FpuC8K4b+gn
 1b0DvbJ1tLcaD19j4O4zNadD6KzzDQgTX9pm9HdoL9OA00oSc1Km45JuBS7x3kf5/FNX
 jlZkO3qwimPRBLlKmfuDBLugftLC+0TiGRT7Kk68Wqg0TncjTCOi9/RUh3wpOLzDOyYd
 VmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180283; x=1769785083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YOI5elt6Aar3cBSUkuqN78QLlyhofCVDFs+1c8kJcJA=;
 b=M9BxMkLVxWyiajyXO/x6EZJOyFbOs4jurpBOCXk6zNfzT2JehwySsFf7iMQsK7AVhP
 bxUKFWdGB/pKRALgb6Q+cLd/mA8KS5b090qkn4+5bKCGQPVp2A/4INxBX77u85Aro8Dx
 IOTPXE/cWNgVKI8fe2tQCRFqGrvk3Vy+SQSdc873Dq5NVCShInxQYZcQgTjgn3OSvxnu
 SrBqaQL0VNyy6hiouZsNtA+g4VXLvgB79lU09NZhi9h2fS4DjyrU5bolAWZCIoPLXnlu
 7dqbdHjRZrQ6piocqbHxvQAaepKmtITFY8bMXEWLWMgnVMQ1i6OWVCi8qYvxDP0q1Fau
 SnnQ==
X-Gm-Message-State: AOJu0YwLiKD934K1cFJ95peG/F7d7JanBYT+/u/83MG/u/o42LCw1Mvc
 sYmh+rz+gQ1RASWZgCH/OS8fx0g3NXF8m0QEN+F5GP9kmqFQdYjM1OjiEJxS1GRUIsg=
X-Gm-Gg: AZuq6aJLN689kKt0AVbvo7d0b5UGvzLZkimVz6GZbw7Qe75luAq5bmn9NgOY0II4OJg
 lWHd6PME1Sp4W4hRysogJcwnKJf9yA2wkowwDyCTDUbENFinCYrCD/4X3EiYnDcmXZQ026eQpmK
 Uwn4P9bdTl6hkQtaXOxDI2b2eFiURwuz6NCV38Bo1WlfCQto6dZCNqBGymEMktPyFzR1CqBoKFo
 p1aJGj5iEHDiHM84h7vf5dyjE2UKJxoHJgH2/8J1fMomoEuXFQNN0GtPtZADomeiIjp22Hk04M+
 HafU9Iy+1/InR5N5JAlI8XW5+4qsC0DtIpJ28yFkgeFZptNcA/+FiQdCtUpQaJfHjfoCYOuaGLN
 5cmnCtHK96FMLGt0cRMP2pN5jIGA4gkvtilemqxFiYGSfcWOSgNV4Jlvcrj26MKOr4wYPbKSSlC
 JNZP2aIYkso1j/
X-Received: by 2002:a05:6000:26ce:b0:42f:ba58:6599 with SMTP id
 ffacd0b85a97d-435b15f7ef8mr5277780f8f.35.1769180283065; 
 Fri, 23 Jan 2026 06:58:03 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02f71sm7717001f8f.6.2026.01.23.06.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:57:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8006E5F9F4;
 Fri, 23 Jan 2026 14:57:51 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 12/16] scripts/get_maintainer.py: add support for -f
Date: Fri, 23 Jan 2026 14:57:45 +0000
Message-ID: <20260123145750.1200879-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123145750.1200879-1-alex.bennee@linaro.org>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

Now we have our sections we can add support for checking each file
against the maintainer list and gathering the ones we want. Finally we
can print the list out.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/get_maintainer.py | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index 696a5b55d8d..96875255b11 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -132,6 +132,32 @@ def __init__(self, section, entries):
             else:
                 raise UnhandledTag(f"'{tag}' is not understood.")
 
+    def __str__(self) -> str:
+        entries = []
+
+        for m in self.maintainers:
+            entries.append(f"{m.name} <{m.email}> (maintainer: {self.section})")
+
+        for r in self.reviewers:
+            entries.append(f"{r.name} <{r.email}> (reviewer: {self.section})")
+
+        for l in self.lists:
+            entries.append(f"{l} (open list: {self.section})")
+
+        return "\n".join(entries)
+
+    def is_file_covered(self, filename):
+        "Is filename covered by this maintainer section"
+
+        for fx in self.files_exclude:
+            if filename.match(fx):
+                return False
+
+        for f in self.files:
+            if filename.match(f):
+                return True
+
+        return False
 
 
 def read_maintainers(src):
@@ -279,6 +305,15 @@ def main():
         print(f"loaded {len(maint_sections)} from MAINTAINERS")
         exit(0)
 
+    relevent_maintainers = None
+
+    if args.file:
+        relevent_maintainers = [ms for ms in maint_sections if
+                                ms.is_file_covered(args.file)]
+
+    for rm in relevent_maintainers:
+        print(rm)
+
 
 if __name__ == '__main__':
     main()
-- 
2.47.3


