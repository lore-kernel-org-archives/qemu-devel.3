Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA71C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ML9-0007d2-06; Thu, 03 Apr 2025 11:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0ML5-0007cX-U8
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:18:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0ML3-0000Pd-JM
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:18:43 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so7229455e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743693519; x=1744298319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fuei3baK1sdFDft7gXrQyidqUa02cv4ewmtE/kL3GxQ=;
 b=tGLOwhStTQbMRa2oZvHCS3gH4M96IzmNHlbRvLSAN1tSrJtl/odls7c2NeD79A1lQr
 7GfckOyO5xwEqSUSSnfWr7+9DPLBydzj+6NVHoJTFyWxlYa1rWSr69Te/2la/PE9lPZZ
 uzp4RJGlz2pzHTbxlZgamHbt4yYqfA6hnktsjeMB6WysqzUzOU3G/8FTUSUzDz3wLAb0
 X/hB29uynfK/zKV16G7sjkngFJAryj3UVOe84zE4M8Pf7sDg8yt+py6Tc02dFYCLrqmV
 sDGuc0kbT7PAZswY0E5YogwCohKtfE26hLG88OXOlktci0mIT/4zJBI5f825QoLHmrTY
 ezng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743693519; x=1744298319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fuei3baK1sdFDft7gXrQyidqUa02cv4ewmtE/kL3GxQ=;
 b=KODoXvqx2XRSDGx/kHwLPfcgzKZeh/B0iyLRTsNFieB52TXWix/MziTjPL5+QkBeBu
 Jsk2zTjUHq8elhGrB09Sjle4WTQrwver8R3Svg/apuqvP7w9xQ8z05+pU7G3kGc6tphm
 GCxe3jDy6DeuE2c0tbsJ2ZfRCveeDgg20vOprhAO57ypS6H11FbeyC6ujyYEKQXb3omD
 nj+CP9OyeiHWLhaZjoWYwWIPS66BndTAsdlMyJxF8KWqK6GLRLD8MM8DsQaOdGBeN5l2
 1JVFsmKO4y6h3oJSqs1MZjTB7gWfhjhYlTy8ATdngRMWsbKmK30235Eqn1gYzGeLjwN/
 echQ==
X-Gm-Message-State: AOJu0YxULhductbSPuz3ygMaWdfQ0SuPOLj4Xl8GWhUv/alPcq2aAwIe
 WEjHw17fErFTfnuhv9tlLy7OwHf1Kpga1HnbHhD68dMbkLf0oW80/pxu2ppiqvcfk7iLz+UcEAm
 x
X-Gm-Gg: ASbGnctJeqt1ZyyhYg3bZxzh7Oo9nNPrRPJJHbcFiL5ZouocNzNKcGqX5z71lvAVvOs
 OD580MfwY7NFpOmAO/gZwuVPByZ4xBb+hesXfprFMGO45lXbGFBYvWUpFxzZNGyE7Py7CSrTfMm
 dm2wSs2wS3rJB/mx3xl7XV9CcRPHltOP9A2vRnRqi+5QWFCm9ZzxXp8jnkIvRS7FryJh9dtoFCj
 OBPf/YR1NxMznr92ztp0ZSLbkmOkj4MZ/jrZhURd36oOsOrxGd9uBlz3DGUWdEy852czvVcYxB0
 bMM24MVDRipIwtk3xj0JkXhmMbamDMm0Wvmu+7kfFI8Y4O6zlFlfS5tt+Yg20g+JgOPQZZ/+kxa
 7iqLcez4IhcRHn7qeHRYddGN5isY+pg==
X-Google-Smtp-Source: AGHT+IEnm1d5jqQclVVh0+L43ZL/ydHkKrGZBsMRZ386WjgQW7Nmg/Rga4Nq4MA7R+Vd0OPKzFvQ9Q==
X-Received: by 2002:a05:600c:8707:b0:43c:fe15:41d4 with SMTP id
 5b1f17b1804b1-43eb5c2167bmr71212425e9.18.1743693519299; 
 Thu, 03 Apr 2025 08:18:39 -0700 (PDT)
Received: from localhost.localdomain (145.171.88.92.rev.sfr.net.
 [92.88.171.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1660bcesm24437595e9.10.2025.04.03.08.18.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 08:18:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Udo Steinberg <udo@hypervisor.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-10.0 v2 01/14] tests/functional/test_aarch64_rme_virt: fix
 sporadic failure
Date: Thu,  3 Apr 2025 17:18:16 +0200
Message-ID: <20250403151829.44858-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403151829.44858-1-philmd@linaro.org>
References: <20250403151829.44858-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This test was randomly failing on our CI, and on dev machines,
especially with QEMU debug builds.

From the information collected, it's related to an implementation choice
in edk2 QEMU virt support. The workaround is to disable KASLR, to avoid
accessing protected memory.
Note: this is *not* needed for the similar test_aarch64_rme_sbsaref.

More information is available on the associated GitLab issue.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2823
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250328183816.2687925-1-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/test_aarch64_rme_virt.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/functional/test_aarch64_rme_virt.py b/tests/functional/test_aarch64_rme_virt.py
index f4ad4d33d58..a1abf584f0e 100755
--- a/tests/functional/test_aarch64_rme_virt.py
+++ b/tests/functional/test_aarch64_rme_virt.py
@@ -87,7 +87,9 @@ def test_aarch64_rme_virt(self):
         self.vm.add_args('-fsdev', f'local,security_model=none,path={rme_stack},id=shr0')
         self.vm.add_args('-device', 'virtio-net-pci,netdev=net0')
         self.vm.add_args('-netdev', 'user,id=net0')
-        self.vm.add_args('-append', 'root=/dev/vda')
+        # We need to add nokaslr to avoid triggering this sporadic bug:
+        # https://gitlab.com/qemu-project/qemu/-/issues/2823
+        self.vm.add_args('-append', 'root=/dev/vda nokaslr')
 
         self.vm.launch()
         # Wait for host VM boot to complete.
-- 
2.47.1


