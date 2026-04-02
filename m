Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34544D39406
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Ew0-0006t1-B6; Thu, 02 Apr 2026 06:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8Evs-0006pw-El
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:05:50 -0400
Received: from qs-2004i-snip4-5.eps.apple.com ([57.103.84.88]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8Evp-0003mq-VP
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:05:48 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-1 (Postfix) with ESMTPS id
 6CC80300012C; Thu, 02 Apr 2026 10:05:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775124343; x=1777716343;
 bh=/MUkLPgFZBpV3m64Kp5Hg3FT9nhtEW1quSiDaAGCvyk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=BrIDuYZzTgqIXTAzoIyvqUxC4ZvAbmnVpJGxUTqVz8Zf4c2vF7f82AT4KEzMvPyRcXRradcFmm+I9qlJ21lfrw4QE3YBPYJbX2DJbCVUEprllks6/8jSFrj9lLYywyo96/5aDfUG9TeCc3iJq0j6+s6qnK9LuPFH9MLAmz6R3hpXkLOOsyKUMzlr1PdWIp+SufPovjJ4skvnvz2Qd9A1sDcuJm/FiK77hOXL5ah2aNw5inKb7okmAwOw3noJcM4JIpXAh8WrDM7dKudnHkLuwJAWxd107bfu2ViJuKeMgi+FHNBgv9XQ0m+ieoaHEsQENHrt/87z2r+WUdevDRW30Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-1 (Postfix) with ESMTPSA id
 D5D0F30000E1; Thu, 02 Apr 2026 10:05:38 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH 1/2] whpx: i386: enable x2apic by default for user-mode LAPIC
Date: Thu,  2 Apr 2026 12:05:34 +0200
Message-ID: <20260402100535.42960-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402100535.42960-1-mohamed@unpredictable.fr>
References: <20260402100535.42960-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5MCBTYWx0ZWRfX4jD38TIzKCv2
 38pN0j/jcwG4SOujplmbVgbtnmdKwL3nVf5BWbUnIPMKLhKyEX1FoZqN5oVsJuDif+IFFRkHYE4
 Kj1i9EL/9hUk9jTaL+GWqNob0FXAJubQ+zDk8MxmIb8GhVXdK6kVNKTJJVhsQo5DA20Rw3kQ3x3
 +oqtkb9+FWmjr+fylCehiA86HGBdCAgCeopWY+ToOVZBDnn9YCOKu1BG+Hf4OCmIuwa44/2b1xk
 IXFewRT9ffUETI31/bcnYTsVVYGzGi36/1WvWkl02LasaefAwGt3f1bwQiPBz/IWJy4eYWXa/B5
 UCh9KPRBR9esnh6XrpxVHwJeVWIFhwBIwYguT+H6UV08k2mTDNvfT3jHE5cYQo=
X-Authority-Info-Out: v=2.4 cv=CrKys34D c=1 sm=1 tr=0 ts=69ce3f74
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=23N40mErLr3Vl_GD1psA:9
X-Proofpoint-GUID: wyWc4IxrgjXp5kLpQ_aRe9blGJLlSFMa
X-Proofpoint-ORIG-GUID: wyWc4IxrgjXp5kLpQ_aRe9blGJLlSFMa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 clxscore=1030 malwarescore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604020090
Received-SPF: pass client-ip=57.103.84.88;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index b29f8d43c9..5460207bdb 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2269,11 +2269,18 @@ error:
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


