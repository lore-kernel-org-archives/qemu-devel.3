Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9CDE6C61F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 09:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIOvp-0001fO-E7; Tue, 03 Dec 2024 04:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIOvn-0001f0-MQ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:10:55 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIOvm-0001GH-5d
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 04:10:55 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4349f160d62so44859985e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 01:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733217052; x=1733821852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zklyya5OkEnNrhger6hBnXU3zSz+e7zU5Eu5GV2az4Q=;
 b=vvgpGq9gfh6sO+W6Pv4O2TWZaT8QqNsENAyPeW4halmr8r85gS+0SHxgvZXHm0hyhK
 uxO0ByW480/Lxt4ro6ceF81jx18trJqN1IqQjIYJoROilo0LOLYut1Zv4ae39rqXN/h4
 SFPfoX//RTizFAJ2BB4v1/cX4IIDdw20YNt2Q0evDhxxgQjwcsxJuJXyak6BNAOGC89C
 Hga/Cf9nvuDWnwhdv4nHuaehnu4EiMTCKjMzwjOPR75qNLN4wUkqnNoZR9iegG5+AMzU
 4oIG3219gwWZrpGrElg4adUFCvq9wcnPDXndHEb3UoZb2yi6Ny1JxeGIJWuMgSqJYDNZ
 YxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733217052; x=1733821852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zklyya5OkEnNrhger6hBnXU3zSz+e7zU5Eu5GV2az4Q=;
 b=KEI9Jlkvpb0JUgK0Z2X5fMMefgnYUGZyRa4fkrWxFWvtpAON3jUFAdxWBmjIs0xjO4
 5mQ95sKx27RUuwPMm59vrlIEx2vbYS3iTTD29wGQ4BSOrFaF0Zj2FmsTCHM5bLJmuR8t
 3Kgpx4o0AUlCIGUZMkWZ6rPoGois+pLSC/Vp1swbJO3yssmDWf+ISkyBd9JGhjjXG97G
 cgy8ZFUgSc5VmtMtIiVabR5SYx+hXmc4R+D0rO6MQfaslTctBjVKq9JLXq2l0lYEm1ch
 zsmp6QORaav5qtvJ6swUGbdrZJ67ot6GHirPq8/0m1qc2WWkUNIvIwJH9PS8t8g6tIhw
 JcVw==
X-Gm-Message-State: AOJu0YzjbblISKANe+RPfQ1avCMe4rsA1zp+/pVHxO4hea7AkYtHuvx7
 P8DiCQx+bcxkS53pWBuN6493s8krj6cyXmNXvLapi2rpG2Ke1VHmhtIP6N0QvOLBIkSf3OKrshZ
 hmtk=
X-Gm-Gg: ASbGnctbgHau4jnhfN7Ucr1qzWvgIL6qUi42wAPv+29u8SPwd/DxFRH/SgsrvxLoogc
 7j35yGVnwo2gvKIMyf1cTpdHVe6ftoL0EayFVARuMWpCRibHEPpojtda8wnhxufnQIfv5MK6ElP
 oCr/bt4kBEH254ERtU9KpAh2NSEaU1t0zoP1fRjt/E4o0i/MRVuoBGf7OuSjmHzlDKGg+FoG3fa
 l9OoTZ7byowyQj+eddNPRYeOIfgf2pqUe3T14dRy5J46jYfUzVEjvmBBRjRc5eH1dSjh8vA
X-Google-Smtp-Source: AGHT+IHTGgMmemYBBcAKZN6bzYOzsR+bh6w40+IJsK3GajkxBDLAPAHbojG23XPTL2B/77QHF3Fjog==
X-Received: by 2002:a05:600c:1c07:b0:434:9c1b:b36a with SMTP id
 5b1f17b1804b1-434d09bf7b4mr15037615e9.13.1733217052265; 
 Tue, 03 Dec 2024 01:10:52 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7d21bcsm217075815e9.30.2024.12.03.01.10.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 01:10:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-9.2? v2 2/2] tests/functional/test_empty_cpu_model: Use
 QTest accelerator
Date: Tue,  3 Dec 2024 10:10:36 +0100
Message-ID: <20241203091036.59898-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203091036.59898-1-philmd@linaro.org>
References: <20241203091036.59898-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

When testing with a HVF-only binary, we get:

   3/12 qemu:func-quick+func-aarch64 / func-aarch64-empty_cpu_model                              ERROR            0.62s   exit status 1
  stderr:
  Traceback (most recent call last):
    File "tests/functional/test_empty_cpu_model.py", line 21, in test
      self.assertRegex(self.vm.get_log(), r'-cpu option cannot be empty')
  AssertionError: Regex didn't match: '-cpu option cannot be empty' not found in 'qemu-system-aarch64: No accelerator selected and no default accelerator available\n'

Explicit the QTest accelerator to be able to run the test.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/test_empty_cpu_model.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/test_empty_cpu_model.py b/tests/functional/test_empty_cpu_model.py
index 0081b06d85a..e3bca707af9 100755
--- a/tests/functional/test_empty_cpu_model.py
+++ b/tests/functional/test_empty_cpu_model.py
@@ -13,6 +13,7 @@
 
 class EmptyCPUModel(QemuSystemTest):
     def test(self):
+        self.vm.add_args('-accel', 'qtest')
         self.vm.add_args('-S', '-display', 'none', '-machine', 'none', '-cpu', '')
         self.vm.set_qmp_monitor(enabled=False)
         self.vm.launch()
-- 
2.45.2


