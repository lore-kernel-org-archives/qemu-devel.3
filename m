Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779CBD73E80
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXZA-0004lb-12; Thu, 29 Jan 2026 14:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZ8-0004f4-J7
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:20:30 -0500
Received: from ci-2005e-snip4-4.eps.apple.com ([57.103.89.175]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZ7-0005p8-07
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:20:30 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPS id
 088921801889; Thu, 29 Jan 2026 19:20:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769714428; x=1772306428;
 bh=ChIhwcPMGVA7/ZQSbYVEEiNk2wqKK9/9DHnWEjCY41s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ZwWoerl99AYjUrYQUZveKjBSxCucyoja+12VwRJ6tk8JK+UdTfJk6P8eDR44a1MnAKUSsUguG45mPirD4Dw4pTZTzyctgWdV/guTfeyS5bTH5YPwRcleqIfOdT3Crs1tczsOGy2yxCs7xSZ0ak+crjT0TSWSN/LWXSjeIcN43R8ZDNW8j70LkvPzROnrXD2PTIyQJ58ZzQhLWwC0xIIsSKUjMUPOTGSpYmz68O91Yy7aNQJ3HKn7Hr2WBrKampWr7ojUgY0jzQuv30a+/gu1yuiK+jdPeQ73cTQsJZqe+b/5IQTjGGaNQJkXfY5qCX0vrS17Ewz3s/fKVyOm4k0Cww==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPSA id
 7E4A01802009; Thu, 29 Jan 2026 19:20:21 +0000 (UTC)
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
Subject: [PATCH v19 03/22] qtest: hw/arm: virt: skip ACPI test for IORT with
 GICv2
Date: Thu, 29 Jan 2026 20:19:48 +0100
Message-ID: <20260129192009.14707-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260129192009.14707-1-mohamed@unpredictable.fr>
References: <20260129192009.14707-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzOCBTYWx0ZWRfXxK30N/6D5baR
 d2lmAPC1OCr4XFevJodTxpvWXbfpq6Q+1x35LTgkM0zP2jjlaltts/OUlqpr28316UYkArZk6ae
 wpqaLICwKMmrTL92PJoqHOQzEAHMYpI7UVJ2TAadCKiiWsyyhzDm+fhqqzeIqslq2SOPkUxfkqc
 iAaNj/hyS8VvYtWr5oy0UT0aa4LgsD797AXAigX+779ZZeFA2SLJRGbpatYbji1KIHufPrPxZ8R
 xxkXN9KkVtWK4wrCb43BYidwOrMkzWfwLdmDdSuTf2zT/dsYgw6NO0w+LHapcKzhNyXc8lGJGbE
 dp5cZ1HYA31fUWbboh2/pJNolGezIdBPYNHqPEe60vkysN11XpTTIFyQUzVxh8=
X-Authority-Info-Out: v=2.4 cv=NqncssdJ c=1 sm=1 tr=0 ts=697bb2fa
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3bhNkNL8zgIfWImNCT0A:9
X-Proofpoint-ORIG-GUID: 4XoywZy36S2QKdys_N_xxfmEf1tv5hBN
X-Proofpoint-GUID: 4XoywZy36S2QKdys_N_xxfmEf1tv5hBN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 malwarescore=0 clxscore=1030 phishscore=0 lowpriorityscore=0
 mlxlogscore=998 suspectscore=0 spamscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290138
X-JNJ: AAAAAAABWtC4Z5r5XzVUiyYXcTEyzC+ztTwPQgZHIkx9JZ6L/cm0RWGQhEC6jaKjTX6wvE3AOr7ton5oisKoSov2L0DKLAf1eoQW1K6Wg7ZXBSITXAei2/AlOjVoa05AP3qud/wNsPMlQDku9ZqndFx8muDTJuTy65AJ/ZkKhpYyG/J0azh5FcsqcNEDxLDVUypB7ogoYJCzdUL/iVU3Nh8pFW6vvUinrI0NNgMDtTySKg/zQTmr7na4IPBr4njfnCbyTp+BVCfxpNLjkqxh8IrsyDyNWzwidbIgFLmUyW/ETu0WdddU1p+zG+1fTshwmfGvsEpQNjU+83SlgBIKKC7l2JmsBZXSz/Ve9RZvqSFIlbFKe3cll45vLXJicpCs7pT6HPA0wngG8Eed2joLam59rD1IjK74Q9nTipuXaU/w1rlnUZPqyTZ9PKxPvZNj04iNuONoeZYHk/fu898t4ALvNZr5fyZzr1nZ6lgG4oZzgoSJ21FTPVDol8ZpmbfuDNRs481/xnh3I8963FIrylorhDLLZpUPODNif3Lg6V+1qABuD9ZGVdBZXhVYSWyHYVMM6FJCoNZPY6bmuhVgiqdcDEBFvz8zQ2t/xYJ6h5X7zrDaeSoTgVM5t1KInTdRtgnwwJeyrdtfECaUT11iFFLjpss4iS3JWDeojFPEDoloePjxyu3mChvLY7Wype4hDpkA1Kw/3xrfMB7iFic+lu4/StedHd3LDBnn2z8v6uvG6WCK+P/7TzjdmXE0qYxLx1ZWw1ky1O3ztvJHB9ITFRJjcUDmvghAIvlhIfsVsYLTdoMnkx9rsU2dQZoYbrZrHOyNlQgNHxvzzUPiP+QK5ppSpfPpL38sWx7XYQJhRjgSN4gF2ocNzp3UiFrEu6NTiOuKn5g/Y2FA6gFddg==
Received-SPF: pass client-ip=57.103.89.175;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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


