Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22BCC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 19:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsRMS-0005ej-2C; Wed, 12 Mar 2025 15:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tsRMP-0005eZ-TN
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:03:21 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tsRMO-0007QZ-73
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 15:03:21 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac2a81e41e3so43059966b.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 12:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741806198; x=1742410998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KXL6KuwS0ndReh1nkiG6eRuO6G6TimJVrRWCcPjiYBs=;
 b=t6fuN90+3RO9TETceez2UtllrDKZshikcgXK+NZkiPM+kx0m8hAwwX6atqlwJz61LN
 9tvzab9sBJu/gMT5xvfMdQB9N9U7RdkBOQkCBJSiUzkHOcAgb87vLQzwj3XTWcPXckIz
 7TpMOd4ApSHe3McVfrTlN7b5Srq1nP2Vn3bI93CqAjoIDS91KtARF/Yz95QiaA4sm9kI
 sE+msQfjEtX4sA6zvSFfkQM5u4GGn038lKwV7hWdPOHD4KjBdVYHzVDxkQ+dF8KjpaNq
 kOA5GYPMYxoACECILxzXFZBatmAqc+N0Yy9E4ObA97Frnuncm445hylSiYilzM26Bqa5
 s2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741806198; x=1742410998;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KXL6KuwS0ndReh1nkiG6eRuO6G6TimJVrRWCcPjiYBs=;
 b=wb5vynRz05wjexTIZDpsHM9hMNycxNJwbem08ekG4jUSMl5zo/VhdaJSMjC/j7i61D
 6JRBTbFpC7mwuMsbedC/W2IhstM/uD5rpTlalr4VwXpVtaOaWY7NrawYkxnu8WbxVbcV
 TWvc7T5P0zsVL4F8aZaXRv8n5pvnYd1H+ePG4kWO7oxl/Req4B62FigxYRUBK2leo647
 fWxKiAGJMg1baGr90yt5qGLNjxqN4EwPWFV8F1fonMEwl+6r4sZMob4pGk4qBMMcf8Ox
 gOWADaJ7fv8Am9N+Wa8S15PZ6Lcs8yQurnD6qbxzd4dwqbgc+LA/c/eaNuJcJLYISpDI
 VsBQ==
X-Gm-Message-State: AOJu0YwqFUgHQ5Vu5CcLb6BFh219fWjrO53FAnOa5nqq1GWnbgMo8vmI
 3xBp8gp0EXTFzsODu3Cit76ru+jc0B0t4+9z7r482OyGkRMwHzVQlYDnRtft8KC7uiNeQAX1Xeq
 6
X-Gm-Gg: ASbGncs+h1ZikZKuzT5zQnU60d/6BtnYIiN2iObMfosPJqcwgi8yiS4+iZK3df9yEZS
 SaCj9hULB+3cxvwKY9jNiLEFuy0dmnh3cTg5+rpSLirIbupLyKgZ5ZiTD6iNTqhuTCIqVV4RvMq
 pBzlCy4zd+/kjZtHlxyciJN/8WFrTa4mmSwCs3iAF1n7ZpICjeeKU5Z4Rlca/y2K5bPzNCBNq6h
 QiAu1NDgxLOZziDN5ARFXSfRBJq9scasOMTMHDkEzbFqwv4FpgeYu6psfq68z2w+2psgzKlGlqS
 1jlZitixjjwXlzVVxX/LGpxshUD6ZqalRU/4kmYIlnuHnU4=
X-Google-Smtp-Source: AGHT+IHPsNdq6mUc9ndJ+knWv06aPeyeZecN+NQ7ELvtAhQezCHH8/rLji3WHCH7HhhNJfB223wwkA==
X-Received: by 2002:a17:906:9586:b0:abf:7919:4990 with SMTP id
 a640c23a62f3a-ac252f8d731mr2395632866b.35.1741806197863; 
 Wed, 12 Mar 2025 12:03:17 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac291796eccsm610594166b.25.2025.03.12.12.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 12:03:17 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 87BC05F767;
 Wed, 12 Mar 2025 19:03:16 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH] tests/functional: skip vulkan test if mssing vulkaninfo
Date: Wed, 12 Mar 2025 19:03:13 +0000
Message-Id: <20250312190314.1632357-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

I could have sworn I had this is a previous iteration of the patches
but I guess it got lost in a re-base. As we are going to call
vulkaninfo to probe for "bad" drivers we need to skip if the binary
isn't available.

Fixes: 9f7e493d11 (tests/functional: skip vulkan tests with nVidia)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/test_aarch64_virt_gpu.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index f19a47f8b6..314d994a7a 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -115,6 +115,7 @@ def test_aarch64_virt_with_virgl_blobs_gpu(self):
         self._run_virt_weston_test("glmark2-wayland -b:duration=1.0")
 
     @skipIfMissingCommands('zstd')
+    @skipIfMissingCommands('vulkaninfo')
     def test_aarch64_virt_with_vulkan_gpu(self):
 
         self.require_device('virtio-gpu-gl-pci')
-- 
2.39.5


