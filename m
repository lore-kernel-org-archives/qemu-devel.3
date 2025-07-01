Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36F1C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSo-0005rP-Ts; Tue, 01 Jul 2025 13:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSj-0005mP-Sf
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:08:05 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSh-0003kK-7Z
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:08:05 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a4f72cba73so4483663f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389681; x=1751994481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KxWPsSs+27QX8v3jrIStt0DlCSv+fp9Zyr2gtQ2zORA=;
 b=fhpz7Jwrsu5+zyIqeiU0I2znLfvM1Kpj/86ubQzp7Aomx1dpbFX9Qan9neyrPHuZSv
 hxiVKVuqxMkmXcB/OTaAxpZt4CGatg4ugtsEGHrEQtkGbTrxhT4xNWt4gLOWXIlIPZKb
 /ZyIKkU8cd0xCh7gHxXHZo/RZhLpREgPiUtlFuLYwyOCfsO23gzztCoFHwVl/wKrxDyj
 f7JomEGNDhZoC73kfhyOBfs3fRkm3aiCClHsr1mBUxL6oko83lAvS9Y6BIix4Hd6XG29
 Co7W/g461HJjqmEM5hHH+NFfr18Qq3gFd+8b9lFWVcK0v26nx3UaH/ZBkh7K84E7wXv7
 LBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389681; x=1751994481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KxWPsSs+27QX8v3jrIStt0DlCSv+fp9Zyr2gtQ2zORA=;
 b=ooMA9702mYjKzXA6G++SqANGZbKXhAdJ8KbHO9oIy3nVofU/tEU4q5PvaNaBf/ex9j
 ZjMg+5MQf9hOkvUDG9Spjois9dDSOoDT+O9DkGD0jm+k/6IKnnraPn5ObSBYqgw1reow
 08wx5sgkuUF5K7h++eEuOUxwJ86rhKSsxZwPVaQYNvtH9m+a95t5glx6MygtJY0LYsHU
 fF2SOI+1y75Syd7f8mFbk4LgHtQ9iKRCkNS4Ywf8FPUlOcE3G426eBYWLdo9bOAz1Tnt
 lSNuA01ACGKnnqCoyQPvBD1IvvnL2PK+FYCrPg6j/f4RF7ju78pgl47iGlSGYjyOt4Ng
 D0sA==
X-Gm-Message-State: AOJu0Yxcq27QeXBgnNJ5vqfE4SoNb9I6bs8r7WFGpLI34z9Jfh3KYp6Y
 fWCRa60Gr5exqNeKJONMlgffcqDHSKgpyTCTcDjplNkvwNkar0D3My7CYuVkhHFyLHP1qa0VMHs
 j2wZs
X-Gm-Gg: ASbGncvRbKbavdcOmymp8Gqih74sz0dcNVSxL0/guUqWLjyNmJfuXDEGRSF7FTl/x2E
 hyLeo6KvtjMgFT6zJNzzy+8MNSdKubUf0Hlfn1kVl39pTHOjqff/N3TLmdXKVLlxRMpGce4VA+4
 0aL4NcYfzHq/XzcTGkCstf47A9j+3XLmouwBSrWQKWoeAKhsE/42e8jcwUPC0V4fpngBemUtKuI
 V0z3wJDGAHR8Boxc6Y7ZBF0umV2XEAVpbFsTlQsCYs+HBWdHRjvnxTMjYiF5eQYcemd9WgzbJAB
 ZMa6NP4PO/XdbNDFaIwInpDRxHkNvsWzcdjHp93bSQRIFli4j5OVKWHww35IrbX3/dFh
X-Google-Smtp-Source: AGHT+IGPziVZyr6NmYXTa6ceJM2mT0A2T4ru/RVIM22EqpWq/JB6oRMRrcdJBZDmvfVmqMZLpei7Xg==
X-Received: by 2002:a05:6000:290f:b0:3a4:e624:4ec9 with SMTP id
 ffacd0b85a97d-3afa162b562mr3259577f8f.3.1751389681491; 
 Tue, 01 Jul 2025 10:08:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.08.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:08:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/43] tests/functional: Require TCG to run Aarch64 imx8mp-evk
 test
Date: Tue,  1 Jul 2025 18:07:16 +0100
Message-ID: <20250701170720.4072660-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

The imx8mp-evk machine can only run with the TCG accelerator.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20250623121845.7214-25-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/test_aarch64_imx8mp_evk.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/test_aarch64_imx8mp_evk.py b/tests/functional/test_aarch64_imx8mp_evk.py
index 638bf9e1310..99ddcdef835 100755
--- a/tests/functional/test_aarch64_imx8mp_evk.py
+++ b/tests/functional/test_aarch64_imx8mp_evk.py
@@ -49,6 +49,7 @@ def setUp(self):
                      self.DTB_OFFSET, self.DTB_SIZE)
 
     def test_aarch64_imx8mp_evk_usdhc(self):
+        self.require_accelerator("tcg")
         self.set_machine('imx8mp-evk')
         self.vm.set_console(console_index=1)
         self.vm.add_args('-m', '2G',
-- 
2.43.0


