Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C983D35693
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 10:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl3G6-000266-3l; Wed, 28 Jan 2026 05:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vl3G4-00024t-Gb
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 05:58:48 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vl3G1-00029L-DX
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 05:58:48 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so55844115e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 02:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769597921; x=1770202721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WoBh5xYB4SiZR0MTlQgtfh1lto9+PJhfKJnE7vgrSa0=;
 b=ML7F9jma64W7gtohZvjW6TEJJzW4AtS9I8/gsd4SfkNR7izP3YurxvKWtS7mf76pZM
 qfKOmnqKt7gvUnsaLPety9WZKBhNpy1UavsJwZubrsRQwtz+6IqmV/SoqAlAj69Wxn+H
 Ob7Y3goMCdsful2A6K7LGlK8McGeNk6XGj1w1sYalNB9rY9vG5bMAdvc9wIeph2eVVmn
 ChLYQ+JuIJISHex7FDvn+NVkPFn2uYldlJ0joMg1Qb2y3FQtHRAhW5oyMlk3M8r0gIdy
 r0Pg420lVlzh8+AhCo+/C+h32ZBr05Ccbv+/MRWPTc1zvMBy8YA/PQ4W5U2eno1roUkt
 YUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769597921; x=1770202721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WoBh5xYB4SiZR0MTlQgtfh1lto9+PJhfKJnE7vgrSa0=;
 b=RzBPNvaTs81rK8q96BAY5qAZJsTyK5KkofolRf82lDbRJn4D+Q43inXDcM+Te7XHTc
 Zz7cSNZNh63uuHeJ0mvHfg0Hb+ZojkPzE1Mee/zubl7B2S6M75ayVmUYpaooftsmKQ9X
 7RdZMFGd6F1uMlrAOu4lMHGkoifkg2bSsrAXla4yaGDSTbE97Sq5yS04EtXnL4VwvWZr
 82jqNzk0v2mzmqb+aHGlCRaanNwX09EidXr3HjC9fkkO3ce06f0czAVmrWn6pQZHRDb8
 iSlkQ+oSKJdmZGN1aD8mQrdN0IanSI1njSCn06BLym/0qXCLSDekAhwBIpLGqNzCvzhP
 BRNA==
X-Gm-Message-State: AOJu0YyLJPN6CyIJIf748f84XfoWs5CLN88hFlE2nAplE8Fk6tk6lqmQ
 82c1EnIdbaXIYu9Bz20fLB0pSj2wRLGGFs05f12UPh54f2U8YO2bUYHCtl2i7wtva34=
X-Gm-Gg: AZuq6aIbehbVqgVM9VsNbYpymX9BU9kLZ0Y+NUybQBYBY/w8zspIuF2v69EuTxjyZh0
 UxPvClt3d/0JKepDeoQzMSwXXxLVJqrbhKvyGf3RWn9h+nVIphd4nWVttF07g1X1FpFoTeRg/B5
 u+Hm5XHjHafJMN72Nd95FCEd6B5oJ+YcNGAa0blp/yqWku12XB/pSS5Rx6/tlTSoQWaQHwQYkci
 t6KwbOirGY2qr4V0CPDvSn5cKp8RRc76rlSyAwUH8rCKQk17VoCwIJZPlmr1vmLrZbDfR1+pf82
 7hMJQoVXLkyvjiQx56vSjQfvZWKhUzi3yyDrL1J8Nmmzrs3xEA7qi4l6XObz4iqDsRkRrEUXJo5
 fmr2dgP5jnmYO2+hOCrrM/XtNpKb7EGV+Vmyz9KM6Bw6nF4ovfoWtr4eo01v48rm2cztVfw1Thi
 MVnQNtkNMVWMA=
X-Received: by 2002:a05:600c:3595:b0:477:a978:3a7b with SMTP id
 5b1f17b1804b1-48069c78bdamr62185265e9.22.1769597920943; 
 Wed, 28 Jan 2026 02:58:40 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm6881983f8f.13.2026.01.28.02.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 02:58:40 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9FE2D5F89A;
 Wed, 28 Jan 2026 10:58:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH 2/2] tests/functional: migrate sbsa_ref test images
Date: Wed, 28 Jan 2026 10:58:39 +0000
Message-ID: <20260128105839.3487840-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128105839.3487840-1-alex.bennee@linaro.org>
References: <20260128105839.3487840-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

As the builds in codelinaro.org are going away migrate the binaries to
share.linaro.org. As the hotlinks don't encode the filename we need to
explicitly tell uncompress how to handle the files.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/aarch64/test_sbsaref.py | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tests/functional/aarch64/test_sbsaref.py b/tests/functional/aarch64/test_sbsaref.py
index d3402f5080a..48f1b7a86b8 100755
--- a/tests/functional/aarch64/test_sbsaref.py
+++ b/tests/functional/aarch64/test_sbsaref.py
@@ -31,10 +31,10 @@ def fetch_firmware(test):
     """
 
     # Secure BootRom (TF-A code)
-    fs0_path = test.uncompress(Aarch64SbsarefMachine.ASSET_FLASH0)
+    fs0_path = test.uncompress(Aarch64SbsarefMachine.ASSET_FLASH0, format="xz")
 
     # Non-secure rom (UEFI and EFI variables)
-    fs1_path = test.uncompress(Aarch64SbsarefMachine.ASSET_FLASH1)
+    fs1_path = test.uncompress(Aarch64SbsarefMachine.ASSET_FLASH1, format="xz")
 
     for path in [fs0_path, fs1_path]:
         with open(path, "ab+") as fd:
@@ -54,15 +54,11 @@ class Aarch64SbsarefMachine(QemuSystemTest):
 
     timeout = 180
 
-    ASSET_FLASH0 = Asset(
-        ('https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/'
-         '20241122-189881/edk2/SBSA_FLASH0.fd.xz'),
-        '76eb89d42eebe324e4395329f47447cda9ac920aabcf99aca85424609c3384a5')
+    ASSET_FLASH0 = Asset('https://share.linaro.org/downloadFile?id=kyoMLGC9zXa4oA7',
+                         '76eb89d42eebe324e4395329f47447cda9ac920aabcf99aca85424609c3384a5')
 
-    ASSET_FLASH1 = Asset(
-        ('https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/'
-         '20241122-189881/edk2/SBSA_FLASH1.fd.xz'),
-        'f850f243bd8dbd49c51e061e0f79f1697546938f454aeb59ab7d93e5f0d412fc')
+    ASSET_FLASH1 = Asset('https://share.linaro.org/downloadFile?id=Dj1HRXnDnKtU6Nj',
+                         'f850f243bd8dbd49c51e061e0f79f1697546938f454aeb59ab7d93e5f0d412fc')
 
     def test_sbsaref_edk2_firmware(self):
 
-- 
2.47.3


