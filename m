Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD89E9128F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0JI-0000yT-2u; Thu, 05 Feb 2026 09:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0JE-0000w0-8k
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:16 -0500
Received: from qs-2003h-snip4-11.eps.apple.com ([57.103.86.83]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0JA-0007uw-Jt
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:15 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPS id
 499DE180014C; Thu,  5 Feb 2026 14:26:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770301571; x=1772893571;
 bh=9QIxEvbHNo+rywotPm4qpOSZ6bu6/BOqqYkQWv1CMRs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=TH1mDw8pJekDZPIWOYguMVlXKTDAFHvFCZ8z/lo+ofXLTXkwWKhytj8Z4Jl+6SYBHFblMcxSlgvlGPAKd+0SxTzNkMa7U1qrLMr30yw3Ka6sY+Y+46zAyUL9we11mIVBnsTYz9pV6Dpv9HP4otzZsByNJq190X99fOfq2zqOvwssoWaABoTYPjswdC3OeVPkxjSQ8dlUksaM8b6zGMDXqcMT26vePPJTwx8bQ5wrX0DNnq/cbftO+hmP2spNOCy+8UdqDx3BdjLRWRcP/3+UshrP1rvt/O7ydGNV0YQvH1CdfrnLIWKbXy4FYPK0FsmGrdtbs7JaMY7xa98da/p1RQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPSA id
 D2E661800264; Thu,  5 Feb 2026 14:26:02 +0000 (UTC)
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
Subject: [PATCH v21 06/22] qtest: hw/arm: virt: add ACPI tables for new GICv3
 + GICv2m test case
Date: Thu,  5 Feb 2026 15:25:24 +0100
Message-ID: <20260205142543.64818-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205142543.64818-1-mohamed@unpredictable.fr>
References: <20260205142543.64818-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iTCjNI2NvEX200EsIIPuUBxbPiVo2loo
X-Authority-Info-Out: v=2.4 cv=dozWylg4 c=1 sm=1 tr=0 ts=6984a882
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t89SEOTD3Leb8Qfr0uYA:9
X-Proofpoint-ORIG-GUID: iTCjNI2NvEX200EsIIPuUBxbPiVo2loo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEwOCBTYWx0ZWRfX6zBWgNbdneAO
 JCwZ97PiI5yHmvRtdff7WM9tmQ9gEs9cA5hWhBL3mP3FD4pVJbng219KMDN2wTM8TVaYkzMuS9z
 x4EbH2mHKb8OEhmYa3WCwryfUhRYTZO42ehlbaT789yefKyebCPoaoaPrBKjVzZ0IDX6IPkib79
 xobgpoc/KA64qPPMlewPgEB9AZw22o4EGzvhoK6w6vBhO15hroHJUFweaiPawOe6Rah0W7qKehX
 SCia9h2jJw7KrBYCvvMxcjfhjRsV5FgaOQNYv6hxt35A1FLLPWFRfkbMSm48HkXD2WAd5XtQBw2
 kk2+qUImURswObLp/OHruG1muK3IWVSLMSLRhWS/QWlY1B/VUipf0+2CynyWGQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050108
X-JNJ: AAAAAAABoUvExQbMdMgOAkCtqLl7bNLuoL//8qCJhDycHhogOMCEG4d9MIdBkb5zOm5tQ3dATVJX5/zeCzcm1K37M+T7BYJ9Mp2/1CywjbKsQoecOnyICmkWOEMtMpll1rhD+nFOEz1QJhFdJuKmKvTLha21se7d8QjFydt3rjDR2D70ICs/0UEuZ+6UCuPgGIN4hr5nV6sjYS5KZSlbkKz6Ri+4e3qIvMBRdr1J49+r1BiBJw6yscUiNpmI/nDbAA/LUge6AMXCfrvawNQCzl0Rxn7rey2FI4Te2gmY6BXqCUIk3DMs99t9UoXzetsbJKQkRfUQbZVrZCkJIkoofxKPUcob9NNeMVJZYrMSdbRitD9nsVsDy8BE5XQCuBV4PYPeb+I702IGL2AN7OiRpFBT/5xjReFW3RC+aLFukcK2hXJFzC7tFL95K+c31DsfK1vUaSQB9DWddL94+wLpcOA+r1syFO4180mjYVk5wZWuaghkbyp/qeyD2eGZJ+sW1R6Ujm3OAIVKgN/q/FJPok9YVs0gYMC62i2kaqWyFZumcoSTqYL4/bQCVC3wQdxR+GAvQwtOiT8X6/wF4lxLhj59nniHSONOvdEWW1gqg/m+m+0wd3IZ77WBXyXz2XZA56+WUI/E8zGZLcthsjZW2Wqsj4Ct779F/wUD8xtJFgdR56ru17bqgVOnrcEeMRfyUxVCiXnA1re5IYLvpb7M95vF2PPyawCLtGdO7pzSeIM9PrlOn1HREXP4vpm9JiiOFspCHtKKx8LiKlywsqaPJazWMBN1L+Q4uiUqouLJ/ZOlUFwun/1K6e/ZC3f4PRJCPKQ+Y1GPBAXCzn1qCIZCv2ea51ArhcxyZVUrIPoUHYM78XJZctxW/ab+1n5+IWVew1G8hD5fgJ4XdwWwoKNzlCJ0bT6ILAlkTEQTiCmpjlLK3FyWe+BQAYoTuWCyItsK3ruK0QwrZYh1Kn6l4p0cRJ57wPkO
Received-SPF: pass client-ip=57.103.86.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 0000000000000000000000000000000000000000..c10da4e61dd00e7eb062558a2735d49ca0b20620
GIT binary patch
literal 172
zcmebD4+>esz`(#f-O1nCBUr&HBEVSz2pEB4AU23*0%8Lo1_2fq1{MelMzV5(SRi%i
nAPXpv4aB)XoP#9EWWm4;QV+r^P#Q=v12GslK<WQb8fG^DHhBvH

literal 0
HcmV?d00001

-- 
2.50.1 (Apple Git-155)


