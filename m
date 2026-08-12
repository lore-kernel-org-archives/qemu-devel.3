Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A462C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7tm-0006Ge-8d; Wed, 12 Aug 2026 08:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7tO-0005MO-I8
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:17:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7tL-0000B2-Ia
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:17:09 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso12813605e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537026; x=1787141826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zLt5NhoC02lUEPdlMBnPNuumKFa4Kh+BTXUoMQJScfE=;
 b=ku8fc2pp/UPow6tavZZSAQyqzGARQPO4d1DeMOYdAkDLS9OzAgw6P7ZCiWAJeSexhr
 VoTMUYqGzmIQ7AUlTDU5xnEZFYMpQafAp/QH4BYi8P4Fu63bPmBCp2JCAckA1K+ipRZ0
 S6/HFcRXPEkU6Hu4NigxwI4ouj1sINKfMVMXZnFkzA+xm4LnIgnEL6fflOyPq/j0M4ZF
 xwk1hbpEVtZz9X/HN/c+qikDlOlPk2SfPhXmX6YwngE7FHOX8sop/76IKdJ+w+1CEI7o
 8XxNokD4AJ0DGeAYNHoWL0ZkYV2IhQnI7bryRjOkk14oRiB6elta8eM+V0HasMmo7m07
 OJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537026; x=1787141826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zLt5NhoC02lUEPdlMBnPNuumKFa4Kh+BTXUoMQJScfE=;
 b=LlccGxTN7uGSE20xVcFNHj4/8/5oZmGZXAR8rsRdSLqNrc81zMtYSwmnLa02HENCyh
 Myo8rw2/sz84UaYHDRbsGfoZeDndhJlcMgmrDiKFnXNRel4MBeGzxAxgAkxqRH0n5mSa
 SGvAtOX4Cx2J8Mp8FR+xg8SMs26Jje4JpNkDxdPGyRNMYNKTE31QoNDzHOOi2sJRAJqr
 UzHXHomoGvxz1jLaOpDW50aKeQFcO4Mc3Ya42UYrM1nQTa2wxoRRJ+rT42Ag6iArhvDS
 fZcs5GudhePYB75uJi1FJCmhz4WwckrTsH+vJ+MtqIlIFjTSRwg1K2wT98l11G8C3h9Y
 JKqg==
X-Gm-Message-State: AOJu0YyNoYgjDpCHEP4hzDfgVk21qv5TQZnDi69e/I2d5qo3bTybgZul
 LBhEg8dxE01mrf7Gu4FCroZ04Nb6tRg+pRlEDc+W8JcvisC27baTpbP0AE0aqSdQOa5qtQb1nd9
 k6/Qk
X-Gm-Gg: AR+sD12xiNwXsSJSL1klShyCEeLqK+L4pOLrtZoaVwxgYqLPOtDuQki+Dm5lscYkZLM
 W6Dz8P0raYBQkmh/7HIlbwa5+9x+zg3fPfFr4nH+/T7lZnJ7eQbdNCoQLfc2stnJFboybMETjKh
 A2MffC/DTOHrB0HS0IeBQCvX9jEuUs0QD+3Ko3I/BCV6AcRymGwiggDJb8lyemlg2Dvo+Seuin0
 k/Qzb3cEli7bGjE+kASj/uJ7UOHfbGNH3sBXr9yCOAqBrjqORj8RXMh6KHEKucC+B4olz0dYxBk
 R6+VuXrzZiVmnwYUvFfzAPahe1UKoQ20tcHkrP+KVESBuBx2R+5zU9IoRfrAPR26ySGpPb69VbH
 giRg11SQKdwKSajfZd8WYXBjvKAehWT0jHCZudi2nqkDz93o40LtwORI+vMy1zNsRtIUq7hiR50
 ffLC7HXCVmXTKlTIxIed3bF6ew2YlBCr+teTyXoQT62JygPhBAUspIxL0QEznu68CX21XQKZbr7
 srvGfmUEpgbyY/mrearsXDPsSIrrz304ykKmi3uX83Uuh0YPccgmurTYJuZed6XBZCETA==
X-Received: by 2002:a05:600c:4690:b0:490:c6c2:52 with SMTP id
 5b1f17b1804b1-4997c0fe67cmr57851845e9.3.1786537026117; 
 Wed, 12 Aug 2026 05:17:06 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.17.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:17:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/26] tests/functional/aarch64: add raspi4b full-RAM
 regression test
Date: Wed, 12 Aug 2026 13:16:22 +0100
Message-ID: <20260812121622.649730-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Marcelo Manzo <marcelomanzo@gmail.com>

Guards against the bug fixed in the previous commit: boots raspi4b's
default 2 GiB configuration and checks that the guest actually sees
close to that (>1.9M kB), not the ~921 MiB the bug left it capped at.
Deliberately checks a threshold rather than the exact byte count of
either figure, since the precise number depends on how this specific
pinned kernel accounts for its own early reservations; the threshold
is comfortably between the two (943524 kB broken, 1905824 kB fixed,
confirmed by hand against this exact kernel/initrd).

Folded into the existing test_arm_raspi4_initrd test rather than a
new standalone boot, since it needs no machine state that test isn't
already setting up, and the functional-test suite is already slow
enough from how many separate guest boots it runs.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Message-id: 20260811143539.7835-3-marcelomanzo@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/aarch64/test_raspi4.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/functional/aarch64/test_raspi4.py b/tests/functional/aarch64/test_raspi4.py
index 7a4302b0c5..bacecbbe9c 100755
--- a/tests/functional/aarch64/test_raspi4.py
+++ b/tests/functional/aarch64/test_raspi4.py
@@ -86,6 +86,23 @@ def test_arm_raspi4_initrd(self):
                                                 'BCM2835')
         exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
                                                 'cprman@7e101000')
+
+        # We used to get the RAM size wrong; guard against a regression
+        # (see git history for details).
+        mem_total_kb = None
+        cmd_output = exec_command_and_wait_for_pattern(
+            self, 'cat /proc/meminfo', 'MemAvailable')
+        for line in cmd_output.decode('ascii', errors='replace').splitlines():
+            if line.startswith('MemTotal:'):
+                mem_total_kb = int(line.split()[1])
+                break
+        self.assertIsNotNone(mem_total_kb, 'MemTotal line not found')
+        self.assertGreater(mem_total_kb, 1900000,
+                           'guest RAM (%d kB) is far below the ~1.9 GiB '
+                           'expected for a 2 GiB raspi4b -- the second '
+                           'memory node above the 1 GiB peripheral hole '
+                           'is probably not being added' % mem_total_kb)
+
         exec_command_and_wait_for_pattern(self, 'halt', 'reboot: System halted')
         # TODO: Raspberry Pi4 doesn't shut down properly with recent kernels
         # Wait for VM to shut down gracefully
-- 
2.43.0


