Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB52D58D5D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFaz1-00076D-53; Mon, 25 Nov 2024 10:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFaym-0006wo-Du
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:26:24 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFayf-0002Xt-2R
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:26:19 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so25947065e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548375; x=1733153175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e4h6aEw9LYtmJIIcDDymcXrZ9jlAyL6XBEIid/PrQo0=;
 b=Ph0aeLY94OHVv6Kr4Tml4e0GzT+57rKKD4G0CF7ZC1ROcCiO01XjOmGVOhChmIQU2M
 UNrne83o28hnNMFcUs6JSXy95cAqktFHImY4wDQBVC2T2YtVMj04LkHM0Lrxqc6XiKi8
 YYPLZiZM+RFW3CX/D/gxMbrZoYyimAn9br2LXzwTBSmSv4mC6kuAnX3MYtcfDXDkiaVo
 aLAoBfDGKOo7zo8xh2AZJ0sK7HyFFrGcqDQaFTJlG1Kh11A2f21phRIlac1BveMMCHWY
 MwBlNctikgcqFAV/MnjCH7oA9MxM5i/Oq3VX8IAECJqzYoVIn/j5uTJxSMn67MyYzFG9
 szdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548375; x=1733153175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e4h6aEw9LYtmJIIcDDymcXrZ9jlAyL6XBEIid/PrQo0=;
 b=Ldktev4bNEjfSJ7AN5fPxJf32eX/W6Nfj0PEtKgMMMSndvny6FCBpZ14gaWzeSmBmH
 6nQXHanu5F/P1cZs2nuXGSd9erd9xWQ7a9nhr2rvgVCX9P9V99sGOi7Sbz2nsrz5Sm9J
 4nGe3M/5EYdvhpIhhtnApMZ7fsW6+n+1AMkujAs+ifHtOQszW6Hggc7EzUQ5xO2o8Vs/
 3h5chNKufliqF3Ym1l/0zdLcWgZDLNtzv+Mr+qzgTdFvd+zJ8onomDICRP9QFUN62Vl+
 /wfRBBzqMSVsauesgdOUHwZpWx91xB5Pk/9hOWJe1pDv05f2niBz1leXN72so42c5LHH
 lNww==
X-Gm-Message-State: AOJu0Yy0kA10Bc6qbQ9zw0Ynp94lKioVXUJMaVQOBwrd4yyTa6vd6D+o
 FaajAhXyrZSRjqqPD7CCJSQfCUIAN9VidtihI8rl7U3WyzV39uh4uywiRgQMKMw=
X-Gm-Gg: ASbGnctbs/oMTZWoQr0VbiJNENmmRg6XDpHL3oHB4iXFWSFeUhzNxT9a+9rcuUuyEEi
 T5gdCxkbYxjXTvPwagAu1e9aJQWUBefUz5IAEOWpLXXdWf53iYjHX8tOeCkuzxupfPq+pqA3em5
 SoGlyjSwsRS5BsCqUkE3daLou3p0HH1VxMWDIdCXJN8EajnSedMR4qK/ySY3+jEcUwav7ejiDvY
 pSH/oOLpew0Dtm1C+NFiNChhmzPXTQmi5V8umEc3sfunHmq
X-Google-Smtp-Source: AGHT+IGSybAa9ZEgN/23gNMpxtvTIF9z6Ba3QA7Yszz3ayXdrGUM/t4R9PXImw66v8Ym+chbS7osRA==
X-Received: by 2002:a05:600c:a0b:b0:431:4a82:97f2 with SMTP id
 5b1f17b1804b1-433c5c95780mr147723625e9.6.1732548375496; 
 Mon, 25 Nov 2024 07:26:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43366cbcdd8sm183016145e9.1.2024.11.25.07.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:26:14 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9AED35F869;
 Mon, 25 Nov 2024 15:21:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-arm@nongnu.org (open list:Virt)
Subject: [PULL 20/28] tests/functional: update the aarch64 tuxrun tests
Date: Mon, 25 Nov 2024 15:20:57 +0000
Message-Id: <20241125152105.2100395-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Now there are new up to date images available we should update to them.
With the new rootfs the blk I/O errors also go away on arm64be.

Cc: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-22-alex.bennee@linaro.org>

diff --git a/tests/functional/test_aarch64_tuxrun.py b/tests/functional/test_aarch64_tuxrun.py
index da56aee4ed..75adc8acb8 100755
--- a/tests/functional/test_aarch64_tuxrun.py
+++ b/tests/functional/test_aarch64_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunAarch64Test(TuxRunBaselineTest):
 
     ASSET_ARM64_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/arm64/Image',
-        'ce95a7101a5fecebe0fe630deee6bd97b32ba41bc8754090e9ad8961ea8674c7')
+        'https://storage.tuxboot.com/buildroot/20241119/arm64/Image',
+        'b74743c5e89e1cea0f73368d24ae0ae85c5204ff84be3b5e9610417417d2f235')
     ASSET_ARM64_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/arm64/rootfs.ext4.zst',
-        'bbd5ed4b9c7d3f4ca19ba71a323a843c6b585e880115df3b7765769dbd9dd061')
+        'https://storage.tuxboot.com/buildroot/20241119/arm64/rootfs.ext4.zst',
+        'a1acaaae2068df4648d04ff75f532aaa8c5edcd6b936122b6f0db4848a07b465')
 
     def test_arm64(self):
         self.set_machine('virt')
@@ -32,11 +32,11 @@ def test_arm64(self):
                            rootfs_asset=self.ASSET_ARM64_ROOTFS)
 
     ASSET_ARM64BE_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/arm64be/Image',
-        'e0df4425eb2cd9ea9a283e808037f805641c65d8fcecc8f6407d8f4f339561b4')
+        'https://storage.tuxboot.com/buildroot/20241119/arm64be/Image',
+        'fd6af4f16689d17a2c24fe0053cc212edcdf77abdcaf301800b8d38fa9f6e109')
     ASSET_ARM64BE_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/arm64be/rootfs.ext4.zst',
-        'e6ffd8813c8a335bc15728f2835f90539c84be7f8f5f691a8b01451b47fb4bd7')
+        'https://storage.tuxboot.com/buildroot/20241119/arm64be/rootfs.ext4.zst',
+        'f5e9371b62701aab8dead52592ca7488c8a9e255c9be8d7635c7f30f477c2c21')
 
     def test_arm64be(self):
         self.set_machine('virt')
-- 
2.39.5


