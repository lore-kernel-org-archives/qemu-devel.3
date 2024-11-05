Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D24DD2B920
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8JHi-0001UM-Se; Tue, 05 Nov 2024 08:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JHg-0001O7-Pl
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:07:48 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JHe-0002mE-UY
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:07:48 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37d49ffaba6so3682886f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730812065; x=1731416865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iGrQLs85iCO+ooJQZbg2Q0E0dHdOyXnWOUnrVx9dt/s=;
 b=p7UplYsopUDrR9bQxsQNNf+/ABPKai0G9SUQzGaxakVA0i3Hw1E3tMNfKLrDZss9gs
 WPahsSIx77KwVxoTR52QGinkc3yXybT+iemMPAtf+6noc2pizCKVXocVlacJk1VhU5rY
 9YSapTsr6/I/APXYiofkKYeaNvSoidtdH+e5kARVviPu+t/QEj996gLQZr0PCz4kYgPV
 3S06D9wbojiHpisMrXE/JFZ2dGnMGkWH1bkdjQFDWd3CPwAdKbcDYF9RoS0R6NDrNH+l
 2G08yqBg8j07H/Qt1KlT5G1c8MePkBmqAyyO5AwYwdtr3xSbSIGrd4a3AgF3BiLHVXJF
 tl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730812065; x=1731416865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iGrQLs85iCO+ooJQZbg2Q0E0dHdOyXnWOUnrVx9dt/s=;
 b=eaiaVrhJinvJbma4FehrQxXWeiQDIxnzukoIOeQeyen7VTNrsCXiZGBHtAAJ9iPySf
 96awT/Ye94XemdXKDoYlWiaP7XOYeEE4THvqVi0vQpHHHiG7kibqc4nhteWr+bO2UWTg
 nukvfyoVbY2q2/tmvoMET+t+A2lZDKc35gmjLqPbDG2gasoYB7xuZfIjmrbp/5H1xxvy
 LItH19NthJeH0nLHBkSOPDTkTEBr8aVjMgN6+njx3ucnVF4FYulRM2w6xQK3VIjWusaY
 H/EYl0kN6f6fkmOaXQs1+0qztOMkhwxXG84UsylsxFT+2shz2ZZstTPyPfYrhx8ui473
 ZgDA==
X-Gm-Message-State: AOJu0Ywb/gpQeL1ebEFwjqyh3w5v1Yq9hvC9kWgDsEf1569uetlF/huH
 TpNJlW211TUSzvtqkQUriHep358Al4/oVGcq2VWpzhX14y0WoTf3cvftrpwkaOHCy30FseCsjOR
 3uFw=
X-Google-Smtp-Source: AGHT+IFBVQj24hPaYJq+c06qyzVA+HQtRRHQ9ExIDQjWpx2JTxCgRcyMOYt+iiZiAtz/GgVm7Ul8Gw==
X-Received: by 2002:adf:f802:0:b0:37c:d2f3:b3af with SMTP id
 ffacd0b85a97d-381b705688bmr15321823f8f.5.1730812065186; 
 Tue, 05 Nov 2024 05:07:45 -0800 (PST)
Received: from localhost.localdomain (86.red-88-29-160.dynamicip.rima-tde.net.
 [88.29.160.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d439esm16225993f8f.44.2024.11.05.05.07.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 05:07:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 19/19] tests/functional: Add microblaze cross-endianness tests
Date: Tue,  5 Nov 2024 14:04:31 +0100
Message-ID: <20241105130431.22564-20-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105130431.22564-1-philmd@linaro.org>
References: <20241105130431.22564-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Copy/paste the current tests, but call the opposite endianness
machines, testing:
- petalogix-s3adsp1800-le machine (little-endian CPU) on the
  qemu-system-microblaze binary (big-endian)
- petalogix-s3adsp1800-be machine (big-endian CPU) on the
  qemu-system-microblazeel binary (little-endian).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Clever refactor left for later
---
 .../functional/test_microblaze_s3adsp1800.py  | 21 +++++++++++++++++++
 .../test_microblazeel_s3adsp1800.py           | 19 +++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index 2b2f7822707..7f5e8b6024f 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -36,5 +36,26 @@ def test_microblaze_s3adsp1800_be(self):
         # message, that's why we don't test for a later string here. This
         # needs some investigation by a microblaze wizard one day...
 
+    ASSET_IMAGE_LE = Asset(
+        ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
+        'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
+
+    def test_microblaze_s3adsp1800_le(self):
+        self.require_netdev('user')
+        self.set_machine('petalogix-s3adsp1800-le')
+        file_path = self.ASSET_IMAGE_LE.fetch()
+        archive_extract(file_path, self.workdir)
+        self.vm.set_console()
+        self.vm.add_args('-kernel', self.workdir + '/day13/xmaton.bin')
+        self.vm.add_args('-nic', 'user,tftp=' + self.workdir + '/day13/')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'QEMU Advent Calendar 2023')
+        time.sleep(0.1)
+        exec_command(self, 'root')
+        time.sleep(0.1)
+        exec_command_and_wait_for_pattern(self,
+                'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
+                '821cd3cab8efd16ad6ee5acc3642a8ea')
+
 if __name__ == '__main__':
     QemuSystemTest.main()
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index 1aee5149fb1..60543009bab 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -38,5 +38,24 @@ def test_microblazeel_s3adsp1800_le(self):
                 'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
                 '821cd3cab8efd16ad6ee5acc3642a8ea')
 
+    ASSET_IMAGE_BE = Asset(
+        ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
+         'day17.tar.xz'),
+        '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
+
+    def test_microblazeel_s3adsp1800_be(self):
+        self.set_machine('petalogix-s3adsp1800-be')
+        file_path = self.ASSET_IMAGE_BE.fetch()
+        archive_extract(file_path, self.workdir)
+        self.vm.set_console()
+        self.vm.add_args('-kernel', self.workdir + '/day17/ballerina.bin')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'This architecture does not have '
+                                       'kernel memory protection')
+        # Note:
+        # The kernel sometimes gets stuck after the "This architecture ..."
+        # message, that's why we don't test for a later string here. This
+        # needs some investigation by a microblaze wizard one day...
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.45.2


