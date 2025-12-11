Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9B0D41D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 18:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTkz9-0000h2-4R; Thu, 11 Dec 2025 13:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTkz4-0000fd-Nj
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:01:46 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTkz0-00060k-Pi
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:01:45 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42e2e628f8aso220271f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 10:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765476100; x=1766080900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TWn+H+QO/mlabJco1FHXHcY3lt3eGKIBuWinFFufa28=;
 b=RsG1NdScn6G36yJZhVGk22fBQF12VD6au1hvaEIB8JpDeenrPNaRPdpj8PSQTh5kPm
 U6qcBnK3Ma4CSD3Q1JcqvQwKePm+FxN3gtnkeRqB5Gj3bHHTFh8SqHVhEhqTxecTi9+S
 vb6tcBdC799WattNTb2eQOGzXwi/+bvRjOf2FT4xbePnRIHrV//ll4/jSaV6h5Fb1ws/
 Yq87uILdLQpiRudpYrHT+ENkjYBZ1G1uNfzzl+yO1Mmbn0WZ+eA3rXgIvRIXHzfJSOQw
 dZf7WfpcWHWHzzob0Lvez8BtH1yncB4OLjFiP01gnY5EErrE85/jNE9grWN8HYKR3WWd
 dtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765476100; x=1766080900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TWn+H+QO/mlabJco1FHXHcY3lt3eGKIBuWinFFufa28=;
 b=ev0A7ZU5iasRVDlaFltVah4O5RcOwz/MaVd2/HQFXov62H3bUhNy+M4ztHtvk15Xe/
 8/VboeglLr+f00WFBwTTZkhtrTWzuyc3lJ0JO/7zi46EnBXV69+0KvmTE62biiw0+BFj
 Day0QhAKuNgnpTJS+HTWeWClLc6pj/Nk/DuhemvVNj5xE1UCNB+bopLar8+/zLhELcO5
 vAoBeY6Np3zih3M7LOBCrQG+fnA/+i7nLDs3tDeXkbNhsVey93HCrFau6lzZR3gvCEjG
 Y8ccfSDy//m3Ol56YK+gT7BIhS1ggfZaDNRqPcrFmHYkSFmOoY2rcyZBL4HX8tCyl5Xl
 xQHQ==
X-Gm-Message-State: AOJu0Yws0rgvmp91YMr/E8mUyTyM5xP3ygSa4Fa5x8ULWl6A+L6v0MMy
 nLjxekQDRkcUgygMnsUZFy1lmlaMriyrCjq39Pm4y7Wks4hTWwjr31TticYMluByt1U=
X-Gm-Gg: AY/fxX72N7oZ3SflmcJkpHJ4gcGDn7+xxtSL+1mNLK+L6A9cmJ74PHNgrwkI/o8Pmkh
 kDqi0qApWM5PbSyrfGXu8cxn2d5pzVMAaGIOgpu0NmZelzmdgQr1xRMK4IfsqQLIhZQJJQRnCzB
 k9XJ+v8rS6iKb+QF3PhIBAQS9aQ/drQwCxgBDwXVjC4q/1r9e50u/gxVbTiRcsX9SI9YXWQPsl+
 I8IHjZvjr7cMrORWONb5Fi3t+Gr71ENpgPgvsFMe+mpHtE+nAvCiNEL/sOmUwkOguKoYM50ii8y
 SJhTVA3TjJDZseMxd8E9p5EkFodqFLpEH8Crb70czidPaLn5iMo24wb+SpQKxBY9OWlwEoPf8aK
 Jk+pjmc7rtiC2LRkxLpXjwtHdJAsHaLTLreajNtZyi69fQ3iwm/7nbQcG6772c9Rl9BdBYBVRaI
 Lq5ub0TTkbRK4=
X-Google-Smtp-Source: AGHT+IG88qxFtc0LAd4yOiJaf9kfmgdh425dEW9N4UUGp4/HYnFgVEEgCiqwba1zGUXnqunQh/c7vA==
X-Received: by 2002:a05:6000:290f:b0:401:5ad1:682 with SMTP id
 ffacd0b85a97d-42fa39d1f95mr7070827f8f.14.1765476099421; 
 Thu, 11 Dec 2025 10:01:39 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a702a1sm7819381f8f.13.2025.12.11.10.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 10:01:36 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3DDDC5F8ED;
 Thu, 11 Dec 2025 18:01:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [RFC PATCH 7/9] scripts/get_maintainer.py: add support for -f
Date: Thu, 11 Dec 2025 18:01:30 +0000
Message-ID: <20251211180132.3186564-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211180132.3186564-1-alex.bennee@linaro.org>
References: <20251211180132.3186564-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Now we have our sections we can add support for checking each file
against the maintainer list and gathering the ones we want. Finally we
can print the list out.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/get_maintainer.py | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/scripts/get_maintainer.py b/scripts/get_maintainer.py
index 7b8ce2b65e3..bf45865438e 100755
--- a/scripts/get_maintainer.py
+++ b/scripts/get_maintainer.py
@@ -129,6 +129,32 @@ def __init__(self, section, entries):
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


