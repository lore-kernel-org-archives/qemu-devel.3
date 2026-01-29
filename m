Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0F1D73E80
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXZN-0005o6-6b; Thu, 29 Jan 2026 14:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZL-0005cN-F7
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:20:43 -0500
Received: from ci-2007l-snip4-7.eps.apple.com ([57.103.88.120]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZG-0005tW-E0
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:20:43 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPS id
 56C3A1800175; Thu, 29 Jan 2026 19:20:34 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769714437; x=1772306437;
 bh=eSKI1c+/H+K3c62E0exzGevFCv9bBt5G6GLopf+ZV6E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=IrSHEXQo3AjTjLagdARMtPYlyglmk/3cHEKT090f2OeAswIP9IZ12YTPgZFGZ7jNIW4I15y64rV7+Mv5ktQCBNYVRNR8PZdYbDEeh5DNukwyoF40yseMS0aWwbcfLEVCyWcKcKAF+b/aY1DytdDlBOWYEpmZ99wyz86W3KdClm6cN9Mt5Dl52SEgX5E8Jsj1oG9vckoVEw0KSBxophD6qKQTGLfd90VtEis8bIRs8bnTmFCn8AgxPfDY32wLEOhURq3pP7dv3mfI0MW37ELFKe2F4OT03gsLOqI9Agh15nTiTScpwCQM0etWFFp3s+fP/BUMabK+PfFIskdIoU9Lzg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPSA id
 E4E1F1800092; Thu, 29 Jan 2026 19:20:30 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v19 06/22] qtest: hw/arm: virt: add new test case for GICv3 +
 GICv2m
Date: Thu, 29 Jan 2026 20:19:51 +0100
Message-ID: <20260129192009.14707-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260129192009.14707-1-mohamed@unpredictable.fr>
References: <20260129192009.14707-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yRwSxAoZQfs16JAwnRn-e3S9Q9iyTe8y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzOCBTYWx0ZWRfX66TKU9zuboKO
 80tyJKGzCeqYLgM5V0Rf1cDxRbn79veHhicairZ8nhzAs2s+56psc579F7o3sk4SscPkXvrEFGr
 MotgfSPAOkIFhnfAm9Qx/6WJ0r2aPyXLw5WbhhLKIz9/kvX48Ykp2uw4K4LMEILASL1KbftsPTR
 D2GY/DQUFOsiBcJd8ZVdVvrTQ5yd3LmCRFnO2TMNXqEBlWlm0LeYrupcPkRgcxRmFfLEdo/DdYi
 csQUZeGEpsTi3I94gpEltg5qHvso4JAtjBBLiku2txRpkNSUfzBc4kzSu8yZobST+dPuo1NRUia
 I8S5na8Uj+5Ljefg+Rit4vSYHwgb9DtpJJ7WElZ3aJ895ttCVhXFaAqjbiOXo8=
X-Proofpoint-GUID: yRwSxAoZQfs16JAwnRn-e3S9Q9iyTe8y
X-Authority-Info-Out: v=2.4 cv=GsZPO01C c=1 sm=1 tr=0 ts=697bb304
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HkXMOn5Dch_fMdOo4lQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1030 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290138
X-JNJ: AAAAAAAB3CNKB+WzupafUu+aby9wTT8y40bQx3RuhWxjYwyZtqD0tK1tPGtNSrazH2xeT3OV/nB4l7CFkWj8eqalLtIuiiW1LVfTmjznwYGmkVx4vwJtkl3MlePWqCwqTw2n5pvLc4Opv/EpD53Wec7JX+mSi8tMk6AtKQbbck/tyXPxM5A/R86ZD6YXrIyCCn9m3nfIKAGUVNXXts2ATO5zPusThDTbWg+DAkfKxbcRZNUFMrs+AICCVyOo/T0dja9aJJSlKc6xo62MZkiGyjXD/KRVmephr2mErKiyS+0lvtCA1tEHeNQ3U763dWDUeshi7j07zUdGXDKdHfwwL5ot++W/jxARLtUbyyxsZqZD+zCl7H2we0Io/YyC/sarnQJEpEY9TXsKvJa3Y6UXxq6lTL3OgmyY2r0dVZJSiFQvMnOw8XkwptYl06aiMG+VvKJb9ZXaWp7qUS43jvQbmM8kiQiOhT8Tdnbxco7QQRrJV81UBTatwS83o7PcMohTGn1pIUEyD3K+9svNgEy+gyQvESzcYbn/wIbA3jaDxMdVK3H2y5yOjdxF2B1KncbHn2crDIoT3Vbny3A+N8GHudpbitd4xL1w6So0BNrxUgwF2emwqlYAwvY6xl8W5OsIF6hleo7Ict1pGENZgMaRZWW73cD4FjDVEOnO4xBKEC+/BOeBy/rCcG43Wq951O6uDsMHrHuAtShBXBQaPSx3o4MBWZv16mOIkeNhPNYTm399ZLYYdOZ446NFRrPGKSQG2nwfWXwZHBXQD/M4ATNpV0QLWzl93cRAQhAXX0tvizyZBuqjFE6sppWGhyNYJXtXYdcRetqTxh7dkZMfrfUj6RyDCRQ6us1fDUxUwtV6heNynQUVng==
Received-SPF: pass client-ip=57.103.88.120;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


