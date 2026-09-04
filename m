Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFBDC79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TQC-0001aS-Ly; Fri, 04 Sep 2026 08:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQB-0001ZW-7a
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:31 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TQ9-0000ew-Gb
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:53:30 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49b965570d7so10933195e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788526408; x=1789131208; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ilsum7WCP4JfV9DfKFlmxOu6x9pWUdaPIfh49tOZlDE=;
 b=D/ZMeS8E0rZgNMPpXBlGQJRpS4HbyP0wEyCcSSjxqjv/cjcRZzw5UE0wZkaRn7kzOw
 qfWnU4jFUqy2RXg5DBZL+naG2pqskHhwuarmrO9cU/1dcJIcklp0EJlB8kB7z1iI4EhX
 aiV0YAD6ok95o16gKtA+pj6gdex7s6IwDF3Uajsl38GaI0+fLU+4A3L4eIEUnWpYUWDN
 FFdJ5Uh1HSTItQqVv2nByyQJafAT6L72aOhETBMINWQjhJfvKcJp7fCKf8Z9MKNQ5IHt
 dc1C516ylaznLG4ic3YKslYDYA1hLH5mxJ61+gMXUXI5t/EoHWbQTooh87xtgLMSwxEM
 BJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526408; x=1789131208;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ilsum7WCP4JfV9DfKFlmxOu6x9pWUdaPIfh49tOZlDE=;
 b=d6a1bucmeWjsEZY/KfcyurMCS78pVCkIBj7+aHydB1e+CA4f510ogmHPNBDVyRfBgT
 J1iKYTGOm7lNG0i3I0/OTApakOx+xj4eUtZE9/BEu9sHhUHJpCUfInxS4xDMtUC4zTfd
 k9BTZpx5/iqwhdlwtHHDnvzY8OrSQ2v9E3U5eNn9vi+ANXvXX8KXONskjgXTP58q7r5r
 kaPvdLrsgXWPV+pSHorhPx3DowGi3RErBpINY0fOHCA1ILupovaMHXSR3royJMzrlQ3N
 sXSTEuTMxxTZEh2KnsvkEZYwPEx3bXGjWtwm+7qAASbwOotIJ2Br/J20j1EoCfwVORgF
 ii9g==
X-Gm-Message-State: AFuF++mCqdrFdgL+RWYf7IFToP36FhkL8ohpbwvvqrM+5F2A4Uzbl2fm
 SSxKY3tx2UJkPjPTB/P28fHZ9VozlbfWqmhnTyihPL9D9u40gF5guNfyjy3QIfkgbK0=
X-Gm-Gg: AYBFou2GwvLGs/cVqXs8VtztaTSOwn5xiJCFHJQsDG4wBlVSGUoaG7uXymBPl7+pn5S
 2j3xzNCBlWxQySp5LdoNRREYKaSZwsxPvxb/KEIKvoiyG7B7N3jXPktlcHTRShAPb/UzRqvKQKP
 AgorqMDv/BuTRrdLiV7F8GwewQUouSyu/4BiRQHrGQolxLLM44N9IqUFsdLVZpFbheILnjaqIf4
 diQISwYDgfOw6g/5Ks7vdF2EkPObiers1GkMCjJnjdvthMCqcAFZWrYyAt55af9rlEXb9JpJcZC
 /kxyDFcAd7DpyrbGPZGiX2xeKDddwkaH49qUrLhrcOVcmpjQRCkXkgJAqTpkWroHzkHt7b/BGg/
 HSTfnXcIEKnRlN3vH/mtr2dK5TjABxbaNqMpucq107RYObrRjWCU1go/kcHkKIWjT46SHTrANbS
 /hW6cE3jlNvXrbkLYNAn0i7/mSzFFXs+aQGiUl4Tu/zyF1TGS49apW9rcfeOx6
X-Received: by 2002:a05:600c:4f48:b0:49c:fc6e:8cb7 with SMTP id
 5b1f17b1804b1-49cfc6e90a2mr31553165e9.27.1788526407749; 
 Fri, 04 Sep 2026 05:53:27 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf75ce49esm118469985e9.1.2026.09.04.05.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:53:26 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2C02261785;
 Fri, 04 Sep 2026 13:46:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 029/105] tests/tcg/meson.build: check host cross cc is working
Date: Fri,  4 Sep 2026 13:44:43 +0100
Message-ID: <20260904124604.2207440-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

On Fedora, cross compilers are provided without runtime or header files.
Thus, even if program is present, it can't be used to compile files
directly. Check this, and fallback on docker if not working.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-30-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/test_cc.c b/tests/tcg/test_cc.c
new file mode 100644
index 00000000000..d3614a01fe6
--- /dev/null
+++ b/tests/tcg/test_cc.c
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* Include a standard header to make sure cross compiler provides them */
+#include <stdint.h>
+
+int main(void)
+{
+    return 0;
+}
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index ab7090a62fe..9809695f3b8 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -109,6 +109,18 @@ foreach target, plan: tcg_tests
   cc = find_program(plan['cc'], required : false)
   cc_from_system = cc.found()
   has_cc = cc.found()
+  if has_cc
+    check_flags = ['-static']
+    if target.endswith('softmmu')
+      check_flags = ['-nostdlib', '-ffreestanding', '-r']
+    endif
+
+    cmd = run_command([cc, files('test_cc.c'), check_flags, '-o', '/dev/null'],
+                      check: false)
+    has_cc = cmd.returncode() == 0
+    cc_from_system = has_cc
+  endif
+
   build_test_depends = []
   build_test_depend_files = []
 
-- 
2.47.3


