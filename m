Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BE0C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJN-0006C5-OI; Fri, 04 Sep 2026 08:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJJ-0006A6-Br
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJF-0006sZ-BK
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:24 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso7097245e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525980; x=1789130780; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UDgTEJQAVKD+RjxGjDwkAKQhJVsaXbOnqkqZa/CeU3U=;
 b=XKgsazEztcqD5+HCV4DWsXt2XjGVLraztP2UECClXQ6YZAwOfs3TGkINUGK9c+66QH
 OOejW/NTJ3ZOXR2o4+mcNgskH8P//6Ru8AQ8LvpzgYiPLmONMYnoAre736NPtubDbtfg
 2IglVnUiwMtrVzKXwj4k6rOAs2oI9WdlhhPtDPhn+cgjd8qzdRjo1OBeWdSucd6uB4Gq
 PBhUdbKf+scck6rcRHS65gicLMAiAI0XKWSzTaIGa3oYhqnRiu0jgUuQeQaKMMZgXpUb
 +kjaOeV2pe2tbx1qsffBpYVK79V4Mnrud3DAmG8LxywVIYGzARs8lDb2WLfvpjV3/zTq
 N/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525980; x=1789130780;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UDgTEJQAVKD+RjxGjDwkAKQhJVsaXbOnqkqZa/CeU3U=;
 b=irWlUqhuqJBHLsH2tTw9Jo2ZtcVwSJZvbxbz7y+AHwVR6znL1CxFGPEJJBOvc9jKHC
 vsNdNIy9PJEzda9F5Yw+A2eX4xb3AynsCzGhfSy568cr+98CayEeFqFr4FpIl+PLaXH8
 qDiwpNAWZBF1l/5dCXEAj4NBPPLowp2ro5uZDnadsfp2qgRD9Xx1UlHz6FEDSpk5HvBw
 QQjO9eEO6SxY8HN5/881P5iPiHQ8qWviXtX97VDo6BVLK60XOKLm3KWDfXEHkh8LzEk4
 o00W0RCyDs65mJzj6omXQ8RuB1A5mSJZo0dulFLGvr3aoMi9t6Szx6mfEkvj1r6x+C5n
 MO6A==
X-Gm-Message-State: AFuF++k9SzUVSyDyAlK7i4NFZ4DSmin3EUIY3hKnnX8Oqr1wG0ihFqmg
 /gP40o8UwljUK+CmjK2Clf38HM5wKnGWl7Wt/qIvGGheVF489b3K0rt5v8NuDd/2I3M=
X-Gm-Gg: AYBFou0QAGSajmVRF7bOUYb+dFNeDrsf6nmwhjzk+bsZ++reoiOTlysskt3uVdESrhW
 scKGu8kcbOqMBdnPUz1H0FZKgPYZ08glDlDcXRFrkUrmijpmBsAfMovnE9eWLfxkkxMVeizv+Qa
 hCS1HlwMUG7VAzzi96bAu/zgtnbyPgeSslDcdsWDq+q8RpppqG5+kPcTW86InzqgeHI/88ZgIZG
 B0/rKfShFo3P5ErQtW853dVJ45GUTk6/xXXvLNblg2LwgLH4mWG00iHZax1EiDjKf/SxHqRDRGm
 SQun0bfqP9RO8szVHvEqcLfXPHkNMjPOv/vRitNRpoVXEGqeMSDUHmJ41vmUv3DUjxunHdFkyg6
 21I37hmhfAX/nkhyw7jRz/DM0XWEzRhjLapzuIiksblDM3Hf7iDJJkYaptFGdW/LnkuFUQ8h/o8
 fW8G7pydSXV+HZnbhsFLxRHTYZRe8VUoBF+Q73LxLVmpIsH7g9lKFZ8NdiliqxU1+rgxO+ETenR
 A==
X-Received: by 2002:a05:600c:870f:b0:49c:fc6c:bdfb with SMTP id
 5b1f17b1804b1-49cfc6cbfb2mr28917195e9.18.1788525979749; 
 Fri, 04 Sep 2026 05:46:19 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885cb03asm6042416f8f.37.2026.09.04.05.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ADA62616F8;
 Fri, 04 Sep 2026 13:46:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 024/105] tests/tcg/meson.build: move gdb_arch support check
Date: Fri,  4 Sep 2026 13:44:38 +0100
Message-ID: <20260904124604.2207440-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

This allows to report the correct skip reason instead of saying gdb does
not support a specific feature for some tests.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-25-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 7384786f7f8..c227bb52381 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -138,10 +138,6 @@ foreach target, plan: tcg_tests
       # if set, we'll skip test and print the reason
       skip_test = ''
 
-      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
-        continue
-      endif
-
       if 'plugin_test' in setup and not get_option('plugins')
         # do not use the skip_test logic, and simply ignore the test
         continue
@@ -284,6 +280,10 @@ foreach target, plan: tcg_tests
         endif
       endif
 
+      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
+        skip_test = 'gdb not available for ' + gdb_arch
+      endif
+
       if skip_test != ''
         # still declare test, but skip it and print reason
         cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
-- 
2.47.3


