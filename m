Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBCAC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZomx-0001rt-AA; Thu, 10 Jul 2025 06:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZoma-0001pY-2n
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:45:41 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uZomV-00077P-QI
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:45:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so6012075e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752144333; x=1752749133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sPAaWZS9pbyaeBj3LeenkXr30JcrTD9NQ22BxqPsMYU=;
 b=uNPem30md9MuvYgDlsM40iCXG0H+Q7wxhgV+mnvtDqtl6+A0OGq9P6mMEIRBpM+OZh
 7AlN293rWsuA9ylbx039e56A0fb3y7290iCr9fCCkLLzVzVIcoPsm7OcYln/Dg3q57Y5
 sy5lUQvSepfDJ1GJY1WPYrvWwIqWkFeWa8iO3uvhLxNRKQ7Mwkak74iqbQhwsHQtBz+Y
 /ljz7toMp0TzMYN+ilG4pnN2Dx9ziVjRA9lMIzMKjLu0KLrFacA8heah2nIoc37u6UnM
 fzFt8VyrO6sS9uAa1+LjA9HcG0iWIOqQQ6F5goa1O26Fz99ruE+iOm7QFFLOvnjqV7sj
 7SCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752144333; x=1752749133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sPAaWZS9pbyaeBj3LeenkXr30JcrTD9NQ22BxqPsMYU=;
 b=m+y+7cq1WsPB9q/Fau980IlxL4Sop+O/UqCfK5VRohZgzfFNSldc6uhl3pO9noC0jA
 a9WwkSNrnv9IOUOn+6gVNAmkC8TdEHRTXLed/fNG3OH2SxfBNWVkybhkp9aqcB0rz7V0
 804a0P5aKRW48evGwQmdQP7SyXUWdvRyhnV9KL24R4V5ajpVaJ1I3VE7prtLFxRlHCbP
 UpvFwtAfyLA8rHtCmFsCyq4583Qnn5YO/o86am5TfAHnAHrGfHXJ3ddNxOptLQarUvWi
 AFEMZKEPqZ0ekzxEQ//kZt32b/kCCO4tJyqPeAwBSgKDNa7eiHmqeEt7wA0H/M61V58F
 ldbQ==
X-Gm-Message-State: AOJu0YyG+lzK7VE0KZ64xEqNAIA8He/t83QObhT2g4A42TXjtpaT4CKm
 plDAZt5y+vVPLA1zLMzMmWg5S0A+X1n7TB+7g316YC+c8tyk6C2niSohT7uwrOWgP5E=
X-Gm-Gg: ASbGnctXFISzTMSLlsHR2UpqnPchqISPvKv2EfH7o4JS08hjhzJVWo6kZJzffK4xD+D
 PaarBiB+t/fbuNbmQxYFkWdbEAfd1beuM1jXsHEZUktxuIkSIj/R/59WVXq9aJnXIZuOHAH9/By
 PbnyRz5Ulg4dQPBLq8/Bn2eXJb/HolapriEVlew8SFkhHR0QHASCxfpLlDTYgMSfeW7IG9tyIIM
 sQj33AgFh29RpvevYfjVl1eDTheIoIYt+r+ClRalXpKSYmJEDneTGToUdnWyv18PnTTUAzF4Kaq
 awVGxhqq4/SrwzSl2KoeUYSTEl4lNemeUH0Aow/W6Nlv6PhTjGPytnCC8RNfCsU=
X-Google-Smtp-Source: AGHT+IEcMtc/oDsJJa1KmaF6zHqG68AR4pPzawvBP8mWG8hK/mavUzJNAhurd0r3IQDtq/Z8MshOGQ==
X-Received: by 2002:a05:600c:1385:b0:43d:563:6fef with SMTP id
 5b1f17b1804b1-454dd2e1fd3mr18454345e9.21.1752144332951; 
 Thu, 10 Jul 2025 03:45:32 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5032e17sm60568795e9.5.2025.07.10.03.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 03:45:32 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 521775F813;
 Thu, 10 Jul 2025 11:45:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 1/7] gitlab: use argparse in check-units script
Date: Thu, 10 Jul 2025 11:45:24 +0100
Message-ID: <20250710104531.3099313-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710104531.3099313-1-alex.bennee@linaro.org>
References: <20250710104531.3099313-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Modernise the argument parsing so we can easily add to the script.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/check-units.py | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/.gitlab-ci.d/check-units.py b/.gitlab-ci.d/check-units.py
index 268a4118d5..cdc62ae5ee 100755
--- a/.gitlab-ci.d/check-units.py
+++ b/.gitlab-ci.d/check-units.py
@@ -8,8 +8,10 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from os import access, R_OK, path
-from sys import argv, exit
+from sys import exit
 import json
+import argparse
+from pathlib import Path
 from collections import Counter
 
 
@@ -51,16 +53,17 @@ def analyse_units(build_units):
 
 
 if __name__ == "__main__":
-    if len(argv) != 2:
-        script_name = path.basename(argv[0])
-        print(f"Usage: {script_name} <path_to_compile_commands.json>")
-        exit(1)
+    parser = argparse.ArgumentParser(
+        description="analyse number of build units in compile_commands.json")
+    parser.add_argument("cc_path", type=Path, default=None,
+                        help="Path to compile_commands.json")
+
+    args = parser.parse_args()
 
-    cc_path = argv[1]
-    if path.isfile(cc_path) and access(cc_path, R_OK):
-        units = extract_build_units(cc_path)
+    if path.isfile(args.cc_path) and access(args.cc_path, R_OK):
+        units = extract_build_units(args.cc_path)
         analyse_units(units)
         exit(0)
     else:
-        print(f"{cc_path} doesn't exist or isn't readable")
+        print(f"{args.cc_path} doesn't exist or isn't readable")
         exit(1)
-- 
2.47.2


