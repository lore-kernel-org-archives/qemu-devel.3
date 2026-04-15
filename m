Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3042F419B6
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD0JI-0007Ee-Lg; Wed, 15 Apr 2026 09:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wD0JG-0007DK-MV
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:29:38 -0400
Received: from pv-2002l-snip4-11.eps.apple.com ([57.103.64.171]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wD0JF-00046z-Bf
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:29:38 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id
 36C0D18000AA; Wed, 15 Apr 2026 13:29:35 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgDTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRNEwVSB11NVg1HD1geXBQXCEVDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTAtIAVsHXwNFCEsBVAVdHEUBQARVGl8fHVYQUgBSD3IFVwhBCFMCUQRYGl8IGQ1AThkMSh1SVlEFSgxcAGgPXR1YEV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776259776; x=1778851776;
 bh=TrgeVsVYtEOZKp22T3irnEElZdL3/X6V7jZ6IikmDcQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=RPuVgymDhYH/6YFTpUaRjtZxq3Da2qCFY0EuZIYPfbJn1IIDKouYYi4sOlwFIl0Q8nKUca0YYH//vuvr1h1VF8OGGMv/IxKaOX/FMwjpbuv1JyY1JTnyhFolQ3Q2jkKVoGXhymwAcDHNnRIevoj0Ql8vwg6ppX0r53K/vhZfjfKZCvk98pBMPhMVDs6kgrHClUIUfQjwfMW0Ricd8plcenBcrin7uT960drJHQrgopVRxoyIjvYH3GrCoQCa86kDYUCj1HgO3XMiAvi6yJ2US6yx4KVW02iagk6X1nsOFxdy+mO39KTPUBDbsHGdf7uZYDp7k/z2ryHAOdoRY/KGNQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id
 DA61C1800373; Wed, 15 Apr 2026 13:29:33 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v2 03/10] whpx: i386: enable GuestIdleReg enlightenment
Date: Wed, 15 Apr 2026 15:29:19 +0200
Message-ID: <20260415132926.58878-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260415132926.58878-1-mohamed@unpredictable.fr>
References: <20260415132926.58878-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: otC0XAmYAuCT4wa2HJzb1i6QCiCBmm3S
X-Proofpoint-ORIG-GUID: otC0XAmYAuCT4wa2HJzb1i6QCiCBmm3S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEyNSBTYWx0ZWRfX3gCCJPaO/W9v
 SEUodMbxf+6sYjprL29RVjfzGXXQS3zTFxvG58We67AvUrVx6TbGDPFJOMUc0yAvwKILs3+Inmi
 OlcytAMe3iaCE5Ce29brznV5skV8DqvBH7pfiy/puPwM7CcMVjMKWbSp/GynAKeHm9EwUwT3wfI
 hWF2BbPVZUUo2YguiCJ4Hn/Pmu8RyXGorXA28p9bwPzKkYBzNAi46WGTg/IAWEcBRYomn+RAdwK
 tnjYS0vd0/8AUejug3fcD+FaHVBM/MpoqZ7jRkoBf1UtTuUI5kepNrY3HI5RvM5eh8KYMWDjDM2
 X5udH5LLb5lVhvh9rDO9JHjepxCpJYv6XO+cQXviFDde07CxU5V1G3kc7/WVak=
X-Authority-Info-Out: v=2.4 cv=ZIDaWH7b c=1 sm=1 tr=0 ts=69df92bf
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=givlr1pFTcEyfNb0yRoA:9
Received-SPF: pass client-ip=57.103.64.171;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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

This corresponds to HV_X64_MSR_GUEST_IDLE (0x400000f0).

This enlightenment is only available by the HV when using the Hyper-V LAPIC.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index b248afb5e7..73066581d4 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2686,6 +2686,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         synthetic_features.Bank0.AccessIntrCtrlRegs = 1;
         synthetic_features.Bank0.SyntheticClusterIpi = 1;
         synthetic_features.Bank0.DirectSyntheticTimers = 1;
+        synthetic_features.Bank0.AccessGuestIdleReg = 1;
         /*
          * These technically work without the Hyper-V LAPIC
          * but behave oddly for multi-core VMs.
-- 
2.50.1 (Apple Git-155)


