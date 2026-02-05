Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487E1E9129C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0J6-0000oE-L3; Thu, 05 Feb 2026 09:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0J4-0000n2-Fx
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:06 -0500
Received: from qs-2002g-snip4-6.eps.apple.com ([57.103.87.197]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0J3-0007qo-3B
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:06 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPS id
 E494A1800DA1; Thu,  5 Feb 2026 14:25:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770301564; x=1772893564;
 bh=ChIhwcPMGVA7/ZQSbYVEEiNk2wqKK9/9DHnWEjCY41s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JzTs0q1U2kud0n3gI1QAFerUJhrv7pbgsNPVUnGqUNvgP6FwWy+N6KEbCEp3jrrBnqkaczgrVijLSdJjVmMwf6sr9m1fXKkLytYObp8Spo2i8WXn7ZgyG3FqW8MRmiM83Mh1r7ZEy35+bs9lI2a6O1euiNKOYnpkPtKueQjk8T29HN10uJgd4jNvPRxnlhqTKpcvvURBW0lp9Z1GdS5LxebTB9OYVpXUMSHUQ7F4GE+lrm5C42ggxcRnpQHX6Pz9ccZFjv20UAPu9nnkaCsR/K8b4OwJyKBdm4Uyd+JfZBD2nRn3XFvC5+jAxwDPH8gJGYxAxhW6dH3hpP8BecshOQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPSA id
 3B1E71800128; Thu,  5 Feb 2026 14:25:54 +0000 (UTC)
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
Subject: [PATCH v21 03/22] qtest: hw/arm: virt: skip ACPI test for IORT with
 GICv2
Date: Thu,  5 Feb 2026 15:25:21 +0100
Message-ID: <20260205142543.64818-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205142543.64818-1-mohamed@unpredictable.fr>
References: <20260205142543.64818-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEwOCBTYWx0ZWRfXxHPp7X0I8oTP
 +xbwXNRm2jmFPemcUn3Hubj/AI6jGGxJDoMOfLjia3hiUTDtdZ5dpvXQfa3e199M0puLes8Rzms
 BxCGOSIuQeks18Vw6CSD8RcZVei113Y+y9EDcOsCJMjljuoiuyODXg2EhM0nyGDJpEikAygKMS9
 +j/VTJbfj3E9x8lGUwb4Ete4IrcZBOl0Wrg7QEhQZlE2y54CW/2oCKNrg26ymyB/tNeK/mqr3I9
 ka+SBXMHX+GbGlLVkZRsplKQDr+4Q5M0umH9gNnWgJdlYNl2A3kgeT9Mx0IU+b8a+ain9UzSxzj
 Qtn47hE1L/7EtnmyRr1y+9KC9FUtmphw23tAoy+sBv8ULnddYNByjCDVhDyFd4=
X-Authority-Info-Out: v=2.4 cv=V/1wEOni c=1 sm=1 tr=0 ts=6984a87a
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3bhNkNL8zgIfWImNCT0A:9
X-Proofpoint-ORIG-GUID: bb1rVl0rrycccUCMz4oFVg0LfBdGDMzT
X-Proofpoint-GUID: bb1rVl0rrycccUCMz4oFVg0LfBdGDMzT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050108
X-JNJ: AAAAAAABcQbziiXBNRenHHc53stuyxZFv1onlJRYZB53NDIrDlJsyWQQ3Xkw+RnYSMMAPNYWwoqpKszkI7Q4Gk7Nvjb9s+Qnk98kM7L8n4hMMDJFN3No9Wsa6K6UNuPxiGVG7W9Cf9APctRqV2FrkLmGD6r5bFBe6QaRMoGRbK+nxaBX8iCIQBtTF6JvpJxHJUSgpeJpf3Dk++1EEOAe5Xi5gRREQlJeqX4NWWsewP7rahwWnFEnY09zt/iMBlTguLXgosZYaYNatgh7V1K6Dieah1Z9dPpTpVHjjlhiWexdHz/J09ON1icdbGILwX3Ucs6KyEJ+Dv79TVBE3XFlP/ZMxwljFjA4aR1Z9szv4/WtQu+Okr3uCC/bTnAlOQJkp+mdgclQfh4AzaVQ8UkzNO0G7FhlMOZA7u+33vwyXWi3+9lwS1yx0LWtf0PAAPWbG4FMqN+LslqBf+P0PbOMF9dbPpw/aWNuesCPerL2bBcyS2HVO6JfL19log5zIQH20KemdVYWDoPdw+cfsix9Ue3jb4sxGbWxI3noN97qFhaoM/jBICGWDGYtD5UHz45ai3JP3VEp6nOIS29YHBn/NuBeujrqG3kCFvOsMZ7xskkTIP36PYD3rcE6guvCqHeToS7O3g4eJl69b6ocaM7CAGlvyEIe/W1oarhluC2Md07oU69WfUN7lolfg9V5OAUKdNwh231KZmw9nGgSmWQ01VrlZbkFCbve4Qz3EMKG9JoyMeFbLSVirLx6XO2LAU0dlWW67r4b9+IzYAFYBmS6ytml5yfwZOCDtZwLsLSZjyERtb7f3n+xhr3SbDar2MZHArFJF0cNNbtUUImXwdXTCRVUtpIGpuIiXMh/8OxvwPo+v9wc/ZxwYYyETS5eT1hBGhU3R3E7GcYLFJyeuVwr3tjxZYXnnxu7lWbYuRinTDvtKrRWS4yU4D1pJqjnE6Uv2oDXt42G3WqFNu4GLdRh0ENgR5adCFz
 g4A==
Received-SPF: pass client-ip=57.103.87.197;
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


