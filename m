Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFBDC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiArx-0006bB-ED; Wed, 12 Feb 2025 06:25:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiAra-0006OK-7h
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:25:08 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiArV-0004f9-WB
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:25:05 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43946b5920cso21211065e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739359500; x=1739964300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhuBVUlLscLfkf9l122Veq4MQDhOCQ9wVWqjNr9jN1s=;
 b=U/xBDP2ZgQKBjMaDafrv01h7WDoOE8SusPpl78M1hRsR/qRKYJsYzt7mUOe5eOXHLH
 Mb2Be5o+cEZ56JBM3vilwqCEXuTpVsQktViFiBqn+qjfh41CeWdyDpnYMw652ByhnC+p
 /VmNR8Y1niIrlREjTyf7CNvc9DRdtvnvctfz9tPHW2DJ5qYxfuHpSZTPEczD5ylu9TJw
 xe5+FfFbaJ21xCSDWKqRws1lujmki6VhW2L7pTCDMVWrrGgNKSd2kfGuFWMFtKeflRMZ
 yAaTNJYna0bW+0GlyZcNgHn8Bz8vhAbeVewMvJ4I9YMhhsNR8aBv80Nb7QNt9X8QMPMg
 Gliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739359500; x=1739964300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MhuBVUlLscLfkf9l122Veq4MQDhOCQ9wVWqjNr9jN1s=;
 b=n68MZF9f8JfoDrwSjNYkawW+y98WP4cwXDGauNqS4eX0ZhwV/2hX+W8za0ahQsJfzE
 RGKmrRiZomuNE4lk5iK2natTe0gtQWoI+uCD8MhUPd6A1Zt7y3IqX7wOIMr2mHPhcaNo
 PWsclVZW7EzZWXw6RlTxfuASxLfW/gm3NwjmR9ddc/Z1LqbDwZ6s9ldLlxC5xpx1jJDn
 aEJvgfPlGQ059iHdkmXkvzT1mdjHV96o7a6vx0WQn2GP4cJiA/fhOs7hF4sK7JVqPl7u
 J4d3dlR9RinLP50vbGpb8Pofi8MkGrZAc88xMUnfHHgQrI/HXTJ/aNecJ0LwkbEtdOrg
 LafA==
X-Gm-Message-State: AOJu0YwqAP2HuI7d+pIgO+NP0T4S56j9jc6OhRI0sfH170PduQ6qZEmA
 uXz0h9++DwGrcTSXFZuabPJlnr+MUF3Php658SX0R7ELZ8QZ6LNq1eDOxSP6P+rmQ8bYSM394Bg
 mOjw=
X-Gm-Gg: ASbGnctK5dshcQjxa9MAYOL2JHjPCYJ4bGsfQAAPAMs0kogNVaD/fWka11tqeDIiTLk
 ei9idVI09p6ZiE6C8MYpYshKgKRZ4EUHQCV4Dq2OgoRhHO072ogSVfqYPkCwwPNIQ19DfByf39t
 btRtjLC7nhDVFRRItEoL6yz1j25pKfLknczfBsgCr1qNZ4GRZ0KdLYd2J7kTZILdXQg3Lw6dF1E
 S7fXcl2P/2Iy7WkQLUwqfcOKTUNmG1czQqcwRAI3Eu9Yzh6P73t4irK7HjYm0JvIxEOPIUl+OaD
 I2XJ+ex+qhJ58pRO2L/8zLTPkVxT5xmj5tmIbZVew1On/EgtmbHDceA8ozxk4utKKg==
X-Google-Smtp-Source: AGHT+IFNbenNg2ezwDkDetjPoyqAtJl6uIXm1ro9nwaiUhYNxBUuY4yhMikrnLpfvft3dcXWTWxKLA==
X-Received: by 2002:a05:600c:35cc:b0:439:4499:54de with SMTP id
 5b1f17b1804b1-439581d491fmr28471535e9.31.1739359498948; 
 Wed, 12 Feb 2025 03:24:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a07a8f2sm16646805e9.38.2025.02.12.03.24.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 03:24:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 09/11] tests/functional: Allow microblaze tests to take a
 machine name argument
Date: Wed, 12 Feb 2025 12:24:11 +0100
Message-ID: <20250212112413.37553-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212112413.37553-1-philmd@linaro.org>
References: <20250212112413.37553-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Make microblaze tests a bit more generic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250206131052.30207-14-philmd@linaro.org>
---
 tests/functional/test_microblaze_s3adsp1800.py   | 7 +++++--
 tests/functional/test_microblazeel_s3adsp1800.py | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index fac364b1ea9..c4226f49cf3 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -20,8 +20,8 @@ class MicroblazeMachine(QemuSystemTest):
          'day17.tar.xz'),
         '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
 
-    def test_microblaze_s3adsp1800_be(self):
-        self.set_machine('petalogix-s3adsp1800')
+    def do_ballerina_be_test(self, machine):
+        self.set_machine(machine)
         self.archive_extract(self.ASSET_IMAGE_BE)
         self.vm.set_console()
         self.vm.add_args('-kernel',
@@ -34,5 +34,8 @@ def test_microblaze_s3adsp1800_be(self):
         # message, that's why we don't test for a later string here. This
         # needs some investigation by a microblaze wizard one day...
 
+    def test_microblaze_s3adsp1800_legacy_be(self):
+        self.do_ballerina_be_test('petalogix-s3adsp1800')
+
 if __name__ == '__main__':
     QemuSystemTest.main()
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index ccebf5c2ce1..1f0812eec63 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -22,9 +22,9 @@ class MicroblazeelMachine(QemuSystemTest):
          'day05.tar.xz'),
         'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
 
-    def test_microblazeel_s3adsp1800_le(self):
+    def do_xmaton_le_test(self, machine):
         self.require_netdev('user')
-        self.set_machine('petalogix-s3adsp1800')
+        self.set_machine(machine)
         self.archive_extract(self.ASSET_IMAGE_LE)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.scratch_file('day13', 'xmaton.bin'))
@@ -39,5 +39,8 @@ def test_microblazeel_s3adsp1800_le(self):
                 'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
                 '821cd3cab8efd16ad6ee5acc3642a8ea')
 
+    def test_microblaze_s3adsp1800_legacy_le(self):
+        self.do_xmaton_le_test('petalogix-s3adsp1800')
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.47.1


