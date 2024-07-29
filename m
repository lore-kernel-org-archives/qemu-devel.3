Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85941C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSId-0006T4-6X; Mon, 29 Jul 2024 11:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSIb-0006Lg-IB
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:28:33 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSIZ-00006m-Hd
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:28:33 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3684e8220f9so1078736f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722266909; x=1722871709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24RQoEKyoT+5UpLOepmNrf2/RkiZNFw5AqywzTwtt80=;
 b=wCHCdxfWsNRNUtF1lCqTjnNCgsu8k7psjAPM8xOMquAO0aItj/8cWas+17nsznDAVu
 MDu6LwRIP4cnMgGHeu57NJMJWb6gLZlh3fxFC/huP51ec8IOGG7itEZd6FL5YfCMR2j8
 c4hRkZaPJekL1d/sJYGzL2HCbsMPVD9yTmfNVJWTpAEHLIkTdmbOBnVl9CJSyHlNERFB
 UuEl7eZHDLVVEelss5DxjYQeAr7KV6wBF6uMWfdBfacYBCZE2Uc9rY5ogIAkMyBUP8JS
 BvQxsWYabXEQwu7zklMz0T9J9H0oqpq9NrQtIclubIbLGxNmnYFZEQuXNG7TJJC3Zecr
 llRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266909; x=1722871709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24RQoEKyoT+5UpLOepmNrf2/RkiZNFw5AqywzTwtt80=;
 b=sKaE/MPPhvif/rAoZU2e6Kqt4JqyJnCSj6Npe2FYWh3ZN7yXjiecmgKaPnYOn9dOF/
 1QwsNOs+CWu67/sYMA+ZoVZp61aC8+AJGJJPSwYxZ9SuXKnpEXsaEyocYbmrv6JoM4aI
 8ZMbm6unzzLN1jGsQRbo6TYrvKpixwfDV82svmXGgfljosThACUgSd6z2d4Zaz3Qch1H
 Xji8Isw/8sBh0P4Ft5BpLptuf1Y+zRExi37uumxN4dc98JR2KbydlDocbTZkllNRzFhN
 /TzRlcUh0RYVssHdV8xq5mPTVcApzWxkV76/VoG2Gmc5UIZQ1fOn5VNOqp2d9IyZuTHW
 g+Xg==
X-Gm-Message-State: AOJu0YwxUoxtsG61jAElnlyjlX8l2HMuYwGWrkvX0io3s1LkXZ0EzrD5
 C1mr6zRaWJrakaFebIFu7I4vBDOKayKNGH9gKV93s2tUAagwWPSRamcSPGwoI9jrDFGQJn3VfxR
 V
X-Google-Smtp-Source: AGHT+IFd5Zrr2gZfoj8q+c/s5v8wsX9bkyB6pSZ74JWTocdxqpO8cJX1vSbD7U4oYdBE+PfV2jUiyg==
X-Received: by 2002:a5d:474f:0:b0:362:2af4:43cc with SMTP id
 ffacd0b85a97d-36b5d7cfa55mr4952901f8f.19.1722266909624; 
 Mon, 29 Jul 2024 08:28:29 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36800cdasm12766168f8f.64.2024.07.29.08.28.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jul 2024 08:28:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/14] tests/avocado: mips: fallback to HTTP given certificate
 expiration
Date: Mon, 29 Jul 2024 17:27:12 +0200
Message-ID: <20240729152714.10225-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729152714.10225-1-philmd@linaro.org>
References: <20240729152714.10225-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

The SSL certificate installed at mipsdistros.mips.com has expired:

 0 s:CN = mipsdistros.mips.com
 i:C = US, O = Amazon, OU = Server CA 1B, CN = Amazon
 a:PKEY: rsaEncryption, 2048 (bit); sigalg: RSA-SHA256
 v:NotBefore: Dec 23 00:00:00 2019 GMT; NotAfter: Jan 23 12:00:00 2021 GMT

Because this project has no control over that certificate and host,
this falls back to plain HTTP instead.  The integrity of the
downloaded files can be guaranteed by the existing hashes for those
files (which are not modified here).

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240726134438.14720-2-crosa@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/avocado/boot_linux_console.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index c35fc5e9ba..450d67be6a 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -299,7 +299,7 @@ def test_mips_malta32el_nanomips_4k(self):
         :avocado: tags=endian:little
         :avocado: tags=cpu:I7200
         """
-        kernel_url = ('https://mipsdistros.mips.com/LinuxDistro/nanomips/'
+        kernel_url = ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
                       'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
                       'generic_nano32r6el_page4k.xz')
         kernel_hash = '477456aafd2a0f1ddc9482727f20fe9575565dd6'
@@ -312,7 +312,7 @@ def test_mips_malta32el_nanomips_16k_up(self):
         :avocado: tags=endian:little
         :avocado: tags=cpu:I7200
         """
-        kernel_url = ('https://mipsdistros.mips.com/LinuxDistro/nanomips/'
+        kernel_url = ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
                       'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
                       'generic_nano32r6el_page16k_up.xz')
         kernel_hash = 'e882868f944c71c816e832e2303b7874d044a7bc'
@@ -325,7 +325,7 @@ def test_mips_malta32el_nanomips_64k_dbg(self):
         :avocado: tags=endian:little
         :avocado: tags=cpu:I7200
         """
-        kernel_url = ('https://mipsdistros.mips.com/LinuxDistro/nanomips/'
+        kernel_url = ('http://mipsdistros.mips.com/LinuxDistro/nanomips/'
                       'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
                       'generic_nano32r6el_page64k_dbg.xz')
         kernel_hash = '18d1c68f2e23429e266ca39ba5349ccd0aeb7180'
-- 
2.45.2


