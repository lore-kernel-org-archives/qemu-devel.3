Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0973BC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQK-0001gL-4f; Fri, 04 Sep 2026 08:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQI-0001fV-MY
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:38 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQE-0000hL-TL
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:38 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-482f2ee53e7so609699f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526413; x=1789131213; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C0tPrXZuMf2C7gQPLjpGhrFHCwZjtghhiSmlOj5fpFY=;
 b=X/7HNqWI0on1p9c0jOo6ZqKqqwA9GSUWL/tTgA2RGtPvP89zywh8oI6V8aYwhjTkiR
 MkPklK1W8g3jePJBvDuX2gPJPfzjeypsQYUhRfg+MKniYOFal/tfSCHbcfFyH2kZV8pk
 vPns0fRkpYx7vIf/tCP79avAM1o4XzMGSC542QmV7srlYFbwwqAOov9TxRO+PbZGZeEX
 rkJ+d5KkEG34LZ7Cffje0vXGTrywyFawn7fSW2HRILYAh4syAsMXVm+lLTCWrpZT92K1
 jsXrxXmXcLQx6jft0/F+LEQcsxVygyaCZGOwdJ6aVCRVX2wk95cbeMdzNReXot2BTZhA
 i/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526413; x=1789131213;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C0tPrXZuMf2C7gQPLjpGhrFHCwZjtghhiSmlOj5fpFY=;
 b=VVLWRkEclBVZfNS6yvi6vK+v6bSxk4/sjrbVhluD4sB6O4O48HK+StGXCJVZ2VR+zf
 vVKjcToUPXXEIjlQ1IPOzyYfCFOVo6aRCUtinmuUppD+FPIrwrh60Co9lD6w+rIc0/BI
 sZET8YOvSCWm15vbQjHzjqMm13Qw0hCDgl2XQ3uLZ/ckZ0/47zh7qFaaxdwZBkzhMUA5
 kS0DVaim3QLvC/IqnHB067VTBtI3nksPryT6cfIjLCP+wzmJpTL8OSfBDcA2vJJPQwpo
 fyVd4+QVcYiOJAH2rvPr/zr/FIaS/HRctd5p0PUXiKV88VrjV73aLOy0xbDgFrRn25rF
 lxRA==
X-Gm-Message-State: AFuF++mxe7olmHKpJtHrqQtH7LaDN62lF6Bvi8PHqLnG//GNO5DQB3YN
 K6DtzPgdlTfgfu0/Nt304XwqUSmYH5QyupiBcyFroS3ollHFURuFS9cT1GWE5I6ihoE=
X-Gm-Gg: AYBFou3MptUXlKFlcXNwAckUjgvTiJT4nKFx4YUrQ1jEIdCW1f3/avnktQyTH6it51g
 gYdqCXIQM3a9olHtkfocDtWMxfTKf7Vy2sQVzAhvlAcLkxgqBB0faP+uW4MuHLSDcDlZ0X2ffyz
 V0na821HtPqTCQnNiaYJUaiVZujxRCe1/iJ0ncXtXgbc8RHwBESEC81nOnqGT0qTXfo5lymn3Qm
 3cBYPHgR4nOdARPE0x5RjiIJxFbHRzXLLJI5SEOPXVAGazX9ppAn9aYLfBwS7BUWuZt7liruLGe
 4MQ9CvswSBl/n4fKg2A6kRS6wRJD1HlNsQ/A7sYby7kKJOMXjIPC+uPLPBNIKDeJD8aEPIYYUvJ
 3vrhT5visc1Rof7gJKRWKyPzxsBGFNTq5zZuFOTWa02FB59KrHbwesUu0P54uItf8PKnKmrMhIB
 54bGmSICOXrh7a5LhF/aY7T8XJPzxGyK6IjYLKpc6k/qgKLL5/q2RMG5Jck/mQ
X-Received: by 2002:a05:600c:6098:b0:49c:fc6c:be05 with SMTP id
 5b1f17b1804b1-49cfc6cbfdbmr33702785e9.28.1788526413363; 
 Fri, 04 Sep 2026 05:53:33 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf770fcf5sm66392155e9.6.2026.09.04.05.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0901061579;
 Fri, 04 Sep 2026 13:46:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 017/105] tests/tcg/meson.build: add wrapper
 run_and_check_forbidden_output
Date: Fri,  4 Sep 2026 13:44:31 +0100
Message-ID: <20260904124604.2207440-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

One of our test requires to make sure output does not contain a specific
string. An example is system multiarch test run-gdbstub-untimely-packet.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-18-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index f5fd9bee7bc..c718555d257 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -7,6 +7,9 @@ endif
 gdb = find_program(gdb_progs, required: false)
 prog_gdb_test = find_program('../guest-debug/run-test.py')
 prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
+prog_run_and_check_forbidden_output = find_program(
+  './scripts/run_and_check_forbidden_output.sh'
+)
 
 tcg_tests = {}
 # tcg_tests is a dictionary with following structure:
diff --git a/tests/tcg/scripts/run_and_check_forbidden_output.sh b/tests/tcg/scripts/run_and_check_forbidden_output.sh
new file mode 100755
index 00000000000..4486ca8ef83
--- /dev/null
+++ b/tests/tcg/scripts/run_and_check_forbidden_output.sh
@@ -0,0 +1,19 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 2 ]; then
+    echo "run_and_check_forbidden_output: 'forbidden string' cmd [args]..." 1>&2
+    exit 1
+fi
+forbidden="$1";shift
+output=$("$@" 2>&1)
+set -x
+if ! echo "$output" | grep -Fi "$forbidden"
+then
+    echo "output does not contain forbidden string: $forbidden"
+    exit 0
+fi
+echo "found forbidden string: $forbidden" 1>&2
+exit 1
-- 
2.47.3


