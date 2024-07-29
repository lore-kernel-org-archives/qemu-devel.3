Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96CBC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSIr-0000YX-0T; Mon, 29 Jul 2024 11:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSIp-0000Js-L4
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:28:47 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSIl-00009O-MF
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:28:47 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4266dc7591fso16448985e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722266922; x=1722871722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jz7Ox8GZ4fBgHa8IWcCtoxPXphT3ERQSEGlUxQOFD08=;
 b=Srp3SKyWWnt6FNQiXVpaec38d/YXtS4zyesfqtPrDgdzDHiVcvCUH5bZ5R4MMgUz41
 uBvSBPQZi/AjyIZkZhaMWK5FSH7lf04dCVZ0WAKuYcVbKejHxrZqWQQeGEsPUvpuQtAK
 5uHMc8CG9lKrlp+ZLHVZiNoyU1Xw6Bq1lFtsL4qkG/CLYN3ApUqgkbYJbCnUWbUNMaN0
 s1BjKCTia4v12S1dBjcskz7C++I7kD2kY1Q+9EHkGTPF9kQ1TFe54WbL7tgj2S9XiaMJ
 VNaMFXlF2GC4Qa3JPYXm4tAa5V9mOIXofGjVkmA9559fbMPA5a8imEaFtq9GRpRXZUL+
 6UDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266922; x=1722871722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jz7Ox8GZ4fBgHa8IWcCtoxPXphT3ERQSEGlUxQOFD08=;
 b=svjViJWLUDCYby85mp3MOVviUtTACNRB2tQ90khkDeMVqwIDWZyoIG2nglf6eSRbP+
 5Ey8F/5zM6qGUtEreYR3kTcL3SJDdbunBb9TMF+xt6/hUsJiy6ax/Xs4zkjv8FvAHz52
 bVcTXn7UzGxo32wkjQk7EYQ1EmYlkyYEm4Wpsyas3UwEvx5ds+1F9qMAirBmhdkcvhBJ
 Xs4b+3cD8Q+vNZAe5YqOT2ru+4zYreuhixEpCnwpoTCEpZySvTnss49kSk0rpPDyFSz7
 ONK7vDz/+6o/rQxjfPB7F59j79nvlA0YLF67gXqZryL79zrjLn0F3SzH2twbtpPZnSbn
 3KDw==
X-Gm-Message-State: AOJu0YzEYfqx1Gy1kDOEhgeyuyjSmjlS/Z5kQBVZ3Kc5MWmQrQZJLl9y
 U9NmbIb5iwOECyuPQeFRHJQeWMCMJj1yGL1Peeo/bueozmsmuCjk/ZS8uX+1DvTM5JYrt28xVaN
 v
X-Google-Smtp-Source: AGHT+IFuQJotWxyhTGPrZVPb0S0IiFSQXlanWxvBWHS38i5zJszlbwhWHAV9aQ149I7EKR12XuQvOA==
X-Received: by 2002:a05:600c:3b1f:b0:426:5416:67de with SMTP id
 5b1f17b1804b1-42811dd4862mr49326015e9.30.1722266921829; 
 Mon, 29 Jul 2024 08:28:41 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428057b7218sm181106805e9.47.2024.07.29.08.28.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jul 2024 08:28:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/14] tests/avocado: test_arm_emcraft_sf2: handle RW
 requirements for asset
Date: Mon, 29 Jul 2024 17:27:14 +0200
Message-ID: <20240729152714.10225-15-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729152714.10225-1-philmd@linaro.org>
References: <20240729152714.10225-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Cleber Rosa <crosa@redhat.com>

The asset used in the mentioned test gets truncated before it's used
in the test.  This means that the file gets modified, and thus the
asset's expected hash doesn't match anymore.  This causes cache misses
and re-downloads every time the test is re-run.

Let's make a copy of the asset so that the one in the cache is
preserved and the cache sees a hit on re-runs.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240726134438.14720-9-crosa@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/avocado/boot_linux_console.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index b8b0a4df10..2929aa042d 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -401,14 +401,16 @@ def test_arm_emcraft_sf2(self):
                    'fe371d32e50ca682391e1e70ab98c2942aeffb01/spi.bin')
         spi_hash = '65523a1835949b6f4553be96dec1b6a38fb05501'
         spi_path = self.fetch_asset(spi_url, asset_hash=spi_hash)
+        spi_path_rw = os.path.join(self.workdir, os.path.basename(spi_path))
+        shutil.copy(spi_path, spi_path_rw)
 
-        file_truncate(spi_path, 16 << 20) # Spansion S25FL128SDPBHICO is 16 MiB
+        file_truncate(spi_path_rw, 16 << 20) # Spansion S25FL128SDPBHICO is 16 MiB
 
         self.vm.set_console()
         kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
         self.vm.add_args('-kernel', uboot_path,
                          '-append', kernel_command_line,
-                         '-drive', 'file=' + spi_path + ',if=mtd,format=raw',
+                         '-drive', 'file=' + spi_path_rw + ',if=mtd,format=raw',
                          '-no-reboot')
         self.vm.launch()
         self.wait_for_console_pattern('Enter \'help\' for a list')
-- 
2.45.2


