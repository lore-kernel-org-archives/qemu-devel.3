Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85845E9129A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 15:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1ES-0003xK-2o; Thu, 05 Feb 2026 10:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1EP-0003wG-4C
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:25:21 -0500
Received: from p-west2-cluster4-host2-snip4-10.eps.apple.com ([57.103.69.211]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1EN-0001oV-Db
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:25:20 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPS id
 7C94918001D6; Thu,  5 Feb 2026 15:25:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770305118; x=1772897118;
 bh=tbfFbAve7fkxKDMXq+Hqdeacl/+zBPkkhOdplq2Wm74=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=bLMi4YTx2LNd74qYUgSUfNUGFU/CV/258tEBGKwWI7Od1f+T9nrxcxI8SpZm4AQ7eNNvU3yeZTPZoTZFxxq1b6/5BYWHHhB7x3dXQA0270UwqB6a00dE6+3FtHj4LlIUeqCp9ZkoiK5/R2h/vVOmWiz4BLjzHnatjktphnGK+dB+1xUOsCCFeIER/4xVSpvyVeXOBOmVY5ENrOU9yc0P43vSFCqJTZvJSDAaCElODhLxtoOH2F42P+SwRr/kDuBjMp7u14WVXMbyKdvs1L+E2biJHuNgSkwuFT/jRuoMqFOJCpIvwZrKgK0tKheNJrF0zUeF2rZUHQXZYYOXzi2PYg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPSA id
 A72181800623; Thu,  5 Feb 2026 15:25:10 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH v22 07/22] qtest: hw/arm: virt: add new test case for GICv3 +
 GICv2m
Date: Thu,  5 Feb 2026 16:24:10 +0100
Message-ID: <20260205152432.78208-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205152432.78208-1-mohamed@unpredictable.fr>
References: <20260205152432.78208-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDExNiBTYWx0ZWRfX8tArYvH0XFXE
 +a44NDegdok1wU9zYq2x62vY+xSc30VPNdGtVNMZhiqjbtoHumXqDy5FawAP+6XBY/IuU40QNGl
 4TH7jGttfv/DmWWCC+gNFkL61qicNzsvtFiu5YdHcRYN8atwbgOvFYqJVCFynz9+k9G4NLWou2n
 R//MRzGaF9P242brRPT/FAPkRyGPRl4cYNOgrjVRCV9cI21QD0GUsB9Lp3VH1vbaUru6MtMH8TS
 yziAUzMC/KiM6frG6Hc766KRr+GeoHxi27g/jXDSST6f57DYekF+3fJ4oEICiElR+iKd7dEfB6E
 X3qRiH5eZKLBqJo1byJ1SgdlafQm90j04Sg1isRztsC/1JfkfoclaHk9LPENuM=
X-Proofpoint-ORIG-GUID: 8OkwBfJ27Pk-U6qzKSCIe1wK7fqnvo9J
X-Authority-Info-Out: v=2.4 cv=E5bAZKdl c=1 sm=1 tr=0 ts=6984b65d
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=WSkgWlIY1_Pf25iQiQAA:9
X-Proofpoint-GUID: 8OkwBfJ27Pk-U6qzKSCIe1wK7fqnvo9J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1030 mlxlogscore=999
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2602050116
X-JNJ: AAAAAAABR7vWvJnfUA8UYL/vy+s9eLrzPnAQdcZNEda4yGr2wPxffOodaDA4/AaX8BTgDpQxR+48sP6LEFf3qhV7dBW0BlBj3iPEO2Es9lNmkMFOLRBOb8pOJZBiwpukeOLzNwQPAxRnnxRfjajhB520Dz+VpajNuebs5W2A83ltVDerBxhNS51K2ddrp2keZ4J1Qi0lEgJojGcOHQT/56TvVqBtPtXbbriFuMr5xtJYFL1iRPiF0O8e8pSdE03dHqvCD2Ud6cKwsD8jSIdXq27Tc4eRYFrpDGc52h1ysv0hhQYuXCkX7kXjxQtsEN0jODrOTXGURSCpU96D7Yfwql51WoTDs+vP1Zs7AEgYAPwXBLRTq9/A1ptCkucJLpQg94bxXywDd7irX8FSBCCbW/UbRSzIKzrXFnnPm8UiRH0k4ex8q95UWwkIXnn3MNDNHVnX2BFElyirzpjHgzu+TSBnYgoQ3VdJgxS8M4EDg4h9mQ7eFvImZEhK9YRo/dS2ZfZQVh6RABrLmu+Jiwas/NvEmbCr8EpM80bymII6i1G+Wj8YeCt1uXLc5Ylvh7BZmpMk5aA3at2tg7zqlgkrLZvAuK2l4QtEgLUcpda/tRf/i2yKHDfXOgKs++wgQBScrBFRjfpJb0ifSuhzLWd34YnFQqp5IFUuLh6byJU5bR6s8rbdcUmHqKU3C9uC3etDKXaJVcZvGkuDjFNM16zR/Nc615SpOD8k+uHgmJubGGgRKZ+qv5d9U53TjjO9zlFoY70/7BwNNYkFCDgEDoz+PNheDauOAv5tXfg3ZBSXGWYfoLrrOigngq+rxKczKbyt4CIFanjKmeow29YLogT7eD6bzXFNGNbnZyCYG3w33UBD7DEqmzDJwsCAEDXS53I6vr0nTQudEQ8WUoMyAy91rKJ9bRHZRTj7ZQVpTnUYMbSMA75Ncdf80j9LM3vkQHtt41QgEKwXA2v5
Received-SPF: pass client-ip=57.103.69.211;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


