Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0628CEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxph-0008VI-S1; Mon, 17 Nov 2025 06:55:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpe-0008RT-MH
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:42 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpX-0005k4-B6
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:42 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47778b23f64so28810745e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 03:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763380534; x=1763985334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ddQPmTtLHjd+ba+Nnv9Q5/alJP/AtH8hBil+YOtIrqM=;
 b=Y56rlFrLRlo0wk5l2a8cka5Hjjv+hNM7AoPSZrNiCdQK7t790fRlHy6f8Kijbfyg7O
 HxLGsPXHKrTVwNZttmauf2l4q0CT57MlYJhNwkAAXZ5W43uxzPpXkHQZLfC0x44K/vrq
 kj8b0Y15qLip/4INnVxEDm/AP8HLSH3gt2oKvn1xKHII9OHx+94OvyOjhpln42w+6taD
 m6OXyRZJ9g11BXu/clfn5VhJEgHZBTWhmLa7JgT1SjXvEaAGG6QdJwnPRaTBmOxwiBos
 jhSaXfVozXC7ynKKOrf3QsUvEzfFiJWEKTfEd0B1wkmmGGf4mgmi5xbTYh9aM6gs1Ujj
 uw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763380534; x=1763985334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ddQPmTtLHjd+ba+Nnv9Q5/alJP/AtH8hBil+YOtIrqM=;
 b=SGJZ4x3URIJ+BoCkvDeRg6CTqStHxT/uriCIWVlu9lycdrbAgesTSVixkg6u9xKU1d
 3MOxr9zxHSQMmpmO3UYawhZ4dFj8ezegIFrYIzxbI92hEIfZ/wXkt2uSCa+AQiZlSAYu
 wT/HBAlfr5xjlUb419kFMM7Cl7gpIoxHHCWSVZgIFPSLZgFKrDsxlVcIBl4c5Ogk/sMp
 tprMXVh9plnOgw2VsbBOs12eY05/YOcsvyXpAyv4m75iS87RDhcAulZ//px3SQb4OYo/
 IhULgCMnC8yOAYHr7E/GVNT6J7qiM9SMPzYoagoivL8Wpehi/QVHEYMS0XWQimZGC4Q7
 NYOw==
X-Gm-Message-State: AOJu0YwWjLiwNf+LXpc37pO0s4ftjW06Xyd6f8cS5t2q3Fu1TXJi9Mm8
 /rGTnlbRF/MTRNPuNr4OSpkzHUXX/0uF+T886hAv0yiZnfWdh7gozfPLizwb75Ato9A=
X-Gm-Gg: ASbGnctuifLKJpDh64F8DTcyA4hJ5SwtFtNgzXtK+veCNCURnzDdprE1xSe/5vqnkw5
 NQs8ACz6Ik4hSFB3nKdPr1jAQnQgH8ySw3vfFqZSYAaj8KkiEJFk0hlH9uwJZo9AcFT46xYzIFF
 bY0Z6aggwys6Cuacv3wIjt9MfINhSnxec8WduWiFJHd+KbY8vUzLlyHQV+MSIxsEM0Pf7ATTQjv
 XNM3HJBuGT4kUNqT2inti/HPshW75ipT50mtMtGITuNecKh0OlU40Vu/E0t2naqEsirWAU8I+6Z
 KEyg1lvUjXkbEAm/zpgnmv0WyJgg75r34cDt9TjKKPFSf+j95tqekeBC4Nz9PCWBgNQRPw7gCCL
 jP3KoEDJCfAASHCYxmGD5XSF8ZAgz3tY9e0+k6lFnDKhF9veUWLu2QJaHQcjVVbvrLPCKfe5GnY
 8tdLiF38tkkiI=
X-Google-Smtp-Source: AGHT+IE9XT1/z3WZDB68SBtTcY3HF4o+hHRH9skQlfd6HRJiPbFe4AIRwfFV9ZZ+IH0NBmKs8jvyJg==
X-Received: by 2002:a05:600c:1d19:b0:477:582e:7a81 with SMTP id
 5b1f17b1804b1-4778fe50bb3mr91800995e9.4.1763380533851; 
 Mon, 17 Nov 2025 03:55:33 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47796a8a695sm142872405e9.13.2025.11.17.03.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 03:55:32 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5E8A85FA6C;
 Mon, 17 Nov 2025 11:55:25 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, qemu-s390x@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH v3 11/18] tests: move test_virt_gpu to share.linaro.org
Date: Mon, 17 Nov 2025 11:55:16 +0000
Message-ID: <20251117115523.3993105-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117115523.3993105-1-alex.bennee@linaro.org>
References: <20251117115523.3993105-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Linaro are migrating file-hosting from the old NextCloud instance to
another sharing site.

Cc: qemu-stable@nongnu.org
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251113102525.1255370-13-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/aarch64/test_virt_gpu.py | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tests/functional/aarch64/test_virt_gpu.py b/tests/functional/aarch64/test_virt_gpu.py
index 4e50887c3e9..c26a1f20c65 100755
--- a/tests/functional/aarch64/test_virt_gpu.py
+++ b/tests/functional/aarch64/test_virt_gpu.py
@@ -23,15 +23,11 @@
 class Aarch64VirtGPUMachine(LinuxKernelTest):
 
     ASSET_VIRT_GPU_KERNEL = Asset(
-        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
-        'download?path=%2F&files='
-        'Image.6.12.16.aarch64',
+        'https://share.linaro.org/downloadFile?id=lL8wgnMmSXZo7Co',
         '7888c51c55d37e86bbbdeb5acea9f08c34e6b0f03c1f5b2463285f6a6f6eec8b')
 
     ASSET_VIRT_GPU_ROOTFS = Asset(
-        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
-        'download?path=%2F&files='
-        'rootfs.aarch64.ext2.zstd',
+        'https://share.linaro.org/downloadFile?id=qOn1wbfKmS6KVHZ',
         'd45118c899420b7e673f1539a37a35480134b3e36e3a59e2cb69b1781cbb14ef')
 
     def _launch_virt_gpu(self, gpu_device):
-- 
2.47.3


