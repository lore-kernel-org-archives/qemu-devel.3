Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB75C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSl-0005oq-Ic; Tue, 01 Jul 2025 13:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSi-0005lj-QV
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:08:04 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSh-0003jG-0t
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:08:04 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a6d77b43c9so3260780f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389680; x=1751994480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HBsbE/TrRmGaC5yb0jy251zZHsHyCp+NU1gxrZ4fEQc=;
 b=dk1faEvkJn0n191P5mUjvN3EtCG8SXBkPoKlfQYMPKQYfCGU9lTM2z4Dtx+FPYaMpy
 w80jkd3EDQDcpFhPsQZarraj/0IvqKqg+h19ImS3neytaBJ0/pgEhLEbk8ZEErXK34NB
 g1jbli9KBLTK6voyRVTSTfe4O5hQNbxtFqRvZpxX3MhOdl5f6G3Lc48XYlTuWalupnnh
 kUrHr7TEm9KgiL95HnnvAS881maolQ16zzEhP0G2I967RQWLMHiIYUiJXX8YJt3MR5VQ
 j2gcJiTe8r897Osqbm0N76eAkfd3pkyzlyTHw0HZOZ91Zpwj4mBuuZ+5q4XzNj/0xeSj
 UO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389680; x=1751994480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HBsbE/TrRmGaC5yb0jy251zZHsHyCp+NU1gxrZ4fEQc=;
 b=hhpc2CP9wAqJ4KtO2xMpAoBgIbTkyKXggPo92+/o1+6dh1tj8Ybs69s1qv/cygZ+3/
 5BgN7E1fNg8zngqDgh3oz+8LkJmozhnACCG+V/n4blnkZdcPRbMUAyMt/3vbpbTmaiZ3
 wXqB+9khAkyFYDYpDJtgHu8hWtUW9Ve1DoFenO9q6iE+4ci2UyBTfauMNidmL5Y3MAp3
 7yUmlu4T2j6yOLMS2ZbW6qNljohiiEyhLj2V3UZ+mra1NknGjlio+Qx5zG3EZVI9IPD3
 7BPyuBXr8AdnupGDG8S2/7W0s8Xa7ODJHRLNJ5n5Cddoo+vo/V3vQex92kLS1oR44Avn
 AQQg==
X-Gm-Message-State: AOJu0YzCE9eQtw+PdEu/B9XUYcEEL1lYbYWMTbJF4BoqPP/c2MCKn4GH
 3Rh3Fe0LcOMR6SSmGdlEPzLaSvSGZYY5ZKsy9EVR3j8QJXBc/8LJvHtWazySyYkP7w3OReh/Rsk
 +DqCm
X-Gm-Gg: ASbGncvnimci7Q+CerRCagSS78635eMoY6WJEyRfDDWN89jSvor1eXXG/SVigrlfMF2
 6lCPPfC1mY90bLKxgVw5rHMhQ5IWZY3o6l/FaEUQx2whXSHCNDuSps4o1ReSMCIfZkIJSLRxg7o
 MwvHP+x6bxq8WYw8prgDRFU2WlESKfgPnPUkXHIXGMk18S9kvWPyTm/c4xzyPl+N8FKCzin8jag
 7vwphXtXEdgJWiidyS+0JliEAKdtq23QtffmGsDV8F9V6J3BIx9NRE0SY6W7KbBNz+Y9sffyyvP
 mACnPlYcNhZJUgfCwGCVD1EDtfr2LaavRDJjx8pZzia0uB2ziRZ/+IbLgrswoZX1pCtJ
X-Google-Smtp-Source: AGHT+IGSZnTZogZAyPgZhEeHePSmiz0VLWq9qw/f0pkMc1JFKNcAJY5Y4w6IolKl/peXK2qaKfGfEQ==
X-Received: by 2002:a05:6000:4a09:b0:3a4:f7dd:234b with SMTP id
 ffacd0b85a97d-3a8e842ffdbmr14608690f8f.0.1751389679806; 
 Tue, 01 Jul 2025 10:07:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/43] tests/functional: Set sbsa-ref machine type in each test
 function
Date: Tue,  1 Jul 2025 18:07:14 +0100
Message-ID: <20250701170720.4072660-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

fetch_firmware() is only about fetching firmware.
Set the machine type and its default console in
test_sbsaref_edk2_firmware().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Message-id: 20250623121845.7214-23-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/test_aarch64_sbsaref.py         | 5 +++--
 tests/functional/test_aarch64_sbsaref_alpine.py  | 3 ++-
 tests/functional/test_aarch64_sbsaref_freebsd.py | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
index e6a55aecfac..d3402f5080a 100755
--- a/tests/functional/test_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -40,8 +40,6 @@ def fetch_firmware(test):
         with open(path, "ab+") as fd:
             fd.truncate(256 << 20)  # Expand volumes to 256MiB
 
-    test.set_machine('sbsa-ref')
-    test.vm.set_console()
     test.vm.add_args(
         "-drive", f"if=pflash,file={fs0_path},format=raw",
         "-drive", f"if=pflash,file={fs1_path},format=raw",
@@ -68,8 +66,11 @@ class Aarch64SbsarefMachine(QemuSystemTest):
 
     def test_sbsaref_edk2_firmware(self):
 
+        self.set_machine('sbsa-ref')
+
         fetch_firmware(self)
 
+        self.vm.set_console()
         self.vm.add_args('-cpu', 'cortex-a57')
         self.vm.launch()
 
diff --git a/tests/functional/test_aarch64_sbsaref_alpine.py b/tests/functional/test_aarch64_sbsaref_alpine.py
index 6108ec65a54..87769993831 100755
--- a/tests/functional/test_aarch64_sbsaref_alpine.py
+++ b/tests/functional/test_aarch64_sbsaref_alpine.py
@@ -26,8 +26,9 @@ class Aarch64SbsarefAlpine(QemuSystemTest):
     # We only boot a whole OS for the current top level CPU and GIC
     # Other test profiles should use more minimal boots
     def boot_alpine_linux(self, cpu=None):
-        fetch_firmware(self)
+        self.set_machine('sbsa-ref')
 
+        fetch_firmware(self)
         iso_path = self.ASSET_ALPINE_ISO.fetch()
 
         self.vm.set_console()
diff --git a/tests/functional/test_aarch64_sbsaref_freebsd.py b/tests/functional/test_aarch64_sbsaref_freebsd.py
index 26dfc5878bb..3cddc082f3b 100755
--- a/tests/functional/test_aarch64_sbsaref_freebsd.py
+++ b/tests/functional/test_aarch64_sbsaref_freebsd.py
@@ -26,8 +26,9 @@ class Aarch64SbsarefFreeBSD(QemuSystemTest):
     # We only boot a whole OS for the current top level CPU and GIC
     # Other test profiles should use more minimal boots
     def boot_freebsd14(self, cpu=None):
-        fetch_firmware(self)
+        self.set_machine('sbsa-ref')
 
+        fetch_firmware(self)
         img_path = self.ASSET_FREEBSD_ISO.fetch()
 
         self.vm.set_console()
-- 
2.43.0


