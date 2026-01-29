Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F30D73E87
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXZ6-0004QT-Cl; Thu, 29 Jan 2026 14:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZ2-00047L-RO
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:20:24 -0500
Received: from ci-2005g-snip4-2.eps.apple.com ([57.103.89.193]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZ1-0005lK-6H
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:20:24 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPS id
 BADA318005FD; Thu, 29 Jan 2026 19:20:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769714421; x=1772306421;
 bh=JM+IS+u2FhSUs+ag940jtQKtrbvFK486Oy66aTDOb2E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=gGYRdVFU1sTlV5314iJYgg2VxOjEhB4zjTqQkpJctXG1aiZ0Uj+EWngQxmGoECaznyb0OQpOAg7cU4Mfb52uXY7bj8I4QKj5HlCb0h/JHLUoKIoKETulWoT/fw3RjI3VcyhBKDnpaN3b9IAWYrSpCPVFFh0o/nSXAObsZtYWfKY29IduS4eDw5oQiHLLodTmgcEJQ3/pGU7aNfDdNAVZEOxmj89j7UjQnjBqw0d7uz6NaIBnfkeG2Bm39P/JZXSUUHZ11W/jAck451ifTYk/ZF7lmG6vi2xaHElCn7WviVLFBVF3+5/AgD64b99FbUymQti+wljZMYE36E1UxIrZiA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPSA id
 24AD618018A2; Thu, 29 Jan 2026 19:20:15 +0000 (UTC)
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
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v19 01/22] target/arm/kvm: add constants for new PSCI versions
Date: Thu, 29 Jan 2026 20:19:46 +0100
Message-ID: <20260129192009.14707-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260129192009.14707-1-mohamed@unpredictable.fr>
References: <20260129192009.14707-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: y916QoC3qz94CYWxavWdkV2y4W6syvgH
X-Authority-Info-Out: v=2.4 cv=MIttWcZl c=1 sm=1 tr=0 ts=697bb2f4
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=JzSzn-WSbtI0XTK35wMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: y916QoC3qz94CYWxavWdkV2y4W6syvgH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzOCBTYWx0ZWRfX2vNdm+4sZNib
 eYdtqjaEO63bLAA+D/gpKz7Af6TX0rXXweC94nEFPp14wiQK9N3mZRUK3Zjfz1x9owLVV7J8GDQ
 OFhn7T3Pcljd/bItYe9wJHZSYWCdV6Uc4V/RqWtaDWYc2bwM5V5RoYD0Eq8WbJAxwObLIxMizdh
 CUTv8m2JeF4qtPrqeIIB/lLbqGqnO20SFUtwcZeZn4Uh5EWv0Sm3prZXp0uj07bZiR2qM76SKhX
 viaT94+DguIWu1zfsSb70U7t6e/c6hTcCoHICqgr4UFLz1go0bfwWJM25z5+Qa+hlcVz2yREOw2
 s2M6UJgnDmOU/AFWcAqhm2obxN5nIJ0Ujl4cCdwzYY+Q5EA+AREYYNvtT8dd4s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290138
X-JNJ: AAAAAAABa3FxPPZModNjD/Xvi0W8EcR6wNgG6cek5cIV3q8Oyl4S/P2CALT2UcRJvWCuN/7nR7px6g3ngVVO/bbBO/DmhcqkWJ4A9T+QjCa8OakTr8tU7TXJ42QOq+7XKRJ/n2R5Brad8pT2aBK7CYUYX9hGx90boFP4yM0YUpH84BOLRFqNnpX6jme99VECKT0sKObbCT4s2KVYSeWs3YrNTm7I3eU93pUBE8huG+Eagy3ogaCxCltEWfVO20BC9ds3sLMGUdIRXDer1TaXdzLIAAprH1Foi0kV/IBJ0hFy6flAkiGs09Z/EjvvAz0TNaX9Z6MNUOf4xr03wj/6OoYwCxBrsfosc6yVPodA4D3z2ft69o6+IyTw1tnNkd4iWgLROFMUn5uVf7pdgPjHImb0QnY+76YFt0LDpHF4cR2D4a1TRLOQ7QcavzFUZCa6WcAkeqtKEhoV17Bi4G7rKaXI+TGj0i44lwXnHfw85a1hL85RkA0nqvBOQ1jFeC6iYSpW53j8M3+nUylzXYaki6im5sB/J76ua5lhvyXCStSjEqQ91IT8mMm4R6NEmV2KZDAscUNRQY4AWYhY4eigmPz69NO9t52pBtemrnuLPUGjZI3nmZXoKTvR4WRziLwuExDXlDrjF2xp89OwzRiCDRBySh6MlQL+UwN68zdJjC+pSvW4ndXZATWFQ/2XdvlAuotcecWWHlOGHKx3WZNIi3MdetO0N5d7BKZJTW42VHTIboq8Q0Hh32Pf2JoQGrMQ5ui74Gz0YGfYcfieLhGftZK407sRxqUzZMpAknz2Z3laEJ1xCsQ1CKrUbXZOlMwbgolKpXg5sJLGsq4tA1tSNqgV57GnG4VWwL/9t9Uso/2hXA==
Received-SPF: pass client-ip=57.103.89.193;
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

From: Sebastian Ott <sebott@redhat.com>

Add constants for PSCI version 1_2 and 1_3.

Signed-off-by: Sebastian Ott <sebott@redhat.com>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/kvm-consts.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index 54ae5da7ce..9fba3e886d 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -97,6 +97,8 @@ MISMATCH_CHECK(QEMU_PSCI_1_0_FN_PSCI_FEATURES, PSCI_1_0_FN_PSCI_FEATURES);
 #define QEMU_PSCI_VERSION_0_2                     0x00002
 #define QEMU_PSCI_VERSION_1_0                     0x10000
 #define QEMU_PSCI_VERSION_1_1                     0x10001
+#define QEMU_PSCI_VERSION_1_2                     0x10002
+#define QEMU_PSCI_VERSION_1_3                     0x10003
 
 MISMATCH_CHECK(QEMU_PSCI_0_2_RET_TOS_MIGRATION_NOT_REQUIRED, PSCI_0_2_TOS_MP);
 /* We don't bother to check every possible version value */
-- 
2.50.1 (Apple Git-155)


