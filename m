Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD822D2FED4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknq2-0006Jv-Ik; Tue, 27 Jan 2026 13:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknny-0001qb-NN
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:28:54 -0500
Received: from p-west2-cluster5-host6-snip4-10.eps.apple.com ([57.103.71.63]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknnu-0003TF-Og
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:28:44 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPS id
 C66621800251; Tue, 27 Jan 2026 18:28:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769538521; x=1772130521;
 bh=eSKI1c+/H+K3c62E0exzGevFCv9bBt5G6GLopf+ZV6E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Oflqo00qsIfsdVAa1nx+0lsrEULZCRjWhJvq+QXPvKFtXt2dmDyj0JfxWeTILW4AlALoRzDatmyLfIRyIWEp2HbYxY6AQ9fQRxhQCHF3sKsGHYddKEckB91LD4XwwktQk93eUjZz7XraeO+FlCkmuNgNhF4muZ5+DqZD86oVl/MfU0zJ8KClqBUQg3lbPZfhOWUO7KnSSJ3cWp5FZh3+9fR5HnHya5HAo9kG1m8kShBMRenXdGlrArqXrWBSPekSJiwkoHx717s/2cAx7zOCKfjDQzDwhvdmnVeQ2g7LmxhuH8xVg5EYTmb5CZpRe4hes3bdyG6nXkSQg6l+lNJNww==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPSA id
 796CF18001FA; Tue, 27 Jan 2026 18:28:36 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v18 06/22] qtest: hw/arm: virt: add new test case for GICv3 +
 GICv2m
Date: Tue, 27 Jan 2026 19:27:46 +0100
Message-ID: <20260127182805.73212-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127182805.73212-1-mohamed@unpredictable.fr>
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MCBTYWx0ZWRfX8v0SK1cTFxnk
 +cN6YrHXdCtjF9UB9siu2ZGRBEv4JlAHS9wodbJusaxCtJIgDc0gqOEDwWp2CyU939bWGyx/rPd
 A4/jVPWTw9fTZi9d3f5T8bVwlsMQppikzWbaqebcs+EPmLjQsPiCZ/gWOuB9GTWvnEomoMUTlXd
 K6bamUcYYNWEdNaXRl2sB8I6DzHCLhbZR3mvNj+y3QyJsiv9SSVnWueYqXEatuCU0SVy4HEd17g
 iX275emdLHDXbwUvUi8vifagGNWZclNF0foiCHRFFRbAOGPl/BsDtv4XcxHW1ywZv7Ie+qD7GVP
 60NjhgQBh+CuRCNaiWXMf5K/h8LdQrD6PL8urtwfbsuMSN9NZs9OW8T1Sia8V4=
