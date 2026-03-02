Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F872FD0049
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwzU5-0001JC-9s; Mon, 02 Mar 2026 04:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vwzU2-0001Gk-Pt
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 04:22:34 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vwzU1-0007g7-6c
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 04:22:34 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso37026255e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 01:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772443352; x=1773048152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QgoB5HfDRfRQ2Ou/Ss9qWoCChifI8a9FD/ElPyWHfHg=;
 b=E/euRnZcW/JfUEOUWU67vA30NnJde6NE4ILOQMQF1ziyLYGLXTlXFjDYV4JLHvGmlK
 p4R3MKh56Ro2J3wpnGVW3e3Is1thN509Dsb17pkct2SOcIt+5tsmue35zAsW4ZbLyAKy
 xyUpNMtw5WxjcJeg0TdYcflKr66iG21XKs4hzM3yCWFq/uXIgMqS7VB6VQtMal6sFzlg
 /1KRzSi3/xjr3uj5PeKvnni5FlU97Gc40EzM0zDUMXzj2gK2PRe3qRNZptZ792cdrmF3
 y4XMLRmu5aM0GEjmLGTvM5jFE6HnL82NikWIfMUghQBolJG6+3RKDLJNc7ZgLxdEi93M
 IOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772443352; x=1773048152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QgoB5HfDRfRQ2Ou/Ss9qWoCChifI8a9FD/ElPyWHfHg=;
 b=jZDwWYJD4CdRkZNO0Xd0g9mN0GzUVBiZryZ94ORD20XOIM1nGU1D43lWOP0oP3UaPR
 Du2YO2rSv1v76+ZZc0WZZFbCi7jxtAsRjEOnbDMfG1szNVPlhn3x/2Ucjwp5gH9bJBPA
 gheh0DpH8uoVgbP+KcG/+6ebkoI6AH9HmYyM2JjTI02DqhrdN2/QF3IR2HYpmDPX4JN/
 X7jMciHVjiO5XJjUfiHhQLJTj/Hfvde+6cEv8Ku6k9KlY+oxVtrVFuXvhDW7DPXWukV5
 ovHl5yvxDwCvDROVaPMekouX9zGpv/8JSQad1h0ecjBaPmy/htvxdXg6h+Ad7ievM8bb
 tgmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhO5pPmsCG2VfdyP+yLBANTocMkUiLXbyu6vwi6rRWm0gxj9cqFX/3k4Bw+kqLwWZNaeyEyW00DQFn@nongnu.org
X-Gm-Message-State: AOJu0Yx2w/+pl6Xox/gY7kmy41JHQEWv/HaY6WKwfx4HLUv3cuDRT6Ig
 RiabAg+7YgStwgdQu+mzBM132I2u91eCjCmxqwUWcHbkcL/2Z0EYnepjuUzJw8u9bBk=
X-Gm-Gg: ATEYQzymsI87wIiL7u0a5gU60Dxhp6RvNdstqU11TV2EpJBUo7vQLxQlsAu+Pshf+SD
 hlE9y6+k4DdTPQ3AAv6Q2qt7t+0MUp7a7caMDovgUBg6zYMwKP548QuhXloqgiGRxpQrwVlyFCO
 /TtOxUgh4bwasCV6yfKN4iOHCDkd0A6MN2x/k1/q2UnxhRuKFebIjjnOCSU57WeWMKp8+X0TTE+
 mxGXHk5xeqytvjSifW8ynxenExL42HLuNjmr6hwfLofMyCmQJxvRWsd4bPDZbBkxKi51Vop4srU
 aK7akjb6mBcvSBlsGQR4KY9phA/k3T0tx8lwZ5V8p2Lv5R4k9fbIxkkaMW5GxZ6WLYzHax0Bk/g
 M+h29yGo9EPJtcmM6VWsTkYj09tSPV6F7fNg5DxcbSIEo+oN1O6uWzJkxtJxPXogG3+MkFQXqkq
 Wpv/BlJc9U7FrdaDNgHOlW74pIeE+DUZrPez1diqBGL5XgSB75lD8mqUJe1+EXhldok537OVBRH
 qZyCwCKMlUaXvUJtXQbGrSJXhIBQrQ=
X-Received: by 2002:a05:600c:548a:b0:47e:e20e:bb9c with SMTP id
 5b1f17b1804b1-483c9bdb16emr183788885e9.8.1772443351719; 
 Mon, 02 Mar 2026 01:22:31 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb9d9c6sm129435305e9.14.2026.03.02.01.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 01:22:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Yodel Eldar <yodel.eldar@yodel.dev>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 4/9] tests/qtest/iommu-smmuv3-test: Free QPCIDevice
Date: Mon,  2 Mar 2026 09:22:20 +0000
Message-ID: <20260302092225.4088227-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302092225.4088227-1-peter.maydell@linaro.org>
References: <20260302092225.4088227-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The QPCIDevice we get via qpci_device_foreach() is allocated
memory, and we need to g_free() it after use.

This fixes asan leaks like this:

Direct leak of 64 byte(s) in 1 object(s) allocated from:
    #0 0x622a5f16913d in calloc (/home/pm215/qemu/build/arm-clang/tests/qtest/iommu-smmuv3-test+0x1d413d) (BuildId: bc598be1f4ad6d1a9a600c55aeef36108bdb6a04)
    #1 0x73ee41c0f771 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63771) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x622a5f1d4cec in qpci_device_find /home/pm215/qemu/build/arm-clang/../../tests/qtest/libqos/pci.c:82:11
    #3 0x622a5f1d4cec in qpci_device_foreach /home/pm215/qemu/build/arm-clang/../../tests/qtest/libqos/pci.c:34:19
    #4 0x622a5f23cc73 in setup_qtest_pci_device /home/pm215/qemu/build/arm-clang/../../tests/qtest/iommu-smmuv3-test.c:45:5
    #5 0x622a5f23cc73 in run_smmuv3_translation /home/pm215/qemu/build/arm-clang/../../tests/qtest/iommu-smmuv3-test.c:74:11

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/iommu-smmuv3-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/iommu-smmuv3-test.c b/tests/qtest/iommu-smmuv3-test.c
index cced49a9b6..dae9821b92 100644
--- a/tests/qtest/iommu-smmuv3-test.c
+++ b/tests/qtest/iommu-smmuv3-test.c
@@ -77,6 +77,7 @@ static void run_smmuv3_translation(const QSMMUTestConfig *cfg)
     g_test_message("### SMMUv3 translation mode=%d sec_sid=%d ###",
                    cfg->trans_mode, cfg->sec_sid);
     qsmmu_run_translation_case(qts, dev, bar, VIRT_SMMU_BASE, cfg);
+    g_free(dev);
     qtest_quit(qts);
 }
 
-- 
2.43.0


