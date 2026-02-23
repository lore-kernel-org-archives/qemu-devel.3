Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD96EEC2AB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXq-0007ee-7E; Mon, 23 Feb 2026 18:40:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXi-0007Hm-Um
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:47 -0500
Received: from qs-2003e-snip4-5.eps.apple.com ([57.103.86.48]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXh-0004T1-70
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:46 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 B9069180039A; Mon, 23 Feb 2026 23:40:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890044; x=1774482044;
 bh=JmJeyCNGmOwI1RRJYOEbtrFmR9IX358A6jq63HYV7u4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=BD8U9tXbVM26wFAtc5W60rPPgIGVkHZWgaRP9Ban3KzPo1tfD1ZsLcK96kt0ovq0NS6qPvV0/2V3uP7xegOgLAsWf8PHVf1t2whwHGNBgo+t3u4PoUoWjL5wVJXNyCNkOvjzyp+80RUFe86lEep0zvDyt80SDlu2EVe1aBa924Fg2RuGAlaC0k+djMACLrCo5ZcYOrdrJjl6RcejFeqBREL6FI296jm3MxvhThH1qtZgdBlpgdOw6J8YsIkX6J6WfsHRJ0oDf0vPPRWmT9IonorNSypE0CtVJAM6fohfXSxW456lJHTOhFrwqM5uTZiOUSCER1zuFbB/NmjrRrTS8A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 0F4731800102; Mon, 23 Feb 2026 23:40:37 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v6 23/28] target/i386: emulate: remove fetch_instruction
 helper too
Date: Tue, 24 Feb 2026 00:39:45 +0100
Message-ID: <20260223233950.96076-24-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=BPy+bVQG c=1 sm=1 tr=0 ts=699ce57a
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=Mh07pQtNwjrl1AJ-msEA:9
X-Proofpoint-ORIG-GUID: DS5X4olcdTkPGk5-vnUnIbsYyaxo8Xrv
X-Proofpoint-GUID: DS5X4olcdTkPGk5-vnUnIbsYyaxo8Xrv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfX3HTzihdi7BQv
 W0ghB+X9mC88yYdGSs3YtIJ3PXWyoSB569xBqIFF4cKMYuUWV4F1XrN2c1R4qUgkCBzasuXnmrj
 Td64cWyZ0pVTdlwtT9HBYrqPcKxMAe2gsVrM3QvZQx1P4qkpWWinKwAegEFMxGQrAg9UiNAjGfx
 HStrN++bMxWe6UnKRCbn0MRabbSVDZdGHK2xvZgQf8neLpduIW4v26mPiXrgI/8qC5JG3keiYZb
 kxcxrder6fWhbMuObYqK6MlgPauP9+cthEYmPL3PT74wZkdU5avnsDvDmuqgnkY4JiJIJKoBznG
 avTmUVT7SgYNG5SB+SnDPkBuXIDQGAy1yh6OE9+9thV7uL1wm/Qo42Jf38WF3s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=869 bulkscore=0 clxscore=1030 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABU4T0M2gYmVuQz96bjotoOPfWsrKyJrAq1WAsumPBQB8aQjQl6omGxoe6mWR2vb0U7dcJiwkAVkbtUFT8DZ+EusYKeB3SjbTYNiL+2czClfAnByST0nlZM6TdYQ2+pb2Shwc4diUKFaeXwoXX5tVry5DjTCeyrfodclK6Qy9lHw//7CdhT9R1unwz9VdsirsSWCx9O4BunI2xuQBSbila8NhU9VDR/j/xuXWoaCmxgg6Biz5wM3RS4ERIKD7xWorpQUlISbrcu1rORzMA6dgX/6j3cSL27p6TeXz7tlzr7TUFw3t4cVtrW24CxN0eTWyBD2hMERlhkJ0Pc+H0aFgAl+U+1x7lBXbwjN9wOIHFQCpxOZW2cSjpZbwHQsk4+BIEVSstqXGdfvDb2L6mjLzl9I/tm4wmbTb1H9dU2+Wz9SAkonh0glpmITlLByjwzT521peYE8Lp9kjScl+GQQNgwuMpKuyj9KOFHDI6zXUh6T/magq26JZnFeuJRgy/nEhqpaYKaytqvPORXiTduRqESFdA/2vFEHh+lavgsnHOexXDQYf2GX846IdiVIS+dLWeDdRwBQyea27LCHvp6ajhUGvBV5enxRnoNCYs+wUzErekZFxlfwPXPyBlMHhf0g0NCUNB49d8IUlHPOUgWNmJgKKtnoACB1HQFSJBDAKK1ZXm0dk8qIunlqChoZsMEBNXRcGimbZoGHwuQ6ZMe4nDCleGsTkq72wpB38mvjVRdD4iXXZVcAPL6eqw3XFdGqycZrM2GjLOH1G0ohwWBOUmo2jf
Received-SPF: pass client-ip=57.103.86.48;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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

Not used anymore.
---
 target/i386/emulate/x86_decode.c | 6 +-----
 target/i386/emulate/x86_emu.h    | 2 --
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index 9faa65a579..bae1dd4d6f 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -77,11 +77,7 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
         memcpy(&val, decode->stream->bytes + decode->len, size);
     } else {
         target_ulong va = linear_rip(env_cpu(env), env->eip) + decode->len;
-        if (emul_ops->fetch_instruction) {
-            emul_ops->fetch_instruction(env_cpu(env), &val, va, size);
-        } else {
-            x86_read_mem(env_cpu(env), &val, va, size);
-        }
+        x86_read_mem(env_cpu(env), &val, va, size);
     }
     decode->len += size;
 
diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
index 3e485b8ca3..6b69111822 100644
--- a/target/i386/emulate/x86_emu.h
+++ b/target/i386/emulate/x86_emu.h
@@ -25,8 +25,6 @@
 #include "cpu.h"
 
 struct x86_emul_ops {
-    void (*fetch_instruction)(CPUState *cpu, void *data, target_ulong addr,
-                              int bytes);
     MMUTranslateResult (*mmu_gva_to_gpa) (CPUState *cpu, target_ulong gva, uint64_t *gpa, MMUTranslateFlags flags);
     void (*read_segment_descriptor)(CPUState *cpu, struct x86_segment_descriptor *desc,
                                     enum X86Seg seg);
-- 
2.50.1 (Apple Git-155)


