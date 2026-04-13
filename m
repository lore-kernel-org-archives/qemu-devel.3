Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C5FF531CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 20:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCOGh-0007Nu-Fw; Mon, 13 Apr 2026 16:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCOGf-0007NA-52
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 16:52:25 -0400
Received: from ci-2007i-snip4-7.eps.apple.com ([57.103.88.90]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCOGd-0007ua-5Y
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 16:52:24 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id
 7EA061800206; Mon, 13 Apr 2026 20:52:20 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776113542; x=1778705542;
 bh=dugTy6Mycl0V8PO55M7zjkrIKW6irE2gkRf+Eg5CDxE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Y2MT6ejife1jhSJrpzwK9WzEvOzCzVvmCG/KZj+MB1IKT5xzEzb2dELH9LXqOXkBb+arxGyG9nIgHMC8zsy13jGaMe3PpFDflPTW6TEvb5eC3zyBBv/MNIq9AnxqzINl4rJJTR2btbYTF/B186m44bZ0eAKKm7PuIG29hMqNtRTI+1fFdcfY8Hq8SgGwjVPKNGGYbxID+/CyocPIei+VrHr6kd8R4/wRsMiBRlMuo0XIdy9yrr+BveUy0H9STCSizGRUPGwytlJ9ZvQgvIYkK28cF/PX9bwiEvohKeQlDyC7MfJgTkR2bHPgl0u7xpWidL1SMKEnmylCBxx49DgCZg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id
 8E7D0180015F; Mon, 13 Apr 2026 20:52:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v12 05/15] whpx: i386: enable x2apic by default for user-mode
 LAPIC
Date: Mon, 13 Apr 2026 22:51:57 +0200
Message-ID: <20260413205208.50643-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260413205208.50643-1-mohamed@unpredictable.fr>
References: <20260413205208.50643-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dAP6Isrp7E3nh5ntkGQSpLu9qTJ3Ty6X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDIwNSBTYWx0ZWRfXyWHGE5ckei5l
 b+mrXv4pdyU96VL5Hpe4s1RhgKXVGjJTo7PnTKqg/hBRPli4LV8U2MMsbQgwu/OmwXfnBYl8mC6
 vori+fErZvWE6Fkz1PzaP1te0Gq42W+ZRFKictmnhw3cMjVa/YcmB3RvOd4MjXC+hm/u51KWxy0
 OgC1gTli6sV785jB4AW+ld55Y9hPrwEFLu0dthB2LG3x7KWMzXNvby0ThbDEqWGw5qh4avF4IaT
 VjoKq2IYq2eeIbXTPL0Opa4JO86A+z5bxIrEQEPlwQb7L6ZdzH/W2QHXFNXoeFlQcSOgLkaLq7z
 qz0scTFTQrN/Uz1JY/RLBtRanfFujHNpB5IVZPsKy2CYsCRuk+zzYq3M6XlYLk=
X-Proofpoint-GUID: dAP6Isrp7E3nh5ntkGQSpLu9qTJ3Ty6X
X-Authority-Info-Out: v=2.4 cv=DohbOW/+ c=1 sm=1 tr=0 ts=69dd5785
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uAk9FrDoCeqUxh5yT_MA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 clxscore=1030 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604130205
Received-SPF: pass client-ip=57.103.88.90;
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
 target/i386/whpx/whpx-all.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 0908dfd134..66f263558f 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2281,11 +2281,18 @@ error:
     return ret;
 }
 
+static PropValue whpx_default_props[] = {
+    { "x2apic", "on" },
+    { NULL, NULL },
+};
+
+
 void whpx_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
 
     host_cpu_instance_init(cpu);
+    x86_cpu_apply_props(cpu, whpx_default_props);
 }
 
 /*
-- 
2.50.1 (Apple Git-155)


