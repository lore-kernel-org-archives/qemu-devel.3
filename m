Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3059BCA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfoo-0003nO-GO; Mon, 05 Oct 2026 06:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmH-0002GI-Ci
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:38 -0400
Received: from mail-wr2-x0e.google.com ([2a00:1450:4864:30::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmD-0000w6-Es
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:34 -0400
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48b01c41135so1008082f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195510; x=1791800310; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uBan2vPnuxZmPsBXKSBaOr/VE/70/QAtNwrFSmFxYy0=;
 b=OzEMMs0utPct/CFwCYkglLVxgsJtBXvhRrpy3DCrNJcnvtMvEk/o8q5zOqv8IwclcK
 dnR2tO2wB802k2HOVum+S3VUf6i/jAIZUSfjtKvPZ+K/1xX368QFMe+KBOmmTxb9q5au
 YjrzBdACUKUPrKX5Rm36st7alheEfeoNxUT6EN7bpnTy7NqqU+9d0zao+sPWvKy2W5En
 b3EmRvNss/Q5Y/bqzs1g7r7Z4CYYdhB0Trk9EU7V/NSzSKca7ZOPkRdkn91FPbj6Hkma
 OmvQrVpnUrz26AGIqunNzk8xjkLngKkicXZJM+HZKmTFjo0sYNhTE0oEx5Icxta/+DA0
 qGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195510; x=1791800310;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uBan2vPnuxZmPsBXKSBaOr/VE/70/QAtNwrFSmFxYy0=;
 b=ykSI4F25vozTNH8Gz1YNbnk6+InHGhCMaFNu48GE/3kwP+nT5b9jzx1sBL9yUKknpo
 mHSI/26/xOUPTkIyrn248gpFy2Kbx9sR3TtDZWjgmcdxaVr+hwZ6SiifD+S08edbXzEY
 JYU72CcQ0fPl7TsG2IPnLcqFlYLlDIz/QK3YqBJJb+N4kUGoXohkjg9WN5MjJMyTLq67
 xpA5axdpmGlkT9rywmaejRLxUQpX+cztZqMJQ3eASTcJlv35hM7hteHqcjCy9bKsaPmw
 37Xb/XvUCwNp+jvKsx/03Wcqm2kHjQBHxvedhE1pB03jx1VfyLtS2o4heULjDPy1Dsbb
 qhAw==
X-Gm-Message-State: AFq9FYJOYb+Hn61s6wPj9kCmBClCGQYtAhwIIlPYTW7+grSU5jN9rzeE
 tVdLYxMhwKt56Ee8jJGrCogFL4yFDcM0DbIO7aNdSkKOC6gXm/mIchalgllu7g==
X-Gm-Gg: AYBFou1DxI9GwBEh8v2hbp7xVL82oArBpqjzgDoal3SNdBTE0Ehxd43zAbuYpuLe966
 zzPuH0T/t6Aiiuj/rllpWgvKHJJDZc7ZNOhxjt4gXD/q1crdL3MOTy0Ivi9cXMvx0LGslCRC3+p
 oDeBY2FmiLvyWbiholcshbqCtvsBfmSDpzxPR+UpuoHFoyTtTQov0c4ttU4mUFOtpgKiPc1llJ9
 QWIwfYmP7mnlpMuqTS9JRtXwy4qhpoFUl2y9+xaU0kV/jb1H2HggGCju+CIAj3b1Xuo0uSrR+sV
 wlRrH9/ZRnUBvvjruN+qdtwFApEJiTXyy+eWWcGZG51sEYfYA0p3BxJm0v0Gfgy4lb0GoLtakHk
 S0CgBB3dS8/u3yUWDKXMYtYzfBnFiQQQfh7afUetowTNEhg1ke/cZ7jkp0j5rjQH5R6q8ay+0oT
 PaAjWNaO3GiYZUhXSVNOME1Syb2N/YLNA2dNnK9ZrmPtXbdpuiN8PgCze8gsR2HT92+s2LufMsN
 KcNytlxJuqRpJK7SSH/9l9YZbY4S2k2fuuQHQ==
X-Received: by 2002:a05:6000:40de:b0:48b:d2d:2fcc with SMTP id
 ffacd0b85a97d-48b1272d0c6mr17135319f8f.9.1791195510440; 
 Mon, 05 Oct 2026 03:18:30 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:28 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 06/31] docs,
 tests/functional: Drop redundant CLI arguments in imx8m*-evk
 invocations
Date: Mon,  5 Oct 2026 12:17:33 +0200
Message-ID: <20261005101800.10821-7-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::e;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Both boards provide defaults matching real hardware. No need to ask
users to repeat these. Also, remove these redundant arguments from the
functional tests such that the defaults get tested.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8m.rst                   | 2 +-
 tests/functional/aarch64/test_imx8mm_evk.py | 4 +---
 tests/functional/aarch64/test_imx8mp_evk.py | 4 +---
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/docs/system/arm/imx8m.rst b/docs/system/arm/imx8m.rst
index 1bcb8255be..5348757089 100644
--- a/docs/system/arm/imx8m.rst
+++ b/docs/system/arm/imx8m.rst
@@ -79,7 +79,7 @@ For i.MX 8M Mini EVK:
 
 .. code-block:: bash
 
-  $ qemu-system-aarch64 -M imx8mm-evk -smp 4 -m 2G \
+  $ qemu-system-aarch64 -M imx8mm-evk \
       -display none -serial null -serial stdio \
       -kernel Image \
       -dtb imx8mm-evk.dtb \
diff --git a/tests/functional/aarch64/test_imx8mm_evk.py b/tests/functional/aarch64/test_imx8mm_evk.py
index 86725991f1..73d286167c 100755
--- a/tests/functional/aarch64/test_imx8mm_evk.py
+++ b/tests/functional/aarch64/test_imx8mm_evk.py
@@ -52,9 +52,7 @@ def test_aarch64_imx8mm_evk_usdhc(self):
         self.require_accelerator("tcg")
         self.set_machine('imx8mm-evk')
         self.vm.set_console(console_index=1)
-        self.vm.add_args('-m', '2G',
-                         '-smp', '4',
-                         '-kernel', self.kernel_path,
+        self.vm.add_args('-kernel', self.kernel_path,
                          '-initrd', self.initrd_path,
                          '-dtb', self.dtb_path,
                          '-append', 'root=/dev/mmcblk2p1',
diff --git a/tests/functional/aarch64/test_imx8mp_evk.py b/tests/functional/aarch64/test_imx8mp_evk.py
index 99ddcdef83..2ec421c326 100755
--- a/tests/functional/aarch64/test_imx8mp_evk.py
+++ b/tests/functional/aarch64/test_imx8mp_evk.py
@@ -52,9 +52,7 @@ def test_aarch64_imx8mp_evk_usdhc(self):
         self.require_accelerator("tcg")
         self.set_machine('imx8mp-evk')
         self.vm.set_console(console_index=1)
-        self.vm.add_args('-m', '2G',
-                         '-smp', '4',
-                         '-kernel', self.kernel_path,
+        self.vm.add_args('-kernel', self.kernel_path,
                          '-initrd', self.initrd_path,
                          '-dtb', self.dtb_path,
                          '-append', 'root=/dev/mmcblk2p1',
-- 
2.56.0


