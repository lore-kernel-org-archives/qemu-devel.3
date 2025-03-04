Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799DFC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpagw-0005Kx-Rd; Tue, 04 Mar 2025 17:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpagu-0005Ja-KF
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:44 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpags-0006T7-OQ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:44 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so947508766b.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127081; x=1741731881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/V8FHPuhrbSfKCzVBzyT2YXGRtU+MVGBZXlL9rDafTM=;
 b=Hcajr0O9mCscbNwq+1EvprKepCi3H+mPci4RUVJfe9YigU3+CsP0lXaE11IH7XTJBJ
 x+jrNMzkUwLIpPFFMOEs8orZL+DhvJf8n5j4vxC1e8J2yKfzjtkEQzqN0MS77Dtw5wWV
 rJey7oThFOWWQzHC8QP8HrBnHjw97pqRWRqPecVedFdQ0lkpE5yosWC+XzjDQqv6HrAm
 H+pyeHbzqcZ8wsR+92QZPgbeNdlZFB2n/LAJaki5n8ulJTK90aeUikhBaJakeUKTsSzY
 6G6/7YPlHt/3ZVisvH62sgZrlU55yXuoQC1cK/3GPkzsYmAx9WSv1/fWRoHTaOvWNZK+
 PSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127081; x=1741731881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/V8FHPuhrbSfKCzVBzyT2YXGRtU+MVGBZXlL9rDafTM=;
 b=btZa5oexL45szLYzRN0L8pPQghWc4G/9QENA9u4tsZ5BBozv67/8ri5MyO967/1m4D
 2MFy6Om7YrTpZY/2hJU9fzFE1usHfSH9KOJGPUaxkXugvlBE97+uuswRf2nNzZEvM/oH
 f4Lt3ojpi9g3gwZlkst0QjvfKVn+K9sYinqUp0TW7YHShUkiL/IlP0zMX/L088bd4jTP
 AKJaKksDnjDHEAd0zcXSJpdfBLasTaU2eT0C0c7GusvUjC6i3ZnXv3HOOTNba3M2dTgm
 7b9l+pJU9DRK1wJkEqN0/o3gIcnQZxXWG0xS4CvN+VTUMVWz1rIdrHa7PzPzprcp13Kj
 sA5Q==
X-Gm-Message-State: AOJu0YwFlzdP6YM9fRESPwWwecc6Jk049C/mjEWASzA6bie9y/WZEtlo
 /ME+8P6a1rEYvghcGsVRyX84VLDdDUL8eVRgmmtARxPxFE5QOMr9Jtcg2Yue6fI=
X-Gm-Gg: ASbGncuWWm+B3R4d9aylwVzEW2o2q7jlyabd6jecToGaDRZl5VN7RIt4aC2KOG2BW/Z
 oaVB3lbvZZlZkT0PgnNOS07itrW2EmN1ZsJZKKOm2trjeC0OVVaL9u3G2TatV0W9KiEqDiG0xH6
 poNr6g0iWCnhSVmNCIzStX4HdsvYLu8IIXjSNPsJC1m5+EX7WsKAq48fwE3RHo6x8Tbla3Nt242
 r/Yvd/auDF6onPM0VERy3EIEyayFB6GzDqEzlKd+9MZH3dYLO337VEAPQmwafwyeTTIsTqZ6uew
 aCXZhDrCfo+4IM23dfA66MVH6ofzzsEZM/VBtOcsqncxgag=
X-Google-Smtp-Source: AGHT+IF2D0GLRCiEgtZWJCPuCGwqnqeBj/pIBv6N+zpFdxHn7R8pAb7U2fR39P+t3Y0ny4y9pK9V4A==
X-Received: by 2002:a17:907:2d1e:b0:abf:6d24:10c8 with SMTP id
 a640c23a62f3a-ac20daff0d0mr73564066b.53.1741127080975; 
 Tue, 04 Mar 2025 14:24:40 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf75c6d4f3sm441451566b.184.2025.03.04.14.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:24:40 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BDE4F5FCAA;
 Tue,  4 Mar 2025 22:24:39 +0000 (GMT)
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
Subject: [PATCH v2 04/32] tests/functional: bail early if vkmark hangs
Date: Tue,  4 Mar 2025 22:24:11 +0000
Message-Id: <20250304222439.2035603-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

The message:

  MESA-VIRTIO: debug: stuck in fence wait with iter at %d

Seems to occur more often on debug builds. Rather than waiting for our
long timeout to hit we might as well bail as soon as we see the
message.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/test_aarch64_virt_gpu.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index 4420a6175f..7d7749e243 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -78,7 +78,7 @@ def _launch_virt_gpu(self, gpu_device):
         self.wait_for_console_pattern('buildroot login:')
         ec_and_wait(self, 'root', '#')
 
-    def _run_virt_weston_test(self, cmd):
+    def _run_virt_weston_test(self, cmd, fail = None):
 
         # make it easier to detect successful return to shell
         PS1 = 'RES=[$?] # '
@@ -87,7 +87,7 @@ def _run_virt_weston_test(self, cmd):
         ec_and_wait(self, 'export XDG_RUNTIME_DIR=/tmp', '#')
         ec_and_wait(self, f"export PS1='{PS1}'", OK_CMD)
         full_cmd = f"weston -B headless --renderer gl --shell kiosk -- {cmd}"
-        ec_and_wait(self, full_cmd, OK_CMD)
+        ec_and_wait(self, full_cmd, OK_CMD, fail)
 
     @skipIfMissingCommands('zstd')
     def test_aarch64_virt_with_vulkan_gpu(self):
@@ -95,7 +95,9 @@ def test_aarch64_virt_with_vulkan_gpu(self):
         self.require_device('virtio-gpu-gl-pci')
 
         self._launch_virt_gpu("virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
-        self._run_virt_weston_test("vkmark -b:duration=1.0")
+        self._run_virt_weston_test("vkmark -b:duration=1.0",
+                                   "debug: stuck in fence wait with iter at")
+
 
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.39.5


