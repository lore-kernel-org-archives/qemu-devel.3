Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AB9CC6B2D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 03:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHC0W-0007WP-F0; Wed, 14 Oct 2026 23:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xHC0E-0007JP-5a
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:19:34 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xHC0C-0006qc-6n
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:19:33 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2e9400d26b5so1091465ad.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792034371; x=1792639171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=04jqFmSmXZGpxWe2Ay1u5AkgLCvCI4RMq9GKToAG5EI=;
 b=ebuQ1APotJQZL7dOoU/zDPoJi5MY0tvHzcxrlkRqD1jLffQ1EmFNmP4Wgd2RS87R4e
 KPTdIWNSUuaxikHfcSuAFYBvSk2xB/kWEa6HYvRbYCMoY+5Rf3xyKNHXo5Hy0yb+kAI/
 5thiXKWJCgPwxcjDXeZyIX5uAwJ6Qmarqp8Wa8+fNRW+fJ0NktfvmJOktz2B+SeBm/+x
 EiibWMMdBRyPKpw8sB8bXUVBiqqnPkiT+Ge98cM9deP5RUdEETcC9kDf5F2M9IdbV5EA
 RaJKDJCM508BxztgPErpqBF2E39eEnOhbZmw/yKHaJ1qk8Hyf6tNWgdJJnas/c7mD8pN
 Z3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792034371; x=1792639171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=04jqFmSmXZGpxWe2Ay1u5AkgLCvCI4RMq9GKToAG5EI=;
 b=TsIB2Dqqt6whZgvPPkmNZE5SoNiLlWhl/k1rQCsqD/joJbHPN50mYuOMUSKH3v+oou
 UcR4hhM44UfIAuubQso/e/6dk99TEIlQGbsDURoNgpDAl1BNyZRQmqQcUlIjrPn4mknD
 BftCPcW3Z+NmqUcy9Da9SmDCEQTS2EjSFc+q9pmFKCKjoM87YXPFiIfu1Zv1pAxoVR4P
 BI0NOF6OSG5MxlD3ewJF0usRdbMi0SVFeExzKvK46SPlLHXeWbuTtewOulvFoZ3nbTYK
 guZItbJth3TsfvlQfAG4Nf5CTtJYQs3dGfphdbjlKaFDqWtgkF3bZAdizVuo3HrzM+4q
 RA1A==
X-Gm-Message-State: AFq9FYKaxsjXGKFIU/vu7HthM9i/Wmd2pw4gn9Iqz69X1/YRr6nBTcpA
 PsJP5w+2PvAQGtaJzyw4TYToKPxSGHF3DB3q3ijcDLgzQCVj+t1NZ10ecVTIpAth7SoRC+eE4Lw
 SsMDO1CI=
X-Gm-Gg: AYBFou3rdPBSC5hbkSClyD0peFXLzwV1iKylxwKdsOmsCJBdoEPrXlQ8cYJMGp37edG
 u02anaF/bsHEyNqtPgmmf++PcmTARr2j05Ck9IaqILaDTFbUThTvgXyGiI6rjbNAr6IOnwPrdfP
 b0BPl7xXdbv1ZdNf0PLMBLOY1a4WLvjT+wxk9EWHBH2HBlPG2887KczS8Kdg4AizNCKAdFD3RMO
 YySRDgxH4mPml6EnsDDlC8MiXYBd9ykOvnT4IXTltuCeG+tJg0YAwAUR1DY2VU8hpURhUaeodV6
 4Up80t1Wrfonog8Blpz8l+cQZi3fT1kLYhWUivMXfiZWj02Y8H8jFZJUbI8qnmMhygVa1oYLYgq
 qrJ7Wl31fTzSHCX4qr4iMhICiTC7iSkamSGOQvZO/A3rpSe6G2QQ9PynMMHjLa+7NbsqqHm67ai
 401EpKV6vQXo4YtOQrvU1mLSn0sFM8Kh7ZhANcmaq1w3IzakaD0P/rKY3g8DO7S7q9SK0pgeExO
 CQDuntN++3dsjVyT+2xonGOD5+A8vM9kcEb6yeHYy2U/Y0=
X-Received: by 2002:a17:90a:cf:b0:3ac:77a2:18b1 with SMTP id
 98e67ed59e1d1-3ac77a21d44mr3221716a91.5.1792034370666; 
 Wed, 14 Oct 2026 20:19:30 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac93049ec2sm1321725a91.1.2026.10.14.20.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 20:19:30 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>
Subject: [PATCH 11/12] tests/functional/riscv64: Add rcpu to tt-atlantis tests
Date: Thu, 15 Oct 2026 13:18:03 +1000
Message-ID: <20261015031804.2406055-12-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
References: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=portias@tenstorrent.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

This updates the tt_atlantis test to test Ascalon boot with the rcpu
enabled and disabled. There is currently no code executing on the rcpu
but this tests that the rcpu model does not break Ascalon boot.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 tests/functional/riscv64/test_tt_atlantis.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/functional/riscv64/test_tt_atlantis.py b/tests/functional/riscv64/test_tt_atlantis.py
index 48abd5cd27..ec5d560811 100755
--- a/tests/functional/riscv64/test_tt_atlantis.py
+++ b/tests/functional/riscv64/test_tt_atlantis.py
@@ -22,8 +22,10 @@ class TTAtlantis(LinuxKernelTest):
          'rootfs.ext2.gz'),
         'b6ed95610310b7956f9bf20c4c9c0c05fea647900df441da9dfe767d24e8b28b')
 
-    def do_test_riscv64_tt_atlantis(self, connect_disk):
+    def do_test_riscv64_tt_atlantis(self, connect_disk, rcpu):
         self.set_machine('tt-atlantis')
+        if rcpu:
+            self.machine += ',rcpu=on'
         kernel_path = self.ASSET_KERNEL.fetch()
         rootfs_path = self.uncompress(self.ASSET_ROOTFS)
 
@@ -48,9 +50,13 @@ def do_test_riscv64_tt_atlantis(self, connect_disk):
         self.vm.launch()
         self.wait_for_console_pattern(pattern)
 
+    def test_riscv64_tt_atlantis_rcpu(self):
+        # test with the rcpu enabled
+        self.do_test_riscv64_tt_atlantis(False, True)
+
     def test_riscv64_tt_atlantis(self):
         # tt-atlantis machine has no PCI host yet, so no disk
-        self.do_test_riscv64_tt_atlantis(False)
+        self.do_test_riscv64_tt_atlantis(False, False)
 
 
 if __name__ == '__main__':
-- 
2.43.0


