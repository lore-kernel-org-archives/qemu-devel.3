Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CE4F99C98
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEFD-0007Cc-CK; Sat, 18 Apr 2026 18:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEF2-0006T5-BG
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:23 -0400
Received: from p-east2-cluster1-host12-snip4-10.eps.apple.com ([57.103.76.63]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEF0-00051L-RU
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:20 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 4B0DC180022B; Sat, 18 Apr 2026 22:34:13 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551656; x=1779143656;
 bh=3N10hCGUapdzhuKA3NU8ZhsH65avZvazfJzRL/H4ESk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=cW1u5ByomZrVbmMDeUkIBa533lMoIiv8vBNnJf/GsU6y1WjF9tnQmmN/aCH9CvJkIZO4HPLxg5uq9Z16YtwqaAQNiRD8/v1cX7KRudkNEFokGBG3J411i117sVQ16vIeQy00hMeBnqXWQPAl/Bx0ToP8IInq+1Q9oBxtwW69tIyXWJbhPmHRaT0tkEw+DC5Mke3xm2Gqm64NK1ngtVE82zqvpQUDIeb5tkcSD/Dwr4xc2pYnCBVXRT3NkbmeR754MP5ELVLn166aB8vLodpwhT+vakG0/pApivuNBl7YK0TpS+kq1CK7T+usSGIBn5il4lFzHaXr0LyMN3Oq88PmlA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 D28F318000B4; Sat, 18 Apr 2026 22:34:10 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 26/38] whpx: i386: Pause VM on fatal exception to be able to
 inspect state
Date: Sun, 19 Apr 2026 00:33:08 +0200
Message-ID: <20260418223320.51330-27-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: U9qEgvgQVm2v8uWLVRJn1DCGcJoHcmAy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOCBTYWx0ZWRfX8hFRQiqC6K5m
 S/aE7G+3Iu+Qgb9W+VB5XciG7NkyjNbJVp8F2AFfTUp/5wOvwIEag3aUq1PDFsKaMibj6UuUs17
 JFbeWOAwbZ8n9IOf9xmREXmpwN+ABucWO90Ooljvuu2Dg58wtsiD6J6qptpdt3VGRh48/fIaGuk
 VPBi5YR/weHbsJA2yhlcj9Teo3OLTwU4/2cNoV8AQFLSq9HSrgYBFS6JkWfJ/w6oGYCIIw4LgmF
 NoELQgNyGIPrsM0GjhSdGIJrtKR3bNJwEQi3DUNhPxucSIPO94IwXnW3tmQuQV3O0jmVNJAKwGh
 siDwy/jk7YAkbCkCMSr8UIvQyGwTTwc62Mlfgrs9J1Bbs3b4Rt/mF6jrBE3yws=
X-Proofpoint-GUID: U9qEgvgQVm2v8uWLVRJn1DCGcJoHcmAy
X-Authority-Info-Out: v=2.4 cv=W9M1lBWk c=1 sm=1 tr=0 ts=69e406e6
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CGn8axfqn9I_s65QuTEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxlogscore=795 lowpriorityscore=0 clxscore=1030 adultscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604180228
Received-SPF: pass client-ip=57.103.76.63;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index a7282eb96a..dee2a203b2 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2310,7 +2310,7 @@ int whpx_vcpu_run(CPUState *cpu)
                          vcpu->exit_ctx.ExitReason);
             whpx_get_registers(cpu, WHPX_LEVEL_FULL_STATE);
             bql_lock();
-            qemu_system_guest_panicked(cpu_get_crash_info(cpu));
+            vm_stop(RUN_STATE_PAUSED);
             bql_unlock();
             break;
         }
-- 
2.50.1 (Apple Git-155)


