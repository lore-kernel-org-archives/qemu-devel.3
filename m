Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9381FC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg1g5-0006Qd-4I; Thu, 06 Feb 2025 08:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1fo-0005yl-20
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:12:04 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg1fm-0008Fg-2T
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:12:03 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso8949725e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 05:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738847520; x=1739452320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7ZKmE4pAQbvMAY+EPowVqHDnkT3H+9xilMSzO1l4tA=;
 b=Cg8ZJB3ZAbT1fnRhl+okfcm3D1zqZ6pGs+bX9A8bu+PgqDDL7QkRcDcwdz9aQB9uRl
 FmAaWRbu7ZC/uA6xgNeIQxzyEVNHNJJgVg9fM8tfhmbWn7O3nd4xNWvbFIZlG534bN8w
 LFrhA3rt1jCbX+rSbcRlQa03AVNQDhmb5idYQXdr8I9qQ8owGqjrI87IjfT3eqmGgx5q
 Ajyav9/OAWM9ODSdJDmOwqB5CjSe8uAfBXR4GD8NyZX2lB8eYkFS8i3Yx71ak5/j3J1K
 v/K35iSaBUEqPJYIzkTFP+HrBqKBnA+/CwpvI0Qgp4ia5ZxTefGlE8selObZbe3HAxcS
 zRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738847520; x=1739452320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x7ZKmE4pAQbvMAY+EPowVqHDnkT3H+9xilMSzO1l4tA=;
 b=dY+9fNxqhZFkEVz5n5UL8s/j9nmqcNDnUKM+91O8Cc5MuqeRufJiI9g2iQBrwt5QdF
 qa2j5Zxey9iux9vWfWtUHDfpvrYFnpbiKcI0jrpFaXmj/OaQkDBFPq+QPaRs9Icqtmej
 4KaBiI0KbJdep3rp0F1os/4v4wKO85ZF/TxQZ3k4U654GPurbcpoJ5OybpXNppJ9eNsR
 vgFSq3+btAMsFllhINJWiKd2qXm4UdRgWpQHLz/SdcL0M+yHERPiZP9/tDL5BapJq+xh
 nGgvSS2CoOXe/eCZGU1Rd6ZtmDWqXPSkBGW4yCxx9hWikIjUpK3GsSzkuvuKPgntpNNH
 aaUg==
X-Gm-Message-State: AOJu0YwjNn3a2xYlxWVNCzl/0/bf+8aYOfoobwIBD5Z0KAZZ9H9hjiEF
 dOyFfIOiUGjZJdbAD3m87QHPMW3CCDIHbut7cXYlN3wRoJ3Jys6zshQMQry8GERQCeC+cn4kscc
 K8BE=
X-Gm-Gg: ASbGncvaRaHf9joRmo676lu9hjJTS2vJuLIJX2rJ9js1zF5XxyNaEGwc9Jy+kKzafQj
 8gkwkuxSVoB4S1qQLyjxxVGvugGjx1Br+AcQFxh13eskI6OVvGR4wHvKqmMWyNVJQuchN9RZW4K
 DkiHMeXzzfaRrTv91eAcZl7xliokHsiezPUMo/8IeHkzerR+GyW5u8/X0ghB64liOehGGxwmgSF
 8bEL6saUKQ0jPAU3iJSnuzKb9b3M7WRplTiZZOqPVH1gvxaSlGT5uJ1nIhklvpvOrjE93l4ZVvo
 BlxSAGwmfWbpE2jhTwAgYIvoxr94uccfWghF9Yfk7GqLHW/GF4qCtCMIk9TQ14dfzQ==
X-Google-Smtp-Source: AGHT+IHC152uCKIQDfoajUQqHatw/skYiwMjx8h1IvKRHdHIzKgFMGSTKv6Pxq13ERxnolFAHtXiRQ==
X-Received: by 2002:a05:600c:3b0f:b0:434:e9ee:c2d with SMTP id
 5b1f17b1804b1-4390d56c256mr44772755e9.26.1738847519976; 
 Thu, 06 Feb 2025 05:11:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfc8a4asm19220435e9.32.2025.02.06.05.11.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 05:11:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 13/16] tests/functional: Allow microblaze tests to take a
 machine name argument
Date: Thu,  6 Feb 2025 14:10:49 +0100
Message-ID: <20250206131052.30207-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206131052.30207-1-philmd@linaro.org>
References: <20250206131052.30207-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
index 5d353dba5d2..715ef3f79ac 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -21,9 +21,9 @@ class MicroblazeelMachine(QemuSystemTest):
         ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
         'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
 
-    def test_microblazeel_s3adsp1800_le(self):
+    def do_xmaton_le_test(self, machine):
         self.require_netdev('user')
-        self.set_machine('petalogix-s3adsp1800')
+        self.set_machine(machine)
         self.archive_extract(self.ASSET_IMAGE_LE)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.scratch_file('day13', 'xmaton.bin'))
@@ -38,5 +38,8 @@ def test_microblazeel_s3adsp1800_le(self):
                 'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
                 '821cd3cab8efd16ad6ee5acc3642a8ea')
 
+    def test_microblaze_s3adsp1800_legacy_le(self):
+        self.do_xmaton_le_test('petalogix-s3adsp1800')
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.47.1


