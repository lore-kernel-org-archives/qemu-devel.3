Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE13C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thae9-0004uk-Mn; Mon, 10 Feb 2025 15:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thads-0004IA-GH
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:37 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thadm-0003x9-Tq
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:32 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38dd011ff8bso2652244f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220265; x=1739825065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAgkBkMy3/LPbRfDSn29phwowCLY9R3s4x7aKYfP9pA=;
 b=cSwkSGJ3VJ0Onp1T9fACCNdlc1oJICx4Ab3+CFJQzg7OTEDpwS56FsLErN9aecjgNo
 jJoxe3s3qb5I4Mq0d3UgWzppZsku42Gk1VMaBwVydu2pgvS1iWWnmX9TGavsEJBs1ocr
 8nGKseIt8ZyIvHLh0mo7BEKzM/AylzVPSlVVbl4iEWcWxsNiiBkHidYQNaqUtyYcmWDx
 aV43ZPSxFp9rjwWcIT8FpV5suXw+2XCJn+wNr9vNPMw+FT8TmyPDiS1vgHhD/78e6gqL
 uOLjSH0yhbO8xAk5ZAc4FP2+XHu3ZLr02pTc45EkG+RR7g47TDmndDnFB9C8OZVb5IjI
 lbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220265; x=1739825065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GAgkBkMy3/LPbRfDSn29phwowCLY9R3s4x7aKYfP9pA=;
 b=sluGHy34slgr06UzXgeLmuqnS/U8JoaH1FZzj2J5lwXFOkePoueDQpaPAYlgVmmPhJ
 NaNgVOeLTqmTf1I6umyiNgVwO7q70rQBi4eIQb1AlID78VZgOAkKYHzhd7FzGQQ+fZPq
 5n+ji/g/l6E4T/TpW5NZfoplY0vrtfXTKJwrXsQ679/v+6FSCikvRWoWSVDYYDr8b7q7
 hzhfTCKCJxg/KX3o8PwmTa7UFe1j7oZsBtWJkAzt/HeMwzJ/BRiE8cwNHh89w2RV8Rx7
 IruFsO9xW5dE3j37H490zevhmLDkDL+Ft4C0URyYkOXxvd6cBv/9CbPe7hdU99b1upKU
 TJRQ==
X-Gm-Message-State: AOJu0YzR0/q2XxvPZek4CpX2tmLnqXxfaPmiY2o+KiOlZLFlySzffxBL
 Y+RC4+9EQdUXT/EHENuvYFscFM/IOW1okRobTgka5gVD4x8nNBSz0glvnUYUihZDnWLopOyZWbF
 OtFM=
X-Gm-Gg: ASbGncsV6pOztFAw1WYwN2MI7eTuQf354eP88G+NTjdQSA35bWtXr9tU9Vz7YW0nsJj
 snDRbzfpV0R9q1ujaqOJ1o8wLvXRHPOwY6fVd1FWz0nJ/u7uAfdU1g4pKE2VvwSOBifvZPRK1U1
 tLVoxNe9qtG4/EneS+aB8mZ7MV4AtJsttRguLvEtdbBj6fWjAEZV1k74UoBfFLdjRGvWl+UnOC1
 GORHFQDADerpnFx5ZUPUQtzbl/zU6x1LAzsHhwTw7yVXHmHSrjFqDFL2SlBU1Qyd/VTMdxs75pn
 P2EHzMTGJpjwOq9QkvE+BsckvbO2ZRKJq1KiIB/LiDMQIAIm3f0/dEVF2owPfCivYw==
X-Google-Smtp-Source: AGHT+IHBC9EcScR2dacwsrw3VcH0REIrGLYp1M5/tZd5XwG8NrDOyO/HJXBx7hHssuJcQ/0tN0riNw==
X-Received: by 2002:a05:6000:400f:b0:38c:5bb2:b932 with SMTP id
 ffacd0b85a97d-38dc8da64damr11344551f8f.3.1739220264841; 
 Mon, 10 Feb 2025 12:44:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc565d62dsm11908055f8f.93.2025.02.10.12.44.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:44:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 27/32] tests/functional: Explicit endianness of microblaze
 assets
Date: Mon, 10 Feb 2025 21:41:59 +0100
Message-ID: <20250210204204.54407-28-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

The archive used in test_microblaze_s3adsp1800.py (testing a
big-endian target) contains a big-endian kernel. Rename using
the _BE suffix.

Similarly, the archive in test_microblazeel_s3adsp1800 (testing
a little-endian target) contains a little-endian kernel. Rename
using _LE suffix.

These changes will help when adding cross-endian kernel tests.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250206131052.30207-13-philmd@linaro.org>
---
 tests/functional/test_microblaze_s3adsp1800.py   | 6 +++---
 tests/functional/test_microblazeel_s3adsp1800.py | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index 2c4464bd05a..fac364b1ea9 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -15,14 +15,14 @@ class MicroblazeMachine(QemuSystemTest):
 
     timeout = 90
 
-    ASSET_IMAGE = Asset(
+    ASSET_IMAGE_BE = Asset(
         ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
          'day17.tar.xz'),
         '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
 
-    def test_microblaze_s3adsp1800(self):
+    def test_microblaze_s3adsp1800_be(self):
         self.set_machine('petalogix-s3adsp1800')
-        self.archive_extract(self.ASSET_IMAGE)
+        self.archive_extract(self.ASSET_IMAGE_BE)
         self.vm.set_console()
         self.vm.add_args('-kernel',
                          self.scratch_file('day17', 'ballerina.bin'))
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index c382afe6bfa..5d353dba5d2 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -17,14 +17,14 @@ class MicroblazeelMachine(QemuSystemTest):
 
     timeout = 90
 
-    ASSET_IMAGE = Asset(
+    ASSET_IMAGE_LE = Asset(
         ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
         'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
 
-    def test_microblazeel_s3adsp1800(self):
+    def test_microblazeel_s3adsp1800_le(self):
         self.require_netdev('user')
         self.set_machine('petalogix-s3adsp1800')
-        self.archive_extract(self.ASSET_IMAGE)
+        self.archive_extract(self.ASSET_IMAGE_LE)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.scratch_file('day13', 'xmaton.bin'))
         tftproot = self.scratch_file('day13')
-- 
2.47.1


