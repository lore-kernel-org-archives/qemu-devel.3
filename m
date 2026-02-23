Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB43E98E06
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRU1-0002HU-9q; Mon, 23 Feb 2026 03:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSj-0000zc-Ja
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:43 -0500
Received: from p-east2-cluster3-host2-snip4-2.eps.apple.com ([57.103.77.223]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSi-0002Kx-6N
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:41 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 35A68180022E; Mon, 23 Feb 2026 08:38:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835919; x=1774427919;
 bh=hfNR82VI32cF33QTS3FopfW+BPdUa6X/9gAEMrrkmf4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=RbsBx57NhlF1VMDANvoW93uf1ad+M2QrowptYXf7fPz2wZo/XHjtEUNHx1KY5izyvbCNmhrqctBnb51f+d7ogIFHLD2IvwnqUZyXtoIZ0TBU5TZneVT6tQ1ySFGw4/h+6REFU5ktkOW1mgaOKFbU+Qx/CAu428/0fIq4jzuXVj0z7BJ37FD0SU+QUwqhtuRcWUI7qQqzOQ49yQWnSxmd5W7RU8xb/ojmCD6NPuvPlveBXlNWFdmYg5f5x5NQ2QeLrpVI5Fyce9lHukibaEi1qUR5cnVYzDHUEsRW485PLYRKT0aNWwM28cfY0gAAhBOvNTXTFuvuS8DQ6TVsrE5RsQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 E2C1F180020F; Mon, 23 Feb 2026 08:38:36 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 25/27] whpx: i386: inject exceptions
Date: Mon, 23 Feb 2026 09:37:31 +0100
Message-ID: <20260223083734.48533-26-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Oa2VzxTY c=1 sm=1 tr=0 ts=699c120f
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=41a--giXCHF2Chj7mBYA:9
X-Proofpoint-ORIG-GUID: 5coSjpzfVgGBt7uM4Odq5S6-EyRCpJg2
X-Proofpoint-GUID: 5coSjpzfVgGBt7uM4Odq5S6-EyRCpJg2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfXwXbCYBfcwm9o
 TJZAIu7o3Tg1oh/5lwNzLwSLSim78zDlseUM7TZOtmRKKsO0YNbDEPCRW7jk0PEc0HNLvQDwXCe
 NtzfKoLMTfSJfDyTyQlAt82J+HI9ZIz4bm0QdlyazMOrgZbyVj3Iqun2Y08sHaWzmzpqSuXveDi
 kv4uGzaE1dq+UrTiRowD0zyDwNHPLrsDYv/olW8qVLOore5J0r/q0f2CpE74N1CYDUedRrZm18D
 dp8DkDNvuAbeyrRXLswpaHVg1raNA3piPAKZEthi96Yf1+NUFplvxtAy1ndOiCtijKh+eqRp/xC
 Wwj3UpNTioPt2XKH747+3D5bZkAD4cLjNNQ0hh1tv6iJaeq8STjq/a1sa5F2Vs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1030
 mlxlogscore=994 spamscore=0 mlxscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAABIitEgpudpvkyAlF4bZqpvR56Ew6qniLQmuNGrzZb0cdBU4usMENdAit3Fk0YYY9rNXId7rkcbYESJO6U2lCsz7sbgQbpK3Ij7W4X8m4GFuREWJw/hLvDhgz6jJyjQXSwaOKYYOBuL/nizFr74w1x4J0BPhTgzaMLfpt7uH70E2IYjKPgw2TWvE1LaurlIBHOrPJdSZm5fWKYDaSR5iNjRICE+owJfwl2DXKSA2fOblmvN9F40H1wcVf6UIxE2xmz8CJU4p0C8MtiNJ7lHi6dlEuBmmjFs42kl0Dww+NI+IPp/ajvo9s5fhFOlv1OiTBnDBMrhF67gfPf3NcTaStTSpW+N2MeM9wGJD0hDC8UBUGzCBRe2Atjc4Xf1aC2Afulbk6bLNdjlc+mIxazK2fTxZXoJjksuzRKBwR5TS6S9fnup2OIm5dI1a83rMY6p8kq+cI50ACP0sDPv9G3CJtM0T7VEstbX3SA4SphspD6AQ+jUbUS5KI7ZBitVixW1LSlkTgqa4Q1mZRn2kx2pm4qh98LF4Dkc7LyDYf6fbvElfYDDyjzHfvbkh1YaT7Nk7J8aAhR8eX1/r0Uf6sXQITTjRl35vySvLKrfdI+zeOGtQWAVdTH8oCg06mVUje1j8OVdhj4wEUcOgPjGH6v1UMHYrw7ozf6VuzENWK7S0RbpjdTwT7HYxGZf1cHVkxX+dVdn15VNyzWM8ybfZjIR8TTGo6LtDl8a2TgFjmxPhFRuO/1l1iBS2TQCcKwVfhxEj+mkMmQe0Gmnr/kwuMkuc7IgjY=
Received-SPF: pass client-ip=57.103.77.223;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 target/i386/whpx/whpx-all.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 561a48206c..0259782a82 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1506,6 +1506,26 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     }
 }
 
+static void whpx_inject_exceptions(CPUState* cpu)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    if (env->exception_injected) {
+        env->exception_injected = 0;
+        WHV_REGISTER_VALUE reg = {};
+        reg.ExceptionEvent.EventPending = 1;
+        reg.ExceptionEvent.EventType = WHvX64PendingEventException;
+        reg.ExceptionEvent.DeliverErrorCode = 1;
+        reg.ExceptionEvent.Vector = env->exception_nr;
+        reg.ExceptionEvent.ErrorCode = env->error_code;
+        if (env->exception_nr == EXCP0E_PAGE) {
+            reg.ExceptionEvent.ExceptionParameter = env->cr[2];
+        }
+        whpx_set_reg(cpu, WHvRegisterPendingEvent, reg);
+    }
+}
+
 int whpx_vcpu_run(CPUState *cpu)
 {
     HRESULT hr;
@@ -1600,6 +1620,8 @@ int whpx_vcpu_run(CPUState *cpu)
             whpx_vcpu_configure_single_stepping(cpu, true, NULL);
         }
 
+        whpx_inject_exceptions(cpu);
+
         hr = whp_dispatch.WHvRunVirtualProcessor(
             whpx->partition, cpu->cpu_index,
             &vcpu->exit_ctx, sizeof(vcpu->exit_ctx));
-- 
2.50.1 (Apple Git-155)


