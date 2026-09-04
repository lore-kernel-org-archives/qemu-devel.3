Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA14C79F88
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQQ-0001ka-J4; Fri, 04 Sep 2026 08:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQO-0001jj-Nh
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:44 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQN-0000ka-0C
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:44 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-482e067e908so873463f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526421; x=1789131221; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nbwdsD1KXx73ouDM87wqBzKiBRdOYCh7uD4Le2YTHEg=;
 b=ghVJadOhSWQ/SHc2AT//CxpUx35r1+sApV4zCYTsCPHF0lJ9Fn2oE+v7KkgyOAPsIY
 zaiEtGcs9IGtWqjYHCTGi/AGdaG1PfbQZj3YJ3DDEz88PdUiguXvYIqrb+IjDa06+FNs
 3hMu0SPQdcvF0U0dSP7h6OZlzqLKOeUSC2hXRBRLyR09kGbSV4mby+498qcHacEJLznE
 qu9TPveAdN7KMbqPzTulJWtbGq/KIwCAyOKEB0tvHEYJLJqHOYeYghKvuztC0i3sEmLb
 a8Jlo/EHh0UMFTjJBhau8e8Yjh+k6z00cmfb7BlERhNHEy3PT1H2vtyToQqYGkfFNwVs
 IxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526421; x=1789131221;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nbwdsD1KXx73ouDM87wqBzKiBRdOYCh7uD4Le2YTHEg=;
 b=qf1c0Anx9jPFbX3nG70NU887zyD250vNHwVMXUSypFrLAM4xZxlNdRUkQvJ0be7b/h
 nrG5Kpasr1hxBb7s/j8c6gBbrlzoilOnK5V2GB3Nl+Ovmc36rcneMAR3Sbareff/LVcr
 xRU5way1ULT6eYb2GvnHzXOJcKa6zsiKNxdsisy9fWGWzlhT2eZE8i6RpWJPcZhHGvSx
 46e9671w5nhvK/+9+BDq5bPowHQOq4Gd8DtLFzqSJjQKelGgzadpHgjbYHw8n1wpA5Cb
 4bl93v8Qh0tmZx2qK+zxXl6CJX4X65N73j9yf0QxP76kA6xheLk4sbtXq7VwSimC9gX3
 EBjw==
X-Gm-Message-State: AFuF++lMKaNehESGxpTWZddqH5d6BUnc7No1ai2ddOWAXTeG9xQwvcDQ
 +mj2V7WfSbPRzF0kqG1Vtk7+MfaIZYpy0gecpwZA1kJA/EAqKH/9njAUNc7NqEza2dQ=
X-Gm-Gg: AYBFou1czdYjgB+4dYpqYMEQhNUneMdBEkb2jUEZThUNkSnk/QAVklmSiOQkSw0Xc0h
 EffLlqgVpP8PO1f/gHM89KQvcF/Uyel/cXqgmcdOmFPZWxEA69BaGCEHcb7CxuURymlWV7BWTv8
 wnY1UDDFWp5hPiJkE8q1ojMqS3v8w6T9o+Fe60CYWchESmLVhdgXYr+aQ+pBo957g+ha7rxL8Py
 GhWlDWPiMCNxmT8m9Jfq1MBPPgHMew9/1SsnuUkf94Zt/xw76UT4NBB54mhE9KpeqYC/+qPPKub
 ofaIXdtnziNVTciIZIXOGeQ3oyDa/uog5+1mjxLAMjaFvGxkXyjxgaFn3uT6avKk3wOtqL4GXTm
 Rj6slkfFAZRhNmT7bOUr7J3MRc/UZ3+uEvFN7kqJyAvX3palfDNgo4Fv3GnlSnuruDwDOU8Uck6
 bswquEwYhSFVYtaB3GGbSR14FnvX81cVBqZOHb7Cja2F8VkU2BLIHPqLDzNjH0
X-Received: by 2002:a05:6000:4b15:b0:485:8a46:7064 with SMTP id
 ffacd0b85a97d-4858a46728bmr4088818f8f.54.1788526421168; 
 Fri, 04 Sep 2026 05:53:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883959f0sm6612513f8f.10.2026.09.04.05.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 667926168F;
 Fri, 04 Sep 2026 13:46:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 021/105] tests/tcg/meson.build: add logic to skip tests
Date: Fri,  4 Sep 2026 13:44:35 +0100
Message-ID: <20260904124604.2207440-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Instead of skipping tests and not declare them, always declare them and
simply return an exit code 77 (SKIPPED for meson) and print reason why
test is skipped.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-22-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 779f9043abb..7b60ea53825 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -114,11 +114,15 @@ foreach target, plan: tcg_tests
         endforeach
       endif
 
+      # if set, we'll skip test and print the reason
+      skip_test = ''
+
       if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
         continue
       endif
 
       if 'plugin_test' in setup and not get_option('plugins')
+        # do not use the skip_test logic, and simply ignore the test
         continue
       endif
 
@@ -226,6 +230,11 @@ foreach target, plan: tcg_tests
         cmd = [setup['env_var'], cmd]
       endif
 
+      if skip_test != ''
+        # still declare test, but skip it and print reason
+        cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
+      endif
+
       test(test_name, env, args: cmd,
            depends: depends,
            timeout: 120,
-- 
2.47.3


