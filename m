Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB71E69E90
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 20:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIDDo-00022E-Sz; Mon, 02 Dec 2024 15:40:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIDDi-00021z-Vt
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 15:40:39 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIDDh-0005cM-GH
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 15:40:38 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5ced377447bso7496690a12.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 12:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733172035; x=1733776835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BuTlSgZfbP0ZAQXYagEGb5OS1Rg8bdaBraFE+cBHSvA=;
 b=S6aHNrHvjmSIeO0VaJZtu2YwxhgZ7Ni/GV/kzbDcK+jkhpeJ8KHL+nWmg4+ysN5RZ2
 s0f9cTJsgVTTE9a5ajp+zceOROIP2n1tZSY7XfZw62NU5BssOLYexxcQbHwKkegvoXNr
 z4iYA3P9e37Vt6A1IegO+tUEklIDPQ9gaJFoWn0cYF0AvQQlUrMpo83vFBo1om4gGvI/
 FmC6T+GMM9mWRxnBxEA9qY6SDj9zIU6gm5WwnBLdDmXEya3rq5IvyT/HvgkX0NaF2fFi
 cpWHsboBk5nsak1aSybSDe58xQACgTDSEekdiPPebvHUDI48G8v/ewkcfbPjC7vlyNld
 aYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733172035; x=1733776835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BuTlSgZfbP0ZAQXYagEGb5OS1Rg8bdaBraFE+cBHSvA=;
 b=BIJu5jatfYPPWu+rZoUfQ+zHnn/m4kcw+u7r8MdtWmuBDUkW7g/04q9TWOdw3/hvqp
 yYmAkEInbdKCLcU0IbpD02gsBhz8csq7CRFrqQ3928PxX//mEWtAucgY7+dMJkkwfQwE
 bkefLcXBfgr/Xxjdhw6UGtctAwqY6OPJs0hv6ON1mizmepnJQSpLETMFMKTeFBVTqHbI
 yGr9WE2zm5hVYwTWulSbCnmvbmbo/MSgqRu0EYr1OvQ1IEgs7o9na70fezChe+OdMiU/
 V8z/BEnyzmDeyV30Ht2HcPqp4GlRHef8nXi+oXaY9eBqqaEdoU97yeSGDmtNhPowAG7F
 dyHg==
X-Gm-Message-State: AOJu0YyK1KnetM5+nqamDtdDQTXwToogcdbQ86dcQtYEeMEOmeYSSWNg
 OU6R4ozuC2C66NA1SrEx/Tr+hJTmSfxjhzCFdWHgmWYdXWRb2xueq816xd8VgErxKkAYHQrDjJy
 i4Ts=
X-Gm-Gg: ASbGnctJOoi8FgWy3rFH5QxsmpeErl3RTseqMyXl4UDTp9NR84T36dudWTfFbOgaPl/
 TNopIiLBbiC3EzE85hv/Qa8ZzJPdmbpGAA9m4PNXGx7RrR3g+eT0IhHoLe1stT0v3AbUXm4hPIZ
 0JeIfTtIgEHSHTrubI9GJEuJxcaTyfnVUGygYmJr99CTCkiiqp5jmxGFFKeGp2QSwoIZfU4p6/b
 RRabqFtwTTBOLUPQXVCCOe6Z3mmsg9Y6h+Eh3HM4cXdIEHrKZQUVUN7fs01jupZlVRZgaRx
X-Google-Smtp-Source: AGHT+IF54HKZJFDWztzWc40kpidTw4GKOYC29LzmdfOoWAddeOSfEek+1U8U4ljojmBSb9aVSgWNGQ==
X-Received: by 2002:a05:6402:1f0c:b0:5d0:c9e6:309d with SMTP id
 4fb4d7f45d1cf-5d0c9e6323cmr13451504a12.1.1733172035517; 
 Mon, 02 Dec 2024 12:40:35 -0800 (PST)
Received: from localhost.localdomain ([176.176.160.129])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d0eb2d116csm1578300a12.61.2024.12.02.12.40.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Dec 2024 12:40:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.2? 2/2] tests/functional/test_empty_cpu_model: Use QTest
 accelerator
Date: Mon,  2 Dec 2024 21:40:19 +0100
Message-ID: <20241202204020.55665-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241202204020.55665-1-philmd@linaro.org>
References: <20241202204020.55665-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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
 tests/functional/test_empty_cpu_model.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/test_empty_cpu_model.py b/tests/functional/test_empty_cpu_model.py
index 0081b06d85a..16ce1892d84 100755
--- a/tests/functional/test_empty_cpu_model.py
+++ b/tests/functional/test_empty_cpu_model.py
@@ -13,7 +13,7 @@
 
 class EmptyCPUModel(QemuSystemTest):
     def test(self):
-        self.vm.add_args('-S', '-display', 'none', '-machine', 'none', '-cpu', '')
+        self.vm.add_args('-S', '-display', 'none', '-machine', 'none,accel=qtest', '-cpu', '')
         self.vm.set_qmp_monitor(enabled=False)
         self.vm.launch()
         self.vm.wait()
-- 
2.45.2


