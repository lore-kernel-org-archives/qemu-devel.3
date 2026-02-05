Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6457BEC1EB2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 13:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnz9n-0007aq-Ej; Thu, 05 Feb 2026 08:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnz9h-0007Zr-HX
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:12:22 -0500
Received: from p-west2-cluster1-host6-snip4-1.eps.apple.com ([57.103.68.54]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnz9e-0001Wm-M7
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:12:20 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPS id
 8F4821801382; Thu,  5 Feb 2026 13:12:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770297137; x=1772889137;
 bh=ChIhwcPMGVA7/ZQSbYVEEiNk2wqKK9/9DHnWEjCY41s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=AgUCRyco+x+7P8h/0LviGUq02FcAiWQcKOiZsbWXU9uMd+BlWLKDRq2yTYiFVkN/N2iXGxm97LjimPCP0d56IIFJPj5OR2s+2DgQ8I5yF6rW8k2J/CloomPUjE5tQ84egxG3hQnlyQQAuZwpeaPwHCqNRzaY9uFNf7gjlKuZ2PPF8ZIby4m63hG3OOfCWfs1PfePDBIyf+KrjuOKq+/aIJ2r/t2jb9E5UiKDEwXXtH7mgmXPnJrhQCuIAhkkwgETFq9nxLYtFQMqpCIuPt/gj58z2IFS2MFOhdxfif4JUnPBDgXT6FS6UkK4tXM+sg2BgTnub5e4aMgY/wu8CUHiLQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPSA id
 434E31800160; Thu,  5 Feb 2026 13:12:12 +0000 (UTC)
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
Subject: [PATCH v20 03/22] qtest: hw/arm: virt: skip ACPI test for IORT with
 GICv2
Date: Thu,  5 Feb 2026 14:11:32 +0100
Message-ID: <20260205131155.22780-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205131155.22780-1-mohamed@unpredictable.fr>
References: <20260205131155.22780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfX5v5QDGX0EuOU
 Z6GOHQJEBwEUy09Qp8rZ4MuKbPboc9qY+M+GdZ2xnQoNm/OZTVG/MM78m7UoOz0/Yc98cjMKUOr
 u63j2jfnY3dKLQL0JUffbmmbzVeI8D4/J0Sj57lIYMh1X9dl5V4IFYHzF42vlrM/71dTA6koHCl
 XZWWORRo1N8ZT9rbNAaFnmaWgIf6peIiBrkNURt6O8LX+G5XLXftvGdg7d6U88em6cVO7tBHegy
 kyeRWt/YewdAnkpsAyCmUaoF1mxdreOGViMvhTqkEm8hJTTovWQYYXR0W+J2Th9WUPYnF4rHMog
 osCKleJ1NRtvefy7FQqtrVgoLXdFz+HuzlPKDzTC17UzTeRWOz5raFFrFcSCdE=
X-Proofpoint-GUID: wy-QXm7RNzXaI5iVq6GAX9K7PdyA1sBy
X-Authority-Info-Out: v=2.4 cv=Remdyltv c=1 sm=1 tr=0 ts=69849730
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3bhNkNL8zgIfWImNCT0A:9
X-Proofpoint-ORIG-GUID: wy-QXm7RNzXaI5iVq6GAX9K7PdyA1sBy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 clxscore=1030 spamscore=0
 adultscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050098
X-JNJ: AAAAAAABjsDjV8Meaozg8Nx4aBYVodx2dOXiEIS1fRvuDVPTgqtKGxuM2OIQHxl2kql0uhCuEB2oNG0e3KOO26W0ksb+4hwiqpkzPMSGp5L0MjDfDKikHuDE8CHNElUh0XMcpVlieg5EGtHi+qbghjyliCAPWxX4TbdYcw1KB1xgVas3OZRWlMzCY0p+HE8RsmorkeT0F6N/e5w2nK1NATzI4/UJH2Gb7A9wxUF95tDTD+1wJiFItsZLmlloVHMiWVEJcKfYsabL5rxCYJNnKr8AKKkecDJnaQAse2ZJBcCACJIT0DPRHyllinujOc4mRYmpnv8sYpWTqci+4vRx49pVGJJbRhRBTjymMxorRS512Ac21uR5nMNAb2Qw22vLz99usguWA+soVq8LKPszyzImVL90SpGT8nmqsIeNoLeN6PotNlJijEyrdWGrjfYkfP+zJLVM+spCXbAERyTJHXRGKUGPgd1s94wlugtkvWCu+Q7MIfFhZc3rC6pScOx8Y4zluSTSTWDiEMBs+2L4trs2UNTrncwdmAKIYMsLVnMbLsc+Epb3q3WY5C6lrlc7vhKJ0eUET4sqwE3KdQ6IPMMdTfb2WtKms0HZSg3YBfVLQlPE7+miDCja7l4uBU/+yWWhwc2Op2+OvLajlhRVIlAahBegmX+LOi5i+T+e8UNpGN/w72ReJXkUHBbAoJRbzpLcsXPJicPRsUnLymXXS7rsWCZrjXcrlQJ3VUlzaAc5stVrYx1Q9gACHYlzwex09Mx3h8p9TcqGp56Urc2ahUDz8BqHqsrxMOKxWp5ako80bniQuN0DfPSDpvgdVJLN381loxKAXBebmI2seJqG2Ca01ZiSM3VKou3bsDpsv8JTzEHhd46q/0TXlroQs7uKoGyvEv/z5DdWRGdB2eKwxWuSQR11PF5ofww7pDjLLaqDYiC8pxBjfQt/7Q1tCMvh2Qd0eDY5uSt81nCKes8QBH2Bq1o7vLS
 h
Received-SPF: pass client-ip=57.103.68.54;
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


