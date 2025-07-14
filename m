Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A6BC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 12:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubIgK-0000rO-A5; Mon, 14 Jul 2025 08:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubHtP-000772-QU
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:02:48 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubHtL-0003rf-Hw
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:02:47 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ae0dd7ac1f5so877734966b.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 05:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752494558; x=1753099358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8sj9iVmDpEf+chfg1RrFtaVPsqCvpCBDEdTqoin79mM=;
 b=xDp2P9MpUe6bevc0CQqbAs9mFOQFHNZxkmsiIfzN9PaWqRma7Qx0YPIR7TEqIV9VAS
 YrwZyM/EEfb/OxXkqRhWZ7dPkghieuBB532Q7sDBRYcJBLKuqOJrtqRoz+oQfBx71Upr
 v1dqACQtzsrolyHADkQOvsiOaJUJSXI5yfLr38X82/D4fnrrratU62NQAIZEIsx+7T6+
 Z3tDxkvaaZAUbZjJkwptcm/z4tYR6G5PF09fXD/e6PPT9mCyT1WDjwa7BvRlYf0tgav2
 7BIeHFtdWMC9ja/0Urn9AGCyxV6ABqfW07yU1KESZ0w2lW6OV2M5pGcut9WNdMU42wui
 4vCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752494558; x=1753099358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8sj9iVmDpEf+chfg1RrFtaVPsqCvpCBDEdTqoin79mM=;
 b=PaY2MNtVX7tTZGMQseCFED9HtP3mqRX9UnHYHvHiK2H2SsT89I/1Y0sXjHN7nZMTNQ
 +L3iUoz20+3an/XRypA6K1oLYxaJR7T3cSiMhLIBY3Z7NwyBItrsuaOJiYpSv8hCYfZQ
 JgUJcXH8vW+SgAZDsYkGfZJl0LTzVjHP42dQMsuz/AWohTM0tQJzqZr1r9qwDakkqd+N
 0HGJtoBI3Q5AW8rGJ23nM4tAqqsmMOWpPbbal+gZngZr+3N7nM/qkBrhdRFpOvoNhfPs
 SOlygpkz9YoYrduetl0mLuzu4Vf2ij/WQFeguQE1Xhdt2JJnxo0iVzsHGt+lpiQQNs3x
 MlCA==
X-Gm-Message-State: AOJu0YzNP7kKDiETFa0HLvA2z52veSZsOc0oLb81ZWkUkBmx5OCAHOs+
 hp6B47CaV5isTI7SmxcbtjJZfcsg8JDPbS47o4vD+w+FfcsaHItRxdZ+fKphjFiDoi0=
X-Gm-Gg: ASbGnctl7V6l3GtIpYlCbWXMFdiJdWeyWOTmt1KmuaW9TdNjQ9g5CWlyL2BxH+46l0v
 cxvcP5naMwj/dB+Q/INxSYDQYEXPSVkBzGMHQL7yMea6E2MFEI93DtJVvrVP4F+4ZpS9F+1KHua
 IcmNWk68GrfUWaehsqHRFZIHY9DUdvfPMa2Qjo9nZ7tr+vCeEYyYnr+7AOwff7cQduuAtvTrHXq
 zptFe4q5I1rGXvc+UwgE+4C45OVRdkLMeYtwLAnaiSr+bFqVMw5KVX2rdFcJfd+h/MG9uIWI73I
 Ky6NfT2n5CBjLVEDiUxELEdlVI7pWGutOAapk7dlOX4gI/uZh+wjo3HQymTjkXe/BYuFemtc1qA
 vAFlkNQ4LEaLU9n6GpQ7hqR0=
X-Google-Smtp-Source: AGHT+IEVaGKdoJJic6qKtm9BhXBkLMSjcg4IVYuFlNOwRIJn+wLGGuc8I9PxmKQa1fJFCuwBau26WA==
X-Received: by 2002:a17:907:bd94:b0:ae3:b2b7:7f2f with SMTP id
 a640c23a62f3a-ae6fc0f31demr1421381466b.40.1752494558362; 
 Mon, 14 Jul 2025 05:02:38 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e829629dsm815882266b.138.2025.07.14.05.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 05:02:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C97CA5F89A;
 Mon, 14 Jul 2025 13:02:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 1/8] gitlab: use argparse in check-units script
Date: Mon, 14 Jul 2025 13:02:27 +0100
Message-ID: <20250714120234.1524401-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250714120234.1524401-1-alex.bennee@linaro.org>
References: <20250714120234.1524401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250710104531.3099313-2-alex.bennee@linaro.org>

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


