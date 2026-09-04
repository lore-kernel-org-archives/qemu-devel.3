Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271CBC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TaS-0006eO-DA; Fri, 04 Sep 2026 09:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2Ta2-0006Q3-Lp
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:46 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TZw-00038U-8T
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:41 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so10349495e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788527014; x=1789131814; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vDufOlKcWSbRjTlQz+HSShvFcMWsD21zyoT1BVbu8YM=;
 b=nHY16Ezt0pKN5JUJ8bQ33zJNZJFOjd4DqmWhV9hBmXa23BAUDTAP5cLzbXg38Dp+Ze
 t8hfkBgkR38UfU2oCpOTQI+9TtT0KXzaxIHhV214WGgUZ8coddoYLvUv6QHvFBY9PpPL
 CX++V7zWFV2n1K/6AObNDVsuhuck/rhsPiAiEIL6q1eEFSuoGtif9CRCmQRVOVFVL1B8
 8KRBX8bBYIj5Fh5W1ULERZPWxvTuJFO50PpskuK/TcSytO/ofy6wGTWAK4nAsVXwYVFi
 AjK5JY51pUsoNT2yzIMILNehN8mTuS6OZcglRHKiDklb9XA1lg8Ca326OFyi6f5z9pK0
 QeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527014; x=1789131814;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vDufOlKcWSbRjTlQz+HSShvFcMWsD21zyoT1BVbu8YM=;
 b=NgNFZqKAPX4hQb/N35NIjjbA7AAS65dk68Jghkp4wNlAN35N1GF87gkFjWtZFKHA5e
 0BhibFP68z4J4pmB/unADE3B5Y+H7j6FnXQxO/vo7HhDFud36X8fAYT4nsNKdE/LTF8m
 wlDq2ClUSiOb/uVvYaQkPkEtij1iqcBAMuTwiCxoldxMpB0oNDa5t1qJqN8C1xt7BvjY
 D42MA4b7ZJkGOOoOfCnJBn905kivikDzYnxScpQR5ActVlkZpUJGGWoVMDbKxReP7GgV
 +07/mf+jIAGFu3uLMuHwZB3HzwQDbY8Kv+EhW0HnhfIC/pwdhVYcyZCRaznME7VfMflr
 HD9A==
X-Gm-Message-State: AFuF++k8UAArt1RfZNbVT0MZlAkZLt8IJXPNmSQId/XzP/JRCfpQC2+1
 EW1lYZ7tJJH3zHfv724goh5Tp7sCJaDLxYK5jQ0ZWNXEVi2vk8VNRe1fbdz488ihObA=
X-Gm-Gg: AYBFou2dpdoTsznKUP7tNE4AwGt+uTJX8Khx8jJfu4hiM3WxcHi4y3HLDVyjJSfPMZb
 b99mYtMVDxT53HAa5+k0HD1/WaeXJEmg53zVdSiaJEFT8ALGswak6pMZ5JGVCYKeuCQEsvel1N8
 trAiz1tduATaWgUOmaaC7aJVCiU7nYP8/OAhIm/Vlfe9Q2XVr5WEejPegwdHvcyWxYY3rHlEC4Z
 4HqvyzxfZPuDSUKc3rwVOGqxzrXR0MTZqWX3neQkFYWPCCL1UX/jOdvkxZWum7VUNn9YWDrsOqg
 ixhM+Eg1v2qm5ZZvod0L8g+7V9GA5VJDWSesv3nS3tI0+bC0gz33qsoB4SRN2xwaaqtezAOURmE
 HU5KUAQiRuDOP+Ou7Q/oF4zuYila/1X4kN5oV45wpmBG7FfTylQq1HZAeZqkUuptPTaQifx8FhG
 URQixFioLl/d9YZLVNbt9/nbPzqwTaPWuZVa1Ug7uHccMLumF/thda4CHpxzqo
X-Received: by 2002:a05:600c:4585:b0:49c:fc6c:be16 with SMTP id
 5b1f17b1804b1-49cfea09f08mr18051125e9.28.1788527013910; 
 Fri, 04 Sep 2026 06:03:33 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d4938sm152638005e9.2.2026.09.04.06.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4DD0D61633;
 Fri, 04 Sep 2026 13:46:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 020/105] tests/tcg/meson.build: add wrapper check_plugin_output
Date: Fri,  4 Sep 2026 13:44:34 +0100
Message-ID: <20260904124604.2207440-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

This wrapper runs a qemu command, record command output and plugin
output, and forward both to a check script.
We use this pattern in several plugin tests (for instance, with
validate-memory-counts.py).

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-21-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 328592b28bc..779f9043abb 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -5,6 +5,7 @@ if config_host.has_key('GDB')
   gdb_progs = [config_host['GDB'], gdb_progs]
 endif
 gdb = find_program(gdb_progs, required: false)
+prog_check_plugin_output = find_program('./scripts/check_plugin_output.sh')
 prog_gdb_test = find_program('../guest-debug/run-test.py')
 prog_record_replay = find_program('./scripts/record_replay.sh')
 prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
diff --git a/tests/tcg/scripts/check_plugin_output.sh b/tests/tcg/scripts/check_plugin_output.sh
new file mode 100755
index 00000000000..d942082ad86
--- /dev/null
+++ b/tests/tcg/scripts/check_plugin_output.sh
@@ -0,0 +1,25 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 3 ]; then
+    echo "check_plugin_output: check_cmd qemu_bin [args]..." 1>&2
+    exit 1
+fi
+check_cmd="$1"; shift
+check_cmd_args=""
+while [[ "$1" == "-"* ]]; do
+    check_cmd_args="$check_cmd_args $1"
+    shift
+done
+
+qemu="$1"; shift
+tmp=$(mktemp -d)
+trap "rm -rf $tmp" EXIT
+
+set -x
+
+$qemu -d plugin -D $tmp/plugin "$@" |& tee $tmp/output
+cat $tmp/plugin
+$check_cmd $check_cmd_args $tmp/output $tmp/plugin
-- 
2.47.3


