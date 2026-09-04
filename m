Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778DDC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJQ-0006DC-7M; Fri, 04 Sep 2026 08:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJI-00069L-18
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:25 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJE-0006rs-Ts
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:23 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-495590dde14so13333785e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525979; x=1789130779; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r+WY3scpMyBQywsEfZ38rZGwyTfrr1r4ukZ33K30QHM=;
 b=syTqM9ROP97Qh7jlgX2Ny6JTv7Bl/ItK3V3QtdwRJMvOeMBr/z2/AteGBOT3i6BnZu
 SNYSNpzBdsxklKQbzKsTtV3HzXZsdpxawOZjZtkGxckRKfoV0Rc+4dhV76f5Q7r6e6Ol
 J5HFRGmRZXUR17Tx1VaPI0zgg7v6B+xu+wk/uXvJ2moIPRX0Yg0RVsOVG6WZF8tISN9b
 f3pDAaixN1/PIF0ihzxe+jrVUlfHz9dJPe4HJGkSyzDzNC40dntVNkW04OkP5Wv7NNsH
 1a6+gqPdgm9Qovf62TYv3ulovMb7LbqJZl1Qb/gCbTXjUMBlWlO98RSS/Ya7UE5vlwBI
 PGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525979; x=1789130779;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r+WY3scpMyBQywsEfZ38rZGwyTfrr1r4ukZ33K30QHM=;
 b=OuFcxb5jyhKaIva2Y0na9PEHOcgzdBeZ0BDTWcfRMcIxAIi+KuP6Ys0Q/fg6ZuxKaw
 XzthI91QcW7FFlTcTBEcSr5CUWyh9yIeiPp5feA512nEQivmXfR6SR6llqlPd5vh33qy
 yewuE3XZuK5HZTMWSapT5WKjnbyTSztazjdDVAv46Rk2zmjTvylJd8lo0uahIVh8vFuO
 GHhriZ9fe5xO13fC/HF4/H0RxbS+DsXTPJu4KB3n/FqAmQk7UkCknBDbdiu+Wo/oXGM+
 +EzIuH3DK0KcDCw/njyy2ThFzhcWVN2V1VWxwd2EGHadYRew23arLvDTB7FNHvDSKwtn
 2Mpw==
X-Gm-Message-State: AFuF++llV65OlHP78n8mS/DrnWcw9YH/+OaQ9+hgBMcMcatxe2TxR1tF
 gOyrfdL18wXauiaOiYyVt53zxhDLSe/cgEKA8g0akT14IL9eBTHyvpXa1KtqMPjzHs4MfyYJ+Ed
 aZ7+/tcU=
X-Gm-Gg: AYBFou1o2QA1a8ytp2CdKhLa0vGrHB6wD4nvA4Fq/RaFBjmUOb5GXIeRbJx4sRLmSqN
 pvuiUMpkSV99tXnFfiuqQo/teA9KLMtHqx/K5BiaOuOMpQLnZYr/GjIc6BhRSshxwmNhs7wrz9q
 i8hQVJ5V4H+ksljQdf0GtuSJWYkC8bL2d8gGid9Th1fvDcxpvF7rfwus0tgJ97NTRWj9Yj9+RJp
 gx2Px8tDyP8q0ecaJ/ki232hI27IZ8W3AdcLnnIfiZNChIFFvsShvxaz37a9CzMaw78VBT4wSCb
 FV8onw2xgJGHA77k1bZppiazcokRdrYUIKJ8YQaiBzG4QuB4QU+wcLms5pctveYv8c9+Q6ULYCN
 G1GXFz8tDl61hgYy+AAhI6nz14KYlJmlJjVLgQTBcYafg5LVlgQVypS9NM2wjsqLKjNVb/URlyh
 SqiV9GXSZ5FK4NQLbldX74BGCK0RhFAVboLUC1k5f9ndDfMuAXKAG6fXJOYNG7
X-Received: by 2002:a05:600c:1d01:b0:499:cd34:f7c with SMTP id
 5b1f17b1804b1-49cf81e6f87mr86994025e9.5.1788525978627; 
 Fri, 04 Sep 2026 05:46:18 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858d2693e8sm2434073f8f.3.2026.09.04.05.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 202AF615C9;
 Fri, 04 Sep 2026 13:46:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 018/105] tests/tcg/meson.build: add wrapper run_with_input
Date: Fri,  4 Sep 2026 13:44:32 +0100
Message-ID: <20260904124604.2207440-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Semihosting console tests require console interaction, and were flagged
as manual because of this. This wrapper automates interaction, by
sending a specific string on stdin.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-19-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index c718555d257..f2c5d77bfe0 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -7,6 +7,7 @@ endif
 gdb = find_program(gdb_progs, required: false)
 prog_gdb_test = find_program('../guest-debug/run-test.py')
 prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
+prog_run_with_input = find_program('./scripts/run_with_input.sh')
 prog_run_and_check_forbidden_output = find_program(
   './scripts/run_and_check_forbidden_output.sh'
 )
diff --git a/tests/tcg/scripts/run_with_input.sh b/tests/tcg/scripts/run_with_input.sh
new file mode 100755
index 00000000000..3d280547c3a
--- /dev/null
+++ b/tests/tcg/scripts/run_with_input.sh
@@ -0,0 +1,12 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 2 ]; then
+    echo "run_with_input: input_string cmd [args]..." 1>&2
+    exit 1
+fi
+input="$1";shift
+set -x
+echo "$input" | "$@"
-- 
2.47.3