X-Proofpoint-ORIG-GUID: ALw_PwxLYlGBIkTRDLPihEW_Q3KwVWct
X-Authority-Info-Out: v=2.4 cv=a+I9NESF c=1 sm=1 tr=0 ts=697903d9
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HkXMOn5Dch_fMdOo4lQA:9
X-Proofpoint-GUID: ALw_PwxLYlGBIkTRDLPihEW_Q3KwVWct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 clxscore=1030 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270150
X-JNJ: AAAAAAAB5QsU+VVcb75My9paAiDtqM2ADxiEoOauZAm1MSnCRrFGPv2MOg7ebT4LMDEjiEp7iZB0Cc8EhwcCI4l2rrAdPH7Ir1x8AbsNIbvHvDFk1w2gQUiyutp6D+OhMOSxV5+91xmMD/RNPIKnaKlIxdF9b6C+j5XXFfPIOC59BY7oFXSyOJI3CIudSBPbk0gTNBSDw+GDN7uG0Si65UbivmImE5IQPTT9pmKTHzWpamxv/tPlfY6dG9smzla7yQrPfLb3TiTqraW3O1byYtKiDwKSiGWrqOZ23swPuJLtNjF1WBy1V3FMuNb0t0flsciqkzFrTLfmcc1GZ6kh7Pjtk53S5rZQj8GycMtBpIAUBb3zN+UQZl8KR+MHS+TBcu+VMP1/tf8kkUXmib8D1KgATh1o30rXwQk8T8Zjqk4sENYW+sglJtXD/vMPLfgHnBUBOKZudhRGpY+4U0CmMlBTHGS/CdVd5ARyGVbisitAc8o/P47NFqy5yHClypSbrY6bkZKN/qNHsNVd9lTFGnkuYsdnVKhNJHxAMeYn2DTkof1wQ5xynyLJHdquocYHq2K+xvZEunVgMellISQ5SpQgHb66HKWX/el5N6pSGQ1BfBrSvNvHVOHSaplAvw8Idg1xTlPRm4iZ9UJgwtXsXlARK/k2F6nrEeT1xllqAitIOQcqPUG5cX/+4gLPV16YMyCBwx3Sw+BH7RIZL8AhlfvWToTUYHoYQDMEne9P+WkvcoeWG32zlWyhXSlM4RrJgTDXSwhRpg2MPhJ6ExMggKv6p2ssHc6O65Nsdqx36/MiG/pAP6QdomyVLPXTCOl5E54HT75gCtufqvKqUJ46Xbi5P4UnnnwFnW9K+1BhWtg2hY5O1zvfDXYyM95ec7RueBF8mHmu4ZAjcMnAkplmo93B3Slw7wJtk7z9Wd/6E73F7utN
Received-SPF: pass client-ip=57.103.71.63;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 tests/data/acpi/aarch64/virt/APIC.msi_gicv2m | Bin 0 -> 188 bytes
 tests/data/acpi/aarch64/virt/IORT.msi_gicv2m | Bin 0 -> 172 bytes
 tests/qtest/bios-tables-test.c               |  21 +++++++++++++++++++
 3 files changed, 21 insertions(+)
 create mode 100644 tests/data/acpi/aarch64/virt/APIC.msi_gicv2m
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.msi_gicv2m

diff --git a/tests/data/acpi/aarch64/virt/APIC.msi_gicv2m b/tests/data/acpi/aarch64/virt/APIC.msi_gicv2m
new file mode 100644
index 0000000000000000000000000000000000000000..16a01a17c0af605daf64f3cd2de3572be9e60cab
GIT binary patch
literal 188
zcmZ<^@O0k8z`(#_;N<V@5v<@85#X!<1dKp25F13p0FMNW#lQh$F#{Rg0Wcl|15CX*
dLWpD*p8!Y;7u1e#47_lAnZRNoI~*7S7y#H%2>}2A

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/aarch64/virt/IORT.msi_gicv2m b/tests/data/acpi/aarch64/virt/IORT.msi_gicv2m
new file mode 100644
index 0000000000000000000000000000000000000000..c10da4e61dd00e7eb062558a2735d49ca0b20620
GIT binary patch
literal 172
zcmebD4+>esz`(#f-O1nCBUr&HBEVSz2pEB4AU23*0%8Lo1_2fq1{MelMzV5(SRi%i
nAPXpv4aB)XoP#9EWWm4;QV+r^P#Q=v12GslK<WQb8fG^DHhBvH

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index e489d94331..a5a5b8807b 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2252,6 +2252,25 @@ static void test_acpi_aarch64_virt_tcg_its_off(void)
     free_test_data(&data);
 }
 
+static void test_acpi_aarch64_virt_tcg_msi_gicv2m(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "aarch64",
+        .variant = ".msi_gicv2m",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 128ULL * 1024 * 1024,
+    };
+
+    test_acpi_one("-cpu cortex-a57 "
+                  "-M gic-version=3,iommu=smmuv3,msi=gicv2m", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_viot(void)
 {
     test_data data = {
@@ -2834,6 +2853,8 @@ int main(int argc, char *argv[])
                            test_acpi_aarch64_virt_tcg_topology);
             qtest_add_func("acpi/virt/its_off",
                            test_acpi_aarch64_virt_tcg_its_off);
+            qtest_add_func("acpi/virt/msi_gicv2m",
+                           test_acpi_aarch64_virt_tcg_msi_gicv2m);
             qtest_add_func("acpi/virt/numamem",
                            test_acpi_aarch64_virt_tcg_numamem);
             qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);
-- 
2.50.1 (Apple Git-155)


