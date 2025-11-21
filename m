Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AFBCFA761
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMNzh-0004oG-MR; Fri, 21 Nov 2025 05:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNz7-0004aJ-Bk
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:23 -0500
Received: from p-east3-cluster7-host6-snip4-1.eps.apple.com ([57.103.84.182]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNyu-0007rV-SG
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:19 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 4D8421800175; Fri, 21 Nov 2025 10:02:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=lE935EhSo6eiiRGBTf1TCzdO8HBh375WWDyS664DB/c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=OyPc0UCqAZJLzQzaf5ad2Y12VKcK/dCSe4xe+oXuY2cPJgZvx5xXOF5Qi5qY4gU+83T3fSyJToSa/qL+ZFWuaZ13IIz8VEBFwZNctthHsNIaX7KYgEoqabbu/XyOsuJL+3Q6mgnMNyVcLdsk/eOuYYipAvKELuX4Er3AOgibKUF8MjSXJeSinExYJKNPJfY//7/N9cuJXKCjr+TnPtXFmBChZJZCx/C5tyikxWC7AkETE5CD3yeI96UKYu8Af0EDH3u2ea1In9NRucHqlz+Vy37mp6ay5OCF37cabGP84JK8pvUODDCnMSIU872WNuyEhH6snBiRhd64OiaMDHbr2Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 100A81800130; Fri, 21 Nov 2025 10:02:47 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v11 03/28] qtest: hw/arm: virt: skip ACPI test for ITS off
Date: Fri, 21 Nov 2025 11:02:15 +0100
Message-ID: <20251121100240.89117-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121100240.89117-1-mohamed@unpredictable.fr>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=P4c3RyAu c=1 sm=1 tr=0 ts=692038cb cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=1t8nasy7xzbR8br5Zw8A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: IowDia7XAf8QSFgdabAG7Nye8ETo8hIJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfX1VXs/d2MPE2Z
 lC8xcbgwgxQmmZXl1U6JJuxUNTWJdwWVkpXQzjvC+OOtjgdPmmsPGOHm5lBlBNXN3FXMqWOEiQe
 zm/CwZhenxNfYIG/RfEuzhp/UkO+r6XnC0T8mdFy9A7MWhxZthqqUaa2bf8VWaSiCMifJFHDQ2E
 YWKHPkzyI957j+S2uuIfL1k3NHcvbeawZVZQbUCcaAk4F/fWG0eoX/cci6i2h4rA+3Czr7tCNN3
 Fym1I3JC0E1b2gs0WF++vMiohEmTXf/E9lmgnxrUAAs9BO6DadONJDeTPXLsIszPeTstWc3DyCB
 NxVK7udkJ6MRJ/khZe1
X-Proofpoint-GUID: IowDia7XAf8QSFgdabAG7Nye8ETo8hIJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=910 mlxscore=0 clxscore=1030 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511210076
X-JNJ: AAAAAAAB+hdFq3Gaph8aooWwmAd3R+SRnBCTHWbi0n1959RZ5sM4WOYW9IDwzJ8Ck3FYWTTP2/nagJBOt6eY2avFD6KJy8BYS1XtnM1B+RiCzU5tRTN03D/34CeFy5Rz/jQZnY+yvC+ap04UFoz+7T5YTyiclnhNcI2BAV4VWns/TRaIb9bR/YbMy9JFLE4DXxgG5u5uZKCipzb7SN7I8863hNoaTFCw/dd1qk6ICPQqcDilNh6MGDl2NcFqwOhQB0G3g0OLfsy/IyI8hlIc65A+/j99AQhh6lzCwgmyod4OEeF/jeQfwHRcKLuUSVnNS5WsZyhygPcLdTZxmhKN/kizBECLZFRLwSVwoNkhStueqNRCu5Wsr7Yy/PMU0nnRvNFGrlkiLdj7hpiaMC33XsE7l9ktOCJYInfDA9t2MDcylOS7R8NXLppEPfKecfc/0/72MsPJHOI/Fa8y1PtfOhoZQxZVqLINIJZDl5iF2gO6p62r9Yv0a5NFwCPBuO6MeN9ARaBs/eeYDFXhjLRUHoiZpCM+Z9O1WJ/5l9vNos1n3Ts5cUrQXMwc2wf1mXi+Y586uuy5i7H08qktLpQ8JPCIIsUKRw4q5LfX8BGe5D882g7quDBZZ1oX5VAHWvszJclpaS92sc8Za7GEg5nACUE3JVd9lmxoxGQJtOVd/4s85fzjSOQM9xlGmy0owGVXTTAF+unG6Lr50t1gTUzKlNrYs+O4gLroTRXcI1wpDP4AU7vUSZzjhxLqH/dwpuGFh2FbcZH97Q==
Received-SPF: pass client-ip=57.103.84.182;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..bfc4d60124 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/APIC.its_off",
-- 
2.50.1 (Apple Git-155)


