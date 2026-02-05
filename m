Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B34E9129F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 15:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1EL-0003v6-FK; Thu, 05 Feb 2026 10:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1EJ-0003u7-SY
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:25:15 -0500
Received: from p-west2-cluster4-host4-snip4-1.eps.apple.com ([57.103.69.242]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1EI-0001ls-6M
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:25:15 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPS id
 EAA4C1800755; Thu,  5 Feb 2026 15:25:10 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770305113; x=1772897113;
 bh=aqd3TSOX4FSWm+RD0fjzPAlLpXDtMrMmX8e6iOk1vDY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=PbCQE6RLu/gI8vleBR2mIjm5WDkkwtglFNxGsSNFkEYPntyAGAEUkhOtxe7xG8K1Ox48j2esrt7LCDHkt9cIKfdccjqf64IJxvS3dlMGtXyNRiWJa/mS78CU8sY3aOsfwLbuS3Snp366AIhhZ3dtftYrI8f16ET8ffqgREb9qaMxu8C+sFJyInPULZlWk2R6ACNly6JxbJ+wh4BcShBzaq2VIDwI2g30hd1IS/hQBjtkLmXVew+/Y1vT0shcdsKa8ZLYkq3Fre2jwkA1bM4JvG3nUddmOPdhRRKu7PJtVTpL7dDhDm8krIKSlhzflUcxR0s42Y1Hx+LImLjsGAoRjQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPSA id
 2CBAB18001DB; Thu,  5 Feb 2026 15:25:06 +0000 (UTC)
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
Subject: [PATCH v22 06/22] qtest: hw/arm: virt: add ACPI tables for new GICv3
 + GICv2m test case
Date: Thu,  5 Feb 2026 16:24:09 +0100
Message-ID: <20260205152432.78208-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205152432.78208-1-mohamed@unpredictable.fr>
References: <20260205152432.78208-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDExNiBTYWx0ZWRfXxvxd+46f4jb3
 GoVwPJLQwmIXbN+DS/knaFsPiMSlcIqgwYrrwd5uavMMnbPotkCCP88WivPsVGtVYYv3PdwtMKB
 VdAFn87RqmWE6rB94vKjpagJQWLdtAwzfec9zuoGahxgUkLBpte/6ciKN4ZQgNH9ujdb0+uUQgt
 xsFuGgd1H0j802cuZqygdCfQvJbsoS68qcKhhRz84zU48XdvPEM+yhCzSeueGdaSc3gxCvInD6N
 YzSOayFamZrqln3Zy4/aAULvnP45Welq+GiUDXjs/OZTIEPD/tIzMoUVft4mGpbZ8qE2KyyUfh1
 5yRodERc6Wn9MnRwbzZ43BxHvJieBnEIytRWh9KueTJyKTCYaQZXCHMBM1p3OY=
X-Authority-Info-Out: v=2.4 cv=bf5mkePB c=1 sm=1 tr=0 ts=6984b658
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t89SEOTD3Leb8Qfr0uYA:9
X-Proofpoint-GUID: FbvgK2NVsX75rYnNJv2ka6DBGiuRtW0k
X-Proofpoint-ORIG-GUID: FbvgK2NVsX75rYnNJv2ka6DBGiuRtW0k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1030 adultscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050116
X-JNJ: AAAAAAABkrVnZJsRstftENZ8T3p8b+2nRMdc+rXqKxi3h8Qf3GQ1bN2by+LGTnU943OIf3ij6GuRxgyfAx1m7b3fFrg5nnoVBGDTIPAWLd/K/zWWrSKrE5yPUiWsOneCLKtR9/lipxAsbX92I4quTCZL2Ti0NQCytMZOj2es/43pHpbQvf1Nbruy5UJd9961qOHuDR4RXqKRhpMI5m9AXUk8lDOof0jhR7U2LoO8d8yJzqAeMPr1ZpOom7SBwVjleFc0bSA9OO6d+nquh9NQ7d2OwtctseunpinIbdsyioSH0a3diKbb2yS/nKqxW6s3MH9Xb4meh+HyXUqI4esFfRfVuib6yvHL3yJzaFE7M7GxF7/PvygqBFnZv1Ga+gEcicGF1rSBu9LF8L6tNbXOMdDAMwtsKRY5OEI/QJPN5IzLGDbwnpFhdCUTAxQTY+2Z8ycNETpoYArkOuJMeLEZIImNFswIm2qYjOxw2HYy0j/GWlWBNpYKUsvGiJUfelPTx32iP9dJcQpEZqM2ot+6vEoUOHl7B7HbafezPqAVzhLUoVtZtbrnFfu0TuQ4eMHojMQFBaR42+ikCy3Z8O64hebAIf1/FkAWyF3+3+JaF2NjYdbZxsGpYRrSKHQNgqS7iujSbtZwtJQyaMNpSNSy3BtF1NBaQTileAfalKEduC7sW0g51IQZgEx1UgwVlWSUrGVzCOIPWy7NQqJMksdNaBeNSX3ZOfSeNZ78//EzY2jHcSB7k+O0X7PHe6LoYg35Gkg+06HkKLWZGAUe3pWItX+Ajk2mAZJXciaeJA/y0JMObS8tzXml7DJ0j8kg3rJk5rnCz/i73PbxoVQs/YG682byGbhwso4+CIhHs4qjm6YH8fd7GKZyRUG52Ukpc/Sz9PvO39611f7B9CmE16J28/g2Vtj5FwcpiruHU4UFNf6B6TdxuJt7or/EBH5lvTBo568l38eu6V4PjlYRLXJ8Ir6qBDuIydc
 =
Received-SPF: pass client-ip=57.103.69.242;
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
 2 files changed, 0 insertions(+), 0 deletions(-)
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
index 0000000000000000000000000000000000000000..0cf52b52f671637bf4dbc9e0fc80c3c73d0b01d3
GIT binary patch
literal 172
zcmebD4+>esz`(#d)yd!4BUr&HBEVSz2pEB4AU23*0%8Lo1_2fq1{MelMzV5(SRi%i
nAPXpv4aB)XoP#9EWWm4;QV+r^P#Q=v12GslK<WQb8fG^DHhT*J

literal 0
HcmV?d00001

-- 
2.50.1 (Apple Git-155)


