Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5830AC28B2F
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr26z-0003FW-8Z; Sat, 08 Mar 2025 16:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26w-0003Dl-7W
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:34 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26u-0000uR-Bq
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:33 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso2447127f8f.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470811; x=1742075611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OIaKC/SjxFs9P2m9mvZW+W0xEbrgWkgnWx8O8XlDy3g=;
 b=QLzF8vmU8/OcBX2nE+UF3y5tHz6zPJ4vMnMRVtkvxIQVLuW/5ZXCJI2WznCf5AupfM
 riM6rB8FRn4AcDBVmTNZaFZXsyWkEN+aKvtD/OijmtCgvM1BZyrK98IUYgLuEETvALi1
 a04OWTYpXIU8ik2xDHUHoh5HLSjwvwCFn8QEA0ZxNzb9KFuFxenZtkVO5hE+MnVd0GRV
 snuv+t7pM7zc3XRyOA0HpWnoSaYZZ7cXQunlWjEfM2IOke8fuVqdXwzwEtCXzg1pv8sd
 08dFzgE/h/npeo2rEzXM63YzCv0ljFG5C9mjLAa/6Tnu1htZ1zpEjqOtRwyJ6lXoKM28
 J3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470811; x=1742075611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OIaKC/SjxFs9P2m9mvZW+W0xEbrgWkgnWx8O8XlDy3g=;
 b=JTAOrVxsh58d4aA+8WeEofpMCOQJtic2FM9xIlvkWTcGevRjHpOk+7Mkd4cfxHHxaO
 1qL/ZRXRz7FzI/s6fzEoOGOC7Gkeke48jWTBQhnqlhdB84qK86tcWDASq9/PPNCJmy0m
 JrjTdcyC/m2IWT7PrWsE/qEzK6b+L31XmLACraEcF6EH/wNMGcBCY/12qjnEvs73PKAi
 PipXpqp/4gA38ZEYjGxAeJ0+BVQUCSp0E+iQK7rEiDCWcoh4oW/jZZYdrZluaVRwO0WS
 7GCxFlYTufT5JWm6rTlTJz9an4Aj+Te8T8/2rw0h2WIxef1n5tNJ4rPlOO+UmWivZbC+
 S3og==
X-Gm-Message-State: AOJu0YyA2koGLUTtMvk468FScrSpqpGAlyhv8wyXEeGq46m3C0HGhbVD
 MV6R6D8Xsl6Zgkueq2WcpQtXufD0SOf24K5yG8CVq/qNDb+byeSfjRBl1qV4FH8=
X-Gm-Gg: ASbGncvS56mbSuZ0NkEowX2v88W6g9zHOe5Dq0VeLmLDYUzhpOHx1KtfT2t3Lw7E1ja
 Kg16jI1jva9YJAbLlHiGu6zATpgk2XV7m7L7T5YrJjdDpcaO2aAAqPvz7gAXMO0nGA27OLDsNOV
 a38Z9C6KthAYHNxzfX8eFlN4S/TXrg5mij4oldTgmGgXkX621OC+77D9PTC1jWfth6jhODY7LMi
 FsWQ7PZYT8UFVy5uoQnqOGVv3Bs7W71Goc7UXUMSU5guZ/Eo39Fp1mXXEcqKqWV/gq8WLjhz8SI
 nnRD5ECSdEStLlM8hP/FhJLTsdpCrL4Qk0NERtc2O4z7MlM=
X-Google-Smtp-Source: AGHT+IGxbVfTYRdbg3IigvV9WeMY2yrQ9q0eqNLlASEuIc5m6lIkrl4swX+7Ypn3JthiCeE1Jqf0VA==
X-Received: by 2002:a05:6000:2ac:b0:38d:e6b6:508b with SMTP id
 ffacd0b85a97d-39132d308b8mr4967926f8f.9.1741470810865; 
 Sat, 08 Mar 2025 13:53:30 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2b6asm10109790f8f.66.2025.03.08.13.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:30 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1725E601A1;
 Sat,  8 Mar 2025 21:53:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 06/31] tests/functional: expand tests to cover virgl
Date: Sat,  8 Mar 2025 21:53:01 +0000
Message-Id: <20250308215326.2907828-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

Add two more test modes using glmark2-wayland to exercise the OpenGL
pass-through modes with virgl. Virgl can run with or without the
hostmem blob support. To avoid repeating ourselves too much we make
the initial pass a simple --validate pass.

We might want to eventually add more directed tests and individual
features later on but the glmark/vkmark tests are a good general
smoke test for accelerated 3D.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-7-alex.bennee@linaro.org>

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index 32949f6a34..4a21d8c6cd 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -92,6 +92,28 @@ def _run_virt_weston_test(self, cmd, fail = None):
         full_cmd = f"weston -B headless --renderer gl --shell kiosk -- {cmd}"
         ec_and_wait(self, full_cmd, OK_CMD, fail)
 
+    @skipIfMissingCommands('zstd')
+    def test_aarch64_virt_with_virgl_gpu(self):
+
+        self.require_device('virtio-gpu-gl-pci')
+
+        self._launch_virt_gpu("virtio-gpu-gl-pci")
+
+        # subset of the glmark tests
+        tests = " ".join([f"-b {test}" for test in
+                          ["build", "texture", "shading",
+                           "bump", "desktop", "buffer"]])
+
+        self._run_virt_weston_test("glmark2-wayland --validate " + tests)
+
+    @skipIfMissingCommands('zstd')
+    def test_aarch64_virt_with_virgl_blobs_gpu(self):
+
+        self.require_device('virtio-gpu-gl-pci')
+
+        self._launch_virt_gpu("virtio-gpu-gl-pci,hostmem=4G,blob=on")
+        self._run_virt_weston_test("glmark2-wayland -b:duration=1.0")
+
     @skipIfMissingCommands('zstd')
     def test_aarch64_virt_with_vulkan_gpu(self):
 
-- 
2.39.5


