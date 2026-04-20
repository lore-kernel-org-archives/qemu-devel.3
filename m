Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1D8F55808
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEm70-0008LJ-N0; Mon, 20 Apr 2026 06:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm70-0008Kj-3q
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:44:18 -0400
Received: from p-west3-cluster4-host11-snip4-7.eps.apple.com ([57.103.74.218]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6y-0000mg-Lb
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:44:17 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPS id
 930691800444; Mon, 20 Apr 2026 10:44:13 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776681855; x=1779273855;
 bh=T2c1vi1orOgNlAefb2YumNTYjXQUvJQ0cgUZeOpqxeQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=IE3ERr53wRt0r1c9hk9FgfduZQSH+mfkT2svuhC537X/BPtssWhuLxWzH7uuGiuDyJYgh+uJ23xYmNpEq1zrfcoaV5f+NRG8on46M5/7jgr3AwAA1DkI1ymqpawmcR9tSS/5mcRU9smsIqHJOe0VJgtJJrUz69Niw6bMPALM4dRwTiMM1XBJMvXzn04cyrCefoCeZQJdf0V/itqU1P+EZ+UfbFzUoQQlts4dr8OAtvCtNlNlf+uRBOMflTnuJ2AdpIch6qcgonhN8fFXD3BOSu0VFHAMR24PKClSb8kl/Rd/0Q3L5ZHUYByczRwJVNFlgpRL4c+JEIgtmrDAR1sbFQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPSA id
 0FB071800097; Mon, 20 Apr 2026 10:44:10 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 32/38] whpx: i386: set APIC ID only when APIC present
Date: Mon, 20 Apr 2026 12:42:42 +0200
Message-ID: <20260420104248.86702-33-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260420104248.86702-1-mohamed@unpredictable.fr>
References: <20260420104248.86702-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6wbyipIUSGzcTJlbeTorfLvI1b_v6fKL
X-Proofpoint-GUID: 6wbyipIUSGzcTJlbeTorfLvI1b_v6fKL
X-Authority-Info-Out: v=2.4 cv=d7D4CBjE c=1 sm=1 tr=0 ts=69e6037e
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=WHe3jrWR342bzmf78BwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwNCBTYWx0ZWRfXxZ4DzG1liJuo
 uzckocHi6TGpzztisN9mp4wN6GeikMF754/h5aQi0Jnob0gDgCs7f4Bmra85TrN/E99kVShCg05
 H5WCzy++53hQyL63s+sNaUu1jHjgn+cEkZmJUWK3QiqOLTDCIAZQuEeU65a8KBaLg87vlJW6yF/
 1+H2F8HJAB6R/3e0wFVG0DVhxzexyxdAVLK6hZk54vMfUESh2XovGS7uQ9FDddvbpJlqLA1dsqg
 CgDU38cy3rLVrXuTSEIxz9zGkvYkHNlFOfbljXz5LlxEmsgFvHHpHdEQmwPeEUkPelfa6aJZlHc
 B5/Mzf91mTLi6uo+hTCXCaoN6aJPTAGOGUjSfWsGg/14tjdbKyLcTRl1Ouz8AU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=870
 adultscore=0 clxscore=1030 suspectscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604200104
Received-SPF: pass client-ip=57.103.74.218;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

-M isapc doesn't have an APIC

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 9b2488b801..208ff0c35c 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2590,7 +2590,7 @@ int whpx_init_vcpu(CPUState *cpu)
         goto error;
     }
 
-    if (!whpx_irqchip_in_kernel()) {
+    if (!whpx_irqchip_in_kernel() && x86_cpu->apic_state != NULL) {
         WHV_REGISTER_VALUE apic_id = {.Reg64 = x86_cpu->apic_state->initial_apic_id};
         whpx_set_reg(cpu, WHvX64RegisterInitialApicId, apic_id);
     }
-- 
2.50.1 (Apple Git-155)


