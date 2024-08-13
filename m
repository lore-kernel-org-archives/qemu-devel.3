Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7BAC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 20:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdy49-0007PM-VN; Tue, 13 Aug 2024 16:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3y-0006SU-Qx
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:24:16 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sdy3W-0006JO-KE
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 16:24:13 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-428e3129851so43533685e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 13:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723580624; x=1724185424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=adw5jgjlcSpxCkpQ0j60omHvD1nnW2G6iyfdsNi8jbw=;
 b=MYkkzsH/E/Qb2UFxTysypbI9nFuNmx9kCmmoleBeS09BLk4xtYylR7RdOcxO6jhZrD
 SuKU6ueXJMk1se/OHjjZMQJniwHVAedEYJwsiJKxMq2fAloJzvr8Br4ex9PzH0ZD6hTQ
 I2DRfi1bI6MbIDJF7TrsAioJVGSqNr9W5JlLFuOSC3bujZZSvaOkB0t0R23q7c5kzUrg
 cDiTtn6+0I2J4J4ZsmO9qtb+Dn1KHCUrR/YgBGXIbqquyeWeAYCRPrwDckPzrHLm8eTZ
 Y4unkdv17TC05RcFJzoOht2V2LZWJD4EjU+z5vvPMf02sitHtr2zGqsIB1h8vkKRb/VL
 p9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723580624; x=1724185424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=adw5jgjlcSpxCkpQ0j60omHvD1nnW2G6iyfdsNi8jbw=;
 b=RzWTBCXxsO6KATMCqRIrXXmRlkdUld+yBHE5bf48TR2R8dIkMmEV787p3mJJpM0ahB
 Ji9tE3826+h7uhNeIVAO1UwjssmbF3YgPxJYeMywJr0rdlvVUPQVxiU65ED+5eOvhwaJ
 km9KmAbHL+2EA6p1+Fq0duX5vrkiYK5RPW6DgFESEHqAog2GBuCxohqul/90BGK1gzcD
 ARendNhQgowRAvi58It58vcm4TLSSQWL3fuzVw23v64OqjNh9yquSN03voULk71HRoVL
 X+iJNC28iX3VsGSjFp0cUlYigJaA/Ten7p0zpmJfMjITWNTFTSkK6clbEKAj+CozkOPt
 GlFA==
X-Gm-Message-State: AOJu0YxbtO89/pNcu7Er0MM5qheKMcYajmzxYfOh+RyMTaP0Fs5DXIM9
 bB101cbFDtl6zND/0BGD74bpcfkcGW8IiXg0TY9tsWPZ7GG5+ywZaDdRYmQ8pdM=
X-Google-Smtp-Source: AGHT+IG7R5nUt3voA9dl50RQS5J1OR5JcDC2E5EFJj3IDJ1znrBpLKrB64HTTeltr6WwzmgpgEpd2Q==
X-Received: by 2002:a05:600c:1f13:b0:427:fa39:b0db with SMTP id
 5b1f17b1804b1-429dd264962mr4344725e9.27.1723580624219; 
 Tue, 13 Aug 2024 13:23:44 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c750e57fsm151122575e9.12.2024.08.13.13.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 13:23:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BEC405FE27;
 Tue, 13 Aug 2024 21:23:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Michael Roth <michael.roth@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Weiwei Li <liwei1518@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eric Auger <eric.auger@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Peter Xu <peterx@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 14/21] tests/avocado: replay_kernel.py add x86-64 q35
 machine test
Date: Tue, 13 Aug 2024 21:23:22 +0100
Message-Id: <20240813202329.1237572-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813202329.1237572-1-alex.bennee@linaro.org>
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

The x86-64 pc machine is flaky with record/replay, but q35 is more
stable. Add a q35 test to replay_kernel.py.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20240813050638.446172-7-npiggin@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/avocado/replay_kernel.py | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index a668af9d36..e22c200a36 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -110,7 +110,7 @@ def test_i386_pc(self):
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
     # See https://gitlab.com/qemu-project/qemu/-/issues/2094
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test sometimes gets stuck')
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'pc machine is unstable with replay')
     def test_x86_64_pc(self):
         """
         :avocado: tags=arch:x86_64
@@ -128,6 +128,22 @@ def test_x86_64_pc(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
+    def test_x86_64_q35(self):
+        """
+        :avocado: tags=arch:x86_64
+        :avocado: tags=machine:q35
+        """
+        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
+                      '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
+                      '/vmlinuz')
+        kernel_hash = '23bebd2680757891cf7adedb033532163a792495'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
+        console_pattern = 'VFS: Cannot open root device'
+
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
+
     def test_mips_malta(self):
         """
         :avocado: tags=arch:mips
-- 
2.39.2


