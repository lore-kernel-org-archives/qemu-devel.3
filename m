Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1012C79F87
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQO-0001j6-04; Fri, 04 Sep 2026 08:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQM-0001iM-Qz
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:42 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQK-0000jL-4B
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:42 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48586861639so678901f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526419; x=1789131219; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Enfk34+BKXGXOBtsT5q8qTvUMCUcJJpAI3wkn48gKjY=;
 b=HN4GOlTzlCnTwjoSqpi/UbcXmu6uPCkEr2mG9Gq+C5gQfqUywOirmd0iA2V5rBTZ2i
 KYHzKNKIgfc12DwYRTd8mwvR/DVAw3+rnaeF6f42Usm0BNeRnJJ05IYxromvke4ieGP+
 nw+M859pBgf8H8bXDouuh9Dc2V/kz+G3DQmUjWw8LJLkED+fD20pQSsocrt1JCWvYu0q
 I8U+NcNEXfJrUlNNHMv0o+0d1ScK+l/bwFohbrAd4X26QdnvMnjkI89E9oB/FojsQHrm
 3IXW5KCrIXOvThARQYXvp2+b5D+9/Lp5FU/UtjRnXHsv3ksu7E7l9gOl2SJGCOUxnAFS
 mb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526419; x=1789131219;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Enfk34+BKXGXOBtsT5q8qTvUMCUcJJpAI3wkn48gKjY=;
 b=XneKYDQPw6F1eKNJh97q+MsyPr77QxVgo9+pyup0l2DR8Wvd/0t3WO3m/WGZ1ZbV/S
 eHxnXL6+CJ/Yq5pLcTgMA3s6uj7XDKRJw9pfEhrWJDBjMQzbnNF//n16LZMlzy5IeQvI
 bXsQqPCCHscXduBszIVEegWaZmy53KWwJ8mkSCWKBeG+b7wO2K6oKmA+PVgUSoGrWSoq
 A1VT22C6ieQtS632QOquo3DMp6tgLCLWx6PaAyQlFTaRrPjf5G4NW3FnA0WBX2DEMbWy
 beS/m8c9xlJRAqq9ba0qN5DOkXP2rLvl5VVGjXTmon+Mzlh8Q2xcMDjNgX672LuS/xdY
 /Yuw==
X-Gm-Message-State: AFuF++lgdcXFmgD2+3MkJXNMDwjCci+OB7S1FNsW97jQnfijIZkaapt5
 SV4bOymQWX0icmCVv10tMkyFA7kN78wa/rBx54dYP3OZiUp8v5xCuksrrOlAfooZhOk=
X-Gm-Gg: AYBFou0JU11ET8bnXNYGCxiK6XlOscZWmtAfDE8eyEqhtPbWN6zljhjXGGfbF1KfZwc
 24UeYz8PsPCIj74UT0bxzMqJjYf8svwCuKqBlK4dxJ3jnd2mO4NRZUM6CXLeIhd16HblNYwvwcp
 c/yLe/IYuZURbhBYXa3p7wLVAQGvspnwogv9CS5eY5MmWijox/SE+LwKJI5+2csKT2saF4qdJ8B
 g8qLJNyUCpS5Bn04XQE9R6M/wsQ/YN2QFPm3nE9VsPGgyeQdEvXuKMIItrTr7fsjrrjPPURC7mc
 tyaN+kIedRcIEyk5TtpwJGUpeZ16HyZGV/bdyiarFBiF8t3Qnvg8VR06q22ARLW5B4+Z4Bmdn2s
 usSJL/AXPGDPkah4VwaGoV0VgdKbgN6BMHtpbEiS3K50lNEySHPPIxSQyPSk+/EY2Gw6fWvt19z
 fIQDPjxCErMemwDCPIV7mq7zC99Yo/TOKLmIZNr0YWc3QwNXO7LlZsqr+nQzmW
X-Received: by 2002:a5d:6d2b:0:b0:484:3600:35a9 with SMTP id
 ffacd0b85a97d-4857e3ce195mr12951925f8f.3.1788526418624; 
 Fri, 04 Sep 2026 05:53:38 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c5bc5sm6437586f8f.24.2026.09.04.05.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3691E615D4;
 Fri, 04 Sep 2026 13:46:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 019/105] tests/tcg/meson.build: add wrapper record_replay
Date: Fri,  4 Sep 2026 13:44:33 +0100
Message-ID: <20260904124604.2207440-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

Runs a record and replay test, and make sure the output produced by
both runs is the same.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-20-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index f2c5d77bfe0..328592b28bc 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -6,6 +6,7 @@ if config_host.has_key('GDB')
 endif
 gdb = find_program(gdb_progs, required: false)
 prog_gdb_test = find_program('../guest-debug/run-test.py')
+prog_record_replay = find_program('./scripts/record_replay.sh')
 prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
 prog_run_with_input = find_program('./scripts/run_with_input.sh')
 prog_run_and_check_forbidden_output = find_program(
diff --git a/tests/tcg/scripts/record_replay.sh b/tests/tcg/scripts/record_replay.sh
new file mode 100755
index 00000000000..57775a2d4c1
--- /dev/null
+++ b/tests/tcg/scripts/record_replay.sh
@@ -0,0 +1,16 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 2 ]; then
+    echo "record_replay: qemu_bin [args]..." 1>&2
+    exit 1
+fi
+qemu="$1";shift
+tmp=$(mktemp -d)
+trap "rm -rf $tmp" EXIT
+set -x
+$qemu -icount shift=5,rr=record,rrfile=$tmp/rr.bin "$@" |& tee $tmp/record
+$qemu -icount shift=5,rr=replay,rrfile=$tmp/rr.bin "$@" |& tee $tmp/replay
+diff $tmp/record $tmp/replay
-- 
2.47.3


