Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B42CEF5879
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 11:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vraGh-0005QW-50; Sun, 15 Feb 2026 06:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGd-0005Nt-AZ
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:23 -0500
Received: from p-west2-cluster3-host6-snip4-5.eps.apple.com ([57.103.69.98]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGb-00082D-O5
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:23 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id
 4131118004D8; Sun, 15 Feb 2026 11:26:20 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771154780; x=1773746780;
 bh=PaO3gLaERUfhv9HHc/GfHuuWbKk4K4/t5EAf8ycHg6c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=NxzdrM18srkpyHZ8ec65XwhEN8EMG3iRARi/Rb7rnMm2+pEcp2L1dqicfv1XPb3pv0libnyF0xKtF+w37a21yu9Lj6ac4jk51aLOzrJJSSa9GrsNYeqHiRe1YxMv/HTkK729SaGlrjW32BnLY1GShz1RGE7MnQ1wRMT9J9mWdRet1OBuslCX+FHCW6T1+xw2UhFphLXXKMH9LkiSFDoXIEn9Y7+fKWVeGeTP6a3y24R2mA9xlVIPAgyOmeW81fXQZqToYTPIPDv3RsFFaREvQScJsOlSIbC4D5libGfGEO0BQT4xvsf3W5mg8SvUWZi3B/pmxhPk7XoSqqlMjMUUAg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id
 4DAD718004DA; Sun, 15 Feb 2026 11:26:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v10 14/14] hvf: arm: warn instead of assert on a
 write_list_to_cpustate mismatch
Date: Sun, 15 Feb 2026 12:25:43 +0100
Message-ID: <20260215112543.4817-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215112543.4817-1-mohamed@unpredictable.fr>
References: <20260215112543.4817-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: oRGP5NC6UGTaOo_6c7iILmHZfWAs_ycC
X-Proofpoint-GUID: oRGP5NC6UGTaOo_6c7iILmHZfWAs_ycC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDA5MiBTYWx0ZWRfX9MYqtbChQZ9Y
 Xbx911Zjq/Cb8gUDtwJ1wmt3EJJGOHH1WB/YM9oTqvIlfpx5ecWqKZOCGU4mZAwS1Hz85NsNO3+
 uLXA2HoVJFoFybL5uAVp73w8f88cINkWyH9PIzfG8UhOjrzoo6oC/osIpaZ/gAudSCcIM92Inj/
 OlJ0pHxecRuGDZPftAGEjDJP/HeCaqjYDFvJn45msG+7lX7m8UK7ZFZ5FXXMGNZliMZ7DWR2N38
 zl9OIah0RndhjrrwsUTk/pYXWT6ZTpmzMq8dRUyXKvwpuikMUcLMuYA3gyxZiJyp911mu+C8H29
 sJV0Iok5wy7DMZ+y3M8FucS/n+Fg8ijGcvEwNfUthsx1ODSGmeRYQ09Y0QVyq8=
X-Authority-Info-Out: v=2.4 cv=Vcf6/Vp9 c=1 sm=1 tr=0 ts=6991ad5c
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=U3Ud8cxJ3jSva-eiQ1oA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_04,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=475
 bulkscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 clxscore=1030 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150092
X-JNJ: AAAAAAABNyMGlWQW0ZLsRJYKbH19kQ8TP8VYzj6CJZG2S+xFY3r7QZBqxkLVAhm52c7KKbVHONCwYks0VJBOFS7VY5bBuZUoVFNAk+GPeXY44CYMdE+oJLhgPRkO5KwL5Ww9RW4YRf5P+KA1BkSpJA6FBTH2T+H+uKZXtBxuRv7StdC9ads9pokU0gbf3cN8RmzYcZ7ArwHeW9qZAvI0XWsw17vz3P9wFwu1R/eHDtawX8Q4HrGH3Res7HmAKFjra5P9nZ8xKcb2ScxFj25FchGOL26Mgakeoqx5aQnxW/eFIqfyfb+qdCqjHZj3ylp7QrIVgpCCz7h5BqGYduib1xH6nn8PYB1bZuXbo4SNn/ijrcgvbh1blSYLVglugZ4KPfxtQVjxfv5btHFqdav06Z+AROo5TQJcLf+6Zh5nbyYqeMLaDDyDhKe0S8N9+kMdDgM0cAYfN/+mhEGzhh/zQBS9zsRJ5FJM5FGnhc432k2IdtEdVBNHDCeJxGYRwE/fe6d3i4HygCRb00eP0+idd+ohOMcIL6WjNpL++dFi1IGKG9ojBMbi2F7m2EkfDW6+v/L4f+8HNLsXUKIMw+mlqOQ7ECWR3cpkJXk8tnrPHWK/ocIIFHMai8aqqkGND5Mvo1cz7MjLve6ortxywq5xctF0zKoEU71wv3XW167c0MON5B8D/GWveQGvpiQ+PiS7StWk3NdqGJjlwGM+nhQv991Iot3TnENq
Received-SPF: pass client-ip=57.103.69.98;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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

For VM save/restore in nested virt scenarios, to be triaged later.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8d537b6201..4f3c322776 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -653,7 +653,12 @@ int hvf_arch_get_registers(CPUState *cpu)
 
         arm_cpu->cpreg_values[i] = val;
     }
-    assert(write_list_to_cpustate(arm_cpu));
+
+    /* Don't make this fatal for now. */
+    if (write_list_to_cpustate(arm_cpu)) {
+        warn_report("hvf_arch_get_registers: not all registers are matching");
+    }
+
 
     aarch64_restore_sp(env, arm_current_el(env));
 
-- 
2.50.1 (Apple Git-155)


