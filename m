Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC21FEFB55
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 13:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvyLu-0006Dd-5l; Fri, 27 Feb 2026 08:57:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvyLi-0006A3-CA
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:57:47 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvyLd-0007Ug-SL
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:57:45 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4398dd671daso2277028f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 05:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772200660; x=1772805460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0r5tVTwr3FwSzfLr0irG0lziyL9H4aagQEDitRzfyJI=;
 b=ppBmVzzM6ln8tfKsIK5LisTWB9dvW82wEIBhMaZnPP6W+9ysDRIhYuyOBJDdeL1DTY
 JM9f/c/OwE8h7B2AaqzolR1KbdppGz5CTiDDaOJxwXhGzE6W7NvGqNBoDo4bWLriFLGD
 8v1MF+9I5x00lzPIbwFl4wbz6+2h3TM6q10Z4dksOVbkNvc+hffbwgUBEclwaYDDH1ih
 xAvPolO6GYMTK2Sb2FaTqQO8sTKG3u8AY/UajMVQfDRBc/Y5NcCxaHLgjbTFOzBcH7cC
 3npWjioGPzjYYJ4V2p2gRJR/GUg559wbVK4/GaeDYcGNVfnbPdz3MBjvq+hJGnMNepar
 W8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772200660; x=1772805460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0r5tVTwr3FwSzfLr0irG0lziyL9H4aagQEDitRzfyJI=;
 b=pEJ7EAwcjuE5iU3sMfFOSXZ69jYaIrGe50PpJlhXnX2DNWMBtxDr2UrkOpeGQ68lXp
 Bo/nNsQKzzJY6Erqc6vNGBr6IK6IHlcXZYc9FQWU2Cse0ZdFN+TXLtOtVlmWL3UnifOb
 SxxjVVavGFo1UWGiRYolRTan0tFWKKPNB5QZayn9ZC4BG6Iz66tZfvSYa36Dnp0RQKHL
 aIn4yWeZBDJXl3y9cAdetu96Oym9keLTklF3mljyjAhcaH/tx9tFp+rFtRFI6WbMLbt9
 XwdXtY8Rn8riqE2xPXa80FPpQiuTIP9LVRiHF6YN63mG9GKs5nJqbdFUuMRCy/8xdnjg
 5oxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJNXJLs2uv4m1S54cU6ghbYhYF9V9nNqx7D1ZQ+h80O1NngaPHOX6nv2WBRbAqkI5khj7Mt4ZSLD5h@nongnu.org
X-Gm-Message-State: AOJu0YwoJG2Ke/NOeXu1Ngj7aOE39/fGNg8l3dzO/54ckFuhz1kJi9dt
 e3YVhFxtngNaCaMscNu3pJn/wgi3kVzPgkMCjb24jxZatLA7eWCh156gQHylc/OmOLs=
X-Gm-Gg: ATEYQzxB1H7hSv5W9sHj6o3cNYzO9h+iB/EPw8jg/Fj4ln44BqkXzfSMp7V2sIze6Dv
 U5n57ldeHZ4JNyHtdxfUSsOWzF0vyXg2M5OOoFJl6EfmddAmGkKS/i/A6vV3ghCjDao2qbxFLvQ
 L+mfHgyPFoyd5qKUlD7mZDKTZyIQvwqi5irlcv1BvK7S8Fs387FqYXGff0l8q8Txhk32zKuTK4+
 4SPsq48Y1R262QWkIK3uCFUSDast0L0RDOev0ue3N0wa0nBFaZNDfGqdluqAMvO9yWuP68yVlIf
 3mI7eOBEPMbwdZhk/gwsRGwAUkPyy2GhRrZ6nE3EeBkFGFduZmrYtFLaqITKFv2HS5FST1ADafM
 068XhIBdY8oASUoh+X47HHya8ps4AwePsUyGv1RRm+gjtaVqebWhGBMI78v+QGUocKTJAaz3X/q
 cXFZolkH+VUD62uMFvDht0Jt9A/Yn0d63k98e+fC/c9bsgQf9SEfcArz9OsGgwuvko2+6eXKlmF
 GJbe0sEeowVxw1E9Ez7Xt+WqO88FFc=
X-Received: by 2002:a05:6000:24c3:b0:439:8ddd:90be with SMTP id
 ffacd0b85a97d-4399de14ff7mr4836650f8f.24.1772200660100; 
 Fri, 27 Feb 2026 05:57:40 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b327sm7655163f8f.20.2026.02.27.05.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 05:57:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 2/4] scripts/lsan_suppressions.txt: Add more leaks
Date: Fri, 27 Feb 2026 13:57:34 +0000
Message-ID: <20260227135736.2280161-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227135736.2280161-1-peter.maydell@linaro.org>
References: <20260227135736.2280161-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Running "make check" with the clang leak sanitizer reveals some
leak reports which are either not our problem or else not
a leak which is worth our time to fix. Add some suppressions
for these.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/lsan_suppressions.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/scripts/lsan_suppressions.txt b/scripts/lsan_suppressions.txt
index ffade3ba5a..bd6ef07079 100644
--- a/scripts/lsan_suppressions.txt
+++ b/scripts/lsan_suppressions.txt
@@ -9,3 +9,23 @@ leak:/lib64/libtcmalloc_minimal.so.4
 
 # libxkbcommon also leaks in qemu-keymap
 leak:/lib64/libxkbcommon.so.0
+
+# g_set_user_dirs() deliberately leaks the previous cached g_get_user_*
+# values. This is documented in upstream glib's valgrind-format
+# suppression file:
+# https://github.com/GNOME/glib/blob/main/tools/glib.supp
+# This avoids false positive leak reports for the qga-ssh-test.
+leak:g_set_user_dirs
+
+# The walk_path() function in qos-test does free its memory,
+# but something about the setup with tests run in a subprocess
+# seems to confuse the sanitizer. Suppress the errors.
+leak:walk_path
+
+# qemu_irq_intercept_in is only used by the qtest harness, and
+# its API inherently involves a leak.
+# While we could keep track of the old IRQ data structure
+# in order to free it, it doesn't seem very important to fix
+# since it is only used by the qtest test harness.
+# Just ignore the leak, at least for the moment.
+leak:qemu_irq_intercept_in
-- 
2.43.0


