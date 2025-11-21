Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048C6CFA76F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMNzj-0004os-37; Fri, 21 Nov 2025 05:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzR-0004f1-50
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:41 -0500
Received: from p-east3-cluster3-host9-snip4-10.eps.apple.com ([57.103.86.93]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzE-0007tJ-Kg
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:37 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 9EA281800130; Fri, 21 Nov 2025 10:02:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=9vYko/DI2RK+OqhuWK0dyFWYB5OCgm45PuZW5dC4nJ8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=IKbLvtpf/69TQS/thfNx7P8PYguBkRl9l4/90vQj6Qksjzfo0d8e1hJiyW4zALeW7YCdFXOGSK/lCV+i5pnirx2P5OZoHicnvq0XcB5yg6A2omHci1HYqTnT2k6yGU4yMTD4N9oFo1fJNKCTA+yTFAqnpcKQDsGUfXSwatrdQt/at58w4zjgjflOVuYaqMzLSApLxSHMSdZCVQ3jBwVcwKKXG/bQStXfYiauCpU5vxlk1Ie6Gr8Sjc0mE8gmtPSST4B5nFi+Fc5s5Yh3kVEWk7KHxF+1UYmal9+mEJfUk+7JwjGMZXRrvbOKBipLvbyWt5isC877QGVAjXu3fkPbBw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 8DFEB180016B; Fri, 21 Nov 2025 10:02:51 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v11 05/28] tests: data: update AArch64 ACPI tables
Date: Fri, 21 Nov 2025 11:02:17 +0100
Message-ID: <20251121100240.89117-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121100240.89117-1-mohamed@unpredictable.fr>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _jx-qDq8BsZ5bjzz4wfRj-bgPMTgf_y8
X-Proofpoint-GUID: _jx-qDq8BsZ5bjzz4wfRj-bgPMTgf_y8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfX7REoM0sqYaUv
 D9Mq/2qdjimcckA2XJXEDJF2YOu19reGc3GHvWfRwNyZj99DRJXTuGHval4fKKOSHEGBkHrdnfJ
 pNwO8hqMuaMyvaZWk3vsxSeYOLKvwiwF0uy3v0jASxTvkDIGzzuT8RZn170TptbIvqUXPeOP1DH
 nmEAlfjCwlsctt6GhzurCv7puuO58Hrw6815Sitnv9yAGHLaG44wjUhaMyukc+bF3fm5FBzc2jZ
 9uinDm63zKol9ceDKQ9zavSxxnSvj+RDDNs27W67fkDgT5rPGwACjOZ/NFDUbdf5ei2HiISyPLS
 1daSz7hxQi93gbhcdA9
X-Authority-Info: v=2.4 cv=Oa6VzxTY c=1 sm=1 tr=0 ts=692038ce cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CvHhVyPyXxbOnLnphYAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1030 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 phishscore=0 mlxlogscore=931 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210076
X-JNJ: AAAAAAABZ0AUPOmFM1o3Yr4ylplYGmtZMMCJNYE3W+29wUcdLpHbyMsOuJLzJqB7OptlM3VewR07+Ai+JQa0TNXyd1HIt8bi7BiSKd1rSy98ECIxDFb98mHh7ySmRd4fpky+Kx4o5NSKI3Oc8wbNmoiJu+2hlpZODslo5UdMOrqdQBoTTiItmw004Lu0QRUVrWGwshkYilKfn9E/M7OD3K1VpcXFtV3gGJE54UMFVL9azwsKCsapau6LPbHCwJtDEmp06cmjgLhFUwZjzUKsjmzXwNJxI/VJiN2tAKm28f3nU1jMDcILmR5vxgmu1rVslabxKyrQFhExfRMyb/kbv17PHr6Gi9mNEX+bcc+7II1vJkDCUP7V0P3zk3MNY9uEwL/HKw6XGhE8d43wsuIGczjso3GrGpfOg6LGgGxInBhy5BM1XwPhRYIcSFx55bogyucmSTIcaWHHnSNthE462l816me9ZdYcJrOtp8sXkk1Tf8of7yEOUgTtGUaA0WBR9s+EVJqxv+odCm2Q0oOyjjl/MEP+JdIzbFFQ6YESGvTO53mxXtQjzZwkH7lycRrf6u7TJu6ctQPQ6CaIkDY81RiTFnq235CzppULQFjNovvgMnrFkfMKBxs4Leq7y4wA2/cdxhnPq/8dVlxFbutYjSDt3wjLcX8Bwc3yrx2cvoHoztU7AhLmRQ8GPy6BKRWjKchXUnhBg7lt6D+Wzw74565trnXmjVanAD/OcvGa4j93AqlIQr2CvkcYEzGC3ak/mHE=
Received-SPF: pass client-ip=57.103.86.93;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

After the previous commit introducing GICv3 + GICv2m configurations,
update the AArch64 ACPI table for the its=off case.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 164 -> 188 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/aarch64/virt/APIC.its_off b/tests/data/acpi/aarch64/virt/APIC.its_off
index 6130cb7d07103b326feb4dcd7034f85808bebadf..16a01a17c0af605daf64f3cd2de3572be9e60cab 100644
GIT binary patch
delta 43
qcmZ3&xQCI;F~HM#4+8@Oi@`*$SrWVwKqeS4aeydBAa-B~U;qHCpaq8j

delta 18
ZcmdnPxP+0*F~HM#2?GNI3&%vRSpY3v1aANU

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index bfc4d60124..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/APIC.its_off",
-- 
2.50.1 (Apple Git-155)


