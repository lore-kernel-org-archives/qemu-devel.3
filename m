Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DC6C44532
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYSn-0004Yi-HO; Wed, 21 Jan 2026 08:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYSl-0004UW-0T
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:41:35 -0500
Received: from qs-2003g-snip4-2.eps.apple.com ([57.103.86.65]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYSi-0001BC-GI
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:41:34 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPS id
 DDA121800166; Wed, 21 Jan 2026 13:41:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769002891; x=1771594891;
 bh=iwX+uYjcGihzSI32blK/s5EzwiUNzG/Jak0Gqm1HI2A=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=gAiANNX+ahtDM0XonpzM0pbHuOObg7x758wNJE9ghIQ0mXoHm+/QUv88pvUGuGjSrgm6Lq4FkCtGI8vX1VmvBy6BE6TheXjKLscFIbjV7FlN+j5ftPD743TcAnD5hoQL/btRS9nEO0k2Bcc2RhpUgK1dM6vVnNkRtrX2XRgy+M3PtAuWxQy85ZRbFVDl4HIRz3M9NnNsJXxsdmyIZb3q4JgQokvo2wG2wIkN4a09U0YbxCBSWwmDxYgtN8709vcRxzR8hfONKzzyNMKsYG9b46RdfmKkmGk74oJLh+Betdf5Q7qnES9Jan3juYxaNn9REIQSMw7XTS0xbNOac7dXQQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPSA id
 578A9180009A; Wed, 21 Jan 2026 13:41:28 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v17 04/21] qtest: hw/arm: virt: add new test case for GICv3 +
 GICv2m
Date: Wed, 21 Jan 2026 14:40:55 +0100
Message-ID: <20260121134114.9781-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121134114.9781-1-mohamed@unpredictable.fr>
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=G/cR0tk5 c=1 sm=1 tr=0 ts=6970d78b
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HkXMOn5Dch_fMdOo4lQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExNSBTYWx0ZWRfXwohgR85BsodD
 fN8BrwYsPbTdVnjxpQE6db/1ETFLVqfTqytbfLJfuQg5kTrPPwCH/TeRIp7nSeLUeQyyDmzKNM8
 +lzc7Kax3APmNn0XABc8W8iL99bnGNBKiiULAE1BYbJREN8D74UlX0aEjpEt6Nk8gxPJAeQbZgT
 DakgxRohJKbvwzikrpn/nmwMG5Dh4bwzQ66qPDKNKdgffC7dyyeUOfWgWs//NDQOXE5RE+bKtH7
 UimB6u9DGBUUzOc8s3skgjX6nI3YV7HoUCOemc0lOVOP2EKmD+QLtTf8DralZl6c5hlUh90fmPd
 s0RhcaLF+bgCyRu+eyI
X-Proofpoint-GUID: 2RS7jPjB1JDZPYtl6qFxEVC0I5KTvbHF
X-Proofpoint-ORIG-GUID: 2RS7jPjB1JDZPYtl6qFxEVC0I5KTvbHF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 adultscore=0 clxscore=1030 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601210115
X-JNJ: AAAAAAABLetjPRkxXqQRHrNSQQUZBl3JQuxvz7I559hCfYuL0DPE1aJv5hlBKnOAcNLFqTgFagoEMfLySkaeSuM1oaup9lYcAd4RZLIt1c2Pl4T7iRZ7MN8Hhw0yGr68wW8nhwJ7PYne/K/7bdD0H4xffXZvtuB98oLSMOC3QC4joIlJJWZr/D8B65ejlDMJevcteCwuWRed32zU5FcZcu6H+fEtdhKNXXnhG72P3ndjop3baEssnf2duvWn0lgo6XpEdDHrlmTT0SkADVfGHExjpXXOGkSryK9KjKcwWRcrnw7TzD1mrxAGTvx24Rh05FDBqn4aXmcZMi1Deawmt5dA4sruw2XfJ43Mf9jmRJl8xzeLxcZZuEGMAI/utnvIdGj9tbEnR8CcRWrHPfXKpUEGQmZ4F7GguitZNi8d9cwphP7qTGQ2c0nGCZ11bbl7r0J1qN7yVnZXYwNrsXHWKJXrsenok9j/AKeczZ0aJo9QE88yBn0/ksh/wlyEIBTYlaZb9TrWlAAQ6fOrVxKSkDbMr92xTIafbltZde9YWIJ5n+Q9OqEK4bwWeShOWfTMYzn9B1HyPfX7HRwRYAMDX5YoskEcXfMJRnoq9Cq2V9EPJx/w8iIIvJ38eKlK6AL4rAzpH9dnKRW/146H4ZS5ZrNqSLlfwt1d+ZWFm8p1S3HKsery9t8H8C1YQ0HHBvPtH+byyauarfnM73oBNEQcoJceqffk1qoJ6vl2y0XJoFIlAfNXMe8yJz29aOUgNpTPcOq2YGAT4a1I38GLhfgUmLqZh0dYzkSz6pW9JmHjVTSbM1yMQ7i7lnYoueYCRNgo5ZickZithfLl1fAnlKHCzRgfHn91zGFwm7/VaVrzc5Q6dC9oEYjcBSc6ow==
Received-SPF: pass client-ip=57.103.86.65;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
index 6b892ef23e..fe6af5412f 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2251,6 +2251,25 @@ static void test_acpi_aarch64_virt_tcg_its_off(void)
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
@@ -2833,6 +2852,8 @@ int main(int argc, char *argv[])
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


