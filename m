Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E21C83F34
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 21:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubn92-0002WW-Oh; Tue, 15 Jul 2025 17:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubn7x-00026z-Bm
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 17:23:54 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubn7r-0001or-8y
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 17:23:53 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-74b54af901bso3862168b3a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 14:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752614625; x=1753219425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xfF2qpw8sQPpJGgpe/MPDF+JcTMR6+n/UOivbIi70EY=;
 b=J5M00cwh7p1CZL5NpqJgizSGrvKwJon56OdAF2yqtTYB0aAg6D6TOH8LuJaV1wVGfw
 Vvqwzqo7GkyE3RaJzpJ4JbrGU95o+a6DpnytPW5ONS/u9nl2NM0JN7umCnQXYX1sUYhF
 9vsfyQfo6G6bSGwKQIEGctrtIntAgiv4KsyZnSmWINQAil4/aS5MlEAyXxPg+llG0lAQ
 qn/txcWOvwVDf1HRPQbpnDFg8mmHzjIOSNwTFKN8LngtIm0SkaZt9YSYmNwMbHX9rtnR
 wwu2pd/l0YRgjUapzP0j+Ju9lyrZYc9uQIFvJTdRvHstAbRn3hUQWzx4XJmD3WMGlUL+
 fExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752614625; x=1753219425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xfF2qpw8sQPpJGgpe/MPDF+JcTMR6+n/UOivbIi70EY=;
 b=UFyxifviAhWFJAX9go+BUBJipkweYal8PAjP2j59v73oBzx34yneNndQoZ4QqH8Ay1
 HS828dDnnpxeyJHvcxgmV/2FBreF/4M89va6M+Lc7NkN+Hpj0E/IJG9WVWQ1lukhVFrb
 +WcuqgWYM7dHuIIqrBwHcTR/5LsvKjJXoxdqncMykSk2ZB1nvTe27WdPlr2sxQbsUNqb
 MPURxJV0I4XnewAerdh0eMAbDKNpL15bOWiJaEpadv5vBgk5UPm33hmZqUmZwspz1m82
 9p+rMQm3jtj5o5aIC7/CZaD2rVJnqnvlGiMPYlFJ7b/mfjiU6m9bT7oahpT3BX0l3SOe
 CO8Q==
X-Gm-Message-State: AOJu0YxTc2GYuZXoKBUyw1guLVizxFQXZY/d7fYJ3ewnEXD10mcK3hZO
 B6bHt898BB9txaGx1jUFWZ5npMkoYhMS2dE2LV06IJeWIB3w9ldSa4zJ27Jve30lnbFIqZl3jpf
 zQ80U
X-Gm-Gg: ASbGncsSeOtOPQwC7yyyIiCbHwneC0n8plDqMAtkZ38mVFASxenrxL4wXdMtUV7fZwZ
 3y+8MF8xGh4RpuHLbBGdrfG1J9SuiRU28pn1ijvfG11tI6qD6lIZtuUFjGfodrJEzWiBPBmK/Ph
 ZrZyb6mhj33Kc2VA6OaMDeHc0pDoE+rd088L3cfsWaoMVtYNWv6WmPEIVeUcFB/SnS9drv72GCy
 fZ3I4W8ePs+8AaMABVRgJ0xftgNYtD0F3lfUqmgOsFayUZdpMASo1TZkBSF47q+gTPmf4QG4KW2
 MlZJ/BZIAqJ0/x4UwPCuKilcjfzHxdNAEmjari7opxl72Js3uWojtc1rSnsykg/WxsDuGePNJw2
 l2bVl4R1nt/9xrtgPkQZleUTyKkCcHYz+
X-Google-Smtp-Source: AGHT+IFDd3admL/lcughk7K9B6qVTSJLdGC7Yt+F+y+lgbcy+SNYgBDvNJHcR8MpNygXdy2TzuC77w==
X-Received: by 2002:a05:6a20:7d8b:b0:220:5c12:efa3 with SMTP id
 adf61e73a8af0-237d89607dcmr1224414637.38.1752614624746; 
 Tue, 15 Jul 2025 14:23:44 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f4b16fsm12281708b3a.120.2025.07.15.14.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 14:23:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, jean-philippe@linaro.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, gustavo.romero@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 2/2] tests/functional/test_aarch64_rme: update image
Date: Tue, 15 Jul 2025 14:23:35 -0700
Message-ID: <20250715212335.2215509-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250715212335.2215509-1-pierrick.bouvier@linaro.org>
References: <20250715212335.2215509-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

