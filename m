Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4C6C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 18:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlsP3-0007rU-Mz; Mon, 20 Jul 2026 14:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wlsMX-0006WP-7y
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 14:05:15 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wlsMV-0005zH-KR
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 14:05:08 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so73384605e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784570704; x=1785175504; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KCnuOtAk/eEXnAK31YcZ0Wzu6V3QI60Y5oRXLMbOCeI=;
 b=IX8SHAR2TTVbQaK6Y8LTuQQqVXxxWNQjT9jFELme7uhEyWBpciQr8gB7RUBUe9gkW3
 tYu/B3B7e5gqmZPm+fm/hZ07N7GdWNezJ50NMi0dROmyV+RRc0Y7Gg03m1W85DYagQ8V
 b1so9saFKxtj4CFipB5eohP2Hhc9FjB59w3SSuWYFl2sAcs7DeI3fTYYJrsphBIcDUW3
 PQqrq6Xd4EptzzwgmfM/b24a+lIYExzfSMgv05F1FCiJJFKKa2Qtztjk5xPAuZozHyxJ
 XJixxost1hSJ1wDdiNuBOKUFCH/ar1+27zTA/LsnGC9x1jtwBgJhvEyVrQ9HUblQsR15
 UP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784570704; x=1785175504;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KCnuOtAk/eEXnAK31YcZ0Wzu6V3QI60Y5oRXLMbOCeI=;
 b=S7wL0bG55thXU+J3VIBvGpJNKWzXDNf2Y/Io5G9zcDLqre3m/1eE0evCGmMBNsBcB5
 gTOCGVEgkRR/aY1JmXzfqcN6BxirKdPWiZukPSGe6EvY5rNefCFRm2XYCPgMplE6g05z
 A/efkYHvQyXxWOa9OxX/oP9bZQDISCGIatTp290CqRIxqv/iOXL/CMRafExlPuC8bQmr
 1uOunadwrhVogIxNQumARcIFVMvVPBZ/qrtQZeBQtyDE2Z6EA4xVsSbYdUefdkOJBfGe
 pVS4WRRv0gF0yJriCbIfysTbukdkoT6vM3jWMueNt+Y55E0kxHQyp/h9WvKggMMwXclI
 D2rw==
X-Gm-Message-State: AOJu0Yzgm5VIAjsLEgbGlP3V5amdJblBaF44fsRlQNM/K4JkEgolAMJ3
 wdZNOE5G+Sve+PJ5mxNF8Vk+iWSCg8iQDjrxaaNXGKOqpSc9Ai9bZ2uo1VvkmAGyvjg=
X-Gm-Gg: AfdE7clo5cWscKkSEUoKzxJlkfRJbtbCuT3B/u/bTjv1Dh57iNKaau5IAHyOHk8HfNg
 0zGNESR9F90erd0SP4ZVwVdHqrW2pHtfwoHuNzmzWRX3xiUMKVI2y81rAis2J1GdNps5gC7xCYK
 j88vAEBT7eiE5A0x/YQqNGe+9O+2DetFKasXPAubzE+Dwfm0B4SzRapQJ6apiyNlA05ivBgsp3D
 GrarbFEmrS9Sv3i9DqravPIe8Dv34Bma1P7FfsD5pb+3VSHyrefGWNOtywUTBsM6r3H4ZqsPsy5
 l2vYCunMgLdu0cIBGhM571SQZFj7C3sELgv7gC4fhgUprI1SfHCe1U57sj/LAg77GLhs82I/M3z
 Gg4xoktxp7x2upfXnE27UBdwYaWZ6V8QxVZXGfMEZtxHwIIhF8brKhJrF9MtdYY1uHl9h2u+AU7
 LW+WybLzQODBXpBE432AzOcPo=
X-Received: by 2002:a05:600c:4f12:b0:493:f0f5:f2d2 with SMTP id
 5b1f17b1804b1-4954a3d0ceemr182654405e9.1.1784570703893; 
 Mon, 20 Jul 2026 11:05:03 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495654881c0sm4405605e9.15.2026.07.20.11.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 11:05:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1EA105F7D9;
 Mon, 20 Jul 2026 19:05:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2] gitlab: remove gdb from MacOS jobs
Date: Mon, 20 Jul 2026 19:04:59 +0100
Message-ID: <20260720180459.2542918-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
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

The gdb jobs fail on CI and although I can't replicate locally on the
machine I have access to it definitely fixes it for the gitlab CI
machines.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - better commit message.
---
 .gitlab-ci.d/macos.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
index 53b6e6c4d8f..641a48b3832 100644
--- a/.gitlab-ci.d/macos.yml
+++ b/.gitlab-ci.d/macos.yml
@@ -22,7 +22,7 @@
     - export PKG_CONFIG_PATH="$PKG_CONFIG_PATH"
     - brew update
     - brew install $PKGS
-    - brew install gdb aarch64-elf-gcc i686-elf-gcc x86_64-elf-gcc
+    - brew install aarch64-elf-gcc i686-elf-gcc x86_64-elf-gcc
     - if test -n "$PYPI_PKGS" ; then PYLIB=$($PYTHON -c 'import sysconfig; print(sysconfig.get_path("stdlib"))'); rm -f $PYLIB/EXTERNALLY-MANAGED; $PIP3 install --break-system-packages $PYPI_PKGS ; fi
   script:
     - mkdir build
-- 
2.47.3


