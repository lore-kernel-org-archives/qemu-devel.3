Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89840EC1EB3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 13:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnz9f-0007ZA-Kb; Thu, 05 Feb 2026 08:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnz9b-0007YH-SS
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:12:15 -0500
Received: from p-west2-cluster1-host11-snip4-9.eps.apple.com ([57.103.68.32]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnz9X-0001Va-IK
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:12:14 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPS id
 862D6180026A; Thu,  5 Feb 2026 13:12:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770297128; x=1772889128;
 bh=JM+IS+u2FhSUs+ag940jtQKtrbvFK486Oy66aTDOb2E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=VUx/0zrKqS6XTVFXguO5rasEJhmTUE6gUKz89wopENqeJ0ij9Tf+YCJ/YIc9zqmy6vzaV/BDmRAiy+fsV3GXm5DZLewiweUqNqQPYXDViaSCCJ6W5lz1VFTk+tp0vv/l7pND9oTPoPSd+QMg9aCXtjg+wE/BOLWMqqFBGRbtPYi4TmxWNeQzMdO9qraglHX+mU4CDdBqlTkOwDx+0nFoiLyg9Ctwl34buuOe1i0gPl18g6LMcegWct2T7rOdyhC+QdqflA9wuU91lMEQ7w4eEM6HOyXmYXNLyep8c422VC4bxC+r4Mqnu4Wv1VGpWkbtUpsyICK0+OyrXiDUFkbjqw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPSA id
 F2CB31800267; Thu,  5 Feb 2026 13:12:02 +0000 (UTC)
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
 Pedro Barbuda <pbarbuda@microsoft.com>, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v20 01/22] target/arm/kvm: add constants for new PSCI versions
Date: Thu,  5 Feb 2026 14:11:30 +0100
Message-ID: <20260205131155.22780-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205131155.22780-1-mohamed@unpredictable.fr>
References: <20260205131155.22780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=YsoChoYX c=1 sm=1 tr=0 ts=69849728
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=JzSzn-WSbtI0XTK35wMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ebwkyeV1alhrtmitMBMgL_B5dSKHIXcG
X-Proofpoint-GUID: ebwkyeV1alhrtmitMBMgL_B5dSKHIXcG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfX/vkGkmXUt22z
 sgVLuK2+6UqzPEGO9Ek92pdWwNBA0xwruCh/ECYL3sebQj3o8mPvAPN3OadHpKsFtg34ZhfJEFm
 yarnvQpqvDg/Zy0YXp0OCkoLJeoSSMoRzllJrm/CYXRQdYdJjwXm9gldonNbpXh4DKw0PCd1gBC
 T+BkGeF4ZOyR3fWQi+FHfhf8ZDsHoPly3LviXQkW2rMFqYVdxBEp8w+Hx4HHdTA/kxw1uyR/Z1Y
 REPYv6eFMYywXNTMJ/EEhON76vRXxvnNOJtUJzbx9mXKZax+TN7/mcoL8afhslzv7+0eVebXay+
 eN45P8QIePsrlXewh4WwMTEB53q/0VxQNMy+a9feDRKPGyeBgtIOxmPJCGjC9E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050098
X-JNJ: AAAAAAAB8cAiFv9TtDSz2ow8fMFoJtrkMoce5nNjGYRgmT4RDNROL0CRYjFylSyAxBio4q6i7JtpzJbauZUjUQntXPcwbLzaQtCjw1aackrLbWhykrGarw31FioRSSYHLcYfByA//5pBiGfIpb8dKc8Ip/cT8KDwRj9SIOhisPfZoEZtgIVPXwLEHMxkfoH1ND4mHJXegsmGexoRWqmnfNy0pwaKR6A3LQx6RsfwWZnCgrQcQRZ/UnJJK62KPPfkiyvDE+9j5PTUmBKcB60QcmvPmPU93kBoF2XjMPIKMg5x2VV7XFVmIlbMKFGy2C7WBpYoaH3Lb/NfRTx7rOV9Y2UomfQXHvvHxD5kGzLqKzpM2CA5SIGm86z50+2BtjgXPw5sbQz22nJ6VOhVLCpiBqmpsYg6hNofEPlrT97avMUjOjnXDeG8sft3mwIsT/6eLO74Ceabrr6YMVx9joFRiTmdHOOM/2UBQS763R79tBWAStm4CSmdUKnwtxiw5KH+aGJWdX4qqHqlx4EU+E3LZ7hjRvGLOHobqRvpg4kUhNnJS4j20wzZjUljuiRJNbV4At8GCaE/c6Brl8zga9c8hiYSzkoeEmW31hogHvBiAodR8fzY4YijVG/qAP+TTuH+zT85J3sS+IvcCyRow/luUQZVLWBFoBS2whp1hvrTagn/lB7dyPoFcXFaoq8VWBJ83ExULCrQb/qcKMMLd4LoEervueTEx05fr5dtWuyL+CSAt+Lo2Ddkw/oBZpCF3TpelWeZOzDVjGoq4XmnFncV2cEV6MtdeLpVU0rL0xBcBXPVoutJ7hcYYue5LFVueGp/wmV1udzXm5PTmXuYaO0esruhtrZ1ACPE75PcqJhSQRAcal1AM6t1qr2duO4y5Tw46EKZBaOHRGXUmUWogtaiwuLFzMrWegbjZ6QCYitwt5jfmchHr2iD+Wq4SjyoM3Zg5skOj0T3l/7U/IYArMg=
Received-SPF: pass client-ip=57.103.68.32;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


