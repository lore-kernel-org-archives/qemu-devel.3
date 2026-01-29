Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA8BD73E84
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXaR-0007qa-HX; Thu, 29 Jan 2026 14:21:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZY-0006Pr-4n
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:20:58 -0500
Received: from ci-2007a-snip4-1.eps.apple.com ([57.103.88.4]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZW-00062U-Go
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:20:55 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPS id
 01387180200A; Thu, 29 Jan 2026 19:20:49 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769714453; x=1772306453;
 bh=c9xkU5JKUppgK3M6NvIGvHRbHv9MZvro5B1lYG+DJ2Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=CgWg+BVYgQ1IQtr8NzGH3oNeUNDBIIHBNK20yU6TejwWvT2NZ+MvjBYCPvGs6CZsZAiInZKpy7gtLvDQsX1yock8mo7FMk800Q5MLbG0poftBrKD5uvHSAtY9Neq0hSo+f/Ly7y637gYe5qz7GkemPVE67xcc4/9MKhXq7It6w2jSa75YcdG7PF15ywJ0KZbCTRnLlRDDGDfaGbLvaZ/a0pItkXx+HKwZAVPOtV7GIMBySLmer+VM29CPDX2xYAzyMbZW3Wpl49GnWkFrY8B986Q81y+GJQK+2LY3QVmaqiNvqlkaGKOt9XpzMAb7fqRnHRmuxU3Qmz+SolJw9/SvA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPSA id
 664ED1801881; Thu, 29 Jan 2026 19:20:46 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v19 11/22] whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
Date: Thu, 29 Jan 2026 20:19:56 +0100
Message-ID: <20260129192009.14707-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260129192009.14707-1-mohamed@unpredictable.fr>
References: <20260129192009.14707-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzOCBTYWx0ZWRfX6C7zssQQEtiE
 uFRXC2xZ+q0O+x+udMRkzGnVdNWloDhyIr4hlWxXxj4DBM9vjElkKxLrANy8edfI+NLxbFwaodh
 R4ybkq/meMebVrnxyubsOZwSKzOBkp/kD94mrssiRGHQYuiYJSLmFrRJ06TbGGKyALP7uS4heRa
 uqfyMdci0oXznmEM3Xm+N0pdFeqFFHa5DZWG3RYVcLIdGivBBim9yS2/IYSfoQxAYPwNR8Lhunf
 Axl7DUxxnBEl0Flr3o+lRn3eVn3SAZI9oiI/AvaBXlJjjEEMjzxLm2PEdLlRssModm4wrWHvsfs
 +kxhLlDW6vM0SIjSRAaBONcIYBcr78/s2zs0v/kB1EP2b1aDHna73pxMVaa850=
X-Proofpoint-GUID: OC7cEoxkkhtJxuEcY4a36ji_Jh-Wc4Bz
X-Authority-Info-Out: v=2.4 cv=b8C/I9Gx c=1 sm=1 tr=0 ts=697bb314
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=2psWIPzlEfUqwKpUe20A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: OC7cEoxkkhtJxuEcY4a36ji_Jh-Wc4Bz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 clxscore=1030 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290138
X-JNJ: AAAAAAABOw5qF8MTJM6og/JZQGG9d55j7KuILCOX039bZJwR/udyeauMR82gWHwHr9krcprCyUs0lGM0mfJTZn6bzKueOXeQML8pKZglpfNG6tuyuMS/xxojH7RDnDbukxCeaktwqlhGv7u0Q5JlMZiRFSCKVJHMyKq3jSE4E4re655dcWJyg3B05mgHvWQ+A+5vYSb/6wkq0HaraU0afYGN6OnK1ZDL56KVThfXFjZSDHfepvEdtCsk4+pGV7vTqB+J8Si3aAco8c1JVLgcjPe4K8BHBGqjav9fv6UfpaFrbtMmztBCdJ7P5TkpPV5AQH7xqjq2qBEIkIPtyf7g8DRwtRnhpQwNZADBRZlhJyOCIIy2DS/Ysx4vlSCcSaEhmS3gOf904TxhheZjfSpr5TeKHtHPyYdiO1+sDDkiCr7ccK3N/njjkbla6lkTNng+r8j5uGuOgWn9uNBav0cSzlQWeltPt4SgmVBrhV+4/5JlN/lsiR78Ul/kV56KWCtLmNbzWZWJ40v6AY1g+IuftObXm4+lkAqxTMJaLnNoVvHumyP8q2RIanWl9z/f4g1o3QHJUHj0TTeq9DiCkMise2WBiZ/V+4ZB7okFrtCo/uEyZhxg9GEcrxmgYUmoSJbszEB08pJKZJhO6rYe/w0u3ladqxxO248T+tOT9Jxzx90HRdh2RdqCoYCS58ER9sW18Y1s6sAPHTAJWz0nNyJRm2cpPYhgOoWoY6wXXgEB0cMyXEGFDfVT6cZXZcP3AsRQ7W9ry90lCGn5PWE3MQxivs9akyI7NC9pdbSvN/gvVnyT7jlkE6V+LTz934zLYM/7gTobwZKp+pN1mNHhp1DVsBwEBdJ7aLLJ4Fvp8lI1si02SwoTOErCP0E/qZaF
Received-SPF: pass client-ip=57.103.88.4;
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

As of why: WHPX on arm64 doesn't have debug trap support as of today.

Keep the exception bitmap interface for now - despite that being entirely unavailable on arm64 too.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 accel/whpx/whpx-common.c     | 2 +-
 include/system/whpx-common.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index c58344cb61..c0610815d9 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -119,7 +119,7 @@ int whpx_first_vcpu_starting(CPUState *cpu)
          * have one or more breakpoints enabled. Both require intercepting
          * the WHvX64ExceptionTypeBreakpointTrap exception.
          */
-        exception_mask = 1UL << WHvX64ExceptionTypeDebugTrapOrFault;
+        exception_mask = 1UL << WHPX_INTERCEPT_DEBUG_TRAPS;
     } else {
         /* Let the guest handle all exceptions. */
         exception_mask = 0;
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index 8f171d1397..b86fe9db6e 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -20,4 +20,7 @@ int whpx_first_vcpu_starting(CPUState *cpu);
 int whpx_last_vcpu_stopping(CPUState *cpu);
 void whpx_memory_init(void);
 struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address);
+
+/* On x64: same as WHvX64ExceptionTypeDebugTrapOrFault */
+#define WHPX_INTERCEPT_DEBUG_TRAPS 1
 #endif
-- 
2.50.1 (Apple Git-155)