TF-A needs to be patched to enable support for FEAT_TCR2 and
FEAT_SCTLR2. This new image contains updated firmware.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/functional/test_aarch64_rme_sbsaref.py | 9 +++++----
 tests/functional/test_aarch64_rme_virt.py    | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/tests/functional/test_aarch64_rme_sbsaref.py b/tests/functional/test_aarch64_rme_sbsaref.py
index 746770e776d..70737d3d599 100755
--- a/tests/functional/test_aarch64_rme_sbsaref.py
+++ b/tests/functional/test_aarch64_rme_sbsaref.py
@@ -21,10 +21,11 @@ class Aarch64RMESbsaRefMachine(QemuSystemTest):
     # Stack is built with OP-TEE build environment from those instructions:
     # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
     # https://github.com/pbo-linaro/qemu-rme-stack
+    # ./container.sh ./build_sbsa.sh && ./archive_artifacts.sh sbsa sbsa.tar.xz
     ASSET_RME_STACK_SBSA = Asset(
-        ('https://fileserver.linaro.org/s/KJyeBxL82mz2r7F/'
-         'download/rme-stack-op-tee-4.2.0-cca-v4-sbsa.tar.gz'),
-         'dd9ab28ec869bdf3b5376116cb3689103b43433fd5c4bca0f4a8d8b3c104999e')
+        ('https://fileserver.linaro.org/s/gW3mmtC4ZQaxNJ2/'
+         'download/sbsa_cca_v10.tar.xz'),
+         'b6ec3435a459eb298f221beb5073e485f290d38055d0aafbcff7d8e7c334aa73')
 
     # This tests the FEAT_RME cpu implementation, by booting a VM supporting it,
     # and launching a nested VM using it.
@@ -38,7 +39,7 @@ def test_aarch64_rme_sbsaref(self):
         stack_path_tar_gz = self.ASSET_RME_STACK_SBSA.fetch()
         self.archive_extract(stack_path_tar_gz, format="tar")
 
-        rme_stack = self.scratch_file('rme-stack-op-tee-4.2.0-cca-v4-sbsa')
+        rme_stack = self.scratch_file('.')
         pflash0 = os.path.join(rme_stack, 'images', 'SBSA_FLASH0.fd')
         pflash1 = os.path.join(rme_stack, 'images', 'SBSA_FLASH1.fd')
         virtual = os.path.join(rme_stack, 'images', 'disks', 'virtual')
diff --git a/tests/functional/test_aarch64_rme_virt.py b/tests/functional/test_aarch64_rme_virt.py
index 8452d27928f..fcc321b6006 100755
--- a/tests/functional/test_aarch64_rme_virt.py
+++ b/tests/functional/test_aarch64_rme_virt.py
@@ -49,10 +49,11 @@ class Aarch64RMEVirtMachine(QemuSystemTest):
     # Stack is built with OP-TEE build environment from those instructions:
     # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
     # https://github.com/pbo-linaro/qemu-rme-stack
+    # ./container.sh ./build_virt.sh && ./archive_artifacts.sh virt virt.tar.xz
     ASSET_RME_STACK_VIRT = Asset(
-        ('https://fileserver.linaro.org/s/iaRsNDJp2CXHMSJ/'
-         'download/rme-stack-op-tee-4.2.0-cca-v4-qemu_v8.tar.gz'),
-         '1851adc232b094384d8b879b9a2cfff07ef3d6205032b85e9b3a4a9ae6b0b7ad')
+        ('https://fileserver.linaro.org/s/YpLmzLNL6BAxYL8/'
+         'download/virt_cca_v10.tar.xz'),
+         'bc432c92d62f3cd3542a943cd5a6329b2464c986f8f5dc48f727a0e5386a0e95')
 
     # This tests the FEAT_RME cpu implementation, by booting a VM supporting it,
     # and launching a nested VM using it.
@@ -66,7 +67,7 @@ def test_aarch64_rme_virt(self):
         stack_path_tar_gz = self.ASSET_RME_STACK_VIRT.fetch()
         self.archive_extract(stack_path_tar_gz, format="tar")
 
-        rme_stack = self.scratch_file('rme-stack-op-tee-4.2.0-cca-v4-qemu_v8')
+        rme_stack = self.scratch_file('.')
         kernel = os.path.join(rme_stack, 'out', 'bin', 'Image')
         bios = os.path.join(rme_stack, 'out', 'bin', 'flash.bin')
         drive = os.path.join(rme_stack, 'out-br', 'images', 'rootfs.ext4')
-- 
2.47.2


