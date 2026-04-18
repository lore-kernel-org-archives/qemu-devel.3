Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B810FF99C98
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEFE-0007HV-6B; Sat, 18 Apr 2026 18:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEF7-0006Xi-2A
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:25 -0400
Received: from p-east2-cluster1-host9-snip4-9.eps.apple.com ([57.103.76.112]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEF5-0005Bm-GQ
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:24 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 EB30418000AA; Sat, 18 Apr 2026 22:34:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551662; x=1779143662;
 bh=nflalHNpsd+cwF/uF35esRRPVFTNfgzM4VSaQ5bZG+E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=aFpJkBZuwzC6z3madhJ/bixatLHz207Fx+ckUwdqsP4T7UggdsCjs7OQan0KJjb9CBJQDqF23uqGUqGuZ7KSslIboEfRAnaWTinyKS/+iJV6S+Siy+pgyIwt0kLT5iwH/I6VIZ6+ZjBesVO8opE1NfPoojReKf3FpsBwaB0sOJRwbiGPMm1V4KJM3Va6XARmpR6mTHAc7g+faS/sCIHq8gk2KxHFs0tpN95oxHBSxa+yUSXUNHulU2k1xDMy/RjEp8gWEu/+RIrmyjzixntlIs/xn99EESQvQljt/Vq8Uk5aqHHlfFXyCKmcEQQ4x4eldg7ckKlrGEJaGKc0kriMPQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 4F61818000DE; Sat, 18 Apr 2026 22:34:16 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 29/38] target/i386: make xsave_buf present unconditionally
Date: Sun, 19 Apr 2026 00:33:11 +0200
Message-ID: <20260418223320.51330-30-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yLiIeA2uDg1T-Aq9fbq_G9yDw4pnTHJP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOCBTYWx0ZWRfXygUo6bQHEO37
 EgQK7OhUUdGrPBpP9iAnLhPp5jOUMl4Mn7NzBROz40+K89Ynk/vZ+t4AvCcZmdmw+xOuwvP2BKs
 UsLAuyoof4utrCaHtS0o/LgLv+lNxIvzBhv046KCzKDeHH5iNjFX6C7zG7eNgqWuqDw1TNdGZ3k
 BS5HqWN5U+LXaUb2b+jRGJ9Pn8FWi/ULy+hX0HbYeTMH5GEXEc01GlzWZ+s9W6uQQt/W6mqx52M
 cwWI0Nq/JxGFldvcL/JYoVFFXQ+IFaFE0hxhiWY7JLrFxtAMhkw4R80P2XUE0gr9+9nSJdm6C0D
 sGqPR8GToUacc02ff4QbVUpSeO4etKZrCsBL/cCcGz+N7og4Px8QWXGNtEMMwQ=
X-Authority-Info-Out: v=2.4 cv=QPllhwLL c=1 sm=1 tr=0 ts=69e406ec
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EWkIHKX3_8ZzwOJz1Y8A:9
X-Proofpoint-GUID: yLiIeA2uDg1T-Aq9fbq_G9yDw4pnTHJP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 clxscore=1030 mlxlogscore=872 mlxscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604180228
Received-SPF: pass client-ip=57.103.76.112;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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

This is necessary for the xsave_helper helpers to compile.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 67f508dc10..0af7bdf85a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2269,10 +2269,8 @@ typedef struct CPUArchState {
     int64_t user_tsc_khz; /* for sanity check only */
     uint64_t apic_bus_freq;
     uint64_t tsc;
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
     void *xsave_buf;
     uint32_t xsave_buf_len;
-#endif
 #if defined(CONFIG_KVM)
     struct kvm_nested_state *nested_state;
     MemoryRegion *xen_vcpu_info_mr;
-- 
2.50.1 (Apple Git-155)


