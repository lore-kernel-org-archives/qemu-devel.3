Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAC6EC1EB5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 13:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnz9w-0007eE-EU; Thu, 05 Feb 2026 08:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnz9t-0007dD-PT
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:12:34 -0500
Received: from p-west2-cluster3-host10-snip4-7.eps.apple.com ([57.103.69.80]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnz9r-0001YF-By
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:12:33 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPS id
 1E50A1801394; Thu,  5 Feb 2026 13:12:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770297150; x=1772889150;
 bh=eSKI1c+/H+K3c62E0exzGevFCv9bBt5G6GLopf+ZV6E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=LuO9M0JXC/2Y3eJLcB9wSbH6NWJB0taaaodY3Jzko7yHvxW8epBm51Cd46a8NMDhwlZ5PDRsuiYegdQu1bCCJYsSDQL0FYLIh5PNmkc0J/bqIoKGrD4tG9UROoVje8fWVLSufe5lSwA8x45kwGiECwyiSTcAxknXTvas6HpvMe/LxuUM4BuqGUaix3PZ4bFzjdBWQHETeX/ROOfLByZ/GofPFTocPr0GeI8scYZcS9+QAoriZnYCH9O0urbwHpUpnKJ+MOL5pUvyKNomkgaS0/g9IVJiToGvpz+HHr/glV/2OnLLxnTEAnkfWrydNls24jSRUpoE3vIXavvL8iAlDg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPSA id
 F04301800147; Thu,  5 Feb 2026 13:12:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v20 06/22] qtest: hw/arm: virt: add new test case for GICv3 +
 GICv2m
Date: Thu,  5 Feb 2026 14:11:35 +0100
Message-ID: <20260205131155.22780-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205131155.22780-1-mohamed@unpredictable.fr>
References: <20260205131155.22780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfX1bxmK6dcwpZp
 jBoq26PBydBUR9ML+eOvD87Trdoe75sehbsnxiYfPreMfpmGZ/M1qGpno8RhrkvGj6kzEC3yEQQ
 2oG6Y0YImHLLsmxb2dCsyCg7S1/wKo2MRK72hcfOZgMELqKGSd8ZZqqle1ol5TF7p0cd5nVdrk+
 eGZ0tXnLTmS2oypCn2kCTDtMyKPziNDk3LlkDaZRZO3jaKhWPj9UQg0pR0TZteSQIUz4eY8BBqU
 eiCKCW79gyKtHA+umBVmyp3iXj5vOfHjAAbT9aSZ/XOe/fGtLfGgJ0XsI8L+W07Kvy2iFSUcDFf
 YSIT8o7Exhey7hdMTQfCNH+5bUt73QW7l8nZQFtJuyZ4cOIb5whTr7YcChcABw=
X-Authority-Info-Out: v=2.4 cv=dunWylg4 c=1 sm=1 tr=0 ts=6984973e
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HkXMOn5Dch_fMdOo4lQA:9
X-Proofpoint-ORIG-GUID: F_fDC8vorfQFKH4ZIcpZ1o00ohyLR0Vs
X-Proofpoint-GUID: F_fDC8vorfQFKH4ZIcpZ1o00ohyLR0Vs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1030 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050098
X-JNJ: AAAAAAABW0t5uW2cTsOj804R807J0ssATJSTd17Eq+4+JJSTrtgDYx7BGRC2COatBS+jyUrIJmm3SmLakO83gI9yc2CSgUR0yfg/tnEpQqDFZ9xGMwm7zvODCa2nII630kzI2MAxf+sJlxsRctS+Z5lKNnLdhWa4O3+Bg5qk6NscOiHf1PxEgkisTpYNqcO4pHxe+q7WsQ3Dpuegx0hni8aILiLcfQfVvckjQJIVjxDjpdn8Obo1y1pyYiVCODLe1kC4MNaoyhyL52VaEMFfmeQCpjp/AmlfreixjLfXT0fgC8yS8mlGWAa5FOkXH/1hEjIuVvrKJb/ZVdVzjPTrNFy19VQYy3Od1ikOQlpCsmEQzWBUtwUWlPWq+eT2wbYD5af5DdJQMPR19ZbsMVYZqIqygR8qsh6M6NE9nMba/ps9pE7pufPx4+FAr0fnH0bdRouoOF7riRnFU3hIdWtD1CSCEAMP4B7dx0bmtrudAFretM+iTlOTBxNxYuMEs1uIabneVpfhkHOg7isNpSho6Ydi+whV4dZGbX6opuQ62vcetVP7uMOKVGQumJLBDq7WybcICR6wrO6D3ul6chdKQcBedWk0Y0UrYSYp56Y6wFi+cjeFLkrZrK+sai4h+L/2UkoN5n9etYj2gXvsA4zsnoba/ejmal8rv4a6WCQExyZK96DDlYwStEO7pVuFimb5xaVNd6KuYeAWQXcPDirl6+jJoIucrLkYxP+k9b/yvLckXOrYj6Sde0gwBOPQ8GLuC21L14tVsYQw7Lb/XnNy487UDP1r1Zz6lA1VLhX4hU4aX43CR1LSNxI8ocY9nImuzh5Gkf8h0i+sp3FN2fNAqUmSxMxaj733/cRRFJc8DhhjWJw61nqP++BlR1aV8SDZakc+nutZhj67VM6cdMwyKbq7Z1FyR/IGHc4nUmtmKkUF7dh13pH0iI3dVaf/rQa9jzC+UH7sGiYFv+MM
Received-SPF: pass client-ip=57.103.69.80;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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


