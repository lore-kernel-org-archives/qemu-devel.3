Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66465C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TtL-0005Xc-8v; Fri, 04 Sep 2026 09:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TtG-0005UY-NB
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:34 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TtE-0008Ih-PJ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:34 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49cf4f81d86so7341795e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788528211; x=1789133011; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pWuQIDb9zjoi4BRXnc4bBwnvB0LsX54W6ljnxf6XcRI=;
 b=Y35N1tSUQnWj40xRNmppHNt8HNJgJoc7017nWGiZc/kFKElSXjvguZItIgBkO3h51U
 gr/PIBntiCZYWFFK5U2xBBJonACTShLuosG9asIcQG33qqpCmd8VP/vkiAlvJDF2IMor
 yaZiHvOC300yQVczsCWpwD4MUQYmAhCYwherxCD3XvynOxkdwireZuouRDvmt3i2ZRbz
 7mWxm+anRV+6flhApD04e+/8BMiSlTRHQHnbP5oU/GSaUUaJcmiN7cgd5KCyErIepjOf
 fqHjf8ABQ7LdNomI1Wje0Vrf/yc2jxuIKp8ltYgIZG2zKFNt4k+o3/aDsR1vbGPolDrX
 B+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788528211; x=1789133011;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pWuQIDb9zjoi4BRXnc4bBwnvB0LsX54W6ljnxf6XcRI=;
 b=KOWDw7Duxy7gg5xPHb/RRszplGZswNIanooKzblwH+Or4RLaExXsm2fqEUa5n3G6hC
 sB3VWl4L5xXQI6NS5xhw2QFfpo7QcG/k5ZxKI7ogEWwwa+/qa/mQ3XViDBNiVQ12htEx
 y2TEUUUaHkZQ5CtMVFqNMpMor+yVhNrXgNRSX5a5ed495hZqA1Ei7fEYlNO4/aXXpPj4
 eCEbGE1UjLFidZA0/IWHO5QwGkZhEyE4pzsK58gQ/CmuRMRi5wfusNR4CZkWh/6H3f0k
 d8M97jKck+ys4u6CDxo99dEPnYGkuEwO4olCoyQGWVMeOWkGLudea2t1jE7YpIQsNFU1
 IN6g==
X-Gm-Message-State: AFuF++k9/7d4BMYL44yxPpJbR6Rowf1Qc2pWnYWC9virc5Hivj6C/Nhi
 ilbLOBc4jq5EhLRNpH8L056ZRn/6VYFUfRNyE46wRmzMiy9dQvYHkJKbz6V1kIYH7Y8=
X-Gm-Gg: AYBFou3Q/VryByWoO0elwC9nOfedEoej6jjN/pNLP1G1mG9yBxz/AF68LvuyN6POq8M
 KtNRu3qrd8tfywLAfpFh5q7VMxQtR8bBh9PMp9v+2p2or9DU7IzA2jHtzp6RK4K0PIjTYNxi0jJ
 lBWu1L/hNNI+qmpKVkqxFiOLJI89ejT5ROfWNpz9M9w6XN83me6GPPOWuvotygYEgB7VpAszvSq
 erv/qYYVnvROL3y4CIoI+xiOcsz5ytsMVN6h+FAKnT2bKZun6Eo1QCXL8qG2Lt5lX2Tvg3la2Dh
 xCU4ChpH9UbL1DPQkM7hRFg8Bmk1X18w+LVAdcSYHpFNHQ1L/xhX3zPFOlTNMYZz6T281X04G8i
 p/hbuvgj0h22UXzA4soSt4L5zifT/KnHSCpWdJrD+LUO0/f4Kq1p0oV4IXQUdkQolbqaiTKMVIR
 ZmNN+91z4vGCcXSAYBo4ny0oSo6Onr9J7NE4RrgIvFiaL26mDmW6crKxXRXKv0
X-Received: by 2002:a05:600c:3e0c:b0:49c:fc6c:be0e with SMTP id
 5b1f17b1804b1-49cfc6cbfbemr30323545e9.20.1788528211024; 
 Fri, 04 Sep 2026 06:23:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee7fec25sm170698335e9.13.2026.09.04.06.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:23:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A05FB61839;
 Fri, 04 Sep 2026 13:46:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 034/105] tests/tcg/multiarch/gdbstub/prot-none.py: deactivate
 on gitlab CI
Date: Fri,  4 Sep 2026 13:44:48 +0100
Message-ID: <20260904124604.2207440-35-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

This test was disabled on Gitlab CI.
Tracked in https://gitlab.com/qemu-project/qemu/-/issues/3329.

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-35-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py b/tests/tcg/multiarch/gdbstub/prot-none.py
index 51082a30e40..e653bc697f6 100644
--- a/tests/tcg/multiarch/gdbstub/prot-none.py
+++ b/tests/tcg/multiarch/gdbstub/prot-none.py
@@ -5,6 +5,7 @@
 SPDX-License-Identifier: GPL-2.0-or-later
 """
 import ctypes
+import os
 from test_gdbstub import gdb_exit, main, report
 
 
@@ -21,8 +22,16 @@ def probe_proc_self_mem():
 def run_test():
     """Run through the tests one by one"""
     if not probe_proc_self_mem():
+        print("----------------------------------")
         print("SKIP: /proc/self/mem is not usable")
-        gdb_exit(0)
+        print("----------------------------------")
+        gdb_exit(77)
+    if "GITLAB_CI" in os.environ:
+        print("----------------------------------")
+        print("SKIP: fail on gitlab - " +
+              "https://gitlab.com/qemu-project/qemu/-/issues/3329")
+        print("----------------------------------")
+        gdb_exit(77)
     gdb.Breakpoint("break_here")
     gdb.execute("continue")
     val = gdb.parse_and_eval("*(char[2] *)q").string()
-- 
2.47.3


