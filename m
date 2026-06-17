Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFEFCD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZnXO-00072F-R2; Wed, 17 Jun 2026 06:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4628a4021f=eblot@meta.com>)
 id 1wZnUi-00048x-Tc; Wed, 17 Jun 2026 06:27:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4628a4021f=eblot@meta.com>)
 id 1wZnUE-0007zF-B6; Wed, 17 Jun 2026 06:27:40 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H92RB53537513; Wed, 17 Jun 2026 03:26:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=UGtcO3HQE3juM08mjkK+yABGT1yEHcuFL0vOEH1lcn8=; b=qkfnbcu7slws
 8JHMT7Vqbd7Umf9lHeBwM83ipRDP3gD8cSthfnykd7v3tfNAaDDYuJ8CAoYEzZJX
 eJBSlPN7kbasDXvfMdjrg1qk62ZRJxa1M1x8J1fhxeXUq3O3NGG04vTpp6dWf57S
 t+j4LhQa8YDjPPCfxS8YIG+Td3cDlCv8OtT14ZMdFIYY6n9RRCkjZALcB2zPHzQj
 Mv+cyMwXWYWfiHgQHqcHn38cVPkLrMLfDq7CM8ufFc492aihSwnMayzRR0/2MdI6
 nk0VjU7WmPkuJZYUMM27lSt9igTK8PdI1DwSI+N96Tof6VpkyGJPljg6M/l7FVhV
 clY9yuTC4g==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eueg7ugsa-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 17 Jun 2026 03:26:39 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 17 Jun
 2026 10:26:38 +0000
From: Emmanuel Blot <eblot@meta.com>
Date: Wed, 17 Jun 2026 12:26:03 +0200
Subject: [PATCH v2 4/4] test/functional: anacapa: test ADC128D818
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260617-i2c-adc128d818-anacapa-v2-4-fd38764f0465@meta.com>
References: <20260617-i2c-adc128d818-anacapa-v2-0-fd38764f0465@meta.com>
In-Reply-To: <20260617-i2c-adc128d818-anacapa-v2-0-fd38764f0465@meta.com>
To: <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 "Jamin Lin" <jamin_lin@aspeedtech.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 "Andrew Jeffery" <andrew@codeconstruct.com.au>, Joel Stanley
 <joel@jms.id.au>, Alexander Hansen <alexander.hansen@9elements.com>,
 William de Abreu Pinho <williampinho@meta.com>, <qemu-arm@nongnu.org>,
 Emmanuel Blot <eblot@meta.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781691985; l=5406;
 i=eblot@meta.com; s=20260602; h=from:subject:message-id;
 bh=5cR7F0GXdKed7lQmVUvTFMVnjUGWTsnNU9pfHItXG3Y=;
 b=lI2t9EmgXZwHZ16m/6kSaZncu4sIwVFebEtrY7daCOYxDqevUIC9PreKygvlrSjvvA23cOH1t
 wFMTffMHTOGDjqezCNaKgI11VB9k6E8CIk2k4UTIQ79K4YhO6T0GmAI
X-Developer-Key: i=eblot@meta.com; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
X-Originating-IP: [2620:10d:c0a8:fe::f072]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX2veRPSNbRKvY
 mRM7MF4FLUbitJ6dLz9pMU16y54l+zT6aqeLFHWSdG4B7DaR5hbJDQ/NVew42NscbTQyqIA6cO7
 +wGxVAuy14m8F68zw2SVZ2Ej/6DyoLYpzUccSltwH3uEt2lc3s2fzhQ0NZ2V6xB12JRZYVWG7Ie
 6jo5r91ECAf86TcX4xoiW8Y9tOQKDmjCP1KJ9ZtDyd3AGUiUdPrgxYCq5jFmQJ7ke9mD/2TWqRo
 /5k09ajrzb3IQWudosNU8ZhDko5RiiMLFIr0euSN89lC12j0tUI1Wcp9BSk6CbcN9SXB3PpTzA3
 OjkbQJsdfdw0mxTKSZ5X6wXaL2ssEs1CR4LvPOKpozAatjd+aKfsZHQTlcQA/+CRO8h1TN6FLmE
 /J82MsK+6KblQtttC60QYoGe8nGhWOXaMy1nw9dYbNmvjRdqnLUYv8SO2Qjk8QwV+ZKH7Vjqpns
 OphFXY7JGa8MAvCFH4Q==
X-Proofpoint-GUID: 7xXQZe3FUr4aFqHFkvLlZaGE1blxcS1O
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfXxi3JTpNQPP/Q
 X4DeCIldgOxpf6Zp2Ovhwh6uMlJ5lp6PWXrQQsBBEplWSP5yc8ODw50e0M7WAs4ax03WmNn8d6Q
 NGv/LU3Rf2ypZJV2YuSs389hibAf84Y=
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=6a32765f cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22 a=NEAV23lmAAAA:8
 a=VabnemYjAAAA:8 a=0hSsJX124peQlSGzgAgA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: 7xXQZe3FUr4aFqHFkvLlZaGE1blxcS1O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
Received-SPF: pass client-ip=67.231.153.30;
 envelope-from=prvs=4628a4021f=eblot@meta.com; helo=mx0b-00082601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Verify the ADC128D818 on the Anacapa R-PDB (i2c8 mux channel 0): two
channels are driven with distinct voltages and each is checked to be
reported back independently through the kernel hwmon interface, and the
channel 0 limit registers are validated.

