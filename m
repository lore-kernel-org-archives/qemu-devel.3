Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC90E8B39F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0JL-0000zX-OZ; Thu, 05 Feb 2026 09:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0JH-0000xJ-6I
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:19 -0500
Received: from qs-2003c-snip4-3.eps.apple.com ([57.103.86.26]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0JF-0007wB-Of
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:18 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPS id
 E56C61800D89; Thu,  5 Feb 2026 14:26:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770301577; x=1772893577;
 bh=tbfFbAve7fkxKDMXq+Hqdeacl/+zBPkkhOdplq2Wm74=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=edqphzl3PuooG6CodeDU2uosQie6UZnWj7+3eYnBzPkMtNnBP5Dngq7F7MFp7aG5RpVK0mUQVVW4OiX9ta0giKVdbAh3DqYa1Nweh+HV8hpLMvXpxuaoKDR+4Y6joN6nsWZ8nvy8tQnL8MFj7CzFD3LlhO/OW8yLo37sEV2UTUkk9tyRnVzb0WZ99Cz24NDN1bLVm0FoFbNWw3xdH6mVOWKc/USQDusfZBBHzdwb4ERBwjbxndRRy2sFlRPFcHe5XrCEi64iZt7K/WhdDMkQhkFJ2oPLm3huU5W8nxy1D4BHGvxJXfak+2nCm2sVPHiGj8AkKrUg890qlj4W7UDN5w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPSA id
 B878F1800D93; Thu,  5 Feb 2026 14:26:05 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v21 07/22] qtest: hw/arm: virt: add new test case for GICv3 +
 GICv2m
Date: Thu,  5 Feb 2026 15:25:25 +0100
Message-ID: <20260205142543.64818-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205142543.64818-1-mohamed@unpredictable.fr>
References: <20260205142543.64818-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: F6Je4a14iunhNQ1-T1ccg_Skg5teeUTV
X-Proofpoint-ORIG-GUID: F6Je4a14iunhNQ1-T1ccg_Skg5teeUTV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEwOCBTYWx0ZWRfX74FmD+o6D1BS
 dg/9U+RdIadDUTLfe/4vt8ohPLaymA9FxcrhORsIXzdkYHbVnpWx5Lk4xUMkmsCvyCbJl4vUqfg
 gOi2c0tGBPR4LsUN5NXCI9zMzbiruFPc9xGRWak1N/ikvJu5CcmcXP6IiqRD+jtRIDSlKJrkLJQ
 mxUbSUDyNLsTkVVhrdRfkL2ab4xJon3wRGWXi0zbn/E0GtDK1YFxYII3uLKXEZ/UGRvEIEdWELA
 5ApgFrBLb8vR3tKJQRqGCBLC4xNJrUv4wgKct9SwyLwGEV0FpLja5PYlmoSIIt7u7evRQbECI8E
 a/PEhnHW7rxMXmFFkcV76ceua09WvD+cufGnzrVp/Dcntu10N+rSZn95LrDTYI=
X-Authority-Info-Out: v=2.4 cv=S8nUAYsP c=1 sm=1 tr=0 ts=6984a887
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=WSkgWlIY1_Pf25iQiQAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 bulkscore=0 clxscore=1030 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050108
X-JNJ: AAAAAAABNjTNxx4CiGUYYBiC+IlJF5Sil5YV91s3HcPNBz0vUzdSVyYVjYt2KND0fjhk1WANdBQxpgdqTJkr3F6VfPTXZx6GuePP20TCfgiS3srO4XQOhYIJLFkBITaoxMKdPlZtPFkzkh4ezZXLZPjU20YBrIwpsHU1mDw72GpUPerujCNRnwH+TOeX1En/DSdTDgPHlQqydGG9abvPR3QVvd1e+0AX5MOwtHcRxtFNv0oVQ8rh/1oT7p3qDH+Z3rzvdxl0TlNjKGZ1xaeVnkUm+DXSkH3JyDakSkscF7Xc+zqY4vMwDXXo2nWLPWR+b/RwIsrdZK37pl1/vOl75RPKFape0wxIXrxyFFTsRvnHzFssfwiJSWtWUwwqmZxl1uqMkEhixIvZke3+0B9c+Dm7PE100lEKbovtYF+3j0MrAnMirmp44nDDHhbOYpOAvZ7JwPz2BNcWqacDScQfXe1hR0dcFzBZubSa3GDbVeumQB2fxEgmy67SDhggVEoHoGLRQS28YxBmhh+QUCBmNOiNriMxbN/uIjpXq3hVqVsGKBuhjnsBNaMAwxjorQwimrHhLAJrRXTh8vGGZ0vj2W+Cu7dtveey6YwsVtUfiVSaMzRCERz8+CXGIJJsvSC3EjhJ5HT2tsBFCGUWjhBC+nmZIOz2L6nACo5iYEdc07/2+SQgwD4hw1d6R/UsToDMb5+cNf/cKbiMEj9PxEMOKiG1bDezgIEkPdcB6+r8OD15vvKPDMugel2cSWieEtEFW/Rq33mLOu22/J2h8r5RVvxlm4ZWgL+ta/eZ8Muov3cj4koKxJb6W7O7xJ/QVBFCFw38w9a5fUjqCWaIht2csU0DmIJVd1pn64fdYdZEWiqZdJUkTh0bS+NrePlRXpa5DFIf9ZS/DtvV7LTEcHn0y6cdFf5pB1AltI3O8y1Kwj1EJzn6exxIORLzZfZds+VmNJhr+c80r4xy
Received-SPF: pass client-ip=57.103.86.26;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 tests/qtest/bios-tables-test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

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


