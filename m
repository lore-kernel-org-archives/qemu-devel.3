Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E696FCA168
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzejJ-0000it-TR; Mon, 09 Mar 2026 13:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vzeiq-0000aR-Cq
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:49:01 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vzeim-0002pA-7y
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:48:50 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48534e9076fso11833335e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773078525; x=1773683325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Re1Z7KTF6pGt06r2qKUhhUG6rRUM2+jHUzT54RyU8Vo=;
 b=FTFZ8SEdYsfPazS3nfdP1tVdim/bsrpGwI70n2zDXiZti4Pjv9VT+l6siqmdWJkfQ9
 BONi6CyjbNkmllgagTGlYZQR+J3B/cvi/EUbCT9FLPdQKTILRgqsQiVn6nokby/oYHPC
 fA9WGeH6N6RhpbmUV+K1/hVjrwxNfEE1eHsJsGsaqiGWarsvN5O6CU2i7czGDUelLTql
 7IMGjvbyBTl26p8nzhHuUtJhCJjbYEdeCfGu+opEk8mamzxcmc6YyjPAL0O0EC1mCk8u
 fAFth+aLBYdK7WppVcFyiQqtQLWqR+eZIQkWaxjOACYQIJ5stxWSedntDsC+nr8JL4ai
 7V5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773078525; x=1773683325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Re1Z7KTF6pGt06r2qKUhhUG6rRUM2+jHUzT54RyU8Vo=;
 b=rYmDYcc7CT3YwvjBKDNGVqZ7SjwnDmDu7TcxAjEC+doNUU4QEGg3cqaZQMzP8nW3M3
 Gm3ysCNBuffvbIBjokiMtUymzFI8AEmB3heS27bvWxneNeZUMUkAfw76eQtj1WWqkAf1
 60GUp37MV+FEScGE5fiN/lHdJsOjH6cD/KxD3R3qS+i/vQFhi3lbvdirNqDM64ryhWsT
 6CtgBK8eDKRrrtg6uoiHh5Cw3L0t4aJdUK4Skfb8ZuJZyBKaqYMdWhgOD9aLsQx+932G
 kqfHFawovKnPVGHv3JdvRY+WTuIxOvXDFApu9h0z61dpXmcFZS9doQYgb9D0GTj4AqJX
 UPnQ==
X-Gm-Message-State: AOJu0YwR0Ngd14wCfXmD77o3FklghXvuNAPNBOplHG5DCckMCjMLyCJm
 jDaGwKVBXKn7gnEh9o7peOXMdYveYM2utrsJYqaVQXUQoo8X43MKBlrla9w5BwcmPRw=
X-Gm-Gg: ATEYQzzMi+vEm+MQeWw8CcbaRCgDpHO29djYJMRQyPr6rkR+pRurBQOzXvmKCSmobh5
 I55UpVs4LPEk5Lx3x1FzRfu96MfaHgoljGXNUs6Vi/8vMv9qNAmqOnCY/ZGspqVkKvtceTanoPJ
 h0WdmSOGhrdPcrd8yjpLz6Ehribx3VlBTPVWScr1QRsWVn8TSn0JuGKRm5PX7kE7RNLoLgx31Br
 fP9FQJB92a4afaRvJJHYXG+rdpqSVqFRmp1hnPnanq0YFASIH+2PbKlnUrfcWbxslUQGUHW0W5x
 4E/VuDryM8dfiTPbWLlAd9AwTUwF40/jBkblE+VVsbmfl/OZrBWdhEEUOwN1PVHAXsBhSXMqAVq
 s9JyDzrJRMNFHgEiA3SP4YjCKUyah5067CoXOCgDNV2T7dKPqNv04CK4MiH+I3go5DNYwnYgZ+1
 mJDpe68PpcP/on8fqwlIgk6Kg=
X-Received: by 2002:a05:600c:1d1e:b0:483:c35d:3659 with SMTP id
 5b1f17b1804b1-48526957d5cmr208195725e9.18.1773078525397; 
 Mon, 09 Mar 2026 10:48:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485237f354esm94164265e9.5.2026.03.09.10.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 10:48:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 084865FB68;
 Mon, 09 Mar 2026 17:48:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 4/5] tests/functional: allow tests to define decompression
 target
Date: Mon,  9 Mar 2026 17:48:40 +0000
Message-ID: <20260309174841.4184117-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309174841.4184117-1-alex.bennee@linaro.org>
References: <20260309174841.4184117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

When dealing with multi-stage decompression we want to specify the
target file name lest we just overload the cache name. It also allows
for something is little more friendly than the cache hash.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/qemu_test/testcase.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index c2c916f6077..eaec1bea138 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -35,7 +35,7 @@
 
 class QemuBaseTest(unittest.TestCase):
 
-    def uncompress(self, compressed, format=None):
+    def uncompress(self, compressed, target=None, format=None):
         '''
         @params compressed: filename, Asset, or file-like object to uncompress
         @params format: optional compression format (gzip, lzma)
@@ -52,8 +52,11 @@ def uncompress(self, compressed, format=None):
         if isinstance(compressed, Asset):
             compressed.fetch()
 
-        (name, _ext) = os.path.splitext(str(compressed))
-        uncompressed = self.scratch_file(os.path.basename(name))
+        if target is not None:
+            uncompressed = self.scratch_file(target)
+        else:
+            (name, _ext) = os.path.splitext(str(compressed))
+            uncompressed = self.scratch_file(os.path.basename(name))
 
         uncompress(compressed, uncompressed, format)
 
-- 
2.47.3


