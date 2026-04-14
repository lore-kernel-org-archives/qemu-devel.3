Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A390DF9D0F1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCiPS-00066A-53; Tue, 14 Apr 2026 14:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCiPN-00065b-JZ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:22:45 -0400
Received: from pv-2005k-snip4-11.eps.apple.com ([57.103.66.221]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCiPL-0006TW-Rr
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 14:22:45 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-9 (Postfix) with ESMTPS id
 3A6D51801395; Tue, 14 Apr 2026 18:22:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776190962; x=1778782962;
 bh=TrgeVsVYtEOZKp22T3irnEElZdL3/X6V7jZ6IikmDcQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=CJyJmSaPUlJp92/UjYqOW8jNjS2Pj29P1w574OezBYO5ogNymydCnKq/VpAia47Pf4KTyngKW6hMOGm7jb30rx87uXw0C89uHxYNsdsOQA/txWfWMbXPvuUjAQ00eTgWf1o3NzQATmACw91NqItA0nQsTAM1yL29JMW1lNZU2IfO2SGD++ieQtmh3XXjyQF7i6nECAjJMoDYzwErGeQsGewFwsOjzeSo/NyX+JyyD+pjbRgj+JmLhOFQl8/Y6S70vkF64K9faLN+YXeHOPhHn+2So9RaIEt2jdPjcAf+fR8VeidvKA3msQ2wQZuE83kcAolscPX/42YIDe6okAYK+Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-9 (Postfix) with ESMTPSA id
 A362818001C3; Tue, 14 Apr 2026 18:22:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/7] whpx: i386: enable GuestIdleReg enlightenment
Date: Tue, 14 Apr 2026 20:22:27 +0200
Message-ID: <20260414182231.18776-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260414182231.18776-1-mohamed@unpredictable.fr>
References: <20260414182231.18776-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=fuHRpV4f c=1 sm=1 tr=0 ts=69de85f1
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=givlr1pFTcEyfNb0yRoA:9
X-Proofpoint-ORIG-GUID: o545O07QWpGgSZKPb89EBGZ8Bqhbk7hy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE3MiBTYWx0ZWRfX4gSxP4+lDtIg
 HmkwPj58ySTUZrImS18YtjFFFPX1zwNrVOFQ+7AD7FMIsaqTDGxSVhQQgDouyQ98XAZXWRj0IAk
 M38BNvutrqKofPRFDbXAJIpHu6aeGb6J5IPpacowS3WzTT3tUfiXyavW4qEaj6E4GsL/D8Q8xTn
 FBGUGS4rlSqHD11zowd6m6bjZWSMP+QP+iPH1uZcfxQuot5eZF14Bdu+HYk51oLd4q0fjNYP025
 iJOAcj1qUGzR+jUoCiFHVywkDBupmovuFhrrREJeCJnCzoYxuDLr4lQ34XGaVBS57DbLged75Ho
 U33l04utWlxz7apeLEiH//zjX0dpVlc3sWwTBH0Aede2XlOBCsMZfl9KyPXmv0=
X-Proofpoint-GUID: o545O07QWpGgSZKPb89EBGZ8Bqhbk7hy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=957 malwarescore=0 bulkscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604140172
Received-SPF: pass client-ip=57.103.66.221;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


