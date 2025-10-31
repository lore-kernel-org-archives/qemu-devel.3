Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B507CCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnhh-0007WV-0e; Fri, 31 Oct 2025 07:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vEnhd-0007Uv-2r
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:53:57 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vEnhS-0005xZ-Rs
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:53:56 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b4736e043f9so369153266b.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 04:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761911620; x=1762516420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=brUq3/ArxO91G6+DeWcEGxfRqjtJMC2k/usTFUU+3E0=;
 b=UsmQdTHO1kAfMpgqT8o3TKezYRaAK/v++xsqV/vE+GPfZxkxhK6ekyWRJhO4GNOXAd
 pK6xO/iTknTei9bOczshwG81t+P5fKhVG5mwLpfkaHldkAY1OhjbVaoEPKzB5oinTEXS
 H0RxNMmrzlBRW9bvTK9j6r94Jy/Iqj7CaPTCYnXW6RCc8538cGMZXj8kdGWlFh/nkfCB
 OPGzc6/sriClBDV8mAOKZjueYYoaicE4o9vKirPqRZWrKXmzZdnyK33JW/QT0V1iZaZa
 WkkI+pzHFOQf0yYWLPcI6viOvVS5EMpLcDPt8MaHKoCa/tcBMu4Kw2tu4xNGeMt+PaNM
 qQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761911620; x=1762516420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=brUq3/ArxO91G6+DeWcEGxfRqjtJMC2k/usTFUU+3E0=;
 b=nC1/PZx/USe/gIFnx4gHlxLGeEXVvW46H5AX1ZTrDqqfU4cdsrYQ2yjVJJbwKjPpfX
 uAI93v3YuxITqqSHjX4e6Az4UoezkULx7rA7OMjNSSiChtfieHSuLxg97B8nNYHXuLEI
 KEU+Dexk3dWxFiRDQ5g/V5TTRgmPGW/mK8y2GDilciWmL/y3r2eOXTFOQZCTg+IKwGFG
 QB0V5uE2/ASvUECLx4j9y3GUrHTxzK4lEmXfutWHO607s+LyQpMjzzCEqMgBDGZvOVnY
 8PEaPXBQiA/n1vkNcjamdkgEMwbKoOfa1lT24me8mwSX5FSzwKTCUskLlzfQdTrZl3ng
 CSAg==
X-Gm-Message-State: AOJu0Yz28ifwNr+P+XAb7cPMr0eDXuZKfqe8Yia/Lzdh5abz8JqRqwZx
 BXgKiNFBo5a7XMhnZZ63LhCqXS068A4qLVynZTrCb2k2jztWS/E4POxJ8UkxmIcYn4evVzrET5i
 5IzE1bjk=
X-Gm-Gg: ASbGncusnGAvcwiGVQ5tXSHn24EMHM+UhsU4Nl6AKEZQn1Oed5r+SzS9OouEpSjtmzc
 mk1fudaKCUgiSONaRiwLj8VFS4igs45UCG5c1JbY3sdDr2Huj7ivGIkPCOF/rn9nbT6qQK31Hvm
 OSsnt+yrF7z6d9rLAYGOd4ZTh5kfiCQAwXOUyQMMPK7KpD9CP8MAsK67hKKGKXJ8IMb0dX9B9qZ
 ihIFMfIN1GidHLRVreFp+XEw+quatgYc3IkdmTl6A3UDtQHB5If13HS1n4YLZ3UJp0gEr+emO/3
 LbUv5K4ZwX8XQT3QkFo/YlafZumdanzmuzqX3B/KcdgcQDvwJIj2w9MHCkCbL8PesckZn8XyoaJ
 kvNLj+h8/UKoTNh5jct/GPHR5uPRQiJbfJwx9sEMJzH953fQ+DvUJIMKD0O+lNOHSNRlGETimI2
 BQ59AX3r9wGloCQCPQNg5sm5vrtZCs9rX0IBuTE1Aa
X-Google-Smtp-Source: AGHT+IETBdHyhBAEzcxw4Kuqss2KUFaEvmoma9wvCdkJSlr9v4DAgPKbPvAOG8qkB8tf79szV3BoYQ==
X-Received: by 2002:a17:907:ea8:b0:b70:68d7:ac0c with SMTP id
 a640c23a62f3a-b70705ec9a2mr316676866b.42.1761911619677; 
 Fri, 31 Oct 2025 04:53:39 -0700 (PDT)
Received: from stoup.. (C3239BBB.static.ziggozakelijk.nl. [195.35.155.187])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077975dcbsm158078366b.14.2025.10.31.04.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 04:53:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 3/5] tests/functional: Mark the MIPS replay tests as flaky
Date: Fri, 31 Oct 2025 12:53:31 +0100
Message-ID: <20251031115334.368165-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031115334.368165-1-richard.henderson@linaro.org>
References: <20251031115334.368165-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x630.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

MIPS test_replay.py often times out (likely hang) under GitLab CI:

  2/21 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-replay   TIMEOUT   180.12s   killed by signal 15 SIGTERM

The console.log file is empty, and recording.logs only shows:

  qemu-system-mips64el: terminating on signal 15 from pid 344

Since this is a long term issue affecting our CI, disable the tests.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251031094118.28440-2-philmd@linaro.org>
---
 tests/functional/mips/test_replay.py     | 2 ++
 tests/functional/mips64el/test_replay.py | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tests/functional/mips/test_replay.py b/tests/functional/mips/test_replay.py
index 4327481e35..747835bf00 100755
--- a/tests/functional/mips/test_replay.py
+++ b/tests/functional/mips/test_replay.py
@@ -5,6 +5,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import Asset, skipSlowTest
+from qemu_test import skipFlakyTest
 from replay_kernel import ReplayKernelBase
 
 
@@ -16,6 +17,7 @@ class MipsReplay(ReplayKernelBase):
          'linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb'),
         '16ca524148afb0626f483163e5edf352bc1ab0e4fc7b9f9d473252762f2c7a43')
 
+    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2013")
     def test_replay_mips_malta(self):
         self.set_machine('malta')
         kernel_path = self.archive_extract(self.ASSET_KERNEL_2_63_2,
diff --git a/tests/functional/mips64el/test_replay.py b/tests/functional/mips64el/test_replay.py
index 26a6ccff3f..05cc585f85 100755
--- a/tests/functional/mips64el/test_replay.py
+++ b/tests/functional/mips64el/test_replay.py
@@ -5,6 +5,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import Asset, skipUntrustedTest
+from qemu_test import skipFlakyTest
 from replay_kernel import ReplayKernelBase
 
 
@@ -16,6 +17,7 @@ class Mips64elReplay(ReplayKernelBase):
          'linux-image-2.6.32-5-5kc-malta_2.6.32-48_mipsel.deb'),
         '35eb476f03be589824b0310358f1c447d85e645b88cbcd2ac02b97ef560f9f8d')
 
+    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2013")
     def test_replay_mips64el_malta(self):
         self.set_machine('malta')
         kernel_path = self.archive_extract(self.ASSET_KERNEL_2_63_2,
-- 
2.43.0


