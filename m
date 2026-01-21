Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB6EC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYTr-0005i8-RZ; Wed, 21 Jan 2026 08:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYTE-00050l-PW
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:42:06 -0500
Received: from qs-2001l-snip4-7.eps.apple.com ([57.103.87.120]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYTD-0001IM-8l
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:42:04 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPS id
 B5EF5180009A; Wed, 21 Jan 2026 13:41:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769002922; x=1771594922;
 bh=HZFE5wKi/P+B2jYZ3RcbjRGS58KxloRLD04g+NruaBU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=c9z3TunsqH7Ez5PdhcavRE2gjgVhdEd5yCCL3oUEiAzPw3XxUL1c55P5gxrkmXQ5EFSNFp9U1j/D8FVnoosauHb/qbpO+93VAM0Vh1w0D9vZknFhUhillcCx1VBk6wECdmx7jSc5YSM2rAgJHtZniBQ3vmzNvyksAzp/7Nyc4GIk6XSY/26d5LLtXHvoQXuwWOlV6mHGCVNM7FUgTa8uvLE40UKH64y211oGNM0OVgl9j5Ei/QFK2ZJvSo77Q7gJBxKDJNvVs2KWor8sTLTcID19bUuTt6dwtZ/VriDV0L80vipC9lKOxfAI+DJKA4Na74lGN3n2yMqB52z1SewyOA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-14 (Postfix) with ESMTPSA id
 907B318001BA; Wed, 21 Jan 2026 13:41:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Ani Sinha <anisinha@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v17 14/21] target/arm: cpu: mark WHPX as supporting PSCI 1.3
Date: Wed, 21 Jan 2026 14:41:05 +0100
Message-ID: <20260121134114.9781-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121134114.9781-1-mohamed@unpredictable.fr>
References: <20260121134114.9781-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExNSBTYWx0ZWRfX/SHz/wEri24h
 +XMTIUZS44M6UWvc66b9JjP8s3GJZkMuqrFBxpLIBhxMxImMxqWhj6kcPJBKvc2f90SnZz1sdWD
 fw7W1wPY82EYlbZvPZ/2dB3t3cpW3oYfx+qyY0AERtZ7bofxmfDhTTKL8k9gA9IYnen1j1TRzQf
 57GTlwh9m0LBbCKbq4weMk3AqDYETWUYPBhm0vcYTqolOUXeYe5RZ65eRiaC6Cm9i+1KuEbLJcW
 oharkQ+YEFcv5iGTLctkdsTmzYo4vXV+PRdVIBY5w6AymszIXZRAUrlHriqWyDZp+Xm1UBu7xyd
 5HNo6T/1zQsOfal7JoN
X-Authority-Info-Out: v=2.4 cv=Du1bOW/+ c=1 sm=1 tr=0 ts=6970d7a8
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=emIkxkYSJqCgyAM8kcYA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: zWVaTRwP8MgxpFEkgRxqJOj55X4DutZM
X-Proofpoint-GUID: zWVaTRwP8MgxpFEkgRxqJOj55X4DutZM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1030
 mlxlogscore=999 phishscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601210115
X-JNJ: AAAAAAABNoBcZBvj8WeOQ91UcFaTWT8tmaIPx7/2l1iKgWb6H9z21AjXEA5O+SGDNIYWvmoWsWxZweoIqy2fNnut0awSfTMhVL+7gAe/irWi85euJijfzAFyGla1cGFtiPulXe0kbhp8pcFJPk/YLNMUEdQQfOJx+NDIYEF/Xu4ISEFraySIuS10UvfkW0Lgj4TXhWa1w7LKlw/c71XSXBHqZcprf8X52oxZ9qvsJpJchGXLtWah6Ykwv+KGSZMo2FdruB20Qgi5ZiF50f19gOSk3TcxwHMmIxrlHwQKgYjKPnNvmqpygnhoctcwHhEHIiOOezZPQOC7L5T2wfnZuw4So8CclCdmlBVcntH9hRhYb/UNZmrLn+x2STNHwhgv6KrIUGDzeXk2lFGqNkGzFNgdvWVRkI/cLtZo055bSyLkgLLR+rsrQWdYVry4tCO89yK6KJN+BqqpkXod/VjBH9WyPDRugblxRw2kqifkN5P52E8nXVIPVrMacLXxMAcI4YBlbUqFy5/6VfX7aTn6PTt7fMX+D1joFwuDmhlG4xe8meVzPuUESLVFd9KOX+XDF5m8a5cZeRVyLViUv4nNbje471KGhjOexeLNyAEmoUDSoxrtrTpfxAFbTI1d6xFyPy9I8OAGL6gBMixoFDxiVVQ+f2hZ2F6fOGW1tA1uODosbwYWKMD3MJ57a4bbCXxWrYb03YueSDoURHso4E9KJN0mMIIc5BXyvmuvmHrvyA0uWS0Uv8ENkk7OcxV8W8y0b1+/bhnzGk+GvywRPVt1FjcGAtg4bCUoEMFBo3S3422GH5AXKqIb76qoH2N5CIT4dGWz9eas1wubdYcGzDlQ348ff0SJ6EjEmjzTHEgxFy1Aga4/acGRoaoHCwSVBhBQmXc865fLu/iOGn8oxaK1kwEUE4iEx1i2QBE/spbVpXG5UA0=
Received-SPF: pass client-ip=57.103.87.120;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hyper-V supports PSCI 1.3, and that implementation is exposed through
WHPX.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 target/arm/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 05fa3339b1..fd1e3197ad 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/page-vary.h"
+#include "system/whpx.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -1143,6 +1144,8 @@ static void arm_cpu_initfn(Object *obj)
     if (tcg_enabled() || hvf_enabled()) {
         /* TCG and HVF implement PSCI 1.1 */
         cpu->psci_version = QEMU_PSCI_VERSION_1_1;
+    } else if (whpx_enabled()) {
+        cpu->psci_version = QEMU_PSCI_VERSION_1_3;
     }
 }
 
-- 
2.50.1 (Apple Git-155)