Signed-off-by: Emmanuel Blot <eblot@meta.com>
---
 tests/functional/arm/test_aspeed_anacapa.py | 92 +++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 6 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_anacapa.py b/tests/functional/arm/test_aspeed_anacapa.py
index 27f8bd8b56..003d6dfb17 100644
--- a/tests/functional/arm/test_aspeed_anacapa.py
+++ b/tests/functional/arm/test_aspeed_anacapa.py
@@ -4,22 +4,102 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+import re
+import time
+
 from qemu_test import Asset
+from qemu_test import exec_command
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
 from aspeed import FacebookAspeedTest
 
 
 class AnacapaMachine(FacebookAspeedTest):
 
     ASSET_ANACAPA_FLASH = Asset(
-        'https://github.com/legoater/qemu-aspeed-boot/raw/3fa3212827b04be4034d43b5adeef57c27d6ab18/images/anacapa-bmc/openbmc-20260512025228/obmc-phosphor-image-anacapa-20260512025228.static.mtd.xz',
-        '2232e241abcfb6d4f6b82cb6c378ce5ce05e364aac6d118785c2b6cc33fe43f3')
+        "https://github.com/legoater/qemu-aspeed-boot/raw/3fa3212827b04be4034d43b5adeef57c27d6ab18/images/anacapa-bmc/openbmc-20260512025228/obmc-phosphor-image-anacapa-20260512025228.static.mtd.xz",
+        "2232e241abcfb6d4f6b82cb6c378ce5ce05e364aac6d118785c2b6cc33fe43f3",
+    )
+
+    # ADC128D818 on i2c8 mux (PCA9546 @0x72) channel 0, address 0x1f.
+    ADC128D818_HWMON = "/sys/bus/i2c/devices/*-001f/hwmon/hwmon*"
 
     def test_arm_ast2600_anacapa_openbmc(self):
         image_path = self.uncompress(self.ASSET_ANACAPA_FLASH)
 
-        self.do_test_arm_aspeed_openbmc('anacapa-bmc', image=image_path,
-                                        uboot='2019.04', cpu_id='0xf00',
-                                        soc='AST2600 rev A3')
+        self.do_test_arm_aspeed_openbmc(
+            "anacapa-bmc",
+            image=image_path,
+            uboot="2019.04",
+            cpu_id="0xf00",
+            soc="AST2600 rev A3",
+        )
 
-if __name__ == '__main__':
+        # perform login
+        exec_command_and_wait_for_pattern(self, "root", "Password:")
+        exec_command_and_wait_for_pattern(self, "0penBmc", "#")
+
+        # ADC128D818 test
+        #
+        # The current Anacapa OpenBMC device tree is the AST2600 EVB one, and
+        # therefore does not declare the i2c8 mux nor the ADC128D818 behind it,
+        # so bind the emulated PCA9546 (@0x72) and then the ADC128D818 (@0x1f,
+        # mux channel 0) from userspace before probing.
+        # This should not longer be useful once the Anacapa DT is updated.
+        exec_command_and_wait_for_pattern(
+            self,
+            "echo pca9546 0x72 > /sys/bus/i2c/devices/i2c-8/new_device",
+            "root@anacapa",
+        )
+        exec_command_and_wait_for_pattern(
+            self,
+            "bus=$(basename $(readlink /sys/bus/i2c/devices/8-0072/channel-0)); "
+            "echo adc128d818 0x1f > /sys/bus/i2c/devices/$bus/new_device",
+            "root@anacapa",
+        )
+        exec_command_and_wait_for_pattern(
+            self, f"cat {self.ADC128D818_HWMON}/name", "adc128d818"
+        )
+
+        adc = self.find_adc128d818_qom_path()
+        for ch0_mv, ch1_mv in ((108, 2000), (1280, 500)):
+            self.vm.cmd("qom-set", path=adc, property="ain0", value=ch0_mv)
+            self.vm.cmd("qom-set", path=adc, property="ain1", value=ch1_mv)
+            self.wait_adc128d818_value("in0_input", ch0_mv)
+            self.wait_adc128d818_value("in1_input", ch1_mv)
+
+        self.assertEqual(self.read_adc128d818_value("in0_min"), 0)
+        self.assertEqual(self.read_adc128d818_value("in0_max"), 2551)
+
+    def find_adc128d818_qom_path(self):
+        unattached = "/machine/unattached"
+        devices = [
+            child["name"]
+            for child in self.vm.cmd("qom-list", path=unattached)
+            if "adc128d818" in child["type"]
+        ]
+        devices.sort(key=lambda name: int(name[len("device[") : -1]))
+        return f"{unattached}/{devices[0]}"
+
+    def read_adc128d818_value(self, attr):
+        # split the marker via $m so it only appears in the output, not echo
+        path = f"{self.ADC128D818_HWMON}/{attr}"
+        exec_command(self, f'm=END; cat {path}; echo "ADC$m"')
+        out = wait_for_console_pattern(self, "ADCEND")
+        match = re.search(rb"(-?\d+)\s+ADCEND", out)
+        self.assertIsNotNone(match, f"could not read {attr}")
+        return int(match.group(1))
+
+    def wait_adc128d818_value(self, attr, expected, timeout=20):
+        deadline = time.monotonic() + timeout
+        value = None
+        while time.monotonic() < deadline:
+            value = self.read_adc128d818_value(attr)
+            if value == expected:
+                return
+            time.sleep(2)
+        self.fail(f"{attr} did not reach {expected} (last read {value})")
+
+
+if __name__ == "__main__":
     FacebookAspeedTest.main()

-- 
2.50.1


