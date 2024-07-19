Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5040C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 23:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUwsG-00019e-Jf; Fri, 19 Jul 2024 19:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sUwsF-00013w-Hi; Fri, 19 Jul 2024 19:18:51 -0400
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sUwsD-0006Sv-7j; Fri, 19 Jul 2024 19:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1721431125; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=HtsVuoHwd0mYvX2N/fIWnXkcPbJ0s9ry91GtSvTE2T4=;
 b=mXKkKJ8AI76G45HfkrdJtOq0kD2EUbDbegqhjSw34gVc4W3KOGNLM6TS0nVBaSTsI9HOz8Zh6z89z+KHM9MMzRGKeoCZny4YWkZpVkTGZsLhRfTcEQyQUMDdCOd2OAYIo3D+xjOizaPqY2Y0M0us4jwlmJphJw1oI9MycY43Ixs=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R991e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045046011;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0WAspz2f_1721431123; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WAspz2f_1721431123) by smtp.aliyun-inc.com;
 Sat, 20 Jul 2024 07:18:44 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: [PATCH v6 8/8] tests/avocado: Boot Linux for RV32 cpu on RV64 QEMU
Date: Sat, 20 Jul 2024 07:11:49 +0800
Message-Id: <20240719231149.1364-9-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240719231149.1364-1-zhiwei_liu@linux.alibaba.com>
References: <20240719231149.1364-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

make check-avocado AVOCADO_TESTS=tests/avocado/tuxrun_baselines.py: \
TuxRunBaselineTest:test_riscv64_rv32

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 tests/avocado/tuxrun_baselines.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index 736e4aa289..589c7f254b 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -533,6 +533,22 @@ def test_riscv64_maxcpu(self):
 
         self.common_tuxrun(csums=sums)
 
+    def test_riscv64_rv32(self):
+        """
+        :avocado: tags=arch:riscv64
+        :avocado: tags=machine:virt
+        :avocado: tags=tuxboot:riscv32
+        :avocado: tags=cpu:rv32
+        """
+        sums = { "Image" :
+                 "89599407d7334de629a40e7ad6503c73670359eb5f5ae9d686353a3d6deccbd5",
+                 "fw_jump.elf" :
+                 "f2ef28a0b77826f79d085d3e4aa686f1159b315eff9099a37046b18936676985",
+                 "rootfs.ext4.zst" :
+                 "7168d296d0283238ea73cd5a775b3dd608e55e04c7b92b76ecce31bb13108cba" }
+
+        self.common_tuxrun(csums=sums)
+
     def test_s390(self):
         """
         :avocado: tags=arch:s390x
-- 
2.25.1


