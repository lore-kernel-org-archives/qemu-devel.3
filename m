Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A3AE83F1F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0J3-0000mK-Al; Thu, 05 Feb 2026 09:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0Ix-0000lb-72
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:25:59 -0500
Received: from qs-2002b-snip4-11.eps.apple.com ([57.103.87.151]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0Iv-0007oP-Tq
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:25:58 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPS id
 31FFA180011A; Thu,  5 Feb 2026 14:25:51 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770301557; x=1772893557;
 bh=JM+IS+u2FhSUs+ag940jtQKtrbvFK486Oy66aTDOb2E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=ELkxtTfQ4ryDg7Yi2NfrHIMiJyoO9EykMSovqfvG/O6VzopXlZvpin+DTqbRmugjv2E1w6IBDPcSQBg9OkWMXMciztmAGTd8u5aBdGwst1iu8cBxZJs9pWW5vk1//Tqan2HAE3WRye95R9HI59RMn1dwM2jJjk68KA+pOHILrpLIkzB1GfJwE9T0MYQ8ngvl/L36TJUfinXX0Aq1WH+zqfE16Gn6OWXcSF9T0LLb135VR4pVrvC5bzI2WHp/bYpvAL0TzM8+qVroaO0XFAGLfUk0ia+jKXeRxygaZZ7F7kd/CKUaSyqVN8mvAidBwTzCBpFCxZlBnzdmh1wyOzD0uA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPSA id
 451111800267; Thu,  5 Feb 2026 14:25:48 +0000 (UTC)
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
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v21 01/22] target/arm/kvm: add constants for new PSCI versions
Date: Thu,  5 Feb 2026 15:25:19 +0100
Message-ID: <20260205142543.64818-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205142543.64818-1-mohamed@unpredictable.fr>
References: <20260205142543.64818-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=QLNlhwLL c=1 sm=1 tr=0 ts=6984a873
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=JzSzn-WSbtI0XTK35wMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEwOCBTYWx0ZWRfX7zl9qQDQ4CMd
 LNl9Vt4w5LN3xKDL7XZMTiCdJY2MrGrVsTpeWzRdmPaRYrSvZg9I3frrk7EBKMbhUofTNLIWvtI
 51m4ObsVYRdKJroF6X421mfaHvtEAFIJOheG11OAaexeBNRAC2ECZDXCEdpKuo3RaP0/3G/tgXg
 GnNdjGqxFZZUv2W7cwZg0rtVLzX05DVOAXIBFRaC4MdrkSdAiUEoWM3o2D0PTAWzuTEfsId2W+s
 inP5uSgCOqKQqXrKCoEBnsO7izltDgnwHaluLT4bvVtOjVSOQDJTYx3c5tht0AtPq+AwTmY6fsF
 vCF2Qs7sqoffmI9KiIBNfwtCdIiI97xkKg+GScPans3SLFv6k0rKEWL6WjoQwU=
X-Proofpoint-GUID: HPAg23eP3_mg6IVN9xyeFY3cgn8bcSX4
X-Proofpoint-ORIG-GUID: HPAg23eP3_mg6IVN9xyeFY3cgn8bcSX4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 clxscore=1030
 malwarescore=0 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050108
X-JNJ: AAAAAAABQofOqeULv+IHxZErJD88H0KIE8ihkrEnpuNATfVWcJ+ERV6LSq74zLFWSI6wxB4IdV6OAtcuYTt229oj88nZZFmtRP3e/wIZksAFVNxU0cxhbzJ+yjzpXsc7h0hKNQUdHEOO0AgTpjzuwz1UDaYlFDd5s7xXWeaV4NcL231WhlAPjgvu4u0ertfNQS4CdK5L127zqivY+/RAh7o0MoIUhX5DGVQq0vVh32OPWHUjfwN571sEEqTBJxE6GCSkxmLl4zbk30RQRohgL/6+J6W0EeZiV4JxQIei4hO37WzH/MydcTYwuHLJpP8VnMmO3968+L3NuEj9jvwRC5Sny6Xs6AVSI8Uwdo9LXzM0YQHsBwRMMpy9TkFx7a/LKcPAJd08v3IYbBEu9eWsj5JA2UnHdpUU6w6okGhbXR3+T37keQCxh4aBSkPJbKDqk1gkDbuWOHzyP1LGYTdXn7cON+IolWb0A2MdTHH1/McOhkKONM2g1+/Qlqs/udrgN31xTwKNxmgBM1E9vKG13GqaQNzMlXZOl5jcWIb+0cLcW6sXHJ51KYbzh+2+RNInAonBXutvDtPTLLWeFqcK3TSZzPVZd2IHRLaqLCf8Z5iXIfwtXAivg4D7sxrR7XMGrr+GmKAO6mGtWLuzT1tEMqRZJ08PbFJBdPPlPrv4n20EnYn+IMPZaWcR+7PuzaghiekMtRiXlkGNxInLNUHQFVfkNfojBdf20jv3OxMFoksEBZdMJO3DjlnC7ouRwo6k7eBgGDgSQdpVKBVBxRU4pDk68K/EgJt6JZ8De2evJhjbyU3BcN6SF+9XctZ7lOfs4cB32qRjKUExjRdYXBSEwyMx8EPyscUHAlIm5KAidavmy6Y57HTI/MJXrZKCvW0ihvsM/jtIy/tpIukg55E1rYIBK6BU/pCGryUfNipE2kJovonpEsF5RSKg87Yb7KinKkFlKqlSkmxGwiEReUc=
Received-SPF: pass client-ip=57.103.87.151;
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


