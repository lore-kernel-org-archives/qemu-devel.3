Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49202F55104
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 18:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vywFO-0005M5-B7; Sat, 07 Mar 2026 13:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vywFI-0005Kc-Ls
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:19:25 -0500
Received: from qs-2004l-snip4-11.eps.apple.com ([57.103.84.123]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vywF9-0005Q0-BV
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:19:24 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 30CA318000B9; Sat,  7 Mar 2026 18:19:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772907553; x=1775499553;
 bh=JIMeijHBnhhl3REqIaANk8KG3S1sFo85lBGOJeo99Cc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=PTZsa+YR99QgUnY94RE5UeepQ10ERuq7vRPZmhzks+vWjdjS/8SydchtE9iMSav/Vmz/WHkG+uUV14hMZeN7hf+0RJ8mGzlXplhH2pbCY+j7zglG3QJk5LLG3WnDvYTwExiSh2OFCoilfCwii8FfRy9mgjcvSFBsTmnGM4fSH0Ny1nlCr6CxbC5bDfdZF93B12o6zcyrf1pqigNKcmMScl0sxVSODq6sNLwc0ffieh97bca/X+5lKJ9SFc6PVkYwJQMZTpwSiOTfwCBcHEvRndkPuxO7n5HPcjFvigw9+ftYRyqRXxw1NjDyhGSSOxt6NnZJdRN9kCwRJQcorGLgLg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 9066E1800105; Sat,  7 Mar 2026 18:19:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v6 5/9] target/i386: emulate: LA57 fix
Date: Sat,  7 Mar 2026 19:18:52 +0100
Message-ID: <20260307181856.2209-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307181856.2209-1-mohamed@unpredictable.fr>
References: <20260307181856.2209-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qq_i1AsEouoQeBMC7Uw7puHo3UqXt-bK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE3NCBTYWx0ZWRfXw4MTH/zKeieD
 y/QAch9hyjt5SDCDrIjYsiqwmTu0IA+3jr+EoiRhEQq9PC0PLfnOdjeqD6LOZ9muODavqpCFKsK
 9L1a5X2SiFwq0RR93UiLw5frWmbFfbOMAdrfZGhAhzOKT1bZMSgfmkWRbLdfwU+aTweytuz9VTb
 BtQezPhSQYgRqfhfAdcqikSp+vnDLDD3tNsJLU68DcNGUt/nWWuI2TkL+fJaSpnH1RSNmNBtOsa
 Ra10At/W+58BngJgAvwJXfZQopW/9HkpSTQBO5Jud95zme66PrM/PetwN+mkmsVopznLfRBi1ZS
 S7zCnnlwohC3nOWr1Ye9U8N7M4B6+fvGuxBEgw1t2q0Kx2JKrnOSr0Wmse8Yjk=
X-Authority-Info-Out: v=2.4 cv=XfmEDY55 c=1 sm=1 tr=0 ts=69ac6c20
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=AJrqCOfVdMXzVqk_6-kA:9
X-Proofpoint-GUID: qq_i1AsEouoQeBMC7Uw7puHo3UqXt-bK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1030 spamscore=0
 mlxlogscore=929 phishscore=0 bulkscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070174
X-JNJ: AAAAAAAB3z3EuL9y6Jc1RvftOdY4gb3syRzTTIBrQ+zq9tGFKDB4vzolabnHAR4KU/+W0ZjdsPbhiNfQzRsgOtaR7eBGpE1YJar5ZVNuBOyLYbfUXd7zAOyYQCZr504ojuztTL+Ddq11dQbyC+UNZlNHshCUnDPGGAQ+sStq6OC/10j0mlEUJSfqiBkydVOIR4NDs39YfxdrJuHZWrg+XQtdOH+BgMhpyNNjdtS9gzGdcW2YhvH+rI/BTOD4ev86v2gtPnhi+B1nBaLUtmohV8v2dw2K5xG24uNiZI1hNuaOh//8W34gsdwCibzMn6GQfsvSIosHMrFjhDOKyzjaWhAm7XQjyh3p2sqUs7pvyd3rJ5ce9mqjuJcZmtS0JR/U0xgdt8+Rpua/hmEGxK5GJ8AjHQHmrX/GPVdnVFTXXJ60HTXFoq4gpAs6rx0j8pnHrm4oMjUJkVX9R72ys7g2SkvXmoRFsOzOBWWu1QSlB3R35eaGDtX3omRN4pEf9ZATkWW8BCuFyLYCx4BaN5pjtjkbCRLbV6r5HL89Wc/ppTZVJXuhtjC8Bc/RWhcHs7NSWicW629wG9fSQYrxhnQ3QHyq2VujeF0HmCOEmTuFUnKs21oU/nzCjoIxjw5SrM7QoBpF0qqmq/fFHvbfwdJAWv4BkLpOnITO7LB8evC6cu/aRWB1WHqPCKvbcV9v9U930PGEobbBxvSvumM9uqQ8nxwrOCVThW9rifEiZWEsBlHxu9yXacEXcr0G5pjXOhk0Vn+lEQtPX3sAJRXi6q2L4iA=
Received-SPF: pass client-ip=57.103.84.123;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Seen on a Sapphire Rapids box with LA57.

The top level of the pte array is taken for CR3, so there was
one entry too little for 5-level paging.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index 8261ca1635..4e39bae025 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -56,7 +56,7 @@ static bool is_user(CPUState *cpu)
 struct gpt_translation {
     target_ulong  gva;
     uint64_t gpa;
-    uint64_t pte[5];
+    uint64_t pte[6];
 };
 
 static int gpt_top_level(CPUState *cpu, bool pae)
-- 
2.50.1 (Apple Git-155)


