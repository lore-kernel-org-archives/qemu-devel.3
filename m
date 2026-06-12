Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B03CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY53o-0007gE-A1; Fri, 12 Jun 2026 12:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4623e61353=eblot@meta.com>)
 id 1wY53m-0007fu-Qt; Fri, 12 Jun 2026 12:48:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4623e61353=eblot@meta.com>)
 id 1wY53k-0007np-SC; Fri, 12 Jun 2026 12:48:46 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
 by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65CEKtau1332449;
 Fri, 12 Jun 2026 09:48:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=UGtcO3HQE3juM08mjkK+yABGT1yEHcuFL0vOEH1lcn8=; b=muHgrYyjveY/
 Q+XlqhMnX6UHHOR6Fpw9gkORcmmPua16/75DVG+ar7/XRB08Pu/lgPcSvPv59EqL
 /Tjn2XEpG1Erd4FE4SW6E4UTzUzFmglAhplM0/HYex9Htaq7sw1ZPgWdkmI5q51q
 ya/lkhD3DVA812Y/jt2DL8ERYEzxf3hAYaWn08DJAgc4GmlsdxTm0YJO5t4f/yvN
 JLdDRDa4Vfd5gAfHIBCMUScv1mup7i0z9zXnPEbA80yG3pHJ3flfUZLaDLD7KzVj
 kx3QFKfQ648ijq7tfoudrp52B8HL6ocm7CRjVNWECqXGrxjJYP6oasWmrZo5ufLO
 C+nz3gh1Lw==
Received: from mail.thefacebook.com ([163.114.134.16])
 by m0089730.ppops.net (PPS) with ESMTPS id 4erksugyg7-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 12 Jun 2026 09:48:14 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Fri, 12 Jun
 2026 16:48:12 +0000
From: Emmanuel Blot <eblot@meta.com>
Date: Fri, 12 Jun 2026 18:47:03 +0200
Subject: [PATCH 4/4] test/functional: anacapa: test ADC128D818
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260612-i2c-adc128d818-anacapa-v1-4-9e4640cd164b@meta.com>
References: <20260612-i2c-adc128d818-anacapa-v1-0-9e4640cd164b@meta.com>
In-Reply-To: <20260612-i2c-adc128d818-anacapa-v1-0-9e4640cd164b@meta.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781282877; l=5406;
 i=eblot@meta.com; s=20260602; h=from:subject:message-id;
 bh=5cR7F0GXdKed7lQmVUvTFMVnjUGWTsnNU9pfHItXG3Y=;
 b=snRGUz/WRsWV/Eo5F1L79T2RoFigXL/qVXCWwsd8X2ME3dWo6+0JjuIj9FGPrLdyUR7Y4/019
 npgmFI3WfJCDH//fQxlGWiipvINh8NVdlpuuD6xPVVg55gkh8g6p7w5
X-Developer-Key: i=eblot@meta.com; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
X-Originating-IP: [2620:10d:c085:108::150d]
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE1NSBTYWx0ZWRfXzfFlEYiPzt8O
 sis3qhmzvPTcP1lm8XaFnV4KrgDBXmBBWcGhFL7ZQ5c7NCOma6F3S5stPaHw+J2yntSr4iyPb1x
 stNKM7XugVnazazFG70Jsvtd358b2W4=
X-Authority-Analysis: v=2.4 cv=bvx8wkai c=1 sm=1 tr=0 ts=6a2c384e cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22 a=NEAV23lmAAAA:8
 a=VabnemYjAAAA:8 a=0hSsJX124peQlSGzgAgA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE1NSBTYWx0ZWRfX7DIS1r1GpITv
 pyAnIJZRcBA2TSBltDLru6DWjswakaH4x58qZwXfwrrLlq+wsQYXj357IQ/V7GKvpssryB+cB1O
 9X/fst6KNJ6wrN0SRM2uDbL11BNNF7ESp7LY6dHH/C/Za7ux54evrA144iXyQURyC/jzuaiNPEi
 w3Hey7dul+CtbB8+qZJaScasZbiIeTEiWD9V1KxkQxfszqPpU0ZLXHHm3zWigySoPbsDje8fVHf
 9SU5fYqGQ9/jUgONXYgRvLMK3pkyYnfQVnuRHXhmwvlbrxhupetvPbsjw48I6XWf+h/VfwxJ/Eu
 m3huqILCFWVK8gQMyFJdeEZt+fJKDNOaq6zXLUNoFyOKzc0msctDM9FHUwp7xDC4RTckoTzjuCz
 +2b4rdyFj9F+wUowmE8TEALQifiHhSoAKoyHv9xrUamapZF3vHP8tIAfm7kwstQLP1ogRtySK+R
 buaEhwz0olBUTGPW3gw==
X-Proofpoint-GUID: 0g7svyw8gVtOmxFqqhERBlWXdAON0tKl
X-Proofpoint-ORIG-GUID: 0g7svyw8gVtOmxFqqhERBlWXdAON0tKl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
Received-SPF: pass client-ip=67.231.153.30;
 envelope-from=prvs=4623e61353=eblot@meta.com; helo=mx0a-00082601.pphosted.com
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


