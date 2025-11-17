Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC42CEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxpf-0008RV-2V; Mon, 17 Nov 2025 06:55:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpb-0008MB-Nb
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:39 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpV-0005io-JA
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:39 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so30896585e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 03:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763380532; x=1763985332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bOOLp9RotIMjyhi6C/JbSM8N/Ln7kFnaMLGlM32ws2s=;
 b=er/IbgCNn0oH9LqHAeNGlfeWstsrYsNRADQV45sOhjyJW7+RkKXkZS+EZPoE9D2dgp
 Os/zIzJ+DBGilVY/m7c9FYDHQcRZqsxozQZQv09HmTgWD/xPoFR7dvFjZe38jJEAjsXo
 M3rPZWNGgrPuwt3r2kkl6xLhPgZ5PWKD53v5y5sZ97NEoKq5LNdesKG7m/OWY5a/rUV9
 +fwz2JYjoPub6Cwz9N8r3sWdfTf0I3GsGJ0ALKOSW8dZC8AePN7AcmIYeBSXaRUPoFU/
 GPiDCVBrsWtawscvz9S07XEDlgbkWSHqopVkls9glCP1xmiW3BCT8E3dzmrGBz5jswEt
 sdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763380532; x=1763985332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bOOLp9RotIMjyhi6C/JbSM8N/Ln7kFnaMLGlM32ws2s=;
 b=f/YNmVeggohCLnV+X1cy9/JvLZqB4usLEb0tafmszs1ttKXueAymfTagN1MyfaxbRU
 lhr9EVgbaw+DUc8vd6sqo5RFeZ/zmuzcD5CaJBwd2yCrifliTdB6PMU2jNigjUgDcwYU
 Ht2RHrQ14mrWq1MszuNw/7zhrbbzWMwwSBig/VECZWJqX3k1DSk0qhWhf6ye9qr/DHTr
 2HX64F8WVL50d2XipZ6+YyX/S30Rj0H9fJ6R+tnDX3gqRYfew8tVL704L2Nuv20bgQIl
 53UdRx2R/Dd77TORoaKH1G9DVuCPIYJ+mzEzzsiYgY1czt19NgHcOD4z/xpygY7VqpXn
 GZiQ==
X-Gm-Message-State: AOJu0YwQYDJdUmBvFvFre0XmDwm5YIgeooG+FfOBxPgyx8KpxlXwT2TE
 CfKaAchTgx2OYgNb7/Ywx5EPB3TfSAcOjPyzo/c3v/HI7igL70HFY6Ek2Mfe0dJnitQ=
X-Gm-Gg: ASbGnctCypXnvkh/gS3+Rf6YOCM18FeVj/GnJUp0wjIswNJBqDIU8CX9FSpconaTXZp
 J+Ys8JWfEzFPpKWPfzUCzaTDFeEY4u91Hqx9bgJ1E12S/qOa/OagJGAUDanyYLGmrTZ5428rtUu
 XHP+MGahaZQStcuZiX/6tf/FQYmlsML6xiiSy82cZvOYCtm/HeZWEJQmLCjysWCtIKdskaHxfhG
 bSYLdCDhOGnavxhEpVeJdFQrAGElMLPL/51PbV5Uzj4u7EH//dzmR0tjy+l5Gk3R68r/Txl/Vsr
 E4x5t1iYerGGYYX9Fzh6koXq4gr0fVuIKxf2i6ZSIunTnN29degjgp7qCSFZkF9CdiyR/jPno/x
 cqGdg1qdJNGYDnJSr9e77+ZgQ9NR1Hc/CtvnoSILzW4RY7fDPfJ05ZnDyA6nA6tfRUpRYAcolPU
 0z
X-Google-Smtp-Source: AGHT+IGIY9G6mMWLqbj74djXso//omAIa7KxSHOgB3JwfZUWzTXEfSpEvD26zTyHbX4ouPmvHpN1lg==
X-Received: by 2002:a05:600c:3512:b0:471:15bb:ad7b with SMTP id
 5b1f17b1804b1-4778fe5ecf9mr114602475e9.6.1763380531860; 
 Mon, 17 Nov 2025 03:55:31 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a81c567bsm1240475e9.9.2025.11.17.03.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 03:55:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2FC1E5FA14;
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
Subject: [PATCH v3 09/18] tests: move test_kvm_xen to share.linaro.org
Date: Mon, 17 Nov 2025 11:55:14 +0000
Message-ID: <20251117115523.3993105-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117115523.3993105-1-alex.bennee@linaro.org>
References: <20251117115523.3993105-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Cc: qemu-stable@nongnu.org
Message-ID: <20251113102525.1255370-11-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/x86_64/test_kvm_xen.py | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/tests/functional/x86_64/test_kvm_xen.py b/tests/functional/x86_64/test_kvm_xen.py
index a5d445023c9..424d4b20010 100755
--- a/tests/functional/x86_64/test_kvm_xen.py
+++ b/tests/functional/x86_64/test_kvm_xen.py
@@ -23,18 +23,11 @@ class KVMXenGuest(QemuSystemTest):
     kernel_path = None
     kernel_params = None
 
-    # Fetch assets from the kvm-xen-guest subdir of my shared test
-    # images directory on fileserver.linaro.org where you can find
-    # build instructions for how they where assembled.
-    ASSET_KERNEL = Asset(
-        ('https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/download?'
-         'path=%2Fkvm-xen-guest&files=bzImage'),
-        'ec0ad7bb8c33c5982baee0a75505fe7dbf29d3ff5d44258204d6307c6fe0132a')
-
-    ASSET_ROOTFS = Asset(
-        ('https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/download?'
-         'path=%2Fkvm-xen-guest&files=rootfs.ext4'),
-        'b11045d649006c649c184e93339aaa41a8fe20a1a86620af70323252eb29e40b')
+    ASSET_KERNEL = Asset('https://share.linaro.org/downloadFile?id=UG0V8dzzHrrHb9X',
+                         'ec0ad7bb8c33c5982baee0a75505fe7dbf29d3ff5d44258204d6307c6fe0132a')
+
+    ASSET_ROOTFS = Asset('https://share.linaro.org/downloadFile?id=VwLRKDXKFl6oKti',
+                         'b11045d649006c649c184e93339aaa41a8fe20a1a86620af70323252eb29e40b')
 
     def common_vm_setup(self):
         # We also catch lack of KVM_XEN support if we fail to launch
-- 
2.47.3


