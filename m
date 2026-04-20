Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800B1F5580B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEm6O-00077o-0d; Mon, 20 Apr 2026 06:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6M-00076E-CQ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:43:38 -0400
Received: from p-west3-cluster5-host8-snip4-8.eps.apple.com ([57.103.72.21]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm6K-0000cj-Tr
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:43:38 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPS id
 2517E1800475; Mon, 20 Apr 2026 10:43:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776681815; x=1779273815;
 bh=4624USsR0p7NklevhZpyiOMKAkWt2GrauvKzkoCskVE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JBz6ZtwebDTWn1xVfEGEcZ0hNkLBAd/m7ahsmQ+sD6CsAQPjJUf5x2SCeum8+/CCGBgDVayWXoaAJNUdGWxkuaPUjiGtFsPRbieIEtFUQePpb/jL6O5iJatXd+mqYb6Obr3/DsPSGwwJ+zWuLvu/mQsQezARBcbQDbpWG+gF6yEyI5wgMa18MXzhIF2BCjOCvrsR3l/KDrkLxy1pe28bCC6cujNam/6ZOJtjPg8ZDmWRBstkZwXceAG9pbNZtjvRjoDl1jVdIphJ+kqM85MsgkEcmjl3fq1yk9v3wO57LvvSFYfF59LckwULBw0A0glw9x2woQNKfiIvZZSlxBmeSw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPSA id
 564A518000BF; Mon, 20 Apr 2026 10:43:31 +0000 (UTC)
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
Subject: [PATCH v2 16/38] whpx: i386: set apicbase value only on success
Date: Mon, 20 Apr 2026 12:42:26 +0200
Message-ID: <20260420104248.86702-17-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260420104248.86702-1-mohamed@unpredictable.fr>
References: <20260420104248.86702-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwNCBTYWx0ZWRfX6neWATxSasTX
 sM0vWdIYo0ObuPKOGHYQor4CQxyZ4fXLnGz1i+3kcdnwwsgpH12+vmoMXQxt5NAnzicG94BN4+B
 pYPMBZZq4XVSd8K3mAZ05ibfgv9FekjRDDxx1Jp6lF7ZNvVtfzRSB5zXkoQutVzXv1Ofjk3KaMw
 ojxTxxMKVgLS6d3PEeVsmlK9Hf7A9SHPEfUFa4mv/gxmh2GxG4wfVf8hP8vbXVT819/TqPUUvbn
 r40PcyA+9oRoLiXFOul8dhIl0tkztn1Yw8eAqjNyaogv7UtfkSUiLa0AfCjVNhO0KaEB3J1YKWc
 a3gkN1znnoxdU5p9aAq2kyKAVpVtTvRF5wVwwBF9EEw22K0k+zcfn3YxjkV/D0=
X-Proofpoint-GUID: qmSC2HbiSG6G-dnwftkoqlY5O-ThVt1D
X-Authority-Info-Out: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69e60357
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=uh2sygq7LFHjsVUyvz4A:9
X-Proofpoint-ORIG-GUID: qmSC2HbiSG6G-dnwftkoqlY5O-ThVt1D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=676 clxscore=1030 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604200104
Received-SPF: pass client-ip=57.103.72.21;
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index c6f4041515..0d72e93621 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2001,8 +2001,9 @@ int whpx_vcpu_run(CPUState *cpu)
                     int msr_ret = cpu_set_apic_base(X86_CPU(cpu)->apic_state, val);
                     if (msr_ret < 0) {
                         x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                    } else {
+                        whpx_set_reg(cpu, WHvX64RegisterApicBase, reg);
                     }
-                    whpx_set_reg(cpu, WHvX64RegisterApicBase, reg);
                 }
             }
 
-- 
2.50.1 (Apple Git-155)


