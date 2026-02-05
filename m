Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA925E9129A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 15:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1E8-0003pf-IU; Thu, 05 Feb 2026 10:25:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1E7-0003lY-1P
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:25:03 -0500
Received: from p-west2-cluster4-host11-snip4-4.eps.apple.com ([57.103.69.135]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1E5-0001Vy-Iq
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:25:02 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPS id
 84FBB180019D; Thu,  5 Feb 2026 15:24:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770305100; x=1772897100;
 bh=ChIhwcPMGVA7/ZQSbYVEEiNk2wqKK9/9DHnWEjCY41s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=TxC0etEBsh0XcIkffkdDGladTe1Kwt+75RV/J5LHHNNU5l0m7RftAfWqnuLt1CL5C3V1dd79wbDynED6zrz9pdL6A7qp+WbFA9a3Z4IO8JGr1nyvqmPXwvNWufH36MCCSi1Mzr7uRA1ZFqAcSZ8bDTA5tD7/AMgNqF+qYvCPU3EsznNsEfwrSRIFFoYCIA5nJYInerK76Iu/JNXxWyZmaR1mFC4Lbdu2dz4z7T5QzjvkVbp4uT1dtyHS9GULzOtvzuf+xmmEsVATl2to++8b3eafhZt6djFNEw1RvQyiOyGP4++xs4U/OknBBpBp1lhCA6GjvLexJBV1D8mCCCTIvQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPSA id
 951A8180077C; Thu,  5 Feb 2026 15:24:52 +0000 (UTC)
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
Subject: [PATCH v22 03/22] qtest: hw/arm: virt: skip ACPI test for IORT with
 GICv2
Date: Thu,  5 Feb 2026 16:24:06 +0100
Message-ID: <20260205152432.78208-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205152432.78208-1-mohamed@unpredictable.fr>
References: <20260205152432.78208-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6gyjSpQDP4GO0z8BK9xdITZ1YtEB_1zA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDExNiBTYWx0ZWRfX5jEVzeykaXPl
 gQmh8CXWxmTFvFjDo1oX4ClYLxS9fluRmDiGKaXGd2E7vURyzlHHgIww8xpIXZV7wcxa8+ZalNU
 9q61jWmcmjIPyG/9yBe+DKc3Y4X2Z5d/bRZW+D2GwH7VNM9Efmm2gMYs6v2Q5YiVhzpt9BGBk6N
 1nDcT1uvFPP1ZZQzg31hoULPOfj3lJPswIk5f206NR8ZYKnxqz5k2nlrpOZrCY+BB4+iaqRt9TY
 xmMQIWe/akaySyJn8IBLSfqWWNPEXV9ECr3dV7FIdNYBGM6s2CzYbty73tR3cHDA/Q0/VRWx877
 DUAIWsaJB3QhjOTwLpWo/FALF/GmeDGm7xjBE3aFRWrzYcD+fFR+2f35sVHYf4=
X-Proofpoint-ORIG-GUID: 6gyjSpQDP4GO0z8BK9xdITZ1YtEB_1zA
X-Authority-Info-Out: v=2.4 cv=dPCrWeZb c=1 sm=1 tr=0 ts=6984b64b
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3bhNkNL8zgIfWImNCT0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050116
X-JNJ: AAAAAAABLzdRRejxecrTrKBW8MgfNRrwlFGK9l1fvIeS/WCDmaV2JTjsqLn9uFe9p/sKbazhicSrVzL8dV737RZPDGmisdYJ4GZxeMfrjNrIlM2ig8JT5uzf/21ehiX4eL/q3zkYB2D9nbGwS/FYBzm1C1UAa9CNdUkNC0lqcjRhIr39NVjkMFEKuLHqFZqIX/44VcYY7Czi3LmMhxw8M8ms1c1/QgXW8PNj6ZE+it9Svztjz+IdHdMrh2mRXiMRq0HEqE8/9T/kHLAnt65hkV2w7Eu8w2qSb8QfotjZTYYojrCIY1KRfmqWvpF1JLxQkTGxVWRGHNpE7xTEBp+vECq/40wU9YRr6NTxZw0gevzeKZ5b2oungmSL0wWe1DPYZUm+haYmTFI7y6ET+/Ld6G+hG4nD97yxiMF92fpkpFqVPdL8AURQ62vOVNAoj4D0frI4TBUs2bghwpfHl7BrizLlFBRNs/foAHetKdJZ4hR2RObZyYZbd2tjm5F10T9rDl+4KfsyMYjVLG+OdWS7SWnbGrYsSW1kCXX96Z4n1kKHunMazA7JtilBAHLVU12nwPoHztg+KG64gifkduKte2n5G+paDzGYgPQwL1FiiXM4hjKIdeXNTTBbpVoLKn6+N89Jmih4HAqIQkgyChOoici7b1ph7f0hIuHBPQ7xRzYBs8a0KsxackmQuYQsX4u+f+rY5RlaIeDZQrx2Z1FG10+ZYT6W2hA/iABDSRFcC3PQOydR8ja24g5ROakZoErHEKiDZL4s+NqSZV0KFRwm0MZx6PGiHUnmyJ7lm8dWWGsp61Fo0OEL8mDIiTAPBpVxC1VTgnLkfMkCVTfokYR4D5jn39dRbqi9DNOwnKHbl2j3AYEhhHUZirXv5RN084jrn2YackSmKyu9Uh7oa5nUAQNXG6xM1nmbMJ1x+A1KtWQAaoIL4S4fzrbCBXe+mjiERIWjO2bscG0FLScAfSfIenZJ/w3MiJ5
 eDNI=
Received-SPF: pass client-ip=57.103.69.135;
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
 tests/qtest/bios-tables-test-allowed-diff.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..7acaf464dd 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,4 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/IORT",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
-- 
2.50.1 (Apple Git-155)


