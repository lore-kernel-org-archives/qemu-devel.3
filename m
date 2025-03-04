Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBCBC282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpamZ-00018Y-8f; Tue, 04 Mar 2025 17:30:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpalx-000864-M2
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:30:01 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpals-0007lu-Ng
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:29:54 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-abf45d8db04so606696066b.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127391; x=1741732191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTtmDnmwvkhdA/58TzSBQMrhe3CiA531O+6zAKZ/Bs8=;
 b=oc1Vm/LeqIB5DfQs3g/7Mu58ikOwEiNNBKvAmTJRSJTNDkEsBvqgGzlS4KbynOyfZz
 le7ri63xD9tSBahckEg7A6VmO05ucHbf7+TsCXH9dd1WFcvDGcoey224SA0hvBuXd5qq
 dwI+Ywsbf+VRMt96OIj0U6ty8vT9f2WjRvMxbQ8FsqRVIaCz3T2hFHXh+FjYHtzLUw2L
 71UAaUnvdHtxzOAweXblveVwfp4ic2LtTQSZmGG9OVHFfMHa1O64u6mRquuzc/TCIMYt
 IMV7BUHElZSBdJ5E6iSHAV5c3bG6yqHIKOV+0+WwDQqlDYNzVZkC3Um6dd72OBmu+N6u
 /PlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127391; x=1741732191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rTtmDnmwvkhdA/58TzSBQMrhe3CiA531O+6zAKZ/Bs8=;
 b=HwuytNzUkEywDnAIIJeGgHl+YrcoiuPNHkZq70WKB8xyTxQbDKlcdJX4JXnyyVXnKy
 6TUHi2Z6posQVAyiTDrgKJwLXZ65C/Ru12H3inxGx+c/SvMbeZxXS1qki1T51xcmnbyo
 JavNJCIqvNOwq6caILVIn5d0QljJqkanbJqwkak2XjoJ1L4QV/O3LBoxv0SZSjm3Jg30
 U6NihDGwZ7OjWLYrHKbbCVmo/EoL4O9zmwBLn7YItH36k/HBQ4tXdKl/5nNcoz/3k+TC
 prQKziEL9/hHCuGCLY6gSGM9xNE9yPd7baa6BvltTfldcxUajxW4XJv0XQoHYLVrq/qn
 krzA==
X-Gm-Message-State: AOJu0Yx/9uEOGKnMUV0Mz6TdEuL8zmkZSqCmeHKw+5oWx7Bpvj2fvdDL
 7/JylYTc2aow7Fd4BzBSXlrXbMrLMVOaIbTMImDbi8jJy5BOGM3mUpKVZjVx+9I=
X-Gm-Gg: ASbGncvt9zs2qqkuhjsTBiU44sDXmHZ0NSWra6G0aVBwnMJr9MUkPv4ZrkXeH86IWw2
 COfEKDwh/rywObLdRVU6YJ7xXjm8HqIO96hGoprinnQANBJfKbwecHdeTPFA9J88cHYKOM5MVyw
 O/yQpAxjqzNIwZKnKJOR00but81eNT31P0kRreaDUuobGP9VAGO38+Bap8mZ+NsNfNgRBpOzGYL
 gXkgtMJ9XVkQqgOpHTGUY0CZj2/2kJboRJzfi5FiB7urbQyRdROXwE+wQ7/XH7Ngg7JNVfUBZTT
 dAonoOT4AvOusFTD7ls+LRslKwD1bAhnUBPMKi9npFAJfwI=
X-Google-Smtp-Source: AGHT+IFNGGnVHa9ZHIX8cqQaDWVCxSxsq971F5Su4DgMzigqTiXA1uPQemSAQYmXIlHVegbIwhzbTQ==
X-Received: by 2002:a17:907:6d14:b0:ab7:d87f:665b with SMTP id
 a640c23a62f3a-ac20dafc17emr78306366b.48.1741127391262; 
 Tue, 04 Mar 2025 14:29:51 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0b9956sm1037106766b.16.2025.03.04.14.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:29:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4D4A860853;
 Tue,  4 Mar 2025 22:24:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 19/32] tests/functional: add boot error detection for RME
 tests
Date: Tue,  4 Mar 2025 22:24:26 +0000
Message-Id: <20250304222439.2035603-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

It was identified that those tests randomly fail with a synchronous
exception at boot (reported by EDK2).
While we solve this problem, report failure immediately so tests don't
timeout in CI.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250303185745.2504842-1-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/test_aarch64_rme_sbsaref.py | 3 ++-
 tests/functional/test_aarch64_rme_virt.py    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/functional/test_aarch64_rme_sbsaref.py b/tests/functional/test_aarch64_rme_sbsaref.py
index 93bb528338..ddcc9493a6 100755
--- a/tests/functional/test_aarch64_rme_sbsaref.py
+++ b/tests/functional/test_aarch64_rme_sbsaref.py
@@ -60,7 +60,8 @@ def test_aarch64_rme_sbsaref(self):
 
         self.vm.launch()
         # Wait for host VM boot to complete.
-        wait_for_console_pattern(self, 'Welcome to Buildroot')
+        wait_for_console_pattern(self, 'Welcome to Buildroot',
+                                 failure_message='Synchronous Exception at')
         exec_command_and_wait_for_pattern(self, 'root', '#')
 
         test_realms_guest(self)
diff --git a/tests/functional/test_aarch64_rme_virt.py b/tests/functional/test_aarch64_rme_virt.py
index 42b9229b4c..38e01721a4 100755
--- a/tests/functional/test_aarch64_rme_virt.py
+++ b/tests/functional/test_aarch64_rme_virt.py
@@ -89,7 +89,8 @@ def test_aarch64_rme_virt(self):
 
         self.vm.launch()
         # Wait for host VM boot to complete.
-        wait_for_console_pattern(self, 'Welcome to Buildroot')
+        wait_for_console_pattern(self, 'Welcome to Buildroot',
+                                 failure_message='Synchronous Exception at')
         exec_command_and_wait_for_pattern(self, 'root', '#')
 
         test_realms_guest(self)
-- 
2.39.5


